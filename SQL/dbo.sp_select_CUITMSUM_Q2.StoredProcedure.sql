/****** Object:  StoredProcedure [dbo].[sp_select_CUITMSUM_Q2]    Script Date: 09/29/2017 15:29:09 ******/
DROP PROCEDURE [dbo].[sp_select_CUITMSUM_Q2]
GO
/****** Object:  StoredProcedure [dbo].[sp_select_CUITMSUM_Q2]    Script Date: 09/29/2017 15:29:10 ******/
SET ANSI_NULLS OFF
GO
SET QUOTED_IDENTIFIER OFF
GO




/************************************************************************
Author:		Carlos Lui
Date:		05 Jun, 2012
Description:	Select data From CUITMSUM

************************************************************************/
------------------------------------------------- 
CREATE  procedure [dbo].[sp_select_CUITMSUM_Q2]
                                                                                                                                                                                                                                                                 
---------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------- 
@cis_cocde 	nvarchar(6),	@cis_cusno 	nvarchar(6),  
@cis_seccus	nvarchar(6),	@cis_itmno 	nvarchar(20),	
@cis_colcde	nvarchar(30),	@cis_untcde	nvarchar(6),	
@cis_inrqty	int,		@cis_mtrqty	int,
@cis_conftr	numeric(9),	@cis_creusr	nvarchar(30)
 
AS
begin
	if (select count(*) from CUBASINF (nolock) where cbi_cusali = @cis_cusno)  = 0 
	begin
		select	cis_cocde,		cis_cusno,		cis_itmno,
			cis_itmdsc,		cis_cusitm,		cis_colcde,
			cis_coldsc,		cis_cuscol,		cis_untcde,
			cis_inrqty,		cis_mtrqty,	cis_cft,	cis_cbm,
			cis_refdoc,		cis_docdat,		cis_hrmcde,
			cis_dtyrat,		cis_dept,		cis_cususd,
			cis_cuscad,		cis_selprc,		cis_curcde,
			isnull(imu_hkprctrm,'') + case when imu_hkprctrm is not null then ' - ' else '' end + isnull(ysi_dsc,'') as 'cis_hkprctrm',
			cis_conftr ,		cis_contopc,	isnull(cis_pcprc,0) as 'cis_pcprc',
			isnull(cis_cusstyno,'') as 'cis_cusstyno'
		from CUITMSUM (nolock)
		left join IMVENINF (nolock) on	ivi_itmno = @cis_itmno	and
					ivi_def = 'Y'
		left join IMPRCINF (nolock) on 	imu_itmno = ivi_itmno	and
--					imu_ventyp = 'P'		and
					imu_prdven = ivi_venno	and
--					imu_status = 'ACT'		and
					imu_pckunt = @cis_untcde	and
					imu_inrqty = @cis_inrqty	and
					imu_mtrqty = @cis_mtrqty	and
					imu_conftr = @cis_conftr
		left join SYSETINF (nolock) on	ysi_cde = imu_hkprctrm	and
					ysi_typ = '03'
		where 	cis_itmno = @cis_itmno	and 
			cis_cusno = @cis_cusno	and
			cis_seccus = @cis_seccus	and
			cis_colcde = @cis_colcde	and
			cis_untcde = @cis_untcde	and
			cis_conftr = @cis_conftr	and
			cis_inrqty = @cis_inrqty	and
			cis_mtrqty = @cis_mtrqty
	end                                                          
	else
	begin
		declare @cis_upddat datetime
		
		set @cis_upddat = (
			select  max(cis_upddat)
			from cuitmsum (nolock)
			left join cubasinf (nolock) on cbi_cusali = @cis_cusno
			where 	(cis_cusno = @cis_cusno 	or
				 cis_cusno = cbi_cusno)	and
				cis_seccus = @cis_seccus	and
				cis_itmno = @cis_itmno	and
				cis_colcde = @cis_colcde	and
				cis_untcde = @cis_untcde	and
				cis_inrqty = @cis_inrqty	and
				cis_mtrqty = @cis_mtrqty
			)
		
		select	cis_cocde ,		cis_cusno = @cis_cusno,	cis_itmno,
			cis_itmdsc,		cis_cusitm,			cis_colcde,
			cis_coldsc,		cis_cuscol,			cis_untcde,
			cis_inrqty,		cis_mtrqty,			cis_cft,
			cis_cbm,		cis_refdoc,			cis_docdat,
			cis_hrmcde,	cis_dtyrat,			cis_dept,		
			cis_cususd,		cis_cuscad,			cis_selprc,
			cis_curcde,
			isnull(imu_hkprctrm,'') + case when imu_hkprctrm is not null then ' - ' else '' end + isnull(ysi_dsc,'') as 'cis_hkprctrm',
			cis_conftr ,		cis_contopc,		isnull(cis_pcprc,0) as 'cis_pcprc',
			isnull(cis_cusstyno,'') as 'cis_cusstyno'
		from CUITMSUM (nolock)
		left join IMVENINF (nolock) on 	ivi_itmno = @cis_itmno	and
					ivi_def = 'Y'
		left join IMPRCINF (nolock) on 	imu_itmno = ivi_itmno	and
--					imu_ventyp = 'P'		and
--					imu_status = 'ACT'		and
					imu_prdven = ivi_venno	and
					imu_pckunt = @cis_untcde	and
					imu_inrqty = @cis_inrqty	and
					imu_mtrqty = @cis_mtrqty	and
					imu_conftr = @cis_conftr
		left join SYSETINF (nolock) on	ysi_cde = imu_hkprctrm	and
					ysi_typ = '03'
		left join CUBASINF (nolock) on	cbi_cusali = @cis_cusno
		where 	cis_itmno = @cis_itmno	and 
			(cis_cusno = @cis_cusno	or
			 cis_cusno = cbi_cusno)	and
			cis_seccus = @cis_seccus	and
			cis_colcde = @cis_colcde	and
			cis_untcde = @cis_untcde	and
			cis_conftr = @cis_conftr	and
			cis_inrqty = @cis_inrqty	and
			cis_mtrqty = @cis_mtrqty	and
			cis_upddat = @cis_upddat
	end
end





GO
GRANT EXECUTE ON [dbo].[sp_select_CUITMSUM_Q2] TO [ERPUSER] AS [dbo]
GO
