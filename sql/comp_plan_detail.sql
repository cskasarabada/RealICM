select 
        -- p.comp_plan_id,
        cp.comp_plan_name,
        -- p.plan_component_id,
        pc.plan_component_name,
        -- p.start_date, p.end_date,
       decode (f.incentive_formula_flag, 'Y', 'Incentive Formula', 'Measure Formula') "Formula Type",
       -- f.formula_id,
       decode(f.incentive_formula_flag, 'Y', null, fn.formula_name) "Performance Measure",
       -- out_exp.output_exp_id,
       out_exp.expression_name "Output Expression",
       out_exp.rendered_expression_disp "Output Detail",
       -- in_exp.expression_id,
       in_exp.expression_name "Input Expression",
       in_exp.rendered_expression_disp "Input Detail",
       -- cat.eligible_cat_id,
       cat.name "Credit Category",
       -- rate.rate_table_id,
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
  --- and cp.comp_plan_name = 'IC Simple Per Event Comp Plan 2017'
   and p.plan_component_id = pc.plan_component_id
   and p.plan_component_id = f.plan_component_id
   and f.formula_id = fn.formula_id
   and f.formula_id = out_exp.formula_id (+)
   and f.formula_id = in_exp.formula_id (+)
   and f.formula_id = cat.formula_id (+)
   and f.formula_id = rate.formula_id (+)
order by cp.comp_plan_name, pc.plan_component_name, fn.formula_name


--------
select 
        -- p.comp_plan_id,
        cp.comp_plan_name,
        -- p.plan_component_id,
        pc.plan_component_name,
        -- p.start_date, p.end_date,
       decode (f.incentive_formula_flag, 'Y', 'Incentive Formula', 'Measure Formula') "Formula Type",
       -- f.formula_id,
       decode(f.incentive_formula_flag, 'Y', null, fn.formula_name) "Performance Measure",
       -- out_exp.output_exp_id,
       out_exp.expression_name "Output Expression",
       out_exp.rendered_expression_disp "Output Detail",
       -- in_exp.expression_id,
       in_exp.expression_name "Input Expression",
       in_exp.rendered_expression_disp "Input Detail",
       -- cat.eligible_cat_id,
       cat.name "Credit Category",
       -- rate.rate_table_id,
       rate.rate_table_name
 from fusion.cn_comp_plan_components_all p,
         fusion.cn_comp_plans_all_vl cp,
         fusion.cn_plan_components_all_vl pc,
         fusion.cn_plan_component_formulas_all f,
         fusion.cn_formulas_all_vl fn
where p.comp_plan_id = cp.comp_plan_id
  --- and cp.comp_plan_name = 'IC Simple Per Event Comp Plan 2017'
   and p.plan_component_id = pc.plan_component_id
   and p.plan_component_id = f.plan_component_id
   and f.formula_id = fn.formula_id
   


