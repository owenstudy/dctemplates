#!/usr/bin/env python3
# -*- coding: utf-8 -*-

# @Time    : 4/11/2018 2:47 PM
# @Author  : Owen_study
# @Email   : owen_study@126.com
# @File    : lspolicycheck.py
# @Software: PyCharm Community Edition
# ===============================================
'''
主要是用系统测试的保单来对比测试迁移过来的保单，确保测试的数据和转换进来的数据对比结果一致，检查字段或者表遗漏的情况出现
测试主要侧重下面几点：
1. 表一级的含有policy_id的表，相同的产品测试数据有的表迁移进来的相同产品的保单是不是也存在，如果迁移不存在的表则记录下来
2. 如果是相同的表，则比较字段，侧重找一些迁移字段没有值但是测试数据有值的情况并记录下来
'''
import cx_Oracle
class LSDCPolicyCheck:
    # 传递测试用户和DC用户的信息，以方便拉取数据进行比较, 传递数据的结构是{username:'', password:'',connstring:''}
    def __init__(self, testuser, dcuser):
        # 测试数据所在的用户信息
        self.__testuser = testuser
        conn_test = cx_Oracle.connect('{user_name}/{password}@{connstring}'.format(user_name=testuser.get('username'), password=testuser.get('password'),
                                                                              connstring=testuser.get('connstring')))
        self.__cursor_test = conn_test.cursor()

        # DC转换数据所在的用户信息
        self.__dcuser = dcuser
        conn_dc = cx_Oracle.connect('{user_name}/{password}@{connstring}'.format(user_name=dcuser.get('username'), password=dcuser.get('password'),
                                                                              connstring=dcuser.get('connstring')))
        self.__cursor_dc = conn_dc.cursor()
    '''获取测试库中的保单列表，传入险种id，获取对应的保单列表'''
    def get_policy_list(self, product_id):
        # 获取保单列表
        sql = 'select distinct policy_id from t_contract_product a where a.product_id={product_id} and rownum<100'.format(product_id=product_id)
        self.__cursor_test.execute(sql)
        # 获取全部的保单列表
        policy_list = self.__cursor_test.fetchall()
        policydatalist=[]
        for policy in policy_list:
            policydatalist.append(policy[0])
        # 合并成一个列表返回
        return policydatalist
        pass
    '''获取有policy_id这个字段的列表，根据测试库来获取列表'''
    def get_table_list_test(self):
        # 获取有policy_id的表列表
        sql = "select DISTINCT A.TABLE_NAME from user_tab_cols a where exists(select 1 from user_tab_cols b where a.TABLE_NAME=b.TABLE_NAME and b.COLUMN_NAME='POLICY_ID')"
        tableall = self.__cursor_test.execute(sql)
        alldata = tableall.fetchall()
        tablelist = []
        for table in alldata:
            # 获取T_开始的头，排除其它非相关的表
            if table[0][0:2] == 'T_':
                tablelist.append(table[0])

        return tablelist
if __name__ == '__main__':
    testuser = {'username':'ual_ls_demo', 'password':'ual_ls_demo','connstring':''}
    dcuser = {'username':'ual_ls_demo', 'password':'ual_ls_demo','connstring':''}
    lspolicy = LSDCPolicyCheck(testuser,dcuser)
    lspolicy.get_policy_list(6092)
    lspolicy.get_table_list_test()
    pass