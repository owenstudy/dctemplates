#!/usr/bin/env python3
# -*- coding: utf-8 -*-

# @Time    : 7/1/2019 2:09 PM
# @Author  : Owen_study
# @Email   : owen_study@126.com
# @File    : public_init_script.py
# @Software: PyCharm Community Edition
# ===============================================
'''
创建一些程序中需要使用的初始化脚本，如一些初始表的创建语句，一些初始化数据等
'''

'''创建表的语句，每个表一个变量说明'''

#DC迁移用到的表,如果表已经存在则忽略创建，不删除，因为表中的目标数据是额外维护的
init_dc_all_tables = '''
create table dc_all_tables  
  (table_name                varchar2(30) primary key,
   table_category           varchar2(20) not null,  --只能为这3个值： SOURCE/DM/TARGET
   module                      varchar2(20)    ,            --module: 读ODI数据字典自动维护 
   number_of_all            number(15)     ,
   number_of_passed    number(15)     ,            --业务规则校验：验证通过的记录数
   number_of_initial       number(15)                  --number_of_initial用于保存target表导数前的记录数              
  );\n
'''
# 生成DC_all_tables的insert 语句
init_insert_dc_all_tables = """insert into dc_all_tables (table_name,table_category) select '{table_name}','{table_category}' from dual 
    where not exists(select 1 from dc_all_tables x where x.table_name='{table_name}' and x.table_category='{table_category}');\n"""



if __name__ == '__main__':
    pass