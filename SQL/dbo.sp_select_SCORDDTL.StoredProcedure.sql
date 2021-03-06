/****** Object:  StoredProcedure [dbo].[sp_select_SCORDDTL]    Script Date: 09/29/2017 15:29:09 ******/
DROP PROCEDURE [dbo].[sp_select_SCORDDTL]
GO
/****** Object:  StoredProcedure [dbo].[sp_select_SCORDDTL]    Script Date: 09/29/2017 15:29:10 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO

Create procedure [dbo].[sp_select_SCORDDTL]
                                                                                                                                                                                                                                                                 
@sod_cocde nvarchar(6) ,
@sod_ordno nvarchar(20)                                                
 
AS

declare @max_Seq  int

set @max_seq = (select isnull(max(sod_ordseq),0) from SCORDDTL where sod_cocde = @sod_cocde and sod_ordno = @sod_ordno)

BEGIN


-- Check if any items in SC are in History --
if (select count(*) from SCORDDTL (nolock) where sod_cocde = @sod_cocde and sod_ordno = @sod_ordno and sod_itmno in (select ibi_itmno from IMBASINFH (nolock))) = 0
begin
	-- In Current --
	select	sod_cocde,
		sod_ordno,
		sod_ordseq,
		sod_updpo,
		sod_chgfty,
		sod_cusven + ' - ' + isnull(cv.vbi_vensna, '') as 'sod_cvname',
		sod_subcde,
		sod_venno + ' - ' + isnull(pv.vbi_vensna, '') as 'sod_pvname',
		sod_cussub,
		sod_tradeven + ' - ' + isnull(tv.vbi_vensna, '') as 'sod_tvname',
		sod_examven + ' - ' + isnull(fa.vbi_vensna, '') as 'sod_evname',
		isnull(pod_purord,'') as 'pod_purord',
		isnull(pod_jobord,'') as 'pod_jobord',
		sod_runno,
		sod_pjobno,
		sod_itmno,
		isnull(sod_cusstyno,'') as 'sod_cusstyno',
		sod_cusitm,
		sod_cussku,
		sod_seccusitm,
		isnull(case ibi_itmsts
			when 'CMP' then 'CMP - Active Item with complete Info.'
			when 'INC' then 'INC - Active Item with incomplete Info.'
			when 'HLD' then 'HLD - Active Item Hold by the system'
			when 'DIS' then 'DIS - Discontinue Item'
			when 'INA' then 'INA - Inactive Item'
			when 'CLO' then 'CLO - Closed Item (Alias Item)'
			when 'TBC' then 'TBC - To be confirmed Item'
			when 'OLD' then 'OLD - Old Item'
			end,'N/A') as 'ibi_itmsts',
		/*
		-- NOT USED --
		case (select count(*) from IMBASINF (nolock) where ibi_itmno = sod_itmno)
			when 0 then 'N/A'
			else isnull(case (select ibi_itmsts from IMBASINF (nolock) where ibi_itmno = sod_itmno)
				when 'CMP' then 'CMP - Active Item with complete Info.'
				when 'INC' then 'INC - Active Item with incomplete Info.'
				when 'HLD' then 'HLD - Active Item Hold by the system'
				when 'DIS' then 'DIS - Discontinue Item'
				when 'INA' then 'INA - Inactive Item'
				when 'CLO' then 'CLO - Closed Item (Alias Item)'
				when 'TBC' then 'TBC - To be confirmed Item'
				when 'OLD' then 'OLD - Old Item'
				end,'N/A')
			end as 'ibi_itmsts',
		*/
		/*
		isnull(case b.ibi_itmsts 	
			when 'CMP' then 'CMP - Active Item with complete Info.'
			when 'INC' then 'INC - Active Item with incomplete Info.'
			when 'HLD' then 'HLD - Active Item Hold by the system'
			when 'DIS' then 'DIS - Discontinue Item'
			when 'INA' then 'INA - Inactive Item'
			when 'CLO' then 'CLO - Closed Item (Alias Item)'
			when 'TBC' then 'TBC - To be confirmed Item'
			when 'OLD' then 'OLD - Old Item'
			end,'N/A') as 'h_ibi_itmsts',
		*/
		'N/A' as 'h_ibi_itmsts',
		sod_itmtyp,
		sod_itmdsc,
		sod_cuscol,
		cast(sod_colcde as nvarchar(30)) + ' / ' + cast(sod_pckunt as nvarchar(6)) + ' / ' + 
			cast(sod_inrctn as nvarchar(10)) + ' / ' + cast(sod_mtrctn as nvarchar(10)) + ' / ' +
			cast(sod_cft as nvarchar(10)) + ' / ' + cast(sod_cbm as nvarchar(10)) + ' / ' +
			sod_ftyprctrm + ' / ' + sod_hkprctrm + ' / ' + sod_trantrm as 'sod_colpck',
		sod_colcde,
		sod_pckunt,
		sod_inrctn,
		sod_mtrctn,
		sod_cft,
		sod_cbm,
		sod_ftyprctrm,
		sod_hkprctrm,
		sod_trantrm,
		sod_cus1no,
		sod_cus2no,
		sod_prcgrp,
		sod_effdat,
		sod_expdat,
		sod_pckitr,
		sod_coldsc,
		sod_pckseq,
		sod_qutno,
		sod_refdat,
		sod_resppo,
		sod_cuspo,
		sod_ordqty,
		sod_shpqty,
		sod_ordqty - sod_shpqty as 'sod_outqty',
		sod_discnt,
		sod_oneprc,
		sod_curcde,
		sod_netuntprc,
		sod_untprc,
		sod_untprc as 'sod_orgunt',
		sod_itmprc,
		sod_basprc,
		sod_inrdin,
		sod_inrwin,
		sod_inrhin,
		sod_mtrdin,
		sod_mtrwin,
		sod_mtrhin,
		sod_inrdcm,
		sod_inrwcm,
		sod_inrhcm,
		sod_mtrdcm,
		sod_mtrwcm,
		sod_mtrhcm,
		sod_ctnstr,
		sod_ctnend,
		sod_ttlctn,
		sod_tirtyp,
		sod_moq,
		isnull(sod_moqunttyp,'') as 'sod_moqunttyp',
		sod_moqchg,
		sod_selprc,
		sod_moa,
		sod_rmk,
		sod_pormk,
		isnull(sod_dv,'')  as 'sod_dv',
		sod_venno,
		sod_cusven,
		sod_tradeven,
		sod_examven,
		sod_purord,
		sod_oldpurord,
		sod_purseq,
		@max_seq as 'max_seq',
		sod_venitm,
		sod_clmno,
		sod_itmsts,
		sod_apprve,
		sod_shpstr,
		sod_shpend,
		isnull(convert(nvarchar(10), case sod_candat
			when '1900-01-01' then null 
			else cast(sod_candat as datetime)
			end,101),'  /  /    ') as 'sod_candat',
		isnull(convert(nvarchar(10), case sod_posstr
			when '1900-01-01' then null 
			else cast(sod_posstr as datetime)
			end,101),'  /  /    ') as 'sod_posstr',
		isnull(convert(nvarchar(10), case sod_posend
			when '1900-01-01' then null 
			else cast(sod_posend as datetime)
			end,101),'  /  /    ') as 'sod_posend',
		isnull(convert(nvarchar(10), case sod_poscan
			when '1900-01-01' then null 
			else cast(sod_poscan as datetime)
			end,101),'  /  /    ') as 'sod_poscan',
