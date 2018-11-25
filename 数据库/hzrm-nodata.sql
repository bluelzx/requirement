----------------------------------------------------
-- Export file for user HZRM                      --
-- Created by Administrator on 2013-9-6, 16:10:03 --
----------------------------------------------------

spool hzrm-nodata.log

prompt
prompt Creating table LOADDATA
prompt =======================
prompt
create table LOADDATA
(
  REQUIREMENTCODE VARCHAR2(50 CHAR) not null,
  PLANMANHAUR     INTEGER
)
;

prompt
prompt Creating table MD_DATE_INFO
prompt ===========================
prompt
create table MD_DATE_INFO
(
  S_YEAR      VARCHAR2(10),
  S_YEAR_CHS  VARCHAR2(20),
  S_QUART     VARCHAR2(10),
  S_QUART_CHS VARCHAR2(20),
  S_MTH       VARCHAR2(10),
  S_MTH_CHS   VARCHAR2(20),
  S_TEN       VARCHAR2(10),
  S_TEN_CHS   VARCHAR2(20),
  S_DATE      VARCHAR2(10),
  S_DATE_CHS  VARCHAR2(20)
)
;
comment on table MD_DATE_INFO
  is '����ά��';
comment on column MD_DATE_INFO.S_YEAR
  is '��';
comment on column MD_DATE_INFO.S_YEAR_CHS
  is '������';
comment on column MD_DATE_INFO.S_QUART
  is '��';
comment on column MD_DATE_INFO.S_QUART_CHS
  is '������';
comment on column MD_DATE_INFO.S_MTH
  is '��';
comment on column MD_DATE_INFO.S_MTH_CHS
  is '������';
comment on column MD_DATE_INFO.S_TEN
  is 'Ѯ';
comment on column MD_DATE_INFO.S_TEN_CHS
  is 'Ѯ����';
comment on column MD_DATE_INFO.S_DATE
  is '��';
comment on column MD_DATE_INFO.S_DATE_CHS
  is '��������';

prompt
prompt Creating table REQUIREMENT_TEMP
prompt ===============================
prompt
create table REQUIREMENT_TEMP
(
  REQUIRENAME VARCHAR2(150 CHAR),
  DEPT        VARCHAR2(30 CHAR)
)
;

prompt
prompt Creating table RMM_APPLY_TASK
prompt =============================
prompt
create table RMM_APPLY_TASK
(
  APPLYCODE VARCHAR2(30) not null,
  TASKCODE  VARCHAR2(50) not null
)
;
comment on table RMM_APPLY_TASK
  is '�����Ͳ������';
comment on column RMM_APPLY_TASK.APPLYCODE
  is '�嵥���';
comment on column RMM_APPLY_TASK.TASKCODE
  is '������';

prompt
prompt Creating table RMM_DATE
prompt =======================
prompt
create table RMM_DATE
(
  DATADATE VARCHAR2(8)
)
;

prompt
prompt Creating table RMM_FILE
prompt =======================
prompt
create table RMM_FILE
(
  FILECODE      VARCHAR2(30 CHAR) not null,
  FILENAME      VARCHAR2(200 CHAR),
  FILEPATH      VARCHAR2(200 CHAR),
  UPLOADTIME    VARCHAR2(30 CHAR),
  USERCODE      VARCHAR2(30 CHAR),
  REQUIREMENTID VARCHAR2(30 CHAR),
  FILESIZE      INTEGER,
  FILETYPE      VARCHAR2(30 CHAR)
)
;

prompt
prompt Creating table RMM_HOLIDAY
prompt ==========================
prompt
create table RMM_HOLIDAY
(
  HOLIDAY_DATE VARCHAR2(20)
)
;
comment on table RMM_HOLIDAY
  is '�ڼ��ձ�';
comment on column RMM_HOLIDAY.HOLIDAY_DATE
  is '�ڼ���';

prompt
prompt Creating table RMM_LOG
prompt ======================
prompt
create table RMM_LOG
(
  LOGCODE         VARCHAR2(30 CHAR),
  LOGTIME         VARCHAR2(30 CHAR),
  REQUIREMENTCODE VARCHAR2(30 CHAR),
  TASKCODE        VARCHAR2(30 CHAR),
  LOGCREATOR      VARCHAR2(30 CHAR),
  LOGTEXT         VARCHAR2(500 CHAR),
  REQUIREMENTID   VARCHAR2(30 CHAR)
)
;

prompt
prompt Creating table RMM_MENU
prompt =======================
prompt
create table RMM_MENU
(
  MENUCODE       VARCHAR2(20 CHAR) not null,
  MENUNAME       VARCHAR2(100 CHAR),
  MENUURL        VARCHAR2(200 CHAR),
  PARENTMENU     VARCHAR2(20 CHAR),
  MENUORDER      INTEGER,
  MENUCREATETIME TIMESTAMP(6),
  MENUCREATER    VARCHAR2(20 CHAR),
  MENUSTATUS     INTEGER
)
;
comment on column RMM_MENU.MENUCODE
  is '�˵����';
comment on column RMM_MENU.MENUNAME
  is '�˵���';
comment on column RMM_MENU.MENUURL
  is '�˵�URL';
comment on column RMM_MENU.PARENTMENU
  is '�ϼ��˵�';
comment on column RMM_MENU.MENUORDER
  is '�����';
comment on column RMM_MENU.MENUCREATETIME
  is '����ʱ��';
comment on column RMM_MENU.MENUCREATER
  is '������';
comment on column RMM_MENU.MENUSTATUS
  is '״̬0��Ч1Ϊ��Ч';

prompt
prompt Creating table RMM_PARA
prompt =======================
prompt
create table RMM_PARA
(
  PARA_TYPE   VARCHAR2(20 CHAR),
  PARA_CODE   VARCHAR2(20 CHAR),
  PARA_VALUE  VARCHAR2(200 CHAR),
  PARA_REMARK VARCHAR2(100 CHAR)
)
;
comment on table RMM_PARA
  is 'ϵͳ������';
comment on column RMM_PARA.PARA_TYPE
  is '��������';
comment on column RMM_PARA.PARA_CODE
  is '��������';
comment on column RMM_PARA.PARA_VALUE
  is '����ֵ';
comment on column RMM_PARA.PARA_REMARK
  is '��ע';

prompt
prompt Creating table RMM_PROJECT
prompt ==========================
prompt
create table RMM_PROJECT
(
  PROJECT_CODE VARCHAR2(30),
  PROJECT_NAME VARCHAR2(100)
)
;
comment on table RMM_PROJECT
  is '��Ŀ�б�';
