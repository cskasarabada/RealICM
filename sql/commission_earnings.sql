Select distinct
srp.PARTICIPANT_ID,
srp.PARTICIPANT_NAME,
cptl.comp_plan_name,
comp.TARGET_INCENTIVE,
pctl.PLAN_COMPONENT_NAME,
PcFORM.Formula_Sequence,
FORM.Formula_name,
tpCda.TRANSACTION_AMT_SOURCE_CURR,
tpCda.SOURCE_TRX_NUMBER,
tpCda.TRANSACTION_TYPE
 from 
CN_SRP_PARTICIPANTS_ALL srp,
CN_COMP_PLANS_ALL_B  comp,
CN_COMP_PLANS_ALL_TL cpTl,
CN_SRP_COMP_PLANS_ALL srpCp,
CN_SRP_PLAN_COMPONENTS_ALL srpPC,
CN_PLAN_COMPONENTS_ALL_TL pcTL,
CN_PLAN_COMPONENT_FORMULAS_ALL pcFORM,
CN_FORMULAS_ALL_TL Form,
cn_tp_credits_All tpCda
where 
srpPC.PARTICIPANT_ID= srp.PARTICIPANT_ID
and  srp.PARTICIPANT_ID='21013'
 and comp.COMP_PLAN_ID =srpCp.COMP_PLAN_ID
and srpPC.SRP_COMP_PLAN_ID=srpCp. SRP_COMP_PLAN_ID
and srppc.comp_plan_id = comp.comp_plan_id
and cpTL.comp_plan_id = comp.comp_plan_id
and pctl.PLAN_COMPONENT_ID=srpPC.PLAN_COMPONENT_ID
and srpPC.PLAN_COMPONENT_ID = pcFORM.PLAN_COMPONENT_ID
and pcFORM.FORMULA_ID=Form.Formula_id
and tpcda.PARTICIPANT_ID= srp.PARTICIPANT_ID
and tpcda.SOURCE_EVENT_PERIOD_ID=2019001
and tpcda.SOURCE_TRX_NUMBER ='SR5-Order 101'
Order by PcFORM.Formula_Sequence
-----add to above---
select a.plan_component_id, pc.plan_component_name,
         a.formula_id, f.formula_name,
         goal_id,
         INPUT_ACHIEVED_PTD, INPUT_ACHIEVED_ITD,
         OUTPUT_ACHIEVED_PTD,  OUTPUT_ACHIEVED_ITD
  from CN_SRP_PER_FORM_METRICS_ALL a,
          cn_plan_components_all_tl pc ,
          cn_formulas_all_tl f
 where participant_id = '21013'
    and period_id = 2019001
    and a.plan_component_id = pc.plan_component_id
    and a.formula_id = f.formula_id
-------


select * from cn_tp_transactions_all where source_trx_number='SR5-Order 101'

select 
tpCda.TRANSACTION_AMT_SOURCE_CURR,
tpCda.SOURCE_TRX_NUMBER
from cn_tp_credits_All tpCda where  
tpcda.PARTICIPANT_ID='21013'

TRANSACTION_AMT_SOURCE_CURR (1000000)
SOURCE_CURRENCY_CODE (USD)
TRANSACTION_AMT_FUNC_CURR (1000000)
SOURCE_TO_FUNC_CURR_CNVRT (1)
TRANSACTION_TYPE (ORDER)
ELIGIBLE_CAT_ID (300000002528578)
SOURCE_TYPE (COLLECTION)
OBJECT_STATUS (ELIGIBLE)
COLLECTION_STATUS (NO_ERROR)
ADJUSTMENT_STATUS (UNADJUSTED)
PROCESS_CODE (CNREC)
ORG_ID (300000001870282)
SOURCE_TRX_NUMBER (SR5-Order 101)


