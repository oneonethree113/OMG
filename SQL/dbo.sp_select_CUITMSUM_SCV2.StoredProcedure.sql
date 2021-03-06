/****** Object:  StoredProcedure [dbo].[sp_select_CUITMSUM_SCV2]    Script Date: 09/29/2017 15:29:09 ******/
DROP PROCEDURE [dbo].[sp_select_CUITMSUM_SCV2]
GO
/****** Object:  StoredProcedure [dbo].[sp_select_CUITMSUM_SCV2]    Script Date: 09/29/2017 15:29:10 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO


-- Checked by Allan Yuen at 28/07/2003


/************************************************************************
Author:		Kenny Chan
Date:		03rd Jan, 2002
Description:	Select data From CUITMSUM
Parameter:	1. Company
		2. Item no
************************************************************************
2003-09-03 Bug Fix Select with second customer error
2003-12-04 Select Production Vendor Item Only in IMMRKUP.
2004-04-07 Add Item Status "TBC"
*/
------------------------------------------------- 
/*
sp_select_CUITMSUM_SCV2 'UCPP','03A4690418201','','50001'

sp_select_CUITMSUM_SCV2 'UCPP','03A469-041826','','50001'


*/

CREATE procedure [dbo].[sp_select_CUITMSUM_SCV2]
                                                                                                                                                                                                                                                                 
---------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------- 
@cis_cocde nvarchar(6) ,
@cis_itmno nvarchar(20),
@cis_seccus nvarchar(6),
@cis_cusno nvarchar(6)

---------------------------------------------- 
 
AS
begin

/*
select imu_itmno as 'itmno' , imu_pckunt as 'untcde' , imu_inrqty as 'inrqty' ,imu_mtrqty as 'mtrqty' ,imu_conftr as 'conftr',
imu_ventyp as 'ventyp' ,imu_venno as 'venno' ,imu_prdven as 'prdven' , isnull( imu_std,'') as 'std' into #temp_immrkup
 from immrkup (nolock)
where
imu_itmno = @cis_itmno	 and
imu_ventyp = 'D'
*/
---- Create Temp IM Table  ----
select 
	* 
into 
	#IMTemp
