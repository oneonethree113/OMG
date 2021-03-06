/****** Object:  StoredProcedure [dbo].[sp_select_SHCHGFWD]    Script Date: 09/29/2017 15:29:09 ******/
DROP PROCEDURE [dbo].[sp_select_SHCHGFWD]
GO
/****** Object:  StoredProcedure [dbo].[sp_select_SHCHGFWD]    Script Date: 09/29/2017 15:29:10 ******/
SET ANSI_NULLS OFF
GO
SET QUOTED_IDENTIFIER OFF
GO

















/************************************************************************
Author:		Marco Chan
Date:		15th February, 2011
Description:	insert data into SHCHGFWD
***********************************************************************
*/

CREATE        procedure [dbo].[sp_select_SHCHGFWD]


@scf_cocde	nvarchar(6),
@scf_docno	nvarchar(20)

 
AS

BEGIN

--------------------------------------------------------------------------------------------------

	select 
scf_docno,
scf_fwdnam,
scf_fwdinv,
isnull(scf_ttlamt,0) as 'scf_ttlamt',
scf_fcurcde,
scf_fcrno,
scf_rmk,
scf_exrate,
--0 as 'total',
scf_creusr,
scf_updusr,
scf_credat,
scf_upddat,
scf_timstp,
'' as 'DEL'

	from SHCHGFWD
	where scf_docno = @scf_docno

END















GO
GRANT EXECUTE ON [dbo].[sp_select_SHCHGFWD] TO [ERPUSER] AS [dbo]
GO
