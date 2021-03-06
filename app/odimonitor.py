#!/usr/bin/env python3
# -*- coding: utf-8 -*-

# @Time    : 9/13/2019 12:15 PM
# @Author  : Owen_study
# @Email   : owen_study@126.com
# @File    : odimonitor.py
# @Software: PyCharm Community Edition
# ===============================================
# 监控ODI执行的情况并发送sms
from app import oracleconn,sms
import time,ftplib,paramiko, os

class ODIMonitor(object):
    def __init__(self,user_name, userpwd, connectstring):
        self.__user_name = user_name
        self.__user_pwd =userpwd
        self.__connect_string = connectstring
        # oracle连接串
        self.conn = oracleconn.oracleconn(user_name,userpwd,connectstring);
        # 公共执行的cursor
        self.cursor = self.conn.cursor()
        #退出标志
        self.__ODI_finish=False
        # SMS 发送标志
        self.__SMS_SEND = True
        # 只运行一次nextval 语句的标志
        self.__sequence_run_flag = False

    # 监控指定的表数据量以测试ODI是不是还在运行，主要是监控大表的运行
    # 返回指定表的总数据量以发送短信通知
    def monitor_ilp_trans(self):
        sql_list = {'FUND_TRANS_APPLY':'select count(*) from t_fund_trans_apply','FUND_TRANS':'select count(*) from t_fund_trans','SEQUENCE_TRANS':'SELECT s_fund_trans__trans_id.nextval FROM dual'}
        # sql_list = {'FUND_TRANS_APPLY':'select count(*) from DM_CONTRACT_PRODUCT','FUND_TRANS':'select count(*) from S_DM_ADDRESS','SEQUENCE_TRANS':'SELECT s_fund_trans__trans_id.nextval FROM dual'}
        sql_result ={}
        # # 执行一次确保之后的currval能够查询出来
        # if self.__sequence_run_flag is False:
        #     self.cursor.execute('SELECT s_fund_trans__trans_id.nextval FROM dual')
        #     self.__sequence_run_flag = True

        for sql in sql_list:
            run_sql = sql_list[sql]
            self.cursor.execute(run_sql)
            each_sql_result = self.cursor.fetchall()
            all_scripts = ''
            for result in each_sql_result:
                first_column = result[0]
            sql_result[sql]=first_column

        # 增加时间说明
        sql_result['Time']=self.get_curr_time_str()
        # 判断退出，如果sequence的值》2.亿 说明已经结束
        if sql_result['SEQUENCE_TRANS'] >200000000:
            self.__ODI_finish=True
        return sql_result
    # 检查trigger的状态
    def monitor_disabled_trigger(self):
        sql_list = {'TRIGGER_DISABLE_DTL':"SELECT OWNER,count(*) check_time FROM all_triggers a where status<>'ENABLED' group by a.OWNER"}
        sql_list_cnt = {'TRIGGER_CNT':"SELECT count(*) check_time FROM all_triggers a where status<>'ENABLED' "}
        sql_result ={}

        for sql in sql_list_cnt:
            run_sql = sql_list_cnt[sql]
            self.cursor.execute(run_sql)
            each_sql_result = self.cursor.fetchall()
            all_scripts = ''
            for result in each_sql_result:
                check_result = result[0]
            sql_result[sql]=check_result
        # 各个owner 用户的trigger disable数量汇总
        for sql in sql_list:
            run_sql = sql_list[sql]
            self.cursor.execute(run_sql)
            each_sql_result = self.cursor.fetchall()
            sql_result[sql]=each_sql_result
        # 增加时间说明
        sql_result['Time']=self.get_curr_time_str()
        # 如果有disable 的trigger则记录保存日志并发短信确认
        if sql_result['TRIGGER_CNT'] >0:
            self.__SMS_SEND = True
        else:
            self.__SMS_SEND = False
        return sql_result

    # 字符串对象，用于打印目的
    def get_curr_time_str(self):
        currtime = time.strftime('%Y-%m-%d %H:%M:%S', time.localtime(time.time()))
        return currtime

    # 持续执行进行循环,按秒进行间隔监控
    def monitor_odi(self, mobile_list, interval = 3600):
        while(True):
            sql_result= self.monitor_ilp_trans()
            # 发送短信
            self.send_sms(mobile_list,str(sql_result))
            print(sql_result)
            time.sleep(interval)
            if self.__ODI_finish is True:
                break
    def monitor_trigger(self, mobile_list, interval = 3600):
        while(True):
            sql_result= self.monitor_disabled_trigger()
            time.sleep(interval)
            if self.__SMS_SEND is True:
                # 发送短信
                print(sql_result)
                # self.send_sms(mobile_list,str(sql_result))
                self.__SMS_SEND=False

    # 监控批处理的运行，如果运行超过固定的时间则发短信进行提醒 TODO
    # max_batch_duration 多长时间监控一次并发送消息，单位分钟
    def monitor_first_run_batch(self, max_batch_duration, mobile_list):
        while(True):
            # 获取当前执行的batch状态
            sql_result= self.get_executing_batch_time()
            if sql_result ==0:
                time.sleep(60)
                continue
            if sql_result['run_minutes']>max_batch_duration:
                # 发送短信
                self.send_sms(mobile_list,str(sql_result))
                print(sql_result)
                time.sleep(max_batch_duration)
                # 如果没有正在运行的batch则终止监控
                if len(sql_result) ==0:
                    break
        pass
    # 获取当前运行的batch的时间和相关信息
    def get_executing_batch_time(self):
        pass
        # sql_list = {"""
        # Select a.job_id,b.job_name,(sysdate- a.start_time)*24*60 as run_minutes ,a.process_date,c.status_name,a.run_id,a.start_time
        #     From T_batch_job_run a, t_batch_job b, t_batch_job_status c
        #     Where a.status=c.status_id and c. status_id=222
        #     And a.job_id=b.job_id order by c.status_name,a.run_id desc
        # """}
        run_sql = """
        Select a.job_id,b.job_name,round((sysdate- a.start_time)*24*60,0) as run_minutes ,a.process_date,c.status_name,a.run_id,a.start_time
            From T_batch_job_run a, t_batch_job b, t_batch_job_status c
            Where a.status=c.status_id and c.status_id=222
            And a.job_id=b.job_id order by c.status_name,a.run_id desc
        """
        sql_result ={}

        self.cursor.execute(run_sql)
        each_sql_result = self.cursor.fetchall()
        all_scripts = ''
        if len(each_sql_result) ==0:
            return 0
        for result in each_sql_result:
            sql_result['job_id'] = result[0]
            sql_result['job_name'] = result[1]
            sql_result['run_minutes'] = result[2]
            sql_result['process_date'] = result[3]
            sql_result['status_name'] = result[4]
            sql_result['run_id'] = result[5]
            sql_result['start_time'] = result[6]


        # 增加时间说明
        sql_result['Time']=self.get_curr_time_str()
        return sql_result

    # 发送短信，输入手机号码，以，分隔的多个手机号码
    def send_sms(self, mobile_list,message):
        for mobile in mobile_list.split(','):
            sms.sms_send(mobile,message)

