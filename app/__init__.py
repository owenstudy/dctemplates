#!/usr/bin/env python3
# -*- coding: utf-8 -*-

# @Time    : 18-1-22 下午1:58
# @Author  : Owen_study
# @Email   : owen_study@126.com
# @File    : __init__.py
# @Software: PyCharm
# ===============================================
import os
from flask_login import LoginManager
from flask_openid import OpenID
from config import basedir

from flask import Flask
# 应用总的调用接口变量
app = Flask(__name__)
app.config.from_object('config')

# 用户登录
# lm = LoginManager()
# lm.init_app(app)
# lm.login_view = 'login'
# oid = OpenID(app, os.path.join(basedir, 'tmp'))

from flask_sqlalchemy import SQLAlchemy
db = SQLAlchemy(app)

from app import views, configure

if __name__ == '__main__':
    pass