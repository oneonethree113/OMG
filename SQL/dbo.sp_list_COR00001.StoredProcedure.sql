/****** Object:  StoredProcedure [dbo].[sp_list_COR00001]    Script Date: 09/29/2017 15:29:09 ******/
DROP PROCEDURE [dbo].[sp_list_COR00001]
GO
/****** Object:  StoredProcedure [dbo].[sp_list_COR00001]    Script Date: 09/29/2017 15:29:09 ******/
SET ANSI_NULLS OFF
GO
SET QUOTED_IDENTIFIER OFF
GO



-- Checked by Allan Yuen at 28/07/2003

CREATE PROCEDURE [dbo].[sp_list_COR00001] 

@cocde 	nvarchar(6)

AS


DECLARE 
@field  	nvarchar(20),
@from	nvarchar(30),
@to	nvarchar(30),
@fieldtype		nvarchar(20),
@fieldlength	nvarchar(20)

set @field = ''
set @from = ''
set @to = ''
set @fieldtype = ''
set @fieldlength = ''

select @field as 'field', @from as 'from', @to as 'to', @fieldtype as 'fieldtype', @fieldlength as 'fieldlength'



GO
GRANT EXECUTE ON [dbo].[sp_list_COR00001] TO [ERPUSER] AS [dbo]
GO
