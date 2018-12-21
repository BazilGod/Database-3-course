SET SERVEROUTPUT ON;
grant create  trigger to BAZ;
ALTER SESSION SET nls_date_format='dd-mm-yyyy hh24:mi:ss';

CREATE TABLE tabl(a int primary key,b varchar(30));

DECLARE 
    i int :=0;
BEGIN
    WHILE i<10
LOOP
    INSERT INTO tabl(a,b)
    values (i,'a');
    i:= i+1;
END LOOP;
END;

SELECT * FROM tabl;

CREATE OR REPLACE TRIGGER Input_trigger
after insert on tabl
BEGIN
    dbms_output.put_line('Insert trigger after activate');
END;

CREATE OR REPLACE TRIGGER Delete_trigger
after delete on tabl
BEGIN
    dbms_output.put_line('Delete trigger after  activate');
END;

CREATE OR REPLACE TRIGGER Update_trigger
after update on tabl
BEGIN
    dbms_output.put_line('Update trigger after  activate');
END;

CREATE OR REPLACE TRIGGER Input_for_each_trigger
after insert on tabl
for each row
BEGIN
    dbms_output.put_line('Input_for_each_trigger after activate');
END;

CREATE OR REPLACE TRIGGER Update_for_each_trigger
after update on tabl
for each row
BEGIN
    dbms_output.put_line('Update_for_each_trigger after activate');
END;

CREATE OR REPLACE TRIGGER Delete_for_each_trigger
after delete on tabl
for each row
BEGIN
    dbms_output.put_line('Delete_for_each_trigger after activate');
END;
----------------------------------------------------------------------------------------------------------------
CREATE OR REPLACE TRIGGER Trigger_ing
after insert or update  or delete on tabl
BEGIN
IF INSERTING then
    dbms_output.put_line('Inserting after');
ELSIF UPDATING then
    dbms_output.put_line('Updating after');
ELSIF DELETING then
    dbms_output.put_line('Deleting after');
END IF;
END;
----------------------------------------------------------------------------------------------------------------
CREATE OR REPLACE TRIGGER Input_trigger_before
before insert on tabl
BEGIN
    dbms_output.put_line('Insert trigger before activate');
END;

CREATE OR REPLACE TRIGGER Delete_trigger_before
before delete on tabl
BEGIN
    dbms_output.put_line('Delete trigger before  activate');
END;

CREATE OR REPLACE TRIGGER Update_trigger_before
before update on tabl
BEGIN
    dbms_output.put_line('Update trigger before  activate');
END;

CREATE OR REPLACE TRIGGER Input_for_each_trigger_before
before insert on tabl
for each row
BEGIN
    dbms_output.put_line('Input_for_each_trigger before activate');
END;

CREATE OR REPLACE TRIGGER Update_for_each_trigger_before
before update on tabl
for each row
BEGIN
    dbms_output.put_line('Update_for_each_trigger before activate');
END;

CREATE OR REPLACE TRIGGER Delete_for_each_trigger_before
before delete on tabl
for each row
BEGIN
    dbms_output.put_line('Delete_for_each_trigger before activate');
END;
----------------------------------------------------------------------------------------------------------------
SELECT * from tabl;
SELECT * from audits;
UPDATE tabl SET b = 'B';
DELETE tabl;
delete AUDITS;
----------------------------------------------------------------------------------------------------------------
create table AUDITS(OperationDate date('DD-MM-YYYY  HH24:MI:SS'),OperationType varchar2(40), TriggerName varchar2(40),Data varchar2(40) );

CREATE OR REPLACE TRIGGER AUDITS_trigger_before
before insert or update  or delete on tabl
BEGIN
if inserting then
dbms_output.put_line('before_insert_AUDITS');
INSERT INTO AUDITS(OperationDate,OperationType , TriggerName,Data  )
SELECT sysdate,'Insert', 'AUDITS_trigger_before',concat(tabl.a ,tabl.b)
FROM tabl;
elsif updating then
dbms_output.put_line('before_update_AUDITS');
INSERT INTO AUDITS(OperationDate,OperationType , TriggerName,Data  )
SELECT sysdate,'Update', 'AUDITS_trigger_before',concat(tabl.a ,tabl.b)
FROM tabl;
elsif deleting then
dbms_output.put_line('before_delete_AUDITS');
INSERT INTO AUDITS(OperationDate,OperationType , TriggerName, Data )
SELECT sysdate,'Delete', 'AUDITS_trigger_before',concat(a ,b)
FROM tabl;
END if;
END;

