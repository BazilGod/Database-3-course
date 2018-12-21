 
create table teacher_backup (
  teacher      char(10),
  teacher_name nvarchar2(50),
  pulpit       char(10),
  salary      number
);
create table teacher_backup2 (
  teacher      char(10),
  teacher_name nvarchar2(50),
  pulpit       char(10),
  salary      number
);

create table job_status (
  status   nvarchar2(50),
  datetime timestamp default current_timestamp
);

create or replace procedure jobprocedure is
  cursor teachercursor is select *
                          from teacher
                          where salary > 450;
  begin
     
    for n in teachercursor
      loop
      insert into teacher_backup (teacher, teacher_name, pulpit, salary)
      values
        (n.teacher, n.teacher_name, n.pulpit, n.salary); 
    end loop;
     delete from teacher
    where salary > 450;
    insert into job_status (status) values ('SUCCESS');
    commit;
    exception when others then insert into job_status (status) values ('FAIL');
  end;


begin
jobprocedure;
end;
rollback

 delete teacher_backup;
delete job_status;

declare v_job number;
begin
  dbms_job.submit(
      job => v_job,
      what => 'BEGIN jobprocedure(); END;',
      next_date => trunc(sysdate+7) + 3 / 24,
      interval => 'trunc(sysdate + 7)+3/24');
  commit;
end;


begin
  dbms_job.remove(61);
end;

begin
  dbms_job.run(61);
end;

begin
  dbms_job.broken(61, broken => true);
end;

begin
  dbms_job.change(job => 61, what => null, next_date => trunc(sysdate + 7) + 3 / 24, interval => null);
end;


select *from user_jobs;
select job_name, state, enabled from user_scheduler_jobs;
begin
  dbms_scheduler.create_job(
      job_name => 'js2',
      job_type => 'STORED_PROCEDURE',
      job_action => 'jobprocedure',
      start_date => systimestamp + interval '1' minute,
      repeat_interval => 'FREQ=DAILY; INTERVAL=7;BYHOUR=10; BYMINUTE=10;BYSECOND=30',
      enabled => true
  );
end;

begin
  dbms_scheduler.drop_job('js2', true);
end;
;

begin
  dbms_scheduler.run_job('js2');
end;

begin
  dbms_scheduler.stop_job('js2');
end;

begin
  dbms_scheduler.set_attribute('js2', attribute => 'job_action', value => 'jobprocedure');
end;
begin
dbms_scheduler.create_job( 
job_name   => 'simple_job', 
job_type   => 'PLSQL_BLOCK',
job_action => 'UPDATE teacher set teacher_name = 'a' where salary = 1000;',
enabled   => true
);

BEGIN
  DBMS_SCHEDULER.CREATE_JOB(
     job_name => 'TEST.TEST1_JOB',
     job_type => 'EXECUTABLE',
     job_action => 'cmd.exe /c c:\test1.bat',
     start_date => TRUNC(SYSDATE)+15/24,
     repeat_interval => 'FREQ=MINUTELY;INTERVAL=10',
     comments => 'Test execute',
     auto_drop => FALSE,
     enabled => TRUE);
END;


end;
