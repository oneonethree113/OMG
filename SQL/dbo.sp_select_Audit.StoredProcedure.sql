/****** Object:  StoredProcedure [dbo].[sp_select_Audit]    Script Date: 09/29/2017 15:29:09 ******/
DROP PROCEDURE [dbo].[sp_select_Audit]
GO
/****** Object:  StoredProcedure [dbo].[sp_select_Audit]    Script Date: 09/29/2017 15:29:10 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO






/************************************************************************************************    
ALTER  Date  : 2005-06-08    
Create by  : Lester Wu    
Program ID : sp_select_Audit    
************************************************************************************************    
Modification History    
************************************************************************************************    
Modified on  Modified by  Description    
************************************************************************************************    
2007-01-03 Lester Wu  Handle Audit Table 2006 not build problem  
2011-05-09 Frankie Cheung  Handle difference in field header of different AUD Table of year
*************************************************************************************************/    
    
CREATE  PROCEDURE [dbo].[sp_select_Audit]    
    
@cocde  nvarchar(6),    
@SQL  varchar(8000),    
@table_name varchar(50)  

AS     

CREATE TABLE #tmpSQL
(
	tmpSQL varchar(8000)
)

declare  @strColumns varchar(4000)

set @strColumns = ''    

declare @ItmStrRemain varchar(8000)
declare @ItmStrPart	varchar(8000)

/*** Split incoming SQL with delimitor 'UNION') ***/
if @SQL <> '' 
begin 
	set @ItmStrRemain = @SQL

	while charindex('UNION',@ItmStrRemain)<>0
	begin
		set @ItmStrPart = ltrim(left(@ItmStrRemain, charindex('UNION', @ItmStrRemain)-1))
		set @ItmStrRemain = right(@ItmStrRemain, len(@ItmStrRemain) - charindex('UNION', @ItmStrRemain))
		if left(@ItmStrPart,4) = 'NION' 
		begin
			insert into #tmpSQL values ('U' + @ItmStrPart)			
		end
		else
		begin
			insert into #tmpSQL values (@ItmStrPart)
		end	
	end

	if charindex('UNION',@ItmStrRemain) = 0 
	begin
		if left(@ItmStrRemain,4) = 'NION' 
		begin
			insert into #tmpSQL values ('U' + ltrim(@ItmStrRemain))			
		end
		else
		begin
			insert into #tmpSQL values (ltrim(@ItmStrRemain))
		end	
	end
end
/*** End of Split incoming SQL section  ***/


/*****************************************************/
/*** Add New Archive Audit Table Year variable below if necessary ***/
/*****************************************************/

declare @sql2002 varchar(8000), @sql2003 varchar(8000), @sql2004 varchar(8000), @sql2005 varchar(8000), @sql2006 varchar(8000),
@sql2007 varchar(8000), @sql2008 varchar(8000), @sql2009 varchar(8000), @sql2010 varchar(8000), @sql2011 varchar(8000), @sql2012 varchar(8000),
@sql2013 varchar(8000),@sql2014 varchar(8000), @sql2015 varchar(8000)


declare @sqlcur varchar(8000), @tmpsql varchar(8000)

set @sql2002 = ''
set @sql2003 = ''
set @sql2004 = ''
set @sql2005 = ''
set @sql2006 = ''
set @sql2007 = ''
set @sql2008 = ''
set @sql2009 = ''
set @sql2010 = ''
set @sql2011 = ''
set @sql2012 = ''
set @sql2013 = ''
set @sql2014 = ''
set @sql2015 = ''
set @sqlcur = ''
set @tmpsql = ''

