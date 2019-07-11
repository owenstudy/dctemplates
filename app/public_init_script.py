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
init_dc_all_tables = """
create table dc_all_tables  
  (table_name                varchar2(30) primary key,
   table_category           varchar2(20) not null,  
   module                       varchar2(20)    ,            
   number_of_all            number(15)     ,
   number_of_passed    number(15)     ,           
   number_of_initial       number(15)     ,
   from_dataset              varchar2(300)  ,   
   number_of_dataset    number(15)  
  ) nologging;
comment on column dc_all_tables.table_category  is '只能为这3个值： SOURCE/TEMPLATE/TARGET';
comment on column dc_all_tables.module  is '所属模组，读ODI数据字典自动维护';
comment on column dc_all_tables.number_of_passed  is '通过业务规则校验的记录数，ODI脚本自动维护';
comment on column dc_all_tables.number_of_initial  is '用于保存初始的记录数，ODI脚本自动维护';
comment on column dc_all_tables.from_dataset  is '来源数据集，多数表对应的dataset是table，少数是subquery; SOURCE表的来源数据集为空';
comment on column dc_all_tables.number_of_dataset  is '来源数据集的记录数，ODI脚本自动维护';
 \n
"""
# 生成DC_all_tables的insert 语句
init_insert_dc_all_tables = """insert into dc_all_tables (table_name,table_category) select '{table_name}','{table_category}' from dual 
    where not exists(select 1 from dc_all_tables x where x.table_name='{table_name}' and x.table_category='{table_category}');\n"""

# 生成DC校验的表结构，主要是指手工维护的一些逻辑校验
init_dc_validation = """
        drop table dc_validation;
        create table dc_validation
        (
          sn                     number(5) primary key,
          module             varchar2(100) not null,
          in_project         varchar2(100) default 'Y' not null,   
          priority              varchar2(1)     not null,  
          error_code       varchar2(100),  
          table_name      varchar2(500) not null,  
          column_name  varchar2(500),
          description       varchar2(4000) not null,
          sql_for_source varchar2(4000),
          sql_for_target   varchar2(4000),
          remark              varchar2(4000),   
          temp_skip         varchar2(10)  default 'N' not null, 
          rule_from          varchar2(200)  not null,
          results_source number(19),           
          results_target   number(19),           
          run_duration     number(19,2),
          run_date           date
        );\n
        comment on column dc_validation.sn  is '主键序号';
        comment on column dc_validation.in_project  is 'Y(适用当前项目，要执行) / N(不适用于当前项目)';
        comment on column dc_validation.priority  is '检核规则的优先级: H/M/L)';
        comment on column dc_validation.table_name  is '统一放T表名称';
        comment on column dc_validation.temp_skip  is ' Y(适用当前项目的前提下，会临时跳过不执行) / N(不临时跳过)';
        comment on column dc_validation.rule_from  is ' 检核规则的来源说明，比如defect no / BSD名称 / dc baseline等等';
        comment on column dc_validation.results_source  is '结果为负数表示校验语句执行报错；这里的source指S_DM表结构的da';
        \n
        """
init_insert_dc_validation = """
insert into dc_validation (SN,MODULE,IN_PROJECT,PRIORITY,ERROR_CODE,TABLE_NAME,COLUMN_NAME,DESCRIPTION,SQL_FOR_SOURCE,SQL_FOR_TARGET,REMARK,TEMP_SKIP,RULE_FROM)
 values (
 '{SN}','{MODULE}','{IN_PROJECT}','{PRIORITY}','{ERROR_CODE}','{TABLE_NAME}','{COLUMN_NAME}','{DESCRIPTION}','{SQL_FOR_SOURCE}','{SQL_FOR_TARGET}','{REMARK}','{TEMP_SKIP}','{RULE_FROM}'
);\n
"""
# 生成DCReconciliation report的表结构，主要是指business reconciliation report
init_dc_reconciliation = """
drop table dc_reconciliation_script; 
create table dc_reconciliation_script
(
  brr_status           varchar2(300) not null,
  sn                   varchar2(300)  primary key,
  module               varchar2(300) not null,
  brr_code             varchar2(300) not null,
  brr_desc             varchar2(500) not null,
  brr_column1          varchar2(300) ,
  brr_column2          varchar2(300),
  brr_column3          varchar2(300),
  cnt_column1          varchar2(1000) not null,
  comments             varchar2(1000),
  sql_target           varchar2(4000) not null,
  sql_source           varchar2(4000) not null,
  run_status_target    varchar2(300),
  run_time_target      number(16),
  last_run_date_target date,
  run_status_source    varchar2(300),
  run_time_source      number(16),
  last_run_date_source date
) nologging;\n
comment on column dc_reconciliation_script.brr_status   is 'Y(适用当前项目，要执行) / N(不适用于当前项目)';
comment on column dc_reconciliation_script.sn   is 'Y(Valid)/N(Invalid)';
comment on column dc_reconciliation_script.brr_column1   is '统计维度1';
comment on column dc_reconciliation_script.brr_column2   is '统计维度2';
comment on column dc_reconciliation_script.brr_column3   is '统计维度3';
comment on column dc_reconciliation_script.cnt_column1   is '统计结果';\n
        """
init_insert_dc_reconciliation = """
insert into dc_reconciliation_script (BRR_Status,SN,Module,BRR_CODE,BRR_Desc,BRR_Column1,BRR_Column2,BRR_Column3,Cnt_Column1,Comments,SQL_Target,SQL_Source)
 values (
'{BRR_Status}','{SN}','{Module}','{BRR_CODE}','{BRR_Desc}','{BRR_Column1}','{BRR_Column2}','{BRR_Column3}','{Cnt_Column1}','{Comments}','{SQL_Target}','{SQL_Source}'
);\n
"""

# 公共的文件名称
# 逻辑校验脚本的文件名称
validation_file_name = 'business_rule_verification.sql'
reconciliation_file_name = 'reconciliation_verification.sql'
# Trigger生成的脚本文件名字
trigger_file_name = 'trigger_verification.sql'

if __name__ == '__main__':
    pass