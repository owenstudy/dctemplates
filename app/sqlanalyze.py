#!/usr/bin/env python3
# -*- coding: utf-8 -*-

# @Time    : 7/3/2018 10:58 AM
# @Author  : Owen_study
# @Email   : owen_study@126.com
# @File    : sqlanalyze.py
# @Software: PyCharm Community Edition
# ===============================================

# -*- coding: UTF-8 -*-


import re,sqlparse

keylist = ['ACCESS', 'ADD', 'ALL', 'ALTER', 'AND', 'ANY', 'AS', 'ASC', 'AUDIT', 'BETWEEN', 'BY', 'CHAR', 'CHECK',
           'CLUSTER', 'COLUMN', 'COMMENT', 'COMPRESS', 'CONNECT', 'CREATE', 'CURRENT', 'DATE', 'DECIMAL', 'DEFAULT',
           'DELETE', 'DESC', 'DISTINCT', 'DROP', 'ELSE', 'EXCLUSIVE', 'EXISTS', 'FILE', 'FLOAT', 'FOR', 'FROM', 'GRANT',
           'GROUP', 'HAVING', 'IDENTIFIED', 'IMMEDIATE', 'IN', 'INCREMENT', 'INDEX', 'INITIAL', 'INSERT', 'INTEGER',
           'INTERSECT', 'INTO', 'IS', 'LEVEL', 'LIKE', 'LOCK', 'LONG', 'MAXEXTENTS', 'MINUS', 'MLSLABEL', 'MODE',
           'MODIFY', 'NOAUDIT', 'NOCOMPRESS', 'NOT', 'NOWAIT', 'NULL', 'NUMBER', 'OF', 'OFFLINE', 'ON', 'ONLINE',
           'OPTION', 'OR', 'ORDER', 'P', 'CTFREE', 'PRIOR', 'PRIVILEGES', 'PUBLIC', 'RAW', 'RENAME', 'RESOURCE',
           'REVOKE', 'ROW', 'ROWID', 'ROWNUM', 'ROWS', 'SELECT', 'SESSION', 'SET', 'SHARE', 'SIZE', 'SMALLINT', 'START',
           'SUCCESSFUL', 'SYNONYM', 'SYSDATE', 'TABLE', 'THEN', 'TO', 'TRIGGER', 'UID', 'UNION', 'UNIQUE', 'UPDATE',
           'USER', 'VALIDATE', 'VALUES', 'VARCHAR', 'VARCHAR2', 'VIEW', 'WHENEVER', 'WHERE', 'WITH']

# sq3string = r"(\b[rRbB])?'''[^'\\]*((\\.|'(?!''))[^'\\]*)*(''')?"
sq3string = r"(\b[rRbB])?'[^'\\]*((\\.|'(?!''))[^'\\]*)*?(')?"# 倒数第二个？是为了最小匹配
sqs1 = r"(\b[rRbB])?"
sqs2 = r"A((?!table).)+B"    # 匹配排除table
selectmatch = r"(?!')*\bfrom\b\s+\b(?P<table_name>\w+)\b\s+\b(?P<table_sn>\w+)\b(?!')*"  # 匹配select语句中的表名和表名的简写
insertmatch = r"(?!')*\binsert\b\s+\binto\b\s+\b(?P<table_name>\w+)\b\s+\b(?P<table_sn>\w+)\b(?!')*"   # 匹配insert语句中的表名和表名的简写
updatematch = r"(?!')*\bupdate\b\s+\b(?P<table_name>\w+)\b\s+\b(?P<table_sn>\w+)(?!')+"   # 匹配insert语句中的表名和表名的简写


# chars="select 'from tt we ,d f'*,t able from dual T where sfsf"
selectchars = "select *,'select * from tab3 T3 where T3.s' from tab1 T where a='select * from tab2 T2 where T2.s'"
insertchars = "insert into tab1 T1 (as) values (t,2,_)"
updatechars = "update tab1 t set df='update tab2 sdf set mm=1'"
# print(''.join([i+'|' for i in keylist])[0:-1])


##chars = selectchars
##
### 下面是去掉语句中的字符串，因为字符串可能含有sql语句
##sqloutstr = re.finditer(sq3string, chars, re.S)
##slt = [i for i in sqloutstr]
##slt.reverse()
##if sqloutstr:
##    for match in slt:
##        pl = match.span()
##        chars = chars[:pl[0]]+chars[pl[1]:]
##print(chars)
##
##mstr = selectmatch
##prog = re.compile(mstr, re.S|re.IGNORECASE)
##
##m1 = prog.match(chars)
##
##if m1:
##    print('m1.string',m1.string)
##    print('匹配到:',chars[m1.start():m1.end()])
##m = prog.search(chars)
##if m:
##    print('m',m.groupdict().items())
##    for key, value in m.groupdict().items():
##        print('key, value',key, value)


selectprog = re.compile(selectmatch, re.S | re.IGNORECASE)
updateprog = re.compile(updatematch, re.S | re.IGNORECASE)
inserprog = re.compile(insertmatch, re.S | re.IGNORECASE)


def delSqlStr(sqlstr):
    sqloutstr = re.finditer(sq3string, sqlstr, re.S)

    slt = [i for i in sqloutstr]
    slt.reverse()
    if sqloutstr:
        for match in slt:
            pl = match.span()
            sqlstr = sqlstr[:pl[0]] + sqlstr[pl[1]:]
    return sqlstr


def getSelectTBN(sqlstr):
    """ 返回select语句的 表名,表名简写"""

    TabName = None
    shortTabName = None
    m = selectprog.search(sqlstr)
    if m:
        for key, value in m.groupdict().items():
            if key == 'table_sn':
                shortTabName = value
                if key == 'table_name':
                    TabName = value
    # print('getSelectTBN  TabName=',TabName, 'shortTabName=',shortTabName)
    return TabName, shortTabName


def getUpdateTBN(sqlstr):
    """ 返回select语句的 表名,表名简写"""

    TabName = None
    shortTabName = None
    m = updateprog.search(sqlstr)
    if m:
        for key, value in m.groupdict().items():
            if key == 'table_sn':
                shortTabName = value
                if key == 'table_name':
                    TabName = value
    # print('getUpdateTBN  TabName=',TabName, 'shortTabName=',shortTabName)
    return TabName, shortTabName


def getInsertTBN(sqlstr):
    """ 返回select语句的 表名,表名简写"""

    TabName = None
    shortTabName = None
    m = inserprog.search(sqlstr)
    if m:
        for key, value in m.groupdict().items():
            if key == 'table_sn':
                shortTabName = value
                if key == 'table_name':
                    TabName = value
    # print('getInsertTBN  TabName=',TabName, 'shortTabName=',shortTabName)
    return TabName, shortTabName


def getTabNameShortName(sqlstr):
    tmpsqlstr = delSqlStr(sqlstr)

    TabName = None
    shortTabName = None
    TabName, shortTabName = getSelectTBN(tmpsqlstr)
    if TabName:
        return TabName, shortTabName
    TabName, shortTabName = getUpdateTBN(tmpsqlstr)
    if TabName:
        return TabName, shortTabName
    TabName, shortTabName = getInsertTBN(tmpsqlstr)
    if TabName:
        return TabName, shortTabName

chars = "select * from tab1 T1 where T1.name='ssd'"
print(chars)
print(getTabNameShortName(chars))
chars = "update Tab2 T id=12,name='xiaoxiao'"
print(chars)
print(getTabNameShortName(chars))
chars = "insert into tab3 t3 values(13,'dada')"
print(chars)
print(getTabNameShortName(chars))

if __name__ == '__main__':
    pass