class FTPMonitor(object):
    def __init__(self, host, username, password):
        self.__ftp = ftplib.FTP(host)  # 实例化FTP对象
        # self.__ftp.login(username, password)  # 登录
        self.__host = host
        self.__username = username
        self.__pasword = password

    # 文件传送
    def ftp_download(self):
        '''以二进制形式下载文件'''
        file_remote = '1.txt'
        file_local = '/mma_sftp/DC_DUMP/Sep/exp_ebao_uat_dm20190914.log'
        bufsize = 1024  # 设置缓冲器大小
        fp = open(file_local, 'wb')
        self.__ftp.retrbinary('RETR %s' % file_remote, fp.write, bufsize)
        fp.close()
    def ftp_upload(self):
        '''以二进制形式上传文件'''
        file_remote = 'exp_ebao_uat_dm20190914.log'
        file_local = 'D:\\exp_ebao_uat_dm20190914.log'
        bufsize = 1024  # 设置缓冲器大小
        fp = open(file_local, 'rb')
        self.__ftp.storbinary('STOR ' + file_remote, fp, bufsize)
        fp.close()
    # sftp 传送格式，下载
    def sftp_download(self, from_filename, to_filepath):
        # host = self.__host # sftp ip
        # port = 22  # sftp端口
        # username = self.__username  # sftp用户名
        # password = self.__pasword  # sftp密码
        # # local = 'D:\\exp_ebao_uat_dm20190914.log'  # 存储路径
        # remote = '/mma_sftp/DC_DUMP/Sep/exp_ebao_uat_dm20190914.log'  # 目标文件所在路径

        remote = from_filename
        file_name_only = from_filename.split('/')[-1]
        local = os.path.join(to_filepath,file_name_only)
        self.__sftp_server = paramiko.Transport((self.__host, 22))
        self.__sftp_server.connect(username=self.__username, password=self.__pasword)
        self.sftp = paramiko.SFTPClient.from_transport(self.__sftp_server)
        # sf = paramiko.Transport((host, port))
        # sf.connect(username=username, password=password)
        # sftp = paramiko.SFTPClient.from_transport(self.__sftp_server)
        if os.path.isdir(local):  # 判断本地参数是目录还是文件
            for f in self.sftp.listdir(remote):  # 遍历远程目录
                self.sftp.get(os.path.join(remote + f), os.path.join(local + f))  # 下载目录中文件
                self.__sftp_server.close()
        else:
            self.sftp.get(remote, local)  # 下载文件
            self.__sftp_server.close()
    # sftp upload, 默认只需要传入上传的路径和文件名称，上传只需要传入路径就可以了
    def sftp_upload(self, local_file_name, remote_path):

        self.__sftp_server = paramiko.Transport((self.__host, 22))
        self.__sftp_server.connect(username=self.__username, password=self.__pasword)
        self.sftp = paramiko.SFTPClient.from_transport(self.__sftp_server)

        file_name_only = local_file_name.split('\\')[-1]
        remot_file = os.path.join(remote_path,file_name_only)
        # 上传文件
        self.sftp.put(localpath=local_file_name, remotepath= remot_file)  # 下载文件
        self.__sftp_server.close()

