spool UAL_Mapping_Party_V0.2.9_veri.sql.log
insert into dm_template_veri (module_name,table_name,column_name,veri_code,veri_result)
select '/home/guangjun/git/dctemplates/app/uploads/UAL_Mapping_Party_V0.2.9.xlsx' as module_name,'DM_PRODUCER_HIERARCHY' as table_name,'HIERARCHY_ID' as column_name,'VERI_NUMBER_ILLEGAL' as veri_code,count(*) as veri_result from DM_PRODUCER_HIERARCHY
 where f_is_number(HIERARCHY_ID)=1 and HIERARCHY_ID is not null;
insert into dm_template_veri (module_name,table_name,column_name,veri_code,veri_result)
select '/home/guangjun/git/dctemplates/app/uploads/UAL_Mapping_Party_V0.2.9.xlsx' as module_name,'DM_PRODUCER_HIERARCHY' as table_name,'HIERARCHY_ID' as column_name,'VERI_NON_NULLABLE' as veri_code,count(*) as veri_result from DM_PRODUCER_HIERARCHY
 where HIERARCHY_ID is  null;
insert into dm_template_veri (module_name,table_name,column_name,veri_code,veri_result)
select '/home/guangjun/git/dctemplates/app/uploads/UAL_Mapping_Party_V0.2.9.xlsx' as module_name,'DM_PRODUCER_HIERARCHY' as table_name,'HIERARCHY_ID' as column_name,'VERI_PRIMARY_KEY' as veri_code,count(*) as veri_result from DM_PRODUCER_HIERARCHY
 where (select count(*) from DM_PRODUCER_HIERARCHY  b where DM_PRODUCER_HIERARCHY.HIERARCHY_ID=b.HIERARCHY_ID)>1;
insert into dm_template_veri (module_name,table_name,column_name,veri_code,veri_result)
select '/home/guangjun/git/dctemplates/app/uploads/UAL_Mapping_Party_V0.2.9.xlsx' as module_name,'DM_PRODUCER_HIERARCHY' as table_name,'PRODUCER_ORG_ID' as column_name,'VERI_NUMBER_ILLEGAL' as veri_code,count(*) as veri_result from DM_PRODUCER_HIERARCHY
 where f_is_number(PRODUCER_ORG_ID)=1 and PRODUCER_ORG_ID is not null;
insert into dm_template_veri (module_name,table_name,column_name,veri_code,veri_result)
select '/home/guangjun/git/dctemplates/app/uploads/UAL_Mapping_Party_V0.2.9.xlsx' as module_name,'DM_PRODUCER_HIERARCHY' as table_name,'PRODUCER_ORG_ID' as column_name,'VERI_FOREIGN_KEY_TEMPLATE' as veri_code,count(*) as veri_result from DM_PRODUCER_HIERARCHY
 where ( not exists(select 1 from T_CHANNEL_ORG  b where DM_PRODUCER_HIERARCHY.PRODUCER_ORG_ID=b.channel_id) and PRODUCER_ORG_ID is not null);
insert into dm_template_veri (module_name,table_name,column_name,veri_code,veri_result)
select '/home/guangjun/git/dctemplates/app/uploads/UAL_Mapping_Party_V0.2.9.xlsx' as module_name,'DM_PRODUCER_HIERARCHY' as table_name,'PRODUCER_ID' as column_name,'VERI_NUMBER_ILLEGAL' as veri_code,count(*) as veri_result from DM_PRODUCER_HIERARCHY
 where f_is_number(PRODUCER_ID)=1 and PRODUCER_ID is not null;
insert into dm_template_veri (module_name,table_name,column_name,veri_code,veri_result)
select '/home/guangjun/git/dctemplates/app/uploads/UAL_Mapping_Party_V0.2.9.xlsx' as module_name,'DM_PRODUCER_HIERARCHY' as table_name,'PRODUCER_ID' as column_name,'VERI_NON_NULLABLE' as veri_code,count(*) as veri_result from DM_PRODUCER_HIERARCHY
 where PRODUCER_ID is  null;
insert into dm_template_veri (module_name,table_name,column_name,veri_code,veri_result)
select '/home/guangjun/git/dctemplates/app/uploads/UAL_Mapping_Party_V0.2.9.xlsx' as module_name,'DM_PRODUCER_HIERARCHY' as table_name,'PRODUCER_ID' as column_name,'VERI_FOREIGN_KEY_TEMPLATE' as veri_code,count(*) as veri_result from DM_PRODUCER_HIERARCHY
 where ( not exists(select 1 from DM_AGENT  b where DM_PRODUCER_HIERARCHY.PRODUCER_ID=b.AGENT_ID) and PRODUCER_ID is not null);
insert into dm_template_veri (module_name,table_name,column_name,veri_code,veri_result)
select '/home/guangjun/git/dctemplates/app/uploads/UAL_Mapping_Party_V0.2.9.xlsx' as module_name,'DM_PRODUCER_HIERARCHY' as table_name,'PRODUCER_POSITION' as column_name,'VERI_STRING_LENGTH_OVER_DEF' as veri_code,count(*) as veri_result from DM_PRODUCER_HIERARCHY
 where length(PRODUCER_POSITION)>2 and PRODUCER_POSITION is not null;
insert into dm_template_veri (module_name,table_name,column_name,veri_code,veri_result)
select '/home/guangjun/git/dctemplates/app/uploads/UAL_Mapping_Party_V0.2.9.xlsx' as module_name,'DM_PRODUCER_HIERARCHY' as table_name,'PRODUCER_POSITION' as column_name,'VERI_FOREIGN_KEY_TEMPLATE' as veri_code,count(*) as veri_result from DM_PRODUCER_HIERARCHY
 where ( not exists(select 1 from T_AGENT_GRADE  b where DM_PRODUCER_HIERARCHY.PRODUCER_POSITION=b.agent_grade) and PRODUCER_POSITION is not null);
insert into dm_template_veri (module_name,table_name,column_name,veri_code,veri_result)
select '/home/guangjun/git/dctemplates/app/uploads/UAL_Mapping_Party_V0.2.9.xlsx' as module_name,'DM_PRODUCER_HIERARCHY' as table_name,'PRODUCER_STATUS' as column_name,'VERI_NUMBER_ILLEGAL' as veri_code,count(*) as veri_result from DM_PRODUCER_HIERARCHY
 where f_is_number(PRODUCER_STATUS)=1 and PRODUCER_STATUS is not null;
insert into dm_template_veri (module_name,table_name,column_name,veri_code,veri_result)
select '/home/guangjun/git/dctemplates/app/uploads/UAL_Mapping_Party_V0.2.9.xlsx' as module_name,'DM_PRODUCER_HIERARCHY' as table_name,'PRODUCER_STATUS' as column_name,'VERI_FOREIGN_KEY_TEMPLATE' as veri_code,count(*) as veri_result from DM_PRODUCER_HIERARCHY
 where ( not exists(select 1 from T_AGENT_STATUS  b where DM_PRODUCER_HIERARCHY.PRODUCER_STATUS=b.agent_status) and PRODUCER_STATUS is not null);
insert into dm_template_veri (module_name,table_name,column_name,veri_code,veri_result)
select '/home/guangjun/git/dctemplates/app/uploads/UAL_Mapping_Party_V0.2.9.xlsx' as module_name,'DM_PRODUCER_HIERARCHY' as table_name,'UPLINE_ORG_ID' as column_name,'VERI_NUMBER_ILLEGAL' as veri_code,count(*) as veri_result from DM_PRODUCER_HIERARCHY
 where f_is_number(UPLINE_ORG_ID)=1 and UPLINE_ORG_ID is not null;
insert into dm_template_veri (module_name,table_name,column_name,veri_code,veri_result)
select '/home/guangjun/git/dctemplates/app/uploads/UAL_Mapping_Party_V0.2.9.xlsx' as module_name,'DM_PRODUCER_HIERARCHY' as table_name,'UPLINE_ORG_ID' as column_name,'VERI_FOREIGN_KEY_TEMPLATE' as veri_code,count(*) as veri_result from DM_PRODUCER_HIERARCHY
 where ( not exists(select 1 from T_CHANNEL_ORG  b where DM_PRODUCER_HIERARCHY.UPLINE_ORG_ID=b.channel_id) and UPLINE_ORG_ID is not null);
insert into dm_template_veri (module_name,table_name,column_name,veri_code,veri_result)
select '/home/guangjun/git/dctemplates/app/uploads/UAL_Mapping_Party_V0.2.9.xlsx' as module_name,'DM_PRODUCER_HIERARCHY' as table_name,'UPLINE_ID' as column_name,'VERI_NUMBER_ILLEGAL' as veri_code,count(*) as veri_result from DM_PRODUCER_HIERARCHY
 where f_is_number(UPLINE_ID)=1 and UPLINE_ID is not null;
insert into dm_template_veri (module_name,table_name,column_name,veri_code,veri_result)
select '/home/guangjun/git/dctemplates/app/uploads/UAL_Mapping_Party_V0.2.9.xlsx' as module_name,'DM_PRODUCER_HIERARCHY' as table_name,'UPLINE_ID' as column_name,'VERI_FOREIGN_KEY_TEMPLATE' as veri_code,count(*) as veri_result from DM_PRODUCER_HIERARCHY
 where ( not exists(select 1 from DM_AGENT  b where DM_PRODUCER_HIERARCHY.UPLINE_ID=b.AGENT_ID) and UPLINE_ID is not null);
insert into dm_template_veri (module_name,table_name,column_name,veri_code,veri_result)
select '/home/guangjun/git/dctemplates/app/uploads/UAL_Mapping_Party_V0.2.9.xlsx' as module_name,'DM_PRODUCER_HIERARCHY' as table_name,'UPLINE_POSITION' as column_name,'VERI_STRING_LENGTH_OVER_DEF' as veri_code,count(*) as veri_result from DM_PRODUCER_HIERARCHY
 where length(UPLINE_POSITION)>2 and UPLINE_POSITION is not null;
insert into dm_template_veri (module_name,table_name,column_name,veri_code,veri_result)
select '/home/guangjun/git/dctemplates/app/uploads/UAL_Mapping_Party_V0.2.9.xlsx' as module_name,'DM_PRODUCER_HIERARCHY' as table_name,'UPLINE_POSITION' as column_name,'VERI_FOREIGN_KEY_TEMPLATE' as veri_code,count(*) as veri_result from DM_PRODUCER_HIERARCHY
 where ( not exists(select 1 from T_AGENT_GRADE  b where DM_PRODUCER_HIERARCHY.UPLINE_POSITION=b.agent_grade) and UPLINE_POSITION is not null);
insert into dm_template_veri (module_name,table_name,column_name,veri_code,veri_result)
select '/home/guangjun/git/dctemplates/app/uploads/UAL_Mapping_Party_V0.2.9.xlsx' as module_name,'DM_PRODUCER_HIERARCHY' as table_name,'HIERARCHY_TYPE' as column_name,'VERI_STRING_LENGTH_OVER_DEF' as veri_code,count(*) as veri_result from DM_PRODUCER_HIERARCHY
 where length(HIERARCHY_TYPE)>1 and HIERARCHY_TYPE is not null;
insert into dm_template_veri (module_name,table_name,column_name,veri_code,veri_result)
select '/home/guangjun/git/dctemplates/app/uploads/UAL_Mapping_Party_V0.2.9.xlsx' as module_name,'DM_PRODUCER_HIERARCHY' as table_name,'HIERARCHY_TYPE' as column_name,'VERI_NON_NULLABLE' as veri_code,count(*) as veri_result from DM_PRODUCER_HIERARCHY
 where HIERARCHY_TYPE is  null;
insert into dm_template_veri (module_name,table_name,column_name,veri_code,veri_result)
select '/home/guangjun/git/dctemplates/app/uploads/UAL_Mapping_Party_V0.2.9.xlsx' as module_name,'DM_PRODUCER_HIERARCHY' as table_name,'HIERARCHY_TYPE' as column_name,'VERI_FOREIGN_KEY_TEMPLATE' as veri_code,count(*) as veri_result from DM_PRODUCER_HIERARCHY
 where ( not exists(select 1 from T_HIERARCHY_TYPE  b where DM_PRODUCER_HIERARCHY.HIERARCHY_TYPE=b.hierarchy_type) and HIERARCHY_TYPE is not null);
insert into dm_template_veri (module_name,table_name,column_name,veri_code,veri_result)
select '/home/guangjun/git/dctemplates/app/uploads/UAL_Mapping_Party_V0.2.9.xlsx' as module_name,'DM_PRODUCER_HIERARCHY' as table_name,'ACTIVE_INDI' as column_name,'VERI_STRING_LENGTH_OVER_DEF' as veri_code,count(*) as veri_result from DM_PRODUCER_HIERARCHY
 where length(ACTIVE_INDI)>1 and ACTIVE_INDI is not null;
insert into dm_template_veri (module_name,table_name,column_name,veri_code,veri_result)
select '/home/guangjun/git/dctemplates/app/uploads/UAL_Mapping_Party_V0.2.9.xlsx' as module_name,'DM_PRODUCER_HIERARCHY' as table_name,'ACTIVE_INDI' as column_name,'VERI_NON_NULLABLE' as veri_code,count(*) as veri_result from DM_PRODUCER_HIERARCHY
 where ACTIVE_INDI is  null;
insert into dm_template_veri (module_name,table_name,column_name,veri_code,veri_result)
select '/home/guangjun/git/dctemplates/app/uploads/UAL_Mapping_Party_V0.2.9.xlsx' as module_name,'DM_PRODUCER_HIERARCHY' as table_name,'ACTIVE_INDI' as column_name,'VERI_FOREIGN_KEY_TEMPLATE' as veri_code,count(*) as veri_result from DM_PRODUCER_HIERARCHY
 where ( not exists(select 1 from T_YES_NO  b where DM_PRODUCER_HIERARCHY.ACTIVE_INDI=b.YES_NO) and ACTIVE_INDI is not null);
insert into dm_template_veri (module_name,table_name,column_name,veri_code,veri_result)
select '/home/guangjun/git/dctemplates/app/uploads/UAL_Mapping_Party_V0.2.9.xlsx' as module_name,'DM_PRODUCER_HIERARCHY' as table_name,'PRE_HIERARCHY_ID' as column_name,'VERI_NUMBER_ILLEGAL' as veri_code,count(*) as veri_result from DM_PRODUCER_HIERARCHY
 where f_is_number(PRE_HIERARCHY_ID)=1 and PRE_HIERARCHY_ID is not null;
insert into dm_template_veri (module_name,table_name,column_name,veri_code,veri_result)
select '/home/guangjun/git/dctemplates/app/uploads/UAL_Mapping_Party_V0.2.9.xlsx' as module_name,'DM_PRODUCER_HIERARCHY' as table_name,'PRE_HIERARCHY_ID' as column_name,'VERI_FOREIGN_KEY_TEMPLATE' as veri_code,count(*) as veri_result from DM_PRODUCER_HIERARCHY
 where ( not exists(select 1 from T_PRODUCER_HIERARCHY  b where DM_PRODUCER_HIERARCHY.PRE_HIERARCHY_ID=b.hierarchy_id) and PRE_HIERARCHY_ID is not null);
insert into dm_template_veri (module_name,table_name,column_name,veri_code,veri_result)
select '/home/guangjun/git/dctemplates/app/uploads/UAL_Mapping_Party_V0.2.9.xlsx' as module_name,'DM_PRODUCER_HIERARCHY' as table_name,'SITUATION_CODE' as column_name,'VERI_NUMBER_ILLEGAL' as veri_code,count(*) as veri_result from DM_PRODUCER_HIERARCHY
 where f_is_number(SITUATION_CODE)=1 and SITUATION_CODE is not null;
insert into dm_template_veri (module_name,table_name,column_name,veri_code,veri_result)
select '/home/guangjun/git/dctemplates/app/uploads/UAL_Mapping_Party_V0.2.9.xlsx' as module_name,'DM_PRODUCER_HIERARCHY' as table_name,'START_DATE' as column_name,'VERI_DATE_ILLEGAL' as veri_code,count(*) as veri_result from DM_PRODUCER_HIERARCHY
 where f_is_date(START_DATE)=1 and START_DATE is not null;
insert into dm_template_veri (module_name,table_name,column_name,veri_code,veri_result)
select '/home/guangjun/git/dctemplates/app/uploads/UAL_Mapping_Party_V0.2.9.xlsx' as module_name,'DM_PRODUCER_HIERARCHY' as table_name,'START_DATE' as column_name,'VERI_NON_NULLABLE' as veri_code,count(*) as veri_result from DM_PRODUCER_HIERARCHY
 where START_DATE is  null;
insert into dm_template_veri (module_name,table_name,column_name,veri_code,veri_result)
select '/home/guangjun/git/dctemplates/app/uploads/UAL_Mapping_Party_V0.2.9.xlsx' as module_name,'DM_PRODUCER_HIERARCHY' as table_name,'END_DATE' as column_name,'VERI_DATE_ILLEGAL' as veri_code,count(*) as veri_result from DM_PRODUCER_HIERARCHY
 where f_is_date(END_DATE)=1 and END_DATE is not null;
insert into dm_template_veri (module_name,table_name,column_name,veri_code,veri_result)
select '/home/guangjun/git/dctemplates/app/uploads/UAL_Mapping_Party_V0.2.9.xlsx' as module_name,'DM_PRODUCER_HIERARCHY' as table_name,'END_DATE' as column_name,'VERI_NON_NULLABLE' as veri_code,count(*) as veri_result from DM_PRODUCER_HIERARCHY
 where END_DATE is  null;
insert into dm_template_veri (module_name,table_name,column_name,veri_code,veri_result)
select '/home/guangjun/git/dctemplates/app/uploads/UAL_Mapping_Party_V0.2.9.xlsx' as module_name,'DM_PRODUCER_HIERARCHY' as table_name,'CHANGE_TYPE' as column_name,'VERI_STRING_LENGTH_OVER_DEF' as veri_code,count(*) as veri_result from DM_PRODUCER_HIERARCHY
 where length(CHANGE_TYPE)>2 and CHANGE_TYPE is not null;
insert into dm_template_veri (module_name,table_name,column_name,veri_code,veri_result)
select '/home/guangjun/git/dctemplates/app/uploads/UAL_Mapping_Party_V0.2.9.xlsx' as module_name,'DM_PRODUCER_HIERARCHY' as table_name,'CHANGE_TYPE' as column_name,'VERI_NON_NULLABLE' as veri_code,count(*) as veri_result from DM_PRODUCER_HIERARCHY
 where CHANGE_TYPE is  null;
insert into dm_template_veri (module_name,table_name,column_name,veri_code,veri_result)
select '/home/guangjun/git/dctemplates/app/uploads/UAL_Mapping_Party_V0.2.9.xlsx' as module_name,'DM_PRODUCER_HIERARCHY' as table_name,'CHANGE_TYPE' as column_name,'VERI_FOREIGN_KEY_TEMPLATE' as veri_code,count(*) as veri_result from DM_PRODUCER_HIERARCHY
 where ( not exists(select 1 from T_HIERARCHY_CHANGE_TYPE  b where DM_PRODUCER_HIERARCHY.CHANGE_TYPE=b.change_type) and CHANGE_TYPE is not null);
insert into dm_template_veri (module_name,table_name,column_name,veri_code,veri_result)
select '/home/guangjun/git/dctemplates/app/uploads/UAL_Mapping_Party_V0.2.9.xlsx' as module_name,'DM_PRODUCER_HIERARCHY' as table_name,'TRANSFER_REASON' as column_name,'VERI_NUMBER_ILLEGAL' as veri_code,count(*) as veri_result from DM_PRODUCER_HIERARCHY
 where f_is_number(TRANSFER_REASON)=1 and TRANSFER_REASON is not null;
