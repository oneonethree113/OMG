/****** Object:  StoredProcedure [dbo].[sp_select_CUITMSUM_SCV2_wCust]    Script Date: 09/29/2017 15:29:09 ******/
DROP PROCEDURE [dbo].[sp_select_CUITMSUM_SCV2_wCust]
GO
/****** Object:  StoredProcedure [dbo].[sp_select_CUITMSUM_SCV2_wCust]    Script Date: 09/29/2017 15:29:10 ******/
SET ANSI_NULLS OFF
GO
SET QUOTED_IDENTIFIER OFF
GO
















-- It is based on sp_select_CUITMSUM_SCV2
/********************************************************************************************************************
Modification History
********************************************************************************************************************
Modify on		Modify by		Description
********************************************************************************************************************
2008-11-24		Mark Lau		For getting price with customer 
********************************************************************************************************************/

CREATE procedure [dbo].[sp_select_CUITMSUM_SCV2_wCust]
                                                                                                                                                                                                                                                                 
---------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------- 
@cis_cocde nvarchar(6) ,
@cis_itmno nvarchar(20),
@cis_seccus nvarchar(6),
@cis_cusno nvarchar(6)

---------------------------------------------- 
 
AS
begin


---- Create Temp IM Table  ----
select 
	* 
into 
	#IMTemp
