/****** Object:  StoredProcedure [dbo].[sp_select_QUOTNDTL_checking2]    Script Date: 09/29/2017 15:29:09 ******/
DROP PROCEDURE [dbo].[sp_select_QUOTNDTL_checking2]
GO
/****** Object:  StoredProcedure [dbo].[sp_select_QUOTNDTL_checking2]    Script Date: 09/29/2017 15:29:10 ******/
SET ANSI_NULLS OFF
GO
SET QUOTED_IDENTIFIER OFF
GO




/*=========================================================
Program ID	: 	sp_select_QUOTNDTL_checking2
Description   	: 
Programmer  	: 
ALTER  Date   	: 
Last Modified  	: 
Table Read(s) 	:
Table Write(s) 	:
=========================================================
 Modification History                                    
=========================================================
Date		Author		Description

=========================================================
*/

CREATE procedure [dbo].[sp_select_QUOTNDTL_checking2]                                                                                                                                                                                                                            
@cocde nvarchar(6),                                                                                                                                                                                                                                         
@qutno nvarchar(20)                                                                                                                                                                                                                                          
                                                                                                                                                                                                                                                                 
AS                                 

declare	@copy	nvarchar(3),	@message		nvarchar(100)

set @copy = ''
set @message = ''                                                                                                                                                                                                              

declare @selRate as numeric(16,11)

select @selRate = ysi_selrat from SYSETINF where ysi_typ = '06' and ysi_cde = 'HKD'

/*select		qud_itmno as 'itmno',		qud_untcde as 'untcde',		qud_inrqty as 'inrqty',
		qud_mtrqty as 'mtrqty',		qud_conftr as 'conftr',		imu_ventyp as 'ventyp',
		imu_venno as 'venno',		imu_prdven as 'prdven',	imu_cus1no as 'cus1no',
		imu_cus2no as 'cus2no',	imu_ftyprctrm as 'ftyprctrm',	imu_hkprctrm as 'prctrm',
		imu_trantrm as 'trantrm'
		--isnull( imu_std,'') as 'std'
into #temp_imprcinf
from quotndtl (nolock)
left join imprcinf (nolock) on	imu_itmno = qud_itmno	and
			imu_pckunt = qud_untcde	and
			imu_inrqty = qud_inrqty	and 	
			imu_mtrqty = qud_mtrqty 	and
			imu_conftr = qud_conftr	and
			imu_ventyp = 'D'
where
	qud_cocde = @cocde	and
	qud_qutno = @qutno*/


BEGIN                                          

