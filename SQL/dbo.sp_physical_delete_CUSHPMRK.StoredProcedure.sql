/****** Object:  StoredProcedure [dbo].[sp_physical_delete_CUSHPMRK]    Script Date: 09/29/2017 15:29:09 ******/
DROP PROCEDURE [dbo].[sp_physical_delete_CUSHPMRK]
GO
/****** Object:  StoredProcedure [dbo].[sp_physical_delete_CUSHPMRK]    Script Date: 09/29/2017 15:29:10 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO







/************************************************************************
Author:		Kath Ng     
Date:		5th October, 2001
Description:	Physical Delete CUSHPMRK data
Parameter:	1. Company Code range    
		2. Customer Code range    
		3. Ship Mark Type
		4. Seq No
************************************************************************/

CREATE PROCEDURE [dbo].[sp_physical_delete_CUSHPMRK] 

@csm_cocde	nvarchar(6),
@csm_cusno	nvarchar(6),
@csm_shptyp	nvarchar(30),
@csm_seqno	int,
@Type		nvarchar(4)

AS

----------------------------------------------------------------------------------------------------------------
IF @Type = 'DDtl'
BEGIN
DELETE FROM CUSHPMRK
WHERE 	--csm_cocde = @csm_cocde AND
 	csm_cusno = @csm_cusno
AND 	csm_shptyp = @csm_shptyp
AND 	csm_seqno = @csm_seqno
END
----------------------------------------------------------------------------------------------------------------
IF @Type = 'DMtr'
BEGIN
DELETE FROM CUSHPMRK
WHERE 	--csm_cocde = @csm_cocde AND
 	csm_cusno = @csm_cusno
END
----------------------------------------------------------------------------------------------------------------







GO
GRANT EXECUTE ON [dbo].[sp_physical_delete_CUSHPMRK] TO [ERPUSER] AS [dbo]
GO
