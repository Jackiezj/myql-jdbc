-- 事务操作
start transaction;  -- 开启事务
rollback;  -- 回滚事务
commit;  -- 提交事务

-- 修改事务的默认提交方式
select @@autocommit; -- 查看事务的默认提交方式 1 代表自动提交  0 代表手动提交
set @@autocommit = 0;  -- 修改默认提交方式：

-- 事务的隔离级别
-- 隔离级别：
read uncommitted;  -- 读未提交
	-- 产生的问题：脏读、不可重复读、幻读
read committed;  -- 读已提交 （Oracle）
	-- 产生的问题：不可重复读、幻读
repeatable read;  -- 可重复读 （MySQL默认）
	-- 产生的问题：幻读
serializable;  -- 串行化
	-- 可以解决所有的问题