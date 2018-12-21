GRANT CREATE TABLESPACE TO BAZ;
ALTER USER BAZ QUOTA UNLIMITED ON t1;
ALTER USER BAZ QUOTA UNLIMITED ON t2;
ALTER USER BAZ QUOTA UNLIMITED ON t3;
ALTER USER BAZ QUOTA UNLIMITED ON t4;



GRANT ALTER ANY TABLESPACE TO TUSER
CREATE TABLESPACE t1 DATAFILE 'D:\5sem\Databases\t1.DAT'
SIZE 10M REUSE AUTOEXTEND ON NEXT 2M MAXSIZE 20M;
CREATE TABLESPACE t2 DATAFILE 'D:\5sem\Databases\t2.DAT'
  SIZE 10M REUSE AUTOEXTEND ON NEXT 2M MAXSIZE 20M;
CREATE TABLESPACE t3 DATAFILE 'D:\5sem\Databases\t3.DAT'
  SIZE 10M REUSE AUTOEXTEND ON NEXT 2M MAXSIZE 20M;
CREATE TABLESPACE t4 DATAFILE 'D:\5sem\Databases\t4.DAT'
  SIZE 10M REUSE AUTOEXTEND ON NEXT 2M MAXSIZE 20M;

create table T_Range( id number, time_id date)
partition by range(id)
(
Partition p1 values less than (100) tablespace t1,
Partition p2 values less than (200) tablespace t2,
Partition p3 values less than (300) tablespace t3,
Partition pmax values less than (maxvalue) tablespace t4
);

insert into T_range(id, time_id)
values(50,'01-02-2018');
insert into T_range(id, time_id)
values(105,'01-02-2017');
insert into T_range(id, time_id)
values(205,'01-02-2016');
insert into T_range(id, time_id)
values(305,'01-02-2015');
insert into T_range(id, time_id)
values(405,'01-02-2015');

SELECT * FROM T_range;

((select * from T_range partition(p1)
MINUS
select * from T_range partition(p2))
UNION ALL
(select * from T_range partition(p2)
MINUS
select * from T_range partition(p1)))
UNION 
((select * from T_range partition(p1)
MINUS
select * from T_range partition(p3))
UNION ALL
(select * from T_range partition(p3)
MINUS
select * from T_range partition(p1)))
UNION 
((select * from T_range partition(p1)
MINUS
select * from T_range partition(pmax))
UNION ALL
(select * from T_range partition(pmax)
MINUS
select * from T_range partition(p1)))

select * from T_range partition(p1)

select * from T_range partition(p2)

select * from T_range partition(p3)

select * from T_range partition(p5)



create table T_Interval(id number, time_id date)
partition by range(time_id)
interval (numtoyminterval(1,'month'))
(
partition p0 values less than  (to_date ('1-12-2009', 'dd-mm-yyyy')),
partition p1 values less than  (to_date ('1-12-2015', 'dd-mm-yyyy')),
partition p2 values less than  (to_date ('1-12-2018', 'dd-mm-yyyy'))
);

insert into T_Interval(id, time_id)
values(50,'01-02-2008');
insert into T_Interval(id, time_id)
values(105,'01-01-2009');
insert into T_Interval(id, time_id)
values(105,'01-01-2014');
insert into T_Interval(id, time_id)
values(205,'01-01-2015');
insert into T_Interval(id, time_id)
values(305,'01-01-2016');
insert into T_Interval(id, time_id)
values(405,'01-01-2018');
insert into T_Interval(id, time_id)
values(505,'01-01-2019');

select * from T_Interval partition(p0)

select * from T_Interval partition(p1)

select * from T_Interval partition(p2)


/*create table T_hash (str varchar2 (50), id number)
partition by hash (str)
partitions 4 store in (t1,t2,t3,t4);
*/
create table T_hash (str varchar2 (50), id number)
partition by hash (str)
(partition k1 tablespace t1,
partition k2 tablespace t2,
partition k3 tablespace t3,
partition k4 tablespace t4
)

drop table T_hash;
insert into T_hash (str,id)
values('asdssawesd', 1);
insert into T_hash (str,id)
values('gxdghghffdh', 2);
insert into T_hash (str,id)
values('/.....,,,,', 3);
insert into T_hash (str,id)
values('oiouuuoiu', 4);
insert into T_hash (str,id)
values('a', 7);

select * from T_hash partitions
select * from T_hash partition(k1)

select * from T_hash partition(k2)

select * from T_hash partition(k3)

select * from T_hash partition(k4)
WHERE partition

select * from T_hash partition(t4)

select * from partition where tablespace_name = 't1'

create table T_list(obj char(3))
partition by list (obj)
(
partition p1 values ('a'),
partition p2 values ('b'),
partition p3 values ('c')
);
insert into  T_list(obj)
values('a' );
insert into  T_list(obj)
values('b' );
insert into  T_list(obj)
values('c' );
insert into  T_list(obj)
values('d' );

select * from T_list partition (p1);
select * from T_list partition (p2);
select * from T_list partition (p3) ;

alter table T_list enable row movement;
update T_list
set obj='a' where obj='b';

alter table t_range merge partitions
p1,p2 into partition p5;

create table T_list1(obj char(3));

alter table T_list exchange partition  p3
with table T_list1;
SELECT * FROM T_list partition  p3 ;
SELECT * FROM T_list1;


alter table t_interval split partition p2 at 
(to_date ('1-12-2009', 'dd-mm-yyyy')) into (partition p6 tablespace t4, partition p5 tablespace t2);
----------------------------------------------------------------------------------------------------------------------------
create table orders
 (
 order#     number primary key,
 order_date date ,
 data       varchar2(30)
)
 enable row movement
 PARTITION BY RANGE (order_date )
 (
 PARTITION part_2014 VALUES LESS THAN ( to_date ('01-01-2015','dd-mm-yyyy')) ,
 PARTITION part_2015 VALUES LESS THAN (to_date('01-01-2016' ,'dd-mm-yyyy'))
 )

insert into orders values(1,to_date('01-џэт-2014', 'DD-MON-YYYY'),'A');
insert into orders values(2,to_date('01-џэт-2015', 'DD-MON-YYYY'),'B');

create table order_line_items
 (
 order# number ,
 line# number ,
 data varchar2 (30) ,
 constraint c1_pk primary key (order#, line#) ,
 constraint c1_fk foreign key (order#) references orders
 )
 enable row movement
 partition BY reference (c1_fk)

insert into order_line_items values(1,1,'C');
insert into order_line_items values(2,1,'D');

SELECT table_name, partition_name
FROM user_tab_partitions
WHERE table_name in ('ORDERS','ORDER_LINE_ITEMS')
order by table_name, partition_name

alter table orders add partition
part_2017 values less than
(to_date('01-01-2018','dd-mm-yyyy'));

select '2014',count(*) from order_line_items
partition(part_2014)
union all
select '2015',count(*) from order_line_items
partition(part_2015)
union all
select '2017',count(*) from order_line_items
partition(part_2017)

update orders set order_date=add_months(order_date,12)














