/****** Object:  StoredProcedure [dbo].[sp_list_SYMAQL]    Script Date: 09/29/2017 15:29:09 ******/
DROP PROCEDURE [dbo].[sp_list_SYMAQL]
GO
/****** Object:  StoredProcedure [dbo].[sp_list_SYMAQL]    Script Date: 09/29/2017 15:29:10 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create  PROCEDURE [dbo].[sp_list_SYMAQL] 

@ycc_cocde 	nvarchar(6) = ' '
AS

Select 
'' as 'yal_del',
*

from SYMAQL


--------------------------------


GO
GRANT EXECUTE ON [dbo].[sp_list_SYMAQL] TO [ERPUSER] AS [dbo]
GO
