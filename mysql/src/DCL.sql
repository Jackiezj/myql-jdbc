-- 用户管理
-- 添加用户：
CREATE USER '用户名'@'主机名' IDENTIFIED BY '密码';
-- 删除用户：
DROP USER '用户名'@'主机名';
-- 修改用户密码：
UPDATE USER SET PASSWORD = PASSWORD('新密码') WHERE USER = '用户名';
SET PASSWORD FOR '用户名'@'主机名' = PASSWORD('新密码');
SET PASSWORD FOR 'root'@'localhost' = PASSWORD('123');
-- win中mysql中忘记了root用户的密码？
/*
	cmd -- > net stop mysql 停止mysql服务  需要管理员运行该cmd
	使用无验证方式启动mysql服务： mysqld --skip-grant-tables
	打开新的cmd窗口,直接输入mysql命令，敲回车。就可以登录成功
	use mysql;
	update user set password = password('你的新密码') where user = 'root';
	关闭两个窗口
	打开任务管理器，手动结束mysqld.exe 的进程
	启动mysql服务
	使用新密码登录。
*/
-- linux忘记密码参照MySQL安装配置linux部分
-- 查询用户：
USE myql;
SELECT * FROM USER;  -- * 通配符： % 表示可以在任意主机使用用户登录数据库



-- 权限管理
-- 查询权限
SHOW GRANTS FOR '用户名'@'主机名';
SHOW GRANTS FOR 'lisi'@'%';

-- 授予权限
grant 权限列表 on 数据库名.表名 to '用户名'@'主机名';
GRANT ALL ON *.* TO 'zhangsan'@'localhost';  -- 给张三用户授予所有权限，在任意数据库任意表上
-- 撤销权限：
revoke 权限列表 on 数据库名.表名 from '用户名'@'主机名';
REVOKE UPDATE ON db3.`account` FROM 'lisi'@'%';