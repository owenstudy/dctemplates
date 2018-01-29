load data 
infile '/home/guangjun/git/dctemplates/app/sqlldr/control/DM_COMPANY_CUSTOMER.txt'
append into table DM_COMPANY_CUSTOMER
fields terminated by ',' optionally enclosed by '|' trailing nullcols
(
COMPANY_ID                     "TRIM(:COMPANY_ID                    )",
COMPANY_NAME                   "TRIM(:COMPANY_NAME                  )",
ABBR_NAME                      "TRIM(:ABBR_NAME                     )",
FOUND_DATE                     "TRIM(:FOUND_DATE                    )",
TAX_CODE                       "TRIM(:TAX_CODE                      )",
TELEPHONE                      "TRIM(:TELEPHONE                     )",
FAX                            "TRIM(:FAX                           )",
EMAIL                          "TRIM(:EMAIL                         )",
STAFF_AMOUNT                   "TRIM(:STAFF_AMOUNT                  )",
REGISTER_CAPITAL               "TRIM(:REGISTER_CAPITAL              )",
REGISTER_CODE                  "TRIM(:REGISTER_CODE                 )",
URL                            "TRIM(:URL                           )",
LEADER_NAME                    "TRIM(:LEADER_NAME                   )",
CONTACT_TEL                    "TRIM(:CONTACT_TEL                   )",
BANKRUPTCY_ORDER_NO            "TRIM(:BANKRUPTCY_ORDER_NO           )",
DISCHARGE_DATE                 "TRIM(:DISCHARGE_DATE                )",
BANKRUPTCY_ORDER_DATE          "TRIM(:BANKRUPTCY_ORDER_DATE         )",
BANKRUPTCY_STATUS              "TRIM(:BANKRUPTCY_STATUS             )",
VIP_INDI                       "TRIM(:VIP_INDI                      )",
MOBILE                         "TRIM(:MOBILE                        )",
SMS                            "TRIM(:SMS                           )",
INSERT_TIME                    "TRIM(:INSERT_TIME                   )",
UPDATE_TIME                    "TRIM(:UPDATE_TIME                   )"
)