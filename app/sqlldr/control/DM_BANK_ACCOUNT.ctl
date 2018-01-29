load data 
infile '/home/guangjun/git/dctemplates/app/sqlldr/control/DM_BANK_ACCOUNT.txt'
append into table DM_BANK_ACCOUNT
fields terminated by ',' optionally enclosed by '|' trailing nullcols
(
ACCOUNT_ID                     "TRIM(:ACCOUNT_ID                    )",
BANK_CODE                      "TRIM(:BANK_CODE                     )",
BANK_ACCOUNT                   "TRIM(:BANK_ACCOUNT                  )",
ACCO_NAME                      "TRIM(:ACCO_NAME                     )",
CERTI_TYPE                     "TRIM(:CERTI_TYPE                    )",
CERTI_CODE                     "TRIM(:CERTI_CODE                    )",
APPLY_DATE                     "TRIM(:APPLY_DATE                    )",
ACCOUNT_TYPE                   "TRIM(:ACCOUNT_TYPE                  )",
EXPIRE_DATE                    "TRIM(:EXPIRE_DATE                   )",
CREDIT_CARD_TYPE               "TRIM(:CREDIT_CARD_TYPE              )",
DEBIT_CREDIT_TYPE              "TRIM(:DEBIT_CREDIT_TYPE             )",
PARTY_ID                       "TRIM(:PARTY_ID                      )",
ACCOUNT_STATUS                 "TRIM(:ACCOUNT_STATUS                )",
IS_SELF                        "TRIM(:IS_SELF                       )",
SUSPEND_CAUSE                  "TRIM(:SUSPEND_CAUSE                 )",
CAUSE_DESC                     "TRIM(:CAUSE_DESC                    )"
)