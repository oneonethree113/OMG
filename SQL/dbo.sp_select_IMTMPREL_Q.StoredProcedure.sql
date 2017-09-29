/****** Object:  StoredProcedure [dbo].[sp_select_IMTMPREL_Q]    Script Date: 09/29/2017 15:29:09 ******/
DROP PROCEDURE [dbo].[sp_select_IMTMPREL_Q]
GO
/****** Object:  StoredProcedure [dbo].[sp_select_IMTMPREL_Q]    Script Date: 09/29/2017 15:29:10 ******/
SET ANSI_NULLS OFF
GO
SET QUOTED_IDENTIFIER ON
GO



CREATE  PROCEDURE [dbo].[sp_select_IMTMPREL_Q] 
                                                                                                                                                                                                                                                                 
@itr_cocde		nvarchar(6),
@itr_itmno		nvarchar(20),
@imu_cus1no	nvarchar(6),
@imu_cus2no	nvarchar(6)
 
AS
begin

select distinct
	'' as 'Conv',
	'' as 'ID',
	itr_itmno,
	icf_colcde as 'itr_color',
	imu_pckunt,
	imu_inrqty,
	imu_mtrqty,
	imu_cft,
	imu_ftyprctrm,
	imu_hkprctrm,
	imu_trantrm,
	cast(imu_pckunt as nvarchar) + ' / ' +
	cast(imu_inrqty as nvarchar) + ' / ' +
	cast(imu_mtrqty as nvarchar) + ' / ' +
	cast(imu_cft as nvarchar) + ' / ' +
	cast(imu_ftyprctrm as nvarchar) + ' / ' +
	cast(imu_hkprctrm as nvarchar) + ' / ' +
	cast(imu_trantrm as nvarchar) as 'itr_pck',
	'' as 'Reason'
from	IMTMPREL (nolock), IMCOLINF (nolock), IMVENINF (nolock), IMPRCINF (nolock)
where	itr_tmpitm = @itr_itmno			and
	icf_itmno = itr_itmno				and
	itr_itmno = ivi_itmno				and
	ivi_itmno = imu_itmno			and
	ivi_def = 'Y'				and
	ivi_venno = imu_prdven/*			and
	--imu_status = 'ACT'				and
	(imu_cus1no = @imu_cus1no		and
	 imu_cus2no = @imu_cus2no	or
	 imu_cus1no = @imu_cus1no		and
	 imu_cus2no = ''		or
	 imu_cus1no = ''			and
	 imu_cus2no = '')*/

end




GO
GRANT EXECUTE ON [dbo].[sp_select_IMTMPREL_Q] TO [ERPUSER] AS [dbo]
GO
