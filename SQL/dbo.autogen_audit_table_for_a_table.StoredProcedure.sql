/****** Object:  StoredProcedure [dbo].[autogen_audit_table_for_a_table]    Script Date: 09/29/2017 15:29:09 ******/
DROP PROCEDURE [dbo].[autogen_audit_table_for_a_table]
GO
/****** Object:  StoredProcedure [dbo].[autogen_audit_table_for_a_table]    Script Date: 09/29/2017 15:29:09 ******/
SET ANSI_NULLS OFF
GO
SET QUOTED_IDENTIFIER OFF
GO







/*
'***
'***  Author : Philip YU
'***  Creation Date : 28-June-2000
'***  Description : To generate the Audit table structure and then create the index on the Auidt table
'***  Logic : 1.  Input the table name
'***
'***
'***  Modification History :Kenny Chan
'***  Modified by  :28-8-2001	
'***  Modified on  :To add one more field 'actflg' for audit table
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
CREATE PROCEDURE [dbo].[autogen_audit_table_for_a_table]
@table_name nvarchar(20)
AS
set nocount on
--if exists (select * from sysobjects where id = object_id(@table_name + '_AUD') and OBJECTPROPERTY(id, N'IsUserTable') = 1)
 --RETURN
declare @pk_count int
declare @credat nvarchar(20)
set @table_name = upper(@table_name)
select 'if exists (select * from sysobjects where id = object_id(''' + @table_name + '_AUD'') and OBJECTPROPERTY(id, ''IsUserTable'') = 1)'
select 'drop table ' + @table_name + '_AUD'
select 'GO'
select 'Create table [' + @table_name + '_AUD] ('
select
a.name + ' ' + b.name  -- build the columns
+
case b.name when 'numeric' then ' (' + convert(nvarchar(3),a.prec) + ',' + convert(nvarchar(3),a.scale) + ')' -- get the field length for different data type
  when 'nvarchar' then ' (' + convert(nvarchar(3),a.prec) +')'
  else ''  
  end
+
case b.name When 'timestamp' then  
      ' NOT NULL'
  else
      ' NOT NULL DEFAULT (' 
  end
+
case b.name when 'numeric' then '0'
  when 'int' then '0'
  when 'tinyint' then '0'
  when 'timestamp' then ''
  when 'datetime' then
    case right(a.name,6) when 'credat' then 'getdate()'
    else "''"
    end
  else "''"
  end
+ 
case b.name when 'timestamp' then
 ''
else
')' 
end
+
case right(a.name,6) when 'timstp' then + char(13) + ' ,' + left(a.name,3) + '_actflg_aud tinyint NOT NULL DEFAULT (0)' -- since lckflg is the last field in a table, so no comma is needed to append
  else ' ,'
  end
from syscolumns a, systypes b
where a.id = object_id(@table_name)
and a.xtype = b.xtype -- make sure the data type in match in both table
and b.name <> 'sysname'
order by a.colid

select ') ON [PRIMARY]'
select 'GO'
select 'create index [IX_1_' + @table_name + '_AUD] on ' + @table_name + '_AUD ('
select @pk_count = count(*)
from syscolumns a, sysindexes b, syscolumns c
where a.id = object_id(@table_name)
and b.id = object_id(@table_name)
and c.id = object_id(@table_name)
and (b.status & 0x800) = 0x800
and a.name = index_col (@table_name, b.indid, c.colid)
select a.name +
case a.colid when @pk_count then ''
  else ' ,'
  end
from syscolumns a, sysindexes b, syscolumns c
where a.id = object_id(@table_name)
and b.id = object_id(@table_name)
and c.id = object_id(@table_name)
and (b.status & 0x800) = 0x800
and a.name = index_col (@table_name, b.indid, c.colid)
order by a.colid
select ') ON [PRIMARY]'
select 'GO'
select 'create index [IX_2_' + @table_name + '_AUD] on ' + @table_name + '_AUD ('
select @credat = name
from syscolumns
where id = object_id(@table_name)
and right(name,6) = 'credat'
select @credat
select ') ON [PRIMARY]'
select 'GO'
set nocount off






GO
GRANT EXECUTE ON [dbo].[autogen_audit_table_for_a_table] TO [ERPUSER] AS [dbo]
GO
