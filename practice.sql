//學生表
create table student(
 sno varchar(10) primary key,
 sname varchar(20),
 sage INT , 
 ssex varchar(5)
);

//教師表
create table teacher(
 tno varchar(10) primary key, 
 tname varchar(20)
);

//課程表
create table course(
 cno varchar(10),
 cname varchar(20), 
 tno varchar(20), 
 constraint pk_course primary key (cno,tno)
);

//成績表
create table sc(
 sno varchar(10),
 cno varchar(10), 
 score DECIMAL(4,2),
 constraint pk_sc primary key (sno,cno)
);

// 學生表data
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

//教師表data
insert into teacher values ('t001', '劉陽');
insert into teacher values ('t002', '諶燕');
insert into teacher values ('t003', '胡明星');

//課程表data
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

// 成績表
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


--1
SELECT TOP 10*
FROM STUDENT

--2
SELECT
    MIN(score) AS 最低分,
    AVG(score) AS 平均分,
    SUM(score) AS 總分
FROM sc;

--3
SELECT COUNT(*) AS 課程數量
FROM teacher t
JOIN course c
on t.tno = c.tno		
WHERE t.tname = '諶燕';

--4
SELECT 
t.tname,
COUNT(c.cno) AS 課程數量
FROM teacher t 
LEFT JOIN course c
on t.tno = c.tno
GROUP BY t.tname;

--5
SELECT *
FROM student
WHERE sname LIKE '張%';

--6
SELECT
    sc.sno,
    sc.score
FROM sc

JOIN course
ON sc.cno = course.cno
WHERE cname='Oracle'
AND score<60;

--7
SELECT
    student.sname,
    course.cname
FROM student

JOIN sc
ON student.sno=sc.sno
JOIN course
ON sc.cno=course.cno;

--8
SELECT
    student.sname,
    course.cname,
    sc.score
FROM student

JOIN sc
ON student.sno=sc.sno
JOIN course
ON sc.cno=course.cno
WHERE score>=70;

--9
SELECT
    sc.sno,
    sc.cno,
    course.cname,
    sc.score
FROM sc
JOIN course
ON sc.cno=course.cno
WHERE score<60
ORDER BY sc.cno DESC;


--10
SELECT
	sno,
	sname
FROM student
WHERE sno NOT IN
(
    SELECT sc.sno
    FROM sc
    JOIN course
    ON sc.cno=course.cno
    JOIN teacher
    ON course.tno=teacher.tno
    WHERE teacher.tname='諶燕'
);


--11
SELECT
    sno,
    AVG(score) AS 平均成績
FROM sc
WHERE score<60
GROUP BY sno
HAVING COUNT(*)>=2;

--12
SELECT
    sno
	score 
FROM sc
WHERE cno='c004'
AND score<60
ORDER BY score DESC;

--13
SELECT
    a.sno
FROM sc a
JOIN sc b
ON a.sno=b.sno
WHERE a.cno='c001'
AND b.cno='c002'
AND a.score>b.score;

--14
SELECT
    sno,
    AVG(score) AS 平均成績
FROM sc
GROUP BY sno
HAVING AVG(score) > 60;

--15
SELECT
    s.sno,
    s.sname,
    COUNT(sc.cno) AS 選課數,
    SUM(sc.score) AS 總成績
FROM student s
LEFT JOIN sc
ON s.sno=sc.sno
GROUP BY s.sno,s.sname;

--16
SELECT COUNT(*) AS 老師數
FROM teacher
WHERE tname LIKE '劉%';

--17
SELECT
    s.sno,
    s.sname
FROM student s
WHERE s.sno NOT IN
(
    SELECT sc.sno
    FROM sc
    JOIN course c
    ON sc.cno=c.cno
    WHERE c.tno<>'t002'
);

--18
SELECT 
	s.sno,
	s.sname
FROM student s
JOIN sc a
ON s.sno=a.sno
JOIN sc b
ON s.sno=b.sno
WHERE a.cno='c001'
AND b.cno='c002';

--19
SELECT
    sno
FROM sc
JOIN course
ON sc.cno=course.cno
WHERE tno='t002'
GROUP BY sno
HAVING COUNT(DISTINCT sc.cno)=
(
    SELECT COUNT(*)
    FROM course
    WHERE tno='t002'
);

--20
SELECT
    s.sno,
    s.sname
FROM student s
JOIN sc a
ON s.sno=a.sno
JOIN sc b
ON s.sno=b.sno
JOIN sc c
ON s.sno=c.sno
WHERE
a.cno='c004'
AND b.cno='c001'
AND c.cno='c002'
AND a.score<b.score
AND a.score<c.score;

--21
SELECT
    s.sno,
    s.sname
FROM student s
WHERE s.sno NOT IN
(
    SELECT sno
    FROM sc
    WHERE score>=60
);
