GRANT CREATE SEQUENCE to BAZ;
GRANT SELECT ANY SEQUENCE to BAZ;
ALTER USER BAZ QUOTA UNLIMITED ON USERS;
GRANT CREATE CLUSTER to BAZ;
GRANT CREATE PUBLIC SYNONYM to BAZ;
GRANT CREATE MATERIALIZED VIEW TO BAZ;
GRANT DROP PUBLIC SYNONYM to BAZ;

CREATE SEQUENCE S1
START WITH 1000
INCREMENT BY 10
NOCYCLE
NOORDER
NOCACHE ;

SELECT S1.nextval   FROM dual;
  
SELECT S1.CURRVAL  FROM DUAL;
-----------------------------------------------------------------------------
CREATE SEQUENCE S2
START WITH 10
INCREMENT BY 10
MAXVALUE 100
NOCYCLE
NOORDER
NOCACHE ;

SELECT S2.nextval   FROM dual;

SELECT S2.CURRVAL  FROM DUAL;

alter SEQUENCE S2 increment by -90;
  
alter SEQUENCE  S2 increment by 10;
------------------------------------------------------------------------------
CREATE SEQUENCE S3
START WITH 10
INCREMENT BY -10
MINVALUE -100
MAXVALUE 100
NOCYCLE
ORDER
NOCACHE ;

SELECT S3.nextval  FROM dual;

SELECT s3.CURRVAL  FROM DUAL;

alter SEQUENCE S3 increment by 90;
  
alter SEQUENCE  S3 increment by -10;
-------------------------------------------------------------------------------
CREATE SEQUENCE S4
START WITH 1
INCREMENT BY 1
MAXVALUE 10
CYCLE
NOORDER
CACHE 5 ;

SELECT S4.nextval  FROM dual;

SELECT S4.CURRVAL  FROM DUAL;
--------------------------------------------------------------------------------
SELECT * FROM all_sequences WHERE sequence_owner='BAZ';
--------------------------------------------------------------------------------
CREATE TABLE T1(N1 NUMBER (20),
                N2 NUMBER (20),
                N3 NUMBER (20),
                N4 NUMBER (20));
alter table T1 storage (buffer_pool keep);

INSERT INTO T1(N1)
  VALUES(S1.CURRVAL);
  
  INSERT INTO T1(N1)
  VALUES(S1.nextval);
  
INSERT INTO T1(N2)
  VALUES(S2.CURRVAL);
  
  INSERT INTO T1(N2)
  VALUES(S2.nextval);
  
  
  INSERT INTO T1(N3)
  VALUES(S3.CURRVAL);
  
    INSERT INTO T1(N3)
  VALUES(S3.NEXTVAL);
  
  INSERT INTO T1(N4)
  VALUES(S4.CURRVAL);
  
    INSERT INTO T1(N4)
  VALUES(S4.NEXTVAL);
  
   INSERT INTO T1(N1,N2,N3,N4)
    VALUES(S4.NEXTVAL,S2.NEXTVAL,S3.NEXTVAL,S4.NEXTVAL);
    
 SELECT * from T1;
-----------------------------------------------------------------------------
CREATE CLUSTER ABC (X NUMBER(10), V VARCHAR2(12))
 HASHKEYS 200;

CREATE TABLE A(XA NUMBER (10),
               VA VARCHAR2(12), 
               NA NUMBER (20))
CLUSTER  ABC (XA,VA); 
                  
 CREATE TABLE B(XB NUMBER (10),
                VB VARCHAR2(12), 
                NB NUMBER (20))
CLUSTER  ABC (XB,VB); 
                  
CREATE TABLE C(XC NUMBER (10),
                VC VARCHAR2(12), 
                NC NUMBER (20))
CLUSTER  ABC (XC,VC); 

       begin
      for i in 1..100 loop
         insert into A(XA,VA,NA) values (i+1,i+1,i+1);
      end loop;
end;

       begin
      for i in 23500..123500 loop
         insert into A(XA,VA,NA) values (i+1,i+1,i+1);
      end loop;
end;

SELECT * from A;

       begin
    for i in 23500..123500 loop
         insert into B(XB,VB,NB) values (i+1,i+1,i+1);
      end loop;
end;
SElect count(*) from B;
       begin
      for i in 23500..123500 loop
         insert into C(XC,VC,NC) values (i+1,i+1,i+1);
      end loop;
end;



set timing on;
SELECT * FROM A UNION SELECT * FROM B 
UNION SELECT * FROM C;

CREATE TABLE D(XC NUMBER (10),
                VC VARCHAR2(12), 
                NC NUMBER (20))
                
                CREATE TABLE F(XC NUMBER (10),
                VC VARCHAR2(12), 
                NC NUMBER (20))
                
                CREATE TABLE E(XC NUMBER (10),
                VC VARCHAR2(12), 
                NC NUMBER (20))
                
                
               begin
        for i in 23500..123500 loop
         insert into D(XC,VC,NC) values (i+1,i+1,i+1);
      end loop;
end;

       begin
    for i in 23500..123500 loop
         insert into F(XC,VC,NC) values (i+1,i+1,i+1);
      end loop;
end;


       begin
      for i in 23500..123500 loop
         insert into E(XC,VC,NC) values (i+1,i+1,i+1);
      end loop;
end; 
 Select * from E;               
                
set timing on;
SELECT * FROM D UNION SELECT * FROM F
UNION SELECT * FROM E;


SELECT * FROM all_clusters ;          
--------------------------------------------------------------------------------------------------
CREATE PUBLIC SYNONYM C FOR BAZ.C;
SELECT * FROM C;

DROP PUBLIC SYNONYM C;

create synonym mydual for DUAL;
SELECT * FROM mydual;

grant select on mydual to system;
------------------------------------------------------------------------------------------------------
create table t_users (
t_id number(11),
t_nick varchar(16),
primary key (t_id) )

create table t_resources (
t_id number(11, 0),
t_name varchar(16),
t_userid number (11),
primary key (t_id) )

ALTER TABLE t_resources
ADD CONSTRAINT fk_t_resources
  FOREIGN KEY (t_userid)
  REFERENCES t_users(t_id);



    INSERT INTO t_users(t_id,t_nick)  VALUES(1,'A');
      INSERT INTO t_users(t_id,t_nick) VALUES(2,'B');
      INSERT INTO t_users(t_id,t_nick) VALUES(3,'C');

   INSERT INTO  t_resources(t_id,t_name,t_userid) VALUES(10,'vk.com',1);
   INSERT INTO  t_resources(t_id,t_name,t_userid) VALUES(11,'facebook.com',2);
   INSERT INTO  t_resources(t_id,t_name,t_userid) VALUES(12,'twitter.com',3);

CREATE VIEW BAZ_VIEW AS SELECT u.t_id ,u.t_nick,r.t_id as resours_id ,r.t_name
FROM  t_users u inner join t_resources r  ON u.t_id = r.t_userid; 

SELECT * FROM BAZ_VIEW;

-------------------------------------------------------------------------------------------------------------
Create table temp (A int);

Create Materialized view temp_mv
      refresh complete start with (sysdate) next  (sysdate+1/1440) 

        as select * from temp;
        
        begin
      for i in 1..10 loop
         insert into temp values (i+1);
      end loop;
end;

commit;

select count(*) from temp;
select count(*) from temp_mv;
select to_char(sysdate,'hh:mi') from dual;

drop table temp;
Drop Materialized view temp_mv;



