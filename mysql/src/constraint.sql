-- 创建表时添加约束
create table student(
	id int primary key auto_increment,  -- 主键约束+自动增长  (非空且唯一 <==> 主键, 一个表中只能有一个)
    name varchar(20) not null,  -- 非空约束
    age varchar(20) unique  -- 唯一约束
);

-- 向表中添加或删除约束
-- 删除约束
alter table student  modify name varchar(20)  -- 删除非空约束
alter table student drop index name;  -- 删除唯一约束
alter table student drop primary key;  -- 删除主键约束
alter table student modify id int;  -- 删除自动增长
-- 添加约束
alter table student modify name varchar(20) not null;  -- 添加非空约束
alter table student modify name varchar(20) unique;  -- 添加唯一约束
alter table student modify id int primary key;  -- 添加主键约束
alter table student modify id int auto_increment;  -- 添加主键约束

-- 外键约束
constraint 外键名称 foreign key (外键列名称) references 主表名称(主表列名称);
alter table 表名 drop foreign key 外键名称;  -- 删除外键
alter table 表名 add constraint 外键名称 foreign key (外键列名称) references 主表名称(主表列名称);  -- 添加外键约束

-- 级联操作
alter table 表名 add constraint 外键名称 foreign key (外键列名称) references 主表名称(主表列名称) on update cascade on update cascade;  -- 添加级联外键约束