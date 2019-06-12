
-- ���ݱ�����ű�

-- �������ģ���
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

-- ��ʼ�����ý�ɫ
insert into SYS_ROLE (ROLE_CODE, ROLE_NAME, NAME_EN, IS_SYS, IS_SHOW, CREATE_BY, CREATE_DATE, UPDATE_BY, UPDATE_DATE, REMARKS, CORP_CODE, CORP_NAME, ROLE_TYPE)
values ('0', 'Ĭ�Ͻ�ɫ', 'default', '1', '1', 'system', sysdate, 'system', sysdate, '�ǹ���Ա�û������е�Ĭ�Ͻ�ɫ', '0', '�׿Ƶ����', null);
insert into SYS_ROLE (ROLE_CODE, ROLE_NAME, NAME_EN, IS_SYS, IS_SHOW, CREATE_BY, CREATE_DATE, UPDATE_BY, UPDATE_DATE, REMARKS, CORP_CODE, CORP_NAME, ROLE_TYPE)
values ('1', 'ϵͳ����Ա', 'corp_admin_user', '1', '1', 'system', sysdate, 'system', sysdate, '�ͻ���ʹ�õĽ�ɫ���ͻ�������Ա�����Ź���Ա', '0', '�׿Ƶ����', null);
insert into SYS_ROLE (ROLE_CODE, ROLE_NAME, NAME_EN, IS_SYS, IS_SHOW, CREATE_BY, CREATE_DATE, UPDATE_BY, UPDATE_DATE, REMARKS, CORP_CODE, CORP_NAME, ROLE_TYPE)
values ('2', '��������Ա', 'sec_admin_user', '1', '1', 'system', sysdate, 'system', sysdate, '�ɿͻ�������Ա����ʹ�ã��������ñ���λ�Ķ�������Ա', '0', '�׿Ƶ����', null);

truncate table sys_role_menu;
--insert into sys_role_menu select '1' role_code, menu_code from sys_menu;

-- ��ʼ�������û�
truncate table sys_user;
insert into SYS_USER (USER_CODE, PASSWORD, USER_NAME, EMAIL, MOBILE, PHONE, PHOTO, IMEI, USER_TYPE, REF_CODE, REF_NAME, MGR_TYPE, LOGIN_IP, LOGIN_DATE, FREEZE_DATE, STATUS, CREATE_BY, CREATE_DATE, UPDATE_BY, UPDATE_DATE, REMARKS, LOGIN_CODE, CORP_CODE, CORP_NAME, WX_OPENID, SESSION_ID)
values ('system', '71f67eb14ba775fd9ad43b61b1fcc19114df5bbcabe46a8f06e90b4d', '��������Ա', null, null, null, null, null, '0', null, null, '0', '127.0.0.1', sysdate, null, '0', 'system', sysdate, 'system', sysdate, null, 'system', '0', '�׿Ƶ����', null, null);
insert into SYS_USER (USER_CODE, PASSWORD, USER_NAME, EMAIL, MOBILE, PHONE, PHOTO, IMEI, USER_TYPE, REF_CODE, REF_NAME, MGR_TYPE, LOGIN_IP, LOGIN_DATE, FREEZE_DATE, STATUS, CREATE_BY, CREATE_DATE, UPDATE_BY, UPDATE_DATE, REMARKS, LOGIN_CODE, CORP_CODE, CORP_NAME, WX_OPENID, SESSION_ID)
values ('admin', '38e7994a556a30b21cca16a3d782011e3cd46e0300bea86913af7781', 'ϵͳ����Ա', null, null, null, null, null, '0', null, null, '1', '127.0.0.1', sysdate, null, '0', 'system', sysdate, 'system', sysdate, null, 'admin', '0', '�׿Ƶ����', null, null);

truncate table sys_user_data_scope;
truncate table sys_user_m_data_scope;
truncate table sys_user_m_role;
truncate table sys_user_role;

-- �����û��ֵ�
truncate table SYS_USER_DICT_TYPE;
truncate table SYS_USER_DICT;

-- ������Ϣģ���
truncate table MSG_MESSAGE;
truncate table MSG_MESSAGE_RECORD;

-- �������ݹ����
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
values ('1', 'Ĭ��վ��', '��ʾվ��', null, null, null, null, 'basic', '<!--HTML--><p>��Ȩ���У�ɽ���׿Ƶ�������޹�˾</p>', null, null, 'system', sysdate, 'system', sysdate, '0');

-- ����FoxBPM���̱�
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

-- ����EcodeFlow���̱�
truncate table sys_flow_business;
truncate table sys_flow_log;
truncate table sys_flow_template;
truncate table sys_flow_templates;
truncate table sys_flow_template_billtype;
truncate table sys_flow_template_scope;

-- ����������ݱ���ɾ����
truncate table test_data;
truncate table test_data_child;
truncate table test_data_main;
truncate table test_tree;
truncate table test_baoxiao;
truncate table test_flow;
