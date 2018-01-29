load data 
infile '/home/guangjun/git/dctemplates/app/sqlldr/control/DM_ADDRESS.txt'
append into table DM_ADDRESS
fields terminated by ',' optionally enclosed by '|' trailing nullcols
(
ADDRESS_ID                     "TRIM(:ADDRESS_ID                    )",
ADDRESS_1                      "TRIM(:ADDRESS_1                     )",
ADDRESS_2                      "TRIM(:ADDRESS_2                     )",
ADDRESS_3                      "TRIM(:ADDRESS_3                     )",
ADDRESS_4                      "TRIM(:ADDRESS_4                     )",
ADDRESS_5                      "TRIM(:ADDRESS_5                     )",
ADDRESS_6                      "TRIM(:ADDRESS_6                     )",
ADDRESS_7                      "TRIM(:ADDRESS_7                     )",
ADDRESS_8                      "TRIM(:ADDRESS_8                     )",
ADDRESS_9                      "TRIM(:ADDRESS_9                     )",
POST_CODE                      "TRIM(:POST_CODE                     )",
STATE                          "TRIM(:STATE                         )",
COUNTRY_CODE                   "TRIM(:COUNTRY_CODE                  )",
CITY                           "TRIM(:CITY                          )",
ADDRESS_STATUS                 "TRIM(:ADDRESS_STATUS                )",
ADDRESS_FORMAT                 "TRIM(:ADDRESS_FORMAT                )"
)