/****** Object:  StoredProcedure [dbo].[autogen_select_for_a_table]    Script Date: 09/29/2017 15:29:09 ******/
DROP PROCEDURE [dbo].[autogen_select_for_a_table]
GO
/****** Object:  StoredProcedure [dbo].[autogen_select_for_a_table]    Script Date: 09/29/2017 15:29:09 ******/
SET ANSI_NULLS OFF
GO
SET QUOTED_IDENTIFIER OFF
GO






/*
'***
'***  Author : Philip YU
'***  Creation Date : 22-June-2000
'***  Description : To generate the select store procedure ('sp_select_') for a table
'***  Logic : 1.  Input the table name
'***
'***
'***  Modification History :
'***  Modified by  :
'***  Modified on  :
'***  Modification description :
'***
'***
'***  Note : Information about the auto-generated scripts :
'***   1. The primary key(s) in the table must have the smallest colid.
'***   2. The rightmost 3 characters of the sequence number in the primary key(s) if exists, should be 'seq'.
'***   3. The sequence number in the primary key(s) if exists, must have the last colid within the primary key(s).
'***   4. The usrid, credat, upddat and lckflg must be the last four columns in the table.
'***   5. The name of the display sequence in the table must be 'disply'.
*/
CREATE PROCEDURE [dbo].[autogen_select_for_a_table]
@table_name nvarchar(20)
AS
set nocount on
declare @final nvarchar(20)
declare @dispseq nvarchar(20)
set @table_name = upper(@table_name)
select 'if exists (select * from sysobjects where id = object_id(''sp_select_' + @table_name + ''') and OBJECTPROPERTY(id, ''IsProcedure'') = 1)'
select 'drop procedure [sp_select_' + @table_name + ']'
select 'GO'
select 'Create procedure [sp_select_' + @table_name + ']'
select
'@' + a.name + ' ' + b.name +
case b.name when 'numeric' then '(' + convert(nvarchar(2),a.prec) + ',' + convert(nvarchar(2),a.scale) + ') ,'
  when 'nvarchar' then '(' + convert(nvarchar(2),a.prec) +') ,'
  else ' ,'
  end
from syscolumns a, systypes b, sysindexes c, syscolumns d
where a.id = object_id(@table_name)
and c.id = object_id(@table_name)
and d.id = object_id(@table_name)
and a.xtype = b.xtype
and b.name <> 'sysname'
and (c.status & 0x800) = 0x800
and a.name = index_col (@table_name, c.indid, d.colid)
and right(a.name,3) <> 'seq'
order by a.colid
select  char(13) + '@lock int' + char(13) + ' ' + char(13) + 'AS' + char(13) + ' ' + char(13) + 'if @lock = 0' + char(13) + 'begin' + char(13) + ' Select *'
select ' from ' + @table_name + char(13) + ' where'
select ' ' + a.name + ' = @' + a.name + ' and'
from syscolumns a, sysindexes b, syscolumns c
where a.id = object_id(@table_name)
and b.id = object_id(@table_name)
and c.id = object_id(@table_name)
and (b.status & 0x800) = 0x800
and a.name = index_col (@table_name, b.indid, c.colid)
and right(a.name,3) <> 'seq'
order by a.colid
select @final = name
from syscolumns
where id = object_id(@table_name)
and colid = 
 (select  max(colid)
 from syscolumns
 where id = object_id(@table_name)
 )
select ' ' + @final + ' <> 9'
---------------------------------
-- Generate display sequence
---------------------------------
select @dispseq = name
from syscolumns
where id = object_id(@table_name)
and right(name,6) = 'disply'
if @dispseq <> ''
 select ' order by ' + @dispseq
---------------------------------
select 'end' + char(13) + 'else' + char(13) + 'begin' + char(13) + ' Select *' + char(13) + ' from ' + @table_name + char(13) +' where'
select ' ' + a.name + ' = @' + a.name + ' and'
from syscolumns a, sysindexes b, syscolumns c
where a.id = object_id(@table_name)
and b.id = object_id(@table_name)
and c.id = object_id(@table_name)
and (b.status & 0x800) = 0x800
and a.name = index_col (@table_name, b.indid, c.colid)
and right(a.name,3) <> 'seq'
order by a.colid
select ' ' + @final + ' <> 9'
---------------------------------
-- Generate display sequence
---------------------------------
if @dispseq <> ''
 select ' order by ' + @dispseq
select ' if @@rowcount <> 0' + char(13) +
'  update ' + @table_name + char(13) +
'  set ' + @final + ' = 1' + char(13) +
'  where'
select '  ' + a.name + ' = @' + a.name + ' and'
from syscolumns a, sysindexes b, syscolumns c
where a.id = object_id(@table_name)
and b.id = object_id(@table_name)
and c.id = object_id(@table_name)
and (b.status & 0x800) = 0x800
and a.name = index_col (@table_name, b.indid, c.colid)
and right(a.name,3) <> 'seq'
order by a.colid
select char(13) + '  ' + @final + ' = 0' + char(13) + 'end'
select 'GO'
set nocount off






GO
GRANT EXECUTE ON [dbo].[autogen_select_for_a_table] TO [ERPUSER] AS [dbo]
GO
