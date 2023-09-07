



sp_configure 'show advanced options', 1;  
GO  
RECONFIGURE;  
GO  
sp_configure 'Ole Automation Procedures', 1;  
GO  
RECONFIGURE;  
GO  


DECLARE @idTest as int= 112233;

DECLARE @URL NVARCHAR(MAX) = 'http://localhost:69001/WeatherForecast';
DECLARE @Object AS INT;
DECLARE @ResponseText AS VARCHAR(8000);
DECLARE @Body AS VARCHAR(8000) =
CONCAT('{   "idTest": ',@idTest,'}')

EXEC sp_OACreate 'MSXML2.XMLHTTP', @Object OUT;
EXEC sp_OAMethod @Object, 'open', NULL, 'post',
                 @URL,
                 'false'
EXEC sp_OAMethod @Object, 'setRequestHeader', null, 'Content-Type', 'application/json'
EXEC sp_OAMethod @Object, 'send', null, @body
EXEC sp_OAMethod @Object, 'responseText', @ResponseText OUTPUT
IF CHARINDEX('false',(SELECT @ResponseText)) > 0
BEGIN
 SELECT @ResponseText As 'Message'
END
ELSE
BEGIN
 SELECT @ResponseText As 'Response'
END
EXEC sp_OADestroy @Object



