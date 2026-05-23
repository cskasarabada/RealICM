select /* SR 3-22190507981*/ n.plan_component_name, b.plan_component_id, b.incentive_type, b.start_date, b.end_date, b.earning_type_id, b.plan_comp_status
  from cn_plan_components_all_b b, cn_plan_components_all_tl n
 where b.plan_component_id = n.plan_component_id
   and n.plan_component_id in (300000003064080,300000002943100)
   
   
   30006)
   
   SELECT /* SR 3-21529670871 */
period_id,
round(SUM(
(NVL(srp.balance2_bbd,0) - NVL(srp.balance2_bbc,0)) +
(NVL(srp.balance4_bbc,0) - NVL(srp.balance4_bbd,0))),2) bb ,
round(SUM(BALANCE2_DTD),2) current_month_earnings,
round(SUM(BALANCE4_DTD),2) recoverable_adjustments,
round(SUM(NVL(BALANCE5_DTD,0)),2) "non-recoverable_adjustments",
round(sum(BALANCE1_CTD),2) recover_thismonth,
round(SUM(BALANCE1_DTD),2) all_payments,
round(SUM(NVL(BALANCE2_BBD,0) - NVL(BALANCE2_BBC,0) +
NVL(BALANCE4_BBC,0) - NVL(BALANCE4_BBD,0) + NVL(BALANCE2_DTD,0) - (
NVL(BALANCE1_DTD,0) - NVL(BALANCE1_CTD,0) - NVL(BALANCE5_DTD,0))),2) eb,
currency_code
FROM cn_srp_subledger_all srp WHERE participant_id= 34000 AND
srp.earning_type_id(+)    = -1000 AND srp.plan_component_id(+) IS NULL GROUP

BY period_id,currency_code ORDER BY period_id,currency_code


-----------
SELECT  cp.comp_plan_name,
cpc.plan_component_name,
srp.* FROM 
cn_srp_subledger_all srp ,
cn_srp_comp_Plans_all srpc,
cn_comp_plans_all_tl cp,
cn_plan_components_all_tl cpc
WHERE srp.participant_id= 33007 AND
srp.earning_type_id(+)    = -1000 
and srpc.srp_comp_plan_id = srp.srp_comp_plan_id 
and srpc.comp_plan_id = cp.comp_plan_id 
and srp.plan_component_id = cpc.plan_component_id 

300000003064080
SELECT  cp.comp_plan_name,
cpc.plan_component_name,
srp.* FROM 
cn_srp_subledger_all srp ,
cn_srp_comp_Plans_all srpc,
cn_comp_plans_all_tl cp,
cn_plan_components_all_tl cpc
WHERE srp.participant_id= 33007 AND
srp.earning_type_id(+)    = -1000 
and srpc.srp_comp_plan_id = srp.srp_comp_plan_id 
and srpc.comp_plan_id = cp.comp_plan_id 
and srp.plan_component_id = cpc.plan_component_id 
and srp.plan_component_id =300000003064080

--

SELECT  cp.comp_plan_name,
cpc.plan_component_name,
srp.* FROM 
cn_srp_subledger_all srp ,
cn_srp_comp_Plans_all srpc,
cn_comp_plans_all_tl cp,
cn_plan_components_all_tl cpc,
cn_tp
WHERE srp.participant_id= 33007 
AND srp.earning_type_id(+)    = -1000 
and srpc.srp_comp_plan_id = srp.srp_comp_plan_id 
and srpc.comp_plan_id = cp.comp_plan_id 
and srp.plan_component_id = cpc.plan_component_id 
and srp.plan_component_id =300000003064080
------
srp.plan_component_id =300000003064080
SELECT /* SR 3-21529670871 */
period_id,
round(SUM(
(NVL(srp.balance2_bbd,0) - NVL(srp.balance2_bbc,0)) +
(NVL(srp.balance4_bbc,0) - NVL(srp.balance4_bbd,0))),2) bb ,
round(SUM(BALANCE2_DTD),2) current_month_earnings,
round(SUM(BALANCE4_DTD),2) recoverable_adjustments,
round(SUM(NVL(BALANCE5_DTD,0)),2) "non-recoverable_adjustments",
round(sum(BALANCE1_CTD),2) recover_thismonth,
round(SUM(BALANCE1_DTD),2) all_payments,
round(SUM(NVL(BALANCE2_BBD,0) - NVL(BALANCE2_BBC,0) +
NVL(BALANCE4_BBC,0) - NVL(BALANCE4_BBD,0) + NVL(BALANCE2_DTD,0) - (
NVL(BALANCE1_DTD,0) - NVL(BALANCE1_CTD,0) - NVL(BALANCE5_DTD,0))),2) eb,
currency_code
FROM cn_srp_subledger_all srp WHERE participant_id= 34000 AND
srp.earning_type_id(+)    = -1000 AND srp.plan_component_id(+) IS NULL GROUP
and srp.plan_component_id =300000003064080
BY period_id,currency_code ORDER BY period_id,currency_code


-----
select * from CN_TP_EARNINGS_ALL where credited_participant_id =33007
and SOURCE_EVENT_PERIOD_ID = 2019003

-----
select tpe.COMM_AMT_CALC_CURR,
tpe.OUTPUT_ACHIEVED,
tpe.PLAN_COMPONENT_ID,
tpe.FORMULA_ID 
from 
CN_TP_EARNINGS_ALL  TPE 
where 
tpe.credited_participant_id =33007
and 
tpe.SOURCE_EVENT_PERIOD_ID in (2019001,2019002,2019003)

--
select * from CN_TP_MEASURE_RESULTS_ALL where credited_participant_id =33007
and SOURCE_EVENT_PERIOD_ID = 2019003
------

select 
cpc.plan_component_name,
tpe.COMM_AMT_CALC_CURR,
tpe.OUTPUT_ACHIEVED,
CNF.FORMULA_NAME 
from 
CN_TP_EARNINGS_ALL  TPE,
cn_plan_components_all_tl cpc 
CN_FORMULAS_ALL_TL CNF
where 
tpe.credited_participant_id =33007
and cnf.formula_id = tpe.formula_id 
and tpe.plan_component_id = cpc.plan_component_id 
and tpe.SOURCE_EVENT_PERIOD_ID in (2019001,2019002,2019003)
and tpe.plan_component_id =300000003064080

