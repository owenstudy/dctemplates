#!D:\E\Anaconda\python
import cx_Oracle
import pandas as pd
import configure
class DcReportsGenerate:
    def __init__(self,dbstring,io_sql_result):
        self.__exp2 = []
        self.dbstring = dbstring
        self.io_sql_result = io_sql_result
    def db_con(self):
        return cx_Oracle.connect(self.dbstring)
    #遍历excel里面的sql
    def queryout_sql(self):
        db = self.db_con()
        sheet_sql = pd.read_excel(self.io_sql_result,'SQL')
        sheet_OverAll = pd.read_excel(self.io_sql_result,'OverAll')
        sql_df = pd.DataFrame(sheet_sql)

        with pd.ExcelWriter(self.io_sql_result) as writer:
            sheet_sql.to_excel(writer,'SQL')
            sheet_OverAll.to_excel(writer,'OverAll')
            for index,sql_row in sql_df.iterrows():
                topic,sheet_name,sql_desc = sql_row
                self.exe_sql(sql_desc,sheet_name,writer,db)
            rs = pd.DataFrame(self.__exp2, columns=['sql', 'error'])
            rs.to_excel(writer, sheet_name='Error_sql', header=1)
        writer.save()
        writer.close()
        db.close()
    #执行sql,捕获sql报错
    def exe_sql(self,sql,sheet,writer,db):
        cr = db.cursor()
        exp=[]
        try:
            cr.execute(sql)
            title1= [i[0] for i in cr.description]
            rs=pd.DataFrame(cr.fetchall(),columns = title1)
            rs.to_excel(writer,sheet,header=1)
        except Exception as e:
            # print("errorSql='%s' \nerrorMsg = %s"%(sql,str(e)))
            exp.append(sql)
            exp.append(str(e))
            self.__exp2.append(exp)

if __name__=='__main__':
    dbstring =  configure.script_dc_report_generate['dbstring']
    io_sql_result = configure.script_dc_report_generate['io_sql_result']
    dc1 = DcReportsGenerate(dbstring,io_sql_result)
    dc1.queryout_sql()