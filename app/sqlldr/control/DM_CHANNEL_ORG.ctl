load data 
infile '/home/guangjun/git/dctemplates/app/sqlldr/control/DM_CHANNEL_ORG.txt'
append into table DM_CHANNEL_ORG
fields terminated by ',' optionally enclosed by '|' trailing nullcols
(
CHANNEL_ID                     "TRIM(:CHANNEL_ID                    )",
PARENT_ID                      "TRIM(:PARENT_ID                     )",
CHANNEL_NAME                   "TRIM(:CHANNEL_NAME                  )",
CHANNEL_CODE                   "TRIM(:CHANNEL_CODE                  )",
LEADER_ID                      "TRIM(:LEADER_ID                     )",
CHANNEL_TYPE                   "TRIM(:CHANNEL_TYPE                  )",
ORG_ID                         "TRIM(:ORG_ID                        )",
STATUS                         "TRIM(:STATUS                        )",
STATUS_DATE                    "TRIM(:STATUS_DATE                   )",
STATUS_REASON                  "TRIM(:STATUS_REASON                 )",
CHANNEL_GRADE                  "TRIM(:CHANNEL_GRADE                 )",
TELEPHONE                      "TRIM(:TELEPHONE                     )",
FAX                            "TRIM(:FAX                           )",
EMAIL                          "TRIM(:EMAIL                         )",
ADDRESS_ID                     "TRIM(:ADDRESS_ID                    )",
DEFAULT_BANK                   "TRIM(:DEFAULT_BANK                  )",
CREATE_DATE                    "TRIM(:CREATE_DATE                   )"
)