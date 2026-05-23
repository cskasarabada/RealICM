
select (pd.attribute_number2/364)"DailyOTV",
pd.attribute_number2,
(NVL(pd.end_date,TO_DATE(srp.end_date,'YYYY-MM-DD')) - TO_DATE((greatest(pd.start_date,srp.start_date)),'YYYY-MM-DD')+1)"ProratedDAYS",
pd.start_date,
pd.end_date,
EXTRACT (YEAR FROM TO_DATE(PD.END_DATE,'YYYY-MM-DD')) "DetailsYear",
EXTRACT (YEAR FROM TO_DATE( nvl(srp.end_date,sysdate),'YYYY-MM-DD'))"SRPYear"
from 
cn_srp_participant_details_all pd,cn_srp_comp_plans_all srp
where 1=1
and pd.participant_id=srp.participant_id 
---and EXTRACT (YEAR FROM TO_DATE(PD.START_DATE,'YYYY-MM-DD')) = EXTRACT (YEAR FROM TO_DATE( nvl(srp.end_date,sysdate),'YYYY-MM-DD'))
and pd.participant_id  = 18001

------
select 
((NVL(pd.end_date,TO_DATE(srp.end_date,'YYYY-MM-DD')) - TO_DATE((greatest(pd.start_date,srp.start_date)), 'YYYY-MM-DD')+1)*(pd.attribute_number2/364))"ProRatedOTV",
pd.attribute_number2,
(NVL(pd.end_date,TO_DATE(srp.end_date,'YYYY-MM-DD')) - TO_DATE((greatest(pd.start_date,srp.start_date)),'YYYY-MM-DD')+1)"ProratedDAYS",
pd.start_date,
pd.end_date,
EXTRACT (YEAR FROM TO_DATE(PD.END_DATE,'YYYY-MM-DD')) "DetailsYear",
EXTRACT (YEAR FROM TO_DATE( nvl(srp.end_date,sysdate),'YYYY-MM-DD'))"SRPYear"
from 
cn_srp_participant_details_all pd,cn_srp_comp_plans_all srp
where 1=1
and pd.participant_id=srp.participant_id 
---and EXTRACT (YEAR FROM TO_DATE(PD.START_DATE,'YYYY-MM-DD')) = EXTRACT (YEAR FROM TO_DATE( nvl(srp.end_date,sysdate),'YYYY-MM-DD'))
and pd.participant_id  = 18001

-------working model 1 ---------
select pd.attribute_number2 "OTV AMOUNT",
trunc((pd.attribute_number2*(NVL(pd.end_date,TO_DATE(srp.end_date,'YYYY-MM-DD')) - TO_DATE((greatest(pd.start_date,srp.start_date)),'YYYY-MM-DD')+1))/364,5) "PRORATED_OTV",
(NVL(pd.end_date,TO_DATE(srp.end_date,'YYYY-MM-DD')) - TO_DATE((greatest(pd.start_date,srp.start_date)),'YYYY-MM-DD')+1)"ProratedDAYS",
pd.start_date,
pd.end_date,
EXTRACT (YEAR FROM TO_DATE(nvl(PD.END_DATE,sysdate),'YYYY-MM-DD')) "DetailsYear",
EXTRACT (YEAR FROM TO_DATE( nvl(srp.end_date,sysdate),'YYYY-MM-DD'))"SRPYear",
pd.participant_detail_id
from 
cn_srp_participant_details_all pd,cn_srp_comp_plans_all srp
where 1=1
and pd.participant_id=srp.participant_id 
---and EXTRACT (YEAR FROM TO_DATE(PD.START_DATE,'YYYY-MM-DD')) = EXTRACT (YEAR FROM TO_DATE( nvl(srp.end_date,sysdate),'YYYY-MM-DD'))
and pd.participant_id  = 18001
--working Model 2 ---- without NEgative Days ----

