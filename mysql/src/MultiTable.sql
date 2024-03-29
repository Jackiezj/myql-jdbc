-- 内连接查询
select * from emp t1, dept t2 where t1.'dept_id' = t2.'id';  -- 隐式内连接
select * from emp [inner] join dept on emp.'dept_id' = temp.'id';  -- 显式内连接

-- 外连接查询
select * from emp left [outer] join dept on emp.'dept_id' = temp.'id';  -- 左外连接, 一般只用左外, 右外是相对于左外的
select * from emp right [outer] join dept on emp.'dept_id' = temp.'id';  -- 右外

-- 子查询
SELECT * FROM emp WHERE emp.salary < (SELECT AVG(salary) FROM emp);  -- 子查询的结果是单行单列的
SELECT * FROM emp WHERE dept_id IN (SELECT id FROM dept WHERE NAME = '财务部' OR NAME = '市场部');  -- 子查询的结果是多行单列的
SELECT * FROM dept t1 ,(SELECT * FROM emp WHERE emp.`join_date` > '2011-11-11') t2 WHERE t1.id = t2.dept_id;  -- 子查询的结果是多行多列的

-- 练习
-- 部门表
CREATE TABLE dept (
    id INT PRIMARY KEY PRIMARY KEY, -- 部门id
    dname VARCHAR(50), -- 部门名称
    loc VARCHAR(50) -- 部门所在地
);

-- 添加4个部门
INSERT INTO dept(id,dname,loc) VALUES
(10,'教研部','北京'),
(20,'学工部','上海'),
(30,'销售部','广州'),
(40,'财务部','深圳');

-- 职务表，职务名称，职务描述
CREATE TABLE job (
    id INT PRIMARY KEY,
    jname VARCHAR(20),
    description VARCHAR(50)
);

-- 添加4个职务
INSERT INTO job (id, jname, description) VALUES
(1, '董事长', '管理整个公司，接单'),
(2, '经理', '管理部门员工'),
(3, '销售员', '向客人推销产品'),
(4, '文员', '使用办公软件');

-- 员工表
CREATE TABLE emp (
    id INT PRIMARY KEY, -- 员工id
    ename VARCHAR(50), -- 员工姓名
    job_id INT, -- 职务id
    mgr INT , -- 上级领导
    joindate DATE, -- 入职日期
    salary DECIMAL(7,2), -- 工资
    bonus DECIMAL(7,2), -- 奖金
    dept_id INT, -- 所在部门编号
    CONSTRAINT emp_jobid_ref_job_id_fk FOREIGN KEY (job_id) REFERENCES job (id),
    CONSTRAINT emp_deptid_ref_dept_id_fk FOREIGN KEY (dept_id) REFERENCES dept (id)
);

-- 添加员工
INSERT INTO emp(id,ename,job_id,mgr,joindate,salary,bonus,dept_id) VALUES
(1001,'孙悟空',4,1004,'2000-12-17','8000.00',NULL,20),
(1002,'卢俊义',3,1006,'2001-02-20','16000.00','3000.00',30),
(1003,'林冲',3,1006,'2001-02-22','12500.00','5000.00',30),
(1004,'唐僧',2,1009,'2001-04-02','29750.00',NULL,20),
(1005,'李逵',4,1006,'2001-09-28','12500.00','14000.00',30),
(1006,'宋江',2,1009,'2001-05-01','28500.00',NULL,30),
(1007,'刘备',2,1009,'2001-09-01','24500.00',NULL,10),
(1008,'猪八戒',4,1004,'2007-04-19','30000.00',NULL,20),
(1009,'罗贯中',1,NULL,'2001-11-17','50000.00',NULL,10),
(1010,'吴用',3,1006,'2001-09-08','15000.00','0.00',30),
(1011,'沙僧',4,1004,'2007-05-23','11000.00',NULL,20),
(1012,'李逵',4,1006,'2001-12-03','9500.00',NULL,30),
(1013,'小白龙',4,1004,'2001-12-03','30000.00',NULL,20),
(1014,'关羽',4,1007,'2002-01-23','13000.00',NULL,10);

-- 工资等级表
CREATE TABLE salarygrade (
    grade INT PRIMARY KEY,   -- 级别
    losalary INT,  -- 最低工资
    hisalary INT -- 最高工资
);

