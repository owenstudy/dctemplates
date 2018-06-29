#!/usr/bin/env python3
# -*- coding: utf-8 -*-

# @Time    : 6/27/2018 9:58 AM
# @Author  : Owen_study
# @Email   : owen_study@126.com
# @File    : gsproductschema.py
# @Software: PyCharm Community Edition
# ===============================================

import json
#定义一个dict对象，并有些value还是以json的形式出现，形式如下
# adict={"xiaoqiangk":"xiaoqiangv","xiaofeik":"xiaofeiv","xiaofeis":{"xiaofeifk":"xiaofeifv","xiaofeimk":{"xiaoqik":"xiaoqiv","xiaogou":{"xiaolei":"xiaolei"}}},"xiaoer":{"xiaoyuk":"xiaoyuv"}}
#定义一个函数，用来处理json，传入json1对象，层深初始为0，对其进行遍历
def hJson(json1,i=0):
    #判断传入的是否是json对象，不是json对象就返回异常
    if(isinstance(json1,dict)or isinstance(json1,list)):
        #遍历json1对象里边的每个元素
        for item in json1:
            #如果item对应的value还是json对象，就调用这个函数进行递归，并且层深i加1，如果不是，直接z在else处进行打印
            if (isinstance(json1[item],dict) or isinstance(json1[item],list)):
                #打印item和其对应的value
                print("****"*i+"%s : %s"%(item,json1[item]))
                #调用函数进行递归，i加1
                hJson(json1[item],i=i+1)
            else:
                #打印
                print("****"*i+"%s : %s"%(item,json1[item]))
    #程序入口，对adict进行处理，第二个参数可以不传
    else:
        print("{0}\n  is not josn object!".format(json1))
if __name__ == '__main__':
    jsonfile = open('jsontest.json','r')
    adict = json.load(jsonfile)
    hJson(adict)
    pass