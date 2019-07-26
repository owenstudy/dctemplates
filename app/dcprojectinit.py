#!/usr/bin/env python3
# -*- coding: utf-8 -*-

import datetime
import os
from app import configure

"""
简要说明：
1. 
<project_short> control name such as : {xxx}_ls_src
<ls_gs> control such as : {xxx}_{ls/gs}_src
<dc_user_base> control bat execute at o46g4/c1815u1/c1815u2 and tablespace datafile location
2. create work rep and exp imp and dc db user,execute in one file , it's 02_initODI.bat. 
3. output in  scirpt and log  files  .
"""


class InitDCProject:
    def __init__(self, project_short, ls_gs, dc_user_base):
        self.__str_date = datetime.datetime.now().strftime("%Y%m%d")
        self.__project_short = project_short
        self.__ls_gs = ls_gs
        self.__dc_user_base = dc_user_base

        # path1 = './downloads/'
        path1 = configure.DOWNLOAD_FOLDER
        if not os.path.exists(path1):
            os.makedirs(path1)
        # self.__00_work_rep_init_script_file = './downloads/00_work_rep_init_script.sql'
        # self.__01_before_exp_file= './downloads/01_before_exp.sql'
        # self.__02_initODI_file = './downloads/02_initODI.bat'
        # self.__03_after_imp_file = './downloads/03_after_imp.sql'

        self.__00_work_rep_init_script_file = os.path.join(path1, '00_work_rep_init_script.sql')
        self.__00_work_rep_init_script_file2 = os.path.join(path1, '00_work_rep_init_script.bat')

        self.__01_before_exp_file = os.path.join(path1, '01_before_exp.sql')
        self.__02_initODI_file = os.path.join(path1, '02_initODI.bat')
        self.__03_after_imp_file = os.path.join(path1, '03_after_imp.sql')

        # IS AND GS have different odi base
        if ls_gs.upper() == 'LS':
            exp_db = 'rep_dla'
        else:
            exp_db = 'rep_gs'
        self.__exp_db = exp_db

        # execute at work_rep_base
        self.__00_work_rep_init_script = """
                    conn dc/dc@o46g4
                    spool 00_work_rep_init_script.log
                    create user rep_{project_short}  identified by  rep_{project_short} ; 
                    grant connect,resource,create session,create view,create synonym,
                    select any table,unlimited tablespace to rep_{project_short}; 
                    grant dba to rep_{project_short};
                    spool off
                    EXIT;
  """

        self.__01_before_exp = """
                conn dc/dc@o46g4
                begin 
                begin execute immediate 'drop table snp_loc_repw_bk' ;exception when others  then null; end;
                execute immediate 'create table snp_loc_repw_bk as select * from  rep_{project_short}.snp_loc_repw' ;
                end;
                /
                drop user rep_{project_short} cascade;
                create user rep_{project_short}  identified by  rep_{project_short} ; 
                grant connect,resource,create session,create view,create synonym,
                select any table,unlimited tablespace to rep_{project_short}; 
                grant dba to rep_{project_short};   
                EXIT;"""
    # __02_initODI.format( exp_db = ,date= , project_short = ,date )
        self.__02_initODI = """ 
                sqlplus /nolog @01_before_exp.sql>01_before_exp.log
                exp {exp_db}/{exp_db}@o46g4 file={exp_db}_{date}.dmp owner={exp_db} log=exp_{exp_db}_{date}.log statistics=none
                imp rep_{project_short}/rep_{project_short}@o46g4 file={exp_db}_{date}.dmp log=imp_{exp_db}_{date}.log fromuser={exp_db} touser=rep_{project_short}
                sqlplus /nolog @03_after_imp.sql>../log/03_after_imp.log
              """

    # execute at dc_user_base
        self.__03_after_imp = """ 
            set feedback 1
            set timing on
            set autoprint on
            conn rep_{project_short}/rep_{project_short}@o46g4
            truncate table snp_loc_repw;
            insert into snp_loc_repw select * from dc.snp_loc_repw_bk;
            update snp_project a set a.project_name='{project_short}_{ls_gs}' , A.PROJECT_CODE= '{project_short}_{ls_gs}';
            commit;


            conn dc/dc@{dc_user_base}
            create tablespace tbs_{project_short} 
            datafile '/oradata/{dc_user_base}/tbs_{project_short}_01.dbf' size 50m autoextend on  ,         
            '/oradata/{dc_user_base}/tbs_{project_short}_02.dbf' size 50m autoextend on    ;
            
            create user  {project_short}_{ls_gs}_src  identified by  {project_short}_{ls_gs}_src default tablespace tbs_{project_short}  ;  
            grant connect,resource,create session,create view,create synonym,
            select any table,unlimited tablespace to {project_short}_{ls_gs}_src ; 
            grant dba to {project_short}_{ls_gs}_src;  
            
            create user  {project_short}_{ls_gs}_tar  identified by  {project_short}_{ls_gs}_tar default tablespace tbs_{project_short}  ;  
            grant connect,resource,create session,create view,create synonym,
            select any table,unlimited tablespace to {project_short}_{ls_gs}_tar ; 
            grant dba to {project_short}_{ls_gs}_tar; 
            
            create user  {project_short}_{ls_gs}_src_trial  identified by  {project_short}_{ls_gs}_src_trial default tablespace tbs_{project_short}  ;  
            grant connect,resource,create session,create view,create synonym,
            select any table,unlimited tablespace to {project_short}_{ls_gs}_src_trial ; 
            grant dba to {project_short}_{ls_gs}_src_trial;
            EXIT;
 """


    # 1.1 保存到 00_work_rep_init_script.sql
    def save_00_work_rep_init_script(self):
        f = open(self.__00_work_rep_init_script_file, 'w+')
        f.write(self.__00_work_rep_init_script.format(project_short=self.__project_short))
        f.close()


    def save_00_work_rep_init_script_bat(self):
        f = open(self.__00_work_rep_init_script_file2, 'w+')
        f.write("sqlplus /nolog @00_work_rep_init_script.sql")
        f.close()


    # 1.2 保存到 01_before_exp.sql
    def save_01_before_exp(self):
        f = open(self.__01_before_exp_file, 'w+')
        f.write(self.__01_before_exp.format(project_short=self.__project_short))
        f.close()


    # 1.3 保存到 02_initODI_file.sql
    def save_02_initODI(self):
        f = open(self.__02_initODI_file, 'w+')
        f.write(self.__02_initODI.format(exp_db=self.__exp_db, date=self.__str_date, project_short=self.__project_short))
        f.close()


    # 1.4 保存到 03_after_imp_file.sql
    def save_03_after_imp(self):
        f = open(self.__03_after_imp_file, 'w+')
        f.write(self.__03_after_imp.format(project_short=self.__project_short, dc_user_base=self.__dc_user_base,
                                           ls_gs=self.__ls_gs))
        f.close()


    # run for all script 2019.7.25
    def gen_all_script(self):
        self.save_00_work_rep_init_script()
        self.save_00_work_rep_init_script_bat()

        self.save_01_before_exp()
        self.save_02_initODI()
        self.save_03_after_imp()
        return True
if __name__ == '__main__':
    project_short = ''
    work_rep_base = ''
    dc_user_base = ''
    ls_gs = ''
    # Test
    init_odi = InitDCProject('DLA0724', 'LS', 'o46g4')
    init_odi.gen_all_script()
    # init_odi.save_00_work_rep_init_script()
    # init_odi.save_01_before_exp()
    # init_odi.save_02_initODI()
    # init_odi.save_03_after_imp()
    #
