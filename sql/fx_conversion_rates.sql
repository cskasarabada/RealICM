Select 
ct.CONVERSION_NAME  ,
cr.conversion_rate ,
cr.from_currency,
cr.to_currency ,
cr.CONVERSION_START_DATE,
cr.CONVERSION_END_DATE
from CN_CONVERSION_TYPES_TL ct,
CN_CONVERSION_RATES cr
where 
cr.conversion_type_id = ct.conversion_type_id
and ct.conversion_name='Incentive Compensation Annual Rate'
and cr.CONVERSION_START_DATE >= :P_CONVERSION_START_DATE
and cr.from_currency =:p_from_currency