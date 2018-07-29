#!/usr/bin/env python3
# -*- coding: utf-8 -*-

# @Time    : 7/18/2018 12:19 PM
# @Author  : Owen_study
# @Email   : owen_study@126.com
# @File    : extractdatatosql.py
# @Software: PyCharm Community Edition
# ===============================================

from app.oracleconn import oracleconn
from app import configure
import os
"""
抽取表的数据成SQL语句，根据某一条件抽取一系统列的数据到文件中，以方便数据的转移
"""
class ExtractData2Sql(object):
    def __init__(self,user_name, userpwd, connectstring):
        # oracle连接串
        self.conn = oracleconn(user_name, userpwd, connectstring);
        # 公共执行的cursor
        self.cursor = self.conn.cursor()
        sqlfilename = os.path.join(configure.DOWNLOAD_FOLDER, 'SqlData.sql')
        self.__logfile_name = 'SqlData.log'
        self.sqlfilehandler = open(sqlfilename, 'w')
        pass
    # 获取某一个表的数据，根据提供的SQL语句
    def get_sqldata_by_table(self, table_name, wheresql):
        selectsql = self.get_select_sql(table_name)[0]+ wheresql
        column_list = self.get_select_sql(table_name)[1]
        sqldata = self.cursor.execute(selectsql).fetchall()
        # 对查询的结果进行处理，每一行生成一个insert语句
        if len(sqldata) ==0:
            return None
        # insertsql = 'insert into {table_name} ({column_list})\n select {value_list} \nfrom dual a \
        #     where not exists(select 1 from {table_name} b where b.{pk_name}={pk_value});\n'
        onetableinsertsql = ''
        pk_column_name = self.get_pk_column(table_name)
        if pk_column_name is None or pk_column_name =='' or column_list.index(pk_column_name)>len(column_list):
            print('[{0}]:No Pimary key!'.format(table_name))
            # 没有PK的默认使用第一个字段
            return column_list.split(',')[0]
            return None
        else:
            pk_column_index = column_list.split(',').index(pk_column_name)
        for eachrec in sqldata:
            insertsql = 'insert into {table_name} ({column_list})\n select {value_list} \nfrom dual a \
                where not exists(select 1 from {table_name} b where b.{pk_name}={pk_value});\n'
            eachrecord_valuelist = ''
            pk_value = eachrec[pk_column_index]
            for eachcolvalue in eachrec:
                if eachcolvalue is None:
                    eachrecord_valuelist = eachrecord_valuelist +'null,'
                else:
                    eachrecord_valuelist = eachrecord_valuelist +str(eachcolvalue)+','
                pass
            eachrecord_valuelist = eachrecord_valuelist[0:len(eachrecord_valuelist)-1]
            # 每行的语句都生成一个insertsql
            insertsql = insertsql.format(table_name=table_name,column_list=column_list, value_list = eachrecord_valuelist, pk_name=pk_column_name, pk_value=pk_value)
            # print(insertsql)
            onetableinsertsql = onetableinsertsql + insertsql
        # print(onetableinsertsql)
        return onetableinsertsql

        pass
    # 获取表的主键名称
    def get_pk_column(self,tablename):
        pksql = "select b.column_name from user_constraints a , user_cons_columns b where a.constraint_name=b.constraint_name and a.constraint_type='P' and a.table_name='{0}'".format(tablename.upper())

        self.cursor.execute(pksql)
        # 只处理PK值有一个的情况
        pk_columnname = self.cursor.fetchone()
        if pk_columnname is not None:
            pk_columnname=pk_columnname[0]
        else:
            pk_columnname= None
        # print(pk_columnname)
        return pk_columnname
    # 获取表的全部列名及类型
    def get_select_sql(self, table_name):
        sql = "select column_name, data_type from cols a, tabs b  where a.table_name=b.table_name and a.table_name=upper('{0}')".format(table_name)
        sqldata = self.cursor.execute(sql).fetchall()
        selectsql = 'select {column_list} from {table_name} '
        select_column_list = ""
        column_list = ""
        for eachdata in sqldata:
            column_name = eachdata[0]
            data_type = eachdata[1]

            # 表的所有原列表
            column_list = column_list + column_name+','
            # 处理过的列名
            select_column_list = select_column_list + self.get_select_column_name(column_name,data_type)+','
        column_list = column_list[0:len(column_list)-1]
        select_column_list = select_column_list[0:len(select_column_list)-1]
        selectsql = selectsql.format(column_list = select_column_list, table_name=table_name)
        return selectsql,column_list
        pass
    # 根据列名和类型来判断生成什么格式的查询字段
    def get_select_column_name(self, column_name, data_type):
        new_column_name = column_name
        if data_type == 'DATE' or data_type[0:9] =='TIMESTAMP':
            new_column_name = "'to_date('''||"+"to_char({0},'yyyy/mm/dd')".format(column_name)+"||''',''yyyy/mm/dd'')' as {0}".format(column_name)
        if data_type == 'VARCHAR2' or data_type == 'CHAR' or data_type == 'CLOB':
            new_column_name = "''''||"+column_name+"||'''' as {0}".format(column_name)
        else:
            new_column_name

        return new_column_name
        pass
    # 根据全部的列表生成对应的语句,每个表共用一个条件
    def get_sqldata_all_tables(self, table_list, wheresql):
        all_sqls = ''
        for table_name in table_list:
            # 每个表生成一段insert SQL语句
            sql = self.get_sqldata_by_table(table_name,wheresql)
            if sql is not None:
                self.sqlfilehandler.write(sql)
            # all_sqls =all_sqls + sql

    # 根据保单的条件生成对应的SQL语句,自动查找需要生成的表,传入policy_id列表，用,分开
    def gen_all_table_sqls(self,policy_id_list):
        sql = "select distinct a.table_name from cols a, tabs b where a.table_name=b.table_name and  a.column_name='POLICY_ID'"
        sqldata = self.cursor.execute(sql).fetchall()
        table_list = []
        for eachtable in sqldata:
            table_list.append(eachtable[0])

        all_sql = self.get_sqldata_all_tables(table_list,' where policy_id in ({0})'.format(policy_id_list))
        pass
    # 根据保单的条件生成对应的SQL语句
    def gen_sql_from_where_sql(self,wheresql):
        sql = "select distinct a.table_name from cols a, tabs b where a.table_name=b.table_name and  a.column_name='POLICY_ID'"
        sqldata = self.cursor.execute(sql).fetchall()
        table_list = []
        for eachtable in sqldata:
            table_list.append(eachtable[0])

        all_sql = self.get_sqldata_all_tables(table_list,wheresql)
        return True
        pass
if __name__ == '__main__':
    extractdata = ExtractData2Sql('ccic_cr_pa','ccic_cr_papwd','172.16.7.37:1522/c37u1')
    # extractdata = ExtractData2Sql('ual_ls_demo','ual_ls_demo','CN01L0201000282:1521/orcl')
    extractdata.gen_sql_from_where_sql(' where policy_id<0')
    # extractdata.gen_all_table_sqls('-101158738985230')
    # extractdata.get_sqldata_by_table('T_CONTRACT_MASTER',' where 1=1')
    # selectsql = extractdata.get_select_sql('t_pa_pl_policy')
    # print(selectsql[0])
    # extractdata.get_select_column_name('CREATE_TIME','TIMESTAMP(6)')
    pass