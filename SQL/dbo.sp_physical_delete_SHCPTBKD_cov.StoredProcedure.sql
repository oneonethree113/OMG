/****** Object:  StoredProcedure [dbo].[sp_physical_delete_SHCPTBKD_cov]    Script Date: 09/29/2017 15:29:09 ******/
DROP PROCEDURE [dbo].[sp_physical_delete_SHCPTBKD_cov]
GO
/****** Object:  StoredProcedure [dbo].[sp_physical_delete_SHCPTBKD_cov]    Script Date: 09/29/2017 15:29:10 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO













CREATE    procedure [dbo].[sp_physical_delete_SHCPTBKD_cov]
@hid_cocde	varchar(6),
@hid_ctrcfs	varchar(20)

as
 



Delete SHCPTBKD_cov
Where 
shb_ordno in (
	select hid_shpno from SHIPGDTL_cov
	Where 
		hid_cocde=@hid_cocde
		and hid_ctrcfs=@hid_ctrcfs
	)
and shb_ordseq in (
	select hid_shpseq from SHIPGDTL_cov
	Where 
		hid_cocde=@hid_cocde
		and hid_ctrcfs=@hid_ctrcfs
	)






GO
GRANT EXECUTE ON [dbo].[sp_physical_delete_SHCPTBKD_cov] TO [ERPUSER] AS [dbo]
GO
