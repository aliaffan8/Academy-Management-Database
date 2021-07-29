drop database p1
go
create database p1
go
use p1
select* from logininfo


--***********************************************************************

create table user1
(
[id] int PRIMARY KEY,
[name] varchar(100),
[age] int,

[gender] varchar(100),
[role] varchar(100), --teacher/student/admin
[DOB] date,

)

insert into user1 values(11111,'amna', 16, 'f','student', '2000/05/25')
insert into user1 values(22222,'asfa', 16, 'f','teacher', '2000/05/25')
insert into user1 values(33333,'haider', 16, 'f','teacher', '2000/05/25')
insert into user1 values(44444,'anmol', 16, 'f','student', '2000/05/25')
insert into user1 values(555555,'nf', 16, 'm','teacher', '2000/07/25')
--*************************************************************************

create table loginInfo(
--[LoginId] int PRIMARY KEY, --?????????????
[UserId] int unique, --FK from user, can have only one account
--[username] varchar(50),
[password] varchar(50) unique,
--[role] varchar(15) --should be included or not?
)
insert into loginInfo values(11111,'amnaakram')
insert into loginInfo values(22222,'asfaakram')
insert into loginInfo values(33333,'haiderakram')
insert into loginInfo values(44444,'anmoltahir')
--****************************************************************************

create table ContactInfo
(
--[ContactId] int PRIMARY KEY, --????????????????????
[UserId] int unique, --FK from user table
[phoneno] varchar(12),
[email] varchar(50),
[address] varchar(50)
)

insert into ContactInfo values(11111,'111111','dwqdddddd','wqdqwdqw')
insert into ContactInfo values(22222,'111111','dwqdddddd','wqdqwdqw')
insert into ContactInfo values(33333,'111111','dwqdddddd','wqdqwdqw')
insert into ContactInfo values(44444,'111111','dwqdddddd','wqdqwdqw')
insert into ContactInfo values(55555,'12222222','dwqdddddd','johar town')

--***********************************************************************************

create table course
(
[courseId] int PRIMARY KEY,
[courseName] varchar(50),
[grade] varchar (80) -- which grade to teach this course
)
insert into course values(1,'maths', 'ninth')
insert into course values(2,'maths', 'tenth')
insert into course values(3,'maths', 'eleven')
--*************************************************************************

create table teacher
(
--[id] int identity (1,1), --????????
[UserId] int, --FK from table user
[no_of_course] int, -- no of courses registered by teacher
[qualification] varchar(100), --?????????????
[rating] int, --from 0 to 5
[experience] int, --in service(years)
[bankname] varchar  (100),
[acc_no] BIGINT,
primary key(userid)
)
insert into teacher values(22222,2,'MA',2,5,'hbl',1)
insert into teacher values(33333,2,'MA',2,5,'hbl',1)
insert into teacher values(55555,4,'MSCS',2,5,'hbl',3333)

create table registered_teacher_courses
(
	[id] int identity(1,1),
	[tid] int, --teacher id, foreign key from user id as teachers 
	[courseID] int, -- course id, foreign key from courses
	[NoOfdays_per_week] int, --no of days teacher will teach per week
	[dateOfHiring] date,
	[feepermonth] int,
	primary key(tid, courseID) 
	--make primary key (courseid, tid) one teacher cannot register 2 same courses 

	
)
insert into registered_teacher_courses (tid,courseid,NoOfdays_per_week,dateOfHiring, feepermonth) values(22222,1,3,'2000/5/20',2000)
	insert into registered_teacher_courses (tid,courseid,NoOfdays_per_week,dateOfHiring, feepermonth) values(22222,2,3,'2000/5/20',2000)
	insert into registered_teacher_courses (tid,courseid,NoOfdays_per_week,dateOfHiring, feepermonth) values(33333,1,3,'2000/5/20',2000)
		insert into registered_teacher_courses (tid,courseid,NoOfdays_per_week,dateOfHiring, feepermonth) values(55555,2,3,'2000/5/20',7000)
			insert into registered_teacher_courses (tid,courseid,NoOfdays_per_week,dateOfHiring, feepermonth) values(55555,3,3,'2000/5/20',10000)

CREATE TABLE PAY
(
[TID] INT, ------------fk, userid from teachers
[SID]INT, -------------fk, userid from student
[courseid] INT,--- FK FROM COURSES
[TOTALAMOUNT] INT,
[paidstatus] varchar(20)
primary key(tid, [sid], [courseid])--one student cannot register twice in the same course with the same teacher 
)


--******************************************************************

create table student
(
--[id] int PRIMARY KEY, --???????????????
[UserId] int, -- FK from user
[registered COURSES] int  --no of courses
primary key(userid)
)
insert into student values(11111,2)
insert into student values(44444,2)
--******************************************************************

