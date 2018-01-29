#!/usr/bin/env python3
# -*- coding: utf-8 -*-

# @Time    : 18-1-29 下午12:10
# @Author  : Owen_study
# @Email   : owen_study@126.com
# @File    : main.py
# @Software: PyCharm
# ===============================================
import os
from app import appserver
# print(os.path.abspath(os.path.dirname(__file__)))

appserver.run(debug=True)


if __name__ == '__main__':
    pass