/****** Object:  StoredProcedure [dbo].[sp_list_SYSCHSQL]    Script Date: 09/29/2017 15:29:09 ******/
DROP PROCEDURE [dbo].[sp_list_SYSCHSQL]
GO
/****** Object:  StoredProcedure [dbo].[sp_list_SYSCHSQL]    Script Date: 09/29/2017 15:29:10 ******/
SET ANSI_NULLS OFF
GO
SET QUOTED_IDENTIFIER ON
GO




-- Checked by Allan Yuen at 28/07/2003

/************************************************************************
Author:		Johnson Lai 
Date:		Apr 29, 2002
*************************************************************************
2005-08-25	Allan Yuen	Change @module from 2 to 5
*/

CREATE procedure [dbo].[sp_list_SYSCHSQL]
                                                                                                                                                                                                                                                               
@cocde	nvarchar(8),
@module nvarchar(5) ,
@usr	nvarchar(30)

 AS
BEGIN
SELECT

scs_select,
scs_from,
scs_where,
scs_order

from SYSCHSQL

WHERE
--scs_cocde = @cocde and
scs_module = @module

ORDER BY 
scs_module
END



GO
GRANT EXECUTE ON [dbo].[sp_list_SYSCHSQL] TO [ERPUSER] AS [dbo]
GO
