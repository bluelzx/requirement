create table RMM_FILE
(
  FILECODE        VARCHAR2(30) not null,
  FILENAME        VARCHAR2(200),
  FILEPATH        VARCHAR2(200),
  UPLOADTIME      VARCHAR2(30),
  USERCODE        VARCHAR2(30),
  REQUIREMENTCODE VARCHAR2(30),
  FILESIZE        INTEGER,
  FILETYPE        VARCHAR2(30)
)