#!/usr/bin/env python3
# -*- coding: utf-8 -*-

__author__ = 'Owen_Study/owen_study@126.com'
import os, traceback
import veriscript, configure

'''把脚本生成到脚本文件中'''
# 创建的表是不是需要数据类型，默认为不需要，生成一个统计的类型长度
def generate_all_scripts(need_data_type = False):
    file_path='./uploads/'
    all_templates_file=os.listdir(file_path)
    #公共函数生成的标志
    public_function_generated=False
    # 生成一次执行的脚本合集
    # 执行所有脚本的命令文件
    file_name_exec = file_path + 'run_all_scripts.sql'
    # 输入日志
    run_all_scripts='spool run_all_scripts.log\n'
    # 公共函数和创建表脚本，生成一个文件
    scripts_create_tables=''
    # 校验脚本生成一个文件
    scripts_veri=''
    clear_sqlldr_flag=False
    for template in all_templates_file:
        try:
            file_ext=template.split('.')[len(template.split('.'))-1]
            # 文件没有扩展名
            file_name_create=file_path+template[:len(template)-len(file_ext)-1]+'_create.sql'
            file_name_veri = file_path + template[:len(template) - len(file_ext) - 1] + '_veri.sql'
            if file_ext.lower()=='xls' or file_ext.lower()=='xlsx':
                script_handler=veriscript.TemplateScript(file_path+template)
                # 清除已经存在的sqlldr执行文件，只执行一次
                if clear_sqlldr_flag is not True:
                    script_handler.clear_sqlldr_file()
                    clear_sqlldr_flag = True
                #公共函数的脚本，只生成一次
                if not public_function_generated:
                    public_function_file_name=file_path+'1-public_script.sql'
                    public_scripts=script_handler.save_public_script(public_function_file_name)
                    public_function_generated=True
                    run_all_scripts = run_all_scripts + '@' + public_function_file_name.replace(file_path,'') + '\n'
                    scripts_create_tables=scripts_create_tables+public_scripts+'\n'
                #模块的创建表和校验脚本
                create_table=script_handler.save_template_create_script(file_name_create,need_data_type)
                veri_table=script_handler.save_template_veri_script(file_name_veri)

                run_all_scripts=run_all_scripts+'@'+file_name_create.replace(file_path,'')+'\n'
                run_all_scripts = run_all_scripts + '@' + file_name_veri.replace(file_path,'') + '\n'
                # 创建表的脚本放在一个文件中
                scripts_create_tables = scripts_create_tables +'--'.rjust(20,'-')+file_name_create+'\n'
                scripts_create_tables=scripts_create_tables+create_table+'\n'

                # 校验数据的脚本放在一个文件中
                scripts_veri = scripts_veri +'--'.rjust(20,'-')+file_name_veri+'\n'
                scripts_veri=scripts_veri+veri_table+'\n'
                pass
                # 生成控制文件及执行加载的命令文件,如果配置文件没有则使用默认值
                sqlldr_config_file_name_ext = configure.sqlloader_configure.get('file_name_ext','txt')
                sqlldr_config_terminated_by= configure.sqlloader_configure.get('terminated_by',',')
                sqlldr_config_enclosed_by= configure.sqlloader_configure.get('enclosed_by','"')
                sqlldr_config_nls_lang= configure.sqlloader_configure.get('nls_lang',"AMERICAN_AMERICA.ZHS16GBK")



                script_handler.gen_control_files()
        except Exception as e:
            traceback.print_exc()
            print('file:{0},error:{1}'.format(template,str(e)))

        pass
    # 保存执行所有脚本的文件
    run_all_scripts = run_all_scripts + 'spool off' + '\n'
    # 保存创建表语句和公共语句
    scripts_create_tables='spool 00initial_scripts.log\n'+scripts_create_tables
    scripts_create_tables = scripts_create_tables+'\nspool off\n'
    script_handler.save_run_all_scripts('00initial_scripts.sql',scripts_create_tables)
    # 保存校验表的脚本
    scripts_veri='spool 01veri_scripts.log\n'+scripts_veri
    scripts_veri = scripts_veri+'\nspool off\n'
    script_handler.save_run_all_scripts('01veri_scripts.sql',scripts_veri)
    # 保存成多个文件 时的执行所有脚本的命令文件
    script_handler.save_run_all_scripts(file_name_exec,run_all_scripts)

if __name__=='__main__':
    # 默认为生成统一的数据类型
    create_table_configure = configure.create_table_configure.get('real_data_type', False)
    generate_all_scripts(need_data_type=create_table_configure)