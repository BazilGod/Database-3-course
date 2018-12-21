SELECT tablespace_name, contents FROM DBA_TABLESPACES;

DROP TABLESPACE BAZ_QDATA; 

CREATE TABLESPACE BAZ_QDATA
  DATAFILE 'D:\5sem\Databases\Labs\5\BAZ_QDATA.dbf'
  SIZE 10 M
  OFFLINE
  
ALTER TABLESPACE BAZ_QDATA ONLINE

ALTER DATABASE DEFAULT TABLESPACE USERS ;

ALTER USER BAZ
QUOTA 2 m ON BAZ_QDATA

--user BAZ
CREATE TABLE Example_table(
id number(15) PRIMARY KEY,
name varchar2(10));

DROP TABLE Example_table;


INSERT INTO Example_table values(1, 'BAZ');
INSERT INTO Example_table values(2, 'IBS');
INSERT INTO Example_table values(3, 'SRG');


SELECT owner, segment_name, segment_type, tablespace_name, bytes, blocks, buffer_pool
FROM DBA_SEGMENTS
WHERE tablespace_name='BAZ_QDATA';

--таблица при удалении не сразу освобождают занятое пространство
--а поначалу переименовывается сегмент и помещается в корзину с возможностью восстановления
--безвозвратно с первого раза - PURGE
SELECT * FROM USER_RECYCLEBIN;

FLASHBACK TABLE  Example_table TO BEFORE DROP;


BEGIN
  FOR k IN 4..10004
  LOOP
    INSERT INTO Example_table VALUES(k, 'A');
  END LOOP;
  COMMIT;
END;

SELECT * FROM DBA_EXTENTS
WHERE TABLESPACE_NAME='BAZ_QDATA';


DROP TABLESPACE BAZ_QDATA INCLUDING CONTENTS AND DATAFILES;


  
SELECT group#, sequence#, bytes, members, status, first_change# FROM V$LOG;

SELECT * FROM V$LOGFILE;
ALTER SYSTEM SWITCH LOGFILE;
ALTER DATABASE ADD LOGFILE GROUP 4 'D:\APP\BAZIL\VIRTUAL\ORADATA\ORCL\REDO04.LOG' 
SIZE 50 m BLOCKSIZE 512;
ALTER DATABASE ADD LOGFILE MEMBER 'D:\APP\BAZIL\VIRTUAL\ORADATA\ORCL\REDO041.LOG'  TO GROUP 4;
ALTER DATABASE ADD LOGFILE MEMBER 'D:\APP\BAZIL\VIRTUAL\ORADATA\ORCL\REDO042.LOG'  TO GROUP 4;

ALTER DATABASE DROP LOGFILE MEMBER 'D:\APP\BAZIL\VIRTUAL\ORADATA\ORCL\REDO042.LOG' ;
ALTER DATABASE DROP LOGFILE MEMBER 'D:\APP\BAZIL\VIRTUAL\ORADATA\ORCL\REDO041.LOG' ;

ALTER DATABASE DROP LOGFILE GROUP 4;


SELECT NAME, LOG_MODE FROM V$DATABASE;
SELECT INSTANCE_NAME, ARCHIVER, ACTIVE_STATE FROM V$INSTANCE;


--connect /as sysdba


--shutdown immediate;
--startup mount;

alter database archivelog;
alter database open;


SELECT * FROM V$ARCHIVED_LOG;
SELECT NAME, FIRST_CHANGE#, NEXT_CHANGE# FROM V$ARCHIVED_LOG;

ARCHIVE LOG LIST;
SHOW PARAMETER DB_RECOVERY;
show parameter log;

ALTER SYSTEM SET LOG_ARCHIVE_DEST_1 ='LOCATION=D:\app\Bazil\virtual\oradata\orcl\archive'

ALTER SYSTEM archive LOG CURRENT;
SELECT log_mode FROM v$database;
 
--shutdown immediate;
--startup mount;
alter database noarchivelog;
 alter database open;
 alter pluggable database all open;
 
SELECT NAME FROM V$CONTROLFILE;
SHOW PARAMETER CONTROL;

ALTER DATABASE BACKUP CONTROLFILE TO TRACE;
show parameter spfile ;
CREATE PFILE = 'BAZ_PFILE.ora' FROM SPFILE;

  SELECT DECODE(value, NULL, 'PFILE', 'SPFILE') "Init File Type" 
          FROM sys.v_$parameter WHERE name = 'spfile';

SELECT * FROM V$PWFILE_USERS;
SELECT * FROM V$DIAG_INFO;


alter database backup controlfile to trace;
select value from v$diag_info where name = 'Default Trace File';
