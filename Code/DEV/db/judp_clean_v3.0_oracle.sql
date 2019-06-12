
-- 数据表清理脚本

-- 清理核心模块表
truncate table sys_company;
truncate table sys_employee;
truncate table sys_employee_post;
truncate table sys_file;
truncate table sys_file_user;
truncate table sys_file_user_biz;
truncate table sys_log;
--truncate table SYS_OPERATE_LOG;
--truncate table SYS_OPERATE_COLUMN;
truncate table sys_office;
truncate table sys_office_company;
truncate table sys_post;
truncate table sys_role;

-- 初始化内置角色
insert into SYS_ROLE (ROLE_CODE, ROLE_NAME, NAME_EN, IS_SYS, IS_SHOW, CREATE_BY, CREATE_DATE, UPDATE_BY, UPDATE_DATE, REMARKS, CORP_CODE, CORP_NAME, ROLE_TYPE)
values ('0', '默认角色', 'default', '1', '1', 'system', sysdate, 'system', sysdate, '非管理员用户，共有的默认角色', '0', '易科德软件', null);
insert into SYS_ROLE (ROLE_CODE, ROLE_NAME, NAME_EN, IS_SYS, IS_SHOW, CREATE_BY, CREATE_DATE, UPDATE_BY, UPDATE_DATE, REMARKS, CORP_CODE, CORP_NAME, ROLE_TYPE)
values ('1', '系统管理员', 'corp_admin_user', '1', '1', 'system', sysdate, 'system', sysdate, '客户方使用的角色，客户方管理员，集团管理员', '0', '易科德软件', null);
insert into SYS_ROLE (ROLE_CODE, ROLE_NAME, NAME_EN, IS_SYS, IS_SHOW, CREATE_BY, CREATE_DATE, UPDATE_BY, UPDATE_DATE, REMARKS, CORP_CODE, CORP_NAME, ROLE_TYPE)
values ('2', '二级管理员', 'sec_admin_user', '1', '1', 'system', sysdate, 'system', sysdate, '由客户方管理员设置使用，可以设置本单位的二级管理员', '0', '易科德软件', null);

truncate table sys_role_menu;
--insert into sys_role_menu select '1' role_code, menu_code from sys_menu;

-- 初始化内置用户
truncate table sys_user;
insert into SYS_USER (USER_CODE, PASSWORD, USER_NAME, EMAIL, MOBILE, PHONE, PHOTO, IMEI, USER_TYPE, REF_CODE, REF_NAME, MGR_TYPE, LOGIN_IP, LOGIN_DATE, FREEZE_DATE, STATUS, CREATE_BY, CREATE_DATE, UPDATE_BY, UPDATE_DATE, REMARKS, LOGIN_CODE, CORP_CODE, CORP_NAME, WX_OPENID, SESSION_ID)
values ('system', '71f67eb14ba775fd9ad43b61b1fcc19114df5bbcabe46a8f06e90b4d', '超级管理员', null, null, null, null, null, '0', null, null, '0', '127.0.0.1', sysdate, null, '0', 'system', sysdate, 'system', sysdate, null, 'system', '0', '易科德软件', null, null);
insert into SYS_USER (USER_CODE, PASSWORD, USER_NAME, EMAIL, MOBILE, PHONE, PHOTO, IMEI, USER_TYPE, REF_CODE, REF_NAME, MGR_TYPE, LOGIN_IP, LOGIN_DATE, FREEZE_DATE, STATUS, CREATE_BY, CREATE_DATE, UPDATE_BY, UPDATE_DATE, REMARKS, LOGIN_CODE, CORP_CODE, CORP_NAME, WX_OPENID, SESSION_ID)
values ('admin', '38e7994a556a30b21cca16a3d782011e3cd46e0300bea86913af7781', '系统管理员', null, null, null, null, null, '0', null, null, '1', '127.0.0.1', sysdate, null, '0', 'system', sysdate, 'system', sysdate, null, 'admin', '0', '易科德软件', null, null);

truncate table sys_user_data_scope;
truncate table sys_user_m_data_scope;
truncate table sys_user_m_role;
truncate table sys_user_role;

-- 清理用户字典
truncate table SYS_USER_DICT_TYPE;
truncate table SYS_USER_DICT;

-- 清理消息模块表
truncate table MSG_MESSAGE;
truncate table MSG_MESSAGE_RECORD;

-- 清理内容管理表
truncate table cms_article;
truncate table cms_article_data;
truncate table cms_category;
truncate table cms_category_role;
truncate table cms_comment;
truncate table cms_guestbook;
truncate table cms_link;
truncate table cms_site;
truncate table cms_visit_log;

insert into CMS_SITE (SITE_CODE, SITE_NAME, TITLE, LOGO, DOMAIN, DESCRIPTION, KEYWORDS, THEME, COPYRIGHT, CUSTOM_INDEX_VIEW, REMARKS, CREATE_BY, CREATE_DATE, UPDATE_BY, UPDATE_DATE, STATUS)
values ('1', '默认站点', '演示站点', null, null, null, null, 'basic', '<!--HTML--><p>版权所有：山东易科德软件有限公司</p>', null, null, 'system', sysdate, 'system', sysdate, '0');

-- 清理FoxBPM流程表
truncate table foxbpm_agent;
truncate table foxbpm_agent_details;
truncate table foxbpm_def_bytearray;
truncate table foxbpm_def_deployment;
truncate table foxbpm_def_processdefinition;
truncate table foxbpm_mail;
truncate table foxbpm_run_processinstance;
truncate table foxbpm_run_process_info;
truncate table foxbpm_run_runningtrack;
truncate table foxbpm_run_task;
truncate table foxbpm_run_taskidentitylink;
truncate table foxbpm_run_token;
truncate table foxbpm_run_variable;

-- 清理EcodeFlow流程表
truncate table sys_flow_business;
truncate table sys_flow_log;
truncate table sys_flow_template;
truncate table sys_flow_templates;
truncate table sys_flow_template_billtype;
truncate table sys_flow_template_scope;

-- 清理测试数据表（可删除）
truncate table test_data;
truncate table test_data_child;
truncate table test_data_main;
truncate table test_tree;
truncate table test_baoxiao;
truncate table test_flow;