/*
		isnull(convert(nvarchar(10), case sod_candat
			when '1900-01-01' then null 
			else cast(sod_candat as datetime)
			end,101),'') as 'sod_candat',
		isnull(convert(nvarchar(10), case sod_posstr
			when '1900-01-01' then null 
			else cast(sod_posstr as datetime)
			end,101),'') as 'sod_posstr',
		isnull(convert(nvarchar(10), case sod_posend
			when '1900-01-01' then null 
			else cast(sod_posend as datetime)
			end,101),'') as 'sod_posend',
		isnull(convert(nvarchar(10), case sod_poscan
			when '1900-01-01' then null 
			else cast(sod_poscan as datetime)
			end,101),'') as 'sod_poscan',
*/
		sod_fcurcde,
		sod_ftycst,
		sod_bomcst,
		sod_ftyprc,
		sod_ftyprc as 'sod_orgfty',
		sod_ftyunt,
		isnull(sod_dvfcurcde ,'') as 'sod_dvfcurcde',
		isnull(sod_dvftycst,0) as 'sod_dvftycst',
		isnull(sod_dvbomcst,0) as 'sod_dvbomcst',
		isnull(sod_dvftyprc,0) as 'sod_dvftyprc',
		isnull(sod_ftyunt,'') as 'sod_dvftyunt',
		sod_ftycst_org,
		sod_bomcst_org,
		sod_ftyprc_org,
		sod_dvftycst_org,
		sod_dvbomcst_org,
		sod_dvftyprc_org,
		sod_dvitmcst,
		sod_hrmcde,
		sod_dtyrat,
		sod_dept,
		sod_typcode,
		sod_code1,
		sod_code2,
		sod_code3,
		sod_cususdcur,
		sod_cususd,
		sod_cuscadcur,
		sod_cuscad,
		isnull(sod_alsitmno,'') as 'sod_alsitmno', 
		isnull(sod_alscolcde,'') as 'sod_alscolcde',
		sod_conftr,
		sod_contopc,
		sod_pcprc,
		isnull(sod_custum,'') as 'sod_custum',
		sod_invqty,
		sod_orgmoqchg,
		sod_cusmoqchg,
		sod_venmoqchg,
		sod_assitmcount,
		sod_orgvenno,
		isnull(sod_ztnvbeln,'') as 'sod_ztnvbeln',
		isnull(sod_ztnposnr,'') as 'sod_ztnposnr',
		isnull(sod_zorvbeln,'') as 'sod_zorvbeln',
		isnull(sod_zorposnr,'') as 'sod_zorposnr',
		sod_qutdat,
		sod_imqutdat,
		sod_imqutdat_org,
		sod_imqutdatchg,
		isnull(sod_itmcstcur,'') as 'sod_itmcstcur',
		sod_venno_org,
		sod_fcurcde_org,
		sod_dvfcurcde_org,
		sod_year,
		sod_season,
		sod_tordno,
		case sod_tordseq when 0 then '' else cast(sod_tordseq as varchar(10)) end as 'sod_tordseq',
		sod_creusr,
		sod_updusr,
		sod_credat,
		sod_upddat,
		sod_effcpo,
		cast(sod_timstp as int) as 'sod_timstp',
		sod_markup,
		sod_mumin,
		sod_mrkprc,
		sod_muminprc,
		sod_commsn,
		sod_itmcom,
		sod_pckcst,	
		sod_stdprc,
		isnull(sod_covqty,'0') as 'sod_covqty',
		isnull(sod_name_f1,'') as 'sod_name_f1',
		isnull(sod_dsc_f1,'') as 'sod_dsc_f1',
		isnull(sod_name_f2,'') as 'sod_name_f2',
		isnull(sod_dsc_f2,'') as 'sod_dsc_f2',
		isnull(sod_name_f3,'') as 'sod_name_f3',
		isnull(sod_dsc_f3,'') as 'sod_dsc_f3',
		sod_moqmoaflg,
		sod_onetimeflg,
		sod_belprcflg,
		sod_chgftycstflg,
		sod_ftycst as 'sod_ftycst_check',
		sod_dvftycst as 'sod_dvftycst_check',
		sod_ordqty as 'sod_ordqty_check',
		sod_untprc as 'sod_untprc_check',
		sod_chguntprcflg,
		sod_untprc_org,
		sod_itmchidsc,
		isnull(sod_dtlttlctn,0) as 'sod_dtlttlctn'
	from	SCORDDTL (nolock)
		left join VNBASINF cv (nolock) on
			cv.vbi_venno = sod_cusven
		left join VNBASINF pv (nolock) on
			pv.vbi_venno = sod_venno
		left join VNBASINF tv (nolock) on
			tv.vbi_venno = sod_tradeven
		left join VNBASINF fa (nolock) on
			fa.vbi_venno = sod_examven
		left join IMBASINF (nolock) on
			ibi_itmno = sod_itmno
		left join POORDDTL (nolock) on
			pod_cocde = sod_cocde and
			pod_scno = sod_ordno and
			pod_scline = sod_ordseq
	where	sod_cocde = @sod_cocde and
		sod_ordno = @sod_ordno
	order by sod_ordseq