comment on column RMM_PROJECT.PROJECT_CODE
  is '��Ŀ����';
comment on column RMM_PROJECT.PROJECT_NAME
  is '��Ŀ����';

prompt
prompt Creating table RMM_REQUIREMENT
prompt ==============================
prompt
create table RMM_REQUIREMENT
(
  REQUIREMENTCODE  VARCHAR2(50 CHAR) not null,
  REQUIREMENTNAME  VARCHAR2(100 CHAR),
  REMARK           VARCHAR2(500 CHAR),
  CREATETIME       VARCHAR2(30 CHAR),
  CREATOR          VARCHAR2(30 CHAR),
  STARTDATE        VARCHAR2(30 CHAR),
  ENDDATE          VARCHAR2(30 CHAR),
  STATUS           INTEGER,
  DEPT             VARCHAR2(30 CHAR),
  PRESENTER        VARCHAR2(30 CHAR),
  PARENTCODE       VARCHAR2(50 CHAR),
  CLOSETIME        VARCHAR2(30 CHAR),
  REQUIREMENTTYPE  INTEGER,
  OWNER            VARCHAR2(30 CHAR),
  REQUIREMENTID    VARCHAR2(30 CHAR),
  IMPORTANT        INTEGER,
  URGENT           INTEGER,
  CONFIRMCLOSETIME VARCHAR2(30 CHAR),
  CONFIRMCLOSER    VARCHAR2(30 CHAR),
  PLANMANHAUR      NUMBER,
  PROJECT_CODE     VARCHAR2(30 CHAR),
  BUSINESSTYPE     INTEGER,
  WATCHER          VARCHAR2(30 CHAR)
)
;
comment on column RMM_REQUIREMENT.REQUIREMENTCODE
  is 'ҵ��������';
comment on column RMM_REQUIREMENT.REQUIREMENTNAME
  is '��������';
comment on column RMM_REQUIREMENT.REMARK
  is '��ע';
comment on column RMM_REQUIREMENT.CREATETIME
  is '��������';
comment on column RMM_REQUIREMENT.CREATOR
  is '������';
comment on column RMM_REQUIREMENT.STARTDATE
  is '��ʼ����';
comment on column RMM_REQUIREMENT.ENDDATE
  is '��������';
comment on column RMM_REQUIREMENT.STATUS
  is '����״̬1Ϊδ��ʼ2������3���4Ϊ�ر�';
comment on column RMM_REQUIREMENT.DEPT
  is 'ҵ���������';
comment on column RMM_REQUIREMENT.PRESENTER
  is 'ҵ�������';
comment on column RMM_REQUIREMENT.PARENTCODE
  is '�ϼ�����';
comment on column RMM_REQUIREMENT.CLOSETIME
  is '��һ������ر�ʱ��';
comment on column RMM_REQUIREMENT.REQUIREMENTTYPE
  is '�������ͼ�������';
comment on column RMM_REQUIREMENT.OWNER
  is '������';
comment on column RMM_REQUIREMENT.REQUIREMENTID
  is 'ϵͳ���������';
comment on column RMM_REQUIREMENT.IMPORTANT
  is '�����̶ȼ�������';
comment on column RMM_REQUIREMENT.URGENT
  is '��Ҫ�̶ȼ�������';
comment on column RMM_REQUIREMENT.CONFIRMCLOSETIME
  is '�����ֹ�ȷ�ϵĹر�ʱ��';
comment on column RMM_REQUIREMENT.CONFIRMCLOSER
  is '�ر���';
comment on column RMM_REQUIREMENT.PLANMANHAUR
  is 'Ԥ�ƹ�ʱ,��λ������';
comment on column RMM_REQUIREMENT.PROJECT_CODE
  is '��Ŀ����';
comment on column RMM_REQUIREMENT.BUSINESSTYPE
  is 'ҵ�����';
comment on column RMM_REQUIREMENT.WATCHER
  is '����';

prompt
prompt Creating table RMM_REQUIREMENT_APPLY
prompt ====================================
prompt
create table RMM_REQUIREMENT_APPLY
(
  APPLYCODE       VARCHAR2(30),
  APPLYVERSION    VARCHAR2(14),
  REQUIREMENTID   VARCHAR2(30),
  APPLYNAME       VARCHAR2(300),
  DEVPRINCIPAL    VARCHAR2(20),
  REPORTSELF      VARCHAR2(1),
  APPLYTIME       VARCHAR2(20),
  APPLYDEPT       VARCHAR2(30),
  APPLYFINISHTIME VARCHAR2(20),
  HOWTOTEST       VARCHAR2(4000),
  INFO            VARCHAR2(500),
  CONNER          VARCHAR2(30),
  CREATETIME      VARCHAR2(20),
  CREATOR         VARCHAR2(20),
  STATUS          INTEGER,
  ONLINEDATE      VARCHAR2(20)
)
;
comment on column RMM_REQUIREMENT_APPLY.APPLYCODE
  is '�嵥���';
comment on column RMM_REQUIREMENT_APPLY.APPLYVERSION
  is '�汾��';
comment on column RMM_REQUIREMENT_APPLY.REQUIREMENTID
  is '����';
comment on column RMM_REQUIREMENT_APPLY.APPLYNAME
  is '��Ŀ����';
comment on column RMM_REQUIREMENT_APPLY.DEVPRINCIPAL
  is '����������';
comment on column RMM_REQUIREMENT_APPLY.REPORTSELF
  is '�Բⱨ��';
comment on column RMM_REQUIREMENT_APPLY.APPLYTIME
  is '�Ͳ�ʱ��';
comment on column RMM_REQUIREMENT_APPLY.APPLYDEPT
  is '���Բ���';
comment on column RMM_REQUIREMENT_APPLY.APPLYFINISHTIME
  is '���ʱ��';
comment on column RMM_REQUIREMENT_APPLY.HOWTOTEST
  is '����ָ��';
comment on column RMM_REQUIREMENT_APPLY.INFO
  is '����˵��';
comment on column RMM_REQUIREMENT_APPLY.CONNER
  is '������';
comment on column RMM_REQUIREMENT_APPLY.CREATETIME
  is '����ʱ��';
comment on column RMM_REQUIREMENT_APPLY.CREATOR
  is '������';
comment on column RMM_REQUIREMENT_APPLY.STATUS
  is '�Ͳ�״̬1���Ͳ�2���Ͳ�3������4�������';
comment on column RMM_REQUIREMENT_APPLY.ONLINEDATE
  is '��������';

