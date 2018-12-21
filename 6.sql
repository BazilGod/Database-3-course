--1.���������� ����� ������ ������� SGA.
select * from v$sga;
select SUM(VALUE) from v$sga;

--2.���������� ������� ������� �������� ����� SGA.
select * from v$sga_dynamic_components where current_size > 0;

--3.���������� ������� ������� ��� ������� ����.
select COMPONENT, GRANULE_SIZE from v$sga_dynamic_components where current_size > 0;

--4.���������� ����� ��������� ��������� ������ � SGA.
select sum(min_size), sum(max_size), sum(current_size) from v$sga_dynamic_components;

--5.���������� ������� ����� ���P, DEFAULT � RECYCLE ��������� ����.
select component, min_size, current_size, max_size from v$sga_dynamic_components where current_size > 0;

--6.�������� �������, ������� ����� ���������� � ��� ���P. ����������������� ������� �������.
create table MyTable(x int) storage(buffer_pool keep);
select segment_name, segment_type, tablespace_name, buffer_pool from user_segments where lower(segment_name) like '%mytable%';

--7.�������� �������, ������� ����� ������������ � ���� default. ����������������� ������� �������.
create table MyTable2(x int) storage(buffer_pool default);
--�������� ������ ������� �� �������� �����
select segment_name, segment_type, tablespace_name, buffer_pool from user_segments where lower(segment_name) like '%mytable%';

--8.������� ������ ������ �������� �������.
show parameter log_buffer;

--9.������� 10 ����� ������� �������� � ����������� ����.
select type from v$db_object_cache where lower(pin_mode) like '%shared%';

--10.������� ������ ��������� ������ � ������� ����.
select pool, name, bytes from v$sgastat where pool = 'large pool' and name = 'free memory';

--11.�������� �������� ������� ���������� � ���������.
select username, server from v$session;

--12.���������� ������ ������� ���������� � ��������� (dedicated, shared).
select username, server from v$session;