create table student_courses
(
[id] int identity(1,1), --start from 1, then auto-increment by 1
[tid] int, --foreign key , user id of teacher
[SID] int,--------FK FROM STUDENT, userid of student 
[COURSE] int, --fk from course id
[duration_months]int
primary key (id,[tid],[sid],course) 
)
insert into student_courses(tid,sid,course) values(22222,11111,1)
insert into student_courses(tid,sid,course) values(33333,44444,2)
insert into student_courses(tid,sid,course) values(55555,11111,3)
--***********************************************************************
create table responses
(

[sid] int,
[tid] int,
[rating] int


)

--******************************************************************
--***************************************************************************

--***************************************************************************

alter table loginInfo
ADD CONSTRAINT fk_Uid FOREIGN KEY (UserId)
REFERENCES user1 (id) on delete cascade on update cascade

alter table ContactInfo
ADD CONSTRAINT fk_UCIid FOREIGN KEY (UserId)
REFERENCES user1 (id) on delete cascade on update cascade

alter table teacher
ADD CONSTRAINT fk_UTid FOREIGN KEY (UserId)
REFERENCES user1 (id) on delete cascade on update cascade

alter table student
ADD CONSTRAINT fk_USid FOREIGN KEY (UserId)
REFERENCES user1 (id) on delete cascade on update cascade

alter table student_courses
ADD CONSTRAINT fk_course1 FOREIGN KEY (COURSE)
REFERENCES course (courseId) on delete cascade on update cascade

alter table student_courses
add constraint fk_tid foreign key (tid)
references teacher (userid) on delete cascade on update cascade

alter table student_courses
add constraint fk_sid foreign key ([sid])
references student (userid) on delete no action on update no action

alter table registered_teacher_courses
add constraint fk_teacher_id foreign key(tid)
references teacher(userid) on delete cascade on update cascade

alter table registered_teacher_courses
add constraint fk_course_id foreign key (courseID)
references course (courseId) on delete cascade on update cascade

alter table pay
add constraint fk_course_id_pay foreign key (courseID)
references course (courseId) on delete cascade on update cascade

alter table pay
add constraint fk_tid_pay foreign key (tid)
references teacher(userid) on delete cascade on update cascade 

alter table pay 
add constraint fk_sid_pay foreign key ([sid])
references student(userid) on delete no action on update no action

alter table responses 
add constraint fk_response_sid foreign key([sid])
references student([userid]) ON UPDATE CASCADE ON DELETE SET NULL

--alter table responses
--add constraint fk_response_tid foreign key([tid])
--references user1([id]) ON UPDATE CASCADE ON DELETE CASCADE (THROUGH TRIGGER)

select * from student


-----------PROCEDURES-----------------------
--++++++++++++++++++++++++LOGIN+++++++++++++++++++++++++++++++++++++++++++++
go
create procedure login_edemy
 @uid int,
  @pass varchar(15),
   @loginsuccess int output
as
begin
set @loginsuccess=0
if ((select [userid] from logininfo where [userid]=@uid) is not null)
begin
	if ((select [password] from logininfo where [password]=@pass and UserId=@uid) is not null) 
	begin
	set @loginsuccess=1
	end
end 
end
go
declare @outputparam int

exec login_edemy
@uid=2,
@pass='asfa',
@loginsuccess=@outputparam output

select @outputparam as loginSuccess
go
select * from loginInfo

--++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
go
create procedure show_courses
as
select c.coursename, c.grade from course c
go
exec show_courses
go
select * from loginInfo
--++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++

go
create procedure signup_student
 @id int, @name varchar(50), @age int, @gender char, @DOB date,
 @phone varchar(12),@email varchar (50), @address varchar (50),@password varchar(50),
 @signupsuccess int OUTPUT
as 
begin
if ((select [userid] from logininfo where [userid]=@id) is not null)
begin
set @signupsuccess=0
end
else
begin
set @signupsuccess=1
insert into user1 (id,[name],age,gender,[role],DOB) values (@id,@name,@age,@gender,'student',@DOB)
insert into student (UserId,[registered COURSES]) values (@id,0)
insert into ContactInfo(UserId,phoneno,email,[address]) values (@id,@phone,@email,@address)
insert into loginInfo(UserId, [password]) values(@id,@password)
end
end
go

declare @outputparam int
go
exec signup_student
@id=9,
@name='ali affan',
@age=19,
@gender='M',
@role='student',
@dob='06-17-1999',

@phone='03310143576',
@email='aliaffan1999@gmail.com',
@address='106 Aurangzeb Block'
@signupsuccess=outputparam OUTPUT
select * from teacher
select* from user1
select * from student
select * from ContactInfo

