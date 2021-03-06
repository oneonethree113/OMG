/****** Object:  StoredProcedure [dbo].[sp_select_SCVENMRK_H_DV_wCust2]    Script Date: 09/29/2017 15:29:09 ******/
DROP PROCEDURE [dbo].[sp_select_SCVENMRK_H_DV_wCust2]
GO
/****** Object:  StoredProcedure [dbo].[sp_select_SCVENMRK_H_DV_wCust2]    Script Date: 09/29/2017 15:29:10 ******/
SET ANSI_NULLS OFF
GO
SET QUOTED_IDENTIFIER OFF
GO





-- It is based on sp_select_SCVENMRK_H_DV
/********************************************************************************************************************
Modification History
********************************************************************************************************************
Modify on		Modify by		Description
********************************************************************************************************************

********************************************************************************************************************/ 

------------------------------------------------- 
CREATE  procedure [dbo].[sp_select_SCVENMRK_H_DV_wCust2]
                                                                                                                                                                                                                                                                 
---------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------- 
@ivi_cocde 	nvarchar(6) ,
@ivi_itmno 	nvarchar(20),
@imu_pckunt 	nvarchar(6),
@imu_inrqty 	int,
@imu_mtrqty 	int,
@vendortype 	varchar(10),
@imu_cus1no	nvarchar(20),
@imu_cus2no	nvarchar(20),
@imu_hkprctrm	nvarchar(10),
@imu_ftyprctrm	nvarchar(10),
@imu_trantrm	nvarchar(10),
@flag 		varchar(10)
---------------------------------------------- 
 
AS
declare @temp char(1), @AlsItm Char(1), @DV nvarchar(10), @tmp_vendortype varchar(10)
set @tmp_vendortype = ''

select	@vendortype = LTRIM(RTRIM(VBI_VENTYP))
from	IMBASINF
left join	VNBASINF on	IBI_VENNO = VBI_VENNO
where	IBI_ITMNO = @ivi_itmno

select	@TEMP = CASE VBI_VENNO 
			WHEN '0005' THEN 'D'
			WHEN '0006' THEN 'D'
			WHEN '0007' THEN 'D'
			WHEN '0008' THEN 'D'
			WHEN '0009' THEN 'D'
			ELSE CASE  VBI_VENTYP  
					WHEN 'E' THEN 'D'
					WHEN 'I' THEN 'P'
					WHEN 'J' THEN 'P'
					END
			END,
	@AlsItm = CASE VBI_VENNO 
			WHEN '0005' THEN 'Y'
			WHEN '0006' THEN 'Y'
			WHEN '0007' THEN 'Y'
			WHEN '0008' THEN 'Y'
			WHEN '0009' THEN 'Y'
			ELSE 'N'
			END
from	IMBASINFH
left join	IMVENINFH on	IVI_ITMNO = IBI_ITMNO	AND IVI_DEF = 'Y'
left join	VNBASINF on	VBI_VENNO = IVI_VENNO
where	IBI_ITMNO = @ivi_itmno 

select	@DV = ibi_venno
from IMBASINF (nolock) 
where ibi_itmno = @ivi_itmno

select	@tmp_vendortype = vbi_ventyp
from	vnbasinf (nolock)
where	vbi_venno = @DV

if ( @tmp_vendortype <> '' )
begin
	set @vendortype = @tmp_vendortype
end

--if @flag = 0 or @flag <> 0
--begin 
	if @AlsItm = 'N' 
	begin
		select	ivi_cocde,		ivi_itmno,		ivi_venitm,
			ivi_venno,		isnull(vbi_vensna,'N/A') as 'vbi_vensna',
							ivi_def,
			ivi_subcde,		ivi_creusr,		ivi_updusr,
			ivi_upddat,		imu_cocde,		imu_itmno,
			imu_typ,		imu_ventyp,	imu_venno,
			--isnull(imu_pckseq,0)as 'imu_pckseq',
			isnull(imu_pckunt,'N/A') as 'imu_pckunt',
					imu_inrqty,	imu_mtrqty,
			imu_cft,		isnull(imu_curcde,'HKD')as 'imu_curcde',
							imu_hkprctrm,
			--imu_relatn,
			imu_fmlopt,	
			isnull(imu_ftycst,0) as 'imu_ftycst',
			isnull(imu_ftyprc,0) as 'imu_ftyprc',
			isnull((case imu_negprc when 0 then imu_ttlcst else imu_negprc end),0) as 'imu_negprc',	
			isnull(imu_bcurcde,'USD')as 'imu_bcurcde',
			imu_basprc,
			--isnull(imu_negprc,0) as 'imu_negprc' ,
			isnull(imu_bomcst,0) as 'imu_bomcst',
					isnull(ipi_qutdat,'1900-01-01') as ipi_qutdat,
							imu_creusr,
			imu_updusr,	imu_upddat,	@vendortype as 'vendortype',
			imu_cus1no, imu_cus2no, imu_hkprctrm, imu_ftyprctrm,imu_trantrm
		from	IMVENINFH
		left join	IMPRCINFH on	imu_itmno = ivi_itmno				and 
					ivi_venno = imu_prdven				and
--					imu_status = 'ACT'					and
					imu_pckunt =@imu_pckunt				and
					imu_inrqty = @imu_inrqty				and
					imu_mtrqty=@imu_mtrqty				and
					imu_cus1no = @imu_cus1no				and
					imu_cus2no = @imu_cus2no				--and