end
else
begin
	-- In History --
	select	sod_cocde,
		sod_ordno,
		sod_ordseq,
		sod_updpo,
		sod_chgfty,
		sod_cusven + ' - ' + isnull(cv.vbi_vensna, '') as 'sod_cvname',
		sod_subcde,
		sod_venno + ' - ' + isnull(pv.vbi_vensna, '') as 'sod_pvname',
		sod_cussub,
		sod_tradeven + ' - ' + isnull(tv.vbi_vensna, '') as 'sod_tvname',
		sod_examven + ' - ' + isnull(fa.vbi_vensna, '') as 'sod_evname',
		isnull(pod_purord,'') as 'pod_purord',
		isnull(pod_jobord,'') as 'pod_jobord',
		sod_runno,
		sod_pjobno,
		sod_itmno,
		isnull(sod_cusstyno,'') as 'sod_cusstyno',
		sod_cusitm,
		sod_cussku,
		sod_seccusitm,
		/*
		isnull(case ibi_itmsts
			when 'CMP' then 'CMP - Active Item with complete Info.'
			when 'INC' then 'INC - Active Item with incomplete Info.'
			when 'HLD' then 'HLD - Active Item Hold by the system'
			when 'DIS' then 'DIS - Discontinue Item'
			when 'INA' then 'INA - Inactive Item'
			when 'CLO' then 'CLO - Closed Item (Alias Item)'
			when 'TBC' then 'TBC - To be confirmed Item'
			when 'OLD' then 'OLD - Old Item'
			end,'N/A') as 'ibi_itmsts',
		*/
		/*
		-- NOT USED --
		case (select count(*) from IMBASINF (nolock) where ibi_itmno = sod_itmno)
			when 0 then 'N/A'
			else isnull(case (select ibi_itmsts from IMBASINF (nolock) where ibi_itmno = sod_itmno)
				when 'CMP' then 'CMP - Active Item with complete Info.'
				when 'INC' then 'INC - Active Item with incomplete Info.'
				when 'HLD' then 'HLD - Active Item Hold by the system'
				when 'DIS' then 'DIS - Discontinue Item'
				when 'INA' then 'INA - Inactive Item'
				when 'CLO' then 'CLO - Closed Item (Alias Item)'
				when 'TBC' then 'TBC - To be confirmed Item'
				when 'OLD' then 'OLD - Old Item'
				end,'N/A')
			end as 'ibi_itmsts',
		*/
		'N/A' as 'ibi_itmsts',
		isnull(case ibi_itmsts 	
			when 'CMP' then 'CMP - Active Item with complete Info.'
			when 'INC' then 'INC - Active Item with incomplete Info.'
			when 'HLD' then 'HLD - Active Item Hold by the system'
			when 'DIS' then 'DIS - Discontinue Item'
			when 'INA' then 'INA - Inactive Item'
			when 'CLO' then 'CLO - Closed Item (Alias Item)'
			when 'TBC' then 'TBC - To be confirmed Item'
			when 'OLD' then 'OLD - Old Item'
			end,'N/A') as 'h_ibi_itmsts',
		sod_itmtyp,
		sod_itmdsc,
		sod_cuscol,
		cast(sod_colcde as nvarchar(30)) + ' / ' + cast(sod_pckunt as nvarchar(6)) + ' / ' + 
			cast(sod_inrctn as nvarchar(10)) + ' / ' + cast(sod_mtrctn as nvarchar(10)) + ' / ' +
			cast(sod_cft as nvarchar(10)) + ' / ' + cast(sod_cbm as nvarchar(10)) + ' / ' +
			sod_ftyprctrm + ' / ' + sod_hkprctrm + ' / ' + sod_trantrm as 'sod_colpck',
		sod_colcde,
		sod_pckunt,
		sod_inrctn,
		sod_mtrctn,
		sod_cft,
		sod_cbm,
		sod_ftyprctrm,
		sod_hkprctrm,
		sod_trantrm,
		sod_cus1no,
		sod_cus2no,
		sod_prcgrp,
		sod_effdat,
		sod_expdat,
		sod_pckitr,
		sod_coldsc,
		sod_pckseq,
		sod_qutno,
		sod_refdat,
		sod_resppo,
		sod_cuspo,
		sod_ordqty,
		sod_shpqty,
		sod_ordqty - sod_shpqty as 'sod_outqty',
		sod_discnt,
		sod_oneprc,
		sod_curcde,
		sod_netuntprc,
		sod_untprc,
		sod_untprc as 'sod_orgunt',
		sod_itmprc,
		sod_basprc,
		sod_inrdin,
		sod_inrwin,
		sod_inrhin,
		sod_mtrdin,
		sod_mtrwin,
		sod_mtrhin,
		sod_inrdcm,
		sod_inrwcm,
		sod_inrhcm,
		sod_mtrdcm,
		sod_mtrwcm,
		sod_mtrhcm,
		sod_ctnstr,
		sod_ctnend,
		sod_ttlctn,
		sod_tirtyp,
		sod_moq,
		isnull(sod_moqunttyp,'') as 'sod_moqunttyp',
		sod_moqchg,
		sod_selprc,
		sod_moa,
		sod_rmk,
		sod_pormk,
		isnull(sod_dv,'')  as 'sod_dv',
		sod_venno,
		sod_cusven,
		sod_tradeven,
		sod_examven,
		sod_purord,
		sod_oldpurord,
		sod_purseq,
		@max_seq as 'max_seq',
		sod_venitm,
		sod_clmno,
		sod_itmsts,
		sod_apprve,
		sod_shpstr,
		sod_shpend,
		isnull(convert(nvarchar(10), case sod_candat
			when '1900-01-01' then null 
			else cast(sod_candat as datetime)
			end,101),'  /  /    ') as 'sod_candat',
		isnull(convert(nvarchar(10), case sod_posstr
			when '1900-01-01' then null 
			else cast(sod_posstr as datetime)
			end,101),'  /  /    ') as 'sod_posstr',
		isnull(convert(nvarchar(10), case sod_posend
			when '1900-01-01' then null 
			else cast(sod_posend as datetime)
			end,101),'  /  /    ') as 'sod_posend',
		isnull(convert(nvarchar(10), case sod_poscan
			when '1900-01-01' then null 
			else cast(sod_poscan as datetime)
			end,101),'  /  /    ') as 'sod_poscan',
		sod_fcurcde,
		sod_ftycst,
		sod_bomcst,
		sod_ftyprc,
		sod_ftyprc as 'sod_orgfty',
		sod_ftyunt,
		isnull(sod_dvfcurcde ,'') as 'sod_dvfcurcde',
		isnull(sod_dvftycst,0) as 'sod_dvftycst',
		isnull(sod_dvbomcst,0) as 'sod_dvbomcst',
		isnull(sod_dvftyprc,0) as 'sod_dvftyprc',
		isnull(sod_ftyunt,'') as 'sod_dvftyunt',
		sod_ftycst_org,
		sod_bomcst_org,
		sod_ftyprc_org,
		sod_dvftycst_org,
		sod_dvbomcst_org,
		sod_dvftyprc_org,
		sod_dvitmcst,
		sod_hrmcde,
		sod_dtyrat,
		sod_dept,
		sod_typcode,
		sod_code1,
		sod_code2,
		sod_code3,
		sod_cususdcur,
		sod_cususd,
		sod_cuscadcur,
		sod_cuscad,
		isnull(sod_alsitmno,'') as 'sod_alsitmno', 
		isnull(sod_alscolcde,'') as 'sod_alscolcde',
		sod_conftr,
		sod_contopc,
		sod_pcprc,
		isnull(sod_custum,'') as 'sod_custum',
		sod_invqty,
		sod_orgmoqchg,
		sod_cusmoqchg,
		sod_venmoqchg,
		sod_assitmcount,
		sod_orgvenno,
		isnull(sod_ztnvbeln,'') as 'sod_ztnvbeln',
		isnull(sod_ztnposnr,'') as 'sod_ztnposnr',
		isnull(sod_zorvbeln,'') as 'sod_zorvbeln',
		isnull(sod_zorposnr,'') as 'sod_zorposnr',
		sod_qutdat,
		sod_imqutdat,
		sod_imqutdat_org,
		sod_imqutdatchg,
		isnull(sod_itmcstcur,'') as 'sod_itmcstcur',
		sod_venno_org,
		sod_fcurcde_org,
		sod_dvfcurcde_org,
		sod_year,
		sod_season,
		sod_tordno,
		case sod_tordseq when 0 then '' else cast(sod_tordseq as varchar(10)) end as 'sod_tordseq',
		sod_creusr,
		sod_updusr,
		sod_credat,
		sod_upddat,
		cast(sod_timstp as int) as 'sod_timstp',
		sod_markup,
		sod_mumin,
		sod_mrkprc,
		sod_muminprc,
		sod_commsn,
		sod_itmcom,
		sod_pckcst,	
		sod_stdprc,
		isnull(sod_covqty,'0') as 'sod_covqty',
		isnull(sod_name_f1,'') as 'sod_name_f1',
		isnull(sod_dsc_f1,'') as 'sod_dsc_f1',
		isnull(sod_name_f2,'') as 'sod_name_f2',
		isnull(sod_dsc_f2,'') as 'sod_dsc_f2',
		isnull(sod_name_f3,'') as 'sod_name_f3',
		isnull(sod_dsc_f3,'') as 'sod_dsc_f3',
		sod_moqmoaflg,
		sod_onetimeflg,
		sod_belprcflg,
		sod_chgftycstflg,
		sod_ftycst as 'sod_ftycst_check',
		sod_dvftycst as 'sod_dvftycst_check',
		sod_ordqty as 'sod_ordqty_check',
		sod_untprc as 'sod_untprc_check',
		sod_chguntprcflg,
		sod_untprc_org,
		sod_itmchidsc,
		isnull(sod_dtlttlctn,0) as 'sod_dtlttlctn'
	from	SCORDDTL (nolock)
		left join VNBASINF cv (nolock) on
			cv.vbi_venno = sod_cusven
		left join VNBASINF pv (nolock) on
			pv.vbi_venno = sod_venno
		left join VNBASINF tv (nolock) on
			tv.vbi_venno = sod_tradeven
		left join VNBASINF fa (nolock) on
			fa.vbi_venno = sod_examven
		left join IMBASINFH (nolock) on
			ibi_itmno = sod_itmno
		left join POORDDTL (nolock) on
			pod_cocde = sod_cocde and
			pod_scno = sod_ordno and
			pod_scline = sod_ordseq
	where	sod_cocde = @sod_cocde and
		sod_ordno = @sod_ordno
	order by sod_ordseq
end
END


GO
GRANT EXECUTE ON [dbo].[sp_select_SCORDDTL] TO [ERPUSER] AS [dbo]
GO
