import os
import shutil
# 把JSON数据放在对象中
class JSONObject:
    def __init__(self, d):
        self.__dict__ = d
# 清除文件夹中的所有文件
def clean_dir( Dir ):
    if os.path.isdir( Dir ):
        paths = os.listdir( Dir )
        for path in paths:
            filePath = os.path.join( Dir, path )
            if os.path.isfile( filePath ):
                try:
                    os.remove( filePath )
                except os.error:
                    print( "remove %s error." %filePath )#引入logging
            elif os.path.isdir( filePath ):
                if filePath[-4:].lower() == ".svn".lower():
                    continue
                shutil.rmtree(filePath,True)
    return True
# 压缩某个文件件
def zip_dir(Dir):
    # 第一个参数是归档文件名称，第二个参数是指定的格式，不仅是支持zip，第三个参数是要压缩文件/文件夹的路径
    shutil.make_archive(Dir, 'zip', Dir)

# 修改配置文件
def update_sqlldr_config():

    pass

if __name__ == '__main__':
    zip_dir('/home/guangjun/git/dctemplates/app/sqlldr')
