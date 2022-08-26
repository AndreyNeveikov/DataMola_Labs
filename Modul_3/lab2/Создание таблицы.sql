Create table dbo.FileInfo (FileId int identity(1,1), FileName VARCHAR(150),
							FileCreationDate Date, LoadTime datetime default getdate());


Drop table dbo.FileInfo;