from 
(
SELECT 
ibi_itmno, 
bas.ibi_alsitmno, 
bas.ibi_typ, 
bas.ibi_itmsts, 
bas.ibi_tirtyp,
bas.ibi_venno, 
icf_colcde, 
icf_vencol, 
ipi_pckunt, 
ipi_inrqty, 
ipi_mtrqty,
ipi_conftr, 
ipi_cft, 
ipi_cbm, 
imu_bcurcde, 
imu_basprc,
'N' as'ResultStatus' , 
isnull(bas.ibi_alscolcde,'') as 'ibi_alscolcde', 
bas.ibi_ftytmp,
--'' as 'imu_std',
imu_cus1no,
imu_cus2no,
imu_status,
imu_hkprctrm,
imu_ftyprctrm,
imu_trantrm,
imu_effdat,
imu_expdat
from 
imbasinf  bas
left join imcolinf on icf_itmno = bas.ibi_itmno 
left join impckinf on ipi_itmno = bas.ibi_itmno 
left join imveninf on ivi_itmno = bas.ibi_itmno and ivi_def = 'Y'
left join IMPRCINF on imu_itmno = bas.ibi_itmno and imu_prdven = ivi_venno and imu_pckunt = ipi_pckunt and imu_inrqty = ipi_inrqty and imu_mtrqty = ipi_mtrqty and imu_conftr = ipi_conftr
where
bas.ibi_itmno = @cis_itmno and bas.ibi_itmsts <> 'CLO' 
--and imu_status = 'ACT'

union 

SELECT 
bas.ibi_itmno, 
bas.ibi_alsitmno, 
bas.ibi_typ, 
bas.ibi_itmsts, 
bas.ibi_tirtyp, 
bas.ibi_venno, 
icf_colcde, 
icf_vencol, 
ipi_pckunt, 
ipi_inrqty, 
ipi_mtrqty,
ipi_conftr, 
ipi_cft, 
ipi_cbm, 
imu_bcurcde, 
imu_basprc,
'A' as'ResultStatus',
isnull(bas.ibi_alscolcde,'') as 'ibi_alscolcde', 
bas.ibi_ftytmp,
--'' as 'imu_std',
imu_cus1no,
imu_cus2no,
imu_status,
imu_hkprctrm,
imu_ftyprctrm,
imu_trantrm,
imu_effdat,
imu_expdat
from 
imbasinf  bas
left join imbasinf old on bas.ibi_alsitmno = old.ibi_itmno 
left join imcolinf  on	icf_itmno = bas.ibi_itmno 
left join impckinf   on	ipi_itmno = bas.ibi_itmno 
left join imveninf on ivi_itmno = bas.ibi_itmno and ivi_def = 'Y'
left join IMPRCINF on imu_itmno = bas.ibi_itmno and imu_prdven = ivi_venno and imu_pckunt = ipi_pckunt and imu_inrqty = ipi_inrqty and imu_mtrqty = ipi_mtrqty and imu_conftr = ipi_conftr
where	bas.ibi_alsitmno = @cis_itmno and bas.ibi_itmsts <> 'CLO'  and	isnull(old.ibi_itmsts,'') <> 'OLD' 
--and imu_status = 'ACT'

union
SELECT 
bas.ibi_itmno, 
bas.ibi_alsitmno, 
bas.ibi_typ, 
bas.ibi_itmsts, 
bas.ibi_tirtyp, 
bas.ibi_venno, 
icf_colcde, 
icf_vencol, 
ipi_pckunt, 
ipi_inrqty, 
ipi_mtrqty,
ipi_conftr, 
ipi_cft, 
ipi_cbm, 
imu_bcurcde, 
imu_basprc,
'H' as'ResultStatus',
isnull(bas.ibi_alscolcde,'') as 'ibi_alscolcde', 
bas.ibi_ftytmp,
--'' as 'imu_std',
imu_cus1no,
imu_cus2no,
imu_status,
imu_hkprctrm,
imu_ftyprctrm,
imu_trantrm,
imu_effdat,
imu_expdat
from 
imbasinfh  bas
left join imcolinfh   on icf_itmno = bas.ibi_itmno 
left join impckinfh   on ipi_itmno = bas.ibi_itmno 
left join imveninfh on ivi_itmno = bas.ibi_itmno and ivi_def = 'Y'
left join IMPRCINFH on imu_itmno = bas.ibi_itmno and imu_prdven = ivi_venno and imu_pckunt = ipi_pckunt and imu_inrqty = ipi_inrqty and imu_mtrqty = ipi_mtrqty and imu_conftr = ipi_conftr
where bas.ibi_itmno = @cis_itmno

union 

SELECT 
bas.ibi_itmno, 
bas.ibi_alsitmno, 
bas.ibi_typ, 
bas.ibi_itmsts, 
bas.ibi_tirtyp, 
bas.ibi_venno, 
icf_colcde, 
icf_vencol, 
ipi_pckunt, 
ipi_inrqty, 
ipi_mtrqty,
ipi_conftr, 
ipi_cft, 
ipi_cbm, 
imu_bcurcde, 
imu_basprc,
'HA' as'ResultStatus',
isnull(bas.ibi_alscolcde,'') as 'ibi_alscolcde',
bas.ibi_ftytmp,
--'' as 'imu_std',
imu_cus1no,
imu_cus2no,
imu_status,
imu_hkprctrm,
imu_ftyprctrm,
imu_trantrm,
imu_effdat,
imu_expdat
from 
imbasinfh  bas
left join imbasinfh old on bas.ibi_alsitmno = old.ibi_itmno
left join imcolinfh   on icf_itmno = bas.ibi_itmno 
left join impckinfh   on ipi_itmno = bas.ibi_itmno 
left join imveninfh on ivi_itmno = bas.ibi_itmno and ivi_def = 'Y'
left join IMPRCINFH on imu_itmno = bas.ibi_itmno and imu_prdven = ivi_venno and imu_pckunt = ipi_pckunt and imu_inrqty = ipi_inrqty and imu_mtrqty = ipi_mtrqty and imu_conftr = ipi_conftr
where
bas.ibi_alsitmno = @cis_itmno 
	) as table_a