prompt
prompt Creating table RMM_STAT
prompt =======================
prompt
create table RMM_STAT
(
  PARA_TYPE               VARCHAR2(20 CHAR),
  PARA_CODE               VARCHAR2(20 CHAR),
  STATISTIC_GROPU1_REMARK VARCHAR2(30 CHAR),
  STATISTIC_GROPU1        VARCHAR2(20 CHAR),
  STATISTIC_GROPU2        VARCHAR2(20 CHAR),
  STATISTIC_GROPU2_REMARK VARCHAR2(30 CHAR)
)
;
comment on column RMM_STAT.PARA_TYPE
  is '��������';
comment on column RMM_STAT.PARA_CODE
  is '��������';
comment on column RMM_STAT.STATISTIC_GROPU1_REMARK
  is '����1˵��';
comment on column RMM_STAT.STATISTIC_GROPU1
  is '����1';
comment on column RMM_STAT.STATISTIC_GROPU2
  is '����2';
comment on column RMM_STAT.STATISTIC_GROPU2_REMARK
  is '����2˵��';

prompt
prompt Creating table RMM_TASK
prompt =======================
prompt
create table RMM_TASK
(
  TASKCODE       VARCHAR2(50 CHAR),
  TASKNAME       VARCHAR2(500 CHAR),
  REMARK         VARCHAR2(500 CHAR),
  STARTTIME      VARCHAR2(30 CHAR),
  ENDTIME        VARCHAR2(30 CHAR),
  STATUS         INTEGER,
  TASKTYPE       INTEGER,
  REQUIREMENTID  VARCHAR2(50 CHAR),
  TASKGROUP      VARCHAR2(20 CHAR),
  PLANMANHAUR    NUMBER,
  MANHAUR        NUMBER,
  USERCODE       VARCHAR2(30 CHAR),
  SIGNTIME       VARCHAR2(30 CHAR),
  CLOSETIME      VARCHAR2(30 CHAR),
  URGENT         INTEGER,
  LAUNCHDATE     VARCHAR2(30 CHAR),
  FINISHPERCENT  NUMBER,
  PLANFINISHTIME VARCHAR2(30 CHAR),
  ISLONGTERM     VARCHAR2(2),
  CREATOR        VARCHAR2(30)
)
;
comment on column RMM_TASK.TASKCODE
  is '�������Զ�����ǰ��16λΪʱ���14λΪ�������';
comment on column RMM_TASK.TASKNAME
  is '��������';
comment on column RMM_TASK.REMARK
  is '����ע';
comment on column RMM_TASK.STARTTIME
  is '��ʼ����';
comment on column RMM_TASK.ENDTIME
  is '��������';
comment on column RMM_TASK.STATUS
  is '״̬:1Ϊδ��ʼ2������3�������6�������4����-1�ȴ�ǰ������';
comment on column RMM_TASK.TASKTYPE
  is '�������ͼ�������';
comment on column RMM_TASK.REQUIREMENTID
  is '������';
comment on column RMM_TASK.TASKGROUP
  is '������1ΪӦ����2Ϊ������';
comment on column RMM_TASK.PLANMANHAUR
  is 'Ԥ�ƹ�ʱ';
comment on column RMM_TASK.MANHAUR
  is 'ʵ�ʹ�ʱ';
comment on column RMM_TASK.USERCODE
  is '������';
comment on column RMM_TASK.SIGNTIME
  is 'ǩ��ʱ��';
comment on column RMM_TASK.CLOSETIME
  is '�ر��ռ�';
comment on column RMM_TASK.URGENT
  is '�����̶ȼ�������';
comment on column RMM_TASK.LAUNCHDATE
  is '�ƻ���������';
comment on column RMM_TASK.FINISHPERCENT
  is '������ɰٷֱ�';
comment on column RMM_TASK.PLANFINISHTIME
  is 'Ԥ���������';
comment on column RMM_TASK.ISLONGTERM
  is '�Ƿ����������';
comment on column RMM_TASK.CREATOR
  is '���񴴽���';

prompt
prompt Creating table RMM_TASK_DEPENDABLE
prompt ==================================
prompt
create table RMM_TASK_DEPENDABLE
(
  TASKCODE       VARCHAR2(30 CHAR),
  DEPENDABLECODE VARCHAR2(30 CHAR)
)
;

prompt
prompt Creating table RMM_TASK_SIGNIN
prompt ==============================
prompt
create table RMM_TASK_SIGNIN
(
  TASKCODE    VARCHAR2(50 CHAR),
  USERCODE    VARCHAR2(20 CHAR),
  CREATETIME  TIMESTAMP(6),
  WEIGHTRATIO INTEGER,
  REMARK      VARCHAR2(500 CHAR),
  MANHOUR     NUMBER,
  OTHOUR      NUMBER,
  SIGNINCODE  VARCHAR2(30 CHAR)
)
;
comment on column RMM_TASK_SIGNIN.TASKCODE
  is '������';
comment on column RMM_TASK_SIGNIN.USERCODE
  is '�û����';
comment on column RMM_TASK_SIGNIN.CREATETIME
  is '����ʱ��';
comment on column RMM_TASK_SIGNIN.WEIGHTRATIO
  is 'Ȩ�ر���';
comment on column RMM_TASK_SIGNIN.REMARK
  is '��ע';
comment on column RMM_TASK_SIGNIN.MANHOUR
  is '�������칤ʱ';
comment on column RMM_TASK_SIGNIN.OTHOUR
  is '�Ӱ๤ʱ';
comment on column RMM_TASK_SIGNIN.SIGNINCODE
  is '����';

prompt
prompt Creating table RMM_TASK_SIGNIN_TMP
prompt ==================================
prompt
create table RMM_TASK_SIGNIN_TMP
(
  TASKCODE    VARCHAR2(50 CHAR),
  USERCODE    VARCHAR2(20 CHAR),
  CREATETIME  TIMESTAMP(6),
  WEIGHTRATIO INTEGER,
  REMARK      VARCHAR2(500 CHAR),
  MANHOUR     NUMBER,
  OTHOUR      NUMBER,
  SIGNINCODE  VARCHAR2(30 CHAR)
)
;

prompt
prompt Creating table RMM_USER
prompt =======================
prompt
create table RMM_USER
(
  USERCODE   VARCHAR2(20 CHAR) not null,
  USERNAME   VARCHAR2(30 CHAR),
  CREATETIME TIMESTAMP(6),
  CREATER    VARCHAR2(20 CHAR),
  PASSWORD   VARCHAR2(120 CHAR),
  USERTYPE   INTEGER,
  USERSTATUS INTEGER,
  MYTEAM     INTEGER,
  RTXCODE    VARCHAR2(20 CHAR)
)
;
comment on column RMM_USER.USERCODE
  is '�û�����';