select 
to_char(pd.start_date,'MM/DD/YYYY') "Effective Start Date",
to_char(pd.end_date,'MM/DD/YYYY')  "Effective End Date",
pd.attribute_number2 "OTV AMOUNT",
trunc((pd.attribute_number2*(NVL(pd.end_date,TO_DATE(srp.end_date,'YYYY-MM-DD')) - TO_DATE((greatest(pd.start_date,srp.start_date)),'YYYY-MM-DD')+1))/364,5) "PRORATED_OTV",
(NVL(pd.end_date,TO_DATE(srp.end_date,'YYYY-MM-DD')) - TO_DATE((greatest(pd.start_date,srp.start_date)),'YYYY-MM-DD')+1)"ProratedDAYS",
---EXTRACT (YEAR FROM TO_DATE(nvl(PD.END_DATE,sysdate),'YYYY-MM-DD')) "DetailsYear",
EXTRACT (YEAR FROM TO_DATE( nvl(srp.end_date,sysdate),'YYYY-MM-DD'))"Comp_Plan_Year",
pd.participant_detail_id
from 
cn_srp_participant_details_all pd,cn_srp_comp_plans_all srp
where 1=1
and pd.participant_id=srp.participant_id 
and (NVL(pd.end_date,TO_DATE(srp.end_date,'YYYY-MM-DD')) - TO_DATE((greatest(pd.start_date,srp.start_date)),'YYYY-MM-DD')+1) > 0
---and EXTRACT (YEAR FROM TO_DATE(PD.START_DATE,'YYYY-MM-DD')) = EXTRACT (YEAR FROM TO_DATE( nvl(srp.end_date,sysdate),'YYYY-MM-DD'))
and pd.participant_id  = 18001
--------------

