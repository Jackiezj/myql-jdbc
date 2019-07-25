-- 数据库CRUD

-- Create 创建数据库
create database demodb;  -- 创建数据库
create database if not exists demodb;  -- 先判断数据库是否存在,再创建数据库
create database if not exists demodb charset='utf8';  -- 创建数据库并指定编码

-- Retrieve 查询
show databases;  -- 查询所有数据库
show create database demodb;  -- 查询数据库创建语句

-- Update 修改
alter database demodb character set utf8;  -- 修改数据库字符集

-- Delete 删除
drop database demodb
drop database if exists demodb;

-- 使用数据库
select database();  -- 查看当前正在使用的数据库名称
user testdb;  -- 使用数据库




-- 表CRUD

-- Create 创建表
create table student (
  age int,  -- 整数类型
  score double,  -- 小数类型
  mathScore(5, 2) double,  -- 小数类型指定数据长度和小数长度
  sname varchar(20),  -- 字符串最大为20字符
  birthday date,  -- 日期，只包含年月日，yyyy-MM-dd
  loginTime datetime,  -- 日期，包含年月日时分秒	 yyyy-MM-dd HH:mm:ss
  newTime timestamp,  -- 时间戳类型	 包含年月日时分秒	 yyyy-MM-dd HH:mm:ss, 为null时将自动赋值
)
create table studentCopy like student;  -- 复制表

-- Retrieve 查询表
show tables;  -- 查询某个数据库中所有的表名称
desc student;  -- 查询表结构

-- Update 修改表
alter table student rename to newStudent;  -- 修改表名
alter table student character set utf8;  -- 修改表的字符集
alter table student add gender varchar(2);  -- 添加一列
alter table student change age newAge varchar(20);  -- 修改列名称 类型
alter table student drop gender;  -- 删除列

-- D(Delete):删除表
drop table studentCopy;
drop table if exists studentCopy;
