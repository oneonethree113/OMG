/****** Object:  StoredProcedure [dbo].[sp_update_CUSUBCUS]    Script Date: 09/29/2017 15:29:08 ******/
DROP PROCEDURE [dbo].[sp_update_CUSUBCUS]
GO
/****** Object:  StoredProcedure [dbo].[sp_update_CUSUBCUS]    Script Date: 09/29/2017 15:29:10 ******/
SET ANSI_NULLS OFF
GO
SET QUOTED_IDENTIFIER ON
GO






/************************************************************************
Author:		Kath Ng     
Date:		17th October, 2001
Description:	Update data into CUSUBCUS
************************************************************************/

CREATE PROCEDURE [dbo].[sp_update_CUSUBCUS] 
--------------------------------------------------------------------------------------------------------------------------------------

@csc_cocde	nvarchar(6),
@csc_prmcus	nvarchar(6),
@csc_seccus	nvarchar(6),
@csc_cusrel	nvarchar(1),
@csc_updusr	nvarchar(30)

AS

------------------------------------------------------------------------------------------
--IF @Type = 1 BEGIN	-- For Primary Customer
	
UPDATE CUSUBCUS
SET	csc_cusrel = @csc_cusrel,
	csc_updusr = @csc_updusr,	
	csc_upddat = getdate()
WHERE
	--csc_cocde = @csc_cocde and
	csc_prmcus = @csc_prmcus
and	csc_seccus = @csc_seccus

--END

------------------------------------------------------------------------------------------------------------------------------------------------------------








GO
GRANT EXECUTE ON [dbo].[sp_update_CUSUBCUS] TO [ERPUSER] AS [dbo]
GO
