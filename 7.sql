--1.	�������� ������ ������ ������� ���������. 
SELECT name, description FROM v$BGPROCESS ORDER BY 1;--V$Bgprocess. ��� ��������, ������ ��������� ������� ���������, ������ � ������������� ������� �������������� ������� PADDR � ������� ��������� ����������������� ����� ������������ �������� ��������. ����� ������� �� ������� ������� PADDR ����� �������� 0.

--2.	���������� ������� ��������, ������� �������� � �������� � ��������� ������.
  SELECT *FROM v$process ;  --spid -������������� ���������� �������� OS. 

--3.	����������, ������� ��������� DBWn �������� � ��������� ������.
    show parameter db_writer_processes; --DBWn -�����, �������� � dirty - ������, ����������� � ����� ������

--4-5.	�������� �������� ������� ���������� � �����������.���������� ������ ���� ����������.
SELECT * FROM V$INSTANCE;

--6.	���������� ������� (����� ��������� �� ����������).
select * from V$SERVICES ;  --SYS$BACKGROUND ������������ ����������� ���������� ���� --SYS$USERS ������������ ���������� �������������, �� ��������� �������� �� ������.

--7.	�������� ��������� ��� ��������� ���������� � �� ��������.
SELECT * FROM V$DISPATCHER
show parameter DISPATCHERS

--8.	������� � ������ Windows-�������� ������, ����������� ������� LISTENER.
--OracleOraDB12Home4TNSListener

--9.	�������� �������� ������� ���������� � ���������. (dedicated, shared). 
SELECT USERNAME,SERVER FROM V$SESSION;

--10.	����������������� � �������� ���������� ����� LISTENER.ORA. 
--11-12.	��������� ������� lsnrctl � �������� �� �������� �������. �������� ������ ����� ��������, ������������� ��������� LISTENER. 
--lsnrctl status, start, stop



 alter pluggable database all open;



























