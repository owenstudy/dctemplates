#!/usr/bin/env python3
# -*- coding: utf-8 -*-

# @Time    : 18-1-22 下午1:58
# @Author  : Owen_study
# @Email   : owen_study@126.com
# @File    : __init__.py
# @Software: PyCharm
# ===============================================
import os, app.configure
# from flask_login import LoginManager
# from flask_openid import OpenID
# from app.configure import basedir

from flask import Flask
# 应用总的调用接口变量
appserver = Flask(__name__)
# print(__name__)
appserver.config.from_object('app.configure')

# print(appserver.config)
# 用户登录
# lm = LoginManager()
# lm.init_app(app)
# lm.login_view = 'login'
# oid = OpenID(app, os.path.join(basedir, 'tmp'))

# from flask_sqlalchemy import SQLAlchemy
# db = SQLAlchemy(app)

from app import views


if __name__ == '__main__':
    pass