insert into dm_template_veri (module_name,table_name,column_name,veri_code,veri_result)
select '/home/guangjun/git/dctemplates/app/uploads/UAL_Mapping_Party_V0.2.9.xlsx' as module_name,'DM_PRODUCER_HIERARCHY' as table_name,'TRANSFER_REASON' as column_name,'VERI_FOREIGN_KEY_TEMPLATE' as veri_code,count(*) as veri_result from DM_PRODUCER_HIERARCHY
 where ( not exists(select 1 from T_AGENT_TRANSFER_REASON  b where DM_PRODUCER_HIERARCHY.TRANSFER_REASON=b.reason_id) and TRANSFER_REASON is not null);
insert into dm_template_veri (module_name,table_name,column_name,veri_code,veri_result)
select '/home/guangjun/git/dctemplates/app/uploads/UAL_Mapping_Party_V0.2.9.xlsx' as module_name,'DM_PRODUCER_HIERARCHY' as table_name,'CHANGE_COMMENT' as column_name,'VERI_STRING_LENGTH_OVER_DEF' as veri_code,count(*) as veri_result from DM_PRODUCER_HIERARCHY
 where length(CHANGE_COMMENT)>200 and CHANGE_COMMENT is not null;
insert into dm_template_veri (module_name,table_name,column_name,veri_code,veri_result)
select '/home/guangjun/git/dctemplates/app/uploads/UAL_Mapping_Party_V0.2.9.xlsx' as module_name,'DM_PARTY' as table_name,'PARTY_ID' as column_name,'VERI_NUMBER_ILLEGAL' as veri_code,count(*) as veri_result from DM_PARTY
 where f_is_number(PARTY_ID)=1 and PARTY_ID is not null;
insert into dm_template_veri (module_name,table_name,column_name,veri_code,veri_result)
select '/home/guangjun/git/dctemplates/app/uploads/UAL_Mapping_Party_V0.2.9.xlsx' as module_name,'DM_PARTY' as table_name,'PARTY_ID' as column_name,'VERI_NON_NULLABLE' as veri_code,count(*) as veri_result from DM_PARTY
 where PARTY_ID is  null;
insert into dm_template_veri (module_name,table_name,column_name,veri_code,veri_result)
select '/home/guangjun/git/dctemplates/app/uploads/UAL_Mapping_Party_V0.2.9.xlsx' as module_name,'DM_PARTY' as table_name,'PARTY_ID' as column_name,'VERI_PRIMARY_KEY' as veri_code,count(*) as veri_result from DM_PARTY
 where (select count(*) from DM_PARTY  b where DM_PARTY.PARTY_ID=b.PARTY_ID)>1;
insert into dm_template_veri (module_name,table_name,column_name,veri_code,veri_result)
select '/home/guangjun/git/dctemplates/app/uploads/UAL_Mapping_Party_V0.2.9.xlsx' as module_name,'DM_PARTY' as table_name,'PARTY_TYPE' as column_name,'VERI_STRING_LENGTH_OVER_DEF' as veri_code,count(*) as veri_result from DM_PARTY
 where length(PARTY_TYPE)>2 and PARTY_TYPE is not null;
insert into dm_template_veri (module_name,table_name,column_name,veri_code,veri_result)
select '/home/guangjun/git/dctemplates/app/uploads/UAL_Mapping_Party_V0.2.9.xlsx' as module_name,'DM_PARTY' as table_name,'PARTY_TYPE' as column_name,'VERI_NON_NULLABLE' as veri_code,count(*) as veri_result from DM_PARTY
 where PARTY_TYPE is  null;
insert into dm_template_veri (module_name,table_name,column_name,veri_code,veri_result)
select '/home/guangjun/git/dctemplates/app/uploads/UAL_Mapping_Party_V0.2.9.xlsx' as module_name,'DM_PARTY' as table_name,'PARTY_TYPE' as column_name,'VERI_FOREIGN_KEY_TEMPLATE' as veri_code,count(*) as veri_result from DM_PARTY
 where ( not exists(select 1 from T_PARTY_TYPE  b where DM_PARTY.PARTY_TYPE=b.PARTY_TYPE) and PARTY_TYPE is not null);
insert into dm_template_veri (module_name,table_name,column_name,veri_code,veri_result)
select '/home/guangjun/git/dctemplates/app/uploads/UAL_Mapping_Party_V0.2.9.xlsx' as module_name,'DM_PARTY' as table_name,'INSERT_TIME' as column_name,'VERI_DATE_ILLEGAL' as veri_code,count(*) as veri_result from DM_PARTY
 where f_is_date(INSERT_TIME)=1 and INSERT_TIME is not null;
insert into dm_template_veri (module_name,table_name,column_name,veri_code,veri_result)
select '/home/guangjun/git/dctemplates/app/uploads/UAL_Mapping_Party_V0.2.9.xlsx' as module_name,'DM_PARTY' as table_name,'UPDATE_TIME' as column_name,'VERI_DATE_ILLEGAL' as veri_code,count(*) as veri_result from DM_PARTY
 where f_is_date(UPDATE_TIME)=1 and UPDATE_TIME is not null;
insert into dm_template_veri (module_name,table_name,column_name,veri_code,veri_result)
select '/home/guangjun/git/dctemplates/app/uploads/UAL_Mapping_Party_V0.2.9.xlsx' as module_name,'DM_BANK_ACCOUNT' as table_name,'ACCOUNT_ID' as column_name,'VERI_STRING_LENGTH_OVER_DEF' as veri_code,count(*) as veri_result from DM_BANK_ACCOUNT
 where length(ACCOUNT_ID)>20 and ACCOUNT_ID is not null;
insert into dm_template_veri (module_name,table_name,column_name,veri_code,veri_result)
select '/home/guangjun/git/dctemplates/app/uploads/UAL_Mapping_Party_V0.2.9.xlsx' as module_name,'DM_BANK_ACCOUNT' as table_name,'ACCOUNT_ID' as column_name,'VERI_NON_NULLABLE' as veri_code,count(*) as veri_result from DM_BANK_ACCOUNT
 where ACCOUNT_ID is  null;
insert into dm_template_veri (module_name,table_name,column_name,veri_code,veri_result)
select '/home/guangjun/git/dctemplates/app/uploads/UAL_Mapping_Party_V0.2.9.xlsx' as module_name,'DM_BANK_ACCOUNT' as table_name,'ACCOUNT_ID' as column_name,'VERI_PRIMARY_KEY' as veri_code,count(*) as veri_result from DM_BANK_ACCOUNT
 where (select count(*) from DM_BANK_ACCOUNT  b where DM_BANK_ACCOUNT.ACCOUNT_ID=b.ACCOUNT_ID)>1;
insert into dm_template_veri (module_name,table_name,column_name,veri_code,veri_result)
select '/home/guangjun/git/dctemplates/app/uploads/UAL_Mapping_Party_V0.2.9.xlsx' as module_name,'DM_BANK_ACCOUNT' as table_name,'BANK_CODE' as column_name,'VERI_STRING_LENGTH_OVER_DEF' as veri_code,count(*) as veri_result from DM_BANK_ACCOUNT
 where length(BANK_CODE)>20 and BANK_CODE is not null;
insert into dm_template_veri (module_name,table_name,column_name,veri_code,veri_result)
select '/home/guangjun/git/dctemplates/app/uploads/UAL_Mapping_Party_V0.2.9.xlsx' as module_name,'DM_BANK_ACCOUNT' as table_name,'BANK_CODE' as column_name,'VERI_NON_NULLABLE' as veri_code,count(*) as veri_result from DM_BANK_ACCOUNT
 where BANK_CODE is  null;
insert into dm_template_veri (module_name,table_name,column_name,veri_code,veri_result)
select '/home/guangjun/git/dctemplates/app/uploads/UAL_Mapping_Party_V0.2.9.xlsx' as module_name,'DM_BANK_ACCOUNT' as table_name,'BANK_CODE' as column_name,'VERI_FOREIGN_KEY_TEMPLATE' as veri_code,count(*) as veri_result from DM_BANK_ACCOUNT
 where ( not exists(select 1 from T_BANK  b where DM_BANK_ACCOUNT.BANK_CODE=b.bank_code) and BANK_CODE is not null);
insert into dm_template_veri (module_name,table_name,column_name,veri_code,veri_result)
select '/home/guangjun/git/dctemplates/app/uploads/UAL_Mapping_Party_V0.2.9.xlsx' as module_name,'DM_BANK_ACCOUNT' as table_name,'BANK_ACCOUNT' as column_name,'VERI_STRING_LENGTH_OVER_DEF' as veri_code,count(*) as veri_result from DM_BANK_ACCOUNT
 where length(BANK_ACCOUNT)>40 and BANK_ACCOUNT is not null;
insert into dm_template_veri (module_name,table_name,column_name,veri_code,veri_result)
select '/home/guangjun/git/dctemplates/app/uploads/UAL_Mapping_Party_V0.2.9.xlsx' as module_name,'DM_BANK_ACCOUNT' as table_name,'BANK_ACCOUNT' as column_name,'VERI_NON_NULLABLE' as veri_code,count(*) as veri_result from DM_BANK_ACCOUNT
 where BANK_ACCOUNT is  null;
insert into dm_template_veri (module_name,table_name,column_name,veri_code,veri_result)
select '/home/guangjun/git/dctemplates/app/uploads/UAL_Mapping_Party_V0.2.9.xlsx' as module_name,'DM_BANK_ACCOUNT' as table_name,'ACCO_NAME' as column_name,'VERI_STRING_LENGTH_OVER_DEF' as veri_code,count(*) as veri_result from DM_BANK_ACCOUNT
 where length(ACCO_NAME)>100 and ACCO_NAME is not null;
insert into dm_template_veri (module_name,table_name,column_name,veri_code,veri_result)
select '/home/guangjun/git/dctemplates/app/uploads/UAL_Mapping_Party_V0.2.9.xlsx' as module_name,'DM_BANK_ACCOUNT' as table_name,'CERTI_TYPE' as column_name,'VERI_NUMBER_ILLEGAL' as veri_code,count(*) as veri_result from DM_BANK_ACCOUNT
 where f_is_number(CERTI_TYPE)=1 and CERTI_TYPE is not null;
insert into dm_template_veri (module_name,table_name,column_name,veri_code,veri_result)
select '/home/guangjun/git/dctemplates/app/uploads/UAL_Mapping_Party_V0.2.9.xlsx' as module_name,'DM_BANK_ACCOUNT' as table_name,'CERTI_TYPE' as column_name,'VERI_FOREIGN_KEY_TEMPLATE' as veri_code,count(*) as veri_result from DM_BANK_ACCOUNT
 where ( not exists(select 1 from T_CERTI_TYPE  b where DM_BANK_ACCOUNT.CERTI_TYPE=b.TYPE_ID) and CERTI_TYPE is not null);
insert into dm_template_veri (module_name,table_name,column_name,veri_code,veri_result)
select '/home/guangjun/git/dctemplates/app/uploads/UAL_Mapping_Party_V0.2.9.xlsx' as module_name,'DM_BANK_ACCOUNT' as table_name,'CERTI_CODE' as column_name,'VERI_STRING_LENGTH_OVER_DEF' as veri_code,count(*) as veri_result from DM_BANK_ACCOUNT
 where length(CERTI_CODE)>50 and CERTI_CODE is not null;
insert into dm_template_veri (module_name,table_name,column_name,veri_code,veri_result)
select '/home/guangjun/git/dctemplates/app/uploads/UAL_Mapping_Party_V0.2.9.xlsx' as module_name,'DM_BANK_ACCOUNT' as table_name,'APPLY_DATE' as column_name,'VERI_DATE_ILLEGAL' as veri_code,count(*) as veri_result from DM_BANK_ACCOUNT
 where f_is_date(APPLY_DATE)=1 and APPLY_DATE is not null;
insert into dm_template_veri (module_name,table_name,column_name,veri_code,veri_result)
select '/home/guangjun/git/dctemplates/app/uploads/UAL_Mapping_Party_V0.2.9.xlsx' as module_name,'DM_BANK_ACCOUNT' as table_name,'APPLY_DATE' as column_name,'VERI_NON_NULLABLE' as veri_code,count(*) as veri_result from DM_BANK_ACCOUNT
 where APPLY_DATE is  null;
insert into dm_template_veri (module_name,table_name,column_name,veri_code,veri_result)
select '/home/guangjun/git/dctemplates/app/uploads/UAL_Mapping_Party_V0.2.9.xlsx' as module_name,'DM_BANK_ACCOUNT' as table_name,'ACCOUNT_TYPE' as column_name,'VERI_STRING_LENGTH_OVER_DEF' as veri_code,count(*) as veri_result from DM_BANK_ACCOUNT
 where length(ACCOUNT_TYPE)>2 and ACCOUNT_TYPE is not null;
insert into dm_template_veri (module_name,table_name,column_name,veri_code,veri_result)
select '/home/guangjun/git/dctemplates/app/uploads/UAL_Mapping_Party_V0.2.9.xlsx' as module_name,'DM_BANK_ACCOUNT' as table_name,'ACCOUNT_TYPE' as column_name,'VERI_NON_NULLABLE' as veri_code,count(*) as veri_result from DM_BANK_ACCOUNT
 where ACCOUNT_TYPE is  null;
insert into dm_template_veri (module_name,table_name,column_name,veri_code,veri_result)
select '/home/guangjun/git/dctemplates/app/uploads/UAL_Mapping_Party_V0.2.9.xlsx' as module_name,'DM_BANK_ACCOUNT' as table_name,'ACCOUNT_TYPE' as column_name,'VERI_FOREIGN_KEY_TEMPLATE' as veri_code,count(*) as veri_result from DM_BANK_ACCOUNT
 where ( not exists(select 1 from T_ACCOUNT_TYPE  b where DM_BANK_ACCOUNT.ACCOUNT_TYPE=b.account_type) and ACCOUNT_TYPE is not null);
insert into dm_template_veri (module_name,table_name,column_name,veri_code,veri_result)
select '/home/guangjun/git/dctemplates/app/uploads/UAL_Mapping_Party_V0.2.9.xlsx' as module_name,'DM_BANK_ACCOUNT' as table_name,'EXPIRE_DATE' as column_name,'VERI_DATE_ILLEGAL' as veri_code,count(*) as veri_result from DM_BANK_ACCOUNT
 where f_is_date(EXPIRE_DATE)=1 and EXPIRE_DATE is not null;
insert into dm_template_veri (module_name,table_name,column_name,veri_code,veri_result)
select '/home/guangjun/git/dctemplates/app/uploads/UAL_Mapping_Party_V0.2.9.xlsx' as module_name,'DM_BANK_ACCOUNT' as table_name,'CREDIT_CARD_TYPE' as column_name,'VERI_STRING_LENGTH_OVER_DEF' as veri_code,count(*) as veri_result from DM_BANK_ACCOUNT
 where length(CREDIT_CARD_TYPE)>1 and CREDIT_CARD_TYPE is not null;
insert into dm_template_veri (module_name,table_name,column_name,veri_code,veri_result)
select '/home/guangjun/git/dctemplates/app/uploads/UAL_Mapping_Party_V0.2.9.xlsx' as module_name,'DM_BANK_ACCOUNT' as table_name,'CREDIT_CARD_TYPE' as column_name,'VERI_FOREIGN_KEY_TEMPLATE' as veri_code,count(*) as veri_result from DM_BANK_ACCOUNT
 where ( not exists(select 1 from T_CREDIT_CARD_TYPE  b where DM_BANK_ACCOUNT.CREDIT_CARD_TYPE=b.credit_card_type) and CREDIT_CARD_TYPE is not null);
insert into dm_template_veri (module_name,table_name,column_name,veri_code,veri_result)
select '/home/guangjun/git/dctemplates/app/uploads/UAL_Mapping_Party_V0.2.9.xlsx' as module_name,'DM_BANK_ACCOUNT' as table_name,'DEBIT_CREDIT_TYPE' as column_name,'VERI_STRING_LENGTH_OVER_DEF' as veri_code,count(*) as veri_result from DM_BANK_ACCOUNT
 where length(DEBIT_CREDIT_TYPE)>1 and DEBIT_CREDIT_TYPE is not null;
insert into dm_template_veri (module_name,table_name,column_name,veri_code,veri_result)
select '/home/guangjun/git/dctemplates/app/uploads/UAL_Mapping_Party_V0.2.9.xlsx' as module_name,'DM_BANK_ACCOUNT' as table_name,'DEBIT_CREDIT_TYPE' as column_name,'VERI_NON_NULLABLE' as veri_code,count(*) as veri_result from DM_BANK_ACCOUNT
 where DEBIT_CREDIT_TYPE is  null;
insert into dm_template_veri (module_name,table_name,column_name,veri_code,veri_result)
select '/home/guangjun/git/dctemplates/app/uploads/UAL_Mapping_Party_V0.2.9.xlsx' as module_name,'DM_BANK_ACCOUNT' as table_name,'DEBIT_CREDIT_TYPE' as column_name,'VERI_FOREIGN_KEY_TEMPLATE' as veri_code,count(*) as veri_result from DM_BANK_ACCOUNT
 where ( not exists(select 1 from T_DEBIT_CREDIT_TYPE  b where DM_BANK_ACCOUNT.DEBIT_CREDIT_TYPE=b.debit_credit_type) and DEBIT_CREDIT_TYPE is not null);
insert into dm_template_veri (module_name,table_name,column_name,veri_code,veri_result)
select '/home/guangjun/git/dctemplates/app/uploads/UAL_Mapping_Party_V0.2.9.xlsx' as module_name,'DM_BANK_ACCOUNT' as table_name,'PARTY_ID' as column_name,'VERI_NUMBER_ILLEGAL' as veri_code,count(*) as veri_result from DM_BANK_ACCOUNT
 where f_is_number(PARTY_ID)=1 and PARTY_ID is not null;
insert into dm_template_veri (module_name,table_name,column_name,veri_code,veri_result)
select '/home/guangjun/git/dctemplates/app/uploads/UAL_Mapping_Party_V0.2.9.xlsx' as module_name,'DM_BANK_ACCOUNT' as table_name,'PARTY_ID' as column_name,'VERI_FOREIGN_KEY_TEMPLATE' as veri_code,count(*) as veri_result from DM_BANK_ACCOUNT
 where ( not exists(select 1 from DM_PARTY  b where DM_BANK_ACCOUNT.PARTY_ID=b.PARTY_ID) and PARTY_ID is not null);
insert into dm_template_veri (module_name,table_name,column_name,veri_code,veri_result)
select '/home/guangjun/git/dctemplates/app/uploads/UAL_Mapping_Party_V0.2.9.xlsx' as module_name,'DM_BANK_ACCOUNT' as table_name,'ACCOUNT_STATUS' as column_name,'VERI_STRING_LENGTH_OVER_DEF' as veri_code,count(*) as veri_result from DM_BANK_ACCOUNT
 where length(ACCOUNT_STATUS)>1 and ACCOUNT_STATUS is not null;
insert into dm_template_veri (module_name,table_name,column_name,veri_code,veri_result)
select '/home/guangjun/git/dctemplates/app/uploads/UAL_Mapping_Party_V0.2.9.xlsx' as module_name,'DM_BANK_ACCOUNT' as table_name,'ACCOUNT_STATUS' as column_name,'VERI_NON_NULLABLE' as veri_code,count(*) as veri_result from DM_BANK_ACCOUNT
 where ACCOUNT_STATUS is  null;
insert into dm_template_veri (module_name,table_name,column_name,veri_code,veri_result)
select '/home/guangjun/git/dctemplates/app/uploads/UAL_Mapping_Party_V0.2.9.xlsx' as module_name,'DM_BANK_ACCOUNT' as table_name,'IS_SELF' as column_name,'VERI_STRING_LENGTH_OVER_DEF' as veri_code,count(*) as veri_result from DM_BANK_ACCOUNT
 where length(IS_SELF)>1 and IS_SELF is not null;
