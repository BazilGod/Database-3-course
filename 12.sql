SET serveroutput ON;
SELECT * FROM TEACHER;

UPDATE TEACHER
SET BIRTHDAY='12.12.1999'
WHERE TEACHER='”–¡';

UPDATE TEACHER
SET BIRTHDAY='23.06.1969'
WHERE TEACHER='¿ Õ¬◊';

UPDATE TEACHER
SET BIRTHDAY='03.12.1968'
WHERE TEACHER='Õ¬–¬';

-------------------------------------------------------------------------------------------------------------------------
SELECT *
FROM TEACHER
WHERE TO_CHAR((BIRTHDAY), 'DAY')='œŒÕ≈ƒ≈À‹Õ» ';
-------------------------------------------------------------------------------------------------------------------------
CREATE VIEW NextMonthBirth AS
SELECT *
FROM TEACHER
WHERE TO_CHAR(sysdate,'mm')+1 = TO_CHAR(BIRTHDAY, 'mm');

SELECT * FROM NextMonthBirth;
-------------------------------------------------------------------------------------------------------------------------
CREATE VIEW NumberTeachersMonths AS
SELECT to_char(TBIRTHDAY, 'Month', 'nls_date_language=russian') ÃÂÒˇˆ ,to_char(TBIRTHDAY, 'yyyy') √Ó‰, count(*) œÂÔÓ‰‡‚‡ÚÂÎÂÈ
 FROM (select trunc(BIRTHDAY, 'MM') as TBIRTHDAY FROM TEACHER )  
 GROUP BY TBIRTHDAY
 ORDER BY TBIRTHDAY;

SELECT * FROM NumberTeachersMonths;

DROP VIEW NumberTeachersMonths;
-------------------------------------------------------------------------------------------------------------------------
CURSOR TeacherBirtday(TEACHER%ROWTYPE) 
    RETURN TEACHER%ROWTYPE IS
    SELECT * FROM TEACHER WHERE MOD((TO_CHAR(sysdate,'yyyy') - TO_CHAR(BIRTHDAY, 'yyyy')+1), 10)=0;
-------------------------------------------------------------------------------------------------------------------------
CURSOR tAvgSalary(TEACHER.SALARY%TYPE,TEACHER.PULPIT%TYPE) 
  RETURN TEACHER.SALARY%TYPE,TEACHER.PULPIT%TYPE  IS
    SELECT FLOOR(AVG(SALARY)), PULPIT
    FROM TEACHER
    GROUP BY PULPIT;
  
   select decode(grouping( T.PULPIT),0,to_char(T .PULPIT),'Ù‡ÍÛÎ¸ÚÂÚ À’‘') PULPIT , FLOOR(AVG(SALARY))
   FROM TEACHER T, PULPIT P,FACULTY F
WHERE T.PULPIT = P.PULPIT AND P.FACULTY='À’‘'
   group by rollup(T.PULPIT); 

    select pulpit,avg(salary) over (partition by pulpit order by salary) as num from TEACHER
    
    
    
-------------------------------------------------------------------------------------------------------------------------    
SELECT round(AVG(T.SALARY),3),P.FACULTY
FROM TEACHER T
INNER JOIN PULPIT P
ON T.PULPIT = P.PULPIT
GROUP BY P.FACULTY
UNION
  SELECT FLOOR(AVG(SALARY)), TEACHER.PULPIT
    FROM TEACHER
    GROUP BY TEACHER.PULPIT
ORDER BY FACULTY;






SELECT round(AVG(SALARY),3) FROM TEACHER;
-------------------------------------------------------------------------------------------------------------------------  
DECLARE
  TYPE PERSON IS RECORD
    (
      PULP NVARCHAR2(50),
      NAME NVARCHAR2(50)
    );
  rec2 PERSON;
BEGIN
  SELECT  TEACHER_NAME, PULPIT INTO rec2
  FROM TEACHER
  WHERE TEACHER='∆À ';
  DBMS_OUTPUT.PUT_LINE(rec2.PULP||' '||rec2.NAME);
END;

DECLARE
    TYPE ADDRESS IS RECORD
    (
      TOWN NVARCHAR2(20),
      COUNTRY NVARCHAR2(20)
    );
    TYPE PERSON IS RECORD
    (
      NAME TEACHER.TEACHER_NAME%TYPE,
      PULP TEACHER.PULPIT%TYPE,
      homeAddress ADDRESS
    );
  per1 PERSON;
  per2 PERSON;
BEGIN
  SELECT TEACHER_NAME, PULPIT INTO per1.NAME, per1.PULP
  FROM TEACHER
  WHERE TEACHER='–ÃÕ ';
  per1.homeAddress.TOWN := 'Polotsk';
  per1.homeAddress.COUNTRY := 'Belarus';
  per2 := per1;
  DBMS_OUTPUT.PUT_LINE(per2.NAME||' '||per2.PULP||' ËÁ '||per2.homeAddress.TOWN||' '||per2.homeAddress.COUNTRY);
END;
-------------------------------------------------------------------------------------------------------------------------
SELECT regexp_substr(TEACHER_NAME,'(\S+)',1, 1)||' '||
      SUBSTR(regexp_substr(TEACHER_NAME,'(\S+)',1, 2),1, 1)||'. '||
      SUBSTR(regexp_substr(TEACHER_NAME,'(\S+)',1, 3),1, 1)||'. ' as name
FROM TEACHER;