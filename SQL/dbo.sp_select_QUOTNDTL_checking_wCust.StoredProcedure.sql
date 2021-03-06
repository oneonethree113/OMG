/****** Object:  StoredProcedure [dbo].[sp_select_QUOTNDTL_checking_wCust]    Script Date: 09/29/2017 15:29:09 ******/
DROP PROCEDURE [dbo].[sp_select_QUOTNDTL_checking_wCust]
GO
/****** Object:  StoredProcedure [dbo].[sp_select_QUOTNDTL_checking_wCust]    Script Date: 09/29/2017 15:29:10 ******/
SET ANSI_NULLS OFF
GO
SET QUOTED_IDENTIFIER OFF
GO














-- It is based on sp_select_QUOTNDTL_checking
/********************************************************************************************************************
Modification History
********************************************************************************************************************
Modify on		Modify by		Description
********************************************************************************************************************
2008-10-28		Lester Wu		For getting price with customer 
********************************************************************************************************************/


CREATE procedure [dbo].[sp_select_QUOTNDTL_checking_wCust]                                                                                                                                                                                                                            
@cocde nvarchar(6),                                                                                                                                                                                                                                         
@qutno nvarchar(20) ,
@imd_cus1no	nvarchar(20),
@imd_cus2no 	nvarchar(20),
@creusr		nvarchar(30)
                                                                                                                                                                                                                                       
                                                                                                                                                                                                                                                                 
                                                                                                                                                                                                                                                                 
AS                                 

declare	@copy	nvarchar(3),	@message		nvarchar(100)               
set @copy = ''
set @message = ''                                                                                                                                                                                                              
                                                                                                                                                                                                                                                                 


declare @selRate as numeric(16,11)
select @selRate = ysi_selrat from SYSETINF where ysi_typ = '06' and ysi_cde = 'HKD'


-- Added by Mark Lau 20081210

select qud_itmno as 'itmno' , qud_untcde as 'untcde' , qud_inrqty as 'inrqty' ,qud_mtrqty as 'mtrqty' ,qud_conftr as 'conftr',
imu_ventyp as 'ventyp' ,imu_venno as 'venno' ,imu_prdven as 'prdven' , isnull( imu_std,'') as 'std' into #temp_immrkup from quotndtl (nolock)
left join immrkup (nolock) on 
imu_itmno = qud_itmno	and
imu_pckunt = qud_untcde and
imu_inrqty = qud_inrqty	and 	
imu_mtrqty = qud_mtrqty 	and
imu_conftr = qud_conftr and
imu_ventyp = 'D'
where
qud_cocde = @cocde AND	
qud_qutno = @qutno 	


select qud_itmno as 'itmno' , qud_untcde as 'untcde' , qud_inrqty as 'inrqty' ,qud_mtrqty as 'mtrqty' ,qud_conftr as 'conftr',
isnull(imd_ventyp,'') as 'ventyp' ,isnull(imd_venno,'') as 'venno' ,isnull(imd_prdven,'') as 'prdven' , isnull( imd_cus1no,'') as 'cus1no', isnull( imd_cus2no,'') as 'cus2no'
into #temp_immrkupdtl 
from quotndtl (nolock)
inner join quotnhdr (nolock) on qud_qutno = quh_qutno
left join immrkupdtl (nolock) on 
imd_itmno = qud_itmno	and
imd_untcde = qud_untcde and
imd_inrqty = qud_inrqty	and 	
imd_mtrqty = qud_mtrqty 	and
imd_conftr = qud_conftr and
imd_ventyp = 'D'
where
qud_cocde = @cocde AND	
qud_qutno = @qutno 	and 
quh_cus1no = isnull( imd_cus1no,'') and 
quh_cus2no = isnull( imd_cus2no,'') 


BEGIN                                          