insert into dm_template_veri (module_name,table_name,column_name,veri_code,veri_result)
select '/home/guangjun/git/dctemplates/app/uploads/UAL_Mapping_Party_V0.2.9.xlsx' as module_name,'DM_BANK_ACCOUNT' as table_name,'IS_SELF' as column_name,'VERI_NON_NULLABLE' as veri_code,count(*) as veri_result from DM_BANK_ACCOUNT
 where IS_SELF is  null;
insert into dm_template_veri (module_name,table_name,column_name,veri_code,veri_result)
select '/home/guangjun/git/dctemplates/app/uploads/UAL_Mapping_Party_V0.2.9.xlsx' as module_name,'DM_BANK_ACCOUNT' as table_name,'SUSPEND_CAUSE' as column_name,'VERI_STRING_LENGTH_OVER_DEF' as veri_code,count(*) as veri_result from DM_BANK_ACCOUNT
 where length(SUSPEND_CAUSE)>1 and SUSPEND_CAUSE is not null;
insert into dm_template_veri (module_name,table_name,column_name,veri_code,veri_result)
select '/home/guangjun/git/dctemplates/app/uploads/UAL_Mapping_Party_V0.2.9.xlsx' as module_name,'DM_BANK_ACCOUNT' as table_name,'CAUSE_DESC' as column_name,'VERI_STRING_LENGTH_OVER_DEF' as veri_code,count(*) as veri_result from DM_BANK_ACCOUNT
 where length(CAUSE_DESC)>1000 and CAUSE_DESC is not null;
insert into dm_template_veri (module_name,table_name,column_name,veri_code,veri_result)
select '/home/guangjun/git/dctemplates/app/uploads/UAL_Mapping_Party_V0.2.9.xlsx' as module_name,'DM_PARTY_COMMENT' as table_name,'COMMENT_ID' as column_name,'VERI_NUMBER_ILLEGAL' as veri_code,count(*) as veri_result from DM_PARTY_COMMENT
 where f_is_number(COMMENT_ID)=1 and COMMENT_ID is not null;
insert into dm_template_veri (module_name,table_name,column_name,veri_code,veri_result)
select '/home/guangjun/git/dctemplates/app/uploads/UAL_Mapping_Party_V0.2.9.xlsx' as module_name,'DM_PARTY_COMMENT' as table_name,'COMMENT_ID' as column_name,'VERI_NON_NULLABLE' as veri_code,count(*) as veri_result from DM_PARTY_COMMENT
 where COMMENT_ID is  null;
insert into dm_template_veri (module_name,table_name,column_name,veri_code,veri_result)
select '/home/guangjun/git/dctemplates/app/uploads/UAL_Mapping_Party_V0.2.9.xlsx' as module_name,'DM_PARTY_COMMENT' as table_name,'COMMENT_ID' as column_name,'VERI_PRIMARY_KEY' as veri_code,count(*) as veri_result from DM_PARTY_COMMENT
 where (select count(*) from DM_PARTY_COMMENT  b where DM_PARTY_COMMENT.COMMENT_ID=b.COMMENT_ID)>1;
insert into dm_template_veri (module_name,table_name,column_name,veri_code,veri_result)
select '/home/guangjun/git/dctemplates/app/uploads/UAL_Mapping_Party_V0.2.9.xlsx' as module_name,'DM_PARTY_COMMENT' as table_name,'PARTY_ID' as column_name,'VERI_NUMBER_ILLEGAL' as veri_code,count(*) as veri_result from DM_PARTY_COMMENT
 where f_is_number(PARTY_ID)=1 and PARTY_ID is not null;
insert into dm_template_veri (module_name,table_name,column_name,veri_code,veri_result)
select '/home/guangjun/git/dctemplates/app/uploads/UAL_Mapping_Party_V0.2.9.xlsx' as module_name,'DM_PARTY_COMMENT' as table_name,'PARTY_ID' as column_name,'VERI_NON_NULLABLE' as veri_code,count(*) as veri_result from DM_PARTY_COMMENT
 where PARTY_ID is  null;
insert into dm_template_veri (module_name,table_name,column_name,veri_code,veri_result)
select '/home/guangjun/git/dctemplates/app/uploads/UAL_Mapping_Party_V0.2.9.xlsx' as module_name,'DM_PARTY_COMMENT' as table_name,'PARTY_ID' as column_name,'VERI_FOREIGN_KEY_TEMPLATE' as veri_code,count(*) as veri_result from DM_PARTY_COMMENT
 where ( not exists(select 1 from DM_PARTY  b where DM_PARTY_COMMENT.PARTY_ID=b.PARTY_ID) and PARTY_ID is not null);
insert into dm_template_veri (module_name,table_name,column_name,veri_code,veri_result)
select '/home/guangjun/git/dctemplates/app/uploads/UAL_Mapping_Party_V0.2.9.xlsx' as module_name,'DM_PARTY_COMMENT' as table_name,'COMMENTS' as column_name,'VERI_STRING_LENGTH_OVER_DEF' as veri_code,count(*) as veri_result from DM_PARTY_COMMENT
 where length(COMMENTS)>1000 and COMMENTS is not null;
insert into dm_template_veri (module_name,table_name,column_name,veri_code,veri_result)
select '/home/guangjun/git/dctemplates/app/uploads/UAL_Mapping_Party_V0.2.9.xlsx' as module_name,'DM_PARTY_COMMENT' as table_name,'COMMENTS' as column_name,'VERI_NON_NULLABLE' as veri_code,count(*) as veri_result from DM_PARTY_COMMENT
 where COMMENTS is  null;
insert into dm_template_veri (module_name,table_name,column_name,veri_code,veri_result)
select '/home/guangjun/git/dctemplates/app/uploads/UAL_Mapping_Party_V0.2.9.xlsx' as module_name,'DM_PARTY_COMMENT' as table_name,'START_DATE' as column_name,'VERI_DATE_ILLEGAL' as veri_code,count(*) as veri_result from DM_PARTY_COMMENT
 where f_is_date(START_DATE)=1 and START_DATE is not null;
insert into dm_template_veri (module_name,table_name,column_name,veri_code,veri_result)
select '/home/guangjun/git/dctemplates/app/uploads/UAL_Mapping_Party_V0.2.9.xlsx' as module_name,'DM_CUSTOMER' as table_name,'CUSTOMER_ID' as column_name,'VERI_NUMBER_ILLEGAL' as veri_code,count(*) as veri_result from DM_CUSTOMER
 where f_is_number(CUSTOMER_ID)=1 and CUSTOMER_ID is not null;
insert into dm_template_veri (module_name,table_name,column_name,veri_code,veri_result)
select '/home/guangjun/git/dctemplates/app/uploads/UAL_Mapping_Party_V0.2.9.xlsx' as module_name,'DM_CUSTOMER' as table_name,'CUSTOMER_ID' as column_name,'VERI_NON_NULLABLE' as veri_code,count(*) as veri_result from DM_CUSTOMER
 where CUSTOMER_ID is  null;
insert into dm_template_veri (module_name,table_name,column_name,veri_code,veri_result)
select '/home/guangjun/git/dctemplates/app/uploads/UAL_Mapping_Party_V0.2.9.xlsx' as module_name,'DM_CUSTOMER' as table_name,'CUSTOMER_ID' as column_name,'VERI_PRIMARY_KEY' as veri_code,count(*) as veri_result from DM_CUSTOMER
 where (select count(*) from DM_CUSTOMER  b where DM_CUSTOMER.CUSTOMER_ID=b.CUSTOMER_ID)>1;
insert into dm_template_veri (module_name,table_name,column_name,veri_code,veri_result)
select '/home/guangjun/git/dctemplates/app/uploads/UAL_Mapping_Party_V0.2.9.xlsx' as module_name,'DM_CUSTOMER' as table_name,'CUSTOMER_ID' as column_name,'VERI_FOREIGN_KEY_TEMPLATE' as veri_code,count(*) as veri_result from DM_CUSTOMER
 where ( not exists(select 1 from DM_PARTY  b where DM_CUSTOMER.CUSTOMER_ID=b.PARTY_ID) and CUSTOMER_ID is not null);
insert into dm_template_veri (module_name,table_name,column_name,veri_code,veri_result)
select '/home/guangjun/git/dctemplates/app/uploads/UAL_Mapping_Party_V0.2.9.xlsx' as module_name,'DM_CUSTOMER' as table_name,'GENDER' as column_name,'VERI_STRING_LENGTH_OVER_DEF' as veri_code,count(*) as veri_result from DM_CUSTOMER
 where length(GENDER)>1 and GENDER is not null;
insert into dm_template_veri (module_name,table_name,column_name,veri_code,veri_result)
select '/home/guangjun/git/dctemplates/app/uploads/UAL_Mapping_Party_V0.2.9.xlsx' as module_name,'DM_CUSTOMER' as table_name,'GENDER' as column_name,'VERI_FOREIGN_KEY_TEMPLATE' as veri_code,count(*) as veri_result from DM_CUSTOMER
 where ( not exists(select 1 from T_GENDER  b where DM_CUSTOMER.GENDER=b.GENDER_CODE) and GENDER is not null);
insert into dm_template_veri (module_name,table_name,column_name,veri_code,veri_result)
select '/home/guangjun/git/dctemplates/app/uploads/UAL_Mapping_Party_V0.2.9.xlsx' as module_name,'DM_CUSTOMER' as table_name,'BIRTHDAY' as column_name,'VERI_DATE_ILLEGAL' as veri_code,count(*) as veri_result from DM_CUSTOMER
 where f_is_date(BIRTHDAY)=1 and BIRTHDAY is not null;
insert into dm_template_veri (module_name,table_name,column_name,veri_code,veri_result)
select '/home/guangjun/git/dctemplates/app/uploads/UAL_Mapping_Party_V0.2.9.xlsx' as module_name,'DM_CUSTOMER' as table_name,'CERTI_TYPE' as column_name,'VERI_NUMBER_ILLEGAL' as veri_code,count(*) as veri_result from DM_CUSTOMER
 where f_is_number(CERTI_TYPE)=1 and CERTI_TYPE is not null;
insert into dm_template_veri (module_name,table_name,column_name,veri_code,veri_result)
select '/home/guangjun/git/dctemplates/app/uploads/UAL_Mapping_Party_V0.2.9.xlsx' as module_name,'DM_CUSTOMER' as table_name,'CERTI_TYPE' as column_name,'VERI_FOREIGN_KEY_TEMPLATE' as veri_code,count(*) as veri_result from DM_CUSTOMER
 where ( not exists(select 1 from T_CERTI_TYPE  b where DM_CUSTOMER.CERTI_TYPE=b.TYPE_ID) and CERTI_TYPE is not null);
insert into dm_template_veri (module_name,table_name,column_name,veri_code,veri_result)
select '/home/guangjun/git/dctemplates/app/uploads/UAL_Mapping_Party_V0.2.9.xlsx' as module_name,'DM_CUSTOMER' as table_name,'CERTI_CODE' as column_name,'VERI_STRING_LENGTH_OVER_DEF' as veri_code,count(*) as veri_result from DM_CUSTOMER
 where length(CERTI_CODE)>50 and CERTI_CODE is not null;
insert into dm_template_veri (module_name,table_name,column_name,veri_code,veri_result)
select '/home/guangjun/git/dctemplates/app/uploads/UAL_Mapping_Party_V0.2.9.xlsx' as module_name,'DM_CUSTOMER' as table_name,'MARRIAGE_ID' as column_name,'VERI_STRING_LENGTH_OVER_DEF' as veri_code,count(*) as veri_result from DM_CUSTOMER
 where length(MARRIAGE_ID)>1 and MARRIAGE_ID is not null;
insert into dm_template_veri (module_name,table_name,column_name,veri_code,veri_result)
select '/home/guangjun/git/dctemplates/app/uploads/UAL_Mapping_Party_V0.2.9.xlsx' as module_name,'DM_CUSTOMER' as table_name,'MARRIAGE_ID' as column_name,'VERI_FOREIGN_KEY_TEMPLATE' as veri_code,count(*) as veri_result from DM_CUSTOMER
 where ( not exists(select 1 from T_MARRIAGE  b where DM_CUSTOMER.MARRIAGE_ID=b.marriage_id) and MARRIAGE_ID is not null);
insert into dm_template_veri (module_name,table_name,column_name,veri_code,veri_result)
select '/home/guangjun/git/dctemplates/app/uploads/UAL_Mapping_Party_V0.2.9.xlsx' as module_name,'DM_CUSTOMER' as table_name,'EDUCATION_ID' as column_name,'VERI_STRING_LENGTH_OVER_DEF' as veri_code,count(*) as veri_result from DM_CUSTOMER
 where length(EDUCATION_ID)>2 and EDUCATION_ID is not null;
insert into dm_template_veri (module_name,table_name,column_name,veri_code,veri_result)
select '/home/guangjun/git/dctemplates/app/uploads/UAL_Mapping_Party_V0.2.9.xlsx' as module_name,'DM_CUSTOMER' as table_name,'EDUCATION_ID' as column_name,'VERI_FOREIGN_KEY_TEMPLATE' as veri_code,count(*) as veri_result from DM_CUSTOMER
 where ( not exists(select 1 from T_EDUCATION  b where DM_CUSTOMER.EDUCATION_ID=b.education_id) and EDUCATION_ID is not null);
insert into dm_template_veri (module_name,table_name,column_name,veri_code,veri_result)
select '/home/guangjun/git/dctemplates/app/uploads/UAL_Mapping_Party_V0.2.9.xlsx' as module_name,'DM_CUSTOMER' as table_name,'HEIGHT' as column_name,'VERI_NUMBER_ILLEGAL' as veri_code,count(*) as veri_result from DM_CUSTOMER
 where f_is_number(HEIGHT)=1 and HEIGHT is not null;
insert into dm_template_veri (module_name,table_name,column_name,veri_code,veri_result)
select '/home/guangjun/git/dctemplates/app/uploads/UAL_Mapping_Party_V0.2.9.xlsx' as module_name,'DM_CUSTOMER' as table_name,'WEIGHT' as column_name,'VERI_NUMBER_ILLEGAL' as veri_code,count(*) as veri_result from DM_CUSTOMER
 where f_is_number(WEIGHT)=1 and WEIGHT is not null;
insert into dm_template_veri (module_name,table_name,column_name,veri_code,veri_result)
select '/home/guangjun/git/dctemplates/app/uploads/UAL_Mapping_Party_V0.2.9.xlsx' as module_name,'DM_CUSTOMER' as table_name,'EMAIL' as column_name,'VERI_STRING_LENGTH_OVER_DEF' as veri_code,count(*) as veri_result from DM_CUSTOMER
 where length(EMAIL)>100 and EMAIL is not null;
insert into dm_template_veri (module_name,table_name,column_name,veri_code,veri_result)
select '/home/guangjun/git/dctemplates/app/uploads/UAL_Mapping_Party_V0.2.9.xlsx' as module_name,'DM_CUSTOMER' as table_name,'INCOME' as column_name,'VERI_NUMBER_ILLEGAL' as veri_code,count(*) as veri_result from DM_CUSTOMER
 where f_is_number(INCOME)=1 and INCOME is not null;
insert into dm_template_veri (module_name,table_name,column_name,veri_code,veri_result)
select '/home/guangjun/git/dctemplates/app/uploads/UAL_Mapping_Party_V0.2.9.xlsx' as module_name,'DM_CUSTOMER' as table_name,'JOB_CATE_ID' as column_name,'VERI_NUMBER_ILLEGAL' as veri_code,count(*) as veri_result from DM_CUSTOMER
 where f_is_number(JOB_CATE_ID)=1 and JOB_CATE_ID is not null;
insert into dm_template_veri (module_name,table_name,column_name,veri_code,veri_result)
select '/home/guangjun/git/dctemplates/app/uploads/UAL_Mapping_Party_V0.2.9.xlsx' as module_name,'DM_CUSTOMER' as table_name,'JOB_CATE_ID' as column_name,'VERI_FOREIGN_KEY_TEMPLATE' as veri_code,count(*) as veri_result from DM_CUSTOMER
 where ( not exists(select 1 from T_JOB_CATEGORY  b where DM_CUSTOMER.JOB_CATE_ID=b.job_cate_id) and JOB_CATE_ID is not null);
insert into dm_template_veri (module_name,table_name,column_name,veri_code,veri_result)
select '/home/guangjun/git/dctemplates/app/uploads/UAL_Mapping_Party_V0.2.9.xlsx' as module_name,'DM_CUSTOMER' as table_name,'NATIONALITY' as column_name,'VERI_STRING_LENGTH_OVER_DEF' as veri_code,count(*) as veri_result from DM_CUSTOMER
 where length(NATIONALITY)>3 and NATIONALITY is not null;
insert into dm_template_veri (module_name,table_name,column_name,veri_code,veri_result)
select '/home/guangjun/git/dctemplates/app/uploads/UAL_Mapping_Party_V0.2.9.xlsx' as module_name,'DM_CUSTOMER' as table_name,'NATIONALITY' as column_name,'VERI_FOREIGN_KEY_TEMPLATE' as veri_code,count(*) as veri_result from DM_CUSTOMER
 where ( not exists(select 1 from T_NATIONALITY_CODE  b where DM_CUSTOMER.NATIONALITY=b.nationality_code) and NATIONALITY is not null);
insert into dm_template_veri (module_name,table_name,column_name,veri_code,veri_result)
select '/home/guangjun/git/dctemplates/app/uploads/UAL_Mapping_Party_V0.2.9.xlsx' as module_name,'DM_CUSTOMER' as table_name,'SMOKING' as column_name,'VERI_STRING_LENGTH_OVER_DEF' as veri_code,count(*) as veri_result from DM_CUSTOMER
 where length(SMOKING)>1 and SMOKING is not null;
insert into dm_template_veri (module_name,table_name,column_name,veri_code,veri_result)
select '/home/guangjun/git/dctemplates/app/uploads/UAL_Mapping_Party_V0.2.9.xlsx' as module_name,'DM_CUSTOMER' as table_name,'SMOKING' as column_name,'VERI_NON_NULLABLE' as veri_code,count(*) as veri_result from DM_CUSTOMER
 where SMOKING is  null;
insert into dm_template_veri (module_name,table_name,column_name,veri_code,veri_result)
select '/home/guangjun/git/dctemplates/app/uploads/UAL_Mapping_Party_V0.2.9.xlsx' as module_name,'DM_CUSTOMER' as table_name,'DEATH_TIME' as column_name,'VERI_DATE_ILLEGAL' as veri_code,count(*) as veri_result from DM_CUSTOMER
 where f_is_date(DEATH_TIME)=1 and DEATH_TIME is not null;
insert into dm_template_veri (module_name,table_name,column_name,veri_code,veri_result)
select '/home/guangjun/git/dctemplates/app/uploads/UAL_Mapping_Party_V0.2.9.xlsx' as module_name,'DM_CUSTOMER' as table_name,'DRIVING_LICENCE' as column_name,'VERI_STRING_LENGTH_OVER_DEF' as veri_code,count(*) as veri_result from DM_CUSTOMER
 where length(DRIVING_LICENCE)>1 and DRIVING_LICENCE is not null;
insert into dm_template_veri (module_name,table_name,column_name,veri_code,veri_result)
select '/home/guangjun/git/dctemplates/app/uploads/UAL_Mapping_Party_V0.2.9.xlsx' as module_name,'DM_CUSTOMER' as table_name,'DRIVING_LICENCE' as column_name,'VERI_NON_NULLABLE' as veri_code,count(*) as veri_result from DM_CUSTOMER
 where DRIVING_LICENCE is  null;
insert into dm_template_veri (module_name,table_name,column_name,veri_code,veri_result)
select '/home/guangjun/git/dctemplates/app/uploads/UAL_Mapping_Party_V0.2.9.xlsx' as module_name,'DM_CUSTOMER' as table_name,'RETIRED' as column_name,'VERI_STRING_LENGTH_OVER_DEF' as veri_code,count(*) as veri_result from DM_CUSTOMER
 where length(RETIRED)>1 and RETIRED is not null;