select* from user1
select * from student
select * from teacher
select * from ContactInfo
select * from logininfo
--+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
go
CREATE procedure signup_teacher
 @id int, @name varchar(100), @age int,
  @gender varchar(100), @DOB date,
  @phone varchar(12),@email varchar (50), @address varchar (50),
@qualified varchar(50), @experience int, @bankname varchar (100), @acc_no int,
@password varchar(50),
@signupsuccess int OUTPUT
as 
begin

set @signupsuccess=0
if((select id from user1 where id=@id) is NULL)
begin
set @signupsuccess=1
insert into user1 (id,[name],age,gender,[role],DOB) values (@id,@name,@age,@gender,'teacher',@DOB)
insert into teacher values(@id,0,@qualified,0,@experience,@bankname,@acc_no)
insert into ContactInfo(UserId,phoneno,email,[address]) values (@id,@phone,@email,@address)
insert into loginInfo(UserId, [password]) values(@id,@password)
end
end
go

declare @out1 int
exec signup_teacher
@id=8,
@name='ali affan',
@age=19,
@gender='M',
@role='student',
@DOB='06-17-1999',

@phone='03310143576',
@email='aliaffan1999@gmail.com',
@address='106 Aurangzeb Block',
@qualified='MA',
@experience= 5 ,
@bankname='HBL',
@acc_no=1122334455,
@signupsuccess=@out1 OUTPUT,
@password='kkkkkkkkkkkkkkkkkkkkkkkk'
select @out1

select * from user1
select * from teacher
select * from ContactInfo
--++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
go
create view student_view
as
select u.id, u.[name], u.age,u.gender,u.[DOB], c.phoneno,c.email,c.address, s.[registered COURSES] from user1 u left join
 ContactInfo c on c.UserId=u.id left join student s on s.UserId=u.id
 go

 go
create view teacher_view 
 as
 select u.id, u.[name], u.age,u.gender,u.[DOB], c.phoneno,c.email,c.address,t.bankname, t.acc_no, t.experience, t.no_of_course, t.qualification
 ,t.rating
   from user1 u left join
 ContactInfo c on c.UserId=u.id left join teacher t on t.UserId=u.id
 go
 ------**************for the view of user stdent/teacher**************************
 go
 create procedure viewmain
 @i1 int 
 as
 begin
 if((select role from user1 where id=@i1)='student')
 begin

 select * from student_view s where s.id=1

 end
 else if((select role from user1 where id=@i1)='teacher')
 begin

 select * from teacher_view t where t.id=@i1

 end
 end
 go
 exec viewmain @i1=11111
 select * from teacher
 --++++++++++++++++++++++++++++shows all courses registered by a student+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
go 
 create procedure show_student_reg_courses
 @i1 int 
 as
 begin
 select c.courseName, c.grade  ,u.name as intructor,sc.duration_months  from student_courses sc join
  course c on c.courseId=sc.COURSE
 join user1 u on sc.tid=u.id 
 where sc.SID=@i1

 end
 go
 exec show_student_reg_courses @i1=1
 --+++++++++++++++++++++show all courses registered by the teacher+++++++++++++++++++++++++++++++++++++++++++++++++++++
 go
 create procedure show_teacher_reg_courses1
 @i1 int 
 as
 begin
 select c.courseName, c.grade,rt.NoOfdays_per_week, rt.dateOfHiring, rt.feepermonth
 from registered_teacher_courses rt join course c on rt.courseID=c.courseId
 where rt.tid=@i1
 end
 go
 exec show_teacher_reg_courses1 @i1=5
 --+++++++++++++++++++++++++++shows onlu names and qualification of teachers available for a particular subject
  go
  create procedure teachers_available --teachers available for a particular subject
 @i1 varchar(50), --subjectname
 @i2 varchar(80) --grade
 as
 begin
 select u.name, t.qualification
  from registered_teacher_courses rt join teacher t on t.UserId=rt.tid join user1 u on u.id=t.UserId
join course c on rt.courseID=c.courseId where c.courseName=@i1 and c.grade=@i2
 end
 go
 exec teachers_available @i1='maths', @i2='ninth'


 --++++++++++++++++++++showsdetails of a teacher +++++++++++++++++++++++++++++++++++++++++++++++++
 --will be used after showing names of all teachers of a particular subject. when user clicks on show details
 --@i1 i.e. teacher's userid will be a hidden field(html)
  go
  create procedure teachers_info --teachers available for a particular subject
 @i1 int,
  @i2 varchar(50), --subjectname
 @i3 varchar(80) --grade
 as
 begin
 select  u.name, t.qualification, t.rating, t.experience, rt.feepermonth, rt.dateOfHiring,
 ci.email, ci.phoneno
  from registered_teacher_courses rt join teacher t on t.UserId=rt.tid join user1 u on u.id=t.UserId
