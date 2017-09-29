/****** Object:  StoredProcedure [dbo].[sp_physical_delete_SHASSINF_cov]    Script Date: 09/29/2017 15:29:09 ******/
DROP PROCEDURE [dbo].[sp_physical_delete_SHASSINF_cov]
GO
/****** Object:  StoredProcedure [dbo].[sp_physical_delete_SHASSINF_cov]    Script Date: 09/29/2017 15:29:10 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO














CREATE     procedure [dbo].[sp_physical_delete_SHASSINF_cov]
@hid_ctrcfs	varchar(20)

as
 



Delete SHASSINF_cov
Where 
HAI_SHPno in (
	select hid_shpno from SHIPGDTL_cov
	Where  hid_ctrcfs=@hid_ctrcfs
	)
and HAI_SHPseq in (
	select hid_shpseq from SHIPGDTL_cov
	Where   hid_ctrcfs=@hid_ctrcfs
	)







GO
GRANT EXECUTE ON [dbo].[sp_physical_delete_SHASSINF_cov] TO [ERPUSER] AS [dbo]
GO
