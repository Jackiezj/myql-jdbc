-- 添加数据
insert into student (id, name, age) values (null, "zhangsan", 18);  -- 除数字外所有内容都用"" 引起来 如日期
insert into student values (...);  -- ... 表示所有列全部需要依次传递

-- 删除数据
delete from student where age=18;
delete from student;  -- 不加条件表示全部删除, 不推荐使用
truncate table student;  -- 先删除表，然后再创建一张一样的表, 推荐使用

-- 修改数据
update student set name = "lisi", age = 18 where name = "ls"
update student set name = "list", age = 18;  -- 不加条件, 修改表中的所有记录