IF @COCDE = 'UCPP'
BEGIN
	SELECT
		qud_cocde,			qud_qutno,			qud_itmno,	
		qud_colcde,		qud_untcde,		qud_inrqty,
		qud_mtrqty,		qud_venno,		qud_qutseq,
		qud_cuscol,		qud_cusitm,		qud_coldsc,
		qud_note,			qud_stkqty,		qud_cusqty,
		qud_smpqty,		qud_hrmcde,		qud_dtyrat,
		qud_cususd,		qud_cuscad,		qud_dept,
		qud_pckitr,			qud_tbm,			qud_hstref,		
		isnull(ibi_itmno,qud_itmno) as 'ibi_itmno',
		isnull(ibi_alsitmno,qud_alsitmno) as 'ibi_alsitmno',
		isnull(ibi_alscolcde,qud_alscolcde) as 'ibi_alscolcde',
		isnull(ibi_typ,'') as 'ibi_typ',
		isnull(ibi_itmsts,'INA') as 'ibi_itmsts',
		isnull(ibi_engdsc,'') as 'ibi_engdsc',
		isnull(ibi_tirtyp,'') as 'ibi_tirtyp',
		isnull(ibi_moqctn,0) as 'ibi_moqctn',
		isnull(ibi_moa,0) as 'ibi_moa',
		isnull(ibi_curcde,'') as 'ibi_curcde',
		isnull(ibi_lnecde,'') as 'ibi_lnecde',
		isnull(ibi_venno,'') as 'ibi_venno',
		isnull(ibi_cosmth,'') as 'ibi_cosmth',
		isnull(icf_colcde,'') as 'icf_colcde',
		isnull(icf_colcde,'') as 'icf_vencol',
		isnull(ipi_pckseq,0) as 'ipi_pckseq',
		isnull(ipi_pckunt,'') as 'ipi_pckunt',
		isnull(ipi_inrqty,0) as 'ipi_inrqty',	
		isnull(ipi_mtrqty,0) as 'ipi_mtrqty',
		isnull(ipi_cft,0) as 'ipi_cft',
		ipi_pckunt+' / '+ltrim(str(ipi_inrqty))+' / '+ltrim(str(ipi_mtrqty)) as 'packing',
		cast(ipi_inrdin as nvarchar) + 'x' +
		cast(ipi_inrwin as nvarchar)+ 'x' +
		cast(ipi_inrhin as nvarchar)  as 'inner_in',
		
		cast(ipi_mtrdin as nvarchar)+ 'x' +
		cast(ipi_mtrwin as nvarchar)+  'x' +
		cast(ipi_mtrhin as nvarchar) as 'master_in',

		cast(ipi_inrdcm as nvarchar)+ 'x' +
		cast(ipi_inrwcm as nvarchar)+ 'x' +
		cast(ipi_inrhcm as nvarchar) as 'inner_cm',
		
		cast(ipi_mtrdcm as nvarchar)+ 'x' +
		cast(ipi_mtrwcm as nvarchar)+ 'x' +
		cast(ipi_mtrhcm as nvarchar) as 'master_cm',
		isnull(ipi_inrdin,0) as 'ipi_inrdin',
		isnull(ipi_inrwin,0) as 'ipi_inrwin',
		isnull(ipi_inrhin,0) as 'ipi_inrhin',
		isnull(ipi_mtrdin,0) as 'ipi_mtrdin',
		isnull(ipi_mtrwin,0) as 'ipi_mtrwin',
		isnull(ipi_mtrhin,0) as 'ipi_mtrhin',
		isnull(ipi_inrdcm,0) as 'ipi_inrdcm',
		isnull(ipi_inrwcm,0) as 'ipi_inrwcm',
		isnull(ipi_inrhcm,0) as 'ipi_inrhcm',
		isnull(ipi_mtrdcm,0) as 'ipi_mtrdcm',
		isnull(ipi_mtrwcm,0) as 'ipi_mtrwcm',
		isnull(ipi_mtrhcm,0) as 'ipi_mtrhcm',
		isnull(ipi_grswgt,0) as 'ipi_grswgt',
		isnull(ipi_netwgt,0) as 'ipi_netwgt',
		case ipi_qutdat
			when '' then '1900-01-01'
			when null then '1900-01-01'
			else ipi_qutdat end as 'ipi_qutdat',
		isnull(ven.vbi_venno,'') as 'vbi_venno',
		isnull(ivi_venno,'') + ' - ' + isnull(ven.vbi_vensna,'') as 'ivi_venno', 	
		isnull(ivi_venitm,'') as 'ivi_venitm', 
		isnull(ivi_subcde,'') as 'ivi_subcde', 
		isnull(imu_ventyp,'') as 'imu_ventyp',
		isnull(imu_curcde,'') as 'imu_curcde',	
		(case imu_negprc when 0  then imu_ftyprc else imu_negprc end) as 'imu_ftyprc',
		isnull(imu_bcurcde,'') as 'imu_bcurcde',
		isnull( imu_basprc ,0) as 'imu_basprc',
		(case imu_negprc when 0  then imu_ftyprc else imu_negprc end) as 'imu_ftycst',
		isnull(ycf_value,0) as 'ycf_value',
		@copy as 'copy',		@message as 'message',	qud_discnt,
		isnull(imu_hkprctrm,'') + case when imu_hkprctrm is not null then ' - ' else '' end + isnull(a.ysi_dsc,'') as  'imu_prctrm',
		isnull(cusven.vbi_venno,'') +  case isnull(cusven.vbi_vensna,'') when '' then '' else ' - ' + isnull(cusven.vbi_vensna,'') end as 'qud_cusven',
		qud_cussub,
		isnull(imu_ftyprctrm,'') + case when imu_ftyprctrm is not null then ' - ' else '' end + isnull(b.ysi_dsc,'') as  'imu_ftyprctrm',
		isnull(ven.vbi_ventyp,'') as 'vbi_ventyp',
		isnull(ipi_conftr,1) as 'ipi_conftr',	qud_contopc,		qud_pcprc,
		isnull( ipi_cbm,0) as 'ipi_cbm', isnull(icf_ucpcde,'') as 'icf_ucpcde',
		qud_ftytmpitm,		qud_ftytmpitmno,
		isnull(qud_cusstyno,'') as 'ics_cussty',
		isnull(qud_specpck,'') as 'qud_specpck',
		isnull(qud_custitmcat,'') as 'qud_custitmcat',
		isnull(qud_custitmcatfml,'') as 'qud_custitmcatfml',
		isnull(qud_custitmcatamt,'') as 'qud_custitmcatamt',
		isnull(ibi_rmk,'') as 'ibi_rmk',isnull(qud_rndsts,'') as 'qud_rndsts',
		isnull(imu_cus1no,'') as 'imu_cus1no',
		isnull(imu_cus2no,'') as 'imu_cus2no',
		isnull(imu_trantrm,'') as 'imu_trantrm',
		case imu_effdat
			when '' then '1900-01-01'
			when null then '1900-01-01'
			else imu_effdat end as 'imu_effdat',
		case imu_expdat
			when '' then '1900-01-01'
			when null then '1900-01-01'
			else imu_expdat end as 'imu_expdat'
		--isnull(std.std,'') as 'imu_std'
	FROM
		QUOTNDTL
		left join IMBASINF on	(qud_itmno = ibi_itmno	or
					qud_itmno = ibi_alsitmno)	and
					ibi_itmsts <> 'CLO'
		left join IMCOLINF on	icf_itmno = ibi_itmno		and
					icf_colcde = qud_colcde 
		left join IMPCKINF on	ipi_itmno = ibi_itmno		and
					ipi_pckunt = qud_untcde	and
					ipi_inrqty = qud_inrqty		and
					ipi_mtrqty = qud_mtrqty	and
					ipi_conftr = qud_conftr
		left join IMVENINF on	ivi_itmno = ibi_itmno		and
					ivi_def = 'Y'
		left join VNBASINF ven on	ven.vbi_venno = ivi_venno	and
					ven.vbi_vensts = 'A'
		left join IMPRCINF on	imu_itmno = ibi_itmno	and
					imu_prdven = ven.vbi_venno	and
