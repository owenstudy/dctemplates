#!/usr/bin/env python3
# -*- coding: utf-8 -*-

# @Time    : 6/21/2018 10:01 AM
# @Author  : Owen_study
# @Email   : owen_study@126.com
# @File    : oracleconn.py
# @Software: PyCharm Community Edition
# ===============================================
import cx_Oracle
"""
一个标准的oracle联接，直接传入用户名密码和联系串，返回一个连接对象
"""
def oracleconn (user_name, userpwd, connectstring ):
    try:
        if connectstring != '':
            conn = cx_Oracle.connect('{user_name}/{password}@{connstring}'.format(user_name=user_name, password=userpwd,
                                                                                  connstring=connectstring))
        else:
            conn = cx_Oracle.connect('{user_name}/{password}'.format(user_name=user_name, password=userpwd))
    except Exception as e:
        print('连接错误:{0}'.format(str(e)))
        return None
    return conn
if __name__ == '__main__':
    pass