insert into dm_template_veri (module_name,table_name,column_name,veri_code,veri_result)
select '/home/guangjun/git/dctemplates/app/uploads/UAL_Mapping_Party_V0.2.9.xlsx' as module_name,'DM_CUSTOMER' as table_name,'RETIRED' as column_name,'VERI_NON_NULLABLE' as veri_code,count(*) as veri_result from DM_CUSTOMER
 where RETIRED is  null;
insert into dm_template_veri (module_name,table_name,column_name,veri_code,veri_result)
select '/home/guangjun/git/dctemplates/app/uploads/UAL_Mapping_Party_V0.2.9.xlsx' as module_name,'DM_CUSTOMER' as table_name,'RETIRED' as column_name,'VERI_FOREIGN_KEY_TEMPLATE' as veri_code,count(*) as veri_result from DM_CUSTOMER
 where ( not exists(select 1 from T_YES_NO  b where DM_CUSTOMER.RETIRED=b.YES_NO) and RETIRED is not null);
insert into dm_template_veri (module_name,table_name,column_name,veri_code,veri_result)
select '/home/guangjun/git/dctemplates/app/uploads/UAL_Mapping_Party_V0.2.9.xlsx' as module_name,'DM_CUSTOMER' as table_name,'LANG_ID' as column_name,'VERI_STRING_LENGTH_OVER_DEF' as veri_code,count(*) as veri_result from DM_CUSTOMER
 where length(LANG_ID)>3 and LANG_ID is not null;
insert into dm_template_veri (module_name,table_name,column_name,veri_code,veri_result)
select '/home/guangjun/git/dctemplates/app/uploads/UAL_Mapping_Party_V0.2.9.xlsx' as module_name,'DM_CUSTOMER' as table_name,'LANG_ID' as column_name,'VERI_FOREIGN_KEY_TEMPLATE' as veri_code,count(*) as veri_result from DM_CUSTOMER
 where ( not exists(select 1 from T_LANGUAGE  b where DM_CUSTOMER.LANG_ID=b.lang_id) and LANG_ID is not null);
insert into dm_template_veri (module_name,table_name,column_name,veri_code,veri_result)
select '/home/guangjun/git/dctemplates/app/uploads/UAL_Mapping_Party_V0.2.9.xlsx' as module_name,'DM_CUSTOMER' as table_name,'HOMEPLACE' as column_name,'VERI_STRING_LENGTH_OVER_DEF' as veri_code,count(*) as veri_result from DM_CUSTOMER
 where length(HOMEPLACE)>100 and HOMEPLACE is not null;
insert into dm_template_veri (module_name,table_name,column_name,veri_code,veri_result)
select '/home/guangjun/git/dctemplates/app/uploads/UAL_Mapping_Party_V0.2.9.xlsx' as module_name,'DM_CUSTOMER' as table_name,'NATION_CODE' as column_name,'VERI_STRING_LENGTH_OVER_DEF' as veri_code,count(*) as veri_result from DM_CUSTOMER
 where length(NATION_CODE)>2 and NATION_CODE is not null;
insert into dm_template_veri (module_name,table_name,column_name,veri_code,veri_result)
select '/home/guangjun/git/dctemplates/app/uploads/UAL_Mapping_Party_V0.2.9.xlsx' as module_name,'DM_CUSTOMER' as table_name,'NATION_CODE' as column_name,'VERI_FOREIGN_KEY_TEMPLATE' as veri_code,count(*) as veri_result from DM_CUSTOMER
 where ( not exists(select 1 from T_NATION  b where DM_CUSTOMER.NATION_CODE=b.nation_code) and NATION_CODE is not null);
insert into dm_template_veri (module_name,table_name,column_name,veri_code,veri_result)
select '/home/guangjun/git/dctemplates/app/uploads/UAL_Mapping_Party_V0.2.9.xlsx' as module_name,'DM_CUSTOMER' as table_name,'ACCIDENT_STATUS' as column_name,'VERI_STRING_LENGTH_OVER_DEF' as veri_code,count(*) as veri_result from DM_CUSTOMER
 where length(ACCIDENT_STATUS)>2 and ACCIDENT_STATUS is not null;
insert into dm_template_veri (module_name,table_name,column_name,veri_code,veri_result)
select '/home/guangjun/git/dctemplates/app/uploads/UAL_Mapping_Party_V0.2.9.xlsx' as module_name,'DM_CUSTOMER' as table_name,'ACCIDENT_STATUS' as column_name,'VERI_NON_NULLABLE' as veri_code,count(*) as veri_result from DM_CUSTOMER
 where ACCIDENT_STATUS is  null;
insert into dm_template_veri (module_name,table_name,column_name,veri_code,veri_result)
select '/home/guangjun/git/dctemplates/app/uploads/UAL_Mapping_Party_V0.2.9.xlsx' as module_name,'DM_CUSTOMER' as table_name,'ACCIDENT_STATUS' as column_name,'VERI_FOREIGN_KEY_TEMPLATE' as veri_code,count(*) as veri_result from DM_CUSTOMER
 where ( not exists(select 1 from T_ACCIDENT_STATUS  b where DM_CUSTOMER.ACCIDENT_STATUS=b.accident_status) and ACCIDENT_STATUS is not null);
insert into dm_template_veri (module_name,table_name,column_name,veri_code,veri_result)
select '/home/guangjun/git/dctemplates/app/uploads/UAL_Mapping_Party_V0.2.9.xlsx' as module_name,'DM_CUSTOMER' as table_name,'HONOR_TITLE' as column_name,'VERI_STRING_LENGTH_OVER_DEF' as veri_code,count(*) as veri_result from DM_CUSTOMER
 where length(HONOR_TITLE)>3 and HONOR_TITLE is not null;
insert into dm_template_veri (module_name,table_name,column_name,veri_code,veri_result)
select '/home/guangjun/git/dctemplates/app/uploads/UAL_Mapping_Party_V0.2.9.xlsx' as module_name,'DM_CUSTOMER' as table_name,'HONOR_TITLE' as column_name,'VERI_FOREIGN_KEY_TEMPLATE' as veri_code,count(*) as veri_result from DM_CUSTOMER
 where ( not exists(select 1 from T_TITLE  b where DM_CUSTOMER.HONOR_TITLE=b.title_code) and HONOR_TITLE is not null);
insert into dm_template_veri (module_name,table_name,column_name,veri_code,veri_result)
select '/home/guangjun/git/dctemplates/app/uploads/UAL_Mapping_Party_V0.2.9.xlsx' as module_name,'DM_CUSTOMER' as table_name,'CUST_GRADE' as column_name,'VERI_STRING_LENGTH_OVER_DEF' as veri_code,count(*) as veri_result from DM_CUSTOMER
 where length(CUST_GRADE)>2 and CUST_GRADE is not null;
insert into dm_template_veri (module_name,table_name,column_name,veri_code,veri_result)
select '/home/guangjun/git/dctemplates/app/uploads/UAL_Mapping_Party_V0.2.9.xlsx' as module_name,'DM_CUSTOMER' as table_name,'CUST_GRADE' as column_name,'VERI_NON_NULLABLE' as veri_code,count(*) as veri_result from DM_CUSTOMER
 where CUST_GRADE is  null;
insert into dm_template_veri (module_name,table_name,column_name,veri_code,veri_result)
select '/home/guangjun/git/dctemplates/app/uploads/UAL_Mapping_Party_V0.2.9.xlsx' as module_name,'DM_CUSTOMER' as table_name,'CUST_GRADE' as column_name,'VERI_FOREIGN_KEY_TEMPLATE' as veri_code,count(*) as veri_result from DM_CUSTOMER
 where ( not exists(select 1 from T_CUST_GRADE  b where DM_CUSTOMER.CUST_GRADE=b.CUST_GRADE) and CUST_GRADE is not null);
insert into dm_template_veri (module_name,table_name,column_name,veri_code,veri_result)
select '/home/guangjun/git/dctemplates/app/uploads/UAL_Mapping_Party_V0.2.9.xlsx' as module_name,'DM_CUSTOMER' as table_name,'COUNTRY_CODE' as column_name,'VERI_STRING_LENGTH_OVER_DEF' as veri_code,count(*) as veri_result from DM_CUSTOMER
 where length(COUNTRY_CODE)>3 and COUNTRY_CODE is not null;
insert into dm_template_veri (module_name,table_name,column_name,veri_code,veri_result)
select '/home/guangjun/git/dctemplates/app/uploads/UAL_Mapping_Party_V0.2.9.xlsx' as module_name,'DM_CUSTOMER' as table_name,'COUNTRY_CODE' as column_name,'VERI_FOREIGN_KEY_TEMPLATE' as veri_code,count(*) as veri_result from DM_CUSTOMER
 where ( not exists(select 1 from T_COUNTRY  b where DM_CUSTOMER.COUNTRY_CODE=b.country_code) and COUNTRY_CODE is not null);
insert into dm_template_veri (module_name,table_name,column_name,veri_code,veri_result)
select '/home/guangjun/git/dctemplates/app/uploads/UAL_Mapping_Party_V0.2.9.xlsx' as module_name,'DM_CUSTOMER' as table_name,'BLACKLIST_CAUSE' as column_name,'VERI_NUMBER_ILLEGAL' as veri_code,count(*) as veri_result from DM_CUSTOMER
 where f_is_number(BLACKLIST_CAUSE)=1 and BLACKLIST_CAUSE is not null;
insert into dm_template_veri (module_name,table_name,column_name,veri_code,veri_result)
select '/home/guangjun/git/dctemplates/app/uploads/UAL_Mapping_Party_V0.2.9.xlsx' as module_name,'DM_CUSTOMER' as table_name,'BLACKLIST_CAUSE' as column_name,'VERI_FOREIGN_KEY_TEMPLATE' as veri_code,count(*) as veri_result from DM_CUSTOMER
 where ( not exists(select 1 from T_BLACKLIST_CAUSE  b where DM_CUSTOMER.BLACKLIST_CAUSE=b.blacklist_cause) and BLACKLIST_CAUSE is not null);
insert into dm_template_veri (module_name,table_name,column_name,veri_code,veri_result)
select '/home/guangjun/git/dctemplates/app/uploads/UAL_Mapping_Party_V0.2.9.xlsx' as module_name,'DM_CUSTOMER' as table_name,'MOBILE' as column_name,'VERI_STRING_LENGTH_OVER_DEF' as veri_code,count(*) as veri_result from DM_CUSTOMER
 where length(MOBILE)>20 and MOBILE is not null;
insert into dm_template_veri (module_name,table_name,column_name,veri_code,veri_result)
select '/home/guangjun/git/dctemplates/app/uploads/UAL_Mapping_Party_V0.2.9.xlsx' as module_name,'DM_CUSTOMER' as table_name,'OFFICE_TEL' as column_name,'VERI_STRING_LENGTH_OVER_DEF' as veri_code,count(*) as veri_result from DM_CUSTOMER
 where length(OFFICE_TEL)>40 and OFFICE_TEL is not null;
insert into dm_template_veri (module_name,table_name,column_name,veri_code,veri_result)
select '/home/guangjun/git/dctemplates/app/uploads/UAL_Mapping_Party_V0.2.9.xlsx' as module_name,'DM_CUSTOMER' as table_name,'HOME_TEL' as column_name,'VERI_STRING_LENGTH_OVER_DEF' as veri_code,count(*) as veri_result from DM_CUSTOMER
 where length(HOME_TEL)>40 and HOME_TEL is not null;
insert into dm_template_veri (module_name,table_name,column_name,veri_code,veri_result)
select '/home/guangjun/git/dctemplates/app/uploads/UAL_Mapping_Party_V0.2.9.xlsx' as module_name,'DM_CUSTOMER' as table_name,'FIRST_NAME' as column_name,'VERI_STRING_LENGTH_OVER_DEF' as veri_code,count(*) as veri_result from DM_CUSTOMER
 where length(FIRST_NAME)>100 and FIRST_NAME is not null;
insert into dm_template_veri (module_name,table_name,column_name,veri_code,veri_result)
select '/home/guangjun/git/dctemplates/app/uploads/UAL_Mapping_Party_V0.2.9.xlsx' as module_name,'DM_CUSTOMER' as table_name,'MID_NAME' as column_name,'VERI_STRING_LENGTH_OVER_DEF' as veri_code,count(*) as veri_result from DM_CUSTOMER
 where length(MID_NAME)>150 and MID_NAME is not null;
insert into dm_template_veri (module_name,table_name,column_name,veri_code,veri_result)
select '/home/guangjun/git/dctemplates/app/uploads/UAL_Mapping_Party_V0.2.9.xlsx' as module_name,'DM_CUSTOMER' as table_name,'LAST_NAME' as column_name,'VERI_STRING_LENGTH_OVER_DEF' as veri_code,count(*) as veri_result from DM_CUSTOMER
 where length(LAST_NAME)>100 and LAST_NAME is not null;
insert into dm_template_veri (module_name,table_name,column_name,veri_code,veri_result)
select '/home/guangjun/git/dctemplates/app/uploads/UAL_Mapping_Party_V0.2.9.xlsx' as module_name,'DM_CUSTOMER' as table_name,'ALIAS_NAME' as column_name,'VERI_STRING_LENGTH_OVER_DEF' as veri_code,count(*) as veri_result from DM_CUSTOMER
 where length(ALIAS_NAME)>100 and ALIAS_NAME is not null;
insert into dm_template_veri (module_name,table_name,column_name,veri_code,veri_result)
select '/home/guangjun/git/dctemplates/app/uploads/UAL_Mapping_Party_V0.2.9.xlsx' as module_name,'DM_CUSTOMER' as table_name,'INDUSTRY_ID' as column_name,'VERI_NUMBER_ILLEGAL' as veri_code,count(*) as veri_result from DM_CUSTOMER
 where f_is_number(INDUSTRY_ID)=1 and INDUSTRY_ID is not null;
insert into dm_template_veri (module_name,table_name,column_name,veri_code,veri_result)
select '/home/guangjun/git/dctemplates/app/uploads/UAL_Mapping_Party_V0.2.9.xlsx' as module_name,'DM_CUSTOMER' as table_name,'INDUSTRY_ID' as column_name,'VERI_FOREIGN_KEY_TEMPLATE' as veri_code,count(*) as veri_result from DM_CUSTOMER
 where ( not exists(select 1 from T_COMPANY_TYPE  b where DM_CUSTOMER.INDUSTRY_ID=b.type_id) and INDUSTRY_ID is not null);
insert into dm_template_veri (module_name,table_name,column_name,veri_code,veri_result)
select '/home/guangjun/git/dctemplates/app/uploads/UAL_Mapping_Party_V0.2.9.xlsx' as module_name,'DM_CUSTOMER' as table_name,'RELIGION_CODE' as column_name,'VERI_STRING_LENGTH_OVER_DEF' as veri_code,count(*) as veri_result from DM_CUSTOMER
 where length(RELIGION_CODE)>3 and RELIGION_CODE is not null;
insert into dm_template_veri (module_name,table_name,column_name,veri_code,veri_result)
select '/home/guangjun/git/dctemplates/app/uploads/UAL_Mapping_Party_V0.2.9.xlsx' as module_name,'DM_CUSTOMER' as table_name,'RELIGION_CODE' as column_name,'VERI_FOREIGN_KEY_TEMPLATE' as veri_code,count(*) as veri_result from DM_CUSTOMER
 where ( not exists(select 1 from T_RELIGION  b where DM_CUSTOMER.RELIGION_CODE=b.religion_code) and RELIGION_CODE is not null);
insert into dm_template_veri (module_name,table_name,column_name,veri_code,veri_result)
select '/home/guangjun/git/dctemplates/app/uploads/UAL_Mapping_Party_V0.2.9.xlsx' as module_name,'DM_CUSTOMER' as table_name,'OFFICE_TEL_EXT' as column_name,'VERI_STRING_LENGTH_OVER_DEF' as veri_code,count(*) as veri_result from DM_CUSTOMER
 where length(OFFICE_TEL_EXT)>10 and OFFICE_TEL_EXT is not null;
insert into dm_template_veri (module_name,table_name,column_name,veri_code,veri_result)
select '/home/guangjun/git/dctemplates/app/uploads/UAL_Mapping_Party_V0.2.9.xlsx' as module_name,'DM_CUSTOMER' as table_name,'FAX' as column_name,'VERI_STRING_LENGTH_OVER_DEF' as veri_code,count(*) as veri_result from DM_CUSTOMER
 where length(FAX)>30 and FAX is not null;
insert into dm_template_veri (module_name,table_name,column_name,veri_code,veri_result)
select '/home/guangjun/git/dctemplates/app/uploads/UAL_Mapping_Party_V0.2.9.xlsx' as module_name,'DM_CUSTOMER' as table_name,'INSURED_STATUS' as column_name,'VERI_STRING_LENGTH_OVER_DEF' as veri_code,count(*) as veri_result from DM_CUSTOMER
 where length(INSURED_STATUS)>2 and INSURED_STATUS is not null;
insert into dm_template_veri (module_name,table_name,column_name,veri_code,veri_result)
select '/home/guangjun/git/dctemplates/app/uploads/UAL_Mapping_Party_V0.2.9.xlsx' as module_name,'DM_CUSTOMER' as table_name,'INSURED_STATUS' as column_name,'VERI_FOREIGN_KEY_TEMPLATE' as veri_code,count(*) as veri_result from DM_CUSTOMER
 where ( not exists(select 1 from T_INSURED_STATUS  b where DM_CUSTOMER.INSURED_STATUS=b.insured_status) and INSURED_STATUS is not null);
insert into dm_template_veri (module_name,table_name,column_name,veri_code,veri_result)
select '/home/guangjun/git/dctemplates/app/uploads/UAL_Mapping_Party_V0.2.9.xlsx' as module_name,'DM_CUSTOMER' as table_name,'CLAIM_INDI' as column_name,'VERI_STRING_LENGTH_OVER_DEF' as veri_code,count(*) as veri_result from DM_CUSTOMER
 where length(CLAIM_INDI)>1 and CLAIM_INDI is not null;
insert into dm_template_veri (module_name,table_name,column_name,veri_code,veri_result)
select '/home/guangjun/git/dctemplates/app/uploads/UAL_Mapping_Party_V0.2.9.xlsx' as module_name,'DM_CUSTOMER' as table_name,'CLAIM_INDI' as column_name,'VERI_FOREIGN_KEY_TEMPLATE' as veri_code,count(*) as veri_result from DM_CUSTOMER
 where ( not exists(select 1 from T_CLAIM_INDI  b where DM_CUSTOMER.CLAIM_INDI=b.indi_code) and CLAIM_INDI is not null);
insert into dm_template_veri (module_name,table_name,column_name,veri_code,veri_result)
select '/home/guangjun/git/dctemplates/app/uploads/UAL_Mapping_Party_V0.2.9.xlsx' as module_name,'DM_CUSTOMER' as table_name,'VIP_INDI' as column_name,'VERI_STRING_LENGTH_OVER_DEF' as veri_code,count(*) as veri_result from DM_CUSTOMER
 where length(VIP_INDI)>1 and VIP_INDI is not null;
insert into dm_template_veri (module_name,table_name,column_name,veri_code,veri_result)
select '/home/guangjun/git/dctemplates/app/uploads/UAL_Mapping_Party_V0.2.9.xlsx' as module_name,'DM_CUSTOMER' as table_name,'VIP_INDI' as column_name,'VERI_FOREIGN_KEY_TEMPLATE' as veri_code,count(*) as veri_result from DM_CUSTOMER
 where ( not exists(select 1 from T_YES_NO  b where DM_CUSTOMER.VIP_INDI=b.YES_NO) and VIP_INDI is not null);
