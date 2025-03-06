show global variables like "local_infile";
set global local_infile=1;
select * from transactions;

LOAD DATA LOCAL INFILE 'C:\Users\Griselda\Desktop\Bootcamp Data Analytics\Sprint 4\users_usa.csv'
INTO TABLE users
FIELDS TERMINATED BY ','
ENCLOSED BY '"'
lines terminated by '\r\n'
IGNORE 1 ROWS;

SHOW VARIABLES LIKE 'pid_file';
SHOW VARIABLES LIKE 'secure_file_priv';