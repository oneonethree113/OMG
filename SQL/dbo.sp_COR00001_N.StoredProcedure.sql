/****** Object:  StoredProcedure [dbo].[sp_COR00001_N]    Script Date: 09/29/2017 15:29:09 ******/
DROP PROCEDURE [dbo].[sp_COR00001_N]
GO
/****** Object:  StoredProcedure [dbo].[sp_COR00001_N]    Script Date: 09/29/2017 15:29:09 ******/
SET ANSI_NULLS OFF
GO
SET QUOTED_IDENTIFIER OFF
GO




/*
=========================================================
Program ID	: sp_COR00001_N
Description   	: 
Programmer  	: Tommy Ho
Create Date   	: 
Last Modified  	: 
Table Read(s) 	:
Table Write(s) 	:
=========================================================
 Modification History                                    
=========================================================
 Date      Initial  	Description                          
=========================================================    
05/06/2003 Allan Yuen   Relocate Audit Log Table Location  
*/



CREATE PROCEDURE [dbo].[sp_COR00001_N]

--@lang  		nvarchar(1),
--@userid  	nvarchar(30),
@tablename 	nvarchar(14),
@selection1 	nvarchar(14),	@selection2 	nvarchar(14),	
@selection3 	nvarchar(14),	@selection4 	nvarchar(14),
@selection5 	nvarchar(14),	@selection6 	nvarchar(14),
@selection7 	nvarchar(14),
@value1 		nvarchar(20),	@value2 		nvarchar(20),
@value3 		nvarchar(20),	@value4 		nvarchar(20),
@value5 		nvarchar(20),	@value6 		nvarchar(20),
@value7 		nvarchar(20),
@fromDate 	datetime,		@toDate  		datetime,
@add		int,		@update		int,
@delete		int

AS	

declare @sql as nvarchar(500)
declare @addstt as varchar(50)
declare @updatestt as varchar(50)
declare @deletestt as varchar(50)

--set @sql = 'select  *  from  ' + @tablename
--Allan Yuen Relocate Audit Log Table Location
set @sql = 'select  *  from  ' + 'UCPERPDB_AUD.DBO.'+ @tablename

set @sql = @sql + ' where ' + @selection1 + ' = '  + '''' + @value1 + ''''

if @selection2 <> '' 
begin
	set @sql = @sql + ' and '  + @selection2 + ' = '  + '''' + @value2 + ''''
end
if @selection3 <> '' 
begin
	set @sql = @sql + ' and '  + @selection3 + ' = '  + '''' + @value3 + ''''
end
if @selection4 <> '' 
begin
	set @sql = @sql + ' and '  + @selection4 + ' = '  + '''' + @value4 + ''''
end
if @selection5 <> '' 
begin
	set @sql = @sql + ' and '  + @selection5 + ' = '  + '''' + @value5 + ''''
end
if @selection6 <> '' 
begin
	set @sql = @sql + ' and '  + @selection6 + ' = '  + '''' + @value6 + ''''
end

set @sql = @sql + ' and ' + left(@selection1, 4) + 'credat between ' +
	 '''' +ltrim(str(year(@fromdate))) + '/' +  ltrim(str(month(@fromDate))) + '/' + ltrim(str(day(@fromDate))) + '''' 
	 + ' and ' + 
	 ''''+ ltrim(str(year(@ToDate))) + '/' + ltrim(str(month(@ToDate))) + '/' + ltrim(str(day(@ToDate))) +  ' 23:59:59' + ''''

if @add = 1 
begin
	set @addstt =  left(@selection1, 4) + 'actflg_aud = 1' 
end

if @update = 1 
begin
	set @updatestt = ' (' + left(@selection1, 4) + 'actflg_aud = 2 or  ' + 
 		 	            left(@selection1, 4) + 'actflg_aud = 3)' 
end

if @delete = 1 
begin
	set @deletestt = left(@selection1, 4) + 'actflg_aud = 4 '
end

if @add = 1 and @update = 0 and @delete = 0  --ADD
begin
	set @sql = @sql + ' and ' + @addstt
end

if @add = 0 and @update = 1 and @delete = 0  --UPDATE
begin
	set @sql = @sql + ' and ' + @updatestt
end

if @add = 0 and @update = 0 and @delete = 1 --DELETE
begin
	set @sql = @sql + ' and ' + @deletestt
end

if @add = 1 and @update = 1 and @delete = 0 --ADD and UPDATE
begin
	set @sql = @sql + ' and (' + @addstt + ' or ' + @updatestt +')'
end

if @add = 1 and @update = 0 and @delete = 1 --ADD and DELETE
begin
	set @sql = @sql + ' and (' + @addstt + ' or ' + @deletestt +')'
end

if @add = 0 and @update = 1 and @delete = 1 --UPDATE and DELETE
begin
	set @sql = @sql + ' and (' + @updatestt + ' or ' + @deletestt +')'
end

if @add = 1 and @update = 1 and @delete = 1 --ADD and UPDATE and DELETE
begin
	set @sql = @sql + ' and (' + @addstt + ' or ' + @updatestt + ' or ' + @deletestt +')'
end


exec (@sql)






GO
GRANT EXECUTE ON [dbo].[sp_COR00001_N] TO [ERPUSER] AS [dbo]
GO
