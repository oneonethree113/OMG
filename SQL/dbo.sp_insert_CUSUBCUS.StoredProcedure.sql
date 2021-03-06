/****** Object:  StoredProcedure [dbo].[sp_insert_CUSUBCUS]    Script Date: 09/29/2017 15:29:09 ******/
DROP PROCEDURE [dbo].[sp_insert_CUSUBCUS]
GO
/****** Object:  StoredProcedure [dbo].[sp_insert_CUSUBCUS]    Script Date: 09/29/2017 15:29:09 ******/
SET ANSI_NULLS OFF
GO
SET QUOTED_IDENTIFIER OFF
GO




-- Checked by Allan Yuen at 28/07/2003


/************************************************************************
Author:		Kath Ng     
Date:		17th October, 2001
Description:	Insert data into CUSUBCUS
************************************************************************/

CREATE PROCEDURE [dbo].[sp_insert_CUSUBCUS] 
--------------------------------------------------------------------------------------------------------------------------------------

@csc_cocde	nvarchar(6),
@csc_prmcus	nvarchar(6),
@csc_seccus	nvarchar(6),
@csc_cusrel	nvarchar(1),
@csc_updusr	nvarchar(30)

--------------------------------------------------------------------------------------------------------------------------------------
AS


INSERT INTO  CUSUBCUS
(
csc_cocde,	csc_prmcus,	csc_seccus,
csc_cusrel,	csc_creusr,	csc_updusr,
csc_credat,	csc_upddat
)
--------------------------------------------------------------------------------------------------------------------------------------
values
(
--@csc_cocde,
' ',	@csc_prmcus,	@csc_seccus,
@csc_cusrel,	@csc_updusr,	@csc_updusr,
getdate(),	getdate()
)








GO
GRANT EXECUTE ON [dbo].[sp_insert_CUSUBCUS] TO [ERPUSER] AS [dbo]
GO
