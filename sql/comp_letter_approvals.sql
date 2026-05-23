	select  /* Doc ID 2135790.1 */
         srp.srp_comp_plan_id,
         srp.participant_id, h.party_name "Participant",
         srp.comp_plan_id, n.comp_plan_name,
         srp.start_date, srp.end_date,
         srp.srp_plan_appr_instance_id,
         apr.published_date, apr.approval_status,
         w.tasknumber, w.outcome, w.state,
         w.UPDATEDBY, w.UPDATEDDATE,
         w.ASSIGNEES, w.APPROVERS
from  fusion.cn_srp_comp_plans_all srp, fusion.cn_comp_plans_all_tl n,
        fusion.cn_srp_participants_all p, fusion.hz_parties h,
        fusion.cn_srp_plan_appr_instances_all apr,
        FA_FUSION_SOAINFRA.WFTASK w
where srp.srp_comp_plan_id = apr.srp_comp_plan_id
and srp.srp_plan_appr_instance_id =
apr.srp_plan_appr_instance_id
and srp.participant_id = p.participant_id
and p.party_id = h.party_id
and srp.comp_plan_id = n.comp_plan_id
and n.language = userenv('LANG')
and w.compositename = 'IcCnSrpCompPlanApprovalComposite'
and apr.srp_plan_appr_instance_id = w.IDENTIFICATIONKEY

-----
FA_FUSION_SOAINFRA.WFATTACHMENT_VIEW

select 
srp.srp_comp_plan_id,
srp.participant_id,
h.party_name"Participant",
srp.comp_plan_id,
n.comp_plan_name,
srp.start_date, 
srp.end_date,
srp.srp_plan_appr_instance_id,
apr.published_date, 
apr.approval_status,
b.creation_date,
b.task_definition_name,
b.TASK_NUMBER,
t.TASK_TITLE,
b.INITIATED_BY,
b.INITIATED_DATE,
b.COMPLETED_BY,
b.COMPLETED_DATE,
b.STATUS_CODE, b.OUTCOME_CODE,
hb.version,
hb.from_user, 
hb.status_code BPMtaskStatusCode, 
hb.outcome_code BPMtaskOutcomeCode, 
hb.completed_date BPMtaskCompleted_date
from 
fusion.cn_srp_comp_plans_all srp, 
fusion.cn_comp_plans_all_tl n,
fusion.cn_srp_participants_all p, 
fusion.hz_parties h,
fusion.cn_srp_plan_appr_instances_all apr,
fusion.FND_BPM_TASK_B b, 
fusion.FND_BPM_TASK_TL t,
fusion.FND_BPM_TASK_HISTORY_B hb
where 
srp.srp_comp_plan_id = apr.srp_comp_plan_id
and srp.srp_plan_appr_instance_id = apr.srp_plan_appr_instance_id
and srp.participant_id = p.participant_id
and p.party_id = h.party_id
and srp.comp_plan_id = n.comp_plan_id
and n.language = userenv('LANG')
and apr.srp_plan_appr_instance_id = b.IDENTIFICATION_KEY
and b.domain = 'ICDomain'
and b.task_definition_name = 'SoaOLabel.CompensationPlanDocumentApproval'
and b.task_id = t.task_id
and t.language = USERENV('LANG')
and t.task_id = hb.task_id
order by b.task_number desc, hb.version

Following Columns are duplicated:STATUS_CODE,OUTCOME_CODE,COMPLETED_DATE. If you want select duplicated columns, please use expression elements with unique names and select the elements that you want to duplicate.
-----Refining the Query ---------------------
select 
b.creation_date,
b.task_definition_name,
b.TASK_NUMBER,
t.TASK_TITLE,
b.INITIATED_BY,
b.INITIATED_DATE,
b.COMPLETED_BY,
b.COMPLETED_DATE,
b.STATUS_CODE, b.OUTCOME_CODE,
hb.version,
hb.from_user, 
hb.status_code BPMtaskStatusCode, 
hb.outcome_code BPMtaskOutcomeCode, 
hb.completed_date BPMtaskCompleted_date
from 
fusion.cn_srp_plan_appr_instances_all apr,
fusion.	 b, 
fusion.FND_BPM_TASK_TL t,
fusion.FND_BPM_TASK_HISTORY_B hb
where 
b.domain = 'ICDomain'
and b.task_definition_name = 'SoaOLabel.CompensationPlanDocumentApproval'
and b.task_id = t.task_id
and t.language = USERENV('LANG')
and t.task_id = hb.task_id
order by b.task_number desc, hb.version
