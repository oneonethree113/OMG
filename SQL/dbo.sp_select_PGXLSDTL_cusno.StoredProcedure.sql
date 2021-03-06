/****** Object:  StoredProcedure [dbo].[sp_select_PGXLSDTL_cusno]    Script Date: 09/29/2017 15:29:09 ******/
DROP PROCEDURE [dbo].[sp_select_PGXLSDTL_cusno]
GO
/****** Object:  StoredProcedure [dbo].[sp_select_PGXLSDTL_cusno]    Script Date: 09/29/2017 15:29:10 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create PROCEDURE  [dbo].[sp_select_PGXLSDTL_cusno]
	@pxd_xlsfil  nvarchar(50) ,
	@pxd_fildat  nvarchar(30)  

AS

select
	distinct
	pxd_cocde,
	pxd_scno ,
	case (pxd_scno) when  '' then pxd_tono 
			else '' end as 'pxd_tono',
		isnull(soh_cus1no,'') as 'soh_cus1no',
		isnull(soh_cus2no,'') as 'soh_cus2no',
		isnull(toh_cus1no,'') as 'toh_cus1no',
		isnull(toh_cus2no,'') as 'toh_cus2no'
from	PGXLSDTL
			left join SCORDHDR
			 on pxd_scno= soh_ordno 
			left join TOORDHDR
			 on pxd_tono= toh_toordno
where 
	pxd_xlsfil = @pxd_xlsfil 
	and pxd_fildat = @pxd_fildat  


GO
GRANT EXECUTE ON [dbo].[sp_select_PGXLSDTL_cusno] TO [ERPUSER] AS [dbo]
GO
