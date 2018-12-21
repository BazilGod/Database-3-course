CREATE TABLE ORDRS
(
	ORDER_NUM INTEGER PRIMARY KEY,
	ORDER_DATE DATE,
	PRODUCT VARCHAR2(10),
	AMOUNT NUMBER,
    text CLOB,
    img BLOB,
    f_name VARCHAR2(30),
    i_name VARCHAR2(30)
)

drop table ordrs;
SELECT * FROM nls_session_parameters WHERE parameter = 'NLS_DATE_FORMAT';
alter session set nls_date_format = 'DD-MM-YYYY'

SELECT * FROM nls_session_parameters;
select sysdate from dual
select to_CHAR(sysdate,'DD MONTH YYYY','nls_date_language=russian')from dual;