IF @COCDE = 'UCPP'
BEGIN
	SELECT	   
	
		qud_cocde,	qud_qutno,	qud_itmno,	
		qud_colcde,	qud_untcde,	qud_inrqty,
		qud_mtrqty,	qud_venno,	qud_qutseq,
		qud_cuscol,	qud_cusitm,	qud_coldsc,
		qud_note,		qud_stkqty,	qud_cusqty,
		qud_smpqty,	qud_hrmcde,	qud_dtyrat,
		qud_cususd,	qud_cuscad,	qud_dept,
		qud_pckitr,	qud_tbm,		qud_hstref,
		

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
		-- Frankie Cheung 20100412 add period
		ipi_qutdat as 'ipi_qutdat',
	
		isnull(ven.vbi_venno,'') as 'vbi_venno',
		isnull(ivi_venno,'') + ' - ' + isnull(ven.vbi_vensna,'') as 'ivi_venno', 	
		isnull(ivi_venitm,'') as 'ivi_venitm', 
		isnull(ivi_subcde,'') as 'ivi_subcde', 
		isnull(imd_ventyp,'') as 'imu_ventyp',
		isnull(imd_curcde,'') as 'imu_curcde',	

		isnull((case ven.vbi_ventyp when 'I' then 	
			(case imd_negprc when 0  then imd_calftyprc 
			 else imd_negprc end) 
			when 'J' then 	
			(case imd_negprc when 0  then imd_calftyprc 
			 else imd_negprc end) 
			else

			imd_icttl end),0) + isnull(imd_icD,0)

		  as 'imu_ftyprc',
-------------------------------------------------------------------------------------------------------------
		isnull(imd_bcurcde,'') as 'imu_bcurcde',
		 isnull( imd_basprc ,0) as 'imu_basprc',
		(case ven.vbi_ventyp when 'I' then (case imd_negprc when 0  then imd_calftyprc else imd_negprc end)   
				 when 'J' then (case imd_negprc when 0  then imd_calftyprc else imd_negprc end)   
				 else imd_fcttl end) as 'imu_ftycst',
		isnull(ycf_value,0) as 'ycf_value',
		@copy as 'copy',	@message as 'message',
		qud_discnt,
		
		isnull(imd_prctrm,'') + case when imu_prctrm is not null then ' - ' else '' end + isnull(a.ysi_dsc,'') as  'imu_prctrm',


		isnull(cusven.vbi_venno,'') +  case isnull(cusven.vbi_vensna,'') when '' then '' else ' - ' + isnull(cusven.vbi_vensna,'') end as 'qud_cusven',
		qud_cussub 


		, isnull(imu_ftyprctrm,'') + case when imu_ftyprctrm is not null then ' - ' else '' end + isnull(b.ysi_dsc,'') as  'imu_ftyprctrm'

		, isnull(ven.vbi_ventyp,'') as 'vbi_ventyp'	

		,isnull(ipi_conftr,1) as 'ipi_conftr', qud_contopc, qud_pcprc,
		-- Lester Wu 20080925
		isnull( ipi_cbm,0) as 'ipi_cbm', isnull(icf_ucpcde,'') as 'icf_ucpcde',qud_ftytmpitm,qud_ftytmpitmno,
		isnull(qud_cusstyno,'') as 'ics_cussty', isnull(qud_specpck,'') as 'qud_specpck',
		isnull(qud_custitmcat,'') as 'qud_custitmcat', isnull(qud_custitmcatfml,'') as 'qud_custitmcatfml', isnull(qud_custitmcatamt,'') as 'qud_custitmcatamt',
		isnull(ibi_rmk,'') as 'ibi_rmk',isnull(qud_rndsts,'') as 'qud_rndsts', '' as 'imu_std'

	FROM 
		QUOTNDTL
		inner join quotnhdr on qud_qutno = quh_qutno
		--left join IMBASINF on (qud_itmno = ibi_itmno or qud_itmno = ibi_alsitmno) and ibi_itmsts <> 'CLO'
		left join IMBASINF on (qud_itmno = ibi_itmno ) and ibi_itmsts <> 'CLO'

		left join IMCOLINF on

			icf_itmno = ibi_itmno	and
			icf_colcde = qud_colcde 

		left join IMPCKINF on
	
			ipi_itmno = ibi_itmno	and
			ipi_pckunt = qud_untcde	and	ipi_inrqty = qud_inrqty	and
			ipi_mtrqty = qud_mtrqty
			and ipi_conftr = qud_conftr
		left join IMVENINF on
			ivi_itmno = ibi_itmno	and
			ivi_def = 'Y'
		left join VNBASINF ven on
			ven.vbi_venno = ivi_venno	and
			ven.vbi_vensts = 'A'
		left join IMMRKUP on
			imu_itmno = ibi_itmno	and
			imu_prdven = ven.vbi_venno	and	imu_pckunt = ipi_pckunt	and
			imu_inrqty = ipi_inrqty	and 	imu_mtrqty = ipi_mtrqty 	and
			 imu_conftr = ipi_conftr and
			imu_ventyp =  (case ven.vbi_ventyp 
					when 'I' then 'P' 
					when 'J' then 'P' 
					else 'D' end) --(case @cocde when 'UCPP' then 'P'  else 'D' end)
		left join immrkupdtl on
			imd_itmno = imu_itmno and
			imd_inrqty = imu_inrqty and
			imd_mtrqty = imu_mtrqty and
			imd_untcde = imu_pckunt and
			imd_conftr = imu_conftr and
			imu_prdven = imd_prdven and
			imd_ventyp = 'D'
			
		left join SYCONFTR on
			ycf_cocde = ' ' 
			and ycf_code1 = ipi_pckunt	and
			ycf_code2 = 'PC'

		left join SYSETINF a  on
			a.ysi_cocde = ' '  
			and a.ysi_cde = imu_prctrm and a.ysi_typ = '03'

		left join SYSETINF b  on
			b.ysi_cocde = ' ' 
			and b.ysi_cde = imu_ftyprctrm and b.ysi_typ = '03'
		-------------------------------------------------------------------------------------
		left join VNBASINF cusven on
			cusven.vbi_venno = ibi_cusven	and
			cusven.vbi_vensts = 'A'
		
	WHERE 
		qud_cocde = @cocde AND	
		qud_qutno = @qutno 	and
		(ven.vbi_ventyp = 'I' OR  ven.vbi_ventyp = 'J' OR ven.vbi_ventyp is null)
		and imd_cus1no = @imd_cus1no and imd_cus2no = @imd_cus2no
	--order by 
		--qud_qutno, qud_qutseq     

