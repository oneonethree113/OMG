/****** Object:  StoredProcedure [dbo].[sp_Search_Customer]    Script Date: 09/29/2017 15:29:09 ******/
DROP PROCEDURE [dbo].[sp_Search_Customer]
GO
/****** Object:  StoredProcedure [dbo].[sp_Search_Customer]    Script Date: 09/29/2017 15:29:10 ******/
SET ANSI_NULLS OFF
GO
SET QUOTED_IDENTIFIER OFF
GO




/************************************************************************
Author:		Kath Ng     
Date:		17th December, 2001
Description:	Search Customer (By Customer No, Customer Name and Short Name)
************************************************************************/

CREATE PROCEDURE [dbo].[sp_Search_Customer]

@Cocde		nvarchar(6),
@Cusno		nvarchar(6),
@CusName	nvarchar(20)


AS

declare @s nvarchar(1000)

set @s = ''
set @s = @s + 'select distinct cbi_cusno, cbi_cussna, cbi_cusnam  from  CUBASINF'

set @s = @s + 'where cbi_cocde = ''' + @Cocde + ''' and '

if @Cusno <> ''
	set @s = @s + 'cbi_cusno like ''' + @Cusno + ''' and '

if @CusName <> ''
	set @s = @s + 'cbi_cusna1 like ''' + @CusName + ''' and '

--if @Contact <> ''
	--set @s = @s + 'cbi_conct1like ''' + @Contact + ''' and '


set @s =  left(@s , len(@s)-4)

set @s = @s + 'order by cbi_cusno, cbi_cusna1, cbi_conct1'

exec(@s)
 
--select @s




GO
GRANT EXECUTE ON [dbo].[sp_Search_Customer] TO [ERPUSER] AS [dbo]
GO