if __name__ == '__main__':
    # monitor = ODIMonitor('mma_tar','mma_tar','172.16.7.189:1524/c189u1')
    # monitor = ODIMonitor('MMA_LS_TAR','MMA_LS_TAR','172.25.18.15:1521/c1815u1')
    # monitor.monitor_trigger('13166366407',5)
    # 监控UT5,DM1,2,3,4,5,6各个环境的trigger
    monitor = ODIMonitor('mma_ls_stage', 'mma_ls_stage', 'nlsut2_db.mmatst.net/NLSUT2.mmatst.net')
    monitor.monitor_trigger('13166366407',5)
    # 监控NLS各个环境的trigger
    monitor = ODIMonitor('org', 'nls_ORG2020', 'ora02-scan.hkgsite.com/nls.hkgsite.com')
    monitor.monitor_trigger('13166366407',5)

    # 测试batch monitor
    # monitor.get_executing_batch_time()
    # monitor.monitor_first_run_batch(5,'1316636647')
    # monitor.monitor_first_run_batch(3600,'13166366407')
    # monitor.monitor_odi('13166366407,13764850780',3600)
    # result = monitor.monitor_ilp_trans()
    # print(result)
    # ftpmonitor = FTPMonitor('ftp.ebaotech.com','mma_sftp','Og0MQzvY')
    # # ftpmonitor.sftp_download(from_filename='/mma_sftp/DC_DUMP/Sep/exp_ebao_uat_dm20190914.log', to_filepath='D:\\')
    # ftpmonitor.sftp_upload(local_file_name='D:\\exp_ebao_uat_dm20190914_test.log',remote_path='/mma_sftp/DC_DUMP/Sep/')
    pass