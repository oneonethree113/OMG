/****** Object:  StoredProcedure [dbo].[sp_insert_SHCHGFWD]    Script Date: 09/29/2017 15:29:09 ******/
DROP PROCEDURE [dbo].[sp_insert_SHCHGFWD]
GO
/****** Object:  StoredProcedure [dbo].[sp_insert_SHCHGFWD]    Script Date: 09/29/2017 15:29:09 ******/
SET ANSI_NULLS OFF
GO
SET QUOTED_IDENTIFIER ON
GO














/************************************************************************
Author:		Marco Chan
Date:		15th February, 2011
Description:	insert data into SHCHGFWD
***********************************************************************
*/

CREATE     procedure [dbo].[sp_insert_SHCHGFWD]
@scf_docno nvarchar(20),
@scf_fwdnam nvarchar(200),
@scf_fwdinv nvarchar(200),
@scf_fcrno nvarchar(200),
@scf_fcurcde nvarchar(10),
@scf_exrate decimal(9,4),
@scf_rmk nvarchar(1000),
@scf_ttlamt decimal(13,4),
@scf_creusr	nvarchar(30)

AS

BEGIN

--------------------------------------------------------------------------------------------------


insert into SHCHGFWD
(
scf_docno,
scf_fwdnam,
scf_fwdinv,
scf_fcrno,
scf_fcurcde,
scf_exrate,
scf_rmk,
scf_ttlamt,
scf_creusr,
scf_updusr,
scf_credat,
scf_upddat

)
values
(
@scf_docno,
@scf_fwdnam,
@scf_fwdinv,
@scf_fcrno,
@scf_fcurcde,
@scf_exrate,
@scf_rmk,
@scf_ttlamt,
@scf_creusr,
@scf_creusr,
getdate(),
getdate()
)

END




GO
GRANT EXECUTE ON [dbo].[sp_insert_SHCHGFWD] TO [ERPUSER] AS [dbo]
GO
