SELECT a.name, a.value  FROM v$parameter a
ORDER BY a.name;


connect BAZ/qwerty@localhost:1521/pdb_a ;

SELECT TABLESPACE_NAME FROM DBA_TABLESPACES;
SELECT USERNAME FROM DBA_USERS;
SELECR ROLE FROM DBA_ROLES;

SELECT * FROM USER_SEGMENTS ;
SELECT table_name FROM user_tables;
CREATE VIEW BAZ_VIEW3 AS SELECT count(*)  kolichestvosegments, sum(EXTENTS) kolichestvoextents,SUM(BLOCKS) kolichestvobloks,SUM(BYTES) vesblocksvbaits FROM USER_SEGMENTS ;
SELECT * FROM BAZ_VIEW3;
drop VIEW BAZ_VIEW3;