comment on column RMM_USER.USERNAME
  is '�û�����';
comment on column RMM_USER.CREATETIME
  is '����ʱ��';
comment on column RMM_USER.CREATER
  is '������';
comment on column RMM_USER.PASSWORD
  is '����';
comment on column RMM_USER.USERTYPE
  is '�û�����1Ϊ��Ŀ����Ա2Ϊ������Ա3Ϊ������Ա';
comment on column RMM_USER.USERSTATUS
  is '�û�״̬0Ϊ��Ч1Ϊ��Ч';
comment on column RMM_USER.MYTEAM
  is '�����Ŷ�1���С�2�����3��Ŀ';
comment on column RMM_USER.RTXCODE
  is 'RTX���˺�';

prompt
prompt Creating table RMM_USER_MENU
prompt ============================
prompt
create table RMM_USER_MENU
(
  USERCODE   VARCHAR2(20 CHAR),
  MENUCODE   VARCHAR2(20 CHAR),
  PARENTMENU VARCHAR2(20 CHAR),
  MENUORDER  INTEGER
)
;

prompt
prompt Creating table RMM_VACATION
prompt ===========================
prompt
create table RMM_VACATION
(
  STARTTIME  VARCHAR2(30 CHAR),
  ENDTIME    VARCHAR2(30 CHAR),
  PROPOSER   VARCHAR2(20 CHAR),
  CREATETIME TIMESTAMP(6),
  CREATOR    VARCHAR2(20 CHAR),
  REMARK     VARCHAR2(100 CHAR)
)
;
comment on table RMM_VACATION
  is '���ݱ�';
comment on column RMM_VACATION.STARTTIME
  is '��ʼ����,9λ,ǰ��8λΪ����,����ʾ������,1Ϊ����2Ϊ����';
comment on column RMM_VACATION.ENDTIME
  is '��������,9λ,ǰ��8λΪ����,����ʾ������,1Ϊ����2Ϊ����';
comment on column RMM_VACATION.PROPOSER
  is '�����';
comment on column RMM_VACATION.CREATETIME
  is '¼��ʱ��';
comment on column RMM_VACATION.CREATOR
  is '¼����';
comment on column RMM_VACATION.REMARK
  is '��ע';

prompt
prompt Creating table TMP_RMM_20160701
prompt ===============================
prompt
create table TMP_RMM_20160701
(
  C1  VARCHAR2(1000),
  C2  VARCHAR2(1000),
  C3  VARCHAR2(1000),
  C4  VARCHAR2(1000),
  C5  VARCHAR2(1000),
  C6  VARCHAR2(1000),
  C7  VARCHAR2(1000),
  C8  VARCHAR2(1000),
  C9  VARCHAR2(1000),
  C10 VARCHAR2(1000),
  C11 VARCHAR2(1000),
  C12 VARCHAR2(1000),
  C13 VARCHAR2(1000),
  C14 VARCHAR2(1000),
  C15 VARCHAR2(1000),
  C16 VARCHAR2(1000),
  C17 VARCHAR2(1000),
  C18 VARCHAR2(1000),
  C19 VARCHAR2(1000),
  C20 VARCHAR2(1000),
  C21 VARCHAR2(1000),
  C22 VARCHAR2(1000),
  C23 VARCHAR2(1000),
  C24 VARCHAR2(1000),
  C25 VARCHAR2(1000),
  C26 VARCHAR2(1000),
  C27 VARCHAR2(1000),
  C28 VARCHAR2(1000),
  C29 VARCHAR2(1000),
  C30 VARCHAR2(1000),
  C31 VARCHAR2(1000),
  C32 VARCHAR2(1000),
  C33 VARCHAR2(1000)
)
;

prompt
prompt Creating table TMP_RMM_20160704
prompt ===============================
prompt
create table TMP_RMM_20160704
(
  C1  VARCHAR2(1000),
  C2  VARCHAR2(1000),
  C3  VARCHAR2(1000),
  C4  VARCHAR2(1000),
  C5  VARCHAR2(1000),
  C6  VARCHAR2(1000),
  C7  VARCHAR2(1000),
  C8  VARCHAR2(1000),
  C9  VARCHAR2(1000),
  C10 VARCHAR2(1000),
  C11 VARCHAR2(1000),
  C12 VARCHAR2(1000)
)
;

prompt
prompt Creating table TMP_TASKCODE
prompt ===========================
prompt
create table TMP_TASKCODE
(
  TASKCODE VARCHAR2(50 CHAR)
)
;

