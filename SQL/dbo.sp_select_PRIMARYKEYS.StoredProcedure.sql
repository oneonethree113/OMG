/****** Object:  StoredProcedure [dbo].[sp_select_PRIMARYKEYS]    Script Date: 09/29/2017 15:29:09 ******/
DROP PROCEDURE [dbo].[sp_select_PRIMARYKEYS]
GO
/****** Object:  StoredProcedure [dbo].[sp_select_PRIMARYKEYS]    Script Date: 09/29/2017 15:29:10 ******/
SET ANSI_NULLS OFF
GO
SET QUOTED_IDENTIFIER OFF
GO







/*	Procedure for 8.0 server */
CREATE PROCEDURE [dbo].[sp_select_PRIMARYKEYS](
			   @cocde nvarchar(6),	
			   @table_name		sysname,
			   @table_owner 	sysname = null,
			   @table_qualifier sysname = null )
as
	DECLARE @table_id		int
	DECLARE @full_table_name	nvarchar(255)

	if @table_qualifier is not null
    begin
		if db_name() <> @table_qualifier
		begin	/* If qualifier doesn't match current database */
			raiserror (15250, -1,-1)
			return
		end
    end
	if @table_owner is null
	begin	/* If unqualified table name */
		SELECT @full_table_name = quotename(@table_name)
    end
    else
	begin	/* Qualified table name */
		if @table_owner = ''
		begin	/* If empty owner name */
			SELECT @full_table_name = quotename(@table_owner)
		end
		else
		begin
			SELECT @full_table_name = quotename(@table_owner) +
				'.' + quotename(@table_name)
		end
    end
	/*	Get Object ID */
	SELECT @table_id = object_id(@full_table_name)

    select
		TABLE_QUALIFIER = convert(sysname,db_name()),
		TABLE_OWNER = convert(sysname,user_name(o.uid)),
		TABLE_NAME = convert(sysname,o.name),
		COLUMN_NAME = convert(sysname,c.name),
		case 	c.xtype when 231 then 
			c.length/2 
		else	c.length
		end,	
		--KEY_SEQ = convert(smallint,c.colid),
		KEY_SEQ =
			case
				when c.name = index_col(@full_table_name, i.indid,  1) then convert (smallint,1)
				when c.name = index_col(@full_table_name, i.indid,  2) then convert (smallint,2)
				when c.name = index_col(@full_table_name, i.indid,  3) then convert (smallint,3)
				when c.name = index_col(@full_table_name, i.indid,  4) then convert (smallint,4)
				when c.name = index_col(@full_table_name, i.indid,  5) then convert (smallint,5)
				when c.name = index_col(@full_table_name, i.indid,  6) then convert (smallint,6)
				when c.name = index_col(@full_table_name, i.indid,  7) then convert (smallint,7)
				when c.name = index_col(@full_table_name, i.indid,  8) then convert (smallint,8)
				when c.name = index_col(@full_table_name, i.indid,  9) then convert (smallint,9)
				when c.name = index_col(@full_table_name, i.indid, 10) then convert (smallint,10)
				when c.name = index_col(@full_table_name, i.indid, 11) then convert (smallint,11)
				when c.name = index_col(@full_table_name, i.indid, 12) then convert (smallint,12)
				when c.name = index_col(@full_table_name, i.indid, 13) then convert (smallint,13)
				when c.name = index_col(@full_table_name, i.indid, 14) then convert (smallint,14)
				when c.name = index_col(@full_table_name, i.indid, 15) then convert (smallint,15)
				when c.name = index_col(@full_table_name, i.indid, 16) then convert (smallint,16)
			end,
		PK_NAME = convert(sysname,i.name)
	from
		sysindexes i, syscolumns c, sysobjects o --, syscolumns c1
	where
		o.id = @table_id
		and o.id = c.id
		and o.id = i.id
		and (i.status & 0x800) = 0x800
		--and c.name = index_col (@full_table_name, i.indid, c1.colid)
		and (c.name = index_col (@full_table_name, i.indid,  1) or
		     c.name = index_col (@full_table_name, i.indid,  2) or
		     c.name = index_col (@full_table_name, i.indid,  3) or
		     c.name = index_col (@full_table_name, i.indid,  4) or
		     c.name = index_col (@full_table_name, i.indid,  5) or
		     c.name = index_col (@full_table_name, i.indid,  6) or
		     c.name = index_col (@full_table_name, i.indid,  7) or
		     c.name = index_col (@full_table_name, i.indid,  8) or
		     c.name = index_col (@full_table_name, i.indid,  9) or
		     c.name = index_col (@full_table_name, i.indid, 10) or
		     c.name = index_col (@full_table_name, i.indid, 11) or
		     c.name = index_col (@full_table_name, i.indid, 12) or
		     c.name = index_col (@full_table_name, i.indid, 13) or
		     c.name = index_col (@full_table_name, i.indid, 14) or
		     c.name = index_col (@full_table_name, i.indid, 15) or
		     c.name = index_col (@full_table_name, i.indid, 16)
		    )
		--and c1.colid <= i.keycnt	/* create rows from 1 to keycnt */
		--and c1.id = @table_id
	order by 1, 2, 3, 6






GO
GRANT EXECUTE ON [dbo].[sp_select_PRIMARYKEYS] TO [ERPUSER] AS [dbo]
GO
