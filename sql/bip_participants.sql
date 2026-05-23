select P.PARTICIPANT_NAME AS "Name",
        PD.ATTRIBUTE_NUMBER2 AS "OTV",
        PD.ATTRIBUTE_CHAR14 AS "Position",
        PD.ATTRIBUTE_CHAR8 AS "Comp Role Display Name",
        PD.ATTRIBUTE_CHAR10 AS "MgrL1",
        PD.ATTRIBUTE_CHAR12 AS "Region",
        PD.ATTRIBUTE_CHAR13 AS "Sub Region",
        --PD.ATTRIBUTE_CHAR9 AS "Territory",
        PD.ATTRIBUTE_CHAR1 AS "Comp Letter Language",
        PD.ATTRIBUTE_NUMBER1 AS "Current Salary",
        PD.ATTRIBUTE_CHAR5 AS "Manager Employee ID",
        PD.CURRENCY_CODE AS "Participant Home Currency",
        PC.ATTRIBUTE1 AS "Display on Comp Letter",
        PC.ATTRIBUTE2 AS "PC Type",
        P.PARTY_NUMBER AS "WWID",
        CP.DISPLAY_NAME AS "Plan",
        CP.COMP_PLAN_ID AS "CP_Id",
        CP.ORG_ID AS "CP_OrgId",
        CP.DESCRIPTION AS "Description",
        SCP.TARGET_INCENTIVE AS "Target Incentive",
        SCP.START_DATE AS "From Date",
        SCP.END_DATE AS "To Date",
        INITCAP(SCP.APPROVAL_STATUS) AS "Status",
        SPC.TARGET_INCENTIVE_WEIGHT AS "Weight %",
        (Select max(target_itd) from CN_SRP_PER_GOALS_ALL where SRP_COMP_PLAN_ID = SPC.SRP_COMP_PLAN_ID and PLAN_COMPONENT_ID = SPC.PLAN_COMPONENT_ID group by SRP_COMP_PLAN_ID, PLAN_COMPONENT_ID) AS "Plan Target Incentive",
        (Select distinct(CURRENCY_CODE) from CN_SRP_PER_GOALS_ALL where SRP_COMP_PLAN_ID = SPC.SRP_COMP_PLAN_ID and PLAN_COMPONENT_ID = SPC.PLAN_COMPONENT_ID) AS "CURRENCY CODE",
        PD.ATTRIBUTE_NUMBER2 * SPC.TARGET_INCENTIVE_WEIGHT / 100 AS "Current Amount",
        (PD.ATTRIBUTE_NUMBER1) + (PD.ATTRIBUTE_NUMBER2) AS "CURRENT On Target Earnings:",
        PC.DISPLAY_NAME AS "Plan Component Name",
        PC.DESCRIPTION AS "PC Description",
        INITCAP(PC.INCENTIVE_TYPE) AS "Incentive Type",
        CPC.START_DATE AS "PC Start Date",
        CPC.END_DATE AS "PC End Date",
        CT.CREDIT_TYPE_NAME AS "Earning Type",
        PCF.FORMULA_SEQUENCE AS "Sequence",
        PCF.INCENTIVE_FORMULA_FLAG AS "Incentive Formula",
        F.DISPLAY_NAME AS "Formula Name",
        F.FORMULA_TYPE_CODE AS "Formula T.ype",
        F.FORMULA_ID AS "Formula ID",
        IT.INTERVAL_NAME AS "Performance Interval",
        SFM.SRP_FORM_METRIC_ID AS "FORM METRIC ID",
        SG.TARGET AS "Target",
        SFRT.SRP_FORM_RATE_TABLE_ID AS "SRP FormRtId",
        FRT.START_DATE AS "Rate From",
        FRT.END_DATE AS "Rate To",
        RT.DISPLAY_NAME AS "Rate Table Name",
        RT.RATE_TABLE_ID AS "Rate Id",
        (select MT.PARTICIPANT_NAME from CN_SRP_PARTICIPANT_HDR_RO_V "MT" where MT.HR_PERSON_NUMBER=PD.ATTRIBUTE_CHAR5 and PD.start_date <= SCP.start_date and
              ((PD.END_date IS NOT NULL
               AND PD.END_date >= SCP.start_date)
               OR PD.END_date IS NULL)) AS "Manager"
        FROM CN_SRP_COMP_PLANS_ALL "SCP",
             CN_SRP_PARTICIPANT_HDR_RO_V "P",
             CN_SRP_PARTICIPANT_DETAILS_ALL "PD",
             CN_COMP_PLANS_ALL_VL "CP",
             CN_SRP_PLAN_COMPONENTS_ALL "SPC",
             CN_PLAN_COMPONENTS_ALL_VL "PC",
             CN_COMP_PLAN_COMPONENTS_ALL "CPC",
             CN_CREDIT_TYPES_ALL_VL "CT",
             CN_PLAN_COMPONENT_FORMULAS_ALL "PCF",
             CN_FORMULAS_ALL_VL "F",
             CN_INTERVAL_TYPES_ALL_VL "IT",
             CN_SRP_FORM_METRICS_ALL "SFM",
             CN_SRP_GOALS_ALL "SG",
             CN_SRP_FORM_RATE_TABLES_ALL "SFRT",
             CN_FORMULA_RATE_TABLES_ALL "FRT",
             CN_RATE_TABLES_ALL_VL "RT"
        WHERE SCP.PARTICIPANT_ID = P.PARTICIPANT_ID AND
              P.PARTICIPANT_ID = PD.PARTICIPANT_ID AND
              SCP.COMP_PLAN_ID = CP.COMP_PLAN_ID AND
              SCP.SRP_COMP_PLAN_ID = SPC.SRP_COMP_PLAN_ID AND
              SPC.PLAN_COMPONENT_ID = PC.PLAN_COMPONENT_ID AND
              PC.PLAN_COMPONENT_ID = CPC.PLAN_COMPONENT_ID AND
              CP.COMP_PLAN_ID = CPC.COMP_PLAN_ID AND
              PC.EARNING_TYPE_ID = CT.CREDIT_TYPE_ID AND
              PC.ORG_ID = CT.ORG_ID AND
              PC.PLAN_COMPONENT_ID = PCF.PLAN_COMPONENT_ID AND
              PCF.FORMULA_ID = F.FORMULA_ID AND
              F.ACCUMULATION_INTERVAL = IT.INTERVAL_TYPE_ID AND
              F.ORG_ID = IT.ORG_ID AND
              SCP.SRP_COMP_PLAN_ID = SFM.SRP_COMP_PLAN_ID AND
              SPC.SRP_PLAN_COMPONENT_ID = SFM.SRP_PLAN_COMPONENT_ID AND
              F.FORMULA_ID = SFM.FORMULA_ID AND
              SFM.SRP_FORM_METRIC_ID = SG.SRP_FORM_METRIC_ID AND
              SFM.SRP_FORM_METRIC_ID = SFRT.SRP_FORM_METRIC_ID(+) AND
              SFRT.FORMULA_RATE_TABLE_ID = FRT.FORMULA_RATE_TABLE_ID(+) AND
              FRT.RATE_TABLE_ID = RT.RATE_TABLE_ID(+) AND
              SCP.SRP_COMP_PLAN_ID = :P_SRPCPID AND
              PC.ATTRIBUTE1 = 'Y' and
              PD.start_date <= SCP.start_date and
              ((PD.END_date IS NOT NULL
               AND PD.END_date >= SCP.start_date)
               OR PD.END_date IS NULL)
        ORDER BY
            SPC.TARGET_INCENTIVE_WEIGHT DESC,
            PD.start_date