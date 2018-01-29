load data 
infile '/home/guangjun/git/dctemplates/app/sqlldr/control/DM_PARTY.txt'
append into table DM_PARTY
fields terminated by ',' optionally enclosed by '|' trailing nullcols
(
PARTY_ID                       "TRIM(:PARTY_ID                      )",
PARTY_TYPE                     "TRIM(:PARTY_TYPE                    )",
INSERT_TIME                    "TRIM(:INSERT_TIME                   )",
UPDATE_TIME                    "TRIM(:UPDATE_TIME                   )"
)