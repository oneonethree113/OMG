/****** Object:  StoredProcedure [dbo].[sp_select_table_list]    Script Date: 09/29/2017 15:29:08 ******/
DROP PROCEDURE [dbo].[sp_select_table_list]
GO
/****** Object:  StoredProcedure [dbo].[sp_select_table_list]    Script Date: 09/29/2017 15:29:10 ******/
SET ANSI_NULLS OFF
GO
SET QUOTED_IDENTIFIER OFF
GO


CREATE PROCEDURE [dbo].[sp_select_table_list] 

@cocde 	nvarchar(6)

AS

--select * from table_list
select [table] + ' - ' + [desc] as 'table'  from table_list order by [table]


GO
GRANT EXECUTE ON [dbo].[sp_select_table_list] TO [ERPUSER] AS [dbo]
GO
