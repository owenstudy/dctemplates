load data 
infile '/home/guangjun/git/dctemplates/app/sqlldr/control/DM_PARTY_ADDR.txt'
append into table DM_PARTY_ADDR
fields terminated by ',' optionally enclosed by '|' trailing nullcols
(
PARTY_ADDR_ID                  "TRIM(:PARTY_ADDR_ID                 )",
PARTY_ID                       "TRIM(:PARTY_ID                      )",
ADDRESS_ID                     "TRIM(:ADDRESS_ID                    )",
ADDRESS_TYPE                   "TRIM(:ADDRESS_TYPE                  )"
)