select 
to_char(pd.start_date,'MM/DD/YYYY') "Effective Start Date",
to_char(pd.end_date,'MM/DD/YYYY')  "Effective End Date",
pd.attribute_number2 "OTV AMOUNT",
trunc((pd.attribute_number2*(NVL(pd.end_date,TO_DATE(srp.end_date,'YYYY-MM-DD')) - TO_DATE((greatest(pd.start_date,srp.start_date)),'YYYY-MM-DD')+1))/364,5) "PRORATED_OTV",
(NVL(pd.end_date,TO_DATE(srp.end_date,'YYYY-MM-DD')) - TO_DATE((greatest(pd.start_date,srp.start_date)),'YYYY-MM-DD')+1)"ProratedDAYS",
---EXTRACT (YEAR FROM TO_DATE(nvl(PD.END_DATE,sysdate),'YYYY-MM-DD')) "DetailsYear",
EXTRACT (YEAR FROM TO_DATE( nvl(srp.end_date,sysdate),'YYYY-MM-DD'))"Comp_Plan_Year",
Sum(trunc((pd.attribute_number2*(NVL(pd.end_date,TO_DATE(srp.end_date,'YYYY-MM-DD')) - TO_DATE((greatest(pd.start_date,srp.start_date)),'YYYY-MM-DD')+1))/364,5) )"SUMProratedAmt"
from 
cn_srp_participant_details_all pd,cn_srp_comp_plans_all srp
where 1=1
and pd.participant_id=srp.participant_id 
and (NVL(pd.end_date,TO_DATE(srp.end_date,'YYYY-MM-DD')) - TO_DATE((greatest(pd.start_date,srp.start_date)),'YYYY-MM-DD')+1) > 0
---and EXTRACT (YEAR FROM TO_DATE(PD.START_DATE,'YYYY-MM-DD')) = EXTRACT (YEAR FROM TO_DATE( nvl(srp.end_date,sysdate),'YYYY-MM-DD'))
and pd.participant_id  = 18001
Group by EXTRACT (YEAR FROM TO_DATE( nvl(srp.end_date,sysdate),'YYYY-MM-DD')

-----
Sum(trunc((pd.attribute_number2*(NVL(pd.end_date,TO_DATE(srp.end_date,'YYYY-MM-DD'))- TO_DATE((greatest(pd.start_date,srp.start_date)),'YYYY-MM-DD')+1))/364,5) )"SUMProratedAmt"
select pd.attribute_number2 "OTV AMOUNT",
trunc((pd.attribute_number2*(NVL(pd.end_date,TO_DATE(srp.end_date,'YYYY-MM-DD')) - TO_DATE((greatest(pd.start_date,srp.start_date)),'YYYY-MM-DD')+1))/364,5) "PRORATED_OTV",
(NVL(pd.end_date,TO_DATE(srp.end_date,'YYYY-MM-DD')) - TO_DATE((greatest(pd.start_date,srp.start_date)),'YYYY-MM-DD')+1)"ProratedDAYS",
EXTRACT (YEAR FROM TO_DATE( nvl(srp.end_date,sysdate),'YYYY-MM-DD'))"Comp_Plan_Year",
(Select Sum(trunc((pd1.attribute_number2*(NVL(pd1.end_date,TO_DATE(srp1.end_date,'YYYY-MM-DD')) -TO_DATE((greatest(pd1.start_date,srp1.start_date)),'YYYY-MM-DD')+1))/364,5)) OTV_Prorated_4_YR
from cn_srp_participant_details_all pd1,cn_srp_comp_plans_all srp1
where 1=1
and pd1.participant_id=srp1.participant_id 
and pd1.participant_id = pd.participant_id 
and EXTRACT (YEAR FROM TO_DATE( nvl(srp1.end_date,sysdate),'YYYY-MM-DD')) = 2019
)"SummedProratedValue"
from 
cn_srp_participant_details_all pd,cn_srp_comp_plans_all srp
where 1=1
and pd.participant_id=srp.participant_id 
and (NVL(pd.end_date,TO_DATE(srp.end_date,'YYYY-MM-DD')) - TO_DATE((greatest(pd.start_date,srp.start_date)),'YYYY-MM-DD')+1) > 0
---and EXTRACT (YEAR FROM TO_DATE(PD.START_DATE,'YYYY-MM-DD')) = 
EXTRACT (YEAR FROM TO_DATE( nvl(srp.end_date,sysdate),'YYYY-MM-DD'))
and pd.participant_id  = 18001

----
select pd.attribute_number2 "OTV AMOUNT",
trunc((pd.attribute_number2*(NVL(pd.end_date,TO_DATE(srp.end_date,'YYYY-MM-DD')) - TO_DATE((greatest(pd.start_date,srp.start_date)),'YYYY-MM-DD')+1))/364,5) "PRORATED_OTV",
(NVL(pd.end_date,TO_DATE(srp.end_date,'YYYY-MM-DD')) - TO_DATE((greatest(pd.start_date,srp.start_date)),'YYYY-MM-DD')+1)"ProratedDAYS",
---EXTRACT (YEAR FROM TO_DATE(nvl(PD.END_DATE,sysdate),'YYYY-MM-DD')) "DetailsYear",
EXTRACT (YEAR FROM TO_DATE( nvl(srp.end_date,sysdate),'YYYY-MM-DD'))"Comp_Plan_Year",
(Select Sum(trunc((pd1.attribute_number2*(NVL(pd1.end_date,TO_DATE(srp1.end_date,'YYYY-MM-DD')) -TO_DATE((greatest(pd1.start_date,srp1.start_date)),'YYYY-MM-DD')+1))/364,5)) OTV_Prorated_4_YR
from cn_srp_participant_details_all pd1,cn_srp_comp_plans_all srp1
where 1=1
and pd1.participant_id=srp1.participant_id 
and pd1.participant_id = 18001
and EXTRACT (YEAR FROM TO_DATE( nvl(srp1.end_date,sysdate),'YYYY-MM-DD')) = 2019)"OTV_ProatedForFyYr"
from 
cn_srp_participant_details_all pd,cn_srp_comp_plans_all srp
where 1=1
and pd.participant_id=srp.participant_id 
and (NVL(pd.end_date,TO_DATE(srp.end_date,'YYYY-MM-DD')) - TO_DATE((greatest(pd.start_date,srp.start_date)),'YYYY-MM-DD')+1) > 0
---and EXTRACT (YEAR FROM TO_DATE(PD.START_DATE,'YYYY-MM-DD')) = EXTRACT (YEAR FROM TO_DATE( nvl(srp.end_date,sysdate),'YYYY-MM-DD'))
and pd.participant_id  = 18001

-----working----
Select Sum(trunc((pd1.attribute_number2*(NVL(pd1.end_date,TO_DATE(srp1.end_date,'YYYY-MM-DD')) -TO_DATE((greatest(pd1.start_date,srp1.start_date)),'YYYY-MM-DD')+1))/364,5)) OTV_Prorated_4_YR
from cn_srp_participant_details_all pd1,cn_srp_comp_plans_all srp1
where 1=1
and pd1.participant_id=srp1.participant_id 
and pd1.participant_id = 18001
and EXTRACT (YEAR FROM TO_DATE( nvl(srp1.end_date,sysdate),'YYYY-MM-DD')) = 2019

-----Workin Example- ONLY SUM-----

Select Sum(trunc((pd1.attribute_number2*(NVL(pd1.end_date,TO_DATE(srp1.end_date,'YYYY-MM-DD')) -TO_DATE((greatest(pd1.start_date,srp1.start_date)),'YYYY-MM-DD')+1))/364,5)) OTV_Prorated_4_YR
from cn_srp_participant_details_all pd1,cn_srp_comp_plans_all srp1
where 1=1
and pd1.participant_id=srp1.participant_id 
and pd1.participant_id =  pd.partii
and (NVL(pd1.end_date,TO_DATE(srp1.end_date,'YYYY-MM-DD')) - TO_DATE((greatest(pd1.start_date,srp1.start_date)),'YYYY-MM-DD')+1) > 0
and EXTRACT (YEAR FROM TO_DATE( nvl(srp1.end_date,sysdate),'YYYY-MM-DD')) = 2020
------working 
select pd.attribute_number2 "OTV AMOUNT",
trunc((pd.attribute_number2*(NVL(pd.end_date,TO_DATE(srp.end_date,'YYYY-MM-DD')) - TO_DATE((greatest(pd.start_date,srp.start_date)),'YYYY-MM-DD')+1))/364,5) "PRORATED_OTV",
(NVL(pd.end_date,TO_DATE(srp.end_date,'YYYY-MM-DD')) - TO_DATE((greatest(pd.start_date,srp.start_date)),'YYYY-MM-DD')+1)"ProratedDAYS",
---EXTRACT (YEAR FROM TO_DATE(nvl(PD.END_DATE,sysdate),'YYYY-MM-DD')) "DetailsYear",
EXTRACT (YEAR FROM TO_DATE( nvl(srp.end_date,sysdate),'YYYY-MM-DD'))"Comp_Plan_Year",
(Select Sum(trunc((pd1.attribute_number2*(NVL(pd1.end_date,TO_DATE(srp1.end_date,'YYYY-MM-DD')) -TO_DATE((greatest(pd1.start_date,srp1.start_date)),'YYYY-MM-DD')+1))/364,5)) OTV_Prorated_4_YR
from cn_srp_participant_details_all pd1,cn_srp_comp_plans_all srp1
where 1=1
and pd1.participant_id=srp1.participant_id 
and pd1.participant_id = 18001
and EXTRACT (YEAR FROM TO_DATE( nvl(srp1.end_date,sysdate),'YYYY-MM-DD')) = 2019)"OTV_ProatedForFyYr"
from 
cn_srp_participant_details_all pd,cn_srp_comp_plans_all srp
where 1=1
and pd.participant_id=srp.participant_id 
and (NVL(pd.end_date,TO_DATE(srp.end_date,'YYYY-MM-DD')) - TO_DATE((greatest(pd.start_date,srp.start_date)),'YYYY-MM-DD')+1) > 0
---and EXTRACT (YEAR FROM TO_DATE(PD.START_DATE,'YYYY-MM-DD')) = EXTRACT (YEAR FROM TO_DATE( nvl(srp.end_date,sysdate),'YYYY-MM-DD'))
and pd.participant_id  = 18001
-------

select to_char(pd.start_date,'MM/DD/YYYY') "Effective Start Date",
to_char(pd.end_date,'MM/DD/YYYY')  "Effective End Date",
pd.attribute_number2 "OTV AMOUNT",
trunc((pd.attribute_number2*(NVL(pd.end_date,TO_DATE(srp.end_date,'YYYY-MM-DD')) - TO_DATE((greatest(pd.start_date,srp.start_date)),'YYYY-MM-DD')+1))/364,5) "PRORATED_OTV",
(NVL(pd.end_date,TO_DATE(srp.end_date,'YYYY-MM-DD')) - TO_DATE((greatest(pd.start_date,srp.start_date)),'YYYY-MM-DD')+1)"ProratedDAYS",
---EXTRACT (YEAR FROM TO_DATE(nvl(PD.END_DATE,sysdate),'YYYY-MM-DD')) "DetailsYear",
EXTRACT (YEAR FROM TO_DATE( nvl(srp.end_date,sysdate),'YYYY-MM-DD'))"Comp_Plan_Year",
(Select Sum(trunc((pd1.attribute_number2*(NVL(pd1.end_date,TO_DATE(srp1.end_date,'YYYY-MM-DD')) -TO_DATE((greatest(pd1.start_date,srp1.start_date)),'YYYY-MM-DD')+1))/364,5)) OTV_Prorated_4_YR
from cn_srp_participant_details_all pd1,cn_srp_comp_plans_all srp1
where 1=1
and pd1.participant_id=srp1.participant_id 
and pd1.participant_id = pd.participant_id
and EXTRACT (YEAR FROM TO_DATE( nvl(srp1.end_date,sysdate),'YYYY-MM-DD')) = EXTRACT (YEAR FROM TO_DATE( nvl(srp.end_date,sysdate),'YYYY-MM-DD'))
)"OTV_ProatedForFyYr"
from 
cn_srp_participant_details_all pd,cn_srp_comp_plans_all srp
where 1=1
and pd.participant_id=srp.participant_id 
and (NVL(pd.end_date,TO_DATE(srp.end_date,'YYYY-MM-DD')) - TO_DATE((greatest(pd.start_date,srp.start_date)),'YYYY-MM-DD')+1) > 0
---and EXTRACT (YEAR FROM TO_DATE(PD.START_DATE,'YYYY-MM-DD')) = EXTRACT (YEAR FROM TO_DATE( nvl(srp.end_date,sysdate),'YYYY-MM-DD'))
and pd.participant_id  = 18001
--------------
select 
to_char(srp.start_date,'MM/DD/YYYY') Comp_Plan_Start_Date,
to_char(srp.end_date,'MM/DD/YYYY') Comp_Plan_end_Date,
to_char(pd.start_date,'MM/DD/YYYY') "Effective Start Date",
to_char(pd.end_date,'MM/DD/YYYY')  "Effective End Date",
pd.attribute_number2 "OTV AMOUNT",
trunc((pd.attribute_number2*(NVL(pd.end_date,TO_DATE(srp.end_date,'YYYY-MM-DD')) - TO_DATE((greatest(pd.start_date,srp.start_date)),'YYYY-MM-DD')+1))/364,5) "PRORATED_OTV",
(NVL(pd.end_date,TO_DATE(srp.end_date,'YYYY-MM-DD')) - TO_DATE((greatest(pd.start_date,srp.start_date)),'YYYY-MM-DD')+1)"ProratedDAYS",
---EXTRACT (YEAR FROM TO_DATE(nvl(PD.END_DATE,sysdate),'YYYY-MM-DD')) "DetailsYear",
EXTRACT (YEAR FROM TO_DATE( nvl(srp.end_date,sysdate),'YYYY-MM-DD'))"Comp_Plan_Year"
from 
cn_srp_participant_details_all pd,cn_srp_comp_plans_all srp
where 1=1
and pd.participant_id=srp.participant_id 
and (NVL(pd.end_date,TO_DATE(srp.end_date,'YYYY-MM-DD')) - TO_DATE((greatest(pd.start_date,srp.start_date)),'YYYY-MM-DD')+1) > 0
---and EXTRACT (YEAR FROM TO_DATE(PD.START_DATE,'YYYY-MM-DD')) = EXTRACT (YEAR FROM TO_DATE( nvl(srp.end_date,sysdate),'YYYY-MM-DD'))
and pd.participant_id  = 18001

------Working Example---- for ----
select to_char(pd.start_date,'MM/DD/YYYY') "Effective Start Date",
to_char(pd.end_date,'MM/DD/YYYY')  "Effective End Date",
pd.attribute_number2 "OTV AMOUNT",
trunc((pd.attribute_number2*(NVL(pd.end_date,TO_DATE(srp.end_date,'YYYY-MM-DD')) - TO_DATE((greatest(pd.start_date,srp.start_date)),'YYYY-MM-DD')+1))/364,5) "PRORATED_OTV",
(NVL(pd.end_date,TO_DATE(srp.end_date,'YYYY-MM-DD')) - TO_DATE((greatest(pd.start_date,srp.start_date)),'YYYY-MM-DD')+1)"ProratedDAYS",
---EXTRACT (YEAR FROM TO_DATE(nvl(PD.END_DATE,sysdate),'YYYY-MM-DD')) "DetailsYear",
EXTRACT (YEAR FROM TO_DATE( nvl(srp.end_date,sysdate),'YYYY-MM-DD'))"Comp_Plan_Year",
(Select Sum(trunc((pd1.attribute_number2*(NVL(pd1.end_date,TO_DATE(srp1.end_date,'YYYY-MM-DD')) -TO_DATE((greatest(pd1.start_date,srp1.start_date)),'YYYY-MM-DD')+1))/364,5)) OTV_Prorated_4_YR
from cn_srp_participant_details_all pd1,cn_srp_comp_plans_all srp1
where 1=1
and pd1.participant_id=srp1.participant_id 
and pd1.participant_id = pd.participant_id
and (NVL(pd1.end_date,TO_DATE(srp1.end_date,'YYYY-MM-DD')) - TO_DATE((greatest(pd1.start_date,srp1.start_date)),'YYYY-MM-DD')+1) > 0
and EXTRACT (YEAR FROM TO_DATE( nvl(srp1.end_date,sysdate),'YYYY-MM-DD')) = EXTRACT (YEAR FROM TO_DATE( nvl(srp.end_date,sysdate),'YYYY-MM-DD'))
)"OTV_ProatedForFyYr"
from 
cn_srp_participant_details_all pd,cn_srp_comp_plans_all srp
where 1=1
and pd.participant_id=srp.participant_id 
and (NVL(pd.end_date,TO_DATE(srp.end_date,'YYYY-MM-DD')) - TO_DATE((greatest(pd.start_date,srp.start_date)),'YYYY-MM-DD')+1) > 0
---and EXTRACT (YEAR FROM TO_DATE(PD.START_DATE,'YYYY-MM-DD')) = EXTRACT (YEAR FROM TO_DATE( nvl(srp.end_date,sysdate),'YYYY-MM-DD'))
and pd.participant_id  = 18001

------- OTV Prorations with the Currency Conversions--------------
select to_char(pd.start_date,'MM/DD/YYYY') "Effective Start Date",
to_char(pd.end_date,'MM/DD/YYYY')  "Effective End Date",
pd.attribute_number2 "OTV AMOUNT",
(SELECT
pda2.attribute_number2 * cr.conversion_rate 
FROM
cn_srp_participant_details_all pda2,
CN_CONVERSION_rates cr,
CN_CONVERSION_TYPES_TL ct
WHERE 1=1
AND pda2.attribute_number1 IS NOT NULL
AND pda2.attribute_number1 <> 0
AND pda2.currency_code =cr.from_currency
and ct.language ='US'
AND pda2.currency_code <>'USD'
-- AND pda.end_date is null
AND pda2.participant_id = pd.participant_id
and pda2.participant_detail_id = pd.participant_detail_id 
and (pda2.Start_date between cr.CONVERSION_START_DATE AND cr.CONVERSION_END_DATE
or  nvl(pda2.end_date, sysdate) <=cr.CONVERSION_END_DATE)
AND ct.CONVERSION_TYPE_ID = cr.CONVERSION_TYPE_ID
AND ct.conversion_name = 'Incentive Compensation Annual Rate'
and EXTRACT (YEAR FROM TO_DATE(cr.CONVERSION_END_DATE,'YYYY-MM-DD')) = EXTRACT (YEAR FROM TO_DATE( nvl(pda2.end_date,sysdate),'YYYY-MM-DD'))
)"Converted_OTV",
trunc((pd.attribute_number2*(NVL(pd.end_date,TO_DATE(srp.end_date,'YYYY-MM-DD')) - TO_DATE((greatest(pd.start_date,srp.start_date)),'YYYY-MM-DD')+1))/364,5) "PRORATED_OTV",
(NVL(pd.end_date,TO_DATE(srp.end_date,'YYYY-MM-DD')) - TO_DATE((greatest(pd.start_date,srp.start_date)),'YYYY-MM-DD')+1)"ProratedDAYS",
---EXTRACT (YEAR FROM TO_DATE(nvl(PD.END_DATE,sysdate),'YYYY-MM-DD')) "DetailsYear",
EXTRACT (YEAR FROM TO_DATE( nvl(srp.end_date,sysdate),'YYYY-MM-DD'))"Comp_Plan_Year",
(Select Sum(trunc((pd1.attribute_number2*(NVL(pd1.end_date,TO_DATE(srp1.end_date,'YYYY-MM-DD')) -TO_DATE((greatest(pd1.start_date,srp1.start_date)),'YYYY-MM-DD')+1))/364,5)) OTV_Prorated_4_YR
from cn_srp_participant_details_all pd1,cn_srp_comp_plans_all srp1
where 1=1
and pd1.participant_id=srp1.participant_id 
and pd1.participant_id = pd.participant_id
and (NVL(pd1.end_date,TO_DATE(srp1.end_date,'YYYY-MM-DD')) - TO_DATE((greatest(pd1.start_date,srp1.start_date)),'YYYY-MM-DD')+1) > 0
and EXTRACT (YEAR FROM TO_DATE( nvl(srp1.end_date,sysdate),'YYYY-MM-DD')) = EXTRACT (YEAR FROM TO_DATE( nvl(srp.end_date,sysdate),'YYYY-MM-DD'))
)"OTV_ProatedForFyYr"
from 
cn_srp_participant_details_all pd,cn_srp_comp_plans_all srp
where 1=1
and pd.participant_id=srp.participant_id 
and (NVL(pd.end_date,TO_DATE(srp.end_date,'YYYY-MM-DD')) - TO_DATE((greatest(pd.start_date,srp.start_date)),'YYYY-MM-DD')+1) > 0
---and EXTRACT (YEAR FROM TO_DATE(PD.START_DATE,'YYYY-MM-DD')) = EXTRACT (YEAR FROM TO_DATE( nvl(srp.end_date,sysdate),'YYYY-MM-DD'))
and pd.participant_id  = 18001

------Separate Currency Conversion for OTV----
SELECT
pda2.attribute_number2 * cr.conversion_rate 
FROM
cn_srp_participant_details_all pda2,
CN_CONVERSION_rates cr,
CN_CONVERSION_TYPES_TL ct
WHERE 1=1
AND pda2.attribute_number1 IS NOT NULL
AND pda2.attribute_number1 <> 0
AND pda2.currency_code =cr.from_currency
AND pda2.currency_code <>'USD'
and ct.language ='US'
-- AND pda.end_date is null
AND pda2.participant_id = pd.participant_id
and (pda2.Start_date between cr.CONVERSION_START_DATE AND cr.CONVERSION_END_DATE
or  nvl(pda2.end_date, sysdate) <=cr.CONVERSION_END_DATE)
AND ct.CONVERSION_TYPE_ID = cr.CONVERSION_TYPE_ID
AND ct.conversion_name = 'Incentive Compensation Annual Rate'
and EXTRACT (YEAR FROM TO_DATE(cr.CONVERSION_END_DATE,'YYYY-MM-DD')) = EXTRACT (YEAR FROM TO_DATE( nvl(pda2.end_date,sysdate),'YYYY-MM-DD'))
and pda2.participant_detail_id = pd.participant_detail_id 
----------------
------- OTV Prorations with the Currency Conversions--------------100%%%--- Working ---
select to_char(pd.start_date,'MM/DD/YYYY') "Effective Start Date",
to_char(pd.end_date,'MM/DD/YYYY')  "Effective End Date",
pd.attribute_number2 "OTV AMOUNT",
(SELECT
pda2.attribute_number2 * cr.conversion_rate 
FROM
cn_srp_participant_details_all pda2,
CN_CONVERSION_rates cr,
CN_CONVERSION_TYPES_TL ct
WHERE 1=1
AND pda2.attribute_number1 IS NOT NULL
AND pda2.attribute_number1 <> 0
AND pda2.currency_code =cr.from_currency
and ct.language ='US'
AND pda2.currency_code <>'USD'
-- AND pda.end_date is null
AND pda2.participant_id = pd.participant_id
and pda2.participant_detail_id = pd.participant_detail_id 
and (pda2.Start_date between cr.CONVERSION_START_DATE AND cr.CONVERSION_END_DATE
or  nvl(pda2.end_date, sysdate) <=cr.CONVERSION_END_DATE)
AND ct.CONVERSION_TYPE_ID = cr.CONVERSION_TYPE_ID
AND ct.conversion_name = 'Incentive Compensation Annual Rate'
and EXTRACT (YEAR FROM TO_DATE(cr.CONVERSION_END_DATE,'YYYY-MM-DD')) = EXTRACT (YEAR FROM TO_DATE( nvl(pda2.end_date,sysdate),'YYYY-MM-DD'))
)"Converted_OTV",
trunc((pd.attribute_number2*(NVL(pd.end_date,TO_DATE(srp.end_date,'YYYY-MM-DD')) - TO_DATE((greatest(pd.start_date,srp.start_date)),'YYYY-MM-DD')+1))/364,5) "PRORATED_OTV",
(NVL(pd.end_date,TO_DATE(srp.end_date,'YYYY-MM-DD')) - TO_DATE((greatest(pd.start_date,srp.start_date)),'YYYY-MM-DD')+1)"ProratedDAYS",
---EXTRACT (YEAR FROM TO_DATE(nvl(PD.END_DATE,sysdate),'YYYY-MM-DD')) "DetailsYear",
EXTRACT (YEAR FROM TO_DATE( nvl(srp.end_date,sysdate),'YYYY-MM-DD'))"Comp_Plan_Year",
(Select Sum(trunc((pd1.attribute_number2*(NVL(pd1.end_date,TO_DATE(srp1.end_date,'YYYY-MM-DD')) -TO_DATE((greatest(pd1.start_date,srp1.start_date)),'YYYY-MM-DD')+1))/364,5)) OTV_Prorated_4_YR
from cn_srp_participant_details_all pd1,cn_srp_comp_plans_all srp1
where 1=1
and pd1.participant_id=srp1.participant_id 
and pd1.participant_id = pd.participant_id
and (NVL(pd1.end_date,TO_DATE(srp1.end_date,'YYYY-MM-DD')) - TO_DATE((greatest(pd1.start_date,srp1.start_date)),'YYYY-MM-DD')+1) > 0
and EXTRACT (YEAR FROM TO_DATE( nvl(srp1.end_date,sysdate),'YYYY-MM-DD')) = EXTRACT (YEAR FROM TO_DATE( nvl(srp.end_date,sysdate),'YYYY-MM-DD'))
)"OTV_ProratedForFyYr",
(Select Sum(trunc((cr1.conversion_rate*
pda3.attribute_number2*(NVL(pda3.end_date,TO_DATE(srp3.end_date,'YYYY-MM-DD')) -TO_DATE((greatest(pda3.start_date,srp3.start_date)),'YYYY-MM-DD')+1))/364,5)) "Coverted_ProRated_YTD_OTV"
from 
cn_srp_participant_details_all pda3,
cn_srp_comp_plans_all srp3,
CN_CONVERSION_rates cr1,
CN_CONVERSION_TYPES_TL ct1
where 1=1
and pda3.participant_id=srp3.participant_id 
and pda3.participant_id = pd.participant_id
AND pda3.participant_detail_id = pd.participant_detail_id
AND pda3.currency_code =cr1.from_currency
and pda3.currency_code <>'USD'
and ct1.language ='US'
AND ct1.CONVERSION_TYPE_ID = cr1.CONVERSION_TYPE_ID
AND ct1.conversion_name = 'Incentive Compensation Annual Rate'
and (NVL(pda3.end_date,TO_DATE(srp3.end_date,'YYYY-MM-DD')) - TO_DATE((greatest(pda3.start_date,srp3.start_date)),'YYYY-MM-DD')+1) > 0
and EXTRACT (YEAR FROM TO_DATE( nvl(srp3.end_date,sysdate),'YYYY-MM-DD')) = EXTRACT (YEAR FROM TO_DATE( nvl(srp3.end_date,sysdate),'YYYY-MM-DD'))
and EXTRACT (YEAR FROM TO_DATE(cr1.CONVERSION_END_DATE,'YYYY-MM-DD')) = EXTRACT (YEAR FROM TO_DATE( nvl(pd.end_date,sysdate),'YYYY-MM-DD'))
)"Conv_OTV_Prora_4_FY_Yr"
from 
cn_srp_participant_details_all pd,cn_srp_comp_plans_all srp
where 1=1
and pd.participant_id=srp.participant_id 
and (NVL(pd.end_date,TO_DATE(srp.end_date,'YYYY-MM-DD')) - TO_DATE((greatest(pd.start_date,srp.start_date)),'YYYY-MM-DD')+1) > 0
---and EXTRACT (YEAR FROM TO_DATE(PD.START_DATE,'YYYY-MM-DD')) = EXTRACT (YEAR FROM TO_DATE( nvl(srp.end_date,sysdate),'YYYY-MM-DD'))
and pd.participant_id  = 18001
=================
(SELECT
pda2.attribute_number2 * cr.conversion_rate 
FROM
cn_srp_participant_details_all pda2,
CN_CONVERSION_rates cr,
CN_CONVERSION_TYPES_TL ct
WHERE 1=1
AND pda2.attribute_number1 IS NOT NULL
AND pda2.attribute_number1 <> 0
AND pda2.currency_code =cr.from_currency
and ct.language ='US'
AND pda2.currency_code <>'USD'
-- AND pda.end_date is null
AND pda2.participant_id = pd.participant_id
and pda2.participant_detail_id = pd.participant_detail_id 
and (pda2.Start_date between cr.CONVERSION_START_DATE AND cr.CONVERSION_END_DATE
or  nvl(pda2.end_date, sysdate) <=cr.CONVERSION_END_DATE)
AND ct.CONVERSION_TYPE_ID = cr.CONVERSION_TYPE_ID
AND ct.conversion_name = 'Incentive Compensation Annual Rate'
and EXTRACT (YEAR FROM TO_DATE(cr.CONVERSION_END_DATE,'YYYY-MM-DD')) = EXTRACT (YEAR FROM TO_DATE( nvl(pda2.end_date,sysdate),'YYYY-MM-DD'))
)"Converted_OTV"

Select Sum(trunc((cr1.conversion_rate*
pda3.attribute_number2*(NVL(pda3.end_date,TO_DATE(srp3.end_date,'YYYY-MM-DD')) -TO_DATE((greatest(pda3.start_date,srp3.start_date)),'YYYY-MM-DD')+1))/364,5)) "Coverted_ProRated_YTD_OTV"
from 
cn_srp_participant_details_all pda3,
cn_srp_comp_plans_all srp3,
CN_CONVERSION_rates cr1,
CN_CONVERSION_TYPES_TL ct1
where 1=1
and pda3.participant_id=srp3.participant_id 
and pda3.participant_id = pd.participant_id
AND pda3.participant_id = pd.participant_id
AND pda3.currency_code =cr1.from_currency
and pda3.currency_code <>'USD'
and ct1.language ='US'
AND ct1.CONVERSION_TYPE_ID = cr1.CONVERSION_TYPE_ID
AND ct1.conversion_name = 'Incentive Compensation Annual Rate'
and (NVL(pda3.end_date,TO_DATE(srp3.end_date,'YYYY-MM-DD')) - TO_DATE((greatest(pda3.start_date,srp3.start_date)),'YYYY-MM-DD')+1) > 0
and EXTRACT (YEAR FROM TO_DATE( nvl(srp3.end_date,sysdate),'YYYY-MM-DD')) = EXTRACT (YEAR FROM TO_DATE( nvl(srp3.end_date,sysdate),'YYYY-MM-DD'))
and EXTRACT (YEAR FROM TO_DATE(cr1.CONVERSION_END_DATE,'YYYY-MM-DD')) = EXTRACT (YEAR FROM TO_DATE( nvl(pd.end_date,sysdate),'YYYY-MM-DD'))

"Conv_OTV_Prora_4_FY_Yr"
--------------