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
        checklogcolumnsql = "select a.column_name from user_tab_columns a  where a.TABLE_NAME ='{tablename}' and \
            exists(select 1 from user_tab_columns b where b.table_name='{tablenamelog}' and a.COLUMN_NAME=b.COLUMN_NAME)".format(tablename=tablename.upper(),tablenamelog=newtablename_log.upper())
        # 检查每个字段的语句
        checksql = "select 'LOG','{tablename}','{column_name}' as columnname,'VERI_LOG_COLUMN', count(*) from {tablename} a where not exists(select 1 from {tablename_log} b where \n\
                      a.{pk_columnname} = b.{pk_columnname} and a.{column_name}=b.{column_name} and b.last_cmt_flg='Y');\n"
        # 获取相同的字段列表，对每个字段进行逐一对比
        self.cursor.execute(checklogcolumnsql)
        checkcolumns = self.cursor.fetchall()

        for eachcolumn in checkcolumns:
            columnname = eachcolumn[0]
            if columnname == pk_columnname:
                continue
            # 每个字段的检查语句
            checksql = checksql.format(tablename=tablename.upper(), column_name=columnname, tablename_log=newtablename_log,
                                       pk_columnname=pk_columnname)
            insert_result_sql='insert into dm_template_veri (module_name,table_name,column_name,veri_code,veri_result)\n'

            veri_sql = insert_result_sql+checksql
            # 保存到文件
            self.sqlfilehandler.write(veri_sql)
            print(veri_sql)

        pass
if __name__ == '__main__':
    checklog = LSLogCheck('ual_ls_demo','ual_ls_demo','',['T_contRACT_MASTER'])
    checklog.check_log('T_contRACT_MASTER')
    pass