union
	SELECT	   
	
		qud_cocde,	qud_qutno,	qud_itmno,	
		qud_colcde,	qud_untcde,	qud_inrqty,
		qud_mtrqty,	qud_venno,	qud_qutseq,
		qud_cuscol,	qud_cusitm,	qud_coldsc,
		qud_note,		qud_stkqty,	qud_cusqty,
		qud_smpqty,	qud_hrmcde,	qud_dtyrat,
		qud_cususd,	qud_cuscad,	qud_dept,
		qud_pckitr,	qud_tbm,		qud_hstref,
		
		--isnull(case ibi_alsitmno when qud_itmno then qud_itmno else ibi_itmno end,qud_itmno) as 'ibi_itmno',
		isnull(ibi_itmno,qud_itmno) as 'ibi_itmno',

		--Added by Mark Lau 20060926
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
--		isnull(icf_vencol,'') as 'icf_vencol',
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
		-- Frankie Cheung 20100412 add period
		ipi_qutdat as 'ipi_qutdat',	

		isnull(ven.vbi_venno,'') as 'vbi_venno',
		isnull(ivi_venno,'') + ' - ' + isnull(ven.vbi_vensna,'') as 'ivi_venno', 	
		isnull(ivi_venitm,'') as 'ivi_venitm', 
		isnull(ivi_subcde,'') as 'ivi_subcde', 
		isnull(imu_ventyp,'') as 'imu_ventyp',
		isnull(imu_curcde,'') as 'imu_curcde',	
--		isnull((case @cocde when 'UCPP' then 	
		isnull((case ven.vbi_ventyp when 'I' then 	
			(case imu_negprc when 0  then imu_calftyprc 
			 else imu_negprc end) 
			when 'J' then 	
			(case imu_negprc when 0  then imu_calftyprc 
			 else imu_negprc end) 
			else
---------------------------------------------------------------------------------------------------------
--			imu_ttlcst end),0)  as 'imu_ftyprc',
			imu_ttlcst end),0) + imu_ftybomcst
--			case ven.vbi_ventyp when 'E' then 0 else 
--				case when imu_venno <> imu_prdven then 0 else 	-- For DV <> PV Set BOM Cost to Zero
--					round(isnull(case isnull(iba_curcde,'') when '' then 0 else 
--						case when isnull(iba_curcde,'') = imu_curcde then bomCst else 
--							case when imu_curcde = 'USD' then bomCst*@selRate  else bomCst /@selRate
--							end
--						end  
--					end,0),4)
--				end
--			end 
		  as 'imu_ftyprc',
