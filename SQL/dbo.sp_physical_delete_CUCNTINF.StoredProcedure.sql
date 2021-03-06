/****** Object:  StoredProcedure [dbo].[sp_physical_delete_CUCNTINF]    Script Date: 09/29/2017 15:29:09 ******/
DROP PROCEDURE [dbo].[sp_physical_delete_CUCNTINF]
GO
/****** Object:  StoredProcedure [dbo].[sp_physical_delete_CUCNTINF]    Script Date: 09/29/2017 15:29:10 ******/
SET ANSI_NULLS OFF
GO
SET QUOTED_IDENTIFIER ON
GO








/************************************************************************
Author:		Kath Ng     
Date:		5th October, 2001
Description:	Physical Delete CUCNTINF data
************************************************************************/

CREATE PROCEDURE [dbo].[sp_physical_delete_CUCNTINF] 

@cci_cocde 	nvarchar(6),
@cci_cusno 	nvarchar(6),
@cci_cnttyp 	nvarchar(6),
@cci_cntseq	int,
@Type		nvarchar(4)

AS
--------------------------------------------------------------------------------------------------------------------
IF @Type = 'DDtl'
BEGIN
/*
DELETE FROM CUCNTINF
WHERE	--cci_cocde = @cci_cocde and
 	cci_cusno = @cci_cusno
and 	cci_cnttyp = @cci_cnttyp
and 	cci_cntseq  = @cci_cntseq
*/
-- Changed by Mark Lau 20061228, as SAP implementation
update cucntinf
set cci_delete = 'Y'
WHERE	--cci_cocde = @cci_cocde and
 	cci_cusno = @cci_cusno
and 	cci_cnttyp = @cci_cnttyp
and 	cci_cntseq  = @cci_cntseq
END
--------------------------------------------------------------------------------------------------------------------

IF @Type = 'DMtr'
BEGIN
DELETE FROM CUCNTINF
WHERE	--cci_cocde = @cci_cocde and
 	cci_cusno = @cci_cusno
END
--------------------------------------------------------------------------------------------------------------------


GO
GRANT EXECUTE ON [dbo].[sp_physical_delete_CUCNTINF] TO [ERPUSER] AS [dbo]
GO
