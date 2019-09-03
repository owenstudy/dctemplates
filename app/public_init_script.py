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

# 公共的sqlplus 参数设置
init_sqlplus_para = """
            set echo on \n
            """
#DC迁移用到的表,如果表已经存在则忽略创建，不删除，因为表中的目标数据是额外维护的
init_dc_all_tables = init_sqlplus_para + """
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
init_dc_validation = init_sqlplus_para + """
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
  run_duration_source     number(19,2),
  run_duration_target     number(19,2),
  run_date           date
) nologging;
comment on column dc_validation.sn  is '主键序号';
comment on column dc_validation.in_project  is 'Y(适用当前项目，要执行) / N(不适用于当前项目)';
comment on column dc_validation.priority  is '检核规则的优先级: H/M/L)';
comment on column dc_validation.table_name  is '如果规则能在T表校验，就写T表名；否则才写源表名';
comment on column dc_validation.temp_skip  is ' Y(适用当前项目的前提下，会临时跳过不执行) / N(不临时跳过)';
comment on column dc_validation.rule_from  is ' 检核规则的来源说明，比如defect no / BSD名称 / dc baseline等等';
comment on column dc_validation.results_source  is '结果为负数表示校验语句执行报错；这里的source指S_DM表结构的data 或 Legacy表结构的data';
comment on column dc_validation.results_target  is '结果为负数表示校验语句执行报错';
comment on column dc_validation.run_duration_source  is '源数据检核脚本执行时长';
comment on column dc_validation.run_date  is '检核规则最近执行日期，不区分source/target';
        \n
        """
init_insert_dc_validation = """
insert into dc_validation (SN,MODULE,IN_PROJECT,PRIORITY,ERROR_CODE,TABLE_NAME,COLUMN_NAME,DESCRIPTION,SQL_FOR_SOURCE,SQL_FOR_TARGET,REMARK,TEMP_SKIP,RULE_FROM)
 values (
 '{SN}','{MODULE}','{IN_PROJECT}','{PRIORITY}','{ERROR_CODE}','{TABLE_NAME}','{COLUMN_NAME}','{DESCRIPTION}','{SQL_FOR_SOURCE}','{SQL_FOR_TARGET}','{REMARK}','{TEMP_SKIP}','{RULE_FROM}'
);\n
"""
# 生成DCReconciliation report的表结构，主要是指business reconciliation report
init_dc_reconciliation =  init_sqlplus_para + """
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
  sql_target           varchar2(4000) ,
  sql_source           varchar2(4000) ,
  run_status_target    varchar2(300),
  run_time_target      number(16),
  last_run_date_target date,
  run_status_source    varchar2(300),
  run_time_source      number(16),
  last_run_date_source date
) nologging;
comment on column dc_reconciliation_script.brr_status   is 'Y(适用当前项目，要执行) / N(不适用于当前项目)';
comment on column dc_reconciliation_script.sn   is '主键，以A或B开头接数字构成，A类规则的优先级高于B';
comment on column dc_reconciliation_script.brr_column1   is '统计维度1';
comment on column dc_reconciliation_script.brr_column2   is '统计维度2';
comment on column dc_reconciliation_script.brr_column3   is '统计维度3';
comment on column dc_reconciliation_script.cnt_column1   is '统计结果';
        \n
        """
init_insert_dc_reconciliation = """
insert into dc_reconciliation_script (BRR_Status,SN,Module,BRR_CODE,BRR_Desc,BRR_Column1,BRR_Column2,BRR_Column3,Cnt_Column1,Comments,SQL_Target,SQL_Source)
 values (
'{BRR_Status}','{SN}','{Module}','{BRR_CODE}','{BRR_Desc}','{BRR_Column1}','{BRR_Column2}','{BRR_Column3}','{Cnt_Column1}','{Comments}','{SQL_Target}','{SQL_Source}'
);\n
"""

# DC STEP check table scl
init_dc_dc_step_check = init_sqlplus_para + """
drop table dc_step_check;
create table dc_step_check
(step_id  number(5) primary key,
 step_desc varchar2(500) not null,
 skip_check varchar2(1) default 'Y' not null,
 check_sql varchar2(4000) not null
) nologging;
\n
"""

# DC mapping dc fields
init_dc_mapping_for_dc_fields = init_sqlplus_para + """
drop table dc_mapping_for_dc_fields;

create table dc_mapping_for_dc_fields
(
dm_table          varchar2(30) not null,
s_dm_table      varchar2(30) not null,
table_rule         varchar2(400) ,
table_rule_detail     varchar2(2000),
column_name         varchar2(30) not null,
dm_table_pk           varchar2(1),
column_rule            varchar2(400) not null,
column_rule_detail  varchar2(2000)
) nologging;
alter table dc_mapping_for_dc_fields add primary key (dm_table, column_name);
comment on column dc_mapping_for_dc_fields.dm_table_pk  is '如果当前字段是DM表的主键，则为Y；否则为null';
comment on column dc_mapping_for_dc_fields.column_name  is 'DM表中"DC_"开头的字段名，但并不是所有DC字段都需要在这张表里维护规则';
comment on column dc_mapping_for_dc_fields.table_rule   is '根据DM表生成来源分3类情况：from_s_dm_only/from_s_dm_and_one_table/from_more_than_2_tables';
comment on column dc_mapping_for_dc_fields.table_rule_detail  is '对于无法在已有规则中涵盖的，需要在这个字段中写出完整的"from ... where ..."';
comment on column dc_mapping_for_dc_fields.column_rule  is '需要在这张表里维护的DC字段，只有2类column_rule: sequence/special_rule';
comment on column dc_mapping_for_dc_fields.column_rule_detail is 'column_rule为"sequence"的，在这个字段中注明sequence name；column_rule为"special_rule"的，在这个字段中写明字段映射规则';
\n
"""
# DC source total control
init_dc_source_total_control = init_sqlplus_para + """
drop table dc_source_total_control; 
create table dc_source_total_control
  (table_name varchar2(30) primary key,
   total_number  number(19)   not null
) nologging;
\n
"""
# 公共的文件名称
# 逻辑校验脚本的文件名称
validation_file_name = 'business_rule_verification.sql'
reconciliation_file_name = 'reconciliation_report.sql'
# Trigger生成的脚本文件名字
trigger_file_name = 'trigger_verification.sql'

if __name__ == '__main__':
    pass