-------------------------------------------------------

--select  * from #IMTemp
-------------------------------------------------------



if ltrim(rtrim(@cis_seccus)) <> '' 
begin 
	Select
		cis_cocde,	cis_cusno,	cis_seccus,	cis_itmno,	cis_itmdsc,	cis_cusitm,	cis_colcde,	cis_coldsc,
		cis_cuscol,	cis_untcde,	cis_inrqty,	cis_mtrqty,	
	
		cis_cft = 	case ResultStatus
			       when 'N' then ISNULL(ipi_cft,0)
			       when 'A' then ISNULL(ipi_cft,0)
			       when 'H' then ISNULL(ipi_cft,0)
			       when 'HA' then ISNULL(ipi_cft,0)
		                  else
			      0
		    	end,
	
		cis_cbm = case ResultStatus
			       when 'N' then ISNULL(ipi_cbm,0)
			       when 'A' then ISNULL(ipi_cbm,0)
			       when 'H' then ISNULL(ipi_cbm,0)
			       when 'HA' then ISNULL(ipi_cbm,0)
		                  else
			      0
		    	end,
	
		cis_refdoc,	cis_docdat, cis_cussku, cis_curcde, cis_ordqty, cis_selprc, cis_hrmcde, cis_dtyrat, 
		cis_dept, cis_typcode, cis_code1, cis_code2, cis_code3, cis_cususd, cis_cuscad, 
		--**********************************
		cast(cis_colcde as nvarchar(30)) + ' / ' + 
		cast(cis_untcde as nvarchar(6)) + ' / ' + 
		cast(cis_inrqty as nvarchar(10)) + ' / ' + 
		cast(cis_mtrqty as nvarchar(10)) + ' / ' + 
		cast( Case  	when ipi_cft = 0 or ipi_cft is null then isnull(ipi_cft,cis_cft) 
			else ipi_cft 
			end as nvarchar(10)) + ' / ' +
		cast(Case  when ipi_cbm= 0 or ipi_cbm is null  then isnull(ipi_cbm,cis_cbm) else ipi_cbm end as nvarchar(10)) as 'cis_colpck',
		--Kenny Add on 10-10-2002
		--**********************************
		cis_inrdin,
		cis_inrwin,
		cis_inrhin,
		cis_mtrdin,
		cis_mtrwin,
		cis_mtrhin,
		cis_inrdcm,
		cis_inrwcm,
		cis_inrhcm,
		cis_mtrdcm,
		cis_mtrwcm,
		cis_mtrhcm,
		case ResultStatus
			WHEN 'N'
			THEN
				Case ibi_itmsts 	
					when 'CMP' then 'CMP - Active Item with complete Info.'
					when 'INC' then 'INC - Active Item with incomplete Info.'
					when 'HLD' then 'HLD - Active Item Hold by the system'
					when 'DIS' then 'DIS - Discontinue Item'
					when 'INA' then 'INA - Inactive Item'
					when 'CLO' then 'CLO - Closed (UCP Item)'
					when 'TBC' then 'TBC - To be confirmed Item'
					-- Lester Wu 2006-09-17
					when 'OLD' then 'OLD - Old Item'
				end
			WHEN 'A'
			THEN
				Case ibi_itmsts 	
					when 'CMP' then 'CMP - Active Item with complete Info.'
					when 'INC' then 'INC - Active Item with incomplete Info.'
					when 'HLD' then 'HLD - Active Item Hold by the system'
					when 'DIS' then 'DIS - Discontinue Item'
					when 'INA' then 'INA - Inactive Item'
					when 'CLO' then 'CLO - Closed (UCP Item)'
					when 'TBC' then 'TBC - To be confirmed Item'
					-- Lester Wu 2006-09-17
					when 'OLD' then 'OLD - Old Item'
				end
			WHEN 'H' THEN 'N/A'
			WHEN 'HA' THEN 'N/A'		
			ELSE 'MISSING'
		end as 'ibi_itmsts',
		Isnull(ibi_typ,'N/A') as 'ibi_typ',
		isnull(imu_bcurcde,'N/A') as  'imu_bcurcde',
		isnull(imu_basprc,0) as 'imu_basprc',
		cis_qutdat, -- Frankie Cheung 20100413 Add Period	
		cis_creusr,
		cis_updusr,
		cis_credat,
		cis_upddat,
		cast(cis_timstp as int ) as 'cis_timstp',
		case ResultStatus
			WHEN 'H'
			THEN
				Case ibi_itmsts 	
					when 'CMP' then 'CMP - Active Item with complete Info.'
					when 'INC' then 'INC - Active Item with incomplete Info.'
					when 'HLD' then 'HLD - Active Item Hold by the system'
					when 'DIS' then 'DIS - Discontinue Item'
					when 'INA' then 'INA - Inactive Item'
					when 'CLO' then 'CLO - Closed (UCP Item)'
					when 'TBC' then 'TBC - To be confirmed Item'
					-- Lester Wu 2006-09-17
					when 'OLD' then 'OLD - Old Item'
				else 'CMP'
				end
			WHEN 'HA'
			THEN
				Case ibi_itmsts 	
					when 'CMP' then 'CMP - Active Item with complete Info.'
					when 'INC' then 'INC - Active Item with incomplete Info.'
					when 'HLD' then 'HLD - Active Item Hold by the system'
					when 'DIS' then 'DIS - Discontinue Item'
					when 'INA' then 'INA - Inactive Item'
					when 'CLO' then 'CLO - Closed (UCP Item)'
					when 'TBC' then 'TBC - To be confirmed Item'
					-- Lester Wu 2006-09-17
					when 'OLD' then 'OLD - Old Item'
				else 'CMP'
				end
			WHEN 'N' THEN 'N/A'
			WHEN 'A' THEN 'N/A'		
			ELSE 'N/A'
		end as 'h_ibi_itmsts',
	
		case ResultStatus
			when 'H' then Isnull(ibi_typ,'N/A') 		
			when 'HA' then Isnull(ibi_typ,'N/A') 
		else 'N/A'
		end as 'h_ibi_typ',	
	
		case ResultStatus
			when 'H' then isnull(imu_bcurcde,'N/A') 
			when 'HA' then isnull(imu_bcurcde,'N/A') 
		else 'N/A'
		end as 'h_imu_bcurcde',
	
		case ResultStatus
			when 'H' then isnull(imu_basprc,0) 
			when 'HA' then isnull(imu_basprc,0) 
		else '0'
		end as 'h_imu_basprc',
	
		cis_pckitr,
	

		case ResultStatus
			when 'N' then isnull(ibi_tirtyp,'0') 
			when 'A' then isnull(ibi_tirtyp,'0') 
		else '0'
		end as 'ibi_tirtyp',
	
		case ResultStatus
			when 'H' then isnull(ibi_tirtyp,'2') 
			when 'HA' then isnull(ibi_tirtyp,'2') 
		else '2'
		end as 'h_ibi_tirtyp',
	
		isnull(icf_colcde , '@#') as 'icf_colcde',
		ibi_venno , 
		ibi_alsitmno , 
		ibi_alscolcde ,			
		--Added by Mark Lau 20070621
			cis_conftr, cis_contopc, cis_pcprc, isnull(ibi_ftytmp,'') as 'ibi_ftytmp'
		-- Added by Mark Lau 20081107
			,isnull(cis_cusstyno,'') as 'cis_cusstyno', '' as 'imu_std',
