spool UAL_Mapping_Party_V0.2.9_create.sql.log
drop table DM_PRODUCER_HIERARCHY;
create table DM_PRODUCER_HIERARCHY(
HIERARCHY_ID                   varchar2(300)  primary key,
PRODUCER_ORG_ID                varchar2(300) ,
PRODUCER_ID                    varchar2(300) ,
PRODUCER_POSITION              varchar2(300) ,
PRODUCER_STATUS                varchar2(300) ,
UPLINE_ORG_ID                  varchar2(300) ,
UPLINE_ID                      varchar2(300) ,
UPLINE_POSITION                varchar2(300) ,
HIERARCHY_TYPE                 varchar2(300) ,
ACTIVE_INDI                    varchar2(300) ,
PRE_HIERARCHY_ID               varchar2(300) ,
SITUATION_CODE                 varchar2(300) ,
START_DATE                     varchar2(300) ,
END_DATE                       varchar2(300) ,
CHANGE_TYPE                    varchar2(300) ,
TRANSFER_REASON                varchar2(300) ,
CHANGE_COMMENT                 varchar2(300) 
);
drop table DM_PARTY;
create table DM_PARTY(
PARTY_ID                       varchar2(300)  primary key,
PARTY_TYPE                     varchar2(300) ,
INSERT_TIME                    varchar2(300) ,
UPDATE_TIME                    varchar2(300) 
);
drop table DM_BANK_ACCOUNT;
create table DM_BANK_ACCOUNT(
ACCOUNT_ID                     varchar2(300)  primary key,
BANK_CODE                      varchar2(300) ,
BANK_ACCOUNT                   varchar2(300) ,
ACCO_NAME                      varchar2(300) ,
CERTI_TYPE                     varchar2(300) ,
CERTI_CODE                     varchar2(300) ,
APPLY_DATE                     varchar2(300) ,
ACCOUNT_TYPE                   varchar2(300) ,
EXPIRE_DATE                    varchar2(300) ,
CREDIT_CARD_TYPE               varchar2(300) ,
DEBIT_CREDIT_TYPE              varchar2(300) ,
PARTY_ID                       varchar2(300) ,
ACCOUNT_STATUS                 varchar2(300) ,
IS_SELF                        varchar2(300) ,
SUSPEND_CAUSE                  varchar2(300) ,
CAUSE_DESC                     varchar2(1000) 
);
drop table DM_PARTY_COMMENT;
create table DM_PARTY_COMMENT(
COMMENT_ID                     varchar2(300)  primary key,
PARTY_ID                       varchar2(300) ,
COMMENTS                       varchar2(1000) ,
START_DATE                     varchar2(300) 
);
drop table DM_CUSTOMER;
create table DM_CUSTOMER(
CUSTOMER_ID                    varchar2(300)  primary key,
GENDER                         varchar2(300) ,
BIRTHDAY                       varchar2(300) ,
CERTI_TYPE                     varchar2(300) ,
CERTI_CODE                     varchar2(300) ,
MARRIAGE_ID                    varchar2(300) ,
EDUCATION_ID                   varchar2(300) ,
HEIGHT                         varchar2(300) ,
WEIGHT                         varchar2(300) ,
EMAIL                          varchar2(300) ,
INCOME                         varchar2(300) ,
JOB_CATE_ID                    varchar2(300) ,
NATIONALITY                    varchar2(300) ,
SMOKING                        varchar2(300) ,
DEATH_TIME                     varchar2(300) ,
DRIVING_LICENCE                varchar2(300) ,
RETIRED                        varchar2(300) ,
LANG_ID                        varchar2(300) ,
HOMEPLACE                      varchar2(300) ,
NATION_CODE                    varchar2(300) ,
ACCIDENT_STATUS                varchar2(300) ,
HONOR_TITLE                    varchar2(300) ,
CUST_GRADE                     varchar2(300) ,
COUNTRY_CODE                   varchar2(300) ,
BLACKLIST_CAUSE                varchar2(300) ,
MOBILE                         varchar2(300) ,
OFFICE_TEL                     varchar2(300) ,
HOME_TEL                       varchar2(300) ,
FIRST_NAME                     varchar2(300) ,
MID_NAME                       varchar2(300) ,
LAST_NAME                      varchar2(300) ,
ALIAS_NAME                     varchar2(300) ,
INDUSTRY_ID                    varchar2(300) ,
RELIGION_CODE                  varchar2(300) ,
OFFICE_TEL_EXT                 varchar2(300) ,
FAX                            varchar2(300) ,
INSURED_STATUS                 varchar2(300) ,
CLAIM_INDI                     varchar2(300) ,
VIP_INDI                       varchar2(300) ,
BANKRUPTCY_ORDER_NO            varchar2(300) ,
BANKRUPTCY_ORDER_DATE          varchar2(300) ,
BANKRUPTCY_STATUS              varchar2(300) ,
DISCHARGE_DATE                 varchar2(300) ,
PROOF_AGE                      varchar2(300) ,
CHILD_COUNT                    varchar2(300) ,
BLACKLIST_CODE                 varchar2(300) ,
ORIGIN_CUST_ID                 varchar2(300) ,
INSERT_TIME                    varchar2(300) ,
UPDATE_TIME                    varchar2(300) 
);
drop table DM_AGENT;
create table DM_AGENT(
AGENT_ID                       varchar2(300)  primary key,
AGENT_CODE                     varchar2(300) ,
ORGAN_ID                       varchar2(300) ,
AGENT_STATUS                   varchar2(300) ,
COMM_ACCOUNT_ID                varchar2(300) ,
AGENT_CATE                     varchar2(300) ,
STATUS_REASON                  varchar2(300) ,
APPOINMENT_DATE                varchar2(300) ,
AGENT_GRADE                    varchar2(300) ,
ENTER_COMPANY_DATE             varchar2(300) ,
LEAVE_COMPANY_DATE             varchar2(300) ,
RECOMMENDER_ID                 varchar2(300) ,
TRAINER_ID                     varchar2(300) ,
SCHOOL                         varchar2(300) ,
MAJOR                          varchar2(300) ,
DEGREE_ID                      varchar2(300) ,
BEGIN_JOB_DATE                 varchar2(300) ,
HOLDBACK_INDI                  varchar2(300) ,
HOLDBACK_PERIOD                varchar2(300) ,
HOLDBACK_RATE                  varchar2(300) ,
PAYMENT_MODE                   varchar2(300) ,
CHANNEL_ORG_ID                 varchar2(300) ,
PHYSICAL_LOCATION              varchar2(300) ,
OTHER_INCOME_INDI              varchar2(300) ,
JOB_NATURE_ID                  varchar2(300) ,
OLD_JOB_ID                     varchar2(300) ,
LICENSE_TYPE_ID                varchar2(300) ,
LICENSE_EFF_DATE               varchar2(300) ,
EXPIRE_DATE                    varchar2(300) ,
POSITION_DATE                  varchar2(300) ,
QUALIFICATION_CERTI_CODE       varchar2(300) 
);
drop table DM_PARTY_ADDR;
create table DM_PARTY_ADDR(
PARTY_ADDR_ID                  varchar2(300)  primary key,
PARTY_ID                       varchar2(300) ,
ADDRESS_ID                     varchar2(300) ,
ADDRESS_TYPE                   varchar2(300) 
);
drop table DM_ADDRESS;
create table DM_ADDRESS(
ADDRESS_ID                     varchar2(300)  primary key,
ADDRESS_1                      varchar2(300) ,
ADDRESS_2                      varchar2(300) ,
ADDRESS_3                      varchar2(300) ,
ADDRESS_4                      varchar2(300) ,
ADDRESS_5                      varchar2(300) ,
ADDRESS_6                      varchar2(300) ,
ADDRESS_7                      varchar2(300) ,
ADDRESS_8                      varchar2(300) ,
ADDRESS_9                      varchar2(300) ,
POST_CODE                      varchar2(300) ,
STATE                          varchar2(300) ,
COUNTRY_CODE                   varchar2(300) ,
CITY                           varchar2(300) ,
ADDRESS_STATUS                 varchar2(300) ,
ADDRESS_FORMAT                 varchar2(300) 
);
drop table DM_CHANNEL_ORG;
create table DM_CHANNEL_ORG(
CHANNEL_ID                     varchar2(300)  primary key,
PARENT_ID                      varchar2(300) ,
CHANNEL_NAME                   varchar2(300) ,
CHANNEL_CODE                   varchar2(300) ,
LEADER_ID                      varchar2(300) ,
CHANNEL_TYPE                   varchar2(300) ,
ORG_ID                         varchar2(300) ,
STATUS                         varchar2(300) ,
STATUS_DATE                    varchar2(300) ,
STATUS_REASON                  varchar2(300) ,
CHANNEL_GRADE                  varchar2(300) ,
TELEPHONE                      varchar2(300) ,
FAX                            varchar2(300) ,
EMAIL                          varchar2(300) ,
ADDRESS_ID                     varchar2(300) ,
DEFAULT_BANK                   varchar2(300) ,
CREATE_DATE                    varchar2(300) 
);
drop table DM_COMPANY_CUSTOMER;
create table DM_COMPANY_CUSTOMER(
COMPANY_ID                     varchar2(300)  primary key,
COMPANY_NAME                   varchar2(300) ,
ABBR_NAME                      varchar2(300) ,
FOUND_DATE                     varchar2(300) ,
TAX_CODE                       varchar2(300) ,
TELEPHONE                      varchar2(300) ,
FAX                            varchar2(300) ,
EMAIL                          varchar2(300) ,
STAFF_AMOUNT                   varchar2(300) ,
REGISTER_CAPITAL               varchar2(300) ,
REGISTER_CODE                  varchar2(300) ,
URL                            varchar2(300) ,
LEADER_NAME                    varchar2(300) ,
CONTACT_TEL                    varchar2(300) ,
BANKRUPTCY_ORDER_NO            varchar2(300) ,
DISCHARGE_DATE                 varchar2(300) ,
BANKRUPTCY_ORDER_DATE          varchar2(300) ,
BANKRUPTCY_STATUS              varchar2(300) ,
VIP_INDI                       varchar2(300) ,
MOBILE                         varchar2(300) ,
SMS                            varchar2(300) ,
INSERT_TIME                    varchar2(300) ,
UPDATE_TIME                    varchar2(300) 
);

spool off