insert into dm_template_veri (module_name,table_name,column_name,veri_code,veri_result)
select '/home/guangjun/git/dctemplates/app/uploads/UAL_Mapping_Party_V0.2.9.xlsx' as module_name,'DM_CUSTOMER' as table_name,'BANKRUPTCY_ORDER_NO' as column_name,'VERI_STRING_LENGTH_OVER_DEF' as veri_code,count(*) as veri_result from DM_CUSTOMER
 where length(BANKRUPTCY_ORDER_NO)>25 and BANKRUPTCY_ORDER_NO is not null;
insert into dm_template_veri (module_name,table_name,column_name,veri_code,veri_result)
select '/home/guangjun/git/dctemplates/app/uploads/UAL_Mapping_Party_V0.2.9.xlsx' as module_name,'DM_CUSTOMER' as table_name,'BANKRUPTCY_ORDER_DATE' as column_name,'VERI_DATE_ILLEGAL' as veri_code,count(*) as veri_result from DM_CUSTOMER
 where f_is_date(BANKRUPTCY_ORDER_DATE)=1 and BANKRUPTCY_ORDER_DATE is not null;
insert into dm_template_veri (module_name,table_name,column_name,veri_code,veri_result)
select '/home/guangjun/git/dctemplates/app/uploads/UAL_Mapping_Party_V0.2.9.xlsx' as module_name,'DM_CUSTOMER' as table_name,'BANKRUPTCY_STATUS' as column_name,'VERI_STRING_LENGTH_OVER_DEF' as veri_code,count(*) as veri_result from DM_CUSTOMER
 where length(BANKRUPTCY_STATUS)>1 and BANKRUPTCY_STATUS is not null;
insert into dm_template_veri (module_name,table_name,column_name,veri_code,veri_result)
select '/home/guangjun/git/dctemplates/app/uploads/UAL_Mapping_Party_V0.2.9.xlsx' as module_name,'DM_CUSTOMER' as table_name,'BANKRUPTCY_STATUS' as column_name,'VERI_FOREIGN_KEY_TEMPLATE' as veri_code,count(*) as veri_result from DM_CUSTOMER
 where ( not exists(select 1 from T_YES_NO  b where DM_CUSTOMER.BANKRUPTCY_STATUS=b.YES_NO) and BANKRUPTCY_STATUS is not null);
insert into dm_template_veri (module_name,table_name,column_name,veri_code,veri_result)
select '/home/guangjun/git/dctemplates/app/uploads/UAL_Mapping_Party_V0.2.9.xlsx' as module_name,'DM_CUSTOMER' as table_name,'DISCHARGE_DATE' as column_name,'VERI_DATE_ILLEGAL' as veri_code,count(*) as veri_result from DM_CUSTOMER
 where f_is_date(DISCHARGE_DATE)=1 and DISCHARGE_DATE is not null;
insert into dm_template_veri (module_name,table_name,column_name,veri_code,veri_result)
select '/home/guangjun/git/dctemplates/app/uploads/UAL_Mapping_Party_V0.2.9.xlsx' as module_name,'DM_CUSTOMER' as table_name,'PROOF_AGE' as column_name,'VERI_STRING_LENGTH_OVER_DEF' as veri_code,count(*) as veri_result from DM_CUSTOMER
 where length(PROOF_AGE)>1 and PROOF_AGE is not null;
insert into dm_template_veri (module_name,table_name,column_name,veri_code,veri_result)
select '/home/guangjun/git/dctemplates/app/uploads/UAL_Mapping_Party_V0.2.9.xlsx' as module_name,'DM_CUSTOMER' as table_name,'CHILD_COUNT' as column_name,'VERI_NUMBER_ILLEGAL' as veri_code,count(*) as veri_result from DM_CUSTOMER
 where f_is_number(CHILD_COUNT)=1 and CHILD_COUNT is not null;
insert into dm_template_veri (module_name,table_name,column_name,veri_code,veri_result)
select '/home/guangjun/git/dctemplates/app/uploads/UAL_Mapping_Party_V0.2.9.xlsx' as module_name,'DM_CUSTOMER' as table_name,'BLACKLIST_CODE' as column_name,'VERI_STRING_LENGTH_OVER_DEF' as veri_code,count(*) as veri_result from DM_CUSTOMER
 where length(BLACKLIST_CODE)>10 and BLACKLIST_CODE is not null;
insert into dm_template_veri (module_name,table_name,column_name,veri_code,veri_result)
select '/home/guangjun/git/dctemplates/app/uploads/UAL_Mapping_Party_V0.2.9.xlsx' as module_name,'DM_CUSTOMER' as table_name,'BLACKLIST_CODE' as column_name,'VERI_FOREIGN_KEY_TEMPLATE' as veri_code,count(*) as veri_result from DM_CUSTOMER
 where ( not exists(select 1 from T_BLACKLIST_CODE  b where DM_CUSTOMER.BLACKLIST_CODE=b.blacklist_code) and BLACKLIST_CODE is not null);
insert into dm_template_veri (module_name,table_name,column_name,veri_code,veri_result)
select '/home/guangjun/git/dctemplates/app/uploads/UAL_Mapping_Party_V0.2.9.xlsx' as module_name,'DM_CUSTOMER' as table_name,'ORIGIN_CUST_ID' as column_name,'VERI_STRING_LENGTH_OVER_DEF' as veri_code,count(*) as veri_result from DM_CUSTOMER
 where length(ORIGIN_CUST_ID)>20 and ORIGIN_CUST_ID is not null;
insert into dm_template_veri (module_name,table_name,column_name,veri_code,veri_result)
select '/home/guangjun/git/dctemplates/app/uploads/UAL_Mapping_Party_V0.2.9.xlsx' as module_name,'DM_CUSTOMER' as table_name,'INSERT_TIME' as column_name,'VERI_DATE_ILLEGAL' as veri_code,count(*) as veri_result from DM_CUSTOMER
 where f_is_date(INSERT_TIME)=1 and INSERT_TIME is not null;
insert into dm_template_veri (module_name,table_name,column_name,veri_code,veri_result)
select '/home/guangjun/git/dctemplates/app/uploads/UAL_Mapping_Party_V0.2.9.xlsx' as module_name,'DM_CUSTOMER' as table_name,'UPDATE_TIME' as column_name,'VERI_DATE_ILLEGAL' as veri_code,count(*) as veri_result from DM_CUSTOMER
 where f_is_date(UPDATE_TIME)=1 and UPDATE_TIME is not null;
insert into dm_template_veri (module_name,table_name,column_name,veri_code,veri_result)
select '/home/guangjun/git/dctemplates/app/uploads/UAL_Mapping_Party_V0.2.9.xlsx' as module_name,'DM_AGENT' as table_name,'AGENT_ID' as column_name,'VERI_NUMBER_ILLEGAL' as veri_code,count(*) as veri_result from DM_AGENT
 where f_is_number(AGENT_ID)=1 and AGENT_ID is not null;
insert into dm_template_veri (module_name,table_name,column_name,veri_code,veri_result)
select '/home/guangjun/git/dctemplates/app/uploads/UAL_Mapping_Party_V0.2.9.xlsx' as module_name,'DM_AGENT' as table_name,'AGENT_ID' as column_name,'VERI_NON_NULLABLE' as veri_code,count(*) as veri_result from DM_AGENT
 where AGENT_ID is  null;
insert into dm_template_veri (module_name,table_name,column_name,veri_code,veri_result)
select '/home/guangjun/git/dctemplates/app/uploads/UAL_Mapping_Party_V0.2.9.xlsx' as module_name,'DM_AGENT' as table_name,'AGENT_ID' as column_name,'VERI_PRIMARY_KEY' as veri_code,count(*) as veri_result from DM_AGENT
 where (select count(*) from DM_AGENT  b where DM_AGENT.AGENT_ID=b.AGENT_ID)>1;
insert into dm_template_veri (module_name,table_name,column_name,veri_code,veri_result)
select '/home/guangjun/git/dctemplates/app/uploads/UAL_Mapping_Party_V0.2.9.xlsx' as module_name,'DM_AGENT' as table_name,'AGENT_CODE' as column_name,'VERI_STRING_LENGTH_OVER_DEF' as veri_code,count(*) as veri_result from DM_AGENT
 where length(AGENT_CODE)>20 and AGENT_CODE is not null;
insert into dm_template_veri (module_name,table_name,column_name,veri_code,veri_result)
select '/home/guangjun/git/dctemplates/app/uploads/UAL_Mapping_Party_V0.2.9.xlsx' as module_name,'DM_AGENT' as table_name,'AGENT_CODE' as column_name,'VERI_NON_NULLABLE' as veri_code,count(*) as veri_result from DM_AGENT
 where AGENT_CODE is  null;
insert into dm_template_veri (module_name,table_name,column_name,veri_code,veri_result)
select '/home/guangjun/git/dctemplates/app/uploads/UAL_Mapping_Party_V0.2.9.xlsx' as module_name,'DM_AGENT' as table_name,'ORGAN_ID' as column_name,'VERI_NUMBER_ILLEGAL' as veri_code,count(*) as veri_result from DM_AGENT
 where f_is_number(ORGAN_ID)=1 and ORGAN_ID is not null;
insert into dm_template_veri (module_name,table_name,column_name,veri_code,veri_result)
select '/home/guangjun/git/dctemplates/app/uploads/UAL_Mapping_Party_V0.2.9.xlsx' as module_name,'DM_AGENT' as table_name,'ORGAN_ID' as column_name,'VERI_FOREIGN_KEY_TEMPLATE' as veri_code,count(*) as veri_result from DM_AGENT
 where ( not exists(select 1 from T_COMPANY_ORGAN  b where DM_AGENT.ORGAN_ID=b.organ_id) and ORGAN_ID is not null);
insert into dm_template_veri (module_name,table_name,column_name,veri_code,veri_result)
select '/home/guangjun/git/dctemplates/app/uploads/UAL_Mapping_Party_V0.2.9.xlsx' as module_name,'DM_AGENT' as table_name,'AGENT_STATUS' as column_name,'VERI_NUMBER_ILLEGAL' as veri_code,count(*) as veri_result from DM_AGENT
 where f_is_number(AGENT_STATUS)=1 and AGENT_STATUS is not null;
insert into dm_template_veri (module_name,table_name,column_name,veri_code,veri_result)
select '/home/guangjun/git/dctemplates/app/uploads/UAL_Mapping_Party_V0.2.9.xlsx' as module_name,'DM_AGENT' as table_name,'AGENT_STATUS' as column_name,'VERI_NON_NULLABLE' as veri_code,count(*) as veri_result from DM_AGENT
 where AGENT_STATUS is  null;
insert into dm_template_veri (module_name,table_name,column_name,veri_code,veri_result)
select '/home/guangjun/git/dctemplates/app/uploads/UAL_Mapping_Party_V0.2.9.xlsx' as module_name,'DM_AGENT' as table_name,'AGENT_STATUS' as column_name,'VERI_FOREIGN_KEY_TEMPLATE' as veri_code,count(*) as veri_result from DM_AGENT
 where ( not exists(select 1 from T_AGENT_STATUS  b where DM_AGENT.AGENT_STATUS=b.agent_status) and AGENT_STATUS is not null);
insert into dm_template_veri (module_name,table_name,column_name,veri_code,veri_result)
select '/home/guangjun/git/dctemplates/app/uploads/UAL_Mapping_Party_V0.2.9.xlsx' as module_name,'DM_AGENT' as table_name,'COMM_ACCOUNT_ID' as column_name,'VERI_NUMBER_ILLEGAL' as veri_code,count(*) as veri_result from DM_AGENT
 where f_is_number(COMM_ACCOUNT_ID)=1 and COMM_ACCOUNT_ID is not null;
insert into dm_template_veri (module_name,table_name,column_name,veri_code,veri_result)
select '/home/guangjun/git/dctemplates/app/uploads/UAL_Mapping_Party_V0.2.9.xlsx' as module_name,'DM_AGENT' as table_name,'COMM_ACCOUNT_ID' as column_name,'VERI_FOREIGN_KEY_TEMPLATE' as veri_code,count(*) as veri_result from DM_AGENT
 where ( not exists(select 1 from T_BANK_ACCOUNT  b where DM_AGENT.COMM_ACCOUNT_ID=b.ACCOUNT_ID) and COMM_ACCOUNT_ID is not null);
insert into dm_template_veri (module_name,table_name,column_name,veri_code,veri_result)
select '/home/guangjun/git/dctemplates/app/uploads/UAL_Mapping_Party_V0.2.9.xlsx' as module_name,'DM_AGENT' as table_name,'AGENT_CATE' as column_name,'VERI_STRING_LENGTH_OVER_DEF' as veri_code,count(*) as veri_result from DM_AGENT
 where length(AGENT_CATE)>1 and AGENT_CATE is not null;
insert into dm_template_veri (module_name,table_name,column_name,veri_code,veri_result)
select '/home/guangjun/git/dctemplates/app/uploads/UAL_Mapping_Party_V0.2.9.xlsx' as module_name,'DM_AGENT' as table_name,'AGENT_CATE' as column_name,'VERI_NON_NULLABLE' as veri_code,count(*) as veri_result from DM_AGENT
 where AGENT_CATE is  null;
insert into dm_template_veri (module_name,table_name,column_name,veri_code,veri_result)
select '/home/guangjun/git/dctemplates/app/uploads/UAL_Mapping_Party_V0.2.9.xlsx' as module_name,'DM_AGENT' as table_name,'AGENT_CATE' as column_name,'VERI_FOREIGN_KEY_TEMPLATE' as veri_code,count(*) as veri_result from DM_AGENT
 where ( not exists(select 1 from T_AGENT_CATE  b where DM_AGENT.AGENT_CATE=b.agent_cate) and AGENT_CATE is not null);
insert into dm_template_veri (module_name,table_name,column_name,veri_code,veri_result)
select '/home/guangjun/git/dctemplates/app/uploads/UAL_Mapping_Party_V0.2.9.xlsx' as module_name,'DM_AGENT' as table_name,'STATUS_REASON' as column_name,'VERI_STRING_LENGTH_OVER_DEF' as veri_code,count(*) as veri_result from DM_AGENT
 where length(STATUS_REASON)>20 and STATUS_REASON is not null;
insert into dm_template_veri (module_name,table_name,column_name,veri_code,veri_result)
select '/home/guangjun/git/dctemplates/app/uploads/UAL_Mapping_Party_V0.2.9.xlsx' as module_name,'DM_AGENT' as table_name,'STATUS_REASON' as column_name,'VERI_FOREIGN_KEY_TEMPLATE' as veri_code,count(*) as veri_result from DM_AGENT
 where ( not exists(select 1 from T_LEAVE_CAUSE  b where DM_AGENT.STATUS_REASON=b.leave_cause) and STATUS_REASON is not null);
insert into dm_template_veri (module_name,table_name,column_name,veri_code,veri_result)
select '/home/guangjun/git/dctemplates/app/uploads/UAL_Mapping_Party_V0.2.9.xlsx' as module_name,'DM_AGENT' as table_name,'APPOINMENT_DATE' as column_name,'VERI_DATE_ILLEGAL' as veri_code,count(*) as veri_result from DM_AGENT
 where f_is_date(APPOINMENT_DATE)=1 and APPOINMENT_DATE is not null;
insert into dm_template_veri (module_name,table_name,column_name,veri_code,veri_result)
select '/home/guangjun/git/dctemplates/app/uploads/UAL_Mapping_Party_V0.2.9.xlsx' as module_name,'DM_AGENT' as table_name,'AGENT_GRADE' as column_name,'VERI_STRING_LENGTH_OVER_DEF' as veri_code,count(*) as veri_result from DM_AGENT
 where length(AGENT_GRADE)>2 and AGENT_GRADE is not null;
insert into dm_template_veri (module_name,table_name,column_name,veri_code,veri_result)
select '/home/guangjun/git/dctemplates/app/uploads/UAL_Mapping_Party_V0.2.9.xlsx' as module_name,'DM_AGENT' as table_name,'AGENT_GRADE' as column_name,'VERI_FOREIGN_KEY_TEMPLATE' as veri_code,count(*) as veri_result from DM_AGENT
 where ( not exists(select 1 from T_AGENT_GRADE  b where DM_AGENT.AGENT_GRADE=b.agent_grade) and AGENT_GRADE is not null);
insert into dm_template_veri (module_name,table_name,column_name,veri_code,veri_result)
select '/home/guangjun/git/dctemplates/app/uploads/UAL_Mapping_Party_V0.2.9.xlsx' as module_name,'DM_AGENT' as table_name,'ENTER_COMPANY_DATE' as column_name,'VERI_DATE_ILLEGAL' as veri_code,count(*) as veri_result from DM_AGENT
 where f_is_date(ENTER_COMPANY_DATE)=1 and ENTER_COMPANY_DATE is not null;
insert into dm_template_veri (module_name,table_name,column_name,veri_code,veri_result)
select '/home/guangjun/git/dctemplates/app/uploads/UAL_Mapping_Party_V0.2.9.xlsx' as module_name,'DM_AGENT' as table_name,'LEAVE_COMPANY_DATE' as column_name,'VERI_DATE_ILLEGAL' as veri_code,count(*) as veri_result from DM_AGENT
 where f_is_date(LEAVE_COMPANY_DATE)=1 and LEAVE_COMPANY_DATE is not null;
insert into dm_template_veri (module_name,table_name,column_name,veri_code,veri_result)
select '/home/guangjun/git/dctemplates/app/uploads/UAL_Mapping_Party_V0.2.9.xlsx' as module_name,'DM_AGENT' as table_name,'RECOMMENDER_ID' as column_name,'VERI_NUMBER_ILLEGAL' as veri_code,count(*) as veri_result from DM_AGENT
 where f_is_number(RECOMMENDER_ID)=1 and RECOMMENDER_ID is not null;
insert into dm_template_veri (module_name,table_name,column_name,veri_code,veri_result)
select '/home/guangjun/git/dctemplates/app/uploads/UAL_Mapping_Party_V0.2.9.xlsx' as module_name,'DM_AGENT' as table_name,'RECOMMENDER_ID' as column_name,'VERI_FOREIGN_KEY_TEMPLATE' as veri_code,count(*) as veri_result from DM_AGENT
 where ( not exists(select 1 from DM_AGENT  b where DM_AGENT.RECOMMENDER_ID=b.AGENT_ID) and RECOMMENDER_ID is not null);
insert into dm_template_veri (module_name,table_name,column_name,veri_code,veri_result)
select '/home/guangjun/git/dctemplates/app/uploads/UAL_Mapping_Party_V0.2.9.xlsx' as module_name,'DM_AGENT' as table_name,'TRAINER_ID' as column_name,'VERI_NUMBER_ILLEGAL' as veri_code,count(*) as veri_result from DM_AGENT
 where f_is_number(TRAINER_ID)=1 and TRAINER_ID is not null;
insert into dm_template_veri (module_name,table_name,column_name,veri_code,veri_result)
select '/home/guangjun/git/dctemplates/app/uploads/UAL_Mapping_Party_V0.2.9.xlsx' as module_name,'DM_AGENT' as table_name,'TRAINER_ID' as column_name,'VERI_FOREIGN_KEY_TEMPLATE' as veri_code,count(*) as veri_result from DM_AGENT
 where ( not exists(select 1 from DM_AGENT  b where DM_AGENT.TRAINER_ID=b.AGENT_ID) and TRAINER_ID is not null);
insert into dm_template_veri (module_name,table_name,column_name,veri_code,veri_result)
select '/home/guangjun/git/dctemplates/app/uploads/UAL_Mapping_Party_V0.2.9.xlsx' as module_name,'DM_AGENT' as table_name,'SCHOOL' as column_name,'VERI_STRING_LENGTH_OVER_DEF' as veri_code,count(*) as veri_result from DM_AGENT
 where length(SCHOOL)>50 and SCHOOL is not null;
insert into dm_template_veri (module_name,table_name,column_name,veri_code,veri_result)
select '/home/guangjun/git/dctemplates/app/uploads/UAL_Mapping_Party_V0.2.9.xlsx' as module_name,'DM_AGENT' as table_name,'MAJOR' as column_name,'VERI_STRING_LENGTH_OVER_DEF' as veri_code,count(*) as veri_result from DM_AGENT
 where length(MAJOR)>50 and MAJOR is not null;
