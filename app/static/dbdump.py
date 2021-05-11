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
    # 20201201 updated by leo , baseline Version, support S_DM_ and DM_ table
        self.__after_dbdump_script = """ 
conn {src_user_name}/{src_user_name}@{connectstring}
DECLARE
  I NUMBER(10);
  J NUMBER(10);
BEGIN
  SELECT COUNT(1)
    INTO I
    FROM USER_TABLES A
   WHERE SUBSTR(A.TABLE_NAME, 1, 5) <> 'S_DM_'
      AND SUBSTR(A.TABLE_NAME, 1, 3) <> 'DM_';

  /*这个时点如果环境里存在非"DM_" or "S_DM_"开头的表，就报错停下*/
  IF I > 0 THEN
    RAISE_APPLICATION_ERROR(-20192,
                            'existing table not begin with "DM_" or "S_DM_", please check');
  END IF;

  SELECT COUNT(1)
    INTO I
    FROM USER_TABLES A
   WHERE SUBSTR(A.TABLE_NAME, 1, 5) = 'S_DM_';

  SELECT COUNT(1)
    INTO J
    FROM USER_TABLES A
   WHERE SUBSTR(A.TABLE_NAME, 1, 3) = 'DM_';

  IF I > 0 AND J > 0 THEN
    RAISE_APPLICATION_ERROR(-20193,
                            'existing both "DM_" and "S_DM_" tables, please check');
  
  ELSIF I > 0 THEN
  
    FOR I_SQL IN (SELECT 'alter table  ' || A.TABLE_NAME ||
                         ' rename to dmp_' || SUBSTR(A.TABLE_NAME, 6) AS R_SQL
                    FROM USER_TABLES A
                   WHERE SUBSTR(A.TABLE_NAME, 1, 5) = 'S_DM_') LOOP
      EXECUTE IMMEDIATE I_SQL.R_SQL;
    END LOOP;
  
  ELSIF J > 0 THEN
  
    FOR I_SQL IN (SELECT 'alter table  ' || A.TABLE_NAME ||
                         ' rename to dmp_' || SUBSTR(A.TABLE_NAME, 4) AS R_SQL
                    FROM USER_TABLES A
                   WHERE SUBSTR(A.TABLE_NAME, 1, 3) = 'DM_') LOOP
      EXECUTE IMMEDIATE I_SQL.R_SQL;
    END LOOP;
  
  END IF;
END;
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
