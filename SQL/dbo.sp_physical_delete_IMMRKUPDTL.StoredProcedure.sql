/****** Object:  StoredProcedure [dbo].[sp_physical_delete_IMMRKUPDTL]    Script Date: 09/29/2017 15:29:09 ******/
DROP PROCEDURE [dbo].[sp_physical_delete_IMMRKUPDTL]
GO
/****** Object:  StoredProcedure [dbo].[sp_physical_delete_IMMRKUPDTL]    Script Date: 09/29/2017 15:29:10 ******/
SET ANSI_NULLS OFF
GO
SET QUOTED_IDENTIFIER OFF
GO





CREATE PROCEDURE [dbo].[sp_physical_delete_IMMRKUPDTL] 

@imd_cocde	nvarchar(6),
@imd_itmno 	nvarchar(20),
@imd_typ	nvarchar(4),
@imd_ventyp	nvarchar(4),
@imd_venno	nvarchar(6),
@imd_prdven	nvarchar(6),
@imd_cus1no	nvarchar(20),
@imd_cus2no	nvarchar(20),
@imd_pckseq	int


AS

delete from IMMRKUPDTL
where 	
--imu_cocde = @imu_cocde and
 	imd_itmno = @imd_itmno
and	imd_typ = @imd_typ 
and	imd_ventyp = @imd_ventyp
and	imd_venno = @imd_venno
and	imd_prdven = @imd_prdven
and 	imd_pckseq = @imd_pckseq
and	imd_cus1no = @imd_cus1no
and 	imd_cus2no = @imd_cus2no



GO
GRANT EXECUTE ON [dbo].[sp_physical_delete_IMMRKUPDTL] TO [ERPUSER] AS [dbo]
GO