-------------------------------------------------------------------------------------------------------------
		isnull(imu_bcurcde,'') as 'imu_bcurcde',
		-- isnull(case ibi_alsitmno when qud_itmno then imu_alsbasprc else imu_basprc end ,0) as 'imu_basprc',
		 isnull( imu_basprc ,0) as 'imu_basprc',
		(case ven.vbi_ventyp when 'I' then (case imu_negprc when 0  then imu_calftyprc else imu_negprc end)   
				 when 'J' then (case imu_negprc when 0  then imu_calftyprc else imu_negprc end)   
				 else imu_ftyprc end) as 'imu_ftycst',
		isnull(ycf_value,0) as 'ycf_value',
		@copy as 'copy',	@message as 'message',
		qud_discnt,
		
		--Kenny Add 04-10-2002
		isnull(imu_prctrm,'') + case when imu_prctrm is not null then ' - ' else '' end + isnull(a.ysi_dsc,'') as  'imu_prctrm',

		--Lester Wu 2005-05-24, return custom vendor and custom sub code
		isnull(cusven.vbi_venno,'') +  case isnull(cusven.vbi_vensna,'') when '' then '' else ' - ' + isnull(cusven.vbi_vensna,'') end as 'qud_cusven',

		qud_cussub 

		-- Lester WU 2006-01-19, retrieve factory price term
		, isnull(imu_ftyprctrm,'') + case when imu_ftyprctrm is not null then ' - ' else '' end + isnull(b.ysi_dsc,'') as  'imu_ftyprctrm'
		-- Lester Wu 2006-05-19
		, isnull(ven.vbi_ventyp,'') as 'vbi_ventyp'	
		--Added by Mark Lau 20070618
		,isnull(ipi_conftr,1) as 'ipi_conftr', qud_contopc, qud_pcprc,
		-- Lester Wu 20080925
		isnull( ipi_cbm,0) as 'ipi_cbm', isnull(icf_ucpcde,'') as 'icf_ucpcde',qud_ftytmpitm,qud_ftytmpitmno,
		isnull(qud_cusstyno,'') as 'ics_cussty', isnull(qud_specpck,'') as 'qud_specpck',
		isnull(qud_custitmcat,'') as 'qud_custitmcat', isnull(qud_custitmcatfml,'') as 'qud_custitmcatfml', isnull(qud_custitmcatamt,'') as 'qud_custitmcatamt',
		isnull(ibi_rmk,'') as 'ibi_rmk',isnull(qud_rndsts,'') as 'qud_rndsts', isnull(std.std,'') as 'imu_std'

	FROM 
		QUOTNDTL
		--left join IMBASINF on (qud_itmno = ibi_itmno or qud_itmno = ibi_alsitmno) and ibi_itmsts <> 'CLO'
		left join IMBASINF on (qud_itmno = ibi_itmno ) and ibi_itmsts <> 'CLO'
			 --qud_itmno = (case ibi_alsitmno when  null then ibi_itmno  else ibi_alsitmno  end)
--			ibi_cocde = qud_cocde 	and	
--			ibi_itmno = qud_itmno
		left join IMCOLINF on
			--icf_cocde = qud_cocde 	and 	
			icf_itmno = ibi_itmno	and
			icf_colcde = qud_colcde 
--			icf_vencol = qud_colcde 
		left join IMPCKINF on
			--ipi_cocde = qud_cocde 	and	
			ipi_itmno = ibi_itmno	and
			ipi_pckunt = qud_untcde	and	ipi_inrqty = qud_inrqty	and
			ipi_mtrqty = qud_mtrqty
			--Added by Mark Lau
			and ipi_conftr = qud_conftr
		left join IMVENINF on
			--ivi_cocde = qud_cocde 	and 	
			ivi_itmno = ibi_itmno	and
			ivi_def = 'Y'
		left join VNBASINF ven on
			--ven.vbi_cocde = qud_cocde 	and 	
			ven.vbi_venno = ivi_venno	and
			ven.vbi_vensts = 'A'
		left join IMMRKUP on
			--imu_cocde = qud_cocde	and 	
			imu_itmno = ibi_itmno	and
			imu_prdven = ven.vbi_venno	and	imu_pckunt = ipi_pckunt	and
			imu_inrqty = ipi_inrqty	and 	imu_mtrqty = ipi_mtrqty 	and
			--Added by Mark Lau
			 imu_conftr = ipi_conftr and
			imu_ventyp =  (case ven.vbi_ventyp 
					when 'I' then 'P' 
					when 'J' then 'P' 
					else 'D' end) --(case @cocde when 'UCPP' then 'P'  else 'D' end)
		left join SYCONFTR on
			ycf_cocde = ' ' --qud_cocde 	
			and ycf_code1 = ipi_pckunt	and
			ycf_code2 = 'PC'
			--Kenny Add on 04-10-2002
		left join SYSETINF a  on
			a.ysi_cocde = ' '  --@cocde 
			and a.ysi_cde = imu_prctrm and a.ysi_typ = '03'
		-- Lester Wu 2006-01-19, retrieve factory price term --------------------
		left join SYSETINF b  on
			b.ysi_cocde = ' '  --@cocde 
			and b.ysi_cde = imu_ftyprctrm and b.ysi_typ = '03'
		-------------------------------------------------------------------------------------
		left join VNBASINF cusven on
			cusven.vbi_venno = ibi_cusven	and
			cusven.vbi_vensts = 'A'
		-- Lester Wu 2006-02-09
