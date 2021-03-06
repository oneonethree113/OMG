/****** Object:  StoredProcedure [dbo].[sp_insert_SHCHGDTL]    Script Date: 09/29/2017 15:29:09 ******/
DROP PROCEDURE [dbo].[sp_insert_SHCHGDTL]
GO
/****** Object:  StoredProcedure [dbo].[sp_insert_SHCHGDTL]    Script Date: 09/29/2017 15:29:09 ******/
SET ANSI_NULLS OFF
GO
SET QUOTED_IDENTIFIER OFF
GO











/************************************************************************
Author:		Marco Chan
Date:		15th February, 2011
Description:	insert data into SHCHGDTL
***********************************************************************
*/

CREATE  procedure [dbo].[sp_insert_SHCHGDTL]
@scd_cocde	nvarchar(6),
@scd_docno	nvarchar(20),
@scd_fwdnam	nvarchar(200),
@scd_venno	nvarchar(6),
@scd_chgcde	nvarchar(20),
@scd_syscbm	numeric(13,4),
@scd_mancbm	numeric(13,4),
@scd_curcde	nvarchar(6),
@scd_fee	numeric(13,4),
@scd_creusr	nvarchar(30)

AS

BEGIN

--------------------------------------------------------------------------------------------------


insert into SHCHGDTL
(
scd_docno,
scd_fwdnam,
scd_venno,
scd_chgcde,
scd_syscbm,
scd_mancbm,
scd_curcde,
scd_fee,
scd_creusr,
scd_updusr,
scd_credat,
scd_upddat
)
values
(
@scd_docno,
@scd_fwdnam,
@scd_venno,
@scd_chgcde,
@scd_syscbm,
@scd_mancbm,
@scd_curcde,
@scd_fee,
@scd_creusr,
@scd_creusr,
getdate(),
getdate()
)

END










GO
GRANT EXECUTE ON [dbo].[sp_insert_SHCHGDTL] TO [ERPUSER] AS [dbo]
GO