from 
	(SELECT 
		ibi_itmno, bas.ibi_alsitmno, bas.ibi_typ, bas.ibi_itmsts, bas.ibi_tirtyp, bas.ibi_venno, icf_colcde, icf_vencol, ipi_pckunt, ipi_inrqty, ipi_mtrqty,ipi_conftr, ipi_cft, ipi_cbm, isnull(imd_bcurcde,'') as 'imu_bcurcde',isnull(imd_basprc,0) as  'imu_basprc','N' as'ResultStatus' , isnull(bas.ibi_alscolcde,'') as 'ibi_alscolcde', bas.ibi_ftytmp, isnull(imd_cus1no,'')  as 'imd_cus1no' , isnull( imd_cus2no,'')  as 'imd_cus2no'
	
	from 
		imbasinf  bas
		left join imcolinf   on
			icf_itmno = bas.ibi_itmno 

		left join impckinf   on
			ipi_itmno = bas.ibi_itmno 
		
		left join imveninf on ivi_itmno = bas.ibi_itmno and ivi_def = 'Y'

		left join immrkup   on 
			imu_itmno = bas.ibi_itmno and
--			imu_prdven = bas.ibi_venno  and
			imu_prdven = ivi_venno and
			imu_pckunt = ipi_pckunt  and
			imu_inrqty = ipi_inrqty  and
			imu_mtrqty = ipi_mtrqty 
			--Added by Mark Lau 20070621
			and imu_conftr = ipi_conftr
			--and imu_ventyp = 'P'
		left join immrkupdtl   on 
			imu_itmno = imd_itmno and
--			imu_prdven = imd_prdven  and
			imd_prdven = ivi_venno and
			imu_pckunt = imd_untcde and
			imu_inrqty = imd_inrqty  and
			imu_mtrqty = imd_mtrqty 
			and imu_conftr = imd_conftr

	where
		bas.ibi_itmno = @cis_itmno and
		bas.ibi_itmsts <> 'CLO'
		and imd_cus1no = @cis_cusno and imd_cus2no = @cis_seccus

	union 
	SELECT 
		bas.ibi_itmno, bas.ibi_alsitmno, bas.ibi_typ, bas.ibi_itmsts, bas.ibi_tirtyp, bas.ibi_venno, icf_colcde, icf_vencol, ipi_pckunt, ipi_inrqty, ipi_mtrqty,ipi_conftr, ipi_cft, ipi_cbm, isnull(imd_bcurcde,'') as 'imu_bcurcde',isnull(imd_basprc,0) as  'imu_basprc','A' as'ResultStatus'  , isnull(bas.ibi_alscolcde,'') as 'ibi_alscolcde', bas.ibi_ftytmp, isnull(imd_cus1no,'')  as 'imd_cus1no' , isnull( imd_cus2no,'')  as 'imd_cus2no'
		
	from 
		imbasinf  bas
		left join imbasinf old on bas.ibi_alsitmno = old.ibi_itmno 
		left join imcolinf   on
			icf_itmno = bas.ibi_itmno 

		left join impckinf   on
			ipi_itmno = bas.ibi_itmno 

		left join imveninf on ivi_itmno = bas.ibi_itmno and ivi_def = 'Y'

		left join immrkup   on 
			imu_itmno = bas.ibi_itmno and
--			imu_prdven = bas.ibi_venno  and
			imu_prdven = ivi_venno and
			imu_pckunt = ipi_pckunt  and
			imu_inrqty = ipi_inrqty  and
			imu_mtrqty = ipi_mtrqty 
			--Added by Mark Lau 20070621
			and imu_conftr = ipi_conftr
			--and imu_ventyp = 'P'
		left join immrkupdtl   on 
			imu_itmno = imd_itmno and
--			imu_prdven = imd_prdven  and
			imd_prdven = ivi_venno and
			imu_pckunt = imd_untcde and
			imu_inrqty = imd_inrqty  and
			imu_mtrqty = imd_mtrqty 
			and imu_conftr = imd_conftr
	where
		bas.ibi_alsitmno = @cis_itmno and
		bas.ibi_itmsts <> 'CLO'  and
		isnull(old.ibi_itmsts,'') <> 'OLD'	-- Lester Wu 2006-09-25
		and imd_cus1no = @cis_cusno and imd_cus2no = @cis_seccus
		
	union
	SELECT 
		bas.ibi_itmno, bas.ibi_alsitmno, bas.ibi_typ, bas.ibi_itmsts, bas.ibi_tirtyp, bas.ibi_venno, icf_colcde, icf_vencol, ipi_pckunt, ipi_inrqty, ipi_mtrqty,ipi_conftr, ipi_cft, ipi_cbm,  isnull(imd_bcurcde,'') as 'imu_bcurcde',isnull(imd_basprc,0) as  'imu_basprc','H' as'ResultStatus'  , isnull(bas.ibi_alscolcde,'') as 'ibi_alscolcde', bas.ibi_ftytmp, isnull(imd_cus1no,'')  as 'imd_cus1no' , isnull( imd_cus2no,'')  as 'imd_cus2no'
	from 
		imbasinfh  bas
		left join imcolinfh   on
			icf_itmno = bas.ibi_itmno 

		left join impckinfh   on
			ipi_itmno = bas.ibi_itmno 

		left join imveninfh on ivi_itmno = bas.ibi_itmno and ivi_def = 'Y'

		left join immrkuph   on 
			imu_itmno = bas.ibi_itmno and
--			imu_prdven = bas.ibi_venno  and
			imu_prdven = ivi_venno and
			imu_pckunt = ipi_pckunt  and
			imu_inrqty = ipi_inrqty  and
			imu_mtrqty = ipi_mtrqty 
			--Added by Mark Lau 20070621
			and imu_conftr = ipi_conftr
			--and imu_ventyp = 'P'
		left join immrkupdtl   on 
			imu_itmno = imd_itmno and
--			imu_prdven = imd_prdven  and
			imd_prdven = ivi_venno and
			imu_pckunt = imd_untcde and
			imu_inrqty = imd_inrqty  and
			imu_mtrqty = imd_mtrqty 
			and imu_conftr = imd_conftr
	where
		bas.ibi_itmno = @cis_itmno and
		bas.ibi_itmsts <> 'CLO'
		and imd_cus1no = @cis_cusno and imd_cus2no = @cis_seccus
	union 
	SELECT 
		bas.ibi_itmno, bas.ibi_alsitmno, bas.ibi_typ, bas.ibi_itmsts, bas.ibi_tirtyp, bas.ibi_venno, icf_colcde, icf_vencol, ipi_pckunt, ipi_inrqty, ipi_mtrqty,ipi_conftr, ipi_cft, ipi_cbm, isnull(imd_bcurcde,'') as 'imu_bcurcde',isnull(imd_basprc,0) as  'imu_basprc','HA' as'ResultStatus'  ,  isnull(bas.ibi_alscolcde,'') as 'ibi_alscolcde', bas.ibi_ftytmp, isnull(imd_cus1no,'')  as 'imd_cus1no' , isnull( imd_cus2no,'')  as 'imd_cus2no'
	from 
		imbasinfh  bas
		left join imbasinfh old on bas.ibi_alsitmno = old.ibi_itmno
		left join imcolinfh   on
			icf_itmno = bas.ibi_itmno 

		left join impckinfh   on
			ipi_itmno = bas.ibi_itmno 

		left join imveninfh on ivi_itmno = bas.ibi_itmno and ivi_def = 'Y'

		left join immrkuph   on 
			imu_itmno = bas.ibi_itmno and
--			imu_prdven = bas.ibi_venno  and
			imu_prdven = ivi_venno and
			imu_pckunt = ipi_pckunt  and
			imu_inrqty = ipi_inrqty  and
			imu_mtrqty = ipi_mtrqty 
			--Added by Mark Lau 20070621
			and imu_conftr = ipi_conftr
			--and imu_ventyp = 'P'
		left join immrkupdtl   on 
			imu_itmno = imd_itmno and
--			imu_prdven = imd_prdven  and
			imd_prdven = ivi_venno and
			imu_pckunt = imd_untcde and
			imu_inrqty = imd_inrqty  and
			imu_mtrqty = imd_mtrqty 
			and imu_conftr = imd_conftr
	where
		bas.ibi_alsitmno = @cis_itmno and
		bas.ibi_itmsts <> 'CLO' and
		isnull(old.ibi_itmsts,'') <> 'OLD'
		and imd_cus1no = @cis_cusno and imd_cus2no = @cis_seccus
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
					when 'OLD' then 'OLD -Old Item'
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
					when 'OLD' then 'OLD -Old Item'
				end
			WHEN 'H' THEN 'N/A'
			WHEN 'HA' THEN 'N/A'		
			ELSE 'MISSING'
		end as 'ibi_itmsts',
		Isnull(ibi_typ,'N/A') as 'ibi_typ',
		isnull(imu_bcurcde,'N/A') as  'imu_bcurcde',
		isnull(imu_basprc,0) as 'imu_basprc',
		cis_qutdat,  		-- Frankie Cheung 20100413 Add Period
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
					when 'OLD' then 'OLD -Old Item'
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
					when 'OLD' then 'OLD -Old Item'
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
			,isnull(cis_cusstyno,'') as 'cis_cusstyno','' as 'imu_std'
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
	-- Added by Mark Lau 20081124
	and isnull(imd_cus1no,'') = @cis_cusno and isnull( imd_cus2no,'') = @cis_seccus
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
					when 'OLD' then 'OLD -Old Item'
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
					when 'OLD' then 'OLD -Old Item'
				end
			WHEN 'H' THEN 'N/A'
			WHEN 'HA' THEN 'N/A'		
			ELSE 'MISSING'
		end as 'ibi_itmsts',
		Isnull(ibi_typ,'N/A') as 'ibi_typ',
		isnull(imu_bcurcde,'N/A') as  'imu_bcurcde',
		isnull(imu_basprc,0) as 'imu_basprc',
		cis_qutdat,	-- Frankie Cheung 20100413 Add Period
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
					when 'OLD' then 'OLD -Old Item'
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
					when 'OLD' then 'OLD -Old Item'
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
			,isnull(cis_cusstyno,'') as 'cis_cusstyno','' as 'imu_std'
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
	-- Added by Mark Lau 20081124
	and isnull(imd_cus1no,'') = @cis_cusno and isnull( imd_cus2no,'') = @cis_seccus
	--Added by Mark Lau 20080311
	order by cis_colcde asc , cis_untcde asc, cis_conftr desc                                                 
---------------------------------------------------------- 
end
end






GO
GRANT EXECUTE ON [dbo].[sp_select_CUITMSUM_SCV2_wCust] TO [ERPUSER] AS [dbo]
GO
