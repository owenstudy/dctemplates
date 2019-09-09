#!D:\E\Anaconda\python
# -*- coding: utf-8 -*-

import configure

class DbDump:
       """
       简要说明：
       输入参数：
        project_data_server : eg,c1815u1
        project_SRC : eg,dla_ls_src
       输出文档：
       before_dbdump.sql
       after_dbdump.sql
       dbdump.bat
       """
       def __init__(self,project_data_server,project_SRC):

              self.project_data_server = project_data_server
              self.project_SRC = project_SRC

              self.__before_dbdump_script_file = '../DBDump/before_dbdump.sql'
              self.__dbdump_script_file = '../DBDump/dbdump.bat'
              self.__after_dbdump_script_file= '../DBDump/after_dbdump.sql'

              # execute at dc stage db server {project_data_server}
              self.__before_dbdump_script = """
conn dc/dc@{project_data_server}
declare v_sql varchar2(4000);
begin 
 execute immediate ' alter user {project_SRC} account lock ';
 for i_session in (SELECT A.SID||','||A.SERIAL# AS session_id  FROM V$SESSION A WHERE USERNAME='{project_SRC}') 
   loop
     begin
        v_sql :=  'alter system kill session '''|| i_session.session_id||'''' ;
        execute immediate v_sql;
     end;
   end loop;
end;
/
drop user {project_SRC} cascade;
create user  {project_SRC}  identified by  {project_SRC}  default tablespace tbs_DLA  ; 
grant connect,resource,create session,create view,CREATE SYNONYM,insert any table,
 SELECT ANY TABLE,UNLIMITED TABLESPACE to {project_SRC}; 
grant dba to {project_SRC}; 
alter user {project_SRC} account unlock ;
disconnect
exit;
  """


              self.__dbdump_script = """
sqlplus /nolog @before_dbdump.sql >before_dbdump.log
imp {project_SRC}/{project_SRC}@{project_data_server} file=D:\ODI_Script\dbdump\XXX.dmp fromuser=XXX(dlautf) touser={project_SRC} log= D:\ODI_Script\dbdump\dbdump.log ignore=Y
sqlplus /nolog @after_dbdump.sql >after_dbdump.log
  """

  
#__02_initODI.format( exp_db = ,date= , project_short = ,date )
              self.__after_dbdump_script = """ 
conn {project_SRC}/{project_SRC}@{project_data_server}

begin
  select count(1)
    into i
    from user_tables a
   where substr(a.table_name, 1, 3) <> 'DM_';
  
  /*这个时点环境里的表必须都是"DM_"开头的，否则就报错停下*/
  if i > 0 then  
    raise_application_error(-20192,'there is table not beginning with "DM_", please check'); 
  end if;
  
  for i_sql in (select 'alter table  ' || a.table_name || ' rename to dmp_' || substr(a.table_name,4) as r_sql
                  from user_tables a
                 where substr(a.table_name,1,3) = 'DM_')
  loop
    execute immediate i_sql.r_sql;
  end loop;  
  
end;
/

exit;

              """

          

       # 1 保存到 before_dbdump.sql
       def save_before_dbdump_script(self):
              f = open(self.__before_dbdump_script_file,'w+')
              f.write(self.__before_dbdump_script.format(project_data_server = self.project_data_server,project_SRC =self.project_SRC))
              f.close()
	   # 2 保存到 dbdump.bat
       def save_dbdump_script(self):
              f = open(self.__dbdump_script_file,'w+')
              f.write(self.__dbdump_script.format(project_data_server = self.project_data_server,project_SRC =self.project_SRC))
              f.close()
       # 3 保存到 after_dbdump.sql
       def save_after_dbdump_script(self):
              f = open(self.__after_dbdump_script_file,'w+')
              f.write(self.__after_dbdump_script.format(project_data_server = self.project_data_server,project_SRC =self.project_SRC))
              f.close()

       def gen_class_all_script(self):
              self.save_before_dbdump_script()
              self.save_dbdump_script()
              self.save_after_dbdump_script()


if __name__=='__main__':
       # Test
       project_data_server = configure.script_dbdump_generate['project_data_server']
       project_SRC = configure.script_dbdump_generate['project_src']
       dc_import_dbdump = DbDump('c1815u1','dla_ls_src')
       dc_import_dbdump.gen_class_all_script()
