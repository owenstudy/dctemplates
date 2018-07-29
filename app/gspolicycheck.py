#!/usr/bin/env python3
# -*- coding: utf-8 -*-

# @Time    : 7/13/2018 1:37 PM
# @Author  : Owen_study
# @Email   : owen_study@126.com
# @File    : gspolicycheck.py
# @Software: PyCharm Community Edition
# ===============================================
'''
分析实际测试环境的数据，并和迁移的数据进行对比，找出关键的差异部分，主要分布的内容：
1. 码值的不同                --自动分析
2. 必填字段的不同              --自动分析
3. 子表的完整性，比如某些子表没有数据    --自动分析
4. 日志表的关联性      --自动分析
5. 根据迁移数据完全新承保的保单和迁移单保单数据的完整性比对     --人工创建单子，手动调用比对
'''
from app.oracleconn import oracleconn
from app import configure
import os
import pandas as pd
class GSPolicyCheck(object):
    # 传递抽取数据的测试环境数据和迁移环境数据, dm_迁移的目标环境，tar_测试的目标环境
    def __init__(self,dm_user_name, dm_userpwd, dm_connectstring,tst_user_name, tst_userpwd, tst_connectstring):
        # oracle连接串
        self.dm_conn = oracleconn(dm_user_name,dm_userpwd,dm_connectstring);
        self.tst_conn = oracleconn(tst_user_name,tst_userpwd,tst_connectstring);
        # 公共执行的cursor
        self.dm_cursor = self.dm_conn.cursor()
        self.tst_cursor = self.tst_conn.cursor()
        sqlfilename = os.path.join(configure.DOWNLOAD_FOLDER,'06AnalyzeScript.sql')
        self.sqlfilehandler = open(sqlfilename,'w')
    # 抽取验证表列表，以保单policy_id为标准列出需要检查的列表，以测试环境的列表为准
    def get_table_list(self,db_cursor):
        sql = "select A.TABLE_NAME from cols a where a.COLUMN_NAME='POLICY_ID' AND TABLE_NAME LIKE 'T_%'"
        all_tables = db_cursor.execute(sql).fetchall()
        return_table_list = []
        for table_name in all_tables:
            return_table_list.append(table_name[0])
            pass
        return return_table_list
        pass
    # 分析单个表的数据情况,根据表所在的数据进行测试
    def analyze_table_data(self, table_name, db_cursor):
        tabledata = self.get_table_data_pandas(table_name,db_cursor)
        table_count= tabledata.count(axis=0)
        first_column_cnt= tabledata['POLICY_ID'].count()
        print(tabledata.columns)
        unique_count = tabledata.nunique(axis=1)

        pass
    # 分析并取一个表的唯一键字段并保存到分析表中
    def get_unique_key_columns(self, tabledata):

        pass
    # 分析并取一个表中的代码表字段
    def get_code_table_columns(self):
        pass
    # 取出表数据放到pandas里面进行分析，取全表的数据
    def get_table_data_pandas(self, table_name, db_cursor):
        sql='select * from {0}'.format(table_name)
        table_data = db_cursor.execute(sql).fetchall()
        table_data_pd = pd.DataFrame(table_data)
        # 设置数据的列名以方便后面对数据的比对
        table_columns = self.get_table_columns(table_name,db_cursor)
        # 根据表的结构设置查询出来结果的列表名称
        table_data_pd.columns=table_columns
        print(list(table_data_pd.columns))
        return table_data_pd
    # 获取一个表的所有列名，供比较时使用
    def get_table_columns(self,table_name, db_cursor):
        sql ="select column_name from cols where table_name='{0}' ".format(table_name)
        sql_data = db_cursor.execute(sql).fetchall()
        # 把查找出来的数据放到一个列表中方便后面的使用
        column_list = []
        for column_name in sql_data:
            column_list.append(column_name[0])
        return column_list

    # 获取一个表的主键列名
    def get_table_pk_columns(self,table_name,db_cursor):
        pass
        pksql = "select b.column_name from user_constraints a , user_cons_columns b where a.constraint_name=b.constraint_name and a.constraint_type='P' and a.table_name='{0}'".format(tablename.upper())

        # 只处理PK值有一个的情况
        pk_columnname=db_cursor.execute(pksql).fetchone()[0]
        return pk_columnname

    # 分析所有的表结果 TODO
    def analyze_table_data_all(self,table_list, db_cursor):
        pass

    # 创建分析结果表的初始化脚本 TODO
    def init_script(self):
        # 保单数据列表供抽样检查
        policy_list_script=' create table dm_analyze_policy_list (policy_id number, policy_no varchar2(30))'
        # 保存对表分析的结果
        policy_analyze_result ="""
        create table dm_analyze_result (sn number, table_name varchar2(30), column_name varchar2(50),
              result_type varchar2(20), comments varchar2(1000),db varchar2(100), insert_time date default sysdate)
        """
        pass

if __name__ == '__main__':
    gspolicy= GSPolicyCheck('ccic_cr_pa','ccic_cr_papwd','172.16.7.37:1522/c37u1','ual_ls_demo','ual_ls_demo','CN01L0201000282:1521/orcl')

    gspolicy.get_table_columns('T_CONTRACT_MASTER',gspolicy.dm_cursor)

    # tablist = gspolicy.get_table_list(gspolicy.dm_cursor)
    tabledata = gspolicy.analyze_table_data('T_CONTRACT_MASTER',gspolicy.dm_cursor)
    # print(tabledata.describe())
    gspolicy.analyze_table_data('T_CONTRACT_MASTER',gspolicy.dm_cursor)
    pass