prompt
prompt Creating view V_MANHAUR_LIST
prompt ============================
prompt
create or replace view v_manhaur_list as
select x.tp as mtype,--����
       (select r.username from rmm_user r where r.usercode = x.usercode) as personName,--��Ա
       x.requirementcode as requirementCode,--������
       x.requirementname as requirementName,--��������
       x.taskname as taskName,--��������
       sum(x.mh1) as doneTime,--��ȷ��
       sum(x.mh2) as todoTime,--��ȷ��
       sum(x.mh1) + sum(x.mh2) as sumTime,--�ϼ�
       x.endTime--�������
  from (select '����' as tp,
               t1.usercode,
               case
                 when t1.status in ('3', '6') then
                  t1.planmanhaur
                 else
                  0
               end as mh1,
               case
                 when t1.status not in ('3', '6') then
                  t1.planmanhaur
                 else
                  0
               end as mh2,
               t2.requirementcode,
               t2.requirementname,
               t1.taskname,
               t1.endtime
          from rmm_task t1, rmm_requirement t2
         where t1.status not in (-1, 4)
           and t1.tasktype <> '99'
           and t1.planmanhaur > 0
           and t1.status<>'0'
           and t1.requirementid = t2.requirementid
        union all
        select '����' as tp,
               t1.usercode,
               case
                 when t1.status in ('3', '6') then
                  t1.planmanhaur * 0.2
                 else
                  0
               end as mh1,
               case
                 when t1.status not in ('3', '6') then
                  t1.planmanhaur * 0.2
                 else
                  0
               end as mh2,
               t2.requirementcode,
               t2.requirementname,
               t1.taskname,
               t1.endtime
          from rmm_task t1, rmm_requirement t2
         where t1.status not in (-1, 4)
           and t1.tasktype <> '99'
           and t1.planmanhaur > 0
           and t1.status<>'0'
           and t1.tasktype in (2, 11, 12, 13, 14, 21, 31, 32)
           and not(t2.requirementcode  like 'T%'
           and t2.createtime>='20161001')
           and t1.requirementid = t2.requirementid
        union all
        select '����' as tp,
               t2.owner as usercode,
               sum(case
                     when t1.status in ('3', '6') and
                          t1.tasktype in (2, 11, 12, 13, 14, 21, 31, 32) then
                      t1.planmanhaur * 0.2
                     else
                      0
                   end) as mh1,
               sum(case
                     when t1.status not in ('3', '6') and
                          t1.tasktype in (2, 11, 12, 13, 14, 21, 31, 32) then
                      t1.planmanhaur * 0.2
                     else
                      0
                   end) as mh2,
               t2.requirementcode,
               t2.requirementname,
               t2.requirementname as taskname,
               '' endtime
          from rmm_task t1, rmm_requirement t2
         where t1.status not in (-1, 4)
           and t1.tasktype <> '99'
           and t1.planmanhaur > 0
           and t1.status<>'0'
           and not(t2.requirementcode  like 'T%'
           and t2.createtime>='20161001')
           and t1.requirementid = t2.requirementid
         group by t2.owner, t2.requirementcode, t2.requirementname
        union
        select '����' as tp,
               t2.watcher as usercode,
               sum(case
                     when t1.status in ('3', '6') and
                          t1.tasktype in (2, 11, 12, 13, 14, 21, 31, 32) then
                      t1.planmanhaur * 0.05
                     else
                      0
                   end) as mh1,
               sum(case
                     when t1.status not in ('3', '6') and
                          t1.tasktype in (2, 11, 12, 13, 14, 21, 31, 32) then
                      t1.planmanhaur * 0.05
                     else
                      0
                   end) as mh2,
               t2.requirementcode,
               t2.requirementname,
               t2.requirementname as taskname,
               '' endtime
          from rmm_task t1, rmm_requirement t2
         where t1.status not in (-1, 4)
           and t1.tasktype <> '99'
           and t1.planmanhaur > 0
           and t1.status<>'0'
           and t2.watcher is not null
           and t1.requirementid = t2.requirementid
         group by t2.watcher, t2.requirementcode, t2.requirementname) x
 group by x.usercode,
          x.tp,
          x.requirementcode,
          x.requirementname,
          x.taskname,
          x.endtime
having sum(x.mh1) > 0 or sum(x.mh2) > 0
 order by x.usercode,
          x.tp,
          x.requirementcode,
          x.requirementname,
          x.taskname;

prompt
prompt Creating view V_MANHAUR_LIST_BCK
prompt ================================
prompt
create or replace view v_manhaur_list_bck as
select x.tp as mtype,--����
       (select r.username from rmm_user r where r.usercode = x.usercode) as personName,--��Ա
       x.requirementcode as requirementCode,--������
       x.requirementname as requirementName,--��������
       x.taskname as taskName,--��������
       sum(x.mh1) as doneTime,--��ȷ��
       sum(x.mh2) as todoTime,--��ȷ��
       sum(x.mh1) + sum(x.mh2) as sumTime--�ϼ�
  from (select '����' as tp,
               t1.usercode,
               case
                 when t1.status in ('3', '6') then
                  t1.planmanhaur
                 else
                  0
               end as mh1,
               case
                 when t1.status not in ('3', '6') then
                  t1.planmanhaur
                 else
                  0
               end as mh2,
               t2.requirementcode,
               t2.requirementname,
               t1.taskname
          from rmm_task t1, rmm_requirement t2
         where t1.status not in (-1, 4)
           and t1.tasktype <> '99'
           and t1.planmanhaur > 0
           and t1.requirementid = t2.requirementid
        union all
        select '����' as tp,
               t1.usercode,
               case
                 when t1.status in ('3', '6') then
                  t1.planmanhaur * 0.2
                 else
                  0
               end as mh1,
               case
                 when t1.status not in ('3', '6') then
                  t1.planmanhaur * 0.2
                 else
                  0
               end as mh2,
               t2.requirementcode,
               t2.requirementname,
               t1.taskname
          from rmm_task t1, rmm_requirement t2
         where t1.status not in (-1, 4)
           and t1.tasktype <> '99'
           and t1.planmanhaur > 0
           and t1.tasktype in (2, 11, 12, 13, 14, 21, 31, 32)
           and t1.requirementid = t2.requirementid
        union all
        select '����' as tp,
               t2.owner as usercode,
               sum(case
                     when t1.status in ('3', '6') and
                          t1.tasktype in (2, 11, 12, 13, 14, 21, 31, 32) then
                      t1.planmanhaur * 0.2
                     else
                      0
                   end) as mh1,
               sum(case
                     when t1.status not in ('3', '6') and
                          t1.tasktype in (2, 11, 12, 13, 14, 21, 31, 32) then
                      t1.planmanhaur * 0.2
                     else
                      0
                   end) as mh2,
               t2.requirementcode,
               t2.requirementname,
               t2.requirementname as taskname
          from rmm_task t1, rmm_requirement t2
         where t1.status not in (-1, 4)
           and t1.tasktype <> '99'
           and t1.planmanhaur > 0
           and t1.requirementid = t2.requirementid
         group by t2.owner, t2.requirementcode, t2.requirementname
        union
        select '����' as tp,
               t2.watcher as usercode,
               sum(case
                     when t1.status in ('3', '6') and
                          t1.tasktype in (2, 11, 12, 13, 14, 21, 31, 32) then
                      t1.planmanhaur * 0.05
                     else
                      0
                   end) as mh1,
               sum(case
                     when t1.status not in ('3', '6') and
                          t1.tasktype in (2, 11, 12, 13, 14, 21, 31, 32) then
                      t1.planmanhaur * 0.05
                     else
                      0
                   end) as mh2,
               t2.requirementcode,
               t2.requirementname,
               t2.requirementname as taskname
          from rmm_task t1, rmm_requirement t2
         where t1.status not in (-1, 4)
           and t1.tasktype <> '99'
           and t1.planmanhaur > 0
           and t2.watcher is not null
           and t1.requirementid = t2.requirementid
         group by t2.watcher, t2.requirementcode, t2.requirementname) x
 group by x.usercode,
          x.tp,
          x.requirementcode,
          x.requirementname,
          x.taskname
having sum(x.mh1) > 0 or sum(x.mh2) > 0
 order by x.usercode,
          x.tp,
          x.requirementcode,
          x.requirementname,
          x.taskname;

