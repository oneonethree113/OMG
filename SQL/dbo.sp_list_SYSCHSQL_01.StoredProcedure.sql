/****** Object:  StoredProcedure [dbo].[sp_list_SYSCHSQL_01]    Script Date: 09/29/2017 15:29:09 ******/
DROP PROCEDURE [dbo].[sp_list_SYSCHSQL_01]
GO
/****** Object:  StoredProcedure [dbo].[sp_list_SYSCHSQL_01]    Script Date: 09/29/2017 15:29:10 ******/
SET ANSI_NULLS OFF
GO
SET QUOTED_IDENTIFIER ON
GO



-- Checked by Allan Yuen at 28/07/2003

/************************************************************************
Author:		Johnson Lai 
Date:		Apr 29, 2002
************************************************************************/

CREATE procedure [dbo].[sp_list_SYSCHSQL_01]
                                                                                                                                                                                                                                                               
@cocde	nvarchar(8),
@sql	nvarchar(4000) ,
@usr	nvarchar(30)

 AS
BEGIN

exec(@sql)

END




GO
GRANT EXECUTE ON [dbo].[sp_list_SYSCHSQL_01] TO [ERPUSER] AS [dbo]
GO
