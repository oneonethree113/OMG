/****** Object:  StoredProcedure [dbo].[sp_select_SHPCKDIM_cov]    Script Date: 09/29/2017 15:29:09 ******/
DROP PROCEDURE [dbo].[sp_select_SHPCKDIM_cov]
GO
/****** Object:  StoredProcedure [dbo].[sp_select_SHPCKDIM_cov]    Script Date: 09/29/2017 15:29:10 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO




/**********************************************************************************************************************************
Modification History
**********************************************************************************************************************************
Modifiy by		Modified on		Description
**********************************************************************************************************************************
***********************************************************************************************************************************/
CREATE       procedure [dbo].[sp_select_SHPCKDIM_cov]
@hpd_cocde	nvarchar(6),
@hpd_shpno	nvarchar(20),
@hpd_shpseq	int


as


select 
* from SHPCKDIM_cov
where hpd_cocde=@hpd_cocde
	and hpd_shpno=@hpd_shpno
	and hpd_shpseq =@hpd_shpseq  
	order by hpd_pdnum	

---------------------------------------------------------------------------------------------------------------------------------------------------------------------










GO
GRANT EXECUTE ON [dbo].[sp_select_SHPCKDIM_cov] TO [ERPUSER] AS [dbo]
GO