-- 添加5个工资等级
INSERT INTO salarygrade(grade,losalary,hisalary) VALUES
(1,7000,12000),
(2,12010,14000),
(3,14010,20000),
(4,20010,30000),
(5,30010,99990);

-- 需求：
-- 1.查询所有员工信息。查询员工编号，员工姓名，工资，职务名称，职务描述
/*
分析：
1.员工编号，员工姓名，工资，需要查询emp表  职务名称，职务描述 需要查询job表
2.查询条件 emp.job_id = job.id
*/
SELECT
t1.`id`, -- 员工编号
t1.`ename`, -- 员工姓名
t1.`salary`,-- 工资
t2.`jname`, -- 职务名称
t2.`description` -- 职务描述
FROM
emp t1, job t2
WHERE
t1.`job_id` = t2.`id`;

-- 2.查询员工编号，员工姓名，工资，职务名称，职务描述，部门名称，部门位置
/*
分析：
1. 员工编号，员工姓名，工资 emp  职务名称，职务描述 job  部门名称，部门位置 dept
2. 条件： emp.job_id = job.id and emp.dept_id = dept.id
*/
SELECT
t1.`id`, -- 员工编号
t1.`ename`, -- 员工姓名
t1.`salary`,-- 工资
t2.`jname`, -- 职务名称
t2.`description`, -- 职务描述
t3.`dname`, -- 部门名称
t3.`loc` -- 部门位置
FROM
emp t1, job t2,dept t3
WHERE
t1.`job_id` = t2.`id` AND t1.`dept_id` = t3.`id`;

-- 3.查询员工姓名，工资，工资等级
/*
分析：
1.员工姓名，工资 emp  工资等级 salarygrade
2.条件 emp.salary >= salarygrade.losalary and emp.salary <= salarygrade.hisalary
emp.salary BETWEEN salarygrade.losalary and salarygrade.hisalary
*/
SELECT
t1.ename ,
t1.`salary`,
t2.*
FROM emp t1, salarygrade t2
WHERE t1.`salary` BETWEEN t2.`losalary` AND t2.`hisalary`;

-- 4.查询员工姓名，工资，职务名称，职务描述，部门名称，部门位置，工资等级
/*
分析：
1. 员工姓名，工资 emp ， 职务名称，职务描述 job 部门名称，部门位置，dept  工资等级 salarygrade
2. 条件： emp.job_id = job.id and emp.dept_id = dept.id and emp.salary BETWEEN salarygrade.losalary and salarygrade.hisalary
*/
SELECT
t1.`ename`,
t1.`salary`,
t2.`jname`,
t2.`description`,
t3.`dname`,
t3.`loc`,
t4.`grade`
FROM
emp t1,job t2,dept t3,salarygrade t4
WHERE
t1.`job_id` = t2.`id`
AND t1.`dept_id` = t3.`id`
AND t1.`salary` BETWEEN t4.`losalary` AND t4.`hisalary`;

-- 5.查询出部门编号、部门名称、部门位置、部门人数
/*
分析：
1.部门编号、部门名称、部门位置 dept 表。 部门人数 emp表
2.使用分组查询。按照emp.dept_id完成分组，查询count(id)
3.使用子查询将第2步的查询结果和dept表进行关联查询
*/
SELECT
t1.`id`,t1.`dname`,t1.`loc` , t2.total
FROM
dept t1,
(SELECT
dept_id,COUNT(id) total
FROM
emp
GROUP BY dept_id) t2
WHERE t1.`id` = t2.dept_id;

-- 6.查询所有员工的姓名及其直接上级的姓名,没有领导的员工也需要查询
/*
分析：
1.姓名 emp， 直接上级的姓名 emp
* emp表的id 和 mgr 是自关联
2.条件 emp.id = emp.mgr
3.查询左表的所有数据，和 交集数据
* 使用左外连接查询
*/
/*
select
t1.ename,
t1.mgr,
t2.`id`,
t2.ename
from emp t1, emp t2
where t1.mgr = t2.`id`;
*/
SELECT
t1.ename,
t1.mgr,
t2.`id`,
t2.`ename`
FROM emp t1
LEFT JOIN emp t2
ON t1.`mgr` = t2.`id`;