insert into dm_template_veri (module_name,table_name,column_name,veri_code,veri_result)
select '/home/guangjun/git/dctemplates/app/uploads/UAL_Mapping_Party_V0.2.9.xlsx' as module_name,'DM_AGENT' as table_name,'DEGREE_ID' as column_name,'VERI_STRING_LENGTH_OVER_DEF' as veri_code,count(*) as veri_result from DM_AGENT
 where length(DEGREE_ID)>2 and DEGREE_ID is not null;
insert into dm_template_veri (module_name,table_name,column_name,veri_code,veri_result)
select '/home/guangjun/git/dctemplates/app/uploads/UAL_Mapping_Party_V0.2.9.xlsx' as module_name,'DM_AGENT' as table_name,'DEGREE_ID' as column_name,'VERI_FOREIGN_KEY_TEMPLATE' as veri_code,count(*) as veri_result from DM_AGENT
 where ( not exists(select 1 from T_DEGREE  b where DM_AGENT.DEGREE_ID=b.degree_id) and DEGREE_ID is not null);
insert into dm_template_veri (module_name,table_name,column_name,veri_code,veri_result)
select '/home/guangjun/git/dctemplates/app/uploads/UAL_Mapping_Party_V0.2.9.xlsx' as module_name,'DM_AGENT' as table_name,'BEGIN_JOB_DATE' as column_name,'VERI_DATE_ILLEGAL' as veri_code,count(*) as veri_result from DM_AGENT
 where f_is_date(BEGIN_JOB_DATE)=1 and BEGIN_JOB_DATE is not null;
insert into dm_template_veri (module_name,table_name,column_name,veri_code,veri_result)
select '/home/guangjun/git/dctemplates/app/uploads/UAL_Mapping_Party_V0.2.9.xlsx' as module_name,'DM_AGENT' as table_name,'HOLDBACK_INDI' as column_name,'VERI_STRING_LENGTH_OVER_DEF' as veri_code,count(*) as veri_result from DM_AGENT
 where length(HOLDBACK_INDI)>1 and HOLDBACK_INDI is not null;
insert into dm_template_veri (module_name,table_name,column_name,veri_code,veri_result)
select '/home/guangjun/git/dctemplates/app/uploads/UAL_Mapping_Party_V0.2.9.xlsx' as module_name,'DM_AGENT' as table_name,'HOLDBACK_PERIOD' as column_name,'VERI_NUMBER_ILLEGAL' as veri_code,count(*) as veri_result from DM_AGENT
 where f_is_number(HOLDBACK_PERIOD)=1 and HOLDBACK_PERIOD is not null;
insert into dm_template_veri (module_name,table_name,column_name,veri_code,veri_result)
select '/home/guangjun/git/dctemplates/app/uploads/UAL_Mapping_Party_V0.2.9.xlsx' as module_name,'DM_AGENT' as table_name,'HOLDBACK_RATE' as column_name,'VERI_NUMBER_ILLEGAL' as veri_code,count(*) as veri_result from DM_AGENT
 where f_is_number(HOLDBACK_RATE)=1 and HOLDBACK_RATE is not null;
insert into dm_template_veri (module_name,table_name,column_name,veri_code,veri_result)
select '/home/guangjun/git/dctemplates/app/uploads/UAL_Mapping_Party_V0.2.9.xlsx' as module_name,'DM_AGENT' as table_name,'PAYMENT_MODE' as column_name,'VERI_STRING_LENGTH_OVER_DEF' as veri_code,count(*) as veri_result from DM_AGENT
 where length(PAYMENT_MODE)>1 and PAYMENT_MODE is not null;
insert into dm_template_veri (module_name,table_name,column_name,veri_code,veri_result)
select '/home/guangjun/git/dctemplates/app/uploads/UAL_Mapping_Party_V0.2.9.xlsx' as module_name,'DM_AGENT' as table_name,'PAYMENT_MODE' as column_name,'VERI_FOREIGN_KEY_TEMPLATE' as veri_code,count(*) as veri_result from DM_AGENT
 where ( not exists(select 1 from T_CHARGE_MODE  b where DM_AGENT.PAYMENT_MODE=b.charge_type) and PAYMENT_MODE is not null);
insert into dm_template_veri (module_name,table_name,column_name,veri_code,veri_result)
select '/home/guangjun/git/dctemplates/app/uploads/UAL_Mapping_Party_V0.2.9.xlsx' as module_name,'DM_AGENT' as table_name,'CHANNEL_ORG_ID' as column_name,'VERI_NUMBER_ILLEGAL' as veri_code,count(*) as veri_result from DM_AGENT
 where f_is_number(CHANNEL_ORG_ID)=1 and CHANNEL_ORG_ID is not null;
insert into dm_template_veri (module_name,table_name,column_name,veri_code,veri_result)
select '/home/guangjun/git/dctemplates/app/uploads/UAL_Mapping_Party_V0.2.9.xlsx' as module_name,'DM_AGENT' as table_name,'CHANNEL_ORG_ID' as column_name,'VERI_FOREIGN_KEY_TEMPLATE' as veri_code,count(*) as veri_result from DM_AGENT
 where ( not exists(select 1 from T_CHANNEL_ORG  b where DM_AGENT.CHANNEL_ORG_ID=b.channel_id) and CHANNEL_ORG_ID is not null);
insert into dm_template_veri (module_name,table_name,column_name,veri_code,veri_result)
select '/home/guangjun/git/dctemplates/app/uploads/UAL_Mapping_Party_V0.2.9.xlsx' as module_name,'DM_AGENT' as table_name,'PHYSICAL_LOCATION' as column_name,'VERI_NUMBER_ILLEGAL' as veri_code,count(*) as veri_result from DM_AGENT
 where f_is_number(PHYSICAL_LOCATION)=1 and PHYSICAL_LOCATION is not null;
insert into dm_template_veri (module_name,table_name,column_name,veri_code,veri_result)
select '/home/guangjun/git/dctemplates/app/uploads/UAL_Mapping_Party_V0.2.9.xlsx' as module_name,'DM_AGENT' as table_name,'PHYSICAL_LOCATION' as column_name,'VERI_FOREIGN_KEY_TEMPLATE' as veri_code,count(*) as veri_result from DM_AGENT
 where ( not exists(select 1 from T_PHYSICAL_LOCATION  b where DM_AGENT.PHYSICAL_LOCATION=b.location_id) and PHYSICAL_LOCATION is not null);
insert into dm_template_veri (module_name,table_name,column_name,veri_code,veri_result)
select '/home/guangjun/git/dctemplates/app/uploads/UAL_Mapping_Party_V0.2.9.xlsx' as module_name,'DM_AGENT' as table_name,'OTHER_INCOME_INDI' as column_name,'VERI_STRING_LENGTH_OVER_DEF' as veri_code,count(*) as veri_result from DM_AGENT
 where length(OTHER_INCOME_INDI)>1 and OTHER_INCOME_INDI is not null;
insert into dm_template_veri (module_name,table_name,column_name,veri_code,veri_result)
select '/home/guangjun/git/dctemplates/app/uploads/UAL_Mapping_Party_V0.2.9.xlsx' as module_name,'DM_AGENT' as table_name,'OTHER_INCOME_INDI' as column_name,'VERI_FOREIGN_KEY_TEMPLATE' as veri_code,count(*) as veri_result from DM_AGENT
 where ( not exists(select 1 from T_YES_NO  b where DM_AGENT.OTHER_INCOME_INDI=b.YES_NO) and OTHER_INCOME_INDI is not null);
insert into dm_template_veri (module_name,table_name,column_name,veri_code,veri_result)
select '/home/guangjun/git/dctemplates/app/uploads/UAL_Mapping_Party_V0.2.9.xlsx' as module_name,'DM_AGENT' as table_name,'JOB_NATURE_ID' as column_name,'VERI_STRING_LENGTH_OVER_DEF' as veri_code,count(*) as veri_result from DM_AGENT
 where length(JOB_NATURE_ID)>2 and JOB_NATURE_ID is not null;
insert into dm_template_veri (module_name,table_name,column_name,veri_code,veri_result)
select '/home/guangjun/git/dctemplates/app/uploads/UAL_Mapping_Party_V0.2.9.xlsx' as module_name,'DM_AGENT' as table_name,'JOB_NATURE_ID' as column_name,'VERI_FOREIGN_KEY_TEMPLATE' as veri_code,count(*) as veri_result from DM_AGENT
 where ( not exists(select 1 from T_JOB_NATURE  b where DM_AGENT.JOB_NATURE_ID=b.job_nature_id) and JOB_NATURE_ID is not null);
insert into dm_template_veri (module_name,table_name,column_name,veri_code,veri_result)
select '/home/guangjun/git/dctemplates/app/uploads/UAL_Mapping_Party_V0.2.9.xlsx' as module_name,'DM_AGENT' as table_name,'OLD_JOB_ID' as column_name,'VERI_STRING_LENGTH_OVER_DEF' as veri_code,count(*) as veri_result from DM_AGENT
 where length(OLD_JOB_ID)>20 and OLD_JOB_ID is not null;
insert into dm_template_veri (module_name,table_name,column_name,veri_code,veri_result)
select '/home/guangjun/git/dctemplates/app/uploads/UAL_Mapping_Party_V0.2.9.xlsx' as module_name,'DM_AGENT' as table_name,'LICENSE_TYPE_ID' as column_name,'VERI_NUMBER_ILLEGAL' as veri_code,count(*) as veri_result from DM_AGENT
 where f_is_number(LICENSE_TYPE_ID)=1 and LICENSE_TYPE_ID is not null;
insert into dm_template_veri (module_name,table_name,column_name,veri_code,veri_result)
select '/home/guangjun/git/dctemplates/app/uploads/UAL_Mapping_Party_V0.2.9.xlsx' as module_name,'DM_AGENT' as table_name,'LICENSE_TYPE_ID' as column_name,'VERI_NON_NULLABLE' as veri_code,count(*) as veri_result from DM_AGENT
 where LICENSE_TYPE_ID is  null;
insert into dm_template_veri (module_name,table_name,column_name,veri_code,veri_result)
select '/home/guangjun/git/dctemplates/app/uploads/UAL_Mapping_Party_V0.2.9.xlsx' as module_name,'DM_AGENT' as table_name,'LICENSE_TYPE_ID' as column_name,'VERI_FOREIGN_KEY_TEMPLATE' as veri_code,count(*) as veri_result from DM_AGENT
 where ( not exists(select 1 from T_TEST_TYPE  b where DM_AGENT.LICENSE_TYPE_ID=b.test_type_id) and LICENSE_TYPE_ID is not null);
insert into dm_template_veri (module_name,table_name,column_name,veri_code,veri_result)
select '/home/guangjun/git/dctemplates/app/uploads/UAL_Mapping_Party_V0.2.9.xlsx' as module_name,'DM_AGENT' as table_name,'LICENSE_EFF_DATE' as column_name,'VERI_DATE_ILLEGAL' as veri_code,count(*) as veri_result from DM_AGENT
 where f_is_date(LICENSE_EFF_DATE)=1 and LICENSE_EFF_DATE is not null;
insert into dm_template_veri (module_name,table_name,column_name,veri_code,veri_result)
select '/home/guangjun/git/dctemplates/app/uploads/UAL_Mapping_Party_V0.2.9.xlsx' as module_name,'DM_AGENT' as table_name,'LICENSE_EFF_DATE' as column_name,'VERI_NON_NULLABLE' as veri_code,count(*) as veri_result from DM_AGENT
 where LICENSE_EFF_DATE is  null;
insert into dm_template_veri (module_name,table_name,column_name,veri_code,veri_result)
select '/home/guangjun/git/dctemplates/app/uploads/UAL_Mapping_Party_V0.2.9.xlsx' as module_name,'DM_AGENT' as table_name,'EXPIRE_DATE' as column_name,'VERI_DATE_ILLEGAL' as veri_code,count(*) as veri_result from DM_AGENT
 where f_is_date(EXPIRE_DATE)=1 and EXPIRE_DATE is not null;
insert into dm_template_veri (module_name,table_name,column_name,veri_code,veri_result)
select '/home/guangjun/git/dctemplates/app/uploads/UAL_Mapping_Party_V0.2.9.xlsx' as module_name,'DM_AGENT' as table_name,'POSITION_DATE' as column_name,'VERI_DATE_ILLEGAL' as veri_code,count(*) as veri_result from DM_AGENT
 where f_is_date(POSITION_DATE)=1 and POSITION_DATE is not null;
insert into dm_template_veri (module_name,table_name,column_name,veri_code,veri_result)
select '/home/guangjun/git/dctemplates/app/uploads/UAL_Mapping_Party_V0.2.9.xlsx' as module_name,'DM_AGENT' as table_name,'QUALIFICATION_CERTI_CODE' as column_name,'VERI_STRING_LENGTH_OVER_DEF' as veri_code,count(*) as veri_result from DM_AGENT
 where length(QUALIFICATION_CERTI_CODE)>50 and QUALIFICATION_CERTI_CODE is not null;
insert into dm_template_veri (module_name,table_name,column_name,veri_code,veri_result)
select '/home/guangjun/git/dctemplates/app/uploads/UAL_Mapping_Party_V0.2.9.xlsx' as module_name,'DM_PARTY_ADDR' as table_name,'PARTY_ADDR_ID' as column_name,'VERI_NUMBER_ILLEGAL' as veri_code,count(*) as veri_result from DM_PARTY_ADDR
 where f_is_number(PARTY_ADDR_ID)=1 and PARTY_ADDR_ID is not null;
insert into dm_template_veri (module_name,table_name,column_name,veri_code,veri_result)
select '/home/guangjun/git/dctemplates/app/uploads/UAL_Mapping_Party_V0.2.9.xlsx' as module_name,'DM_PARTY_ADDR' as table_name,'PARTY_ADDR_ID' as column_name,'VERI_NON_NULLABLE' as veri_code,count(*) as veri_result from DM_PARTY_ADDR
 where PARTY_ADDR_ID is  null;
insert into dm_template_veri (module_name,table_name,column_name,veri_code,veri_result)
select '/home/guangjun/git/dctemplates/app/uploads/UAL_Mapping_Party_V0.2.9.xlsx' as module_name,'DM_PARTY_ADDR' as table_name,'PARTY_ADDR_ID' as column_name,'VERI_PRIMARY_KEY' as veri_code,count(*) as veri_result from DM_PARTY_ADDR
 where (select count(*) from DM_PARTY_ADDR  b where DM_PARTY_ADDR.PARTY_ADDR_ID=b.PARTY_ADDR_ID)>1;
insert into dm_template_veri (module_name,table_name,column_name,veri_code,veri_result)
select '/home/guangjun/git/dctemplates/app/uploads/UAL_Mapping_Party_V0.2.9.xlsx' as module_name,'DM_PARTY_ADDR' as table_name,'PARTY_ID' as column_name,'VERI_NUMBER_ILLEGAL' as veri_code,count(*) as veri_result from DM_PARTY_ADDR
 where f_is_number(PARTY_ID)=1 and PARTY_ID is not null;
insert into dm_template_veri (module_name,table_name,column_name,veri_code,veri_result)
select '/home/guangjun/git/dctemplates/app/uploads/UAL_Mapping_Party_V0.2.9.xlsx' as module_name,'DM_PARTY_ADDR' as table_name,'PARTY_ID' as column_name,'VERI_NON_NULLABLE' as veri_code,count(*) as veri_result from DM_PARTY_ADDR
 where PARTY_ID is  null;
insert into dm_template_veri (module_name,table_name,column_name,veri_code,veri_result)
select '/home/guangjun/git/dctemplates/app/uploads/UAL_Mapping_Party_V0.2.9.xlsx' as module_name,'DM_PARTY_ADDR' as table_name,'PARTY_ID' as column_name,'VERI_FOREIGN_KEY_TEMPLATE' as veri_code,count(*) as veri_result from DM_PARTY_ADDR
 where ( not exists(select 1 from DM_PARTY  b where DM_PARTY_ADDR.PARTY_ID=b.PARTY_ID) and PARTY_ID is not null);
insert into dm_template_veri (module_name,table_name,column_name,veri_code,veri_result)
select '/home/guangjun/git/dctemplates/app/uploads/UAL_Mapping_Party_V0.2.9.xlsx' as module_name,'DM_PARTY_ADDR' as table_name,'ADDRESS_ID' as column_name,'VERI_NUMBER_ILLEGAL' as veri_code,count(*) as veri_result from DM_PARTY_ADDR
 where f_is_number(ADDRESS_ID)=1 and ADDRESS_ID is not null;
insert into dm_template_veri (module_name,table_name,column_name,veri_code,veri_result)
select '/home/guangjun/git/dctemplates/app/uploads/UAL_Mapping_Party_V0.2.9.xlsx' as module_name,'DM_PARTY_ADDR' as table_name,'ADDRESS_ID' as column_name,'VERI_NON_NULLABLE' as veri_code,count(*) as veri_result from DM_PARTY_ADDR
 where ADDRESS_ID is  null;
insert into dm_template_veri (module_name,table_name,column_name,veri_code,veri_result)
select '/home/guangjun/git/dctemplates/app/uploads/UAL_Mapping_Party_V0.2.9.xlsx' as module_name,'DM_PARTY_ADDR' as table_name,'ADDRESS_ID' as column_name,'VERI_FOREIGN_KEY_TEMPLATE' as veri_code,count(*) as veri_result from DM_PARTY_ADDR
 where ( not exists(select 1 from DM_ADDRESS  b where DM_PARTY_ADDR.ADDRESS_ID=b.ADDRESS_ID) and ADDRESS_ID is not null);
insert into dm_template_veri (module_name,table_name,column_name,veri_code,veri_result)
select '/home/guangjun/git/dctemplates/app/uploads/UAL_Mapping_Party_V0.2.9.xlsx' as module_name,'DM_PARTY_ADDR' as table_name,'ADDRESS_TYPE' as column_name,'VERI_STRING_LENGTH_OVER_DEF' as veri_code,count(*) as veri_result from DM_PARTY_ADDR
 where length(ADDRESS_TYPE)>1 and ADDRESS_TYPE is not null;
insert into dm_template_veri (module_name,table_name,column_name,veri_code,veri_result)
select '/home/guangjun/git/dctemplates/app/uploads/UAL_Mapping_Party_V0.2.9.xlsx' as module_name,'DM_PARTY_ADDR' as table_name,'ADDRESS_TYPE' as column_name,'VERI_NON_NULLABLE' as veri_code,count(*) as veri_result from DM_PARTY_ADDR
 where ADDRESS_TYPE is  null;
insert into dm_template_veri (module_name,table_name,column_name,veri_code,veri_result)
select '/home/guangjun/git/dctemplates/app/uploads/UAL_Mapping_Party_V0.2.9.xlsx' as module_name,'DM_PARTY_ADDR' as table_name,'ADDRESS_TYPE' as column_name,'VERI_FOREIGN_KEY_TEMPLATE' as veri_code,count(*) as veri_result from DM_PARTY_ADDR
 where ( not exists(select 1 from T_ADDRESS_TYPE  b where DM_PARTY_ADDR.ADDRESS_TYPE=b.ADDRESS_TYPE) and ADDRESS_TYPE is not null);
insert into dm_template_veri (module_name,table_name,column_name,veri_code,veri_result)
select '/home/guangjun/git/dctemplates/app/uploads/UAL_Mapping_Party_V0.2.9.xlsx' as module_name,'DM_ADDRESS' as table_name,'ADDRESS_ID' as column_name,'VERI_NUMBER_ILLEGAL' as veri_code,count(*) as veri_result from DM_ADDRESS
 where f_is_number(ADDRESS_ID)=1 and ADDRESS_ID is not null;
