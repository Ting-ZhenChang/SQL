-- 學生表
create table student(
 sno varchar(10) primary key,
 sname varchar(20),
 sage INT , 
 ssex varchar(5)
);

-- 教師表
create table teacher(
 tno varchar(10) primary key, 
 tname varchar(20)
);

-- 課程表
create table course(
 cno varchar(10),
 cname varchar(20), 
 tno varchar(20), 
 constraint pk_course primary key (cno,tno)
);

-- 成績表
create table sc(
 sno varchar(10),
 cno varchar(10), 
 score DECIMAL(4,2),
 constraint pk_sc primary key (sno,cno)
);

-- 學生表data
insert into student values ('s001','張三',23,'男');
insert into student values ('s002','李四',23,'男');
insert into student values ('s003','吳鵬',25,'男');
insert into student values ('s004','琴沁',20,'女');
insert into student values ('s005','王麗',20,'女');
insert into student values ('s006','李波',21,'男');
insert into student values ('s007','劉玉',21,'男');
insert into student values ('s008','蕭蓉',21,'女');
insert into student values ('s009','陳蕭曉',23,'女');
insert into student values ('s010','陳美',22,'女');
insert into student values ('s011','王麗',24,'女');
insert into student values ('s012','蕭蓉',20,'女');

-- 教師表data
insert into teacher values ('t001', '劉陽');
insert into teacher values ('t002', '諶燕');
insert into teacher values ('t003', '胡明星');

-- 課程表data
insert into course values ('c001','J2SE','t002');
insert into course values ('c002','Java Web','t002');
insert into course values ('c003','SSH','t001');
insert into course values ('c004','Oracle','t001');
insert into course values ('c005','SQL SERVER 2005','t003');
insert into course values ('c006','C#','t003');
insert into course values ('c007','JavaScript','t002');
insert into course values ('c008','DIV+CSS','t001');
insert into course values ('c009','PHP','t003');
insert into course values ('c010','EJB3.0','t002');

-- 成績表
insert into sc values ('s001','c001',78.9);
insert into sc values ('s002','c001',80.9);
insert into sc values ('s003','c001',81.9);
insert into sc values ('s004','c001',50.9);
insert into sc values ('s005','c001',59.9);
insert into sc values ('s001','c002',82.9);
insert into sc values ('s002','c002',72.9);
insert into sc values ('s003','c002',82.9);
insert into sc values ('s001','c003',59);
insert into sc values ('s006','c003',99.8);
insert into sc values ('s002','c004',52.9);
insert into sc values ('s003','c004',20.9);
insert into sc values ('s004','c004',59.8);
insert into sc values ('s005','c004',50.8);
insert into sc values ('s002','c005',92.9);
insert into sc values ('s001','c007',78.9);
insert into sc values ('s001','c010',78.9);


-- 成績表
SELECT *
FROM sc

-- 學生
SELECT *
FROM student

-- 課程表 
SELECT *
FROM course

-- 老師
SELECT *
FROM teacher


-- 14. 查詢平均成績大於60 分的同學的學號和平均成績
select 
	sc.sno,
	AVG(score) as 平均成績
from sc
where score > 60
group by sc.sno


-- 13.	查詢’c001’課程比’c002’課程成績高的所有學生的學號
select 
	a.sno
from sc a
join sc b -- self join 
on a.sno = b.sno
where a.cno = 'c001'
and b.cno = 'c002'
and a.score < b.score;


-- 12.	檢索’c004’課程分數小於60,按分數降序排列的同學學號
select 
	sc.sno,
	sc.score
from sc
where score < 60
and sc.cno = 'c004'
order by score desc; --按照分數遞減


-- 11.	查詢兩門以上不及格課程的同學的學號及其平均成績
select 
	sc.sno,
	AVG(score) as 平均成績
from sc
where score < 60
group by sc.sno
having count(*) >= 2; --S004和S005的平均成績低於60分的有兩位或兩位以上


-- 10.	查詢沒學過”諶燕”老師講授的任一門課程的學號,學生姓名
select 
	student.sno,
	student.sname
from student

where sno not in --student.sno table
(
select sc.cno
from sc
join course
on sc.cno = course.cno
join teacher
on course.tno = teacher.tno
where teacher.tname = '諶燕'
)


-- 9.	查詢不及格的課程,並按課程號從大到小排列 學號,課程號,課程名,分數
select 
	sc.sno,
	sc.cno,
	course.cname,
	sc.score
from sc
join course --sc 和 course join 
on sc.cno = course.cno
where score < 60
order by sc.cno desc; --按照課號遞減

-- 8.	查詢任何一門課程成績在70 分以上的學生姓名.課程名稱和分數
select 
	student.sname,
	course.cname,
	sc.score
from student
join sc
on student.sno = sc.sno
join course
on sc.cno = course.cno
where score >= 70;
	


-- 7.	查詢所有學生的選課 課程名稱
select 
	student.sname,
	course.cname
from student
join sc --把sc和student join
on student.sno = sc.sno
join course -- 把sc和course join 
on sc.cno = course.cno;

-- 6. 查詢課程名稱為’Oracle’且分數低於60 的學號和分數
select 
	sc.sno,
	sc.score
from sc
join course c
on sc.cno = c.cno 
where cname = 'Oracle'
and score <60;



--3.	查詢老師 “諶燕” 所帶的課程設數量
select count(*) as 課程數量
FROM teacher t
join course c
on t.tno = c.cno
where t.tname = '諶燕'



--4.	查詢所有老師所帶 的課程 數量
select 
	t.tname, --需顯示t.tname
	count(c.cno) as 課程數量 -- 顯示課程數量
from teacher t
left join course c
on t.tno = c.tno 
group by t.tname