imu_cus1no,
imu_cus2no,
imu_status,
imu_hkprctrm,
imu_ftyprctrm,
imu_trantrm,
imu_effdat,
imu_expdat

	From 
		CUITMSUM 
		LEFT JOIN #IMTemp ON
			(ibi_itmno = @cis_itmno  or ibi_alsitmno = @cis_itmno) and
			--cis_colcde = icf_colcde and
			ltrim(rtrim(cis_colcde)) = ltrim(rtrim(icf_colcde)) and
--			ltrim(rtrim(cis_colcde)) = ltrim(rtrim(icf_vencol)) and
			cis_untcde = ipi_pckunt and
			cis_inrqty = ipi_inrqty and
			cis_mtrqty = ipi_mtrqty 
			--Added by Mark Lau 20070621
			and cis_conftr = ipi_conftr
			and cis_cus1no = imu_cus1no
			and cis_cus2no = imu_cus2no

	
	where
		cis_cusno in 
			(select cbi_cusno from cubasinf (nolock)   where (cbi_cusali = @cis_cusno or cbi_cusno = @cis_cusno) and cbi_cusno  <> ''
			   UNION
			   SELECT cbi_cusali from cubasinf (nolock) where cbi_cusno = @cis_cusno and cbi_cusali <> '')
	and
		cis_seccus in 
			(select cbi_cusno from cubasinf (nolock)   where (cbi_cusali = @cis_seccus or cbi_cusno = @cis_seccus) and cbi_cusno <> ''
			   UNION
			   SELECT cbi_cusali from cubasinf (nolock) where cbi_cusno = @cis_seccus and cbi_cusali  <> '') 
		--= @cis_seccus  
	and
		cis_itmno in 	(select ibi.ibi_itmno from imbasinf ibi (nolock) 
				left join IMBASINF als (nolock) on ibi.ibi_alsitmno = als.ibi_itmno
				where ibi.ibi_itmno = @cis_itmno or (ibi.ibi_alsitmno = @cis_itmno and isnull(als.ibi_itmsts,'') <> 'OLD')
				UNION
				-- select ibi.ibi_alsitmno from imbasinf ibi (nolock) where ibi.ibi_itmno = @cis_itmno 
				select ibi.ibi_alsitmno from imbasinf ibi (nolock) 
				left join IMBASINF als (nolock) on ibi.ibi_alsitmno = als.ibi_itmno
				where ibi.ibi_itmno = @cis_itmno and isnull(als.ibi_itmsts,'') <> 'OLD'

				)
	
	--ibi_typ
	--ibi_itmsts
	--ibi_tirtyp
	--ipi_cft
	--ipi_cbm
	--imu_bcurcde
	--imu_basprc
	--ResultStatus
		-- Mark Lau 2008-11-24
		--and imu_std <> 'N'
	--Added by Mark Lau 20080311
	order by cis_colcde asc , cis_untcde asc, cis_conftr desc
