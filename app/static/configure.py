#!/usr/bin/env python3
# -*- coding: utf-8 -*-


# 生成 dc reports  参数,
# """
# 参数说明：
# dbstring : connected oracle dbuser, here use dc src schema,format is  xx/xx@xx
# dc_overall_reports_file : sql config file
# """
script_dc_report_generate = {"dbstring":"dla_ls_src/dla_ls_src@c1815u1","dc_overall_reports_file":"dc_overall_reports.xlsx"}
# """
# 参数说明：
# connectstring : dc src schema name's tns name
# src_user_name : dc src schema name
# """
script_dbdump_generate = {"connectstring":"c1815u1","src_user_name":"dla_ls_src"}

#配基本路径
import os
BASE_DIR = 'D:/Migration_Script'
DBDUMP_FOLDER = os.path.join(BASE_DIR,'DBDump/')
DOCINPUTOUTPUT_FOLDER = os.path.join(BASE_DIR,'docInputOutput/')




# # 生成控制文件的配置说明
# # file_name_upper 加载的文件名称是不是大写，默认为大写
# sqlloader_configure = {"file_name_ext": "csv", "terminated_by":",", "enclosed_by":'"', "append_type":"append", "nls_lang":"AMERICAN_AMERICA.ZHS16GBK",\
#                        'file_name_upper':True,'ignore_first_row':False,'src_user_name':"$UserName",'src_user_pwd':'$src_user_pwd','connectstring':"",\
#                        'tar_user_name':''}
# 
# # sqlloader的选项列表
# file_name_ext_list = [ 'csv','txt']
# terminated_by_list = ['TAB',',']
# enclosed_by_list = ['None','"','|']
# append_type_list = ['append', 'replace']
# nls_lang_list = ['AMERICAN_AMERICA.AR8MSWIN1256','AMERICAN_AMERICA.ZHS16GBK','AMERICAN_AMERICA.AL32UTF8']
# 
# # real_data_type 生成创建中间表的控制选项, 真实的数据类型或者实际定义的数据类型,
# # table_prefix 创建表时加的前缀，为了支持一些项目需要加一个表名前缀
# # 2019.6.27 增加自动添加数迁需要的主外键的额外字段以方便迁移，客户提供的主外键不在系统中使用, additional_dc_columns默认为添加
# # 是否在数据加载完成后做schema的统计分析 analyze_schema
# create_table_configure = {"real_data_type": False, "table_prefix":"",  "additional_DC_columns": True, "analyze_schema": True}
# 
# # 生成脚本的一些公共通用配置信息
# script_public_configure = {'os':'win'}
# # new project 初始化脚本参数
# new_project_init_config = {"project_abbr":"", "ls_gs":"LS,GS", "work_repo_list":""}
# 
# import os
# BASE_DIR = os.path.abspath(os.path.dirname(__file__))
# print(BASE_DIR)
# # 在外部运行时需要把APP_MAIN_FOLDER设置为AP主目录
# APP_MAIN_FOLDER = BASE_DIR
# # 下载文件目录
# DOWNLOAD_FOLDER = os.path.join(APP_MAIN_FOLDER,'downloads/')
# # 上传文件目录
# UPLOADS_FOLDER = os.path.join(APP_MAIN_FOLDER, 'uploads/')
# 
# SQLLDR_FOLDER = os.path.join(DOWNLOAD_FOLDER,'sqlldr/')
# # SQLLDR_FOLDER = os.path.join(APP_MAIN_FOLDER,'sqlldr/')
# SQLLDR_LOG_FOLDER = os.path.join(SQLLDR_FOLDER,'log/')
# SQLLDR_BAD_FOLDER = os.path.join(SQLLDR_FOLDER,'bad/')
# SQLLDR_CONTROL_FOLDER = os.path.join(SQLLDR_FOLDER,'control/')
# SQLLDR_DATAFILE_FOLDER = os.path.join(SQLLDR_FOLDER,'datafiles/')
# SQLLDR_TEMPLATES_FOLDER = os.path.join(APP_MAIN_FOLDER, 'uploads/')