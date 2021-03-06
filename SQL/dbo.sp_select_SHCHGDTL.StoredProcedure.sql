/****** Object:  StoredProcedure [dbo].[sp_select_SHCHGDTL]    Script Date: 09/29/2017 15:29:09 ******/
DROP PROCEDURE [dbo].[sp_select_SHCHGDTL]
GO
/****** Object:  StoredProcedure [dbo].[sp_select_SHCHGDTL]    Script Date: 09/29/2017 15:29:10 ******/
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

CREATE    procedure [dbo].[sp_select_SHCHGDTL]


@scd_cocde	nvarchar(6),
@scd_docno	nvarchar(20),
@scd_venno	nvarchar(6),
@scd_chgcde	nvarchar(20)

 
AS

BEGIN

--------------------------------------------------------------------------------------------------

if @scd_venno = 'ALL'
begin
	select 
	scd_docno,
	scd_fwdnam,
	scd_venno,
	isnull(vbi_vensna,'') 'scd_vensna',
	scd_chgcde,
	scd_syscbm,
	scd_mancbm,
	scd_curcde,
	scd_fee,
	scd_creusr,
	scd_updusr,
	scd_credat,
	scd_upddat,
	scd_timstp
	from SHCHGDTL
	left join VNBASINF on vbi_venno = scd_venno
	where scd_docno = @scd_docno
end
else
begin
	select 
	scd_docno,
	scd_fwdnam,
	scd_venno,
	isnull(vbi_vensna,'') 'scd_vensna',
	scd_chgcde,
	scd_syscbm,
	scd_mancbm,
	scd_curcde,
	scd_fee,
	scd_creusr,
	scd_updusr,
	scd_credat,
	scd_upddat,
	scd_timstp
	from SHCHGDTL
	left join VNBASINF on vbi_venno = scd_venno
	where scd_docno = @scd_docno and scd_venno = @scd_venno and scd_chgcde = @scd_chgcde

end


END











GO
GRANT EXECUTE ON [dbo].[sp_select_SHCHGDTL] TO [ERPUSER] AS [dbo]
GO
