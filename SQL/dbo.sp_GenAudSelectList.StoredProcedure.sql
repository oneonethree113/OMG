/****** Object:  StoredProcedure [dbo].[sp_GenAudSelectList]    Script Date: 09/29/2017 15:29:09 ******/
DROP PROCEDURE [dbo].[sp_GenAudSelectList]
GO
/****** Object:  StoredProcedure [dbo].[sp_GenAudSelectList]    Script Date: 09/29/2017 15:29:09 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO





CREATE  PROCEDURE [dbo].[sp_GenAudSelectList] 
@Aud_db varchar(50), 
@Aud_tbl varchar(50),
@SelectList varchar(4000) output
AS 
BEGIN
	declare @ReturnSelectList varchar(4000), @sql nvarchar(500)
	declare @tmpColum varchar(50), @tmpFieldType varchar(30)
	declare @SyObjCol varchar(100)
	declare @cnt int, @a int
		
	set @SyObjCol = @Aud_db + '..sysobjects a, ' + @Aud_db + '..syscolumns b'
	set @ReturnSelectList = ''
	

	Declare cur_Columns cursor    
	for    
	select      
		case right(b.name,10)      
			when 'actflg_aud' then left(b.name,4) + 'actflg_aud'
			else b.name + ' ,'   
		end as 'colName',
		c.name as 'FieldType' 
	from     
		UCPERPDB_AUD..sysobjects a, UCPERPDB_AUD..syscolumns b, UCPERPDB_AUD..systypes c
	where
		a.name = @Aud_tbl + '_AUD'
		and a.id = b.id
		and b.xtype = c.xtype 
		and c.xtype = c.xusertype 
	order by     
		b.colid  
	
	Open cur_Columns    
	Fetch next from cur_Columns into    
	@tmpColum, @tmpFieldType  
	While @@fetch_status = 0    
	Begin    
		set @cnt = 0

		set @sql = 'Select @a = count(1) from ' + @SyObjCol + ' WHERE a.Name = ''' + @Aud_tbl + '_AUD' + ''' AND a.ID = b.ID AND b.Name = ''' + ltrim(rtrim(left(@tmpColum,len(@tmpColum)-2))) + '''' 	

		--PRINT 'DEBUG FLAG : ' + CONVERT( nvarchar(500), @sql )

		exec   sp_executesql   @sql, N'@a int output' ,@cnt output  

		if @cnt > 0 or right(@tmpColum,10) = 'actflg_aud'
		begin
			set @ReturnSelectList = @ReturnSelectList + @tmpColum    
		end	
		else
		begin
			if @tmpFieldType = 'numeric' or @tmpFieldType = 'int' or @tmpFieldType = 'decimal' or @tmpFieldType = 'float' or 
				@tmpFieldType = 'real' or @tmpFieldType = 'tinyint' or @tmpFieldType = 'smallint' or @tmpFieldType = 'bigint'
			begin 
				set @ReturnSelectList = @ReturnSelectList + '0 as ''' + ltrim(rtrim(left(@tmpColum,len(@tmpColum)-2)))  +  ''','		
			end
			else
			begin
				set @ReturnSelectList = @ReturnSelectList + ''''' as '''+ ltrim(rtrim(left(@tmpColum,len(@tmpColum)-2))) +''','		
			end								
		end

	Fetch next from cur_Columns into    
	@tmpColum, @tmpFieldType  
	END    
	close cur_Columns    
	deallocate cur_Columns  

	set @SelectList = @ReturnSelectList
	
END






GO
GRANT EXECUTE ON [dbo].[sp_GenAudSelectList] TO [ERPUSER] AS [dbo]
GO
