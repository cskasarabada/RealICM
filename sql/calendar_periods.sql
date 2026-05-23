
select org_id, calendar_id, period_type_id, creation_date, last_update_date
  from cn_repositories_all_b crab

select period_name, period_id, b.calendar_id, b.period_number, b.start_date, b.end_date, b.creation_date, b.last_update_date
  from cn_periods_b b, cn_periods_tl n
 where b.period_id = n.period_id
   and n.language = 'US'
   
   
   
select creation_date, last_update_date
  from 

select 
crab.org_id, 
crab.calendar_id, 
cct.CALENDAR_NAME,
n.period_type,
crab.period_type_id, 
n.period_name, b.period_id, b.period_number, trunc(b.start_date), trunc(b.end_date)
  from cn_periods_b b, cn_periods_tl n,
  cn_repositories_all_b crab,
  cn_calendars_tl cct
 where b.period_id = n.period_id
 and crab.calendar_id = b.calendar_id
   and n.language = 'US'
  and  cct.calendar_id= crab.calendar_id
   and CALENDAR_NAME = 'McAfee 445 Monthly Calendar'
   and n.period_type_id =-1001
   
   
   