--					imu_status = 'ACT'		and
					imu_pckunt = ipi_pckunt	and
					imu_inrqty = ipi_inrqty	and
					imu_mtrqty = ipi_mtrqty 	and
					imu_conftr = ipi_conftr	/*and
					imu_ventyp = 
						(case ven.vbi_ventyp 
							when 'I' then 'P' 
							when 'J' then 'P' 
							else 'D' end)*/
		left join SYCONFTR on	ycf_cocde = ' '		and
					ycf_code1 = ipi_pckunt	and
					ycf_code2 = 'PC'
		left join SYSETINF a  on	a.ysi_cocde = ' '		and
					a.ysi_cde = imu_hkprctrm	and
					a.ysi_typ = '03'
		left join SYSETINF b  on	b.ysi_cocde = ' '		and
					b.ysi_cde = imu_ftyprctrm	and
					b.ysi_typ = '03'
		left join VNBASINF cusven on	cusven.vbi_venno = ibi_cusven	and
					cusven.vbi_vensts = 'A'
		/*left join #temp_imprcinf std on	imu_itmno = std.itmno		and
					imu_pckunt = std.untcde	and	
					imu_inrqty = std.inrqty		and
					imu_mtrqty = std.mtrqty 	and
					imu_conftr = std.conftr 	and
					imu_cus1no = std.cus1no	and
					imu_cus2no = std.cus2no	and
					imu_ftyprctrm = std.ftyprctrm	and
					imu_hkprctrm = std.prctrm	and
					imu_trantrm = std.trantrm*/
	WHERE 
		qud_cocde = @cocde	and
		qud_qutno = @qutno	and
		(ven.vbi_ventyp = 'I'	or
		 ven.vbi_ventyp = 'J'	or
		 ven.vbi_ventyp is null)
	order by 
		qud_qutno, qud_qutseq,qud_untcde,qud_inrqty,qud_mtrqty,imu_cus1no,imu_cus2no,imu_hkprctrm,imu_ftyprctrm,imu_trantrm,imu_effdat,imu_expdat
