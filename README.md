# dctemplates
Template related script, including creating table, basic verification 
# 使用说明
  1. 只支持xlsx类型的excel,老格式的文件不支持，需要转换为最新的格式
  2. 文件的格式必须是标准的格式，mapping columns sheet名称一定要是MappingColumns
  3. MAPPING COLUMN的顺序必须是开始的前10列，顺序类型如下：
	Table Name	Column Name	Data Type	Length	Nullable	Key	Short 		Description	Descirption of Data Migration	Default Value	Reference Table
  4. 列的数据类型定义只支持三种类型的处理，DATE, NUMBER, VARCHAR2
  5. 生成sqlldr加载文件，并按目录进行分类存放
  8. 配置文件conigure.py ，通过修改这个配置文件来决定生成控制文件的形式，也可以配置创建表数据类型的选项来决定生成统一的VARCHAR2或者定义的类型
# 校验结果说明
## 针对Template的定义，生成相应的数据基础校验检查
	A. 数字类型的校验
	B. 日期类型的校验
	C. 字符长度的校验
	D. 外键表完整性校验(Reference Table中设置为外键表名.列名(如:DM_PARTY.PARTY_ID)的形式会生成外键值校验)
	E. 主键值唯一性校验
	F. 唯一键校验(一个表只支持一组组合唯一键校验，需要在Key列设置为字母U，所有标志为U的字段会自动生成
