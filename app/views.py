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
    file_name_ext_list = ['*.csv','*.txt','*.dat']
    terminated_by_list = [',','TAB']
    enclosed_by_list = ['"','|']
    return render_template('upload.html', filenames=filenames, \
                           file_name_ext_list=file_name_ext_list, terminated_by_list=terminated_by_list, enclosed_by_list=enclosed_by_list)


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
        generate_all_scripts()
        # 压缩sqlldr相关的脚本
        zip_dir(configure.SQLLDR_FOLDER)
        # 生成的脚本列表
        filelist = ['00initial_scripts.sql','01veri_scripts.sql','sqlldr.zip']

        return render_template('success.html', filenames=filelist)
    except Exception as e:
        return render_template('fail.html')


if __name__ == '__main__':
    appserver.run(
        host="localhost",
        port=int("5000"),
        debug=True
    )