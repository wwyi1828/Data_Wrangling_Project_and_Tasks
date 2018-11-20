select * into wwu.final from [wwu].[IC_BP]
select * from [wwu].[final]
drop table wwu.final
drop table wwu.amerge
--Problem 1
--a)
EXEC sp_rename '[wwu].[final].[BPAlerts]','BPStatus';
select * from wwu.final
--b)
alter table [wwu].[final] add blood_pressure VARCHAR(255);
update [wwu].[final] set blood_pressure='0' where
[BPStatus]='Hypo1';
update  [wwu].[final] set blood_pressure='0' where
[BPStatus] ='Normal';
update [wwu].[final] set blood_pressure='1' where
[BPStatus] ='Hypo2';
update [wwu].[final] set blood_pressure='1' where
[BPStatus] ='HTN1';
update [wwu].[final] set blood_pressure='1' where
[BPStatus] ='HTN2';
update [wwu].[final] set blood_pressure='1' where
[BPStatus] ='HTN3';

--c)
select A.*, B.* into wwu.amerge from [wwu].[final] A
inner join
[dbo].[Demographics] B
on A.[ID]=B.[contactid];
select * from wwu.amerge
select * from wwu.final

--d)
select ID, datediff(week, try_convert(date,[tri_enrollmentcompletedate]),[ObservedTime]) as weeknumber,
AVG(try_convert(float,[blood_pressure])) as avgbp
from wwu.amerge
where datediff(week, try_convert(date,[tri_enrollmentcompletedate]),[ObservedTime]) <= 12 AND
datediff(week, try_convert(date,[tri_enrollmentcompletedate]),[ObservedTime])>0
group by ID, datediff(week, try_convert(date,[tri_enrollmentcompletedate]),[ObservedTime])


--e)
select X.ID, X.[12wk], coalesce(Y.[1wk],0) as [1wk]
from (
select ID, AVG(try_convert(float,[blood_pressure])) as '12wk'
from wwu.amerge 
where [ObservedTime] between dateadd(week,11,try_convert(date,[tri_enrollmentcompletedate])) AND
dateadd(week,12,try_convert(date,[tri_enrollmentcompletedate]))
group by ID) X
left join ( select ID, AVG(try_convert(float,[blood_pressure])) as '1wk'
from [wwu].[amerge]
where [ObservedTime] between try_convert(date,[tri_enrollmentcompletedate]) AND
DATEADD(week, 1, try_convert(date,[tri_enrollmentcompletedate]))
group by ID) Y
on X.ID=Y.ID; 



--Problem2
select A.*, B.*, C.* into wwu.merge3 from [dbo].[Demographics] A
inner join
[dbo].[ChronicConditions] B
on A.[contactid]=B.[tri_patientid]
inner join
[dbo].[Text] C
on A.[contactid]=C.[tri_contactId];


SELECT [contactid],
Max([TextSentDate]) as MostRecentDate into wwu.test
from [wwu].[merge3]
group by [contactid]

select *
from wwu.merge3 A
inner join 
wwu.test B
on A.contactid=B.contactid
AND A.TextSentDate=B.MostRecentDate