CREATE OR REPLACE TRIGGER AUDITS_trigger_after
after insert or update  or delete on tabl
BEGIN
if inserting then
dbms_output.put_line('after_insert_AUDITS');
INSERT INTO AUDITS(OperationDate,OperationType , TriggerName,Data  )
SELECT sysdate,'Insert', 'AUDITS_trigger_after',concat(tabl.a ,tabl.b)
FROM tabl;
elsif updating then
dbms_output.put_line('after_update_AUDITS');
INSERT INTO AUDITS(OperationDate,OperationType , TriggerName,Data  )
SELECT sysdate,'Update', 'AUDITS_trigger_after',concat(tabl.a ,tabl.b)
FROM tabl;
elsif deleting then
dbms_output.put_line('after_delete_AUDITS');
INSERT INTO AUDITS(OperationDate,OperationType , TriggerName, Data )
SELECT sysdate,'Delete', 'AUDITS_trigger_after',concat(a ,b)
FROM tabl;
END if;
END;


---------------------------------------------------------------------------------------------------------------------------
drop table tabl;
FLASHBACK table tabl TO BEFORE DROP;
drop table audits;
FLASHBACK table audits TO BEFORE DROP;

CREATE OR REPLACE TRIGGER no_drop_trg
BEFORE DROP ON BAZ.SCHEMA
DECLARE
v_msg VARCHAR2(1000) :=
'No drop allowed on ' ||
DICTIONARY_OBJ_OWNER || '.' ||
DICTIONARY_OBJ_NAME || ' from ' ||
LOGIN_USER;
BEGIN
IF DICTIONARY_OBJ_OWNER = 'BAZ' AND
DICTIONARY_OBJ_NAME LIKE 'tabl' AND
DICTIONARY_OBJ_TYPE = 'TABLE'
THEN
RAISE_APPLICATION_ERROR (
-20905, v_msg);
END IF;
END; 

create view tablview as SELECT * FROM tabl;
SELECT * FROM tabl;
SELECT * FROM tablview;

CREATE OR REPLACE TRIGGER tabl_trigg
instead of insert or update or delete on tablview
BEGIN
if inserting then
dbms_output.put_line('insert');
insert into tabl VALUES (:new.a, :new.b);
elsif updating then
dbms_output.put_line('update');
elsif deleting then
dbms_output.put_line('delete');
END if;
END tabl_trigg;

SELECT * FROM user_errors;

INSERT INTO tablview (a,b) values(12,'c');
-------------------------------------------------------------------------------------------------------------------------------
create table turtles 
as
select 'Сплинтер' name, 'Крыса' essence from dual union all
select 'Леонардо', 'Художник' from dual union all
select 'Рафаэль', 'Художник' from dual union all
select 'Микеланджело', 'Художник'  from dual union all
select 'Донателло', 'Художник'  from dual;

drop table turtles;

Select * from turtles ;
/*create or replace trigger turtles
before update of essence
on turtles
for each row
when (
  new.name = 'Сплинтер' and old.essence = 'Крыса' and new.essence = 'Учитель'
)
begin
  update turtles
     set essence = 'Ниндзя'
   where essence = 'Художник';  
end; */
 
 drop trigger turtles;

create or replace trigger turtles_true
  for update of essence
  on turtles
  compound trigger
    bUpdPainters  boolean;
 
  before each row is
  begin
    if :new.name = 'Сплинтер' and :old.essence = 'Крыса' and :new.essence = 'Учитель' then
      bUpdPainters := true;
    end if;
  end before each row;
  
  after statement is
  begin
    if bUpdPainters then
      update Turtles
         set essence = 'Ниндзя'
       where essence = 'Художник';
    end if;
  end after statement;
end turtles_true; 

update turtles
   set essence = 'Учитель'
 where name = 'Сплинтер'
-------------------------------------------------------------------------------------------------------------------------------



