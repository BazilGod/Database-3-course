--1.Определите общий размер области SGA.
select * from v$sga;
select SUM(VALUE) from v$sga;

--2.Определите текущие размеры основных пулов SGA.
select * from v$sga_dynamic_components where current_size > 0;

--3.Определите размеры гранулы для каждого пула.
select COMPONENT, GRANULE_SIZE from v$sga_dynamic_components where current_size > 0;

--4.Определите объем доступной свободной памяти в SGA.
select sum(min_size), sum(max_size), sum(current_size) from v$sga_dynamic_components;

--5.Определите размеры пулов КЕЕP, DEFAULT и RECYCLE буферного кэша.
select component, min_size, current_size, max_size from v$sga_dynamic_components where current_size > 0;

--6.Создайте таблицу, которая будут помещаться в пул КЕЕP. Продемонстрируйте сегмент таблицы.
create table MyTable(x int) storage(buffer_pool keep);
select segment_name, segment_type, tablespace_name, buffer_pool from user_segments where lower(segment_name) like '%mytable%';

--7.Создайте таблицу, которая будут кэшироваться в пуле default. Продемонстрируйте сегмент таблицы.
create table MyTable2(x int) storage(buffer_pool default);
--содержат данные которые не содержат пулов
select segment_name, segment_type, tablespace_name, buffer_pool from user_segments where lower(segment_name) like '%mytable%';

--8.Найдите размер буфера журналов повтора.
show parameter log_buffer;

--9.Найдите 10 самых больших объектов в разделяемом пуле.
select type from v$db_object_cache where lower(pin_mode) like '%shared%';

--10.Найдите размер свободной памяти в большом пуле.
select pool, name, bytes from v$sgastat where pool = 'large pool' and name = 'free memory';

--11.Получите перечень текущих соединений с инстансом.
select username, server from v$session;

--12.Определите режимы текущих соединений с инстансом (dedicated, shared).
select username, server from v$session;