--		left join #tmp_FtyTtlCst on 
--			qud_itmno = iba_itmno
		-- Mark Lau 20081210
		left join #temp_immrkup std on
			imu_itmno = std.itmno	and
			imu_pckunt = std.untcde	and
			imu_inrqty = std.inrqty	and
			imu_mtrqty = std.mtrqty 	and
			imu_conftr = std.conftr 			
		left join #temp_immrkupdtl  spec on
			imu_itmno = spec.itmno	and
			imu_pckunt = spec.untcde	and
			imu_inrqty = spec.inrqty	and
			imu_mtrqty = spec.mtrqty 	and
			imu_conftr = spec.conftr 	
	
	WHERE 
		qud_cocde = @cocde AND	
		qud_qutno = @qutno 	and
		(ven.vbi_ventyp = 'I' OR  ven.vbi_ventyp = 'J' OR ven.vbi_ventyp is null)
		and isnull(spec.itmno,'') = ''
		-- Lester Wu 2008-10-28
		--and isnull(imu_std,'') <> 'N'	
	order by 
		qud_qutno, qud_qutseq                                                                                                                                                                                                                       
END
ELSE
BEGIN
	-----------------------------------------------------------------------------------------------------------------------                                                                                                                                          
	SELECT	   
	
		qud_cocde,	qud_qutno,	qud_itmno,	
		qud_colcde,	qud_untcde,	qud_inrqty,
		qud_mtrqty,	qud_venno,	qud_qutseq,
		qud_cuscol,	qud_cusitm,	qud_coldsc,
		qud_note,		qud_stkqty,	qud_cusqty,
		qud_smpqty,	qud_hrmcde,	qud_dtyrat,
		qud_cususd,	qud_cuscad,	qud_dept,
		qud_pckitr,	qud_tbm,		qud_hstref,

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
--		isnull(icf_vencol,'') as 'icf_vencol',
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
		-- Frankie Cheung 20100412 add period
		ipi_qutdat as 'ipi_qutdat',
	
		isnull(ven.vbi_venno,'') as 'vbi_venno',
		isnull(ivi_venno,'') + ' - ' + isnull(ven.vbi_vensna,'') as 'ivi_venno', 	
		isnull(ivi_venitm,'') as 'ivi_venitm', 
		isnull(ivi_subcde,'') as 'ivi_subcde', 
		isnull(imd_ventyp,'') as 'imu_ventyp',
		isnull(imd_curcde,'') as 'imu_curcde',	

		isnull((case ven.vbi_ventyp when 'I' then 	
			(case imd_negprc when 0  then imd_calftyprc 
			 else imd_negprc end) 
			when 'J' then 
			(case imd_negprc when 0  then imd_calftyprc 
			 else imd_negprc end) 
			else

			imd_icttl end),0) + isnull(imd_icD,0)

		  as 'imu_ftyprc',

		isnull(imd_bcurcde,'') as 'imu_bcurcde',
		
		 isnull( imd_basprc ,0) as 'imu_basprc',
		(case ven.vbi_ventyp when 'I' then (case imd_negprc when 0  then imd_calftyprc else imd_negprc end)   
				 when 'J' then (case imd_negprc when 0  then imd_calftyprc else imd_negprc end)   
				 else imd_fcttl end) as 'imu_ftycst',
	
		isnull(ycf_value,0) as 'ycf_value',
		@copy as 'copy',	@message as 'message',
		qud_discnt,
		
		isnull(imd_prctrm,'') + case when imu_prctrm is not null then ' - ' else '' end + isnull(a.ysi_dsc,'') as  'imu_prctrm',


		isnull(cusven.vbi_venno,'') +  case isnull(cusven.vbi_vensna,'') when '' then '' else ' - ' + isnull(cusven.vbi_vensna,'') end as 'qud_cusven',
		qud_cussub

		, isnull(imu_ftyprctrm,'') + case when imu_ftyprctrm is not null then ' - ' else '' end + isnull(b.ysi_dsc,'') as  'imu_ftyprctrm'

		, isnull(ven.vbi_ventyp,'') as 'vbi_ventyp'


		,isnull(ipi_conftr,1) as 'ipi_conftr',qud_contopc, qud_pcprc,

		isnull( ipi_cbm,0) as 'ipi_cbm', isnull(icf_ucpcde,'') as 'icf_ucpcde',qud_ftytmpitm,qud_ftytmpitmno,
		isnull(qud_cusstyno,'') as 'ics_cussty', isnull(qud_specpck,'') as 'qud_specpck',
		isnull(qud_custitmcat,'') as 'qud_custitmcat', isnull(qud_custitmcatfml,'') as 'qud_custitmcatfml', isnull(qud_custitmcatamt,'') as 'qud_custitmcatamt',
		isnull(ibi_rmk,'') as 'ibi_rmk',isnull(qud_rndsts,'') as 'qud_rndsts', '' as 'imu_std'
	FROM 
		QUOTNDTL
		inner join quotnhdr on qud_qutno = quh_qutno
		--left join IMBASINF on (qud_itmno = ibi_itmno or qud_itmno = ibi_alsitmno) and ibi_itmsts <> 'CLO'
		left join IMBASINF on (qud_itmno = ibi_itmno ) and ibi_itmsts <> 'CLO'

		left join IMCOLINF on

			icf_itmno = ibi_itmno	and
			icf_colcde = qud_colcde 
		left join IMPCKINF on
			ipi_itmno = ibi_itmno	and
			ipi_pckunt = qud_untcde	and	ipi_inrqty = qud_inrqty	and
			ipi_mtrqty = qud_mtrqty
			and ipi_conftr = qud_conftr
		left join IMVENINF on

			ivi_itmno = ibi_itmno	and
			ivi_def = 'Y'
		left join VNBASINF ven  on
			ven.vbi_venno = ivi_venno	and
			ven.vbi_vensts = 'A'
		left join IMMRKUP on
			imu_itmno = ibi_itmno	and
			imu_prdven = ven.vbi_venno	and	imu_pckunt = ipi_pckunt	and
			imu_inrqty = ipi_inrqty	and 	imu_mtrqty = ipi_mtrqty 	and
			 imu_conftr = ipi_conftr and
			imu_ventyp =  (case ven.vbi_ventyp 
					when 'I' then 'P' 
					when 'J' then 'P' 
					else 'D' end) 
		left join immrkupdtl on
			imd_itmno = imu_itmno and
			imd_inrqty = imu_inrqty and
			imd_mtrqty = imu_mtrqty and
			imd_untcde = imu_pckunt and
			imd_conftr = imu_conftr and
			imu_prdven = imd_prdven and
			imd_ventyp = 'D'
		left join SYCONFTR on
			ycf_cocde = ' '  	
			and ycf_code1 = ipi_pckunt	and
			ycf_code2 = 'PC'
		left join SYSETINF a  on
			a.ysi_cocde = ' ' 
			and a.ysi_cde = imu_prctrm and a.ysi_typ = '03'
		left join VNBASINF cusven  on
			cusven.vbi_venno = ibi_cusven	and
			cusven.vbi_vensts = 'A'
		left join SYSETINF b  on
			b.ysi_cocde = ' '  
			and b.ysi_cde = imu_ftyprctrm and b.ysi_typ = '03'
		-------------------------------------------------------------------------------------

			
	WHERE 
		qud_cocde = @cocde AND	
		qud_qutno = @qutno 	and
		(ven.vbi_ventyp = 'I' OR ven.vbi_ventyp = 'J' or ven.vbi_ventyp = 'E' or ven.vbi_ventyp is null)
		and imd_cus1no = @imd_cus1no and imd_cus2no = @imd_cus2no

