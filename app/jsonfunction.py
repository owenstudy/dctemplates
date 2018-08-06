#!/usr/bin/env python3
# -*- coding: utf-8 -*-

# @Time    : 7/28/2018 5:07 PM
# @Author  : Owen_study
# @Email   : owen_study@126.com
# @File    : jsonfunction.py
# @Software: PyCharm Community Edition
# ===============================================

class JsonOperate(object):
    def __init__(self, file_name):
        self.__file_name = file_name
        self.__file_handler = open(file_name,'w')
    # 替换json文件中某个属性的值为一个固定的值，并生成一个新的文件
    def replace_attr(self,attr_name, newvalue):
        with open(self.__file_name,'r') as f:
            filecontent = f.read()
            newfilecontent = filecontent.replace()
        pass
if __name__ == '__main__':
    pass