prompt
prompt Creating view V_MANHAUR_SUM
prompt ===========================
prompt
create or replace view v_manhaur_sum as
select t.personName,--��Ա
       t.mtype mtype,--����
       sum(t.doneTime) as doneTime,--��ȷ��
       sum(t.todoTime) as todoTime,--��ȷ��
       sum(t.sumTime) as sumTime,--�ϼ�
       count(*) as sumTask,--������
       sum(case when t.doneTime>0 then 1 else 0 end) as doneTask--������(��ȷ��)
  from v_manhaur_list t
 group by rollup(t.personName, t.mtype);

prompt
prompt Creating view V_RE
prompt ==================
prompt
create or replace view v_re as
select
t1.requirementcode||'-'||t1.requirementname as "��Ŀ����",
decode(t1.urgent,'1','1-һ��','2','2-����','3','3-����(������)','4','4-����') as "����",
(select r1.username from hzrm.rmm_user r1 where r1.usercode=t1.owner) as "������",
(select r2.para_value from hzrm.rmm_para r2 where r2.para_type='2' and r2.para_code=t1.requirementtype) as "����",
t1.planmanhaur as "����",
t1.createtime as "��ȡ����",
t1.enddate as "�ƻ�",
t1.dept as "������",
'����'||nvl(p_ig,'0(+0)')||',����'||nvl(p_ts,'0(+0)')||',����'||nvl(p_cf,'0')||',�����'||nvl(p_cp,'0(+0)/'||nvl(cnt_all,0))||'' as "��Ŀ״̬",
t1.status,
t2.cnt_all,
t2.cnt_ig,
t2.cnt_ts,
t2.cnt_cf,
t2.cnt_cp,
t1.requirementcode,
t1.startdate,
case when t2.cnt_ig<>0 and t1.enddate<to_char(sysdate-to_char(sysdate,'d')+6,'YYYYMMDD') and t1.status<>'4' then 'Y' else 'N' end as yq
  from hzrm.rmm_requirement t1
  left join
  (select xx.requirementid,
  nvl(xx.cnt_all,0) as cnt_all,
  nvl(xx.cnt_cp,0) as cnt_cp,
  nvl(xx.cnt_ts,0) as cnt_ts,
  nvl(xx.cnt_cf,0) as cnt_cf,
  nvl(xx.cnt_all,0)-nvl(xx.cnt_cp,0)-nvl(xx.cnt_ts,0)-nvl(xx.cnt_cf,0) as cnt_ig,
  nvl(xx.cnt_new,0) as cnt_new,
  nvl(xx.new_cp,0) as new_cp,
  nvl(xx.new_ts,0) as new_ts,
xx.cnt_cp||'(+'||xx.new_cp||')/'||xx.cnt_all as p_cp,
xx.cnt_ts||'(+'||xx.new_ts||')'/*||xx.cnt_all*/ as p_ts,
xx.cnt_cf||''/*||'/'||xx.cnt_all*/ as p_cf,
(xx.cnt_all-xx.cnt_cp-xx.cnt_ts-xx.cnt_cf)||'(+'||xx.cnt_new||')'/*||xx.cnt_all*/ as p_ig
 from
(select x.requirementid,
count(*) as cnt_all,
sum(case when x.cd3 between to_char(sysdate-to_char(sysdate,'d')-1,'YYYYMMDD') and to_char(sysdate-to_char(sysdate,'d')+8,'YYYYMMDD')
and not (x.s3<>'4' and x.tasktype not in (2,11,12,13,14) and x.s1 in (3,6)and x.cd1 between to_char(sysdate-to_char(sysdate,'d')-1,'YYYYMMDD') and to_char(sysdate-to_char(sysdate,'d')+8,'YYYYMMDD'))
and not (x.s3<>'4' and x.tasktype in (2,11,12,13,14) and (x.s2 in (1,2) or x.s1 in (3,6) and x.s2 is null) and x.cd1 between to_char(sysdate-to_char(sysdate,'d')-1,'YYYYMMDD') and to_char(sysdate-to_char(sysdate,'d')+8,'YYYYMMDD'))
then 1 else 0 end) as cnt_new,
sum(case
when x.s3='4' then 1
when x.s3<>'4' and x.tasktype not in (2,11,12,13,14) and x.s1 in (3,6) then 1
else 0 end) as cnt_cp,
sum(case
when x.s3='4' and x.cd2 between to_char(sysdate-to_char(sysdate,'d')-1,'YYYYMMDD') and to_char(sysdate-to_char(sysdate,'d')+8,'YYYYMMDD') then 1
when x.s3<>'4' and x.tasktype not in (2,11,12,13,14) and x.s1 in (3,6)and x.cd1 between to_char(sysdate-to_char(sysdate,'d')-1,'YYYYMMDD') and to_char(sysdate-to_char(sysdate,'d')+8,'YYYYMMDD') then 1
else 0 end) as new_cp,
sum(case when x.s3<>'4' and x.tasktype in (2,11,12,13,14) and (x.s2 in (1,2) or x.s1 in (3,6) and x.s2 is null) then 1 else 0 end) as cnt_ts,
sum(case when x.s3<>'4' and x.tasktype in (2,11,12,13,14) and (x.s2 in (1,2) or x.s1 in (3,6) and x.s2 is null) and x.cd1 between to_char(sysdate-to_char(sysdate,'d')-1,'YYYYMMDD') and to_char(sysdate-to_char(sysdate,'d')+8,'YYYYMMDD') then 1 else 0 end) as new_ts,
sum(case when x.s3<>'4' and x.tasktype in (2,11,12,13,14) and x.s2 in (3,4) then 1 else 0 end) as cnt_cf
from
(select t1.requirementid,t1.taskcode,t1.tasktype,t1.status as s1/*����*/,t3.status as s2/*�Ͳ�*/,t4.status as s3/*����*/,t5.cd1,substr(t4.closetime,1,8) as cd2,t1.starttime as cd3
from hzrm.rmm_task t1
left join (select r.taskcode, max(r.applycode) as applycode
from hzrm.rmm_apply_task r
group by r.taskcode) t2 on t1.taskcode = t2.taskcode
left join hzrm.rmm_requirement_apply t3 on t2.applycode = t3.applycode
left join hzrm.rmm_requirement t4 on t4.requirementid=t1.requirementid
left join
(select taskcode,substr(max(logtime),1,8) as cd1 from hzrm.rmm_log where logtext='�������' group by taskcode) t5
on t1.taskcode=t5.taskcode
where t1.tasktype <> '99' and t1.status<>'0'/* and t1.requirementid='2014052211134595516846201213'*/) x
group by x.requirementid) xx) t2
on t1.requirementid=t2.requirementid
 where t1.status <> '4' or t1.requirementcode not like 'T%' and t1.status='4' and t1.closetime between to_char(sysdate-to_char(sysdate,'d')-1,'YYYYMMDD') and to_char(sysdate-to_char(sysdate,'d')+8,'YYYYMMDD')
 order by t1.urgent desc,t1.createtime desc;