union
SELECT	   
	
		qud_cocde,	qud_qutno,	qud_itmno,	
		qud_colcde,	qud_untcde,	qud_inrqty,
		qud_mtrqty,	qud_venno,	qud_qutseq,
		qud_cuscol,	qud_cusitm,	qud_coldsc,
		qud_note,		qud_stkqty,	qud_cusqty,
		qud_smpqty,	qud_hrmcde,	qud_dtyrat,
		qud_cususd,	qud_cuscad,	qud_dept,
		qud_pckitr,	qud_tbm,		qud_hstref,
		--isnull(case ibi_alsitmno when qud_itmno then qud_itmno else ibi_itmno end,qud_itmno) as 'ibi_itmno',
		isnull(ibi_itmno,qud_itmno) as 'ibi_itmno',


		
		--Added by Mark Lau 20060926
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
--		isnull(icf_vencol,'') as 'icf_vencol',
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
		-- Frankie Cheung 20100412 add period
		ipi_qutdat as 'ipi_qutdat',
	
		isnull(ven.vbi_venno,'') as 'vbi_venno',
		isnull(ivi_venno,'') + ' - ' + isnull(ven.vbi_vensna,'') as 'ivi_venno', 	
		isnull(ivi_venitm,'') as 'ivi_venitm', 
		isnull(ivi_subcde,'') as 'ivi_subcde', 
		isnull(imu_ventyp,'') as 'imu_ventyp',
		isnull(imu_curcde,'') as 'imu_curcde',	