end
else
begin
	Select
		cis_cocde,	cis_cusno,	cis_seccus,	cis_itmno,	cis_itmdsc,	cis_cusitm,	cis_colcde,	cis_coldsc,

		cis_cuscol,	cis_untcde,	cis_inrqty,	cis_mtrqty,	
	
		cis_cft = 	case ResultStatus
			       when 'N' then ISNULL(ipi_cft,0)
			       when 'A' then ISNULL(ipi_cft,0)
			       when 'H' then ISNULL(ipi_cft,0)
			       when 'HA' then ISNULL(ipi_cft,0)
		                  else
			      0
		    	end,
	
		cis_cbm = case ResultStatus
			       when 'N' then ISNULL(ipi_cbm,0)
			       when 'A' then ISNULL(ipi_cbm,0)
			       when 'H' then ISNULL(ipi_cbm,0)
			       when 'HA' then ISNULL(ipi_cbm,0)
		                  else
			      0
		    	end,
	
		cis_refdoc,	cis_docdat, cis_cussku, cis_curcde, cis_ordqty, cis_selprc, cis_hrmcde, cis_dtyrat, 
		cis_dept, cis_typcode, cis_code1, cis_code2, cis_code3, cis_cususd, cis_cuscad, 
		--**********************************
		cast(cis_colcde as nvarchar(30)) + ' / ' + 
		cast(cis_untcde as nvarchar(6)) + ' / ' + 
		cast(cis_inrqty as nvarchar(10)) + ' / ' + 
		cast(cis_mtrqty as nvarchar(10)) + ' / ' + 
		cast( Case  	when ipi_cft = 0 or ipi_cft is null then isnull(ipi_cft,cis_cft) 
			else ipi_cft 
			end as nvarchar(10)) + ' / ' +
		cast(Case  when ipi_cbm= 0 or ipi_cbm is null  then isnull(ipi_cbm,cis_cbm) else ipi_cbm end as nvarchar(10)) as 'cis_colpck',
		--Kenny Add on 10-10-2002
		--**********************************
		cis_inrdin,
		cis_inrwin,
		cis_inrhin,
		cis_mtrdin,
		cis_mtrwin,
		cis_mtrhin,
		cis_inrdcm,
		cis_inrwcm,
		cis_inrhcm,
		cis_mtrdcm,
		cis_mtrwcm,
		cis_mtrhcm,
		case ResultStatus
			WHEN 'N'
			THEN
				Case ibi_itmsts 	
					when 'CMP' then 'CMP - Active Item with complete Info.'
					when 'INC' then 'INC - Active Item with incomplete Info.'
					when 'HLD' then 'HLD - Active Item Hold by the system'
					when 'DIS' then 'DIS - Discontinue Item'
					when 'INA' then 'INA - Inactive Item'
					when 'CLO' then 'CLO - Closed (UCP Item)'
					when 'TBC' then 'TBC - To be confirmed Item'
					-- Lester Wu 2006-09-17
					when 'OLD' then 'OLD - Old Item'
				end
			WHEN 'A'
			THEN
				Case ibi_itmsts 	
					when 'CMP' then 'CMP - Active Item with complete Info.'
					when 'INC' then 'INC - Active Item with incomplete Info.'
					when 'HLD' then 'HLD - Active Item Hold by the system'
					when 'DIS' then 'DIS - Discontinue Item'
					when 'INA' then 'INA - Inactive Item'
					when 'CLO' then 'CLO - Closed (UCP Item)'
					when 'TBC' then 'TBC - To be confirmed Item'
					-- Lester Wu 2006-09-17
					when 'OLD' then 'OLD - Old Item'
				end
			WHEN 'H' THEN 'N/A'
			WHEN 'HA' THEN 'N/A'		
			ELSE 'MISSING'
		end as 'ibi_itmsts',
		Isnull(ibi_typ,'N/A') as 'ibi_typ',
		isnull(imu_bcurcde,'N/A') as  'imu_bcurcde',
		isnull(imu_basprc,0) as 'imu_basprc',
		cis_qutdat, -- Frankie Cheung 20100413 Add Period	
		cis_creusr,
		cis_updusr,
		cis_credat,
		cis_upddat,
		cast(cis_timstp as int ) as 'cis_timstp',
		case ResultStatus
			WHEN 'H'
			THEN
				Case ibi_itmsts 	
					when 'CMP' then 'CMP - Active Item with complete Info.'
					when 'INC' then 'INC - Active Item with incomplete Info.'
					when 'HLD' then 'HLD - Active Item Hold by the system'
					when 'DIS' then 'DIS - Discontinue Item'
					when 'INA' then 'INA - Inactive Item'
					when 'CLO' then 'CLO - Closed (UCP Item)'
					when 'TBC' then 'TBC - To be confirmed Item'
					-- Lester Wu 2006-09-17
					when 'OLD' then 'OLD - Old Item'
				else 'CMP'
				end
			WHEN 'HA'
			THEN
				Case ibi_itmsts 	
					when 'CMP' then 'CMP - Active Item with complete Info.'

					when 'INC' then 'INC - Active Item with incomplete Info.'
					when 'HLD' then 'HLD - Active Item Hold by the system'
					when 'DIS' then 'DIS - Discontinue Item'
					when 'INA' then 'INA - Inactive Item'
					when 'CLO' then 'CLO - Closed (UCP Item)'
					when 'TBC' then 'TBC - To be confirmed Item'
					-- Lester Wu 2006-09-17
					when 'OLD' then 'OLD - Old Item'
				else 'CMP'
				end
			WHEN 'N' THEN 'N/A'
			WHEN 'A' THEN 'N/A'		
			ELSE 'N/A'
		end as 'h_ibi_itmsts',
		case ResultStatus
			when 'H' then Isnull(ibi_typ,'N/A') 		
			when 'HA' then Isnull(ibi_typ,'N/A') 
		else 'N/A'
		end as 'h_ibi_typ',	
	
		case ResultStatus
			when 'H' then isnull(imu_bcurcde,'N/A') 
			when 'HA' then isnull(imu_bcurcde,'N/A') 
		else 'N/A'
		end as 'h_imu_bcurcde',
	
		case ResultStatus
			when 'H' then isnull(imu_basprc,0) 
			when 'HA' then isnull(imu_basprc,0) 
		else '0'
		end as 'h_imu_basprc',
	
		cis_pckitr,
	
		case ResultStatus
			when 'N' then isnull(ibi_tirtyp,'0') 
			when 'A' then isnull(ibi_tirtyp,'0') 
		else '0'
		end as 'ibi_tirtyp',
	
		case ResultStatus
			when 'H' then isnull(ibi_tirtyp,'2') 
			when 'HA' then isnull(ibi_tirtyp,'2') 
		else '2'
		end as 'h_ibi_tirtyp',
	
		isnull(icf_colcde , '@#') as 'icf_colcde',
		ibi_venno , 
		ibi_alsitmno , 
		ibi_alscolcde ,
		--Added by Mark Lau 20070621
		cis_conftr,
		cis_contopc , 
		cis_pcprc ,isnull(ibi_ftytmp,'') as 'ibi_ftytmp'
		-- Added by Mark Lau 20081107
			,isnull(cis_cusstyno,'') as 'cis_cusstyno', '' as 'imu_std',
