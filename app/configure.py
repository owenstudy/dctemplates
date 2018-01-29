# 生成控制文件的配置说明
# file_name_upper 加载的文件名称是不是大写，默认为大写
sqlloader_configure = {"file_name_ext":"csv", "terminated_by":",", "enclosed_by":'|', "append_type":"append", "nls_lang":"AMERICAN_AMERICA.ZHS16GBK",'file_name_upper':True}

# real_data_type 生成创建中间表的控制选项, 真实的数据类型或者实际定义的数据类型,
# table_prefix 创建表时加的前缀，为了支持一些项目需要加一个表名前缀
create_table_configure = {"real_data_type": False, "table_prefix":""}

import os
BASE_DIR = os.path.abspath(os.path.dirname(__file__))
# 在外部运行时需要把APP_MAIN_FOLDER设置为AP主目录
APP_MAIN_FOLDER = BASE_DIR
SQLLDR_FOLDER = os.path.join(APP_MAIN_FOLDER,'sqlldr/')
SQLLDR_LOG_FOLDER = os.path.join(SQLLDR_FOLDER,'log/')
SQLLDR_BAD_FOLDER = os.path.join(SQLLDR_FOLDER,'bad/')
SQLLDR_CONTROL_FOLDER = os.path.join(SQLLDR_FOLDER,'control/')
SQLLDR_DATAFILE_FOLDER = os.path.join(SQLLDR_FOLDER,'datafiles/')
SQLLDR_TEMPLATES_FOLDER = os.path.join(APP_MAIN_FOLDER, 'uploads/')

# print(basedir)