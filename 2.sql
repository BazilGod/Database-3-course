--1.Создайте табличное пространство для постоянных данных 
CREATE TABLESPACE TS_IBS6 DATAFILE 'TS_IBS6' 
SIZE 7M REUSE AUTOEXTEND ON NEXT 5M MAXSIZE 20M;  

--2.Создайте табличное пространство для временных данных 
CREATE TEMPORARY TABLESPACE TS_IBS_TEMP6 TEMPFILE 'TS_IBS_TEMP6'
SIZE 5M REUSE AUTOEXTEND ON NEXT 3M MAXSIZE 30M;

--3.Получите список всех табличных пространств, списки всех файлов с помощью select-запроса к словарю.
SELECT * FROM DBA_TABLESPACES ;


--4.Создайте роль с именем RL_XXXCORE
create role RL_IBSCORE6;
commit;

--Назначьте ей следующие системные привилегии:
GRANT CREATE SESSION,
      CREATE TABLE,
      CREATE VIEW,
      CREATE PROCEDURE TO RL_IBSCORE6;

--5.Найдите с помощью select-запроса роль в словаре. Найдите с помощью select-запроса все системные привилегии, назначенные роли
SELECT * FROM SYS.DBA_SYS_PRIVS WHERE GRANTEE = 'RL_IBSCORE6';

--6.Создайте профиль безопасности с именем PF_XXXCORE, имеющий опции, аналогичные примеру из лекции.
CREATE PROFILE PF_IBSCORE6 LIMIT
      PASSWORD_LIFE_TIME 180
      SESSIONS_PER_USER 3
      FAILED_LOGIN_ATTEMPTS 7
      PASSWORD_LOCK_TIME 1
      PASSWORD_REUSE_TIME 10
      PASSWORD_GRACE_TIME DEFAULT
      CONNECT_TIME 180
      IDLE_TIME 30;
      
--7.Получите список всех профилей БД. Получите значения всех параметров профиля PF_XXXCORE. Получите значения всех параметров профиля DEFAULT.
SELECT * FROM SYS.DBA_PROFILES;

SELECT * FROM SYS.DBA_PROFILES WHERE PROFILE = 'PF_IBSCORE6';

SELECT * FROM SYS.DBA_PROFILES WHERE PROFILE = 'DEFAULT';

--8.Создайте пользователя с именем XXXCORE со следующими параметрами
CREATE USER IBSCORE6 IDENTIFIED BY 12345
      DEFAULT TABLESPACE TS_IBS6
      TEMPORARY TABLESPACE TS_IBS_TEMP6
      PROFILE PF_IBSCORE6
      ACCOUNT UNLOCK
      PASSWORD EXPIRE;

GRANT CREATE SESSION,CREATE TABLESPACE, ALTER TABLESPACE,
      CREATE TABLE, to IBSCORE6;

--9.Создайте табличное пространство с именем XXX_QDATA (10m). При создании установите его в состояние offline
create tablespace IBS_QDATA6 OFFLINE
datafile 'D:\IBS_QDATA5.txt'
size 10M reuse
autoextend on next 5M
maxsize 20M;
--10.Затем переведите табличное пространство в состояние online.
alter tablespace IBS_QDATA6 ONLINE;

--11.Выделите пользователю XXX квоту 2m в пространстве XXX_QDATA

ALTER USER IBSCORE6  QUOTA 2M ON IBS_QDATA6


--12.От имени пользователя XXX создайте таблицу в пространстве XXX_T1. В таблицу добавьте 3 строки.
CREATE TABLE t (c NUMBER);

INSERT INTO t(c) VALUES(3);
INSERT INTO t(c) VALUES(1);
INSERT INTO t(c) VALUES(2);

SELECT * FROM t;
      
      
      
      
      
    SELECT USERNAME,ACCOUNT_STATUS,EXPIRY_DATE FROM dba_users WHERE USERNAME LIKE '%IBS%';
ALTER USER IBSCORE6 ACCOUNT UNLOCK;
ALTER USER IBSCORE6 IDENTIFIED BY qwerty;
GRANT INSERT ON IBSCORE6.t TO IBSCORE6;

-- Список всех существующих табличных пространств
select * from v$tablespace;
--------------------
SELECT *
FROM DBA_PROFILES
WHERE PROFILE = 'DEFAULT'

----------------------------
SELECT resource_name, LIMIT
FROM DBA_PROFILES. 
          INNER JOIN 
WHERE PROFILE = 'PF_IBSCORE6' INNER JOIN 
AND resource_name != 'COMPOSITE_LIMIT
AND resource_name != 'CPU_PER_SESSION'
AND resource_name != 'CPU_PER_CALL'
AND resource_name != 'LOGICAL_READS_PER_SESSION'
AND resource_name != 'LOGICAL_READS_PER_CALL'
AND resource_name != 'PRIVATE_SGA'
AND resource_name != 'PASSWORD_REUSE_MAX'
AND resource_name != 'PASSWORD_VERIFY_FUNCTION'
AND resource_name != 'INACTIVE_ACCOUNT_TIME'
AND resource_name != 'PASSWORD_LIFE_TIME'

----------------------
 PASSWORD_LIFE_TIME 180
      SESSIONS_PER_USER 3
      FAILED_LOGIN_ATTEMPTS 7
      PASSWORD_LOCK_TIME 1
      PASSWORD_REUSE_TIME 10
      PASSWORD_GRACE_TIME DEFAULT
      CONNECT_TIME 180
      IDLE_TIME 30;
--------------------------
COMPOSITE_LIMIT
SESSIONS_PER_USER
CPU_PER_SESSION
CPU_PER_CALL
LOGICAL_READS_PER_SESSION
LOGICAL_READS_PER_CALL
IDLE_TIME
CONNECT_TIME
PRIVATE_SGA
FAILED_LOGIN_ATTEMPTS
PASSWORD_LIFE_TIME
PASSWORD_REUSE_TIME
PASSWORD_REUSE_MAX
PASSWORD_VERIFY_FUNCTION
PASSWORD_LOCK_TIME
PASSWORD_GRACE_TIME
INACTIVE_ACCOUNT_TIME
-------------------------------------------
-- Список табличных пространств, занятых объектами пользователя
select tablespace_name from user_tables union select tablespace_name from user_indexes;