prompt
prompt Creating view V_RMM_TASK_SIGNIN
prompt ===============================
prompt
create or replace view v_rmm_task_signin as
select t8.project_name as r_prjname,
       t3.requirementcode as r_no,
       t6.para_value as r_type,
       t3.requirementname as r_name,
       t3.remark as r_remark,
       t3.dept as r_dept,
       t3.presenter as r_presenter,
       decode(t3.urgent, '1', '��ͨ', '2', '��Ҫ') as r_urgent,
       (select r.username from hzrm.rmm_user r where r.usercode = t3.creator) as r_creator,
       t3.createtime as r_createdate,
       t5.username as r_owner,
       t3.startdate as r_startdate,
       substr(t3.confirmclosetime, 1, 8) as r_closedate,
       decode(t3.status,
              '1',
              'δ��ʼ',
              '2',
              '������',
              '3',
              '���',
              '4',
              '�ر�') as r_status,
       t3.planmanhaur as r_planmanhaur,
       t1.taskcode,
       t7.para_value as t_type,
       decode(t2.ISLONGTERM,'1','����','0','�ǳ���') as t_ISLONGTERM,
       t2.taskname as t_name,
       t2.remark as t_remark,
       (select r.username
          from hzrm.rmm_user r
         where r.usercode = t2.usercode) as t_username,
       t2.starttime as t_createtime,
       t2.signtime as t_signdate,
       t2.planmanhaur as t_plan,
       t2.planfinishtime as t_planfinishtime,
       t2.endtime as t_enddate,
       decode(t2.status,
              '1',
              'δ��ʼ',
              '2',
              '������',
              '3',
              '���',
              '6',
              '���',
              '4',
              '����',
              '-1',
              '�ȴ�ǰ������') as t_status,
       decode(t4.myteam, '1', '����', '���') as s_user_type,
       t4.username as s_name,
       t1.createtime as s_signdate,
       t1.manhour as s_manhour,
       t1.othour as s_othour
  from (select taskcode,
               usercode,
               to_char(createtime, 'YYYYMMDD') as createtime,
               MANHOUR,
               OTHOUR,
               rank() over(partition by taskcode, usercode, to_char(createtime, 'YYYYMMDD') order by createtime desc) as rnkno
          from hzrm.rmm_task_signin) t1,
       hzrm.rmm_task t2,
       hzrm.rmm_requirement t3,
       hzrm.rmm_user t4,
       hzrm.rmm_user t5,
       (select * from hzrm.rmm_para t where t.para_type = '2') t6,
       (select * from hzrm.rmm_para t where t.para_type = '1') t7,
       hzrm.rmm_project t8
 where t1.rnkno = 1
   and t2.taskcode = t1.taskcode
   and t2.requirementid = t3.requirementid
   and t2.tasktype <> '99'
   and t3.status <> 0
   and t1.usercode = t4.usercode
   and t3.owner = t5.usercode(+)
   and t3.requirementtype = t6.para_code(+)
   and t2.tasktype = t7.para_code(+)
   and t3.project_code = t8.project_code(+);

prompt
prompt Creating view V_RMM_TASK_STAT
prompt =============================
prompt
create or replace view v_rmm_task_stat as
select x.r_no as "������",
       x.r_name as "��������",
       x.taskcode as "�����",
       x.t_name as "��������",
       x.t_username as "������Ա",
       x.t_ISLONGTERM as "��������������",
       x.t_status as "����״̬",
       m.createtime as "��������",
       x.t_signdate as "ǩ������",
       x.t_planfinishtime as "Ԥ���������",
       x.t_plan as "Ԥ�ƹ�ʱ",
       x.s_manhour1 + x.s_othour1 as "�ƻ���Ͷ�빤ʱ",
       x.s_manhour2 + x.s_othour2 as "�ƻ���Ͷ�빤ʱ",
       decode(x.t_plan,
              0,
              null,
              round((x.s_manhour1 + x.s_othour1) / x.t_plan, 2)) as "�ƻ���/Ԥ�Ʊ���",
       decode(x.t_plan,
              0,
              null,
              round((x.s_manhour1 + x.s_othour1 + x.s_manhour2 + x.s_othour2) /
                    x.t_plan,
                    2)) as "ʵ��/Ԥ�Ʊ���",
       round(decode(x.s_manhour1 + x.s_othour1 + x.s_manhour2 + x.s_othour2,
                    0,
                    0,
                    (x.s_manhour2 + x.s_othour2) /
                    (x.s_manhour1 + x.s_othour1 + x.s_manhour2 + x.s_othour2)),
             2) as "�ƻ���/ʵ�ʱ���",
       x.s_manhour1 as "�ƻ���������ʱ",
       x.s_othour1 as "�ƻ��ڼӰ๤ʱ",
       x.s_manhour2 as "�ƻ���������ʱ",
       x.s_othour2 as "�ƻ���Ӱ๤ʱ",
       decode(x.t_signdate,
              null,
              to_date(to_char(sysdate, 'YYYYMMDD'), 'YYYYMMDD'),
              to_date(x.t_signdate, 'YYYYMMDD')) -
       to_date(m.createtime, 'YYYYMMDD') as "ǩ�ռ������"
  from (select t.r_no,
               t.r_name,
               t.taskcode,
               t.t_name,
               t.t_username,
               t.t_ISLONGTERM,
               t.t_status,
               max(t.t_signdate) as t_signdate,
               max(t.t_planfinishtime) as t_planfinishtime,
               max(t.t_plan) as t_plan,
               round(sum(case
                           when t.t_signdate is not null and
                                t.s_signdate between t.t_signdate and
                                t.t_planfinishtime then
                            t.s_manhour
                           else
                            0
                         end) / 7,
                     2) as s_manhour1,
               round(sum(case
                           when t.t_signdate is not null and
                                t.s_signdate between t.t_signdate and
                                t.t_planfinishtime then
                            t.s_othour
                           else
                            0
                         end) / 7,
                     2) as s_othour1,
               round(sum(case
                           when t.t_signdate is not null and
                                t.s_signdate not between t.t_signdate and
                                t.t_planfinishtime then
                            t.s_manhour
                           else
                            0
                         end) / 7,
                     2) as s_manhour2,
               round(sum(case
                           when t.t_signdate is not null and
                                t.s_signdate not between t.t_signdate and
                                t.t_planfinishtime then
                            t.s_othour
                           else
                            0
                         end) / 7,
                     2) as s_othour2
          from hzrm.v_rmm_task_signin t
         where exists (select 'x'
                  from hzrm.rmm_user r
                 where r.username = t.t_username
                   and r.userstatus = '1')
         group by t.r_no,
                  t.r_name,
                  t.taskcode,
                  t.t_name,
                  t.t_username,
                  t.t_ISLONGTERM,
                  t.t_status) x,
       (select t.taskcode, substr(t.logtime, 1, 8) as createtime
          from rmm_log t
         where t.logtext = '��������') m
 where x.taskcode = m.taskcode(+)
 order by x.t_username,
          decode(x.t_signdate, null, '99999999', x.t_signdate) desc,
          m.createtime;

