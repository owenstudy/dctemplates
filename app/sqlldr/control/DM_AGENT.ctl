load data 
infile '/home/guangjun/git/dctemplates/app/sqlldr/control/DM_AGENT.txt'
append into table DM_AGENT
fields terminated by ',' optionally enclosed by '|' trailing nullcols
(
AGENT_ID                       "TRIM(:AGENT_ID                      )",
AGENT_CODE                     "TRIM(:AGENT_CODE                    )",
ORGAN_ID                       "TRIM(:ORGAN_ID                      )",
AGENT_STATUS                   "TRIM(:AGENT_STATUS                  )",
COMM_ACCOUNT_ID                "TRIM(:COMM_ACCOUNT_ID               )",
AGENT_CATE                     "TRIM(:AGENT_CATE                    )",
STATUS_REASON                  "TRIM(:STATUS_REASON                 )",
APPOINMENT_DATE                "TRIM(:APPOINMENT_DATE               )",
AGENT_GRADE                    "TRIM(:AGENT_GRADE                   )",
ENTER_COMPANY_DATE             "TRIM(:ENTER_COMPANY_DATE            )",
LEAVE_COMPANY_DATE             "TRIM(:LEAVE_COMPANY_DATE            )",
RECOMMENDER_ID                 "TRIM(:RECOMMENDER_ID                )",
TRAINER_ID                     "TRIM(:TRAINER_ID                    )",
SCHOOL                         "TRIM(:SCHOOL                        )",
MAJOR                          "TRIM(:MAJOR                         )",
DEGREE_ID                      "TRIM(:DEGREE_ID                     )",
BEGIN_JOB_DATE                 "TRIM(:BEGIN_JOB_DATE                )",
HOLDBACK_INDI                  "TRIM(:HOLDBACK_INDI                 )",
HOLDBACK_PERIOD                "TRIM(:HOLDBACK_PERIOD               )",
HOLDBACK_RATE                  "TRIM(:HOLDBACK_RATE                 )",
PAYMENT_MODE                   "TRIM(:PAYMENT_MODE                  )",
CHANNEL_ORG_ID                 "TRIM(:CHANNEL_ORG_ID                )",
PHYSICAL_LOCATION              "TRIM(:PHYSICAL_LOCATION             )",
OTHER_INCOME_INDI              "TRIM(:OTHER_INCOME_INDI             )",
JOB_NATURE_ID                  "TRIM(:JOB_NATURE_ID                 )",
OLD_JOB_ID                     "TRIM(:OLD_JOB_ID                    )",
LICENSE_TYPE_ID                "TRIM(:LICENSE_TYPE_ID               )",
LICENSE_EFF_DATE               "TRIM(:LICENSE_EFF_DATE              )",
EXPIRE_DATE                    "TRIM(:EXPIRE_DATE                   )",
POSITION_DATE                  "TRIM(:POSITION_DATE                 )",
QUALIFICATION_CERTI_CODE       "TRIM(:QUALIFICATION_CERTI_CODE      )"
)