DECLARE tmpSQL_cursor CURSOR FOR   
select tmpSQL from #tmpSQL
OPEN tmpSQL_cursor   
FETCH NEXT FROM tmpSQL_cursor INTO @tmpsql   
WHILE @@FETCH_STATUS = 0  
BEGIN  


	if CHARINDEX('UCPERPDB_AUD_2002.' ,@tmpsql) <> 0 
	begin
		exec sp_GenAudSelectList 'UCPERPDB_AUD_2002', @table_name, @strColumns output
		set @sql2002 = ltrim(rtrim(replace(@tmpsql,'select * from UCPERPDB_AUD_2002.', 'select ' + @strColumns + ' from UCPERPDB_AUD_2002.')))   
	end
	
	if CHARINDEX('UCPERPDB_AUD_2003.' ,@tmpsql) <> 0
	begin
		exec sp_GenAudSelectList 'UCPERPDB_AUD_2003', @table_name, @strColumns output
		set @sql2003 = ltrim(rtrim(replace(@tmpsql,'select * from UCPERPDB_AUD_2003.', 'select ' + @strColumns + ' from UCPERPDB_AUD_2003.')))
	end
	
	if CHARINDEX('UCPERPDB_AUD_2004.' ,@tmpsql) <> 0
	begin
		exec sp_GenAudSelectList 'UCPERPDB_AUD_2004', @table_name, @strColumns output
		set @sql2004 = ltrim(rtrim(replace(@tmpsql,'select * from UCPERPDB_AUD_2004.', 'select ' + @strColumns + ' from UCPERPDB_AUD_2004.')))
	end

	if CHARINDEX('UCPERPDB_AUD_2005.' ,@tmpsql) <> 0
	begin
		exec sp_GenAudSelectList 'UCPERPDB_AUD_2005', @table_name, @strColumns output
		set @sql2005 = ltrim(rtrim(replace(@tmpsql,'select * from UCPERPDB_AUD_2005.', 'select ' + @strColumns + ' from UCPERPDB_AUD_2005.')))
	end

	if CHARINDEX('UCPERPDB_AUD_2006.' ,@tmpsql) <> 0 
	begin
		exec sp_GenAudSelectList 'UCPERPDB_AUD_2008', @table_name, @strColumns output
		set @sql2006 = ltrim(rtrim(replace(@tmpsql,'select * from UCPERPDB_AUD_2006.', 'select ' + @strColumns + ' from UCPERPDB_AUD_2008.')))
	end


	if CHARINDEX('UCPERPDB_AUD_2007.' ,@tmpsql) <> 0
	begin
		exec sp_GenAudSelectList 'UCPERPDB_AUD_2008', @table_name, @strColumns output
		set @sql2007 = ltrim(rtrim(replace(@tmpsql,'select * from UCPERPDB_AUD_2007.', 'select ' + @strColumns + ' from UCPERPDB_AUD_2008.')))
	end

	if CHARINDEX('UCPERPDB_AUD_2008.' ,@tmpsql) <> 0
	begin
		exec sp_GenAudSelectList 'UCPERPDB_AUD_2008', @table_name, @strColumns output
		set @sql2008 = ltrim(rtrim(replace(@tmpsql,'select * from UCPERPDB_AUD_2008.', 'select ' + @strColumns + ' from UCPERPDB_AUD_2008.')))
	end
	
	if CHARINDEX('UCPERPDB_AUD_2009.' ,@tmpsql) <> 0 
	begin
		exec sp_GenAudSelectList 'UCPERPDB_AUD_2010', @table_name, @strColumns output
		set @sql2009 = ltrim(rtrim(replace(@tmpsql,'select * from UCPERPDB_AUD_2009.', 'select ' + @strColumns + ' from UCPERPDB_AUD_2010.')))
	end

	if CHARINDEX('UCPERPDB_AUD_2010.' ,@tmpsql) <> 0
	begin
		exec sp_GenAudSelectList 'UCPERPDB_AUD_2010', @table_name, @strColumns output
		set @sql2010 = ltrim(rtrim(replace(@tmpsql,'select * from UCPERPDB_AUD_2010.', 'select ' + @strColumns + ' from UCPERPDB_AUD_2010.')))
	end


	if CHARINDEX('UCPERPDB_AUD_2011.' ,@tmpsql) <> 0
	begin
		exec sp_GenAudSelectList 'UCPERPDB_AUD_2011', @table_name, @strColumns output
		set @sql2011 = ltrim(rtrim(replace(@tmpsql,'select * from UCPERPDB_AUD_2011.', 'select ' + @strColumns + ' from UCPERPDB_AUD_2011.')))
	end

	if CHARINDEX('UCPERPDB_AUD_2012.' ,@tmpsql) <> 0
	begin
		exec sp_GenAudSelectList 'UCPERPDB_AUD_2012', @table_name, @strColumns output
		set @sql2012 = ltrim(rtrim(replace(@tmpsql,'select * from UCPERPDB_AUD_2012.', 'select ' + @strColumns + ' from UCPERPDB_AUD_2012.')))
	end

	if CHARINDEX('UCPERPDB_AUD_2013.' ,@tmpsql) <> 0
	begin
		exec sp_GenAudSelectList 'UCPERPDB_AUD_2013', @table_name, @strColumns output
		set @sql2013 = ltrim(rtrim(replace(@tmpsql,'select * from UCPERPDB_AUD_2013.', 'select ' + @strColumns + ' from UCPERPDB_AUD_2013.')))
	end

	if CHARINDEX('UCPERPDB_AUD_2014.' ,@tmpsql) <> 0
	begin
		exec sp_GenAudSelectList 'UCPERPDB_AUD_2014', @table_name, @strColumns output
		set @sql2014 = ltrim(rtrim(replace(@tmpsql,'select * from UCPERPDB_AUD_2014.', 'select ' + @strColumns + ' from UCPERPDB_AUD_2014.')))
	end

	if CHARINDEX('UCPERPDB_AUD_2015.' ,@tmpsql) <> 0
	begin
		exec sp_GenAudSelectList 'UCPERPDB_AUD_2015', @table_name, @strColumns output
		set @sql2014 = ltrim(rtrim(replace(@tmpsql,'select * from UCPERPDB_AUD_2015.', 'select ' + @strColumns + ' from UCPERPDB_AUD_2015.')))
	end

	/****************************************************************************/
	/*** Add New Archive Audit Table here if necessary, copy above coding block and change the yesr **/
	/****************************************************************************/

	if CHARINDEX('UCPERPDB_AUD.' ,@tmpsql) <> 0 
	begin
		set @sqlcur = @tmpsql
	end

FETCH NEXT FROM tmpSQL_cursor INTO @tmpsql   
END   
close tmpSQL_cursor   
deallocate tmpSQL_cursor  

--PRINT + CONVERT( varchar(8000),  @sql2002 + @sql2003 + @sql2004 + @sql2005 + @sql2006 + @sql2007 + @sql2008 + @sql2009 + @sql2010 + @sqlcur)

/*****************************************************/
/*** Add New Archive Audit Table Year variable below if necessary ***/
/*****************************************************/

exec  (@sql2002 + @sql2003 + @sql2004 + @sql2005 + @sql2006 + @sql2007 + @sql2008 + @sql2009 + @sql2010 + @sql2011 + @sql2012 + @sql2013 + @sql2014 + @sql2015 + @sqlcur)

--select * from #TmpResult
GO
GRANT EXECUTE ON [dbo].[sp_select_Audit] TO [ERPUSER] AS [dbo]
GO
