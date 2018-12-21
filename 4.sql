--1 Получите список всех существующих PDB в рамках экземпляра ORA12W
select name,open_mode from v$pdbs; 

--2 Выполните запрос к ORA12W, позволяющий получить перечень экземпляров.
select INSTANCE_NAME from v$instance;

-- 3 Выполните запрос к ORA12W, позволяющий получить перечень установленных компонентов СУБД Oracle 12c и их версии и статус. 
select * from PRODUCT_COMPONENT_VERSION;

--4 Создайте собственный экземпляр PDB 

--5 Получите список всех существующих PDB в рамках экземпляра ORA12W. 
select name,open_mode from v$pdbs; 

--6 Подключитесь к XXX_PDB c помощью SQL Developer создайте инфраструктурные объекты 
CREATE TABLESPACE TS_IBS_1
DATAFILE 'D:\TS_IBS_1.dbf' size 7M
AUTOEXTEND ON NEXT 5M 
MAXSIZE 20M
LOGGING
ONLINE;
commit;

CREATE TABLESPACE TS_IBS_2 DATAFILE 'TS_IBS_2' 
SIZE 7M REUSE AUTOEXTEND ON NEXT 5M MAXSIZE 20M;  

drop TABLESPACE TS_IBS_2 INCLUDING CONTENTS;
commit;


SELECT * FROM DBA_TABLESPACES ;
select TABLESPACE_NAME, BLOCK_SIZE, MAX_SIZE from sys.dba_tablespaces order by tablespace_name;

CREATE TEMPORARY TABLESPACE TS_IBS_TEMP_11
TEMPFILE 'D:\TS_IBS_TEMP.dbf' size 5M
AUTOEXTEND ON NEXT 3M 
MAXSIZE 30M;
commit;


select file_name, tablespace_name, status , maxbytes, user_bytes  from dba_data_files where file_name = 'D:\TS_IBS_TEMP.dbf';

create role RLIBS;
commit;

GRANT CREATE SESSION,
      CREATE TABLE,
      CREATE VIEW,
      CREATE PROCEDURE TO  RLIBS;

create profile PFGS limit
password_life_time 180 -- кол-во дней жизни пароля
sessions_per_user 3 -- кол-во сессий для пользователя
FAILED_LOGIN_ATTEMPTS 7 -- кол-во попыток входа
PASSWORD_LOCK_TIME 1 -- кол-во дней блокировки после ошибки
PASSWORD_Reuse_time 10 -- через сколько дней можно повторить пароль
password_grace_time default -- кол-во дней предупреждения о смене пароля
connect_time 180 -- время соединения
idle_time 30; -- простой
commit;
Select *  from v&PDBs;
create user U1_IBS_PDB identified by 12345678
default tablespace TS_IBS_1 quota unlimited on TS_IBS_1
profile PFGS
account unlock;
grant RLIBS to U1_IBS_PDB;
commit;
GRANT SELECT ON V_$SESSION TO  to U1_IBS_PDB;
--7 Подключитесь к пользователю U1_XXX_PDB, с помощью SQL Developer, создайте таблицу XXX_table, добавьте в нее строки, выполните SELECT-запрос к таблице.
create table IBS_t (x number(3), s varchar2(50)) ;
commit;

insert into IBS_t (x, s) values (1, 'first');
insert into IBS_t (x, s) values (2, 'second');
insert into IBS_t (x, s) values (3, 'third');
commit;

select * from IBS_t;


--8 С помощью представлений словаря базы данных определите, все табличные пространства, все  файлы (перманентные и временные), все роли (и выданные им привилегии), 
              --профили безопасности, всех пользователей  базы данных XXX_PDB и  назначенные им роли
              
select * from ALL_USERS;  --все пользователи
select * from DBA_TABLESPACES;  --все таб. простр
select * from DBA_DATA_FILES;   --перман данные 
select * from DBA_TEMP_FILES;  --времен данные
select * from DBA_ROLES; --роли
select GRANTEE, PRIVILEGE from DBA_SYS_PRIVS;  --привилег
select * from DBA_PROFILES;  --профил без.
select * from ALL_USERS;  --все пользователи
select * from DBA_TABLESPACES;  --все таб. простр

-- 9 Подключитесь  к CDB-базе данных, создайте общего пользователя с именем C##XXX, назначьте ему привилегию, позволяющую подключится к базе данных XXX_PDB
create user C##IBS identified by 12345678
account unlock;
grant create session to  C##IBS

select * from v$session where USERNAME is not null;

--10 Подключитесь к пользователю U1_XXX_PDB со своего компьютера, а к пользователям C##XXX и C##YYY с другого (к XXX_PDB-базе данных). 

SELECT username
FROM v$session
WHERE username IS NOT NULL

--11-12 Продемонстрируйте преподавателю, работоспособную PDB-базу данных и созданную инфраструктуру

CREATE role IBS_1;
GRANT CREATE TABLE,
      CREATE VIEW,
      CREATE PROCEDURE,
      CREATE SESSION TO IBS_1;

CREATE USER BAZ IDENTIFIED BY qwerty
PROFILE DEFAULT
ACCOUNT UNLOCK;

GRANT  IBS_1 TO BAZ;
GRANT SELECT ON DBA_SOURCE TO BAZ;
grant create session to BAZ;
select * from ALL_USERS;