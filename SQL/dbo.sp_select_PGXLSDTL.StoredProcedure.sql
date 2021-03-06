/****** Object:  StoredProcedure [dbo].[sp_select_PGXLSDTL]    Script Date: 09/29/2017 15:29:09 ******/
DROP PROCEDURE [dbo].[sp_select_PGXLSDTL]
GO
/****** Object:  StoredProcedure [dbo].[sp_select_PGXLSDTL]    Script Date: 09/29/2017 15:29:10 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create   PROCEDURE [dbo].[sp_select_PGXLSDTL]
	@pxd_xlsfil  nvarchar(50) ,
	@pxd_fildat  nvarchar(30)  

AS

select
	pxd_scno  ,
	case (pxd_scno) when  '' then pxd_tono 
			else '' end as 'pxd_tono'  ,
	pxd_itmno  ,
	pxd_assitmno  ,
	pxd_cusitmno  ,
	pxd_um ,
	pxd_inner ,
	pxd_master ,
	pxd_cft ,
	pxd_ftytrm,
	pxd_hktrm,
	pxd_trantrm,
	pxd_colcde
from	PGXLSDTL
where 
	pxd_xlsfil = @pxd_xlsfil 
	and pxd_fildat = @pxd_fildat  
group by 
	pxd_scno  ,
	case (pxd_scno) when  '' then pxd_tono 
			else '' end   ,
	pxd_itmno  ,
	pxd_assitmno  ,
	pxd_cusitmno  ,
	pxd_um ,
	pxd_inner ,
	pxd_master ,
	pxd_cft ,
	pxd_ftytrm,
	pxd_hktrm,
	pxd_trantrm,
	pxd_colcde




GO
GRANT EXECUTE ON [dbo].[sp_select_PGXLSDTL] TO [ERPUSER] AS [dbo]
GO
