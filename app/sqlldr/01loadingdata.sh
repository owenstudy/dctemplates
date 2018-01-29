export NLS_LANG=AMERICAN_AMERICA.ZHS16GBK
#/home/guangjun/git/dctemplates/app/uploads/1517104003.xlsx
sqlldr $USERNAME/$PWD DIRECT=Y ROWS=50000 COLUMNARRAYROWS=50000 CONTROL=./controlfiles/dm_producer_hierarchy.ctl BAD=./bad/dm_producer_hierarchy.bad LOG=./log/dm_producer_hierarchy.log
sqlldr $USERNAME/$PWD DIRECT=Y ROWS=50000 COLUMNARRAYROWS=50000 CONTROL=./controlfiles/dm_party.ctl BAD=./bad/dm_party.bad LOG=./log/dm_party.log
sqlldr $USERNAME/$PWD DIRECT=Y ROWS=50000 COLUMNARRAYROWS=50000 CONTROL=./controlfiles/dm_bank_account.ctl BAD=./bad/dm_bank_account.bad LOG=./log/dm_bank_account.log
sqlldr $USERNAME/$PWD DIRECT=Y ROWS=50000 COLUMNARRAYROWS=50000 CONTROL=./controlfiles/dm_party_comment.ctl BAD=./bad/dm_party_comment.bad LOG=./log/dm_party_comment.log
sqlldr $USERNAME/$PWD DIRECT=Y ROWS=50000 COLUMNARRAYROWS=50000 CONTROL=./controlfiles/dm_customer.ctl BAD=./bad/dm_customer.bad LOG=./log/dm_customer.log
sqlldr $USERNAME/$PWD DIRECT=Y ROWS=50000 COLUMNARRAYROWS=50000 CONTROL=./controlfiles/dm_agent.ctl BAD=./bad/dm_agent.bad LOG=./log/dm_agent.log
sqlldr $USERNAME/$PWD DIRECT=Y ROWS=50000 COLUMNARRAYROWS=50000 CONTROL=./controlfiles/dm_party_addr.ctl BAD=./bad/dm_party_addr.bad LOG=./log/dm_party_addr.log
sqlldr $USERNAME/$PWD DIRECT=Y ROWS=50000 COLUMNARRAYROWS=50000 CONTROL=./controlfiles/dm_address.ctl BAD=./bad/dm_address.bad LOG=./log/dm_address.log
sqlldr $USERNAME/$PWD DIRECT=Y ROWS=50000 COLUMNARRAYROWS=50000 CONTROL=./controlfiles/dm_channel_org.ctl BAD=./bad/dm_channel_org.bad LOG=./log/dm_channel_org.log
sqlldr $USERNAME/$PWD DIRECT=Y ROWS=50000 COLUMNARRAYROWS=50000 CONTROL=./controlfiles/dm_company_customer.ctl BAD=./bad/dm_company_customer.bad LOG=./log/dm_company_customer.log
#/home/guangjun/git/dctemplates/app/uploads/UAL_Mapping_Party_V0.2.9.xlsx
sqlldr $USERNAME/$PWD DIRECT=Y ROWS=50000 COLUMNARRAYROWS=50000 CONTROL=./controlfiles/dm_producer_hierarchy.ctl BAD=./bad/dm_producer_hierarchy.bad LOG=./log/dm_producer_hierarchy.log
sqlldr $USERNAME/$PWD DIRECT=Y ROWS=50000 COLUMNARRAYROWS=50000 CONTROL=./controlfiles/dm_party.ctl BAD=./bad/dm_party.bad LOG=./log/dm_party.log
sqlldr $USERNAME/$PWD DIRECT=Y ROWS=50000 COLUMNARRAYROWS=50000 CONTROL=./controlfiles/dm_bank_account.ctl BAD=./bad/dm_bank_account.bad LOG=./log/dm_bank_account.log
sqlldr $USERNAME/$PWD DIRECT=Y ROWS=50000 COLUMNARRAYROWS=50000 CONTROL=./controlfiles/dm_party_comment.ctl BAD=./bad/dm_party_comment.bad LOG=./log/dm_party_comment.log
sqlldr $USERNAME/$PWD DIRECT=Y ROWS=50000 COLUMNARRAYROWS=50000 CONTROL=./controlfiles/dm_customer.ctl BAD=./bad/dm_customer.bad LOG=./log/dm_customer.log
sqlldr $USERNAME/$PWD DIRECT=Y ROWS=50000 COLUMNARRAYROWS=50000 CONTROL=./controlfiles/dm_agent.ctl BAD=./bad/dm_agent.bad LOG=./log/dm_agent.log
sqlldr $USERNAME/$PWD DIRECT=Y ROWS=50000 COLUMNARRAYROWS=50000 CONTROL=./controlfiles/dm_party_addr.ctl BAD=./bad/dm_party_addr.bad LOG=./log/dm_party_addr.log
sqlldr $USERNAME/$PWD DIRECT=Y ROWS=50000 COLUMNARRAYROWS=50000 CONTROL=./controlfiles/dm_address.ctl BAD=./bad/dm_address.bad LOG=./log/dm_address.log
sqlldr $USERNAME/$PWD DIRECT=Y ROWS=50000 COLUMNARRAYROWS=50000 CONTROL=./controlfiles/dm_channel_org.ctl BAD=./bad/dm_channel_org.bad LOG=./log/dm_channel_org.log
sqlldr $USERNAME/$PWD DIRECT=Y ROWS=50000 COLUMNARRAYROWS=50000 CONTROL=./controlfiles/dm_company_customer.ctl BAD=./bad/dm_company_customer.bad LOG=./log/dm_company_customer.log
