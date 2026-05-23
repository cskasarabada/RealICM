BUSINESS_UNIT_ID (300000002781680)

SELECT DISTINCT bu.bu_id,   bu.bu_name
  FROM fun_all_business_units_v bu,
           fun_business_functions_b bf,
           fun_bu_usages_v buu
 WHERE bu.bu_id = buu.business_unit_id
     AND bf.business_function_code = 'INCENTIVE_COMPENSATION_BF'
     AND bf.business_function_id = buu.module_id ;
     
     SELECT DISTINCT bu.bu_id,   bu.bu_name
  FROM fun_all_business_units_v bu,
           fun_business_functions_b bf,
           fun_bu_usages_v buu
 WHERE bu.bu_id = buu.business_unit_id
     AND bf.business_function_code = 'INCENTIVE_COMPENSATION_BF'
     AND bf.business_function_id = buu.module_id
     
BU_ID (300000001870282)
BU_NAME (McAfee Enterprise LE BU)
LOCATION_ID (300000001870238)

select * from fun_all_business_units_v
300000001870282

PROD
BU_ID (300000002594180)
BU_NAME (McAfee BU)

seelct * from fun_business_functions_b bf
WHERE  bf.business_function_code = 'INCENTIVE_COMPENSATION_BF

BUSINESS_FUNCTION_ID (190)


select * from fun_bu_usages_v where buu.module_id =190

 SELECT DISTINCT bu.bu_id,   bu.bu_name
  FROM fun_all_business_units_v