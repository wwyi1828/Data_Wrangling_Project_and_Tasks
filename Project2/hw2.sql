select * into wwu.Phonecall from PhoneCall
select * into wwu.CallDuration from CallDuration
--select * from wwu.Phonecall
-- drop table wwu.Phonecall
-- drop table wwu.CallDuration
--Problem 1
alter table wwu.Phonecall add Enrollment_group VARCHAR(255)
update wwu.Phonecall set Enrollment_group='Clinical Alert' where [EncounterCode]='125060000';
update wwu.Phonecall set Enrollment_group='Health Coaching' where [EncounterCode]='125060001';
update wwu.Phonecall set Enrollment_group='Technixal Question' where [EncounterCode]='125060002';
update wwu.Phonecall set Enrollment_group='Administrative' where [EncounterCode]='125060003';
update wwu.Phonecall set Enrollment_group='Other' where [EncounterCode]='125060004';
update wwu.Phonecall set Enrollment_group='Lack of engagement' where [EncounterCode]='125060005';

--Problem 2
select Enrollment_group, count(*) as 'Number' 
from wwu.Phonecall
group by Enrollment_group

--Problem 3
select A.*, B.* into wwu.fstjoin from wwu.Phonecall A
inner join 
wwu.CallDuration B
on A.CustomerId=B.tri_CustomerIDEntityReference;
select * from wwu.fstjoin
--Problem 4
select CallOutcome, count(*) as 'Number' 
into wwu.callcounts 
from wwu.fstjoin 
group by CallOutcome;
select * from wwu.callcounts
alter table wwu.callcounts add Call_Outcome varchar(255)
update wwu.callcounts set Call_Outcome='No response' where [CallOutcome]= 1
update wwu.callcounts set Call_Outcome='Left voice mail' where [CallOutcome]= 2
update wwu.callcounts set Call_Outcome='successful' where [CallOutcome]= 3
select * from wwu.callcounts

select CallType, count(*) as 'Number' 
into wwu.typecounts
from wwu.fstjoin 
group by CallType;
select * from wwu.typecounts
alter table wwu.typecounts add Call_Type varchar(255)
update wwu.typecounts set Call_Type='Inbound' where [CallType]= 1
update wwu.typecounts set Call_Type='Outbound' where [CallType]= 2
select * from wwu.typecounts

select Enrollment_group, sum(CallDuration) as 'Total Duration'
from wwu.fstjoin group by Enrollment_group order by Enrollment_group

--Problem 5
select A.*, B.*, C.* into wwu.scdjoin from [dbo].[Text] A
left join [dbo].[ChronicConditions] B
on A.tri_contactId=B.tri_patientid
left join [dbo].[Demographics] C
on A.tri_contactId=C.contactid;

select SenderName, datediff(wk,min(wwu.scdjoin.TextSentDate),max(wwu.scdjoin.TextSentDate)) as 'weeks'
from wwu.scdjoin
group by SenderName
--Problem 6
Select * into wwu.texts from text
left join ChronicConditions
on ChronicConditions.tri_patientid=text.tri_contactId

select SenderName, datediff(wk,min(wwu.scdjoin.TextSentDate),max(wwu.scdjoin.TextSentDate)) as 'weeks'
from wwu.scdjoin
group by SenderName

select tri_name, count(*) SentTexts,
datediff(wk,min(wwu.scdjoin.TextSentDate),max(wwu.scdjoin.TextSentDate)) as 'weeks'
from wwu.scdjoin
where TextSentDate is not null
group by tri_name
