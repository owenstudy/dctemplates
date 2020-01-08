#!/usr/bin/env python3
# -*- coding: utf-8 -*-

# @Time    : 9/3/2019 10:11 AM
# @Author  : Owen_study
# @Email   : owen_study@126.com
# @File    : dcbaseline_config_load.py
# @Software: PyCharm Community Edition
# ===============================================
'''
从配置excel加载DC Baseline所需要的所有配置表，生成insert SQL语句，以方便后续的ODI处理操作
主要是传入excel配置名称，然后读取所有的sheet，除了第一个，具体的配置表则以sheetName为主,如果需要修改则需要单独加一个sheet和表名的映射关系
'''
import pandas as pd
import os,re
from app import configure, public_init_script, common
class DCBaselineConfig(object):
    # 初始传入配置的文件名称，默认放在Upload目录下面
    def __init__(self, config_file_name):
        self.__config_file_name=os.path.join(configure.UPLOADS_FOLDER,config_file_name)
        # sheet name和对应表名的映射，默认为和sheetname相同
        self.__table_name_map = {}
        # sheet中第一行的列名和表字段名的对照关系，默认为和列名相同
        self.__column_name_map = {}
        # 加载excel 数据到pandas中
        self.__config_excel_sheet_list = pd.ExcelFile(self.__config_file_name)

    # 获取sheetname和表名的映射关系
    def __get_table_name_map(self):
        # 获取所有的sheet name
        all_sheet_names = self.__config_excel_sheet_list.sheet_names
        # 默认tablename=sheet name 并且排除掉第一个Cover sheet
        for sheet_name in all_sheet_names[1:]:
            self.__table_name_map[sheet_name]=sheet_name
            # 如果有不同的，需要在此进行映射处理 TODO
        return self.__table_name_map

    # 获取各个sheet中列名和表中的列名映射
    def __get_column_map(self):
        # 获取所有的sheet name并保存到变更中
        all_sheets = self.__get_table_name_map()
        all_sheet_column = {}
        each_sheet_column ={}
        # 每个sheet 按字典方式保存起来以方便后面的调用
        for sheet_name in all_sheets:
            sheet_columns = self.__config_excel_sheet_list.parse(sheet_name).columns
            # 初始化每个表的列
            each_sheet_column ={}
            for each_column in sheet_columns:
                each_sheet_column[each_column] = each_column
                # 如果有异常映射，则需要在这里额外处理 TODO
            all_sheet_column[sheet_name] = each_sheet_column
        return all_sheet_column
    # 生成insert语句的格式化语句
    def __get_table_insert_sql_template(self, sheet_name):
        all_table_columns = self.__get_column_map()
        # insert_sql = 'insert into {table_name} ({column_name}) select xxx from dual;\n'
        # 后面的值在每行记录进行处理
        insert_sql = 'insert into {table_name} ({column_name}) '
        column_name_list = ''
        # 获取映射后的表名
        table_name = self.__table_name_map[sheet_name]
        # 对每个列进行处理
        table_clumns = all_table_columns[sheet_name]
        for each_column in table_clumns:
            # 获取映射后的列名
            column_name = table_clumns[each_column]
            column_name_list = column_name_list+column_name+','
        # 去掉最后的 , 符号
        column_name_list = column_name_list[:len(column_name_list)-1]
        insert_sql = insert_sql.format(table_name=table_name,column_name=column_name_list)
        return insert_sql
    # 给每个列都加上单引号并做SQL的换行处理
    def __get_col_values(self,col_value):
        if type(col_value)==type('str'):
            return "'"+self.__sql_adjust(str(col_value))+"',"
        elif pd.isna(col_value):
            return "null,"
        else:
            return self.__sql_adjust(str(col_value)) + ","
    # 处理sql语句中的特殊字符
    # 对SQL注释中的--进行处理，以防止换行符替换后注释扩大，把--替换成/* xxx */的形式, 2019.7.13
    def __replace_remark(self,matched):
        newremark = '/* '+ matched.group() + ' */'
        return newremark
    # 处理sql语句中的特殊字符
    def __sql_adjust(self, sql):
        # 如果sql中有'则做'的处理
        if type(sql)==type('str'):
            newsql = sql.replace("'","''")
            # 替换SQL中的--注释,替换成/* */
            newsql = re.sub(r'--(.*)',self.__replace_remark,newsql)
            #处理excel中有换行的情况，替换成空格
            newsql = newsql.replace("\n"," ").replace('\r',' ')
            # 对于超长的字符串进行换行
            final_sql = ''
            for s in newsql.split(','):
                if len(final_sql+s)>=1000:
                    final_sql = final_sql +'\n' + s+','
                else:
                    final_sql = final_sql + s + ','
            # 移除最后一个,
            final_sql = final_sql[:len(final_sql)-1]
            # 截取长度超过4000的字符
            final_sql = final_sql[:3999]
        else:
            final_sql=sql
        return final_sql

    # 处理各个sheet的insert语句
    def gen_table_insert_sql(self,sheet_name):
        # 获取sheet的数据
        pd_sheet = self.__config_excel_sheet_list.parse(sheet_name)
        all_insert_sql = ''
        # 循环处理每行的数据并生成sql的值
        # 对sheet中每行进行处理
        for index, eachrow in pd_sheet.iterrows():
            # 循环处理每个列
            each_row_values = ''
            each_values_sql = 'select {col_values} from dual;\n'
            # 获取所有表的列名
            all_table_columns = self.__get_column_map()
            # 获取当前sheet的列名
            sheet_columns = all_table_columns[sheet_name]
            for  eachcol in sheet_columns:
                col_value = eachrow[eachcol]
                each_row_values = each_row_values +self.__get_col_values(col_value)
            # 去除最后一个","
            each_row_values = each_row_values[0:len(each_row_values)-1]
            # 组合成insert 语句
            each_insert_sql = self.__get_table_insert_sql_template(sheet_name)+ each_values_sql.format(col_values=each_row_values)
            all_insert_sql = all_insert_sql + each_insert_sql
        return all_insert_sql
    # 保存数据到文件中
    def __save_script_file(self, filename, insert_sql):
        sql_file_handler = open(os.path.join(configure.DOWNLOAD_FOLDER,filename),'w',encoding='utf-8')
        sql_file_handler.write("spool {0}.log\n".format(filename.split('.')[0]))
        sql_file_handler.write(insert_sql)
        sql_file_handler.write("\n commit;")
        sql_file_handler.write("\nspool off")
        # sql_file_handler.write("\nquit; ")
        sql_file_handler.close()
    # 生成所有的sheet的语句并保存到文件中
    def gen_all_insert_sqls(self):
        all_sheet_names = self.__config_excel_sheet_list.sheet_names
        file_name_list = ''
        # dcbase line table create script
        create_table_script = self.gen_create_table_sql()
        self.__save_script_file('DCBaseline_create_table' + '.sql', create_table_script)
        file_name_list = file_name_list + 'DCBaseline_create_table' + '.sql' + ','

        # 对于每一个sheet都生成列表
        for each_sheet in self.__get_table_name_map():
            each_sheet_sql = self.gen_table_insert_sql(each_sheet)
            self.__save_script_file(each_sheet+'.sql',each_sheet_sql)
            # 生成所有脚本的文件列表
            file_name_list = file_name_list+  each_sheet+'.sql' +','

        # 返回文件列表，去除最后的逗号,
        file_name_list = file_name_list[0:len(file_name_list)-1]
        return file_name_list
        pass

    # 保存生成的语句到文件中
    def save_all_sqls(self):
        file_name_list = self.gen_all_insert_sqls()
        script_file=open(os.path.join(configure.DOWNLOAD_FOLDER,'run_for_all.sql'),'w')
        # 多个批处理文件一次性执行
        for file_name in file_name_list.split(','):
            script_file.write('@@'+ file_name+'\n')
        script_file.write("\n commit; ")
        script_file.write("\n quit; ")
        script_file.close()
        pass
    # 生成创建表的脚本，这部分脚本目前是手工维护，需要和excel中字段关联
    def gen_create_table_sql(self):
        create_table_sql = ''
        # Validation table
        create_table_sql = create_table_sql + public_init_script.init_dc_validation
        # Reconciliation report create table
        create_table_sql = create_table_sql + public_init_script.init_dc_reconciliation
        # DC step check table
        create_table_sql = create_table_sql + public_init_script.init_dc_dc_step_check
        # dc_mapping_for_dc_fields create table
        create_table_sql = create_table_sql + public_init_script.init_dc_mapping_for_dc_fields
        # source total control table
        create_table_sql = create_table_sql + public_init_script.init_dc_source_total_control
        # product mapping table
        create_table_sql = create_table_sql + public_init_script.init_dc_product_mapping

        return  create_table_sql
        pass
    # 生成一个加载template的特殊过程，替换原来的写法，提高性能 2019.9.6
    def get_mapping_cols(self):
        #所有的列名
        column_title_name = configure.template_column_title_name
        # column_title_name=('tableName','columnName','dataType','length','nullable','primaryKey','descShort','descDM','defaultValue','referTable')
        # 保存所有的行数据
        mapping_rows=[]
        all_table_columns = self.__get_column_map()
        # 获取template列所在的sheet index
        sheet_name = 'MappingColumns'
        # 获取sheet的数据
        pd_sheet = self.__config_excel_sheet_list.parse(sheet_name)
        # 对sheet中每行进行处理
        for index, eachrow in pd_sheet.iterrows():
            # 循环所有 的列
            each_row_values = {}
            # 获取所有表的列名
            # all_table_columns = self.__get_column_map()
            # 获取当前sheet的列名
            # sheet_columns = all_table_columns[sheet_name]
            column_index = 0
            sheet_columns = self.__config_excel_sheet_list.parse(sheet_name).columns
            # 初始化每个表的列值
            each_sheet_column = {}
            for  eachcol in sheet_columns:
                if eachcol == 'Nullable' and pd.isna(eachrow[eachcol]):
                    # pandas处理NULL这个字符串有问题，会加载不进来，在这里特殊进行处理 2019.9.10
                    col_value = 'NULL'
                else:
                    col_value = self.__sql_adjust(eachrow[eachcol])
                    # 部分中文的处理还有些问题，生成的INSERT语句有报错，需要后续处理 ，已经搞定，通过生成utf-8格式的脚本文件来解决
                    # col_value = bytes(col_value,encoding='utf-8').decode()
                # 处理空值
                if pd.isna(col_value):
                    col_value = ''
                elif type(col_value)!=type('str'):
                    col_value = str(col_value)
                # 使用固定列名，按dict格式保存值
                each_row_values[column_title_name[column_index]]=col_value
                column_index = column_index + 1
                # 只处理前10列的数据，后面的列忽略
                if column_index>len(column_title_name)-1:
                    break
            if len(each_row_values)>0:
                # 去除文件名的路径信息
                module_name = os.path.split(self.__config_file_name)[1]
                each_row_values['moduleName']=module_name
                cellobj=common.JSONObject(each_row_values)
                mapping_rows.append(cellobj)
        return mapping_rows

if __name__ == '__main__':
    # dc_config = DCBaselineConfig('XXX_DC_configuration_tables.xlsx')
    dc_config = DCBaselineConfig('DLA_Mapping_POLICY_V0.1.xlsx')
    # all_table_name = dc_config.__get_column_map()
    # print(all_table_name)
    # insert_sql_template = dc_config.gen_table_insert_sql('dc_step_check')
    # print(insert_sql_template)
    # all_insert_sql = dc_config.gen_table_insert_sql('dc_step_check')
    # print(all_insert_sql)
    # all_sheet_sql = dc_config.gen_all_insert_sqls()
    # dc_config.save_all_sqls()
    # print(all_sheet_sql)
    dc_config.get_mapping_cols()
    pass