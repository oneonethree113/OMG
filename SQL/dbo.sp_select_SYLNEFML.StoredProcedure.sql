/****** Object:  StoredProcedure [dbo].[sp_select_SYLNEFML]    Script Date: 09/29/2017 15:29:08 ******/
DROP PROCEDURE [dbo].[sp_select_SYLNEFML]
GO
/****** Object:  StoredProcedure [dbo].[sp_select_SYLNEFML]    Script Date: 09/29/2017 15:29:10 ******/
SET ANSI_NULLS OFF
GO
SET QUOTED_IDENTIFIER OFF
GO






/*********************************************
***	Author:	Kath
***	SP Name:	sp_Select SYLNEFML
***	Date:	24th September, 2001
***	Purpose:	Retreive data from SYLNEFML
*********************************************/


CREATE PROCEDURE [dbo].[sp_select_SYLNEFML]

@ylf_cocde	nvarchar(6),
@ylf_lnecde	nvarchar(12)

AS
---------------------------------------------------------------
Select

* 

From SYLNEFML

---------------------------------------------------------------

where

ylf_cocde = @ylf_cocde and
ylf_lnecde = @ylf_lnecde






GO
GRANT EXECUTE ON [dbo].[sp_select_SYLNEFML] TO [ERPUSER] AS [dbo]
GO
