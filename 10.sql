
SET SERVEROUTPUT ON
BEGIN
DBMS_OUTPUT.PUT_LINE('Hello world');
END;



DECLARE
a NUMBER:=11;
b NUMBER:=50;
PI NUMBER(9,8):=3.14159265; 
d NUMBER(7,-2):=1234567.89;
e NUMBER:=0.95E-7 ;
f BOOLEAN := FALSE;
curr_year CONSTANT NUMBER :=TO_NUMBER (TO_CHAR (SYSDATE, 'YYYY'));
author CONSTANT VARCHAR2(100) DEFAULT 'Bazil';
author_sur  CHAR(15) := 'Bazil';
g a%TYPE :=2;
dua DUAL%ROWTYPE;
l  VARCHAR2(100) ;
BEGIN
DBMS_OUTPUT.PUT_LINE('a =' ||a); 
DBMS_OUTPUT.PUT_LINE('b =' ||b); 
DBMS_OUTPUT.PUT_LINE('MOD(50,11)=' ||MOD(b,a)); 
DBMS_OUTPUT.PUT_LINE('MOD(11,50)=' ||MOD(a,b)); 
DBMS_OUTPUT.PUT_LINE('MOD(11.6, 2)=' ||MOD(11.6, 2)); 
DBMS_OUTPUT.PUT_LINE('REMAINDER(11.6, 2)=' ||REMAINDER(11.6, 2)); 
DBMS_OUTPUT.PUT_LINE('POWER(50,11)=' ||POWER(b,a)); 
DBMS_OUTPUT.PUT_LINE('ROUND(123.456,2)' ||ROUND(123.456,2)); 
DBMS_OUTPUT.PUT_LINE('1234567.89(7,-2)=' ||d ); 
DBMS_OUTPUT.PUT_LINE('0.95f =' ||0.95f); 
DBMS_OUTPUT.PUT_LINE('0.95d =' || 0.95d ); 
DBMS_OUTPUT.PUT_LINE('0.95E-7 =' || e); 
DBMS_OUTPUT.PUT_LINE(curr_year ); 
DBMS_OUTPUT.PUT_LINE(author); 
DBMS_OUTPUT.PUT_LINE(author_sur); 
IF author=author_sur THEN
DBMS_OUTPUT.PUT_LINE(author||'(char)'||'='||author||'(varchar)'); 
ELSE	
DBMS_OUTPUT.PUT_LINE(author||'(char)'||'!=' ||author||'(varchar)'); 
END IF;	
DBMS_OUTPUT.PUT_LINE(g ); 
SELECT 2*4 INTO dua FROM DUAL;
 DBMS_OUTPUT.PUT_LINE(dua.DUMMY); 
 
 SELECT OWNER INTO l FROM all_tables  WHERE table_name = 'LOB$' ;
CASE l
  WHEN 'SYS' THEN DBMS_OUTPUT.PUT_LINE('The owner is SYS');
  WHEN 'SYSTEM' THEN DBMS_OUTPUT.PUT_LINE('The owner is SYSTEM');
  ELSE DBMS_OUTPUT.PUT_LINE( 'The owner is another value');
END CASE;

DBMS_OUTPUT.PUT_LINE('a =' ||a); 
DBMS_OUTPUT.PUT_LINE('b =' ||b); 

CASE
WHEN b BETWEEN 40 AND 50 THEN a:=a+5;
WHEN b BETWEEN 50 AND 60 THEN a:=a+10;
ELSE a:=a;
END CASE;
DBMS_OUTPUT.PUT_LINE('a =' ||a); 


CASE
WHEN b >= 50 THEN
CASE
WHEN b <= 55 THEN
a:=a+20;
WHEN b > 70 THEN
a:=a-10;
WHEN b =60 THEN
a:=a+1;
END CASE;
WHEN b < 20 THEN
a:=a;
END CASE;
DBMS_OUTPUT.PUT_LINE('a =' ||a); 
END;

DECLARE
boolean_true BOOLEAN := TRUE;
boolean_false BOOLEAN := FALSE;
boolean_null BOOLEAN;
FUNCTION boolean_to_varchar2 (flag IN BOOLEAN) RETURN VARCHAR2 IS
BEGIN
RETURN
CASE flag
WHEN TRUE THEN 'True'
WHEN FALSE THEN 'False'
ELSE 'NULL'
END;
END;
BEGIN
DBMS_OUTPUT.PUT_LINE(boolean_to_varchar2(boolean_true));
DBMS_OUTPUT.PUT_LINE(boolean_to_varchar2(boolean_false));
DBMS_OUTPUT.PUT_LINE(boolean_to_varchar2(boolean_null));
END;

DECLARE
	i NUMBER := 0;	
BEGIN
	LOOP			
	i := i + 1;
    DBMS_OUTPUT.put_line(i);	
	IF (i >= 10) THEN
		i := 0;
		EXIT;		
	END IF;
	END LOOP;	
    END;



BEGIN
	DBMS_OUTPUT.enable;
	FOR i IN REVERSE 1..10 LOOP
	DBMS_OUTPUT.put_line(TO_CHAR(i)||'-');		
	END LOOP;
	DBMS_OUTPUT.put_line('Blastoff!');		
END;

DECLARE
	k NUMBER := 0;	
BEGIN
	WHILE (k < 10) LOOP
		k := k + 1;
     DBMS_OUTPUT.put_line(k);	   
	END LOOP;
DBMS_OUTPUT.put_line('Blastoff!');		
END;

BEGIN
DBMS_OUTPUT.PUT_LINE(SQLERRM(-1403));
END;

create table t1(a number);
declare a number;
    begin a := 1/0;
    exception when others then
          a := sqlcode;
          insert into t1 values(a);
    end;
    select * from t1;

DECLARE
string_of_5_chars VARCHAR2(5);
BEGIN
BEGIN
    string_of_5_chars := 'Steven';  
    EXCEPTION
    WHEN value_error THEN    
      RAISE no_data_found;   
    WHEN no_data_found THEN
      dbms_output.Put_line ('Inner block');
END;
EXCEPTION
WHEN no_data_found THEN
  dbms_output.Put_line ('Outer block'); -- Exception is handled here which causes it to print 'Outer Block'
END;
