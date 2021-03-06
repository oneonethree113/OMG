/****** Object:  StoredProcedure [dbo].[sp_select_IMPRCINF_ftycst2]    Script Date: 09/29/2017 15:29:09 ******/
DROP PROCEDURE [dbo].[sp_select_IMPRCINF_ftycst2]
GO
/****** Object:  StoredProcedure [dbo].[sp_select_IMPRCINF_ftycst2]    Script Date: 09/29/2017 15:29:10 ******/
SET ANSI_NULLS OFF
GO
SET QUOTED_IDENTIFIER OFF
GO





/************************************************************************
Author:		Carlos Lui
Date:		09 Jul, 2012
Description:	Select Factory Cost From IMPRCINF
Parameter:	
************************************************************************

*/
------------------------------------------------- 
CREATE  procedure [dbo].[sp_select_IMPRCINF_ftycst2]
                                                                                                                                                                                                                                                                 
---------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------- 
@imu_cocde 	nvarchar(6) ,
@imu_itmno 	nvarchar(20),
@imu_pckunt 	nvarchar(6),
@imu_inrqty 	int,
@imu_mtrqty 	int,
@imu_cus1no	nvarchar(6),
@imu_cus2no	nvarchar(6),
@imu_hkprctrm	nvarchar(10),
@imu_ftyprctrm	nvarchar(10),
@imu_trantrm	nvarchar(10),
@dummy		nvarchar(1)

---------------------------------------------- 
 
AS

select	imu_ftycst,		imu_curcde
from	imprcinf
where	imu_itmno = @imu_itmno				and
--	imu_status = 'ACT'					and
	imu_pckunt = @imu_pckunt				and
	imu_inrqty = @imu_inrqty				and
	imu_mtrqty= @imu_mtrqty				and
	imu_ventyp = 'D'					--and
--	imu_cus1no = @imu_cus1no				and
--	imu_cus2no = @imu_cus2no				and
--	imu_hkprctrm = @imu_hkprctrm				and
--	imu_ftyprctrm = @imu_ftyprctrm				and
--	imu_trantrm = @imu_trantrm				and
--	imu_effdat <= CONVERT(varchar(100), GETDATE(), 1)		and
--	imu_expdat >= CONVERT(varchar(100),  dateadd(dd, 1, GETDATE()), 1)






GO
GRANT EXECUTE ON [dbo].[sp_select_IMPRCINF_ftycst2] TO [ERPUSER] AS [dbo]
GO
