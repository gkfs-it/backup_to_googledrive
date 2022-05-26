DECLARE @n VARCHAR(100); --used for path
DECLARE @fileDate VARCHAR(20) -- used for file name
 
-- specify filename format
SELECT @fileDate = CONVERT(varchar(15),CONVERT(datetime, GETDATE()),112)
select @n = 'D:\PathTo\Backups\db_' + @fileDate + '.bak';
BACKUP DATABASE [тут имя БД в MSSQL] TO DISK = @n WITH NOFORMAT, INIT, NAME = N'Полная База данных Резервное копирование', SKIP, NOREWIND, NOUNLOAD, COMPRESSION, STATS = 10;
GO