--					imu_hkprctrm = @imu_hkprctrm				and
--					imu_ftyprctrm = @imu_ftyprctrm				and
--					imu_trantrm = @imu_trantrm				and
--					imu_effdat <= CONVERT(varchar(100), GETDATE(), 1)		and
--					imu_expdat >= CONVERT(varchar(100),  dateadd(dd, 1, GETDATE()), 1)
		left join	VNBASINF on	ivi_venno = vbi_venno					and
					vbi_vensts = 'A'
		left join	IMPCKINFH on	ipi_itmno = ivi_itmno					and
					ipi_pckunt =@imu_pckunt				and
					ipi_inrqty = @imu_inrqty				and
					ipi_mtrqty=@imu_mtrqty
		where 	ivi_itmno = @ivi_itmno	and
			imu_prdven = @DV
		order by	ivi_venno
	end
	else
	begin
		select	ivi_cocde,		ivi_itmno,		ivi_venitm,
			ivi_venno,		isnull(vbi_vensna,'N/A') as 'vbi_vensna',
							ivi_def,
			ivi_subcde,		ivi_creusr,		ivi_updusr,
			ivi_upddat,		imu_cocde,		imu_itmno,
			imu_typ,		imu_ventyp,	imu_venno,
			--isnull(imd_pckseq,0)as 'imu_pckseq',
			isnull(imu_pckunt,'N/A') as 'imu_pckunt',
					imu_inrqty,	imu_mtrqty,
			imu_cft,		isnull(imu_curcde,'HKD')as 'imu_curcde',
							imu_hkprctrm,
			--imu_relatn,
			imu_fmlopt,	
			isnull(imu_ftycst,0) as 'imu_ftycst',
			isnull(imu_ftyprc,0) as 'imu_ftyprc',
			isnull((case imu_negprc when 0 then imu_ttlcst else imu_negprc end),0) as 'imu_negprc',	
			isnull(imu_bcurcde,'USD')as 'imu_bcurcde',
			imu_basprc,
			--isnull(imp_negprc,0) as 'imu_negprc' ,
			isnull(imu_bomcst,0) as 'imu_bomcst',
					isnull(ipi_qutdat,'1900-01-01') as ipi_qutdat,
							imu_creusr,
			imu_updusr,	imu_upddat,	@vendortype as 'vendortype',
			imu_cus1no, imu_cus2no, imu_hkprctrm, imu_ftyprctrm,imu_trantrm
		from	IMBASINFH
		left join	IMVENINFH on	IVI_ITMNO = IBI_ITMNO
		left join	IMPRCINFH on	imu_itmno = ivi_itmno				and
					imu_prdven = ivi_venno				and
--					imu_status = 'ACT'					and
					imu_pckunt =@imu_pckunt				and
					imu_inrqty = @imu_inrqty				and
					imu_mtrqty = @imu_mtrqty				and
					imu_cus1no = @imu_cus1no				and
					imu_cus2no = @imu_cus2no				--and
--					imu_hkprctrm = @imu_hkprctrm				and
--					imu_ftyprctrm = @imu_ftyprctrm				and
--					imu_trantrm = @imu_trantrm				and
--					imu_effdat <= CONVERT(varchar(100), GETDATE(), 1)		and
--					imu_expdat >= CONVERT(varchar(100),  dateadd(dd, 1, GETDATE()), 1)
		left join	VNBASINF on	ivi_venno = vbi_venno					and
					vbi_vensts = 'A'
		left join	IMPCKINFH on	ipi_itmno = ivi_itmno					and
					ipi_pckunt =@imu_pckunt				and
					ipi_inrqty = @imu_inrqty				and
					ipi_mtrqty=@imu_mtrqty
		where	(IBI_ALSITMNO = @IVI_ITMNO	or
			 IBI_ITMNO = @IVI_ITMNO)						and
			--- Alias Item ---
			((IVI_VENNO IN ('0005','0006','0007','0008','0009')	and
			 (LTRIM(RTRIM(VBI_VENTYP)) + LTRIM(RTRIM(IMU_VENTYP)) = 'ID')) or
			 (IVI_VENNO IN ('0005','0006','0007','0008','0009')	and
			 (LTRIM(RTRIM(VBI_VENTYP)) + LTRIM(RTRIM(IMU_VENTYP)) = 'JD')) or
			 (IVI_VENNO IN ('A','B','C','D','E','F','G','H','I','J','K','L','M','N','O','P','Q','R','S','T','U','V','W','X','Y','Z')
								and
			 (LTRIM(RTRIM(VBI_VENTYP)) + LTRIM(RTRIM(IMU_VENTYP)) = 'IP')) or
			 (IVI_VENNO IN ('A','B','C','D','E','F','G','H','I','J','K','L','M','N','O','P','Q','R','S','T','U','V','W','X','Y','Z')
								and
			 (LTRIM(RTRIM(VBI_VENTYP)) + LTRIM(RTRIM(IMU_VENTYP)) = 'JP')))	and
			imu_prdven = @DV
		order by	ivi_venno
	end
--end






GO
GRANT EXECUTE ON [dbo].[sp_select_SCVENMRK_H_DV_wCust2] TO [ERPUSER] AS [dbo]
GO
