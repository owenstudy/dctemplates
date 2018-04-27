#!/usr/bin/env python3
# -*- coding: utf-8 -*-

__author__ = 'Owen_Study/owen_study@126.com'

import re,os, shutil
from  app import template, configure

''' 传入mapping column list列表'''
class TemplateScript(object):
    def __init__(self,mapping_file_name):
        mapping_template=template.Template(mapping_file_name)
        self.__mapping_column_list=mapping_template.get_mapping_cols()
        #所有的template 表名
        self.__table_list=self.__get_table_list()
        # 移除掉模块名中的路径信息
        module_name = os.path.split(mapping_file_name)[1]

        self.__module_name = module_name
        #date format
        self.__date_format='yyyy/mm/dd'
        #保存公用的Sql
        self.__insert_result_sql='insert into dm_template_veri (module_name,table_name,column_name,veri_code,veri_result,veri_sql)\n'

    def test(self):
        #self.__get_table_list()
        script=self.__create_template_script()
        print(script)
        script=self.public_function()
        print(script)
        script=self.gen_veri_template_script()
        print(script)


    '''取得所有的表名'''
    def __get_table_list(self):
        table_list=[]
        for row in self.__mapping_column_list:
            if row.tableName:
                # 增加一个表前缀，以就对不同的项目有不同的需求
                table_list.append(row.tableName)
        key_table_list=list(set(table_list))
        return key_table_list
        pass


    '''创建校验数据的结果表'''
    def create_veri_result_table(self):
        create_table_script="""
        drop table dm_template_veri;
        create table dm_template_veri(module_name varchar2(100), table_name varchar2(100),
        column_name varchar2(100),veri_code varchar2(100),veri_result number,veri_sql varchar2(4000));\n
        """
        # 创建报表视图，表一级统计
        create_table_script = create_table_script +\
            """
            create or replace view v_template_pass_rate_bytable as 
            select aa.module_name,aa.table_name,pass_veri_cnt,total_veri_cnt,round(pass_veri_cnt/aa.total_veri_cnt,3) pass_rate from (
            select a.module_name,a.table_name, sum(case when veri_result=0 then 1 else 0 end) pass_veri_cnt,count(*) total_veri_cnt  from dm_template_veri a group by a.module_name, a.table_name
            ) aa;\n
            """
        # 模块级视图
        create_table_script = create_table_script +\
            """
            create or replace view v_template_pass_rate_bymodule as 
            select a.module_name, round(sum(a.pass_veri_cnt)/sum(a.total_veri_cnt),3) pass_rate from v_template_veri_pass_rate a
             group by module_name ;\n 
            """

        return create_table_script
        pass
    '''校验中使用到的公共函数'''
    def public_function(self):
        public_function_script="""
        Create Or Replace Function F_IS_NUMBER (STR_NUMBER Varchar2)
                    Return Number
                Is
                    V_RESULT   Integer;
                    V_NUMBER   Number;
                Begin
                    V_RESULT := 1;
                    V_NUMBER := To_number (STR_NUMBER);
                    V_RESULT := 0;
                    Return (V_RESULT);
                Exception
                    When Others
                    Then
                        V_RESULT := 1;
                        Return (V_RESULT);
                End;\n
                /
        """
        public_function_script=public_function_script+"""
CREATE OR REPLACE Function F_IS_DATE (STR_DATE Varchar2)
                Return Number
            Is
                V_RESULT   Integer;
                V_DATE     Date;
                errornum integer;
            Begin
                V_RESULT := 1;
                errornum := 0;
                --处理11:05:47这种是合法的情况
                if length(STR_DATE)<8 then 
                  v_result :=1;
                  return v_result;
                elsif length(STR_DATE)=8 and instr(str_date,':')>0 then
                  v_result :=1;
                  return v_result;
                end if;
                
                for i in 1..6 loop
                    begin
                        if errornum = 0 then
                          V_DATE := To_date (STR_DATE, 'mm/dd/yyyy');
                          v_result :=0;
                          exit;
                        end if;
                        if errornum = 1 then
                          V_DATE := To_date (STR_DATE, 'yyyy/mm/dd');
                          v_result :=0;
                          exit;
                        end if;
                        if errornum = 2 then
                          V_DATE := To_date (STR_DATE, 'yyyy/mm/dd HH24:MI:ss');
                          v_result :=0;
                          exit;
                        end if;
                        if errornum = 3 then
                          V_DATE := To_date (STR_DATE, 'yyyy/mm/dd HH24:MI:ssss');
                          v_result :=0;
                          exit;
                        end if;
                        if errornum = 4 then
                          V_DATE := To_date (STR_DATE, 'dd/mm/yyyy');
                          v_result :=0;
                          exit;
                        end if;
                        if errornum = 5 then
                          V_DATE := To_date (STR_DATE, 'dd/mm/yyyy HH24:MI:ss');
                          v_result :=0;
                          exit;
                        end if;
                     exception
                       when others then
                           errornum :=errornum+1;
                           V_RESULT := 1;
                     end;
                end loop ;
                Return (V_RESULT);
            Exception
                When Others
                Then
                    V_RESULT := 1;
                    Return (V_RESULT);
            End;\n
            /
        """

        return public_function_script
    '''生成创建template表的脚本'''
    def __create_template_script_datatype(self):
        script=None
        all_table_script=''
        for table_name in self.__table_list:
            newtable_name = configure.create_table_configure.get('table_prefix')+table_name
            script='drop table '+newtable_name+';\n'
            script=script+'create table '+newtable_name +'(\n'
            pk_column_list = ''
            for row in self.__mapping_column_list:
                if row.tableName==table_name:
                    #调整字段的长度，使脚本对齐美观
                    script=script+row.columnName.ljust(30)
                    #为空的长度也都设置为默认300
                    try:
                        # #处理字段长度，如果是纯数字的，如果超过300则用定义的值，否则用默认值，确保有超过300长度的创建表是正确的
                        # data_length=self.__get_data_length(row.length)
                        # if data_length!=None:
                        #     if data_length>300:
                        #         col_len=data_length
                        #     else:
                        #         col_len=300
                        # else:
                        #     col_len=300
                        # 处理字段长度，varchar2, number如果有长度则设置，否则设置为默认值
                        data_length = row.length
                        if row.length is not None:
                            if row.dataType=='VARCHAR2' or row.dataType=='NUMBER':
                                data_length = row.length
                        else:
                            if row.dataType == 'VARCHAR2':
                                data_length = '300'
                            elif row.dataType=='NUMBER':
                                data_length = ''


                        # 创建主键的索引
                        if row.primaryKey=='Y':
                            primary_key=' primary key'
                            # 处理有可能有多个字段为主键的情况
                            pk_column_list = pk_column_list + row.columnName + ','
                        else:
                            primary_key=''
                        # 判断数据类型，为不同的类型生成相应的脚本
                        if row.dataType=='DATE':
                            col_str=' date'
                        elif row.dataType == 'VARCHAR2':
                            col_str = ' varchar2({0}) '.format(data_length)
                        elif row.dataType == 'NUMBER':
                            if data_length == '':
                                col_str = 'number'
                            else:
                                col_str = 'number({0}) '.format(data_length)
                        else:
                            col_str = ' varchar2(300) '
                        # 补充PK值
                        script = script + col_str
                    except Exception as e:
                        print('创建Template表时出现错误： '+str(e))
                    script=script+',\n'
            script=script[0:len(script)-2]+'\n);\n'
            # 对有主键的表生成主键信息，可以允许有多个字段的组合主键
            if pk_column_list != '' and configure.create_table_configure.get('real_data_type') is True:
                # 去除最后一个","
                pk_column_list = pk_column_list[0:len(pk_column_list)-1]
                pk_script = 'alter table {table_name} add CONSTRAINT pk_{table_name} PRIMARY KEY ({pk_column_list});\n'
                # 主键脚本
                pk_script = pk_script.format(table_name=newtable_name[0:26], pk_column_list=pk_column_list)
                script = script + pk_script
            # 对于没有生成PK的表生成唯一性索引，确保后面的校验语句能够快速运行
            if pk_column_list != '' and configure.create_table_configure.get('real_data_type') is False:
                index_name = 'INDX_'+table_name[0:21]+'_PK'
                index_sql = 'create index {index_name} on {table_name} ({pk_column_list});\n'
                index_sql = index_sql.format(index_name = index_name, table_name = newtable_name, pk_column_list = pk_column_list[0:len(pk_column_list)-1])
                script = script + index_sql + '\n'
            all_table_script=all_table_script+script+'\n'
        return all_table_script
        pass
    '''生成创建template表的脚本'''
    def __create_template_script(self):
        script=None
        all_table_script=''
        for table_name in self.__table_list:
            newtable_name = configure.create_table_configure.get('table_prefix')+table_name
            script='drop table '+newtable_name+';\n'
            script=script+'create table '+newtable_name +'(\n'
            pk_column_list = ''
            for row in self.__mapping_column_list:
                if row.tableName==table_name:
                    #调整字段的长度，使脚本对齐美观
                    script=script+row.columnName.ljust(30)
                    #为空的长度也都设置为默认300
                    try:
                        #处理字段长度，如果是纯数字的，如果超过300则用定义的值，否则用默认值，确保有超过300长度的创建表是正确的
                        data_length=self.__get_data_length(row.length)
                        if data_length!=None:
                            if data_length>300:
                                col_len=data_length
                            else:
                                col_len=300
                        else:
                            col_len=300

                        # 创建主键的索引
                        if row.primaryKey=='Y':
                            primary_key=' primary key'
                            # 处理有可能有多个字段为主键的情况
                            pk_column_list = pk_column_list + row.columnName+','
                        else:
                            primary_key=''
                        # script = script + ' varchar2(%d) %s'%(col_len,primary_key)
                        script = script + ' varchar2(%d) ' % (col_len)
                    except Exception as e:
                        print('创建Template表时出现错误： '+str(e))
                    script=script+',\n'
            script=script[0:len(script)-2]+'\n);\n'
            # 对有主键的表生成主键信息，可以允许有多个字段的组合主键
            if pk_column_list != '' and configure.create_table_configure.get('real_data_type') is True:
                # 去除最后一个","
                pk_column_list = pk_column_list[0:len(pk_column_list)-1]
                pk_script = 'alter table {table_name} add CONSTRAINT pk_{table_name} PRIMARY KEY ({pk_column_list});\n'
                # 主键脚本
                pk_script = pk_script.format(table_name=newtable_name[0:26], pk_column_list=pk_column_list)
                script = script + pk_script
            # 对于没有生成PK的表生成唯一性索引，确保后面的校验语句能够快速运行
            if pk_column_list != '' and configure.create_table_configure.get('real_data_type') is False:
                index_name = 'INDX_'+table_name[0:21]+'_PK'
                index_sql = 'create index {index_name} on {table_name} ({pk_column_list});\n'
                index_sql = index_sql.format(index_name = index_name, table_name = newtable_name, pk_column_list = pk_column_list[0:len(pk_column_list)-1])
                script = script + index_sql + '\n'

            all_table_script = all_table_script+script+'\n'
        return all_table_script
        pass

    '''生成每个表的控件文件，每个表生成一个单独的文件'''
    ''' control file sample
    load data
	infile 'li_clt_adr.unl.tab'
	replace into table li_clt_adr
	fields terminated by '|' TRAILING NULLCOLS
	(	                           
    clt_num		"TRIM(:clt_num		)",
    adr_num		"TRIM(:adr_num		)",
    adr_fmt		"TRIM(:adr_fmt		)"
    )
    '''
    def __create_control_file(self, table_name, file_name, column_list, column_split = '|'):
        # 生成控制文件及执行加载的命令文件,如果配置文件没有则使用默认值
        sqlldr_config_file_replace = configure.sqlloader_configure.get('append_type', "replace")
        sqlldr_config_file_name_ext = file_name +'.' + configure.sqlloader_configure.get('file_name_ext', 'txt')
        sqlldr_config_terminated_by = configure.sqlloader_configure.get('terminated_by', ',')
        sqlldr_config_enclosed_by = configure.sqlloader_configure.get('enclosed_by', '"')
        # 处理有些数据文件出现用TAB分隔但是用"作为enclosed by时会有数据错位的现象，去除掉这个选项后就没有问题了
        if sqlldr_config_enclosed_by =='None':
            new_sqlldr_config_enclosed_by = ''
        else:
            new_sqlldr_config_enclosed_by = "optionally enclosed by '{0}'".format(sqlldr_config_enclosed_by)
        sqlldr_config_nls_lang = configure.sqlloader_configure.get('nls_lang', "AMERICAN_AMERICA.ZHS16GBK")
        # print(configure.sqlloader_configure)
        # TODO 增加文件名大小写的参数配置
        control_file_format='load data \n'+\
                        "infile '{0}'\n"+\
                        "{4} into table {1}\n"+\
                        "fields terminated by '{2}' {5} trailing nullcols\n"+\
                        "(\n{3}\n)"
        control_file_format=control_file_format.format(sqlldr_config_file_name_ext,table_name,sqlldr_config_terminated_by,column_list,sqlldr_config_file_replace, new_sqlldr_config_enclosed_by)
        return control_file_format
    '''运行sqlldr的文件'''
    def __sqlldr_run_script(self, table_name):
        sqlldr_script_format = "sqlldr {src_user_name}/{src_user_pwd}@{connectstring} DIRECT=Y ROWS=50000 COLUMNARRAYROWS=50000 CONTROL=./sqlldr/control/{tablename}.ctl BAD=./sqlldr/bad/{tablename}.bad LOG=./sqlldr/log/{tablename}.log skip={ignore_first_row}"
        # 是否忽略首行的标题
        if configure.sqlloader_configure.get('ignore_first_row') is True:
            ignore_first_row = 1
        else:
            ignore_first_row = 0
        sqlldr_script = sqlldr_script_format.format(src_user_name = configure.sqlloader_configure.get('src_user_name'), src_user_pwd=configure.sqlloader_configure.get('src_user_pwd'),\
                        connectstring = configure.sqlloader_configure.get('connectstring'), tablename = table_name, ignore_first_row=ignore_first_row)
        return sqlldr_script
    '''清除已经生成的sqlldr加载文件'''
    def clear_sqlldr_file(self):
        try:
            # 清除生成的压缩文件
            if os.path.exists(configure.DOWNLOAD_FOLDER) is False:
                os.mkdir(configure.DOWNLOAD_FOLDER)
            else:
                # 清险已经生成的所有的文件
                shutil.rmtree(configure.DOWNLOAD_FOLDER)
                os.mkdir(configure.DOWNLOAD_FOLDER)
            sqlldr_win_file_name=os.path.join(configure.DOWNLOAD_FOLDER,'01loadingdata.bat')
            sqlldr_linux_file_name =os.path.join(configure.DOWNLOAD_FOLDER,'01loadingdata.sh')
            if os.path.exists(sqlldr_win_file_name):
                os.remove(sqlldr_win_file_name)
            if os.path.exists(sqlldr_linux_file_name):
                os.remove(sqlldr_linux_file_name)
        except Exception as e:
            print(str(e))
            pass
    '''生成sqlldr windows格式的加载命令'''
    def __save_sqlldr(self, file_content, os_type = 'win',  nls_lang= None):
        # windows
        nls_lang_format='{0} NLS_LANG={1}\n'
        default_lang='AMERICAN_AMERICA.ZHS16GBK'
        file_name_format=os.path.join(configure.DOWNLOAD_FOLDER,'01loadingdata.{0}')
        # 创建两个目录存放bad&log
        if os.path.exists(configure.SQLLDR_BAD_FOLDER) is False:
            os.mkdir(configure.SQLLDR_BAD_FOLDER)
        if os.path.exists(configure.SQLLDR_LOG_FOLDER) is False:
            os.mkdir(configure.SQLLDR_LOG_FOLDER)
        if os.path.exists(configure.SQLLDR_CONTROL_FOLDER) is False:
            os.mkdir(configure.SQLLDR_CONTROL_FOLDER)
        if os.path.exists(configure.SQLLDR_DATAFILE_FOLDER) is False:
            os.mkdir(configure.SQLLDR_DATAFILE_FOLDER)
        if os_type == 'win':
            file_name = file_name_format.format('bat')
            remark_str = '--'
            if nls_lang == None:
                nls_lang_used = nls_lang_format.format('set', default_lang)
            else:
                nls_lang_used = nls_lang_format.format('set', nls_lang)
        else:
            remark_str = '#'
            file_name = file_name_format.format('sh')
            if nls_lang == None:
                nls_lang_used = nls_lang_format.format('export', default_lang)
            else:
                nls_lang_used = nls_lang_format.format('export', nls_lang)
        # 如果文件已经 存在 则只写入内容，不写入语言的头信息
        if os.path.exists(file_name):
            sqlldr_file = open(file_name, 'a')
        else:
            sqlldr_file = open(file_name, 'a')
            # 写入语言信息
            sqlldr_file.write(nls_lang_used)
        # 写入模块信息
        sqlldr_file.write(remark_str+self.__module_name+'\n')

        # 写入每个文件的加载语句
        sqlldr_file.write(file_content)
        sqlldr_file.close()
        pass
    '''生成全部的控制文件'''
    def gen_control_files(self, file_ext_name = 'txt', column_split = '|', nls_lang = 'AMERICAN_AMERICA.ZHS16GBK'):
        sqlldr_scripts = ''
        # 创建sqlldr目录存放所有的加载相关的文件
        if os.path.exists(configure.SQLLDR_FOLDER) is False:
            os.mkdir(configure.SQLLDR_FOLDER)
        # 创建controlfiles保存所有的控件文件
        if os.path.exists(configure.SQLLDR_CONTROL_FOLDER) is False:
            os.mkdir(configure.SQLLDR_CONTROL_FOLDER)
        # sqlldr $USR_target/$PWD_target DIRECT=Y ROWS=50000 COLUMNARRAYROWS=50000 CONTROL=li_pln.ctl BAD=li_pln.bad LOG=li_pln.log
        for table_name in self.__table_list:
            one_column_list_format = '{0} \"TRIM(:{1})\",\n'
            all_column_list = ''
            newtable_name = configure.create_table_configure.get('table_prefix')+table_name
            for row in self.__mapping_column_list:
                if row.tableName == table_name:
                    # 每个列一行组成列的字符串
                    # 对于字符超过500的则用实际的长度
                    data_length_int = self.__get_data_length(row.length)
                    if row.dataType=='VARCHAR2' and data_length_int is not None:
                        if data_length_int >=500:
                            one_column_list = '{0} CHAR({2}) \"TRIM(:{1})\",\n'.format(row.columnName.ljust(30),
                                                                            row.columnName.ljust(30),data_length_int)
                            all_column_list = all_column_list + one_column_list
                            continue
                    one_column_list = one_column_list_format.format(row.columnName.ljust(30), row.columnName.ljust(30))
                    all_column_list = all_column_list + one_column_list
            # 去除最后一行的,
            all_column_list = all_column_list[0:len(all_column_list) - 2]
            file_name_upper = configure.sqlloader_configure.get('file_name_upper')
            # 判断生成的数据文件名称是不是统一用大写
            if file_name_upper is True:
                lower_table_name = table_name.upper()
            else:
                lower_table_name=table_name.lower()
            # 每个表生成一个文件
            control_file_content=self.__create_control_file(newtable_name, './sqlldr/datafiles/'+lower_table_name, all_column_list, column_split)
            # 保存到文件中
            control_file_name= configure.SQLLDR_CONTROL_FOLDER + lower_table_name+'.ctl'
            control_file=open(control_file_name, 'w')
            control_file.write(control_file_content)
            control_file.close()
            # 保存sqlldr的运行命令
            sqlldr_scripts = sqlldr_scripts + self.__sqlldr_run_script(lower_table_name)+'\n'
        # 保存sqlldr的执行文件到文件中，保存两个版本，一个是windows，一个是linux
        self.__save_sqlldr(sqlldr_scripts,'win', nls_lang)
        self.__save_sqlldr(sqlldr_scripts,'linux', nls_lang)
        # print(control_file_content)

        return all_column_list

        pass
    '''取得传进来值的长度'''
    def __get_data_length(self,data_length):
        col_len=data_length
        if type(data_length)==type(123):
            col_len= data_length
        elif type(data_length)==type('str'):
            if re.match('^\d+$', data_length) != None:
                col_len = int(data_length)
            else:
                col_len=None
        elif data_length==None:
            pass
        else:
            print('数据长度字段的值:%s是未知道的类型!'%type(data_length))
            col_len=None
        return col_len

    '''取得表的主键字段名称'''
    def __get_pk_column_name(self,table_name):
        refer_table_name = table_name.split('.')[0]
        pk_column_list = ''
        # 处理加了前缀的情况
        table_prefix = configure.create_table_configure.get('table_prefix')
        refer_table_name = refer_table_name.replace(table_prefix,'')
        for row in self.__mapping_column_list:
            if row.tableName==refer_table_name and row.primaryKey=='Y':
                pk_column_list = pk_column_list + row.columnName + ','
        # 删除最后多余的","
        if pk_column_list is not None and pk_column_list != '':
            pk_column_list = pk_column_list[0:len(pk_column_list)-1]
        return pk_column_list

    '''校验外键,template表之间的校验'''
    def __get_foreign_key_sql(self,module_name,table_name, column_name, refertable):
        need_verify = True
        if refertable is None or len(refertable.split('.')) == 1:
            return ''
        newrefertable_name = refertable
        # 取得外键表的主键，优先使用中间表中已经存在表的主键值
        if len(refertable.split('.')) > 1:
            table_prefix = configure.create_table_configure.get('table_prefix')
            refertable_name = refertable.split('.')[0]
            # 引用表到这里已经加了前缀，需要处理
            if refertable_name[len(table_prefix):len(table_prefix)+2] == 'DM':
                newrefertable_name = refertable_name
            else:
                # 如果是非DM开头的代码表则需要引用目标库的表，如果目标的设置名称为非空则直接加上用户名前缀
                if configure.sqlloader_configure.get('tar_user_name') !='':
                    newrefertable_name = configure.sqlloader_configure.get('tar_user_name')+'.'+refertable_name[len(table_prefix):]
                else:
                    newrefertable_name = refertable_name[len(table_prefix):]
        else:
            refertable_name = refertable
        pk_column_name=self.__get_pk_column_name(refertable)
        #  如果在本文件中找不到的外键表则用子表给定的字段名称
        if pk_column_name == '' or pk_column_name is None:
            # 如果在sheet中找不到外键表的主键值则通过refer table里面给的列值来处理，如DM_PARTY.PARTY_ID的格式
            if len(refertable.split('.'))>1:
                pk_column_name = refertable.split('.')[1]
                refertable_name = refertable.split('.')[0]
                # # 对于以DM开头的加前缀，其它的表不需要加前缀
                # if refertable_name[0:1] == 'DM':
                #     newrefertable_name = configure.create_table_configure.get('table_prefix')+ refertable_name
                # else:
                #     newrefertable_name = refertable_name
        # 如果没有指定出外键表的字段名称则忽略生成这个外键校验
        if newrefertable_name is not None and pk_column_name is not None:
            veri_code = 'VERI_FOREIGN_KEY_TEMPLATE'
            where_sql = ' where ( not exists(select 1 from %s  b where %s.%s=b.%s) and %s is not null)'%\
                        (newrefertable_name,table_name,column_name,pk_column_name, column_name)
        else:
            need_verify = False

        if need_verify:
            # 生成校验语句并把结果放到表中
            insert_result = self.__insert_result_sql
            # veri_sql = 'select \'%s\' as module_name,\'%s\' as table_name,\'%s\' as column_name,\'%s\' as veri_code,count(*) as veri_result,"[VERI_SQL]" as veri_sql from %s\n' % \
            #            (module_name, table_name, column_name, veri_code, table_name)
            # 校验的简化语句以方便直接使用查询
            select_sql = 'select {column_name}  from {table_name} '.format(column_name=column_name,table_name=table_name)+where_sql+';'
            # 对于把校验SQL放到校验结果中以方便查询
            veri_sql = 'select \'%s\' as module_name,\'%s\' as table_name,\'%s\' as column_name,\'%s\' as veri_code,count(*) as veri_result,\'%s\' as veri_sql from %s\n' % \
                       (module_name, table_name, column_name, veri_code,select_sql,table_name)

            veri_sql = insert_result + veri_sql + where_sql + ';\n'
        else:
            veri_sql = ''

        return veri_sql

    ''' 校验唯一键数据'''
    def __get_PK_sql(self,module_name,table_name, pk_column_list):
        need_verify = True
        veri_code = 'VERI_PRIMARY_KEY'
        # where_sql = ' where (select count(*) from {table_name}  b where 1=1  {connectcondi})>1 '
        where_sql = ' (select count(*) from {table_name} group by {pk_column_list} having count(*) >1 )'
        one_connectcondi = ' and {table_name}.{column_name}=b.{column_name} '
        # all_connectcondi = ''
        # for pk_column in pk_column_list.split(','):
        #     one_connectcondi = ' and {table_name}.{column_name}=b.{column_name} '
        #     one_connectcondi = one_connectcondi.format(table_name=table_name, column_name = pk_column)
        #     all_connectcondi = all_connectcondi + one_connectcondi
        where_sql = where_sql.format(table_name = table_name, pk_column_list = pk_column_list)
        if pk_column_list == '' or pk_column_list is None:
            need_verify = False
        # if primarykey == 'Y':
        #     veri_code = 'VERI_PRIMARY_KEY'
        #     where_sql = ' where (select count(*) from %s  b where %s.%s=b.%s)>1'%\
        #                 (table_name,table_name,column_name,column_name)
        # else:
        #     need_verify = False

        if need_verify:
            # 生成校验语句并把结果放到表中
            insert_result = self.__insert_result_sql
            # 校验的简化语句以方便直接使用查询
            select_sql = 'select {column_name}  from {table_name} '.format(column_name=pk_column_list,table_name=table_name)+where_sql+';'
            veri_sql = 'select \'%s\' as module_name,\'%s\' as table_name,\'%s\' as column_name,\'%s\' as veri_code,count(*) as veri_result,\'%s\' as veri_sql from \n%s' % \
                       (module_name, table_name, pk_column_list, veri_code,select_sql, where_sql)
            veri_sql = insert_result + veri_sql + ';\n'
        else:
            veri_sql = ''

        return veri_sql

    '''校验非空数据'''
    def __get_nullable_sql(self,module_name,table_name, column_name,nullable):
        need_verify = True
        if nullable == 'NOT NULL':
            veri_code = 'VERI_NON_NULLABLE'
            where_sql = ' where %s is  null' % (column_name)
        else:
            need_verify = False

        if need_verify:
            # 生成校验语句并把结果放到表中
            insert_result = self.__insert_result_sql
            # 校验的简化语句以方便直接使用查询
            select_sql = 'select {column_name}  from {table_name} '.format(column_name=column_name,table_name=table_name)+where_sql+';'
            veri_sql = 'select \'%s\' as module_name,\'%s\' as table_name,\'%s\' as column_name,\'%s\' as veri_code,count(*) as veri_result,\'%s\' as veri_sql from %s\n' % \
                       (module_name, table_name, column_name, veri_code,select_sql, table_name)
            veri_sql = insert_result + veri_sql + where_sql + ';\n'
        else:
            veri_sql = ''

        return veri_sql

    '''得到verifi sql，只校验数据类型'''
    def __get_data_type_sql(self,module_name,table_name, column_name,data_type, data_length):
        # 数据类型的校验
        need_verify = True
        data_length_int=self.__get_data_length(data_length)
        if data_type == 'NUMBER' :
            veri_code = 'VERI_NUMBER_ILLEGAL'
            where_sql = ' where f_is_number(%s)=1 and %s is not null' % (column_name, column_name)
        elif data_type == 'DATE':
            veri_code = 'VERI_DATE_ILLEGAL'
            where_sql = ' where f_is_date(%s)=1 and %s is not null' % (column_name, column_name)
        elif data_type == 'VARCHAR2' and data_length_int:
            veri_code = 'VERI_STRING_LENGTH_OVER_DEF'
            where_sql = ' where length(%s)>%d and %s is not null' % (column_name, data_length_int, column_name)
        else:
            need_verify=False

        if need_verify:
            # 生成校验语句并把结果放到表中
            insert_result = self.__insert_result_sql
            # 校验的简化语句以方便直接使用查询
            select_sql = 'select {column_name}  from {table_name} '.format(column_name=column_name,table_name=table_name)+where_sql+';'
            veri_sql = 'select \'%s\' as module_name,\'%s\' as table_name,\'%s\' as column_name,\'%s\' as veri_code,count(*) as veri_result,\'%s\' as veri_sql from %s\n' % \
                       (module_name, table_name, column_name, veri_code,select_sql, table_name)
            veri_sql = insert_result + veri_sql + where_sql+';\n'
        else:
            veri_sql=''

        return veri_sql
    '''生成唯一键，多字段联合唯一键或者单个字段都支持，Key这列可以设置为U后自动生成'''
    def get_unique_sql(self,module_name,table_name, uni_column_str):
        if uni_column_str is None or uni_column_str == '':
            return ''
        wheresql = ' (select {uni_column_list},count(*) from {table_name} group by {uni_column_list} having count(*) >1 )'
        # wheresql = 'where (select count(*) from {table_name} b where {connstr} )>1'
        connstr = '1=1 '
        show_column_name = '['
        # 去除最后的,
        uni_column_list = uni_column_str[0:len(uni_column_str)-1].split(',')
        veri_code = 'VERI_UNIQUE_KEY'
        for column in uni_column_list:
            # 把UNIQUE KEY的列组合显示出来
            show_column_name = show_column_name +column + ','
            # 自关联条件
            connstr = connstr + ' and a.{column_name} = b.{column_name} '.format(column_name=column)
        show_column_name = show_column_name[0:len(show_column_name)-1]+']'
        # where 条件SQL
        wheresql = wheresql.format(table_name=table_name, uni_column_list=uni_column_str[0:len(uni_column_str)-1])
        # 校验的简化语句以方便直接使用查询
        select_sql = 'select * from {table_name} '.format(table_name=wheresql) + ';'
        # 选择语句
        unique_sql = 'select \'{module_name}\' as module_name, \'{table_name}\' as table_name,\'{column_name}\' as column_name,\'{veri_code}\' as VERI_CODE,count(*) as veri_result,\'{veri_sql}\' as veri_sql from {wheresql} \n '
        unique_sql = unique_sql.format(module_name=module_name,table_name=table_name,column_name=show_column_name,veri_code= veri_code,veri_sql = select_sql, wheresql=wheresql)
        # 组合成最终的校验语句
        unique_sql = self.__insert_result_sql + unique_sql +';\n'
        # print(unique_sql)
        return unique_sql
        pass
    '''校验字段的数据类型，长度，是否可为空,FK引用'''
    def gen_veri_template_script(self):
        total_veri_sql = ''
        for table_name in self.__table_list:
            newtable_name = configure.create_table_configure.get('table_prefix')+table_name
            unique_columns = ''
            for row in self.__mapping_column_list:
                # 每个表单独一起处理
                if row.tableName == table_name:
                    # 基础 的数据类型校验
                    base_script=self.__get_data_type_sql(row.moduleName,newtable_name,row.columnName,row.dataType,row.length)
                    total_veri_sql=total_veri_sql+base_script
                    # 非空校验
                    nonnullable_sql=self.__get_nullable_sql(row.moduleName,newtable_name,row.columnName,row.nullable)
                    total_veri_sql = total_veri_sql + nonnullable_sql
                    # 主键类型校验
                    # pk_sql=self.__get_PK_sql(row.moduleName,newtable_name,row.columnName,row.primaryKey)
                    # total_veri_sql = total_veri_sql + pk_sql
                    # 唯一健的列名称，可以允许有多个列
                    if row.primaryKey == 'U':
                        unique_columns = unique_columns +row.columnName+','
                    # 外键类型校验，只校验template之间的关系，代码表由于字段名称不统一，目前 还没有办法把校验加进来
                    try:
                        if row.referTable is not None:
                            newrefertable = configure.create_table_configure.get('table_prefix') + row.referTable
                            fk_sql=self.__get_foreign_key_sql(row.moduleName,newtable_name,row.columnName,newrefertable)
                        else:
                            fk_sql =''
                    except Exception as e:
                        print(str(e))
                    total_veri_sql = total_veri_sql + fk_sql
            # 生成主键的校验语句
            # 主键类型校验
            pk_column_list = self.__get_pk_column_name(table_name)
            pk_sql = self.__get_PK_sql(row.moduleName, newtable_name, pk_column_list)
            total_veri_sql = total_veri_sql + pk_sql

            # 生成多个组合的唯一键，在表的列扫描完成后再生成UNIQUE
            unique_sql = self.get_unique_sql(row.moduleName,newtable_name,unique_columns)
            total_veri_sql = total_veri_sql + unique_sql
            pass
        total_veri_sql= total_veri_sql+'\n commit;\n'

        return total_veri_sql
        pass

    '''生成公共函数的脚本'''
    def save_public_script(self, file_name):
        script_file = open(file_name, 'w')
        # 创建保存校验结果的表
        create_table_script_result = self.create_veri_result_table()
        # 创建校验过程中用到的一些函数
        public_function_script = self.public_function()
        # 保存到文件
        script_file.write(create_table_script_result)
        script_file.write(public_function_script)
        script_file.close()
        return create_table_script_result+'\n'+public_function_script+'\n'

    '''把创建表脚本写入文件'''
    def save_template_create_script(self,file_name):
        # 这个参数不再需要，直接从参数中读取
        need_data_type = configure.create_table_configure.get('real_data_type')
        script_file=open(file_name,'w')
        filenameonly = file_name.split('/')[-1]
        script_file.write("spool {0}.log\n".format(filenameonly))
        # Template表的创建脚本
        if need_data_type is False:
            create_table_script_template=self.__create_template_script()
        else:
            create_table_script_template = self.__create_template_script_datatype()

        script_file.write(create_table_script_template)
        script_file.write("\nspool off")
        script_file.write("\n quit; ")
        script_file.close()
        return create_table_script_template
        pass
    '''把创建表脚本写入文件'''
    def save_template_veri_script(self,file_name):
        script_file=open(file_name,'w')
        filenameonly = file_name.split('/')[-1]
        script_file.write("spool {0}.log\n".format(filenameonly))
        # 校验脚本
        veri_script=self.gen_veri_template_script()

        script_file.write(veri_script)
        script_file.write("\nspool off")
        script_file.write("\n quit; ")
        script_file.close()

        return veri_script
        pass
    ''' 创建执行所有脚本的文件'''
    def save_run_all_scripts(self,file_name,run_scripts):
        script_file=open(file_name,'w')
        script_file.write(run_scripts)
        script_file.write('\nquit;')
        script_file.close()
        # 同时生成一个命令批处理文件以方便后面一次性调用所有的脚本
        # windows bat 文件
        if configure.script_public_configure.get('os') == 'win':
            bat_file_path = os.path.split(file_name)[0]
            bat_file_name = os.path.split(file_name)[1]
            bat_file_name = bat_file_name.split('.')[0]+'.bat'
            script_file = open(os.path.join(bat_file_path,bat_file_name), 'w')
            # 每一个运行的SQL文件生成一个批处理命令
            script_file.write('sqlplus {user_name}/{password}@{connectstring} @{sql_file_name}'.format(\
                user_name = configure.sqlloader_configure.get('src_user_name'), password = configure.sqlloader_configure.get('src_user_pwd'),\
                connectstring = configure.sqlloader_configure.get('connectstring'), sql_file_name = os.path.split(file_name)[1]))
            script_file.close()
    def save_run_for_all_batch(self, file_name_list):
        script_file=open(os.path.join(configure.DOWNLOAD_FOLDER,'run_for_all.bat'),'w')
        # 多个批处理文件一次性执行
        for file_name in file_name_list.split(','):
            script_file.write('call '+ file_name+'\n')
        script_file.close()


if __name__=='__main__':


    script=TemplateScript('./1.Template_Mapping_Party_V0.9_DM.xlsx')

    # script.get_unique_sql('ilp','DM_CONTRACT_INVEST_RATE','item_id,account_code,prem_type')
    script.clear_sqlldr_file()
    script.gen_control_files()
    # script.save_template_create_script()
    # script.save_script('party.sql')