insert into dm_template_veri (module_name,table_name,column_name,veri_code,veri_result)
select '/home/guangjun/git/dctemplates/app/uploads/UAL_Mapping_Party_V0.2.9.xlsx' as module_name,'DM_ADDRESS' as table_name,'ADDRESS_ID' as column_name,'VERI_NON_NULLABLE' as veri_code,count(*) as veri_result from DM_ADDRESS
 where ADDRESS_ID is  null;
insert into dm_template_veri (module_name,table_name,column_name,veri_code,veri_result)
select '/home/guangjun/git/dctemplates/app/uploads/UAL_Mapping_Party_V0.2.9.xlsx' as module_name,'DM_ADDRESS' as table_name,'ADDRESS_ID' as column_name,'VERI_PRIMARY_KEY' as veri_code,count(*) as veri_result from DM_ADDRESS
 where (select count(*) from DM_ADDRESS  b where DM_ADDRESS.ADDRESS_ID=b.ADDRESS_ID)>1;
insert into dm_template_veri (module_name,table_name,column_name,veri_code,veri_result)
select '/home/guangjun/git/dctemplates/app/uploads/UAL_Mapping_Party_V0.2.9.xlsx' as module_name,'DM_ADDRESS' as table_name,'ADDRESS_1' as column_name,'VERI_STRING_LENGTH_OVER_DEF' as veri_code,count(*) as veri_result from DM_ADDRESS
 where length(ADDRESS_1)>200 and ADDRESS_1 is not null;
insert into dm_template_veri (module_name,table_name,column_name,veri_code,veri_result)
select '/home/guangjun/git/dctemplates/app/uploads/UAL_Mapping_Party_V0.2.9.xlsx' as module_name,'DM_ADDRESS' as table_name,'ADDRESS_2' as column_name,'VERI_STRING_LENGTH_OVER_DEF' as veri_code,count(*) as veri_result from DM_ADDRESS
 where length(ADDRESS_2)>200 and ADDRESS_2 is not null;
insert into dm_template_veri (module_name,table_name,column_name,veri_code,veri_result)
select '/home/guangjun/git/dctemplates/app/uploads/UAL_Mapping_Party_V0.2.9.xlsx' as module_name,'DM_ADDRESS' as table_name,'ADDRESS_3' as column_name,'VERI_STRING_LENGTH_OVER_DEF' as veri_code,count(*) as veri_result from DM_ADDRESS
 where length(ADDRESS_3)>100 and ADDRESS_3 is not null;
insert into dm_template_veri (module_name,table_name,column_name,veri_code,veri_result)
select '/home/guangjun/git/dctemplates/app/uploads/UAL_Mapping_Party_V0.2.9.xlsx' as module_name,'DM_ADDRESS' as table_name,'ADDRESS_4' as column_name,'VERI_STRING_LENGTH_OVER_DEF' as veri_code,count(*) as veri_result from DM_ADDRESS
 where length(ADDRESS_4)>100 and ADDRESS_4 is not null;
insert into dm_template_veri (module_name,table_name,column_name,veri_code,veri_result)
select '/home/guangjun/git/dctemplates/app/uploads/UAL_Mapping_Party_V0.2.9.xlsx' as module_name,'DM_ADDRESS' as table_name,'ADDRESS_5' as column_name,'VERI_STRING_LENGTH_OVER_DEF' as veri_code,count(*) as veri_result from DM_ADDRESS
 where length(ADDRESS_5)>100 and ADDRESS_5 is not null;
insert into dm_template_veri (module_name,table_name,column_name,veri_code,veri_result)
select '/home/guangjun/git/dctemplates/app/uploads/UAL_Mapping_Party_V0.2.9.xlsx' as module_name,'DM_ADDRESS' as table_name,'ADDRESS_6' as column_name,'VERI_STRING_LENGTH_OVER_DEF' as veri_code,count(*) as veri_result from DM_ADDRESS
 where length(ADDRESS_6)>100 and ADDRESS_6 is not null;
insert into dm_template_veri (module_name,table_name,column_name,veri_code,veri_result)
select '/home/guangjun/git/dctemplates/app/uploads/UAL_Mapping_Party_V0.2.9.xlsx' as module_name,'DM_ADDRESS' as table_name,'ADDRESS_7' as column_name,'VERI_STRING_LENGTH_OVER_DEF' as veri_code,count(*) as veri_result from DM_ADDRESS
 where length(ADDRESS_7)>100 and ADDRESS_7 is not null;
insert into dm_template_veri (module_name,table_name,column_name,veri_code,veri_result)
select '/home/guangjun/git/dctemplates/app/uploads/UAL_Mapping_Party_V0.2.9.xlsx' as module_name,'DM_ADDRESS' as table_name,'ADDRESS_8' as column_name,'VERI_STRING_LENGTH_OVER_DEF' as veri_code,count(*) as veri_result from DM_ADDRESS
 where length(ADDRESS_8)>100 and ADDRESS_8 is not null;
insert into dm_template_veri (module_name,table_name,column_name,veri_code,veri_result)
select '/home/guangjun/git/dctemplates/app/uploads/UAL_Mapping_Party_V0.2.9.xlsx' as module_name,'DM_ADDRESS' as table_name,'ADDRESS_9' as column_name,'VERI_STRING_LENGTH_OVER_DEF' as veri_code,count(*) as veri_result from DM_ADDRESS
 where length(ADDRESS_9)>100 and ADDRESS_9 is not null;
insert into dm_template_veri (module_name,table_name,column_name,veri_code,veri_result)
select '/home/guangjun/git/dctemplates/app/uploads/UAL_Mapping_Party_V0.2.9.xlsx' as module_name,'DM_ADDRESS' as table_name,'POST_CODE' as column_name,'VERI_STRING_LENGTH_OVER_DEF' as veri_code,count(*) as veri_result from DM_ADDRESS
 where length(POST_CODE)>10 and POST_CODE is not null;
insert into dm_template_veri (module_name,table_name,column_name,veri_code,veri_result)
select '/home/guangjun/git/dctemplates/app/uploads/UAL_Mapping_Party_V0.2.9.xlsx' as module_name,'DM_ADDRESS' as table_name,'STATE' as column_name,'VERI_STRING_LENGTH_OVER_DEF' as veri_code,count(*) as veri_result from DM_ADDRESS
 where length(STATE)>100 and STATE is not null;
insert into dm_template_veri (module_name,table_name,column_name,veri_code,veri_result)
select '/home/guangjun/git/dctemplates/app/uploads/UAL_Mapping_Party_V0.2.9.xlsx' as module_name,'DM_ADDRESS' as table_name,'COUNTRY_CODE' as column_name,'VERI_STRING_LENGTH_OVER_DEF' as veri_code,count(*) as veri_result from DM_ADDRESS
 where length(COUNTRY_CODE)>3 and COUNTRY_CODE is not null;
insert into dm_template_veri (module_name,table_name,column_name,veri_code,veri_result)
select '/home/guangjun/git/dctemplates/app/uploads/UAL_Mapping_Party_V0.2.9.xlsx' as module_name,'DM_ADDRESS' as table_name,'COUNTRY_CODE' as column_name,'VERI_FOREIGN_KEY_TEMPLATE' as veri_code,count(*) as veri_result from DM_ADDRESS
 where ( not exists(select 1 from T_COUNTRY  b where DM_ADDRESS.COUNTRY_CODE=b.COUNTRY_CODE) and COUNTRY_CODE is not null);
insert into dm_template_veri (module_name,table_name,column_name,veri_code,veri_result)
select '/home/guangjun/git/dctemplates/app/uploads/UAL_Mapping_Party_V0.2.9.xlsx' as module_name,'DM_ADDRESS' as table_name,'CITY' as column_name,'VERI_STRING_LENGTH_OVER_DEF' as veri_code,count(*) as veri_result from DM_ADDRESS
 where length(CITY)>50 and CITY is not null;
insert into dm_template_veri (module_name,table_name,column_name,veri_code,veri_result)
select '/home/guangjun/git/dctemplates/app/uploads/UAL_Mapping_Party_V0.2.9.xlsx' as module_name,'DM_ADDRESS' as table_name,'ADDRESS_STATUS' as column_name,'VERI_STRING_LENGTH_OVER_DEF' as veri_code,count(*) as veri_result from DM_ADDRESS
 where length(ADDRESS_STATUS)>1 and ADDRESS_STATUS is not null;
insert into dm_template_veri (module_name,table_name,column_name,veri_code,veri_result)
select '/home/guangjun/git/dctemplates/app/uploads/UAL_Mapping_Party_V0.2.9.xlsx' as module_name,'DM_ADDRESS' as table_name,'ADDRESS_STATUS' as column_name,'VERI_NON_NULLABLE' as veri_code,count(*) as veri_result from DM_ADDRESS
 where ADDRESS_STATUS is  null;
insert into dm_template_veri (module_name,table_name,column_name,veri_code,veri_result)
select '/home/guangjun/git/dctemplates/app/uploads/UAL_Mapping_Party_V0.2.9.xlsx' as module_name,'DM_ADDRESS' as table_name,'ADDRESS_FORMAT' as column_name,'VERI_STRING_LENGTH_OVER_DEF' as veri_code,count(*) as veri_result from DM_ADDRESS
 where length(ADDRESS_FORMAT)>1 and ADDRESS_FORMAT is not null;
insert into dm_template_veri (module_name,table_name,column_name,veri_code,veri_result)
select '/home/guangjun/git/dctemplates/app/uploads/UAL_Mapping_Party_V0.2.9.xlsx' as module_name,'DM_ADDRESS' as table_name,'ADDRESS_FORMAT' as column_name,'VERI_NON_NULLABLE' as veri_code,count(*) as veri_result from DM_ADDRESS
 where ADDRESS_FORMAT is  null;
insert into dm_template_veri (module_name,table_name,column_name,veri_code,veri_result)
select '/home/guangjun/git/dctemplates/app/uploads/UAL_Mapping_Party_V0.2.9.xlsx' as module_name,'DM_ADDRESS' as table_name,'ADDRESS_FORMAT' as column_name,'VERI_FOREIGN_KEY_TEMPLATE' as veri_code,count(*) as veri_result from DM_ADDRESS
 where ( not exists(select 1 from T_YES_NO  b where DM_ADDRESS.ADDRESS_FORMAT=b.YES_NO) and ADDRESS_FORMAT is not null);
insert into dm_template_veri (module_name,table_name,column_name,veri_code,veri_result)
select '/home/guangjun/git/dctemplates/app/uploads/UAL_Mapping_Party_V0.2.9.xlsx' as module_name,'DM_CHANNEL_ORG' as table_name,'CHANNEL_ID' as column_name,'VERI_NUMBER_ILLEGAL' as veri_code,count(*) as veri_result from DM_CHANNEL_ORG
 where f_is_number(CHANNEL_ID)=1 and CHANNEL_ID is not null;
insert into dm_template_veri (module_name,table_name,column_name,veri_code,veri_result)
select '/home/guangjun/git/dctemplates/app/uploads/UAL_Mapping_Party_V0.2.9.xlsx' as module_name,'DM_CHANNEL_ORG' as table_name,'CHANNEL_ID' as column_name,'VERI_NON_NULLABLE' as veri_code,count(*) as veri_result from DM_CHANNEL_ORG
 where CHANNEL_ID is  null;
insert into dm_template_veri (module_name,table_name,column_name,veri_code,veri_result)
select '/home/guangjun/git/dctemplates/app/uploads/UAL_Mapping_Party_V0.2.9.xlsx' as module_name,'DM_CHANNEL_ORG' as table_name,'CHANNEL_ID' as column_name,'VERI_PRIMARY_KEY' as veri_code,count(*) as veri_result from DM_CHANNEL_ORG
 where (select count(*) from DM_CHANNEL_ORG  b where DM_CHANNEL_ORG.CHANNEL_ID=b.CHANNEL_ID)>1;
insert into dm_template_veri (module_name,table_name,column_name,veri_code,veri_result)
select '/home/guangjun/git/dctemplates/app/uploads/UAL_Mapping_Party_V0.2.9.xlsx' as module_name,'DM_CHANNEL_ORG' as table_name,'CHANNEL_ID' as column_name,'VERI_FOREIGN_KEY_TEMPLATE' as veri_code,count(*) as veri_result from DM_CHANNEL_ORG
 where ( not exists(select 1 from DM_COMPANY_CUSTOMER  b where DM_CHANNEL_ORG.CHANNEL_ID=b.COMPANY_ID) and CHANNEL_ID is not null);
insert into dm_template_veri (module_name,table_name,column_name,veri_code,veri_result)
select '/home/guangjun/git/dctemplates/app/uploads/UAL_Mapping_Party_V0.2.9.xlsx' as module_name,'DM_CHANNEL_ORG' as table_name,'PARENT_ID' as column_name,'VERI_NUMBER_ILLEGAL' as veri_code,count(*) as veri_result from DM_CHANNEL_ORG
 where f_is_number(PARENT_ID)=1 and PARENT_ID is not null;
insert into dm_template_veri (module_name,table_name,column_name,veri_code,veri_result)
select '/home/guangjun/git/dctemplates/app/uploads/UAL_Mapping_Party_V0.2.9.xlsx' as module_name,'DM_CHANNEL_ORG' as table_name,'CHANNEL_NAME' as column_name,'VERI_STRING_LENGTH_OVER_DEF' as veri_code,count(*) as veri_result from DM_CHANNEL_ORG
 where length(CHANNEL_NAME)>100 and CHANNEL_NAME is not null;
insert into dm_template_veri (module_name,table_name,column_name,veri_code,veri_result)
select '/home/guangjun/git/dctemplates/app/uploads/UAL_Mapping_Party_V0.2.9.xlsx' as module_name,'DM_CHANNEL_ORG' as table_name,'CHANNEL_CODE' as column_name,'VERI_STRING_LENGTH_OVER_DEF' as veri_code,count(*) as veri_result from DM_CHANNEL_ORG
 where length(CHANNEL_CODE)>50 and CHANNEL_CODE is not null;
insert into dm_template_veri (module_name,table_name,column_name,veri_code,veri_result)
select '/home/guangjun/git/dctemplates/app/uploads/UAL_Mapping_Party_V0.2.9.xlsx' as module_name,'DM_CHANNEL_ORG' as table_name,'CHANNEL_CODE' as column_name,'VERI_NON_NULLABLE' as veri_code,count(*) as veri_result from DM_CHANNEL_ORG
 where CHANNEL_CODE is  null;
insert into dm_template_veri (module_name,table_name,column_name,veri_code,veri_result)
select '/home/guangjun/git/dctemplates/app/uploads/UAL_Mapping_Party_V0.2.9.xlsx' as module_name,'DM_CHANNEL_ORG' as table_name,'LEADER_ID' as column_name,'VERI_NUMBER_ILLEGAL' as veri_code,count(*) as veri_result from DM_CHANNEL_ORG
 where f_is_number(LEADER_ID)=1 and LEADER_ID is not null;
insert into dm_template_veri (module_name,table_name,column_name,veri_code,veri_result)
select '/home/guangjun/git/dctemplates/app/uploads/UAL_Mapping_Party_V0.2.9.xlsx' as module_name,'DM_CHANNEL_ORG' as table_name,'LEADER_ID' as column_name,'VERI_FOREIGN_KEY_TEMPLATE' as veri_code,count(*) as veri_result from DM_CHANNEL_ORG
 where ( not exists(select 1 from DM_PARTY  b where DM_CHANNEL_ORG.LEADER_ID=b.PARTY_ID) and LEADER_ID is not null);
insert into dm_template_veri (module_name,table_name,column_name,veri_code,veri_result)
select '/home/guangjun/git/dctemplates/app/uploads/UAL_Mapping_Party_V0.2.9.xlsx' as module_name,'DM_CHANNEL_ORG' as table_name,'CHANNEL_TYPE' as column_name,'VERI_NUMBER_ILLEGAL' as veri_code,count(*) as veri_result from DM_CHANNEL_ORG
 where f_is_number(CHANNEL_TYPE)=1 and CHANNEL_TYPE is not null;
insert into dm_template_veri (module_name,table_name,column_name,veri_code,veri_result)
select '/home/guangjun/git/dctemplates/app/uploads/UAL_Mapping_Party_V0.2.9.xlsx' as module_name,'DM_CHANNEL_ORG' as table_name,'CHANNEL_TYPE' as column_name,'VERI_FOREIGN_KEY_TEMPLATE' as veri_code,count(*) as veri_result from DM_CHANNEL_ORG
 where ( not exists(select 1 from T_SALES_CHANNEL  b where DM_CHANNEL_ORG.CHANNEL_TYPE=b.sales_channel_id) and CHANNEL_TYPE is not null);
insert into dm_template_veri (module_name,table_name,column_name,veri_code,veri_result)
select '/home/guangjun/git/dctemplates/app/uploads/UAL_Mapping_Party_V0.2.9.xlsx' as module_name,'DM_CHANNEL_ORG' as table_name,'ORG_ID' as column_name,'VERI_NUMBER_ILLEGAL' as veri_code,count(*) as veri_result from DM_CHANNEL_ORG
 where f_is_number(ORG_ID)=1 and ORG_ID is not null;
insert into dm_template_veri (module_name,table_name,column_name,veri_code,veri_result)
select '/home/guangjun/git/dctemplates/app/uploads/UAL_Mapping_Party_V0.2.9.xlsx' as module_name,'DM_CHANNEL_ORG' as table_name,'ORG_ID' as column_name,'VERI_NON_NULLABLE' as veri_code,count(*) as veri_result from DM_CHANNEL_ORG
 where ORG_ID is  null;
insert into dm_template_veri (module_name,table_name,column_name,veri_code,veri_result)
select '/home/guangjun/git/dctemplates/app/uploads/UAL_Mapping_Party_V0.2.9.xlsx' as module_name,'DM_CHANNEL_ORG' as table_name,'ORG_ID' as column_name,'VERI_FOREIGN_KEY_TEMPLATE' as veri_code,count(*) as veri_result from DM_CHANNEL_ORG
 where ( not exists(select 1 from T_COMPANY_ORGAN  b where DM_CHANNEL_ORG.ORG_ID=b.organ_id) and ORG_ID is not null);
insert into dm_template_veri (module_name,table_name,column_name,veri_code,veri_result)
select '/home/guangjun/git/dctemplates/app/uploads/UAL_Mapping_Party_V0.2.9.xlsx' as module_name,'DM_CHANNEL_ORG' as table_name,'STATUS' as column_name,'VERI_STRING_LENGTH_OVER_DEF' as veri_code,count(*) as veri_result from DM_CHANNEL_ORG
 where length(STATUS)>1 and STATUS is not null;
insert into dm_template_veri (module_name,table_name,column_name,veri_code,veri_result)
select '/home/guangjun/git/dctemplates/app/uploads/UAL_Mapping_Party_V0.2.9.xlsx' as module_name,'DM_CHANNEL_ORG' as table_name,'STATUS' as column_name,'VERI_NON_NULLABLE' as veri_code,count(*) as veri_result from DM_CHANNEL_ORG
 where STATUS is  null;
insert into dm_template_veri (module_name,table_name,column_name,veri_code,veri_result)
select '/home/guangjun/git/dctemplates/app/uploads/UAL_Mapping_Party_V0.2.9.xlsx' as module_name,'DM_CHANNEL_ORG' as table_name,'STATUS_DATE' as column_name,'VERI_DATE_ILLEGAL' as veri_code,count(*) as veri_result from DM_CHANNEL_ORG
 where f_is_date(STATUS_DATE)=1 and STATUS_DATE is not null;
insert into dm_template_veri (module_name,table_name,column_name,veri_code,veri_result)
select '/home/guangjun/git/dctemplates/app/uploads/UAL_Mapping_Party_V0.2.9.xlsx' as module_name,'DM_CHANNEL_ORG' as table_name,'STATUS_DATE' as column_name,'VERI_NON_NULLABLE' as veri_code,count(*) as veri_result from DM_CHANNEL_ORG
 where STATUS_DATE is  null;
