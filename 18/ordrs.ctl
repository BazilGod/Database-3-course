LOAD DATA

INFILE *
WHEN ORDER_DATE"MM"=
REPLACE INTO TABLE ORDRS
FIELDS TERMINATED BY ';'  TRAILING NULLCOLS
	(ORDER_NUM, ORDER_DATE DATE "DD-MM-YYYY", PRODUCT"UPPER(:PRODUCT)", AMOUNT ":AMOUNT * 2",text LOBFILE (f_name) TERMINATED BY EOF,img LOBFILE (i_name) TERMINATED BY EOF, f_name , i_name)
BEGINDATA
1;11-11-2018;chair;100;;;
2;03-06-2017;table;200;;;
3;10-11-2008;bed;50;1.txt;1.jpg;
4;12-10-2017;bath;70;;;
5;30-11-2016;chandelier;80;;;
6;02-02-2015;lamp;120;;;
7;17-11-2014;fireplace;110;;2.jpg;