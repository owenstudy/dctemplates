load data 
infile '/home/guangjun/git/dctemplates/app/sqlldr/control/DM_PARTY_COMMENT.txt'
append into table DM_PARTY_COMMENT
fields terminated by ',' optionally enclosed by '|' trailing nullcols
(
COMMENT_ID                     "TRIM(:COMMENT_ID                    )",
PARTY_ID                       "TRIM(:PARTY_ID                      )",
COMMENTS                       "TRIM(:COMMENTS                      )",
START_DATE                     "TRIM(:START_DATE                    )"
)