insert into dm_template_veri (module_name,table_name,column_name,veri_code,veri_result)
select '/home/guangjun/git/dctemplates/app/uploads/UAL_Mapping_Party_V0.2.9.xlsx' as module_name,'DM_CHANNEL_ORG' as table_name,'STATUS_REASON' as column_name,'VERI_STRING_LENGTH_OVER_DEF' as veri_code,count(*) as veri_result from DM_CHANNEL_ORG
 where length(STATUS_REASON)>10 and STATUS_REASON is not null;
insert into dm_template_veri (module_name,table_name,column_name,veri_code,veri_result)
select '/home/guangjun/git/dctemplates/app/uploads/UAL_Mapping_Party_V0.2.9.xlsx' as module_name,'DM_CHANNEL_ORG' as table_name,'CHANNEL_GRADE' as column_name,'VERI_NUMBER_ILLEGAL' as veri_code,count(*) as veri_result from DM_CHANNEL_ORG
 where f_is_number(CHANNEL_GRADE)=1 and CHANNEL_GRADE is not null;
insert into dm_template_veri (module_name,table_name,column_name,veri_code,veri_result)
select '/home/guangjun/git/dctemplates/app/uploads/UAL_Mapping_Party_V0.2.9.xlsx' as module_name,'DM_CHANNEL_ORG' as table_name,'CHANNEL_GRADE' as column_name,'VERI_FOREIGN_KEY_TEMPLATE' as veri_code,count(*) as veri_result from DM_CHANNEL_ORG
 where ( not exists(select 1 from T_CHANNEL_GRADE  b where DM_CHANNEL_ORG.CHANNEL_GRADE=b.channel_grade) and CHANNEL_GRADE is not null);
insert into dm_template_veri (module_name,table_name,column_name,veri_code,veri_result)
select '/home/guangjun/git/dctemplates/app/uploads/UAL_Mapping_Party_V0.2.9.xlsx' as module_name,'DM_CHANNEL_ORG' as table_name,'TELEPHONE' as column_name,'VERI_STRING_LENGTH_OVER_DEF' as veri_code,count(*) as veri_result from DM_CHANNEL_ORG
 where length(TELEPHONE)>30 and TELEPHONE is not null;
insert into dm_template_veri (module_name,table_name,column_name,veri_code,veri_result)
select '/home/guangjun/git/dctemplates/app/uploads/UAL_Mapping_Party_V0.2.9.xlsx' as module_name,'DM_CHANNEL_ORG' as table_name,'FAX' as column_name,'VERI_STRING_LENGTH_OVER_DEF' as veri_code,count(*) as veri_result from DM_CHANNEL_ORG
 where length(FAX)>30 and FAX is not null;
insert into dm_template_veri (module_name,table_name,column_name,veri_code,veri_result)
select '/home/guangjun/git/dctemplates/app/uploads/UAL_Mapping_Party_V0.2.9.xlsx' as module_name,'DM_CHANNEL_ORG' as table_name,'EMAIL' as column_name,'VERI_STRING_LENGTH_OVER_DEF' as veri_code,count(*) as veri_result from DM_CHANNEL_ORG
 where length(EMAIL)>50 and EMAIL is not null;
insert into dm_template_veri (module_name,table_name,column_name,veri_code,veri_result)
select '/home/guangjun/git/dctemplates/app/uploads/UAL_Mapping_Party_V0.2.9.xlsx' as module_name,'DM_CHANNEL_ORG' as table_name,'ADDRESS_ID' as column_name,'VERI_NUMBER_ILLEGAL' as veri_code,count(*) as veri_result from DM_CHANNEL_ORG
 where f_is_number(ADDRESS_ID)=1 and ADDRESS_ID is not null;
insert into dm_template_veri (module_name,table_name,column_name,veri_code,veri_result)
select '/home/guangjun/git/dctemplates/app/uploads/UAL_Mapping_Party_V0.2.9.xlsx' as module_name,'DM_CHANNEL_ORG' as table_name,'ADDRESS_ID' as column_name,'VERI_FOREIGN_KEY_TEMPLATE' as veri_code,count(*) as veri_result from DM_CHANNEL_ORG
 where ( not exists(select 1 from DM_ADDRESS  b where DM_CHANNEL_ORG.ADDRESS_ID=b.ADDRESS_ID) and ADDRESS_ID is not null);
insert into dm_template_veri (module_name,table_name,column_name,veri_code,veri_result)
select '/home/guangjun/git/dctemplates/app/uploads/UAL_Mapping_Party_V0.2.9.xlsx' as module_name,'DM_CHANNEL_ORG' as table_name,'DEFAULT_BANK' as column_name,'VERI_NUMBER_ILLEGAL' as veri_code,count(*) as veri_result from DM_CHANNEL_ORG
 where f_is_number(DEFAULT_BANK)=1 and DEFAULT_BANK is not null;
insert into dm_template_veri (module_name,table_name,column_name,veri_code,veri_result)
select '/home/guangjun/git/dctemplates/app/uploads/UAL_Mapping_Party_V0.2.9.xlsx' as module_name,'DM_CHANNEL_ORG' as table_name,'DEFAULT_BANK' as column_name,'VERI_FOREIGN_KEY_TEMPLATE' as veri_code,count(*) as veri_result from DM_CHANNEL_ORG
 where ( not exists(select 1 from T_BANK  b where DM_CHANNEL_ORG.DEFAULT_BANK=b.bank_code) and DEFAULT_BANK is not null);
insert into dm_template_veri (module_name,table_name,column_name,veri_code,veri_result)
select '/home/guangjun/git/dctemplates/app/uploads/UAL_Mapping_Party_V0.2.9.xlsx' as module_name,'DM_CHANNEL_ORG' as table_name,'CREATE_DATE' as column_name,'VERI_DATE_ILLEGAL' as veri_code,count(*) as veri_result from DM_CHANNEL_ORG
 where f_is_date(CREATE_DATE)=1 and CREATE_DATE is not null;
insert into dm_template_veri (module_name,table_name,column_name,veri_code,veri_result)
select '/home/guangjun/git/dctemplates/app/uploads/UAL_Mapping_Party_V0.2.9.xlsx' as module_name,'DM_COMPANY_CUSTOMER' as table_name,'COMPANY_ID' as column_name,'VERI_NUMBER_ILLEGAL' as veri_code,count(*) as veri_result from DM_COMPANY_CUSTOMER
 where f_is_number(COMPANY_ID)=1 and COMPANY_ID is not null;
insert into dm_template_veri (module_name,table_name,column_name,veri_code,veri_result)
select '/home/guangjun/git/dctemplates/app/uploads/UAL_Mapping_Party_V0.2.9.xlsx' as module_name,'DM_COMPANY_CUSTOMER' as table_name,'COMPANY_ID' as column_name,'VERI_NON_NULLABLE' as veri_code,count(*) as veri_result from DM_COMPANY_CUSTOMER
 where COMPANY_ID is  null;
insert into dm_template_veri (module_name,table_name,column_name,veri_code,veri_result)
select '/home/guangjun/git/dctemplates/app/uploads/UAL_Mapping_Party_V0.2.9.xlsx' as module_name,'DM_COMPANY_CUSTOMER' as table_name,'COMPANY_ID' as column_name,'VERI_PRIMARY_KEY' as veri_code,count(*) as veri_result from DM_COMPANY_CUSTOMER
 where (select count(*) from DM_COMPANY_CUSTOMER  b where DM_COMPANY_CUSTOMER.COMPANY_ID=b.COMPANY_ID)>1;
insert into dm_template_veri (module_name,table_name,column_name,veri_code,veri_result)
select '/home/guangjun/git/dctemplates/app/uploads/UAL_Mapping_Party_V0.2.9.xlsx' as module_name,'DM_COMPANY_CUSTOMER' as table_name,'COMPANY_ID' as column_name,'VERI_FOREIGN_KEY_TEMPLATE' as veri_code,count(*) as veri_result from DM_COMPANY_CUSTOMER
 where ( not exists(select 1 from DM_PARTY  b where DM_COMPANY_CUSTOMER.COMPANY_ID=b.PARTY_ID) and COMPANY_ID is not null);
insert into dm_template_veri (module_name,table_name,column_name,veri_code,veri_result)
select '/home/guangjun/git/dctemplates/app/uploads/UAL_Mapping_Party_V0.2.9.xlsx' as module_name,'DM_COMPANY_CUSTOMER' as table_name,'COMPANY_NAME' as column_name,'VERI_STRING_LENGTH_OVER_DEF' as veri_code,count(*) as veri_result from DM_COMPANY_CUSTOMER
 where length(COMPANY_NAME)>150 and COMPANY_NAME is not null;
insert into dm_template_veri (module_name,table_name,column_name,veri_code,veri_result)
select '/home/guangjun/git/dctemplates/app/uploads/UAL_Mapping_Party_V0.2.9.xlsx' as module_name,'DM_COMPANY_CUSTOMER' as table_name,'COMPANY_NAME' as column_name,'VERI_NON_NULLABLE' as veri_code,count(*) as veri_result from DM_COMPANY_CUSTOMER
 where COMPANY_NAME is  null;
insert into dm_template_veri (module_name,table_name,column_name,veri_code,veri_result)
select '/home/guangjun/git/dctemplates/app/uploads/UAL_Mapping_Party_V0.2.9.xlsx' as module_name,'DM_COMPANY_CUSTOMER' as table_name,'ABBR_NAME' as column_name,'VERI_STRING_LENGTH_OVER_DEF' as veri_code,count(*) as veri_result from DM_COMPANY_CUSTOMER
 where length(ABBR_NAME)>50 and ABBR_NAME is not null;
insert into dm_template_veri (module_name,table_name,column_name,veri_code,veri_result)
select '/home/guangjun/git/dctemplates/app/uploads/UAL_Mapping_Party_V0.2.9.xlsx' as module_name,'DM_COMPANY_CUSTOMER' as table_name,'FOUND_DATE' as column_name,'VERI_DATE_ILLEGAL' as veri_code,count(*) as veri_result from DM_COMPANY_CUSTOMER
 where f_is_date(FOUND_DATE)=1 and FOUND_DATE is not null;
insert into dm_template_veri (module_name,table_name,column_name,veri_code,veri_result)
select '/home/guangjun/git/dctemplates/app/uploads/UAL_Mapping_Party_V0.2.9.xlsx' as module_name,'DM_COMPANY_CUSTOMER' as table_name,'TAX_CODE' as column_name,'VERI_STRING_LENGTH_OVER_DEF' as veri_code,count(*) as veri_result from DM_COMPANY_CUSTOMER
 where length(TAX_CODE)>20 and TAX_CODE is not null;
insert into dm_template_veri (module_name,table_name,column_name,veri_code,veri_result)
select '/home/guangjun/git/dctemplates/app/uploads/UAL_Mapping_Party_V0.2.9.xlsx' as module_name,'DM_COMPANY_CUSTOMER' as table_name,'TELEPHONE' as column_name,'VERI_STRING_LENGTH_OVER_DEF' as veri_code,count(*) as veri_result from DM_COMPANY_CUSTOMER
 where length(TELEPHONE)>30 and TELEPHONE is not null;
insert into dm_template_veri (module_name,table_name,column_name,veri_code,veri_result)
select '/home/guangjun/git/dctemplates/app/uploads/UAL_Mapping_Party_V0.2.9.xlsx' as module_name,'DM_COMPANY_CUSTOMER' as table_name,'FAX' as column_name,'VERI_STRING_LENGTH_OVER_DEF' as veri_code,count(*) as veri_result from DM_COMPANY_CUSTOMER
 where length(FAX)>30 and FAX is not null;
insert into dm_template_veri (module_name,table_name,column_name,veri_code,veri_result)
select '/home/guangjun/git/dctemplates/app/uploads/UAL_Mapping_Party_V0.2.9.xlsx' as module_name,'DM_COMPANY_CUSTOMER' as table_name,'EMAIL' as column_name,'VERI_STRING_LENGTH_OVER_DEF' as veri_code,count(*) as veri_result from DM_COMPANY_CUSTOMER
 where length(EMAIL)>50 and EMAIL is not null;
insert into dm_template_veri (module_name,table_name,column_name,veri_code,veri_result)
select '/home/guangjun/git/dctemplates/app/uploads/UAL_Mapping_Party_V0.2.9.xlsx' as module_name,'DM_COMPANY_CUSTOMER' as table_name,'STAFF_AMOUNT' as column_name,'VERI_NUMBER_ILLEGAL' as veri_code,count(*) as veri_result from DM_COMPANY_CUSTOMER
 where f_is_number(STAFF_AMOUNT)=1 and STAFF_AMOUNT is not null;
insert into dm_template_veri (module_name,table_name,column_name,veri_code,veri_result)
select '/home/guangjun/git/dctemplates/app/uploads/UAL_Mapping_Party_V0.2.9.xlsx' as module_name,'DM_COMPANY_CUSTOMER' as table_name,'REGISTER_CAPITAL' as column_name,'VERI_NUMBER_ILLEGAL' as veri_code,count(*) as veri_result from DM_COMPANY_CUSTOMER
 where f_is_number(REGISTER_CAPITAL)=1 and REGISTER_CAPITAL is not null;
insert into dm_template_veri (module_name,table_name,column_name,veri_code,veri_result)
select '/home/guangjun/git/dctemplates/app/uploads/UAL_Mapping_Party_V0.2.9.xlsx' as module_name,'DM_COMPANY_CUSTOMER' as table_name,'REGISTER_CODE' as column_name,'VERI_STRING_LENGTH_OVER_DEF' as veri_code,count(*) as veri_result from DM_COMPANY_CUSTOMER
 where length(REGISTER_CODE)>100 and REGISTER_CODE is not null;
insert into dm_template_veri (module_name,table_name,column_name,veri_code,veri_result)
select '/home/guangjun/git/dctemplates/app/uploads/UAL_Mapping_Party_V0.2.9.xlsx' as module_name,'DM_COMPANY_CUSTOMER' as table_name,'URL' as column_name,'VERI_STRING_LENGTH_OVER_DEF' as veri_code,count(*) as veri_result from DM_COMPANY_CUSTOMER
 where length(URL)>50 and URL is not null;
insert into dm_template_veri (module_name,table_name,column_name,veri_code,veri_result)
select '/home/guangjun/git/dctemplates/app/uploads/UAL_Mapping_Party_V0.2.9.xlsx' as module_name,'DM_COMPANY_CUSTOMER' as table_name,'LEADER_NAME' as column_name,'VERI_STRING_LENGTH_OVER_DEF' as veri_code,count(*) as veri_result from DM_COMPANY_CUSTOMER
 where length(LEADER_NAME)>50 and LEADER_NAME is not null;
insert into dm_template_veri (module_name,table_name,column_name,veri_code,veri_result)
select '/home/guangjun/git/dctemplates/app/uploads/UAL_Mapping_Party_V0.2.9.xlsx' as module_name,'DM_COMPANY_CUSTOMER' as table_name,'CONTACT_TEL' as column_name,'VERI_STRING_LENGTH_OVER_DEF' as veri_code,count(*) as veri_result from DM_COMPANY_CUSTOMER
 where length(CONTACT_TEL)>30 and CONTACT_TEL is not null;
insert into dm_template_veri (module_name,table_name,column_name,veri_code,veri_result)
select '/home/guangjun/git/dctemplates/app/uploads/UAL_Mapping_Party_V0.2.9.xlsx' as module_name,'DM_COMPANY_CUSTOMER' as table_name,'BANKRUPTCY_ORDER_NO' as column_name,'VERI_STRING_LENGTH_OVER_DEF' as veri_code,count(*) as veri_result from DM_COMPANY_CUSTOMER
 where length(BANKRUPTCY_ORDER_NO)>25 and BANKRUPTCY_ORDER_NO is not null;
insert into dm_template_veri (module_name,table_name,column_name,veri_code,veri_result)
select '/home/guangjun/git/dctemplates/app/uploads/UAL_Mapping_Party_V0.2.9.xlsx' as module_name,'DM_COMPANY_CUSTOMER' as table_name,'DISCHARGE_DATE' as column_name,'VERI_DATE_ILLEGAL' as veri_code,count(*) as veri_result from DM_COMPANY_CUSTOMER
 where f_is_date(DISCHARGE_DATE)=1 and DISCHARGE_DATE is not null;
insert into dm_template_veri (module_name,table_name,column_name,veri_code,veri_result)
select '/home/guangjun/git/dctemplates/app/uploads/UAL_Mapping_Party_V0.2.9.xlsx' as module_name,'DM_COMPANY_CUSTOMER' as table_name,'BANKRUPTCY_ORDER_DATE' as column_name,'VERI_DATE_ILLEGAL' as veri_code,count(*) as veri_result from DM_COMPANY_CUSTOMER
 where f_is_date(BANKRUPTCY_ORDER_DATE)=1 and BANKRUPTCY_ORDER_DATE is not null;
insert into dm_template_veri (module_name,table_name,column_name,veri_code,veri_result)
select '/home/guangjun/git/dctemplates/app/uploads/UAL_Mapping_Party_V0.2.9.xlsx' as module_name,'DM_COMPANY_CUSTOMER' as table_name,'BANKRUPTCY_STATUS' as column_name,'VERI_STRING_LENGTH_OVER_DEF' as veri_code,count(*) as veri_result from DM_COMPANY_CUSTOMER
 where length(BANKRUPTCY_STATUS)>1 and BANKRUPTCY_STATUS is not null;
insert into dm_template_veri (module_name,table_name,column_name,veri_code,veri_result)
select '/home/guangjun/git/dctemplates/app/uploads/UAL_Mapping_Party_V0.2.9.xlsx' as module_name,'DM_COMPANY_CUSTOMER' as table_name,'VIP_INDI' as column_name,'VERI_STRING_LENGTH_OVER_DEF' as veri_code,count(*) as veri_result from DM_COMPANY_CUSTOMER
 where length(VIP_INDI)>1 and VIP_INDI is not null;
insert into dm_template_veri (module_name,table_name,column_name,veri_code,veri_result)
select '/home/guangjun/git/dctemplates/app/uploads/UAL_Mapping_Party_V0.2.9.xlsx' as module_name,'DM_COMPANY_CUSTOMER' as table_name,'MOBILE' as column_name,'VERI_STRING_LENGTH_OVER_DEF' as veri_code,count(*) as veri_result from DM_COMPANY_CUSTOMER
 where length(MOBILE)>20 and MOBILE is not null;
insert into dm_template_veri (module_name,table_name,column_name,veri_code,veri_result)
select '/home/guangjun/git/dctemplates/app/uploads/UAL_Mapping_Party_V0.2.9.xlsx' as module_name,'DM_COMPANY_CUSTOMER' as table_name,'SMS' as column_name,'VERI_STRING_LENGTH_OVER_DEF' as veri_code,count(*) as veri_result from DM_COMPANY_CUSTOMER
 where length(SMS)>30 and SMS is not null;
insert into dm_template_veri (module_name,table_name,column_name,veri_code,veri_result)
select '/home/guangjun/git/dctemplates/app/uploads/UAL_Mapping_Party_V0.2.9.xlsx' as module_name,'DM_COMPANY_CUSTOMER' as table_name,'INSERT_TIME' as column_name,'VERI_DATE_ILLEGAL' as veri_code,count(*) as veri_result from DM_COMPANY_CUSTOMER
 where f_is_date(INSERT_TIME)=1 and INSERT_TIME is not null;
insert into dm_template_veri (module_name,table_name,column_name,veri_code,veri_result)
select '/home/guangjun/git/dctemplates/app/uploads/UAL_Mapping_Party_V0.2.9.xlsx' as module_name,'DM_COMPANY_CUSTOMER' as table_name,'UPDATE_TIME' as column_name,'VERI_DATE_ILLEGAL' as veri_code,count(*) as veri_result from DM_COMPANY_CUSTOMER
 where f_is_date(UPDATE_TIME)=1 and UPDATE_TIME is not null;

 commit;

spool off