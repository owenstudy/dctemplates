#!/usr/bin/env python3
# -*- coding: utf-8 -*-

# @Time    : 18-4-8 下午1:56
# @Author  : Owen_study
# @Email   : owen_study@126.com
# @File    : lslogcheck.py
# @Software: PyCharm
# ===============================================

import cx_Oracle, os
from app import configure
#执行查询 语句
# cursor.execute("select * from tabs")
#获取一条记录
# one = cursor.fetchone()
# print(one)
'''
本功能的主要作用是检查生成的现表数据和LOG数据是不是一致，因为LOG表是从现表复制过来的，实际操作中可能会导致现表和LOG之间的不一致
对每一个现表和LOG表中的字段进行统一处理，如果不一致的则保存异常结果到校验表中
'''
class LSLogCheck(object):
    def __init__(self,user_name, userpwd, connectstring,tablelist):
        self.__user_name = user_name
        self.__user_pwd =userpwd
        self.__connect_string = connectstring
        self.__table_list = tablelist
        if connectstring != '':
            conn = cx_Oracle.connect('{user_name}/{password}@{connstring}'.format(user_name=user_name,password=userpwd,connstring=connectstring))
        else:
            conn = cx_Oracle.connect('{user_name}/{password}'.format(user_name=user_name,password=userpwd))
        # 公共执行的cursor
        self.cursor = conn.cursor()
        sqlfilename = os.path.join(configure.DOWNLOAD_FOLDER,'03VeriLSLogTable.sql')
        self.sqlfilehandler = open(sqlfilename,'w')
        # 写入初始化脚本
        createtablesql = self.create_veri_result_table()
        self.sqlfilehandler.write(createtablesql+'\n')
    '''创建校验数据的结果表'''
    def create_veri_result_table(self):
        create_table_script="""
        create table dm_template_veri(module_name varchar2(100), table_name varchar2(100),
        column_name varchar2(100),veri_code varchar2(100),veri_result number);
        """
        return create_table_script
        pass

    # 获取表的语句名称
    def get_pk_column(self,tablename):
        pksql = "select b.column_name from user_constraints a , user_cons_columns b where a.constraint_name=b.constraint_name and a.constraint_type='P' and a.table_name='{0}'".format(tablename.upper())

        self.cursor.execute(pksql)
        # 只处理PK值有一个的情况
        pk_columnname = self.cursor.fetchone()[0]
        # print(pk_columnname)
        return pk_columnname

    # 检查主表和LOG表之间相同的字段名称内容不同的情况
    def check_log(self,tablename, tablename_log = ''):
        if tablename_log == '':
            newtablename_log = tablename+'_log'
        else:
            newtablename_log = tablename_log
        newtablename_log = newtablename_log.upper()
        # get Pk name
        pk_columnname = self.get_pk_column(tablename)
        # 获得现表和LOG表相同名称的字段
        checklogcolumnsql = "select a.column_name,a.data_type from user_tab_columns a  where a.TABLE_NAME ='{tablename}' and \
            exists(select 1 from user_tab_columns b where b.table_name='{tablenamelog}' and a.COLUMN_NAME=b.COLUMN_NAME)".format(tablename=tablename.upper(),tablenamelog=newtablename_log.upper())
        # 获取相同的字段列表，对每个字段进行逐一对比
        # self.cursor.close()
        self.cursor.execute(checklogcolumnsql)
        checkcolumns = self.cursor.fetchall()

        for eachcolumn in checkcolumns:
            columnname = eachcolumn[0]
            datatype = eachcolumn[1]
            if columnname == pk_columnname:
                continue
            if datatype == 'NUMBER':
                default = 0
            elif datatype == 'VARCHAR2':
                default = "'0'"
            elif datatype == 'DATE':
                default = 'trunc(sysdate)'
            else:
                default = 0
            # 检查每个字段的语句
            checksql = "select 'LOG','{tablename}','{column_name}' as columnname,'VERI_LOG_COLUMN', count(*) from {tablename} a where not exists(select 1 from {tablename_log} b where \n\
                          a.{pk_columnname} = b.{pk_columnname} and nvl(a.{column_name},{default})=nvl(b.{column_name},{default}) and b.last_cmt_flg='Y');\n"
            # 每个字段的检查语句
            checksql = checksql.format(tablename=tablename.upper(), column_name=columnname, tablename_log=newtablename_log,
                                       pk_columnname=pk_columnname, default = default)
            insert_result_sql='insert into dm_template_veri (module_name,table_name,column_name,veri_code,veri_result)\n'

            veri_sql = insert_result_sql+checksql
            # 保存到文件
            self.sqlfilehandler.write(veri_sql)
            print(veri_sql)
    def checkalltables(self):
        for table_name in self.__table_list:
            self.check_log(table_name,'')
        pass
if __name__ == '__main__':
    checklist = [
        'T_ADD_INVEST',
        'T_ASSIGNEE',
        'T_BENEFIT_AGENT',
        'T_BENEFIT_INSURED',
        'T_CONTRACT_BENE',
        'T_CONTRACT_EXTEND',
        'T_CONTRACT_INVEST',
        'T_CONTRACT_INVEST_RATE',
        'T_CONTRACT_INVEST_STREAM',
        'T_CONTRACT_MASTER',
        'T_CONTRACT_PRODUCT',
        'T_EXTRA_PREM',
        'T_ILP_BUCKET_FILLING',
        'T_ILP_BUCKET_INFO',
        'T_ILP_PREM_AGENT',
        'T_ILP_RECURRING_TOPUP',
        'T_ILP_REGULAR_PREM',
        'T_INSURED_LIST',
        'T_MORTGAGE_RATE',
        'T_PAYER',
        'T_PAYER_ACCOUNT',
        'T_PAY_DUE',
        'T_PAY_PLAN',
        'T_PAY_PLAN_PAYEE',
        'T_POLICY_ACCOUNT',
        'T_POLICY_ACCOUNT_STREAM',
        'T_POLICY_CUSTOMER',
        'T_POLICY_ENDORSEMENT',
        'T_POLICY_EXCLUSION',
        'T_POLICY_FUND_CHARGE',
        'T_POLICY_GRANTEE',
        'T_POLICY_HOLDER',
        'T_PREM_DISCNT',
        'T_REFUND_PAYEE',
        'T_REINSURER',
        'T_RI_CONTRACT',
        'T_RI_CONTRACT_REINSURER',
        'T_RI_EXTRA_PREM',
        'T_RI_INSURED_LIST',
        'T_RI_POLICY',
        'T_RI_POLICY_ENDORSEMENT',
        'T_RI_POLICY_EXCLUSION',
        'T_RI_POLICY_PRODUCT',
        'T_RI_PRODUCT_RISK',
        'T_SA_SCHEDULE',
        'T_TOPUP_AGENT',
        'T_TRUSTEE'
    ]
    checklog = LSLogCheck('ual_ls_demo','ual_ls_demo','',checklist)
    checklog.checkalltables()
    pass