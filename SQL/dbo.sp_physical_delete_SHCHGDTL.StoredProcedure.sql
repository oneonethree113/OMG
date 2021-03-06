/****** Object:  StoredProcedure [dbo].[sp_physical_delete_SHCHGDTL]    Script Date: 09/29/2017 15:29:09 ******/
DROP PROCEDURE [dbo].[sp_physical_delete_SHCHGDTL]
GO
/****** Object:  StoredProcedure [dbo].[sp_physical_delete_SHCHGDTL]    Script Date: 09/29/2017 15:29:10 ******/
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


CREATE  procedure [dbo].[sp_physical_delete_SHCHGDTL]

@scd_cocde	nvarchar(6),
@scd_docno	nvarchar(20),
@scd_fwdnam	nvarchar(200),
@scd_venno	nvarchar(6),
@scd_chgcde	nvarchar(20),
@scd_curcde	nvarchar(10)

 
AS

BEGIN

--------------------------------------------------------------------------------------------------
if @scd_venno = 'ALL'
begin
	delete FROM	SHCHGDTL WHERE	scd_docno = @scd_docno
						and scd_fwdnam = @scd_fwdnam
end
else
begin
	if @scd_chgcde = 'ALL'
	begin
		delete from SHCHGDTL where scd_docno = @scd_docno and scd_venno = @scd_venno
					and scd_fwdnam = @scd_fwdnam
	end
	else
	begin
		delete from SHCHGDTL where scd_docno = @scd_docno and scd_venno = @scd_venno and scd_chgcde = @scd_chgcde and scd_curcde = @scd_curcde
					and scd_fwdnam = @scd_fwdnam
	end
end

END









GO
GRANT EXECUTE ON [dbo].[sp_physical_delete_SHCHGDTL] TO [ERPUSER] AS [dbo]
GO
