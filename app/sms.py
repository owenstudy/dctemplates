#!/usr/bin/env python3
# -*- coding: utf-8 -*-

# @Time    : 17-12-8 下午9:38
# @Author  : Owen_study
# @Email   : owen_study@126.com
# @File    : sms.py
# @Software: PyCharm
# ===============================================

import requests, json
import sys

# sms发送的配置信息
sms_auth = {"apikey":""}
'''发送SMS信息'''
def sms_send(mobile, message):
    apikey = sms_auth.get("apikey")
    resp = requests.post("http://sms-api.luosimao.com/v1/send.json", \
                         auth=("api",apikey),\
                         data={"mobile":mobile, "message":message+"【水果尝尝鲜】"}, timeout=3)
    result =resp.content
    print(result)

if __name__ == '__main__':
    mobile= sys.argv[1]
    message = sys.argv[2]
    # mobile = "13166366407,13764850780"
    # message = "ODI 群发测试"
    print(mobile)
    print(message)
    # 外部调用方法
    # python sms.py 13166366407 "ODI SUCCESS"
    for eachmobile in mobile.split(','):
        sms_send(int(eachmobile),message)
    # sms_send(13166366407, "ODI调用成功测试")
    pass