select 
        cp.comp_plan_name,
        pc.plan_component_name,
       decode (f.incentive_formula_flag, 'Y', 'Incentive Formula', 'Measure Formula'),
       decode(f.incentive_formula_flag, 'Y', null, fn.formula_name) ,
       out_exp.expression_name ,
       in_exp.expression_name "Input Expression",
       cat.name "Credit Category",
       rate.rate_table_name
 from fusion.cn_comp_plan_components_all p,
         fusion.cn_comp_plans_all_vl cp,
         fusion.cn_plan_components_all_vl pc,
         fusion.cn_plan_component_formulas_all f,
         fusion.cn_formulas_all_vl fn,
	         ( select out.formula_id, out.output_exp_id, oe.expression_name, oe.rendered_expression_disp
	             from fusion.cn_formulas_all_b out,
	                    fusion.cn_expressions_all_vl oe
	           where out.output_exp_id = oe.expression_id ) out_exp,
         ( select fx.formula_id, fx.expression_id, ie.expression_name, ie.rendered_expression_disp
             from fusion.CN_FORMULA_INPUT_EXPS_ALL fx,
                    fusion.cn_expressions_all_vl ie
           where fx.expression_id = ie.expression_id ) in_exp,
        ( select cc.formula_id, cc.eligible_cat_id, ec.name
            from fusion.cn_formula_ecats_all cc,
                   fusion.cn_eligible_cats_all_vl ec
           where cc.eligible_cat_id = ec.eligible_cat_id) cat,
        ( select r.formula_id, r.rate_table_id, rn.rate_table_name
            from fusion.cn_formula_rate_tables_all r,
                    fusion.cn_rate_tables_all_vl rn
           where r.rate_table_id = rn.rate_table_id ) rate
where p.comp_plan_id = cp.comp_plan_id
   and cp.comp_plan_name = 'IC Simple Per Event Comp Plan 2017'
   and p.plan_component_id = pc.plan_component_id
   and p.plan_component_id = f.plan_component_id
   and f.formula_id = fn.formula_id
   and f.formula_id = out_exp.formula_id (+)
   and f.formula_id = in_exp.formula_id (+)
   and f.formula_id = cat.formula_id (+)
   and f.formula_id = rate.formula_id (+)
order by cp.comp_plan_name, pc.plan_component_name, fn.formula_name



select a.plan_component_id, pc.plan_component_name,
         a.formula_id, f.formula_name,
         goal_id,
         INPUT_ACHIEVED_PTD, INPUT_ACHIEVED_ITD,
         OUTPUT_ACHIEVED_PTD,  OUTPUT_ACHIEVED_ITD
  from CN_SRP_PER_FORM_METRICS_ALL a,
          cn_plan_components_all_tl pc ,
          cn_formulas_all_tl f
 where participant_id = '21013'
    and period_id = 2019001
    and a.plan_component_id = pc.plan_component_id
    and a.formula_id = f.formula_id
    
    
    
    select e.credited_participant_id, p.participant_name, h.party_name,
           e.source_event_date, e.earning_id, COMM_AMT_CALC_CURR,
           e.plan_component_id, pcn.plan_component_name, m.formula_id, fn.formula_name,
           m.source_trx_number, m.transaction_id, m.credit_id, m.credit_amt_calc_curr
  from cn_tp_earnings_all e,
          cn_tp_measure_results_all m,
          cn_srp_participants_all p,   hz_parties h,
          cn_plan_components_all_tl pcn,
          cn_formulas_all_tl fn
where e.object_status = 'CALCULATED'
    and e.transaction_type = 'GRP'
    and e.credited_participant_id = '21013'       
    and e.source_event_period_id = &period_id           -- 2014001
    and e.plan_component_id = &plan_component_id  -- 300000002656453
    -- For CN_TP_MEASURE_RESULTS_N4 index
    and e.srp_comp_plan_id = m.srp_comp_plan_id
    and e.plan_component_id = m.plan_component_id
    and e.credited_participant_id = m.credited_participant_id
    and e.source_event_period_id = m.source_event_period_id
    and m.object_status = 'CALCULATED'
    and m.credit_id is not null
    and e.credited_participant_id = p.participant_id
    and p.party_id = h.party_id
    and e.plan_component_id = pcn.plan_component_id
    and m.formula_id = fn.formula_id
order by e.credited_participant_id, e.plan_component_id, m.formula_id, m.source_trx_number, m.credit_id ;	
