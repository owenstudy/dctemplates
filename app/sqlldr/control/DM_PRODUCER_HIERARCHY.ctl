load data 
infile '/home/guangjun/git/dctemplates/app/sqlldr/control/DM_PRODUCER_HIERARCHY.txt'
append into table DM_PRODUCER_HIERARCHY
fields terminated by ',' optionally enclosed by '|' trailing nullcols
(
HIERARCHY_ID                   "TRIM(:HIERARCHY_ID                  )",
PRODUCER_ORG_ID                "TRIM(:PRODUCER_ORG_ID               )",
PRODUCER_ID                    "TRIM(:PRODUCER_ID                   )",
PRODUCER_POSITION              "TRIM(:PRODUCER_POSITION             )",
PRODUCER_STATUS                "TRIM(:PRODUCER_STATUS               )",
UPLINE_ORG_ID                  "TRIM(:UPLINE_ORG_ID                 )",
UPLINE_ID                      "TRIM(:UPLINE_ID                     )",
UPLINE_POSITION                "TRIM(:UPLINE_POSITION               )",
HIERARCHY_TYPE                 "TRIM(:HIERARCHY_TYPE                )",
ACTIVE_INDI                    "TRIM(:ACTIVE_INDI                   )",
PRE_HIERARCHY_ID               "TRIM(:PRE_HIERARCHY_ID              )",
SITUATION_CODE                 "TRIM(:SITUATION_CODE                )",
START_DATE                     "TRIM(:START_DATE                    )",
END_DATE                       "TRIM(:END_DATE                      )",
CHANGE_TYPE                    "TRIM(:CHANGE_TYPE                   )",
TRANSFER_REASON                "TRIM(:TRANSFER_REASON               )",
CHANGE_COMMENT                 "TRIM(:CHANGE_COMMENT                )"
)