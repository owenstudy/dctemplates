#!/usr/bin/env python3
# -*- coding: utf-8 -*-

# @Time    : 11/8/2018 2:13 PM
# @Author  : Owen_study
# @Email   : owen_study@126.com
# @File    : mappingdoc.py
# @Software: PyCharm Community Edition
# ===============================================
import openpyxl
from openpyxl.workbook import Workbook
from app.template import DCMappingExcel
from app import configure
import os
'''
主要统计映射文档的完成情况，以便生成报表
主要统计两个功能，映射完成度和开发完成度，使用O列和P列的标志位进行统计
'''

class MappingDoc(object):
    # 初始化数据文件到object
    def __init__(self,ignore_strike_row=True):
        # 通过读取download目录 下面的文件来查找映射文档
        file_name_list = self.get_mapping_list()
        self.__file_name_list=file_name_list
        self.__ignore_strike_row=ignore_strike_row
        self.__summary_file_name='MappingSummary.xlsx'

    # 处理一个文件的映射情况
    def mapping_single_file(self,filename):
        # 加载文件到对象中
        mappingjson=DCMappingExcel(file_name=filename,ignore_strike_row = self.__ignore_strike_row).get_config_data()
        # 处理文件中的数据
        cntresultlist=[]
        # 获取表的唯一列表
        tablelist=[]
        for row in mappingjson:
            if row['tableName'] is None or row['tableName']=='':
                continue
            tablelist.append(row['tableName'])
        uniquetablelist= list(set(tablelist))
        # 循环处理每一个表
        for table_name in uniquetablelist:
            cntresult = {}
            cntresult['filename'] = filename
            cntresult['mappingdonecnt'] = 0
            cntresult['developeddonecnt'] = 0
            cntresult['mappingtotal'] = 0

            cntresult['tablename'] = table_name
            for row in mappingjson:
                # 处理每一行的映射和开发完成情况
                if table_name != row['tableName']:
                    continue
                cntresult['tablename']=table_name
                # 统计映射完成的列数量
                if row['mappingdone'] == 'Y':
                    cntresult['mappingdonecnt'] = cntresult['mappingdonecnt']+1;
                # 统计开发完成的列数量
                if row['developeddone'] == 'Y':
                    cntresult['developeddonecnt'] = cntresult['developeddonecnt'] + 1;
                # 总的列数
                cntresult['mappingtotal'] = cntresult['mappingtotal'] + 1;
            cntresultlist.append(cntresult)
        return cntresultlist
    # 处理所有的文件
    def mapping_multiple_file_list(self):
        # 把结果生成到一个文件中
        summyexcel = Workbook()
        wssummary = summyexcel.active
        wssummary.title = 'ProgressDetail'
        # 设置每行的列名以方便查看
        colindex = 'A'
        columntitle=['TableName','MappingDoneTotal','MappingDone%','DevelopedDoneTotal','DevelopedDone%','MappingTotalColumns','ModuleFileName']
        for column in columntitle:
            cellindex = '{0}{1}'.format(colindex, 1)
            wssummary[cellindex]=column
            colindex = chr(ord(colindex) + 1)
        rowindx = 2
        for filename in self.__file_name_list:
            singlemapping = self.mapping_single_file(filename)
            # 行列的索引字符串，以方便保存定位
            for eachtable in singlemapping:
                # 每次从第一列开始重复写入
                colindex = 'A'
                # 保存统计数据进入excel，设置每列的值
                # 表名
                cellindex ='{0}{1}'.format(colindex,rowindx)
                wssummary[cellindex].value = eachtable['tablename']
                # 映射完成数量
                colindex =chr(ord(colindex)+1)
                cellindex ='{0}{1}'.format(colindex,rowindx)
                wssummary[cellindex] = eachtable['mappingdonecnt']
                # 映射完成百分比
                colindex =chr(ord(colindex)+1)
                cellindex ='{0}{1}'.format(colindex,rowindx)
                wssummary[cellindex] = eachtable['mappingdonecnt']/eachtable['mappingtotal']
                # 开发完成数量
                colindex =chr(ord(colindex)+1)
                cellindex ='{0}{1}'.format(colindex,rowindx)
                wssummary[cellindex] = eachtable['developeddonecnt']
                # 开发完成百分比
                colindex =chr(ord(colindex)+1)
                cellindex ='{0}{1}'.format(colindex,rowindx)
                wssummary[cellindex] = eachtable['developeddonecnt']/eachtable['mappingtotal']
                # 映射总数量
                colindex =chr(ord(colindex)+1)
                cellindex ='{0}{1}'.format(colindex,rowindx)
                wssummary[cellindex] = eachtable['mappingtotal']
                # 模块文件名
                colindex =chr(ord(colindex)+1)
                cellindex ='{0}{1}'.format(colindex,rowindx)
                # 只保存文件名称，不保存路径
                wssummary[cellindex] = os.path.basename(eachtable['filename'])
                # 一张表一行数据
                rowindx = rowindx +1
        summyexcel.save(os.path.join(configure.DOWNLOAD_FOLDER,self.__summary_file_name))
    # 查找某个目录下面所有的映射文档以便生成所有映射文件的统计信息
    def get_mapping_list(self):
        file_path = configure.DOWNLOAD_FOLDER
        # file_path=path
        files = os.listdir(file_path)
        mapping_list = []
        # 处理报表文件
        for mappingfile in files:
            fileextname = str.lower(os.path.splitext(mappingfile)[1])
            # 排除掉生成的summary文件
            if (fileextname == '.xlsx' or fileextname== '.xls') and os.path.basename(mappingfile)!='MappingSummary.xlsx':
                filename = os.path.join(file_path, mappingfile)
                mapping_list.append(filename)
        return mapping_list
if __name__ == '__main__':
    filename='MMA_Mapping_BCP_SRC2STG_1026.xlsx'
    filelist = ['MMA_Mapping_BCP_SRC2STG_1026 (1).xlsx','MMA_Mapping_ILP Basic_SRC2STG_20181031.xlsx','MMA_Mapping_ILP Transaction_SRC2STG.xlsx','MMA_Mapping_MAV_SRC2STG _0906_2.xlsx','MMA_Mapping_PAC_SRC2STG_0806.xlsx','MMA_Mapping_PARTY_SRC2STG_0905 (1).xlsx','MMA_Mapping_POLICY_PROPOSAL_SRC2STG _0903.xlsx','MMA_Mapping_POLICY_SRC2STG _10 (2).xlsx','MMA_Mapping_POS_SRC2STG.xlsx']
    mappingcols = MappingDoc()
    mappingcols.get_mapping_list()
    # cntresult = mappingcols.mapping_single_file(filename=filename)
    mappingcols.mapping_multiple_file_list()
    # print(cntresult)
    pass