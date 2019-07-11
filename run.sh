# kill the current session,
# ps -aux|grep python3
ps -ef |  grep  python3 run.py | grep -v grep | awk '{print $2}' | xargs sudo kill -9
# kill the session with python3 of key words
export NLS_LANG='AMERICAN_AMERICA.AL32UTF8'
nohup python3 run.py&
