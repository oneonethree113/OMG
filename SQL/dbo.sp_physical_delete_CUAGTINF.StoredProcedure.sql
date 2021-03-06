/****** Object:  StoredProcedure [dbo].[sp_physical_delete_CUAGTINF]    Script Date: 09/29/2017 15:29:09 ******/
DROP PROCEDURE [dbo].[sp_physical_delete_CUAGTINF]
GO
/****** Object:  StoredProcedure [dbo].[sp_physical_delete_CUAGTINF]    Script Date: 09/29/2017 15:29:10 ******/
SET ANSI_NULLS OFF
GO
SET QUOTED_IDENTIFIER OFF
GO



-- Checked by Allan Yuen at 28/07/2003



/************************************************************************
Author:		Kath Ng     
Date:		19th October, 2001
Description:	Physical Delete CUAGTINF data
************************************************************************/

CREATE PROCEDURE [dbo].[sp_physical_delete_CUAGTINF] 

@cai_cocde	nvarchar(6),
@cai_cusno	nvarchar(6),
@cai_cusagt	nvarchar(6),
@Type		nvarchar(4)

AS
------------------------------------------------------------------------------------------------------------------------------
IF @Type = 'DDtl'		--- Delete Agent Information only
BEGIN
DELETE FROM CUAGTINF
WHERE 	
--cai_cocde = @cai_cocde AND 	
cai_cusno = @cai_cusno
AND 	cai_cusagt = @cai_cusagt
END
------------------------------------------------------------------------------------------------------------------------------

IF @Type = 'DMtr'		---Delete Customer  Master 
BEGIN
DELETE FROM CUAGTINF
WHERE 	
	--cai_cocde = @cai_cocde AND 	
	cai_cusno = @cai_cusno
END
------------------------------------------------------------------------------------------------------------------------------







GO
GRANT EXECUTE ON [dbo].[sp_physical_delete_CUAGTINF] TO [ERPUSER] AS [dbo]
GO
