SELECT papf.person_number,papf.PERSON_ID,C.USER_GUID,C.USERNAME,D.PARTY_NAME,
res.EMAIL_ADDRESS,
  hauft.NAME BusinessUnit

FROM FUSION.HR_ORG_UNIT_CLASSIFICATIONS_F houcf,

FUSION.HR_ALL_ORGANIZATION_UNITS_F haouf,

FUSION.HR_ORGANIZATION_UNITS_F_TL hauft,

FUSION.per_all_assignments_m paam,

fusion.PER_USERS C,

FUSION.HZ_PARTIES D,

FUSION.per_all_people_f papf,
Fusion.jtf_rs_resource_profiles Res

WHERE

D.USER_GUID=C.USER_GUID

AND C.PERSON_ID=papf.PERSON_ID
d.party_id = res.party_id 

AND haouf.ORGANIZATION_ID = houcf.ORGANIZATION_ID

AND haouf.ORGANIZATION_ID = hauft.ORGANIZATION_ID

AND haouf.EFFECTIVE_START_DATE BETWEEN houcf.EFFECTIVE_START_DATE AND houcf.EFFECTIVE_END_DATE

AND hauft.LANGUAGE = 'US'

AND hauft.EFFECTIVE_START_DATE = haouf.EFFECTIVE_START_DATE

AND hauft.EFFECTIVE_END_DATE = haouf.EFFECTIVE_END_DATE

AND houcf.CLASSIFICATION_CODE = 'FUN_BUSINESS_UNIT'

AND SYSDATE BETWEEN hauft.effective_start_date AND hauft.effective_end_date

AND hauft.organization_id = paam.business_unit_id

and paam.person_id = papf.person_id

and paam.primary_assignment_flag = 'Y'
and papf.person_number= 300000002678410

and paam.assignment_type = 'E'

and paam.effective_latest_change = 'Y'

and sysdate between paam.effective_start_date and paam.effective_end_date

and sysdate between papf.effective_start_date and papf.effective_end_date

order by papf.person_number asc,hauft.name asc nulls first