END
ELSE
BEGIN
	SELECT	   
		qud_cocde,			qud_qutno,			qud_itmno,	
		qud_colcde,		qud_untcde,		qud_inrqty,
		qud_mtrqty,		qud_venno,		qud_qutseq,
		qud_cuscol,		qud_cusitm,		qud_coldsc,
		qud_note,			qud_stkqty,		qud_cusqty,
		qud_smpqty,		qud_hrmcde,		qud_dtyrat,
		qud_cususd,		qud_cuscad,		qud_dept,
		qud_pckitr,			qud_tbm,			qud_hstref,		
		isnull(ibi_itmno,qud_itmno) as 'ibi_itmno',
		isnull(ibi_alsitmno,qud_alsitmno) as 'ibi_alsitmno',
		isnull(ibi_alscolcde,qud_alscolcde) as 'ibi_alscolcde',
		isnull(ibi_typ,'') as 'ibi_typ',
		isnull(ibi_itmsts,'INA') as 'ibi_itmsts',
		isnull(ibi_engdsc,'') as 'ibi_engdsc',
		isnull(ibi_tirtyp,'') as 'ibi_tirtyp',
		isnull(ibi_moqctn,0) as 'ibi_moqctn',
		isnull(ibi_moa,0) as 'ibi_moa',
		isnull(ibi_curcde,'') as 'ibi_curcde',
		isnull(ibi_lnecde,'') as 'ibi_lnecde',
		isnull(ibi_venno,'') as 'ibi_venno',
		isnull(ibi_cosmth,'') as 'ibi_cosmth',
		isnull(icf_colcde,'') as 'icf_colcde',
		isnull(icf_colcde,'') as 'icf_vencol',
		isnull(ipi_pckseq,0) as 'ipi_pckseq',
		isnull(ipi_pckunt,'') as 'ipi_pckunt',
		isnull(ipi_inrqty,0) as 'ipi_inrqty',	
		isnull(ipi_mtrqty,0) as 'ipi_mtrqty',
		isnull(ipi_cft,0) as 'ipi_cft',
		ipi_pckunt+' / '+ltrim(str(ipi_inrqty))+' / '+ltrim(str(ipi_mtrqty)) as 'packing',
		cast(ipi_inrdin as nvarchar) + 'x' +
		cast(ipi_inrwin as nvarchar)+ 'x' +
		cast(ipi_inrhin as nvarchar)  as 'inner_in',
		
		cast(ipi_mtrdin as nvarchar)+ 'x' +
		cast(ipi_mtrwin as nvarchar)+  'x' +
		cast(ipi_mtrhin as nvarchar) as 'master_in',

		cast(ipi_inrdcm as nvarchar)+ 'x' +
		cast(ipi_inrwcm as nvarchar)+ 'x' +
		cast(ipi_inrhcm as nvarchar) as 'inner_cm',
		
		cast(ipi_mtrdcm as nvarchar)+ 'x' +
		cast(ipi_mtrwcm as nvarchar)+ 'x' +
		cast(ipi_mtrhcm as nvarchar) as 'master_cm',
		isnull(ipi_inrdin,0) as 'ipi_inrdin',
		isnull(ipi_inrwin,0) as 'ipi_inrwin',
		isnull(ipi_inrhin,0) as 'ipi_inrhin',
		isnull(ipi_mtrdin,0) as 'ipi_mtrdin',
		isnull(ipi_mtrwin,0) as 'ipi_mtrwin',
		isnull(ipi_mtrhin,0) as 'ipi_mtrhin',
		isnull(ipi_inrdcm,0) as 'ipi_inrdcm',
		isnull(ipi_inrwcm,0) as 'ipi_inrwcm',
		isnull(ipi_inrhcm,0) as 'ipi_inrhcm',
		isnull(ipi_mtrdcm,0) as 'ipi_mtrdcm',
		isnull(ipi_mtrwcm,0) as 'ipi_mtrwcm',
		isnull(ipi_mtrhcm,0) as 'ipi_mtrhcm',
		isnull(ipi_grswgt,0) as 'ipi_grswgt',
		isnull(ipi_netwgt,0) as 'ipi_netwgt',
		case ipi_qutdat
			when '' then '1900-01-01'
			when null then '1900-01-01'
			else ipi_qutdat end as 'ipi_qutdat',
		isnull(ven.vbi_venno,'') as 'vbi_venno',
		isnull(ivi_venno,'') + ' - ' + isnull(ven.vbi_vensna,'') as 'ivi_venno', 	
		isnull(ivi_venitm,'') as 'ivi_venitm', 
		isnull(ivi_subcde,'') as 'ivi_subcde', 
		isnull(imu_ventyp,'') as 'imu_ventyp',
		isnull(imu_curcde,'') as 'imu_curcde',	
		(case imu_negprc when 0  then imu_ftyprc else imu_negprc end) as 'imu_ftyprc',
		isnull(imu_bcurcde,'') as 'imu_bcurcde',
		isnull( imu_basprc ,0) as 'imu_basprc',
		(case imu_negprc when 0  then imu_ftyprc else imu_negprc end) as 'imu_ftycst',
		isnull(ycf_value,0) as 'ycf_value',
		@copy as 'copy',		@message as 'message',	qud_discnt,
		isnull(imu_hkprctrm,'') + case when imu_hkprctrm is not null then ' - ' else '' end + isnull(a.ysi_dsc,'') as  'imu_prctrm',
		isnull(cusven.vbi_venno,'') +  case isnull(cusven.vbi_vensna,'') when '' then '' else ' - ' + isnull(cusven.vbi_vensna,'') end as 'qud_cusven',
		qud_cussub,
		isnull(imu_ftyprctrm,'') + case when imu_ftyprctrm is not null then ' - ' else '' end + isnull(b.ysi_dsc,'') as  'imu_ftyprctrm',
		isnull(ven.vbi_ventyp,'') as 'vbi_ventyp',
		isnull(ipi_conftr,1) as 'ipi_conftr',	qud_contopc,		qud_pcprc,
		isnull( ipi_cbm,0) as 'ipi_cbm', isnull(icf_ucpcde,'') as 'icf_ucpcde',
		qud_ftytmpitm,		qud_ftytmpitmno,
		isnull(qud_cusstyno,'') as 'ics_cussty',
		isnull(qud_specpck,'') as 'qud_specpck',
		isnull(qud_custitmcat,'') as 'qud_custitmcat',
		isnull(qud_custitmcatfml,'') as 'qud_custitmcatfml',
		isnull(qud_custitmcatamt,'') as 'qud_custitmcatamt',
		isnull(ibi_rmk,'') as 'ibi_rmk',isnull(qud_rndsts,'') as 'qud_rndsts',
		isnull(imu_cus1no,'') as 'imu_cus1no',
		isnull(imu_cus2no,'') as 'imu_cus2no',
		isnull(imu_trantrm,'') as 'imu_trantrm',
		case imu_effdat
			when '' then '1900-01-01'
			when null then '1900-01-01'
			else imu_effdat end as 'imu_effdat',
		case imu_expdat
			when '' then '1900-01-01'
			when null then '1900-01-01'
			else imu_expdat end as 'imu_expdat'
		--isnull(std.std,'') as 'imu_std'
	FROM
		QUOTNDTL
		left join IMBASINF on	(qud_itmno = ibi_itmno	or
					qud_itmno = ibi_alsitmno)	and
					ibi_itmsts <> 'CLO'
		left join IMCOLINF on	icf_itmno = ibi_itmno		and
					icf_colcde = qud_colcde
		left join IMPCKINF on	ipi_itmno = ibi_itmno		and
					ipi_pckunt = qud_untcde	and
					ipi_inrqty = qud_inrqty		and
					ipi_mtrqty = qud_mtrqty	and
					ipi_conftr = qud_conftr
		left join IMVENINF on	ivi_itmno = ibi_itmno		and
					ivi_def = 'Y'
		left join VNBASINF ven on	ven.vbi_venno = ivi_venno	and
					ven.vbi_vensts = 'A'
		left join IMPRCINF on	imu_itmno = ibi_itmno	and
