--this script creates a new database named 'DWH' after checking if it already exists.


use master;
go 

--drop and recreate the database 'DWH'
if exists (select 1 from sys.databases where name = 'DWH')
begin 
	alter database DWH set SINGLE_USER with rollback immediate;
	drop database DWH
end
go
--create the 'DWH' database
create  database DWH;

use DWH;
--create the schemas
create schema bronze;
go
create schema silver;
go
create schema gold;
go