prompt
prompt Creating view V_TEST_LIST
prompt =========================
prompt
create or replace view v_test_list as
select d.applycode as "�Ͳ��嵥���",
       t.requirementCode as "������",
       t.requirementName as "��������",
       d.applyname as "��Ŀ˵��",
       (select x.username
          from hzrm.rmm_user x
         where x.usercode = d.devprincipal) as "����������",
       d.applytime as "�Ͳ�����",
       d.applydept as "������",
       d.conner as "��������",
       --       d.status
       decode(d.status,
              '1',
              '���Ͳ�',
              '2',
              '���Ͳ�',
              '3',
              '������',
              '4',
              '������') as "�Ͳ�״̬"
  from rmm_requirement t, rmm_requirement_apply d
 WHERE t.requirementId = d.requirementId
 order by d.createTime;

prompt
prompt Creating procedure DOBACKDATA
prompt =============================
prompt
create or replace procedure doBackData(P_O_SUCCEED   OUT VARCHAR2) is
v_sql               varchar2(1000);
begin

  for r in (select * from all_tables@hz66 t where t.owner='SRCC_RMM' )
     loop
        begin
        v_sql := 'DELETE FROM '||r.table_name||'@HZ66';
        execute immediate v_sql;
        v_sql := 'INSERT INTO '||r.table_name||'@HZ66 SELECT * FROM '||r.table_name;
        execute immediate v_sql;
        commit;
        
      exception
      WHEN OTHERS THEN
           dbms_output.put_line('**ERROR LINE:'||dbms_utility.format_error_backtrace());
           dbms_output.put_line('**ERROR CODE:'||SQLCODE);
           dbms_output.put_line('**ERROR INFO:'||SQLERRM);
           rollback;  
      end;
     end loop ;                    

  commit;
  P_O_SUCCEED := 'SUCCESS';
  
  EXCEPTION
  WHEN NO_DATA_FOUND THEN
    NULL;
  WHEN OTHERS THEN
    dbms_output.put_line('**ERROR LINE:'||dbms_utility.format_error_backtrace());
    dbms_output.put_line('**ERROR CODE:'||SQLCODE);
    dbms_output.put_line('**ERROR INFO:'||SQLERRM);
    rollback;
    RAISE;
end doBackData;
/

prompt
prompt Creating procedure DOFINISHTASK
prompt ===============================
prompt
create or replace procedure doFinishTask(P_TASKCODE    IN VARCHAR2,P_STARTDATE   IN VARCHAR2,P_ENDDATE     IN VARCHAR2,P_MANHAUR     IN integer,P_CONFORMCODE IN VARCHAR2,P_O_SUCCEED   OUT VARCHAR2) is
  v_manHaur           integer;
  v_sql               varchar2(1000);
  v_owner             varchar2(100);
  v_totalUnFinishTask number;
  v_oldtask           rmm_task%rowtype;
begin
  --ʵ�ʹ�ʱ
  /*v_manHaur := to_date(P_ENDDATE, 'yyyymmdd')-to_date(P_STARTDATE, 'yyyymmdd')+ 1;*/
  --v_manHaur := P_MANHAUR;
   --dbms_output.put_line(P_TASKCODE);
  select * into v_oldtask from rmm_task where taskcode = P_TASKCODE;

v_manHaur := to_date(P_ENDDATE, 'yyyymmdd')-to_date(v_oldtask.starttime, 'yyyymmdd')+ 1;
 /* select k.owner
    into v_owner
    from rmm_requirement k
   where k.requirementid = v_oldtask.requirementid;*/

  update rmm_task t
     set t.starttime = nvl(P_STARTDATE,t.starttime),
         t.endtime   = P_ENDDATE,
         t.manhaur   = nvl(v_manHaur,t.manhaur),
         t.status    = case when nvl(t.planmanhaur, 0) >= v_manHaur then 3 else 6 end
   where t.taskcode = P_TASKCODE;

  if v_oldtask.tasktype <> 99 then
    insert into rmm_task
      (requirementid,
       taskcode,
       taskname,
       status,
       remark,
       taskgroup,
       tasktype,
       usercode,
       planmanhaur,
       urgent,
       ISLONGTERM,
       creator
       )
    values
      (v_oldtask.requirementid,
       P_CONFORMCODE,
       '(' || v_oldtask.usercode || ')' || v_oldtask.taskname || '-ȷ������',
       -1,
       '�Զ����ȷ������',
       v_oldtask.taskgroup,
       99,
       v_oldtask.creator,
       0,
       1,
       0,
       v_oldtask.usercode);
    insert into rmm_task_dependable
      (taskcode, dependablecode)
    values
      (P_CONFORMCODE, P_TASKCODE);
  end if;

  update rmm_task t
     set t.status = 1
   where exists (select 'x'
            from rmm_task_dependable h
           where h.taskcode = t.taskcode
             and h.dependablecode = P_TASKCODE);

  select count(*)
    into v_totalUnFinishTask
    from rmm_task t1
   WHERE requirementId = v_oldtask.requirementid
     and status in (1, 2, 4, 5, -1);

  if v_totalUnFinishTask = 0 then
    update rmm_requirement t1
       set t1.status = 3
     where exists (select 'x'
              from rmm_task t2
             where t2.taskcode = P_TASKCODE
               and t1.requirementId = t2.requirementId);
  end if;

  commit;
  P_O_SUCCEED := 'SUCCESS';
EXCEPTION
  WHEN NO_DATA_FOUND THEN
    NULL;
  WHEN OTHERS THEN
    dbms_output.put_line('**ERROR LINE:'||dbms_utility.format_error_backtrace());
    dbms_output.put_line('**ERROR CODE:'||SQLCODE);
    dbms_output.put_line('**ERROR INFO:'||SQLERRM);
    rollback;
    RAISE;
end doFinishTask;
/


spool off