--					imu_status = 'ACT'		and
					imu_prdven = ven.vbi_venno	and
					imu_pckunt = ipi_pckunt	and
					imu_inrqty = ipi_inrqty	and
				 	imu_mtrqty = ipi_mtrqty 	and
					imu_conftr = ipi_conftr	/*and
					imu_ventyp = 
						(case ven.vbi_ventyp 
							when 'I' then 'P' 
							when 'J' then 'P' 
							else 'D' end)*/
		left join SYCONFTR on	ycf_cocde = ' '		and
					ycf_code1 = ipi_pckunt	and
					ycf_code2 = 'PC'
		left join SYSETINF a  on	a.ysi_cocde = ' '		and
					a.ysi_cde = imu_hkprctrm	and
					a.ysi_typ = '03'
		left join VNBASINF cusven  on	cusven.vbi_venno = ibi_cusven	and
					cusven.vbi_vensts = 'A'
		left join SYSETINF b  on	b.ysi_cocde = ' '		and
					b.ysi_cde = imu_ftyprctrm	and
					b.ysi_typ = '03'
		/*left join #temp_imprcinf std on	imu_itmno = std.itmno		and
					imu_pckunt = std.untcde	and
					imu_inrqty = std.inrqty		and
					imu_mtrqty = std.mtrqty 	and
					imu_conftr = std.conftr		*/	
	WHERE 
		qud_cocde = @cocde	and
		qud_qutno = @qutno 	and
		(ven.vbi_ventyp = 'I'	or
		ven.vbi_ventyp = 'J'	or
		ven.vbi_ventyp = 'E'	or
		ven.vbi_ventyp is null)
	order by 
		qud_qutno, qud_qutseq,qud_untcde,qud_inrqty,qud_mtrqty,imu_cus1no,imu_cus2no,imu_hkprctrm,imu_ftyprctrm,imu_trantrm,imu_effdat,imu_expdat
END
--drop table #temp_imprcinf
-----------------------------------------------------------------------------------------------------------------------                                                                                                                                          
end




GO
GRANT EXECUTE ON [dbo].[sp_select_QUOTNDTL_checking2] TO [ERPUSER] AS [dbo]
GO
