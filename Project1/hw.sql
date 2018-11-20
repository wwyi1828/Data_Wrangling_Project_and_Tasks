drop table wwu.hw1
select * into wwu.hw1 from Demographics

--Problem 1
EXEC sp_rename 'wwu.hw1.tri_age','Age';
EXEC sp_rename 'wwu.hw1.gendercode','Gender';
EXEC sp_rename 'wwu.hw1.contactid','ID';
EXEC sp_rename 'wwu.hw1.[address1_stateorprovince]','State';
EXEC sp_rename 'wwu.hw1.[tri_imaginecareenrollmentemailsentdate]','EmailSentdate';
EXEC sp_rename 'wwu.hw1.[tri_enrollmentcompletedate]','Completedate';
ALTER TABLE wwu.hw1 ADD TIMEINTERVAL int;
update wwu.hw1 set TIMEINTERVAL =  DATEDIFF(day,try_convert(date,EmailSentdate),try_convert(date,Completedate));
select TIMEINTERVAL from wwu.hw1;

--Problem 2
alter table wwu.hw1 add Enrollment_Status text;
update wwu.hw1 set Enrollment_Status='Complete' where [tri_imaginecareenrollmentstatus]='167410011';
update wwu.hw1 set Enrollment_Status='Email' where [tri_imaginecareenrollmentstatus]='167410001';
update wwu.hw1 set Enrollment_Status='Non responder' where [tri_imaginecareenrollmentstatus]='167410004';
update wwu.hw1 set Enrollment_Status='Facilitated Enrollment' where [tri_imaginecareenrollmentstatus]='167410005';
update wwu.hw1 set Enrollment_Status='Incomplete Enrollments' where [tri_imaginecareenrollmentstatus]='167410002';
update wwu.hw1 set Enrollment_Status='Opted Out' where [tri_imaginecareenrollmentstatus]='167410003';
update wwu.hw1 set Enrollment_Status='Unprocessed' where [tri_imaginecareenrollmentstatus]='167410000';
update wwu.hw1 set Enrollment_Status='Second email sent' where [tri_imaginecareenrollmentstatus]='167410006';
select Enrollment_Status from wwu.hw1
alter table wwu.hw1 add SEX text;
update wwu.hw1 set SEX='male' where [Gender]='1';
update wwu.hw1 set SEX='female' where [Gender]='2';
update wwu.hw1 set SEX='other' where [Gender]='167410000';
update wwu.hw1 set SEX='Unknown' where [Gender]='NULL';

--Problem 3
select max(Age) from wwu.hw1
alter table wwu.hw1 add Age_group text;
update wwu.hw1 set Age_group='0-25' where [Age]<=25;
update wwu.hw1 set Age_group='26-50' where [Age]>25 and [Age]<=50
update wwu.hw1 set Age_group='51-75' where [Age]>50 and [Age]<=75
update wwu.hw1 set Age_group='76-100' where [Age]>75 and [Age]<=100