imu_cus1no,
imu_cus2no,
imu_status,
imu_hkprctrm,
imu_ftyprctrm,
imu_trantrm,
imu_effdat,
imu_expdat

	From 
		CUITMSUM 
		LEFT JOIN #IMTemp ON
			(ibi_itmno = @cis_itmno  or ibi_alsitmno = @cis_itmno) and
			--cis_colcde = icf_colcde and
			ltrim(rtrim(cis_colcde)) = ltrim(rtrim(icf_colcde)) and
--			ltrim(rtrim(cis_colcde)) = ltrim(rtrim(icf_vencol)) and
			cis_untcde = ipi_pckunt and
			cis_inrqty = ipi_inrqty and
			cis_mtrqty = ipi_mtrqty 
			--Added by Mark Lau 20070621
			and cis_conftr = ipi_conftr
			and cis_cus1no = imu_cus1no
			and cis_cus2no = imu_cus2no
	
	where
		cis_cusno in 
			(select cbi_cusno from cubasinf (nolock)   where (cbi_cusali = @cis_cusno or cbi_cusno = @cis_cusno) and cbi_cusno <> ''
			   UNION
			   SELECT cbi_cusali from cubasinf (nolock) where cbi_cusno = @cis_cusno and cbi_cusali <> '') 
		and
		cis_seccus = ''
		and
		cis_itmno in 	
				(select ibi.ibi_itmno from imbasinf ibi (nolock) 
				left join IMBASINF als (nolock) on ibi.ibi_alsitmno = als.ibi_itmno
				where ibi.ibi_itmno = @cis_itmno or (ibi.ibi_alsitmno = @cis_itmno and isnull(als.ibi_itmsts,'') <> 'OLD')
				UNION
				-- select ibi.ibi_alsitmno from imbasinf ibi (nolock) where ibi.ibi_itmno = @cis_itmno 
				select ibi.ibi_alsitmno from imbasinf ibi (nolock) 
				left join IMBASINF als (nolock) on ibi.ibi_alsitmno = als.ibi_itmno
				where ibi.ibi_itmno = @cis_itmno and isnull(als.ibi_itmsts,'') <> 'OLD'

				)

	
	--ibi_typ
	--ibi_itmsts
	--ibi_tirtyp

	--ipi_cft
	--ipi_cbm
	--imu_bcurcde
	--imu_basprc
	--ResultStatus        
		-- Mark Lau 2008-11-24
		--and imu_std <> 'N'
	--Added by Mark Lau 20080311
	order by cis_colcde asc , cis_untcde asc, cis_conftr desc                                                 
---------------------------------------------------------- 
end

--drop table #temp_immrkup
end







GO
GRANT EXECUTE ON [dbo].[sp_select_CUITMSUM_SCV2] TO [ERPUSER] AS [dbo]
GO
