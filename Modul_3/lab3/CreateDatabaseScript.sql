/*Task_1*/

CREATE DATABASE HumanResources   
 ON PRIMARY                   
   ( NAME = HumanResources_data,       
     FILENAME = 'E:\Git_repositories\DataMola_Labs\Modul_3\lab3\Database\HumanResources__data.mdf',
     SIZE = 3MB, 
     MAXSIZE = 75MB,
     FILEGROWTH = 3MB ),
 FILEGROUP Secondary
   ( NAME = HumanResources2_data,
     FILENAME = 'E:\Git_repositories\DataMola_Labs\Modul_3\lab3\Database\HumanResources__data2.ndf',
     SIZE = 2MB, 
     MAXSIZE = 50MB,
     FILEGROWTH = 15% ),
   ( NAME = HumanResources3_data,
     FILENAME = 'E:\Git_repositories\DataMola_Labs\Modul_3\lab3\Database\HumanResources__data3.ndf',
     SIZE = 3MB, 
     FILEGROWTH = 4MB )
 LOG ON
   ( NAME = HumanResources_log,
     FILENAME = 'E:\Git_repositories\DataMola_Labs\Modul_3\lab3\Database\HumanResources__log.ldf',
     SIZE = 1MB,
     MAXSIZE = 10MB,
     FILEGROWTH = 20% ),
   ( NAME = HumanResources2_log,
     FILENAME = 'E:\Git_repositories\DataMola_Labs\Modul_3\lab3\Database\HumanResources__log2.ldf',
     SIZE = 512KB,
     MAXSIZE = 15MB,
     FILEGROWTH = 10% )
 GO  

 USE HumanResources
 GO


 /* dbo.EmployeesExternal */
 CREATE TABLE dbo.EmployeesExternal (				
	EmployeeID	INT	 PRIMARY KEY NOT NULL,
	FirstName	NVARCHAR(50)	NOT NULL,
	LastName	NVARCHAR(50)	NOT NULL,
	JobTitle	NVARCHAR(50)	NOT NULL,
	EmailAddress	NVARCHAR(50)	NULL,
	City	NVARCHAR(50)	NOT NULL,
	StateProvinceName	NVARCHAR(50)	NOT NULL,
	CountryRegionName	NVARCHAR(50)	NOT NULL
 );
  --DROP TABLE dbo.EmployeesExternal;


CREATE TABLE dbo.EmployeesAW (
	BusinessEntityID INT PRIMARY KEY,
	FirstName NVARCHAR(50) NOT NULL,
	LastName NVARCHAR(50) NOT NULL,
	JobTitle NVARCHAR(50) NULL
 );
--DROP TABLE dbo.EmployeesAW;


CREATE TABLE dbo.EmailAddressesAW (
	EmailAddressId INT PRIMARY KEY, 
	BusinessEntityID INT NOT NULL,
	EmailAddress NVARCHAR(50) NOT NULL
 );
 --DROP TABLE dbo.EmailAddressesAW;

 Select * from dbo.EmployeesExternal;
 Select * from dbo.EmployeesAW;
 Select * from dbo.EmailAddressesAW;


 -------------------------------------------------------------------------------------------------------------------
/*Task_2*/


USE AdventureWorks2012
 GO


 -- dbo.EmployeesExternal
 SELECT 
    e.[BusinessEntityID]
    ,p.[FirstName]
    ,p.[LastName]
    ,e.[JobTitle]  
    ,ea.[EmailAddress]
    ,a.[City]
    ,sp.[Name] AS [StateProvinceName] 
    ,cr.[Name] AS [CountryRegionName] 
FROM [HumanResources].[Employee] e
  INNER JOIN [Person].[Person] p
  ON p.[BusinessEntityID] = e.[BusinessEntityID]
    INNER JOIN [Person].[BusinessEntityAddress] bea 
    ON bea.[BusinessEntityID] = e.[BusinessEntityID] 
    INNER JOIN [Person].[Address] a 
    ON a.[AddressID] = bea.[AddressID]
    INNER JOIN [Person].[StateProvince] sp 
    ON sp.[StateProvinceID] = a.[StateProvinceID]
    INNER JOIN [Person].[CountryRegion] cr 
    ON cr.[CountryRegionCode] = sp.[CountryRegionCode]
    LEFT OUTER JOIN [Person].[PersonPhone] pp
    ON pp.BusinessEntityID = p.[BusinessEntityID]
    LEFT OUTER JOIN [Person].[PhoneNumberType] pnt
    ON pp.[PhoneNumberTypeID] = pnt.[PhoneNumberTypeID]
    LEFT OUTER JOIN [Person].[EmailAddress] ea
    ON p.[BusinessEntityID] = ea.[BusinessEntityID]
    order by p.[BusinessEntityID] asc;


-- dbo.EmailAddressesAW;
 select p.[BusinessEntityID],[FirstName],[LastName],[JobTitle]
 from [Person].[Person] p
 inner join [HumanResources].[Employee] e
      on p.BusinessEntityID = e.BusinessEntityID;


-- dbo.EmailAddressesAW;
 select [EmailAddressID],p.[BusinessEntityID],[EmailAddress]
 from [Person].[EmailAddress] e
 inner join [Person].[Person] p
	on e.[BusinessEntityID] = p.BusinessEntityID
 where p.[BusinessEntityID] < 291