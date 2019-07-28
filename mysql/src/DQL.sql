-- DQL: 查询表中的记录
select
  name, age
from
  student
where
  1 = 1
group by
  gender
having
  count (gender = "男")
order by
  age
limit
  2, 5;


-- 查询特定字段数据
select 字段列表 from 表名;  -- *表示全部字段
-- 去重
select distinct 字段列表 from 表名;  -- 两条记录字段列表值完全相同才算distinct
-- 字段运算
select 字段列表 from 表名;  -- 字段列表中的字段可以进行运算
					-- 如: 字段:num1+num2, null参与的运算都为null
					--又如字段: num1+ifnull(num2, 0) 表示如果num2为null时,运算取默认值0
-- 别名
字段列表: name as 名字, age 年龄  -- as可以省略

-- 条件查询
select ... where(条件列表);
where name like _zhang%;   -- "_"表示单个占位, "%"表示多个字符占位

-- 排序查询
select ... order by 字段列表 asc;  -- asc可省略
select ... order by 字段列表 desc;

-- 聚合函数
select count(id) ....

-- 分组
select gender count(id) avg(score) where ... group by gender having count(id) > 2;

-- 分页
select ... limit 3, 2;  -- 3开始索引, 2为每页显示几条