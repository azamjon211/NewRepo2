
if db_id('Store') is null
	create database Store;
go

use Store;

go

-- Drop foreign keys first
IF OBJECT_ID('dbo.employee', 'U') IS NOT NULL
    ALTER TABLE dbo.employee
    DROP CONSTRAINT IF EXISTS FK_employee_store_code;
GO

IF OBJECT_ID('dbo.store', 'U') IS NOT NULL
BEGIN
    ALTER TABLE dbo.store
    DROP CONSTRAINT IF EXISTS FK_store_employee;

    ALTER TABLE dbo.store
    DROP CONSTRAINT IF EXISTS FK_Store_region;
END
GO

-- Now drop tables
DROP TABLE IF EXISTS dbo.employee;
DROP TABLE IF EXISTS dbo.store;
DROP TABLE IF EXISTS dbo.region;
GO

drop sequence if exists dbo.employee_seq;
go

create sequence dbo.employee_seq
start with 1
increment by 1;
go

 --create tables 

create table dbo.region
(
	REGION_CODE INT primary key,
	REGION_DESCRIPTION varchar(50)
);
go

create table dbo.employee
(
	EMP_CODE INT PRIMARY KEY
    DEFAULT (NEXT VALUE FOR dbo.employee_seq),
	EMP_TITLE varchar(10),
	EMP_LNAME varchar(50),
	EMP_FNAME varchar(50),
	EMP_INITIAL char(1),
	EMP_DOB date,
	STORE_CODE int
);
go
create table dbo.store
(
	STORE_CODE int primary key,
	STORE_NAME varchar(50),
	STORE_YTD_SALES decimal(10,2),
	REGION_CODE int,
	EMP_CODE int
);
go

--default constraint 
alter table dbo.employee
add constraint DF_employee_store_code
default 3 for STORE_CODE;
go

--check constraint

alter table dbo.store
add constraint CH_store_store_ytd_sales check(STORE_YTD_SALES > 0);
go


--foreign key constraints 

alter table dbo.store
add constraint FK_Store_region
foreign key (REGION_CODE)
references dbo.region(REGION_CODE)
go
alter table dbo.store
add constraint FK_store_employee
foreign key (EMP_CODE)
references dbo.employee(EMP_CODE)
go
--employee fk key

alter table dbo.employee
add constraint FK_employee_store_code
foreign key (STORE_CODE)
references dbo.store (STORE_CODE)
go

select * from dbo.region
select * from dbo.employee
select * from dbo.store

