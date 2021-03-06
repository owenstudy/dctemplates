#!/usr/bin/env python3
# -*- coding: utf-8 -*-
import os

# 生成控制文件的配置说明
# file_name_upper 加载的文件名称是不是大写，默认为大写
sqlloader_configure = {"file_name_ext": "csv", "terminated_by":",", "enclosed_by":'"', "append_type":"append", "nls_lang":"AMERICAN_AMERICA.ZHS16GBK",\
                       'file_name_upper':True,'ignore_first_row':False,'src_user_name':"$UserName",'src_user_pwd':'$src_user_pwd','connectstring':"",\
                       'tar_user_name':''}

# sqlloader的选项列表
file_name_ext_list = [ 'csv','txt']
terminated_by_list = ['TAB',',']
enclosed_by_list = ['None','"','|']
append_type_list = ['append', 'replace']
nls_lang_list = ['AMERICAN_AMERICA.AR8MSWIN1256','AMERICAN_AMERICA.ZHS16GBK','AMERICAN_AMERICA.AL32UTF8']

# real_data_type 生成创建中间表的控制选项, 真实的数据类型或者实际定义的数据类型,
# table_prefix 创建表时加的前缀，为了支持一些项目需要加一个表名前缀
# 2019.6.27 增加自动添加数迁需要的主外键的额外字段以方便迁移，客户提供的主外键不在系统中使用, additional_dc_columns默认为添加
# 是否在数据加载完成后做schema的统计分析 analyze_schema
create_table_configure = {"real_data_type": False, "table_prefix":"",  "additional_DC_columns": True, "analyze_schema": True}

# 生成脚本的一些公共通用配置信息
script_public_configure = {'os':'win'}
# new project 初始化脚本参数
new_project_init_config = {"project_abbr":"", "ls_gs":"LS,GS", "work_repo_list":""}

template_column_title_name = (
'tableName', 'columnName', 'dataType', 'length', 'nullable', 'primaryKey', 'descShort', 'descDM', 'defaultValue','referTable')


# 设置sql运行log文件的初始化参数和时间信息
# 2020.4.9 leo.zhao 增加收集统计信息代码exec dbms_stats.gather_schema_stats('');
log_file_set_start="""
set feedback on
set echo on
set define off
set sqlblanklines on
select to_char(sysdate,'YYYY/MM/DD HH:MI:SS') from dual;
exec dbms_stats.gather_schema_stats('');
\n
"""
log_file_set_end = """
select to_char(sysdate,'YYYY/MM/DD HH:MI:SS') from dual;
\n
"""
BASE_DIR = os.path.abspath(os.path.dirname(__file__))
print(BASE_DIR)
# 在外部运行时需要把APP_MAIN_FOLDER设置为AP主目录
APP_MAIN_FOLDER = BASE_DIR
# 下载文件目录
DOWNLOAD_FOLDER = os.path.join(APP_MAIN_FOLDER,'downloads/')
# 上传文件目录
UPLOADS_FOLDER = os.path.join(APP_MAIN_FOLDER, 'uploads/')
#  静态文件目录
STATIC_FOLDER = os.path.join(APP_MAIN_FOLDER, 'static/')

# 生成DC ODI脚本的公共配置目录 2019.9.7
# template related 脚本
ODI_FOLDER_TEMPLATE = os.path.join(DOWNLOAD_FOLDER,'allLoadVeriScripts/')
# 客户提供的dump文件所在的目录
ODI_FOLDER_DBDUMP = os.path.join(DOWNLOAD_FOLDER,'DBDump/')
# 默认放入DBDUMP默认的文件列表
ODI_DBDUMP_FILE_LIST = ['DBDUMP方式导入源数据.docx']
# 【DCBaseLine_Config_Script】
ODI_FOLDER_DCBASELINE_CONFIG = os.path.join(DOWNLOAD_FOLDER,'DCBaseLine_Config_Script/')
# Python 报表生成的程序文件
ODI_FOLDER_Python  = os.path.join(DOWNLOAD_FOLDER,'PythonProgram/')
# 下载的python静态文件名称列表
ODI_Python_FILE_LIST = ['dbdump.py','dc_overall_reports.py','configure.py']
# 输入输出的相关文档，主要是报表和template
ODI_FOLDER_REPORT = os.path.join(DOWNLOAD_FOLDER,'docInputOutput/')
# 放入这个文件夹的默认文件列表
ODI_REPORT_FILE_LIST = ['dc_overall_reports.xlsx']


# SQLLDR_FOLDER = os.path.join(DOWNLOAD_FOLDER,'sqlldr/')
# 统一目录，增加一层子目录 2019.9.7
SQLLDR_FOLDER = os.path.join(ODI_FOLDER_TEMPLATE,'sqlldr/')
# SQLLDR_FOLDER = os.path.join(APP_MAIN_FOLDER,'sqlldr/')
SQLLDR_LOG_FOLDER = os.path.join(SQLLDR_FOLDER,'log/')
SQLLDR_BAD_FOLDER = os.path.join(SQLLDR_FOLDER,'bad/')
SQLLDR_CONTROL_FOLDER = os.path.join(SQLLDR_FOLDER,'control/')
SQLLDR_DATAFILE_FOLDER = os.path.join(SQLLDR_FOLDER,'datafiles/')
SQLLDR_TEMPLATES_FOLDER = os.path.join(APP_MAIN_FOLDER, 'uploads/')

