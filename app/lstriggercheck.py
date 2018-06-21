#!/usr/bin/env python3
# -*- coding: utf-8 -*-

# @Time    : 6/21/2018 10:14 AM
# @Author  : Owen_study
# @Email   : owen_study@126.com
# @File    : lstriggercheck.py
# @Software: PyCharm Community Edition
# ===============================================

from app import oracleconn
import  os
from app import configure

"""
从系统中的trigger来生成一个存储过程，检查迁移数据是否符合系统TRIGGER的校验规则
校验的结果保存在dc_trigger_check

"""

class TriggerCheck(object):
    def __init__(self,user_name, userpwd, connectstring,tablelist):
        self.__user_name = user_name
        self.__user_pwd =userpwd
        self.__connect_string = connectstring
        self.__table_list = tablelist
        # oracle连接串
        self.conn = oracleconn.oracleconn(user_name,userpwd,connectstring);
        # 公共执行的cursor
        self.cursor = self.conn.cursor()
        sqlfilename = os.path.join(configure.DOWNLOAD_FOLDER,'04TriggerCheck.sql')
        self.__logfile_name = '04TriggerCheck.log'
        self.sqlfilehandler = open(sqlfilename,'w')
        # 执行trigger的脚本列表，每生成一次增加一个，最后汇总生成一个执行脚本
        self.__exec_script_list = []
    # 把生成的脚本保存到文件
    def save_script_to_file(self):
        # 写入初始化脚本
        createtablesql = self.create_veri_result_table()
        # 文件头信息
        self.sqlfilehandler.write(self.sql_file_header(self.__logfile_name))
        # 创建表信息
        self.sqlfilehandler.write(createtablesql+'\n')
        # TRIGGER脚本
        trigger_scripts = self.gen_trigger_alltables()
        self.sqlfilehandler.write(trigger_scripts+'\n')
        # 执行过程的脚本
        exec_scripts = self.exec_procedure_script()
        self.sqlfilehandler.write(exec_scripts+'\n')
        # 末尾脚本
        self.sqlfilehandler.write(self.sql_file_foot())
        # 写入完成
        self.sqlfilehandler.close()
    '''生成执行过程的脚本'''
    def exec_procedure_script(self):
        script = ''
        for proc in self.__exec_script_list:
            script = script + 'execute {0} ;\n'.format(proc)
        return script
    '''创建校验数据的结果表'''
    def create_veri_result_table(self):
        create_table_script="""
        drop table dc_trigger_check;
        create table dc_trigger_check(table_name varchar2(100),trigger_name varchar2(100),pk_id number(10),policy_id  number(10),
        error_msg  varchar2(1000),processdate  date);
        """
        return  create_table_script

    '''创建生成文件的一些头信息'''
    def sql_file_header(self, logfile_name):
        header_script = """
        spool {logfile_name}
        set define off
        set timing on
        select to_char(sysdate,'YYYY/MM/DD HH:MI:SS') from dual;
        """
        header_script = header_script.format(logfile_name= logfile_name)

        return header_script
    def sql_file_foot(self):
        foot_script = """
        select to_char(sysdate,'YYYY/MM/DD HH:MI:SS') from dual;
        spool off
        """
        return foot_script

    # 对所有的表生成TRIGGER的检查脚本
    def gen_trigger_alltables(self):
        all_scripts = ''
        for table_name in self.__table_list:
            table_trigger_scripts = self.gen_trigger_bytable(table_name)
            all_scripts = all_scripts + table_trigger_scripts + '\n'
            pass
        return all_scripts
    # 检查一张表的所有TRIGGER并生成脚本返回
    def gen_trigger_bytable(self, table_name):
        sql = "select trigger_name from user_triggers a where a.table_name='{table_name}'".format(table_name=table_name)
        self.cursor.execute(sql)
        all_triggers = self.cursor.fetchall()
        all_scripts = ''
        for each_trigger in all_triggers:
            trigger_name = each_trigger[0]
            trigger_script = self.gen_trigger_bytrigger(trigger_name,table_name)
            all_scripts = all_scripts + trigger_script+'\n'
        return all_scripts
        pass
    # 生成一个指定TRIGGER的检查脚本
    def gen_trigger_bytrigger(self, trigger_name, table_name):
        sql = "select line,text from user_source a where a.TYPE='TRIGGER' AND A.name='{trigger_name}' order by a.line".format(trigger_name=trigger_name);
        self.cursor.execute(sql)
        all_scripts = self.cursor.fetchall()
        # 所有的脚本进行处理
        # 生成存储过程的头部
        procedure_name = 'p_'+trigger_name[4:]
        # 保存到列表中
        self.__exec_script_list.append(procedure_name)
        local_variable = ''
        trigger_body = ''
        #  trigger变量声明开始标志
        local_variable_start = False
        trigger_body_start = False
        # trigger的最后一行的行数
        last_line = self.get_last_line(trigger_name)
        for each_line in all_scripts:
            each_script = each_line[1]
            curr_line = each_line[0]
            # 找到trigger的变量声明部分，以declare开头，begin结束之间的脚本
            # 生成TRIGGER的检查逻辑，到最后一行
            if trigger_body_start is True:
                trigger_body = trigger_body + each_script
            # 变量声明结束标志
            if str.find(str.upper(each_script),'BEGIN')>=0:
                local_variable_start = False
                trigger_body_start = True
            # 生成TRIGGER中声明的变量
            if local_variable_start is True:
                local_variable = local_variable + each_script
            # 变量声明开始部分
            if str.find(str.upper(each_script),'DECLARE')>=0:
                local_variable_start = True
            # 找到trigger的校验体,begin之后到最后一行
            pass
            # 删除TRIGGER中的最后一行数据
            if curr_line == last_line and trigger_body_start is True:
                trigger_body = trigger_body[0:len(trigger_body)-len(each_script)-1]
                break
        # 规则trigger中的:NEW, :OLD
        trigger_body = trigger_body.replace(':NEW', 'v_data')
        trigger_body = trigger_body.replace(':new', 'v_data')
        trigger_body = trigger_body.replace(':OLD', 'v_data')
        trigger_body = trigger_body.replace(':old', 'v_data')
        # 脚本的框架结构，再替换一些关键变量
        scripts = self.get_procedure_stru(procedure_name, table_name, trigger_name,local_variable,trigger_body)
        return scripts
        pass
    # 判断trigger最后的语句行数
    def get_last_line(self, trigger_name):
        sql = "select line,text from user_source a where a.TYPE='TRIGGER' AND A.name='{trigger_name}' order by a.line desc".format(trigger_name=trigger_name);
        self.cursor.execute(sql)
        all_scripts = self.cursor.fetchall()
        for each_script in all_scripts:
            script = each_script[1]
            if str.find(script.upper(), 'END')>=0:
                return each_script[0]
            pass

    def get_procedure_stru(self,procedure_name, table_name, trigger_name,local_variable, trigger_body):
        scripts = """
        create or replace procedure {p_name} is 
            cursor c_data is select * from {table_name};
             v_error varchar2(4000);
             -- local variables here
             {local_variable}
        begin
           for v_data in c_data loop
              begin
                    {trigger_body}
              exception
              when others then
                  v_error:=sqlerrm;
                  insert into dc_trigger_check (table_name,trigger_name,pk_id,error_msg,processdate) values('{table_name}','{trigger_name}', v_data.{pk_name}, v_error, sysdate);
                  commit;
              end;
           end loop;
        end;\n
        /\n
        """
        pk_name = self.get_pk_column(table_name)
        scripts = scripts.format(p_name =procedure_name, table_name = table_name, trigger_name = trigger_name,local_variable=local_variable,trigger_body=trigger_body, pk_name=pk_name)
        return scripts
    # 获取表的语句名称
    def get_pk_column(self,tablename):
        pksql = "select b.column_name from user_constraints a , user_cons_columns b where a.constraint_name=b.constraint_name and a.constraint_type='P' and a.table_name='{0}'".format(tablename.upper())

        self.cursor.execute(pksql)
        # 只处理PK值有一个的情况
        pk_columnname = self.cursor.fetchone()[0]
        # print(pk_columnname)
        return pk_columnname

if __name__ == '__main__':
    triggercheck = TriggerCheck('ual_tar', 'ual_tar','172.16.28.46:1523/o46g4',['T_CONTRACT_PRODUCT','T_CONTRACT_MASTER','T_CONTRACT_EXTEND'])
    triggercheck.get_last_line('TRI_CONTRACT_PRODUCT__BIU_CHK')
    triggercheck.save_script_to_file()
    triggercheck.gen_trigger_bytable('T_CONTRACT_PRODUCT')
    triggercheck.gen_trigger_bytrigger('TRI_CONTRACT_PRODUCT__BIU_CHK','T_CONTRACT_PRODUCT')
    pass