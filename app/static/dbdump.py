#!D:\E\Anaconda\python
# -*- coding: utf-8 -*-

import configure


class DbDump:
    """
       简要说明：
       输入参数：
        connectstring : eg,c1815u1
        src_user_name : eg,dla_ls_src
       输出文档：
       before_dbdump.sql
       after_dbdump.sql
       dbdump.bat
       """

    def __init__(self, connectstring, src_user_name):
        self.connectstring = connectstring
        self.src_user_name = src_user_name
        # self.dbdump_folder = configure.DBDUMP_FOLDER

        self.__before_dbdump_script_file = configure.DBDUMP_FOLDER + 'before_dbdump.sql'
        self.__dbdump_script_file = configure.DBDUMP_FOLDER + 'dbdump.bat'
        self.__after_dbdump_script_file = configure.DBDUMP_FOLDER + 'after_dbdump.sql'

    # execute at dc stage db server {connectstring}
        self.__before_dbdump_script = """
conn {src_user_name}/{src_user_name}@{connectstring}

begin 
 for i_sql in (select 'drop  '||a.OBJECT_TYPE||' '||a.OBJECT_NAME as drop_obj  from user_objects a) 
   loop
     begin
        begin execute immediate i_sql.drop_obj; exception when others then null; end;
     end;
   end loop;
end;
/


disconnect
exit;
  """

        self.__dbdump_script = """
sqlplus /nolog @before_dbdump.sql >before_dbdump.log
imp {src_user_name}/{src_user_name}@{connectstring} file=XXX.dmp fromuser=XXX(dlautf) touser={src_user_name} log= dbdump.log ignore=Y GRANTS=N STATISTICS=NONE
sqlplus /nolog @after_dbdump.sql >after_dbdump.log
  """

    # __02_initODI.format( exp_db = ,date= , project_short = ,date )
        self.__after_dbdump_script = """ 
conn {src_user_name}/{src_user_name}@{connectstring}
declare 
  i number(10);
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
        f = open(self.__before_dbdump_script_file, 'w+')
        f.write(self.__before_dbdump_script.format(connectstring=self.connectstring, src_user_name=self.src_user_name))
        f.close()


# 2 保存到 dbdump.bat
    def save_dbdump_script(self):
        f = open(self.__dbdump_script_file, 'w+')
        f.write(self.__dbdump_script.format(connectstring=self.connectstring, src_user_name=self.src_user_name))
        f.close()


# 3 保存到 after_dbdump.sql
    def save_after_dbdump_script(self):
        f = open(self.__after_dbdump_script_file, 'w+')
        f.write(self.__after_dbdump_script.format(connectstring=self.connectstring, src_user_name=self.src_user_name))
        f.close()


    def gen_class_all_script(self):
        self.save_before_dbdump_script()
        self.save_dbdump_script()
        self.save_after_dbdump_script()


if __name__ == '__main__':
    # Test
    connectstring = configure.script_dbdump_generate['connectstring']
    src_user_name = configure.script_dbdump_generate['src_user_name']
    dc_import_dbdump = DbDump(connectstring,src_user_name)
    dc_import_dbdump.gen_class_all_script()
