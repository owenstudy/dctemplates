#!/usr/bin/env python3
# -*- coding: utf-8 -*-

__author__ = 'Owen_Study/owen_study@126.com'

import openpyxl,re, os
from app import common

'''从excel加载template'''

class Template(object):
    # 初始化数据文件到object
    def __init__(self,file_name,ignore_strike_row=True):
        self.__file_name=file_name
        self.excel_handler=openpyxl.load_workbook(file_name, data_only=True)
        self.__ignore_strike_row=ignore_strike_row

    # test template cols
    def test__get_mapping_cols(self):
        mapping_columns_sheet=self.__get_mapping_cols_sheet(self.excel_handler)
        mapping_columns_list=self.get_mapping_cols(mapping_columns_sheet)



    # 取得mapping columns这个sheet
    def __get_mapping_cols_sheet(self,excel_handler):
        sheet_names = excel_handler.sheetnames
        mapping_columns_sheet=None
        for sheet in sheet_names:
            if sheet=='MappingColumns':
                mapping_columns_sheet=excel_handler.get_sheet_by_name(sheet)
                break
        return mapping_columns_sheet


    # 读取excel columns中的字段信息，放到json对象中
    def get_mapping_cols(self):
        mapping_columns_sheet=self.__get_mapping_cols_sheet(self.excel_handler)

        # Template Table Name	Column Name	Data Type	Length	Nullable	Key	Short Description	Descirption of Data Migration	Default Value	Reference Table
        #所有的列名
        column_title_name=('tableName','columnName','dataType','length','nullable','primaryKey','descShort','descDM','defaultValue','referTable')
        # 循环所有的行
        mapping_rows=[]
        for row in mapping_columns_sheet.rows:
            # 循环所有 的列
            cell_value={}
            for cell in row:
                #忽略已经加了删除线的行,只检查前两列是否有删除线，则说明本行是删除的，其它单元格的删除线不识别
                if cell.font.strikethrough and cell.col_idx<=2 and self.__ignore_strike_row:
                    break
                # 排除掉第一行的标题
                if cell.col_idx<=len(column_title_name) and cell.row>=2:
                    title_name=column_title_name[cell.col_idx-1]
                    cell_value[title_name]=cell.value
                    # debug
                    if cell.value == 'COUNTRY':
                        pass
                        # print('stop')
                    #print(cell_value)
            if len(cell_value)>0:
                # 去除文件名的路径信息
                module_name = os.path.split(self.__file_name)[1]
                cell_value['moduleName']=module_name
                cellobj=common.JSONObject(cell_value)
                mapping_rows.append(cellobj)
        return mapping_rows

class DCDocConfigExcel(object):
    # 初始化数据文件到object
    def __init__(self,file_name,ignore_strike_row=True):
        self.__file_name=file_name
        self.excel_handler=openpyxl.load_workbook(file_name, data_only=True)
        self.__ignore_strike_row=ignore_strike_row
    # 取得excel配置的数据信息
    def get_config_data(self):
        docconfig = self.excel_handler.worksheets[0]
        #所有的列名,如果新增加列则直接增加列名,返回的内容只包括列表所在的数据内容
        column_title_name=('phase','sn','majorinfo','output','remark','referdoc')
        # 循环所有的行
        config_rows=[]
        for row in docconfig.rows:
            # 循环所有 的列
            cell_value={}
            for cell in row:
                #忽略已经加了删除线的行,只检查前两列是否有删除线，则说明本行是删除的，其它单元格的删除线不识别
                if cell.font.strikethrough and cell.col_idx<=2 and self.__ignore_strike_row:
                    break
                # 排除掉第一行的标题
                if cell.col_idx<=len(column_title_name) and cell.row>=2:
                    title_name=column_title_name[cell.col_idx-1]
                    cell_value[title_name]=cell.value
            if len(cell_value) > 0:
                # cellobj = common.JSONObject(cell_value)
                # config_rows.append(cellobj)
                config_rows.append(cell_value)

        # print(config_rows[0].majorinfo)
        for config in config_rows:
            for value in config:
                print(config[value])
        return config_rows
        pass


if __name__=='__main__':

    file_name='./数据迁移规范列表.xlsx'

    docconfig = DCDocConfigExcel(file_name)
    docconfig.get_config_data()
    #file_name='sample.xlsx'
    # template1=Template(file_name)
    # mappingcols=template1.get_mapping_cols()

    # for row in mappingcols:
    #     print('%s,%s,%s'%(row.tableName,row.columnName,row.dataType))