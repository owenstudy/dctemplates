import os
# We'll render HTML templates and access data sent by POST
# using the request object from flask. Redirect and url_for
# will be used to redirect the user once the upload is done
# and send_from_directory will help us to send/show on the
# browser the file that the user just uploaded
from flask import Flask, render_template, request, redirect, url_for, send_from_directory
from werkzeug.utils import secure_filename

from app import appserver
from app.common import clean_dir, zip_dir
from app.scripttofile import generate_all_scripts
from app.configure import sqlloader_configure
from app import configure

# Initialize the Flask application
# app = Flask(__name__)
# This is the path to the upload directory
if os.path.exists(configure.SQLLDR_TEMPLATES_FOLDER) is False:
    os.mkdir(configure.SQLLDR_TEMPLATES_FOLDER)
if os.path.exists(configure.DOWNLOAD_FOLDER) is False:
    os.mkdir(configure.DOWNLOAD_FOLDER)

appserver.config['UPLOAD_FOLDER'] = configure.UPLOADS_FOLDER
appserver.config['DOWNLOAD_FOLDER'] = configure.DOWNLOAD_FOLDER
# These are the extension that we are accepting to be uploaded
appserver.config['ALLOWED_EXTENSIONS'] = set(['xlsx'])


# For a given file, return whether it's an allowed type or not
def allowed_file(filename):
    return '.' in filename and \
           filename.rsplit('.', 1)[1] in appserver.config['ALLOWED_EXTENSIONS']


# This route will show a form to perform an AJAX request
# jQuery is loaded to execute the request and update the
# value of the operation
@appserver.route('/')
def index():
    return render_template('index.html')


# Route that will process the file upload
@appserver.route('/upload', methods=['POST'])
def upload():
    # Get the name of the uploaded files
    uploaded_files = request.files.getlist("file[]")
    filenames = []
    # 清除已经存在的文件列表
    clean_dir(appserver.config['UPLOAD_FOLDER'])
    # 加载选择的文件
    for file in uploaded_files:
        # Check if the file is one of the allowed types/extensions
        if file and allowed_file(file.filename):
            # Make the filename safe, remove unsupported chars
            filename = secure_filename(file.filename)
            # Move the file form the temporal folder to the upload
            # folder we setup
            file.save(os.path.join(appserver.config['UPLOAD_FOLDER'], filename))
            # Save the filename into a list, we'll use it later
            filenames.append(filename)
            # Redirect the user to the uploaded_file route, which
            # will basicaly show on the browser the uploaded file
    # Load an html page with a link to each uploaded file
    file_name_ext_list = configure.file_name_ext_list
    terminated_by_list = configure.terminated_by_list
    enclosed_by_list = configure.enclosed_by_list
    append_type_list = configure.append_type_list
    nls_lang_list = configure.nls_lang_list
    return render_template('upload.html', filenames=filenames, \
                           file_name_ext_list=file_name_ext_list, terminated_by_list=terminated_by_list, enclosed_by_list=enclosed_by_list,\
                           append_type_list=append_type_list, nls_lang_list = nls_lang_list)


# This route is expecting a parameter containing the name
# of a file. Then it will locate that file on the upload
# directory and show it on the browser, so if the user uploads
# an image, that image is going to be show after the upload
@appserver.route('/uploads/<filename>')
def uploaded_file(filename):
    return send_from_directory(appserver.config['UPLOAD_FOLDER'],
                               filename)

# 下载生成的脚本文件
@appserver.route('/downloads/<filename>')
def download_file(filename):
    return send_from_directory(appserver.config['DOWNLOAD_FOLDER'],
                               filename)

@appserver.route('/generatescript', methods=['POST'])
def generatescript():
    try:
        script_options(request)
        generate_all_scripts()
        # 压缩sqlldr相关的脚本
        zip_dir(configure.SQLLDR_FOLDER)
        # 生成的脚本列表
        filelist = ['00initial_scripts.sql','01veri_scripts.sql','sqlldr.zip']

        return render_template('success.html', filenames=filelist)
    except Exception as e:
        return render_template('fail.html')
# 处理传递过来的生成脚本参数
def script_options(request):
    sqlloader_configure = {"file_name_ext": "csv", "terminated_by": ",", "enclosed_by": '"', "append_type": "append",
                           "nls_lang": "AMERICAN_AMERICA.ZHS16GBK", 'file_name_upper': True}
    # sqlloader的一些配置信息
    # file_name_ext
    file_name_ext = request.values.getlist('file_name_ext')
    for s in file_name_ext:
        configure.sqlloader_configure['file_name_ext'] = s
    # terminated_by
    terminated_by = request.values.getlist('terminated_by')
    for s in terminated_by:
        configure.sqlloader_configure['terminated_by'] = s
    # enclosed_by
    enclosed_by = request.values.getlist('enclosed_by')
    for s in enclosed_by:
        configure.sqlloader_configure['enclosed_by'] = s
    # append_type
    append_type = request.values.getlist('append_type')
    for s in append_type:
        configure.sqlloader_configure['append_type'] = s
    # nls_lang
    nls_lang = request.values.getlist('nls_lang')
    for s in nls_lang:
        configure.sqlloader_configure['nls_lang'] = s
    # file_name_upper
    file_name_upper = request.values.getlist('file_name_upper')
    for s in file_name_upper:
        configure.sqlloader_configure['file_name_upper'] = __strtobool(s)
    # ignore_first_row
    ignore_first_row = request.values.getlist('ignore_first_row')
    for s in ignore_first_row:
        configure.sqlloader_configure['ignore_first_row'] = __strtobool(s)
    # 创建表的一些配置信息
    # real_data_type
    file_name_upper = request.values.getlist('real_data_type')
    for s in file_name_upper:
        configure.create_table_configure['real_data_type'] = __strtobool(s)
    # table_prefix
    table_prefix = request.values.getlist('table_prefix')
    for s in table_prefix:
        configure.create_table_configure['table_prefix'] = s
    # 数据库连接信息
    # src_user_name
    src_user_name = request.values.getlist('src_user_name')
    for s in src_user_name:
        configure.sqlloader_configure['src_user_name'] = s
    # src_user_pwd
    src_user_pwd = request.values.getlist('src_user_pwd')
    for s in src_user_pwd:
        configure.sqlloader_configure['src_user_pwd'] = s
    # connectstring
    connectstring = request.values.getlist('connectstring')
    for s in connectstring:
        configure.sqlloader_configure['connectstring'] = s

def __strtobool(value):
    if value.upper() == 'TRUE':
        return True
    else:
        return False
if __name__ == '__main__':
    appserver.run(
        host="localhost",
        port=int("5000"),
        debug=True
    )