join course c on rt.courseID=c.courseId left join ContactInfo ci on ci.UserId=u.id where u.id=@i1 and c.courseName=@i2 and c.grade=@i3
 end
 go

 exec teachers_info @i1=5 , @i2='maths', @i3='eleven'
 
 --++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
 go
 create procedure delete_user
 @i1 int
 as
 begin
 delete from user1 where id=@i1
 end
 go
 exec delete_user @i1=2
 --+++++++++++++++++++++ for testing +++++++++++++++++++++++++++++++++++++++++++++++++++++++
 select * from registered_teacher_courses
 select * from teacher
 select * from course
 insert into user1(id) values(3)
 insert into user1(id) values(4)
 insert into teacher(UserId) values( 3)  --for testing
 insert into course(courseId) values(5)  -- for testing
 insert into student(UserId) values (4)
 insert into registered_teacher_courses(feepermonth, tid, courseID)
 values (3000, 3, 5)  

 -------------------++++++++ proc for teacher registered courses +++++++++++++++++++++++------------------
 --takes teacher registration info and stored into the table
 --updates the count of registered courses of every teacher
 go
 create procedure register_courseteacher 
 @tid int, @courseid int, @no_ofdays_perweek int, @date_ofhiring date
 , @fee_per_month int
 as
 begin
 insert into registered_teacher_courses 
 (tid, courseID,NoOfdays_per_week, dateOfHiring, feepermonth)
  values 
 (@tid, @courseid, @no_ofdays_perweek, @date_ofhiring, @fee_per_month) 

 declare @count_of_courses int
 select @count_of_courses= count (*) from registered_teacher_courses
 group by tid having tid= @tid
 update teacher set no_of_course= @count_of_courses where [teacher].UserId= @tid
 end
 go
 
  exec register_course_teacher @tid= 3, @courseid= 5 , 
  @no_ofdays_perweek= 5, @date_ofhiring='20190512 10:34:09 AM', 
  @fee_per_month= 2000

  select * from registered_teacher_courses

  ---++++++++++proc for current courses teacher teaching +++++++++++++++++++++++++++++++-------------
  --views the current courses a teacher is teaching
  go
   create view current_courses
   as
   select pay.TID, pay.SID, user1.name as student_name, pay.courseid,
    course.courseName, course.grade
    from pay join
   course on course.courseId= pay.courseid  
   join user1 on user1.id= pay.SID
   go

   go
   create procedure current_teachingcourses
   @tid int
   as begin
   select * from current_courses where tid= @tid
   end
   go
   exec current_teachingcourses @tid= 3--testing

  ---++++++++++++++++++++++++ registered courses of students++++++++++++++++++++++++++++++++++++-------
  --this proceudre first registers a course by a student and then adds the payment into the pay table
  -- and adds the count of registered courses into the students table
  go
  create procedure students_registered_courses
  @tid int, @sid int, @courseid int, @duration int
  as begin
  insert into student_courses (tid,[SID],COURSE,duration_months)
  values (@tid, @sid, @courseid,@duration)
  declare @feepermonth int --to get fee per month of that teacher
  select @feepermonth= registered_teacher_courses.feepermonth from 
  registered_teacher_courses where tid= @tid 
  insert into PAY (TID, [SID],[courseid], TOTALAMOUNT, paidstatus) 
  values (@tid, @sid,@courseid, @feepermonth,'not paid') 
  
  declare  @count_of_courses int
  select @count_of_courses= count(*) from student_courses group by [SID]
  having [sid]= @sid
  update student set [registered COURSES] = @count_of_courses where UserId= @sid
  end  
  go

  execute students_registered_courses --test execute
  @tid=3, @sid= 4, @courseid=5, @duration= 2

  
--+++++++proc for details of registered courses student currently taking------
   --gives details of current courses student has registered in
   go
   create view current_coursesstudent
   as
   select pay.SID,pay.TID,  user1.name as teacher_name, pay.courseid,
    course.courseName, course.grade
    from pay join
   course on course.courseId= pay.courseid  
   join user1 on user1.id= pay.[TID]
  go
  
  go
  create procedure student_currentcourses
  @sid int
  as begin
  select * from current_coursesstudent where SID= @sid
  end
  go
  ----++++++++++++ proc for view pyament details of registered users ++++++++++++++++++++++++++++++++-----
  -- gives payment detail of teacher or student 
 go
 create procedure get_payment_details @id int
 as begin
 if( (select [role] from user1 where [user1].id= @id) = 'student')
 begin  
 select * from PAY where [sid]= @id
 end
 else 
 begin
 select * from PAY where [TID]= @id
 end
 end
 go

 exec get_payment_details @id=3 -- for testing
