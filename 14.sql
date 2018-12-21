
GRANT CREATE DATABASE LINK TO BAZ;
GRANT CREATE PUBLIC DATABASE LINK TO BAZ;
CREATE DATABASE LINK con1
  CONNECT TO admin IDENTIFIED BY "admin"
  USING 'KURS';
  select * from usern@con1;
  insert into usern@con1 values(2,'ikonov.3000@mail.ru',1111);
update usern@con1 set password=555 where id=2;
delete usern@con1 where ID=5;

CREATE PUBLIC DATABASE LINK con2 
  CONNECT TO admin IDENTIFIED BY "admin"
  USING 'KURS';
 select * from usern@con2;
  insert into usern@con2 values(5,'ikonov.3000@mail.ru',1111);
update usern@con2 set password=555 where id=2;
delete usern@con2 where ID=2;

begin
admin.pkgtest.test@con2;
end;


