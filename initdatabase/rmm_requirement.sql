create table RMM_REQUIREMENT
(
  REQUIREMENTCODE VARCHAR2(50) not null,
  REQUIREMENTNAME VARCHAR2(100),
  REMARK          VARCHAR2(500),
  CREATETIME      VARCHAR2(30),
  CREATOR         VARCHAR2(30),
  STARTDATE       VARCHAR2(30),
  ENDDATE         VARCHAR2(30),
  STATUS          INTEGER,
  DEPT            VARCHAR2(30),
  PRESENTER       VARCHAR2(30),
  PARENTCODE      VARCHAR2(50),
  CLOSETIME       VARCHAR2(30),
  REQUIREMENTTYPE INTEGER
)