--		isnull((case @cocde when 'UCP' then 	
		isnull((case ven.vbi_ventyp when 'I' then 	
			(case imu_negprc when 0  then imu_calftyprc 
			 else imu_negprc end) 
			when 'J' then 
			(case imu_negprc when 0  then imu_calftyprc 
			 else imu_negprc end) 
			else
		--	imu_ttlcst end),0) as 'imu_ftyprc',
			imu_ttlcst end),0) + imu_ftybomcst
--			case ven.vbi_ventyp when 'E' then 0 else 
--				case when imu_venno <> imu_prdven then 0 else	-- For DV <> PV Set BOM Cost to Zero
--					round(isnull(case isnull(iba_curcde,'') when '' then 0 else 
--						case when isnull(iba_curcde,'') = imu_curcde then bomCst else 
--							case when imu_curcde = 'USD' then bomCst*@selRate  else bomCst /@selRate
--							end
--						end  
--					end,0),4) 
--				end 
--			end
		  as 'imu_ftyprc',

		isnull(imu_bcurcde,'') as 'imu_bcurcde',
		-- isnull(case ibi_alsitmno when qud_itmno then imu_alsbasprc else imu_basprc end ,0) as 'imu_basprc',
		 isnull( imu_basprc ,0) as 'imu_basprc',
		(case ven.vbi_ventyp when 'I' then (case imu_negprc when 0  then imu_calftyprc else imu_negprc end)   
				 when 'J' then (case imu_negprc when 0  then imu_calftyprc else imu_negprc end)   
				 else imu_ftyprc end) as 'imu_ftycst',
	
		isnull(ycf_value,0) as 'ycf_value',
		@copy as 'copy',	@message as 'message',
		qud_discnt,
		
		--Kenny Add 04-10-2002
		isnull(imu_prctrm,'') + case when imu_prctrm is not null then ' - ' else '' end + isnull(a.ysi_dsc,'') as  'imu_prctrm',

		--Lester Wu 2005-05-24, return custom vendor and custom sub code
		isnull(cusven.vbi_venno,'') +  case isnull(cusven.vbi_vensna,'') when '' then '' else ' - ' + isnull(cusven.vbi_vensna,'') end as 'qud_cusven',
		qud_cussub
		-- Lester WU 2006-01-19, retrieve factory price term
		, isnull(imu_ftyprctrm,'') + case when imu_ftyprctrm is not null then ' - ' else '' end + isnull(b.ysi_dsc,'') as  'imu_ftyprctrm'
		-- Lester Wu 2006-05-19
		, isnull(ven.vbi_ventyp,'') as 'vbi_ventyp'
		--Added by Mark Lau 20070618

		,isnull(ipi_conftr,1) as 'ipi_conftr',qud_contopc, qud_pcprc,
		-- Lester Wu 20080925
		isnull( ipi_cbm,0) as 'ipi_cbm', isnull(icf_ucpcde,'') as 'icf_ucpcde',qud_ftytmpitm,qud_ftytmpitmno,
		isnull(qud_cusstyno,'') as 'ics_cussty', isnull(qud_specpck,'') as 'qud_specpck',
		isnull(qud_custitmcat,'') as 'qud_custitmcat', isnull(qud_custitmcatfml,'') as 'qud_custitmcatfml', isnull(qud_custitmcatamt,'') as 'qud_custitmcatamt',
		isnull(ibi_rmk,'') as 'ibi_rmk',isnull(qud_rndsts,'') as 'qud_rndsts', isnull(std.std,'') as 'imu_std'
	FROM 
		QUOTNDTL
		--left join IMBASINF on (qud_itmno = ibi_itmno or qud_itmno = ibi_alsitmno) and ibi_itmsts <> 'CLO'
		left join IMBASINF on (qud_itmno = ibi_itmno ) and ibi_itmsts <> 'CLO'
			 --qud_itmno = (case ibi_alsitmno when  null then ibi_itmno  else ibi_alsitmno  end)
--			ibi_cocde = qud_cocde 	and	
--			ibi_itmno = qud_itmno
		left join IMCOLINF on
			--icf_cocde = qud_cocde 	and 	
			icf_itmno = ibi_itmno	and
			icf_colcde = qud_colcde 
--			icf_vencol = qud_colcde 
		left join IMPCKINF on
			--ipi_cocde = qud_cocde 	and	
			ipi_itmno = ibi_itmno	and
			ipi_pckunt = qud_untcde	and	ipi_inrqty = qud_inrqty	and
			ipi_mtrqty = qud_mtrqty
			--Added by Mark Lau
			and ipi_conftr = qud_conftr
		left join IMVENINF on
			--ivi_cocde = qud_cocde 	and 	
			ivi_itmno = ibi_itmno	and
			ivi_def = 'Y'
		left join VNBASINF ven  on
			--ven.vbi_cocde = qud_cocde 	and 	
			ven.vbi_venno = ivi_venno	and
			ven.vbi_vensts = 'A'
		left join IMMRKUP on
			--imu_cocde = qud_cocde	and 	
			imu_itmno = ibi_itmno	and
			imu_prdven = ven.vbi_venno	and	imu_pckunt = ipi_pckunt	and
			imu_inrqty = ipi_inrqty	and 	imu_mtrqty = ipi_mtrqty 	and
			--Added by Mark Lau
			 imu_conftr = ipi_conftr and
			imu_ventyp =  (case ven.vbi_ventyp 
					when 'I' then 'P' 
					when 'J' then 'P' 
					else 'D' end) --(case @cocde when 'UCPP' then 'P'  else 'D' end)
		left join SYCONFTR on
			ycf_cocde = ' ' --qud_cocde 	
			and ycf_code1 = ipi_pckunt	and
			ycf_code2 = 'PC'
			--Kenny Add on 04-10-2002
		left join SYSETINF a  on
			a.ysi_cocde = ' '  --@cocde 
			and a.ysi_cde = imu_prctrm and a.ysi_typ = '03'
		left join VNBASINF cusven  on
			cusven.vbi_venno = ibi_cusven	and
			cusven.vbi_vensts = 'A'
		-- Lester Wu 2006-01-19, retrieve factory price term --------------------
		left join SYSETINF b  on
			b.ysi_cocde = ' '  --@cocde 
			and b.ysi_cde = imu_ftyprctrm and b.ysi_typ = '03'
		-------------------------------------------------------------------------------------
		-- Lester Wu 2006-02-09
--		left join #tmp_FtyTtlCst on 
--			qud_itmno = iba_itmno
		-- Mark Lau 20081210
		left join #temp_immrkup std on
			imu_itmno = std.itmno	and
			imu_pckunt = std.untcde	and
			imu_inrqty = std.inrqty	and
			imu_mtrqty = std.mtrqty 	and
			imu_conftr = std.conftr 				
		left join #temp_immrkupdtl  spec on
			std.itmno = spec.itmno	and
			std.untcde = spec.untcde	and
			std.inrqty = spec.inrqty	and
			 std.mtrqty = spec.mtrqty 	and
			 std.conftr  = spec.conftr 	
	WHERE 
		qud_cocde = @cocde AND	
		qud_qutno = @qutno 	and
		--ven.vbi_ventyp = 'E'
		(ven.vbi_ventyp = 'I' OR ven.vbi_ventyp = 'J' or ven.vbi_ventyp = 'E' or ven.vbi_ventyp is null)
		-- Lester Wu 2008-10-28
		--and isnull(imu_std,'') <> 'N'	
		and isnull(spec.itmno,'') = ''

	order by 
		qud_qutno, qud_qutseq                                                                                                                                 

END
-----------------------------------------------------------------------------------------------------------------------                                                                                                                                          
end






GO
GRANT EXECUTE ON [dbo].[sp_select_QUOTNDTL_checking_wCust] TO [ERPUSER] AS [dbo]
GO
