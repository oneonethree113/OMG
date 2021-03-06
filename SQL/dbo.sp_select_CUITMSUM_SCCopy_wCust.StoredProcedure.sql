/****** Object:  StoredProcedure [dbo].[sp_select_CUITMSUM_SCCopy_wCust]    Script Date: 09/29/2017 15:29:09 ******/
DROP PROCEDURE [dbo].[sp_select_CUITMSUM_SCCopy_wCust]
GO
/****** Object:  StoredProcedure [dbo].[sp_select_CUITMSUM_SCCopy_wCust]    Script Date: 09/29/2017 15:29:10 ******/
SET ANSI_NULLS OFF
GO
SET QUOTED_IDENTIFIER OFF
GO








-- It is based on sp_select_CUITMSUM_SCCopy
/********************************************************************************************************************
Modification History
********************************************************************************************************************
Modify on		Modify by		Description
********************************************************************************************************************
2008-11-24		Mark Lau		For getting price with customer 
********************************************************************************************************************/

CREATE procedure [dbo].[sp_select_CUITMSUM_SCCopy_wCust]
                                                                                                                                                                                                                                                                 
---------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------- 
@cis_cocde nvarchar(6) ,
@cis_itmno nvarchar(20),
@cis_seccus nvarchar(6),
@cis_cusno nvarchar(6),
@cis_untcde nvarchar(8),
@cis_colcde nvarchar(30),
@cis_inrqty int,
@cis_mtrqty int,
@cis_conftr numeric(9)

---------------------------------------------- 
 
AS
declare @temp char(1)
declare @alsitmno char(1)
declare @ventyp char(1)


If @cis_cocde = 'UCPP' 
	begin


		select @ventyp   = vbi_ventyp from imbasinf bas
			left join vnbasinf on bas.ibi_venno = vbi_venno
		where bas.ibi_itmno = @cis_itmno 

		-- Chkecing Item type belon to internal or external

		if @ventyp   = 'E' 
		    SET @temp = 'D'
		else
		    SET @temp = 'P'		


		Select
			cis_cocde,
			cis_cusno,
			cis_seccus,
			cis_itmno,
			cis_itmdsc,
			cis_cusitm,
			cis_colcde,
			cis_coldsc,
			cis_cuscol,
			cis_untcde,
			cis_refdoc,
			cis_docdat,
			cis_cussku,
			cis_curcde,
			cis_ordqty,
			cis_selprc,	
			ISNULL(Case bas.ibi_itmsts when 'CMP' then 'CMP - Active Item with complete Info.'
					when 'INC' then 'INC - Active Item with incomplete Info.'
					when 'HLD' then 'HLD - Active Item Hold by the system'
					when 'DIS' then 'DIS - Discontinue Item'
					when 'INA' then 'INA - Inactive Item'
					when 'CLO' then 'CLO - Closed (UCP Item)'
					when 'TBC' then 'TBC - To be confirmed Item'	
					--Lester Wu 2006-09-17
					when 'OLD' then 'OLD - Old Item'	
					end,'N/A') as 'ibi_itmsts',
			Isnull(bas.ibi_typ,'N/A') as 'ibi_typ',
			Isnull(bas.ibi_curcde,'N/A') as 'ibi_curcde',
			isnull(imp_curcde,'USD')as 'imu_curcde',
			isnull(imd_prctrm,'') as 'imu_prctrm',
			imu_relatn,
			isnull(imd_fmlopt,'') as 'imu_fmlopt',
			isnull(imd_bcurcde,'N/A') as 'imu_bcurcde',
			isnull(imd_basprc,0) as 'imu_basprc',
			--isnull(imd_icttl,0) as 'imu_ftycst',
			case imp_negprc when 0 then
				isnull(imp_calftyprc,0) 
			else
				isnull(imp_negprc,0)
			end as 'imu_ftycst',
			--isnull(imd_icttl,0) as 'imu_ftyprc' ,
			case imp_negprc when 0 then
				isnull(imp_calftyprc,0) 
			else
				isnull(imp_negprc,0)
			end + isnull(imp_ftybomcst,0) as 'imu_ftyprc',
			isnull(imp_ftybomcst,0) as 'imu_bomcst' ,
			case imp_negprc when 0 then
				isnull(imp_calftyprc,0) 
			else
				isnull(imp_negprc,0)
			end + isnull(imp_ftybomcst,0) as 'imu_calftyprc',
			cast(cis_timstp as int ) as 'cis_timstp',
			isnull(bas.ibi_tirtyp,'0') as 'ibi_tirtyp',
			isnull(bas.ibi_moqctn,'0') as 'ibi_moq',
			isnull(bas.ibi_moa,'0') as 'ibi_moa',
			isnull(ivi_venno,'N/A') as 'ivi_venno',
			isnull(ivi_venno,'N/A') + ' - ' + isnull(vbi_vensna ,'') as 'ivi_vensna',
			isnull(ivi_subcde,'') as 'ivi_subcde',
			isnull(ivi_venitm,'') as 'ivi_venitm',
			isnull(vbi_vensts,'N/A') as 'vbi_vensts',
			yco_moq,
			yco_moa,
			yco_curcde,
			isnull(icf_colcde,'@#') as 'icf_colcde',
			imu_cft,
			vbi_ventyp,
			--Added by Mark Lau 20070623
			cis_conftr, cis_contopc, cis_pcprc
		-- Added by Mark Lau 20081107
			,isnull(cis_cusstyno,'') as 'cis_cusstyno',''  as 'imu_std'
		--Frankie Cheung 20110228
			,ltrim(rtrim(str(year(cis_qutdat)))) + '-' + right('00' + ltrim(rtrim(str(month(cis_qutdat)))),2) as 'cis_qutdat'
		From 
			CUITMSUM 
--			left join imbasinf  on bas.ibi_cocde = @cis_cocde and bas.ibi_itmno = @cis_itmno 
--			left join IMVENINF on ivi_cocde = @cis_cocde and ivi_itmno = @cis_itmno and ivi_def = 'Y'
--			left join VNBASINF on vbi_cocde = @cis_cocde and vbi_venno = ivi_venno
--			left join IMMRKUP on imu_cocde =@cis_cocde and 
			left join imbasinf bas  on (bas.ibi_itmno = @cis_itmno  or bas.ibi_alsitmno = @cis_itmno  )
			left join imbasinf old on bas.ibi_alsitmno = old.ibi_itmno						-- Lester Wu 2006-09-25
			left join IMVENINF on ivi_itmno = bas.ibi_itmno and ivi_def = 'Y'
			left join VNBASINF on vbi_venno = ivi_venno
			left join IMMRKUP on 
					--imu_cocde =@cis_cocde and 
					imu_itmno =  bas.ibi_itmno and  
			-- Allan Yuen Fix Error at 02/22/2003
			--		imu_venno   = ivi_venno and 
					imu_prdven = ivi_venno and 
			---------------------------------------------
					imu_ventyp = @temp and 
					imu_pckunt =@cis_untcde and
					imu_inrqty = @cis_inrqty and
					imu_mtrqty=@cis_mtrqty and 
					--Added by Mark Lau 20070623
					imu_conftr = @cis_conftr

			left join IMMRKUPDTL on 
					imu_itmno =  imd_itmno and  
					--imu_prdven = imd_prdven and 
					--imu_ventyp = imd_ventyp and 
					imu_pckunt = imd_untcde and
					imu_inrqty = imd_inrqty and
					imu_mtrqty = imd_mtrqty and 
					imu_conftr = imd_conftr
			left join immrkupdtlpv on 
					imp_itmno = imd_itmno  and  
					--imu_prdven = imd_prdven and 
					imp_venno = imd_venno and
					--imu_ventyp = @temp and 
					imp_untcde =imd_untcde and
					imp_inrqty = imd_inrqty and
					imp_mtrqty=imd_mtrqty		and
					imp_conftr = imd_conftr	and
					imp_cus1no = imd_cus1no and
					imp_cus2no = imd_cus2no
			left join SYCOMINF on yco_cocde = @cis_cocde

--			left join IMCOLINF on icf_cocde = @cis_cocde and icf_itmno = @cis_itmno and icf_colcde = @cis_colcde
			left join IMCOLINF on icf_itmno = bas.ibi_itmno and icf_colcde = @cis_colcde
--			left join IMCOLINF on icf_itmno = bas.ibi_itmno and icf_vencol = @cis_colcde

		Where 
			--cis_cocde = @cis_cocde and
			cis_itmno = @cis_itmno   and 			
			cis_cusno in (select cbi_cusno from cubasinf where cbi_cusali = @cis_cusno or cbi_cusno = @cis_cusno) and 
			cis_seccus = @cis_seccus and
			cis_colcde = @cis_colcde and                             
			cis_inrqty = @cis_inrqty and
			cis_mtrqty = @cis_mtrqty and
			cis_untcde = @cis_untcde and
			--Added by Mark Lau 20070623
			cis_conftr = @cis_conftr and
			left(bas.ibi_itmsts,3) <>  'CLO' and
			(bas.ibi_alsitmno <> @cis_itmno or (bas.ibi_alsitmno = @cis_itmno  and isnull(old.ibi_itmsts,'') <> 'OLD' )) -- Lester Wu 2006-09-25
			and isnull(imd_cus1no,'') = @cis_cusno and isnull(imd_cus2no,'') = @cis_seccus and imu_prdven = imp_prdven
		------------------------------------------------------ 
	end
else

	begin
		-----
		set @alsitmno = 0
		select @alsitmno  = count(1) from imbasinf bas where bas.ibi_alsitmno = @cis_itmno 
		-----
		if @alsitmno = 0 
		begin
			SET @temp = 'D'
			Select
				distinct 
				cis_cocde,
				cis_cusno,
				cis_seccus,
				cis_itmno,
				cis_itmdsc,
				cis_cusitm,
				cis_colcde,
				cis_coldsc,
				cis_cuscol,
				cis_untcde,
				cis_refdoc,
				cis_docdat,
				cis_cussku,
				cis_curcde,
				cis_ordqty,
				cis_selprc,	
				ISNULL(Case bas.ibi_itmsts when 'CMP' then 'CMP - Active Item with complete Info.'
						when 'INC' then 'INC - Active Item with incomplete Info.'
						when 'HLD' then 'HLD - Active Item Hold by the system'
						when 'DIS' then 'DIS - Discontinue Item'
						when 'INA' then 'INA - Inactive Item'
						when 'CLO' then 'CLO - Closed (UCP Item)'
						when 'TBC' then 'TBC - To be confirmed Item'	
						--Lester Wu 2006-09-17
						when 'OLD' then 'OLD - Old Item'	
						end,'N/A') as 'ibi_itmsts',
				Isnull(bas.ibi_typ,'N/A') as 'ibi_typ',
				Isnull(bas.ibi_curcde,'N/A') as 'ibi_curcde',
				isnull(imp_curcde,'USD')as 'imu_curcde',
				isnull(imd_prctrm,'') as 'imu_prctrm',
				imu_relatn,
				isnull(imd_fmlopt,'') as 'imu_fmlopt',
				isnull(imd_bcurcde,'N/A') as 'imu_bcurcde',
				isnull(imd_basprc,0) as 'imu_basprc',
			--isnull(imd_icttl,0) as 'imu_ftycst',
			case imp_negprc when 0 then
				isnull(imp_calftyprc,0) 
			else
				isnull(imp_negprc,0)
			end as 'imu_ftycst',
			--isnull(imd_icttl,0) as 'imu_ftyprc' ,
			case imp_negprc when 0 then
				isnull(imp_calftyprc,0) 
			else
				isnull(imp_negprc,0)
			end + isnull(imp_ftybomcst,0) as 'imu_ftyprc',
			isnull(imp_ftybomcst,0) as 'imu_bomcst' ,
			case imp_negprc when 0 then
				isnull(imp_calftyprc,0) 
			else
				isnull(imp_negprc,0)
			end + isnull(imp_ftybomcst,0) as 'imu_calftyprc',
				cast(cis_timstp as int ) as 'cis_timstp',
				isnull(bas.ibi_tirtyp,'0') as 'ibi_tirtyp',
				isnull(bas.ibi_moqctn,'0') as 'ibi_moq',
				isnull(bas.ibi_moa,'0') as 'ibi_moa',
				isnull(ivi_venno,'N/A') as 'ivi_venno',
				isnull(ivi_venno,'N/A') + ' - ' + isnull(vbi_vensna ,'') as 'ivi_vensna',
				isnull(ivi_subcde,'') as 'ivi_subcde',
				isnull(ivi_venitm,'') as 'ivi_venitm',
				isnull(vbi_vensts,'N/A') as 'vbi_vensts',
				yco_moq,
				yco_moa,
				yco_curcde,
				isnull(icf_colcde,'@#') as 'icf_colcde',
				imu_cft , 		
			--Added by Mark Lau 20070623
			cis_conftr, cis_contopc	, cis_pcprc
		-- Added by Mark Lau 20081107
			,isnull(cis_cusstyno,'') as 'cis_cusstyno',''  as 'imu_std'
		--Frankie Cheung 20110228
			,ltrim(rtrim(str(year(cis_qutdat)))) + '-' + right('00' + ltrim(rtrim(str(month(cis_qutdat)))),2) as 'cis_qutdat'
			From 
				CUITMSUM 
	
	--			left join imbasinf  on bas.ibi_cocde = @cis_cocde and bas.ibi_itmno = @cis_itmno 
	--			left join IMVENINF on ivi_cocde = @cis_cocde and ivi_itmno = @cis_itmno and ivi_def = 'Y'
	--			left join VNBASINF on vbi_cocde = @cis_cocde and vbi_venno = ivi_venno
	--			left join IMMRKUP on imu_cocde =@cis_cocde and 
				left join imbasinf  bas on bas.ibi_itmno = @cis_itmno
				left join IMVENINF on ivi_itmno = @cis_itmno and ivi_def = 'Y'
				left join VNBASINF on vbi_venno = ivi_venno
				left join IMMRKUP on 
						--imu_cocde =@cis_cocde and 
						imu_itmno = @cis_itmno  and  
				-- Allan Yuen Fix Error at 02/22/2003
						imu_venno   = ivi_venno and 
				--		imu_prdven = ivi_venno and 
				---------------------------------------------
						imu_ventyp = @temp and 
						imu_pckunt =@cis_untcde and
						imu_inrqty = @cis_inrqty and
						imu_mtrqty=@cis_mtrqty and 
						--Added by Mark Lau 20070623
						imu_conftr = @cis_conftr

			left join IMMRKUPDTL on 
					imu_itmno =  imd_itmno and  
					--imu_prdven = imd_prdven and 
					--imu_ventyp = imd_ventyp and 
					imu_pckunt = imd_untcde and
					imu_inrqty = imd_inrqty and
					imu_mtrqty = imd_mtrqty and 
					imu_conftr = imd_conftr
			left join immrkupdtlpv on 
					imp_itmno = imd_itmno  and  
					--imu_prdven = imd_prdven and 
					imp_venno = imd_venno and
					--imu_ventyp = @temp and 
					imp_untcde =imd_untcde and
					imp_inrqty = imd_inrqty and
					imp_mtrqty=imd_mtrqty		and
					imp_conftr = imd_conftr	and
					imp_cus1no = imd_cus1no and
					imp_cus2no = imd_cus2no
				left join SYCOMINF on yco_cocde = @cis_cocde
	
	--			left join IMCOLINF on icf_cocde = @cis_cocde and icf_itmno = @cis_itmno and icf_colcde = @cis_colcde
				left join IMCOLINF on icf_itmno = @cis_itmno and icf_colcde = @cis_colcde
--				left join IMCOLINF on icf_itmno = @cis_itmno and icf_vencol = @cis_colcde

			Where
				--cis_cocde = @cis_cocde and
				cis_itmno = @cis_itmno and 
				cis_cusno in (select cbi_cusno from cubasinf where cbi_cusali = @cis_cusno or cbi_cusno = @cis_cusno) and
				cis_seccus = @cis_seccus and
				cis_colcde = @cis_colcde and                             
				cis_inrqty = @cis_inrqty and
				cis_mtrqty = @cis_mtrqty and
				cis_untcde = @cis_untcde and
				--Added by Mark Lau 20070623
				cis_conftr = @cis_conftr
			and isnull(imd_cus1no,'') = @cis_cusno and isnull(imd_cus2no,'') = @cis_seccus and imu_prdven = imp_prdven
			------------------------------------------------------ 
			union
	
--			SET @temp = 'P'
			Select
				distinct 
				cis_cocde,
				cis_cusno,
				cis_seccus,
				cis_itmno,
				cis_itmdsc,
				cis_cusitm,
				cis_colcde,
				cis_coldsc,
				cis_cuscol,
				cis_untcde,
				cis_refdoc,
				cis_docdat,
				cis_cussku,
				cis_curcde,
				cis_ordqty,
				cis_selprc,	
				ISNULL(Case bas.ibi_itmsts when 'CMP' then 'CMP - Active Item with complete Info.'
						when 'INC' then 'INC - Active Item with incomplete Info.'
						when 'HLD' then 'HLD - Active Item Hold by the system'
						when 'DIS' then 'DIS - Discontinue Item'
						when 'INA' then 'INA - Inactive Item'
						when 'CLO' then 'CLO - Closed (UCP Item)'
						when 'TBC' then 'TBC - To be confirmed Item'
						--Lester Wu 2006-09-17
						when 'OLD' then 'OLD - Old Item'	
						end,'N/A') as 'ibi_itmsts',
				Isnull(bas.ibi_typ,'N/A') as 'ibi_typ',
				Isnull(bas.ibi_curcde,'N/A') as 'ibi_curcde',
				isnull(imp_curcde,'USD')as 'imu_curcde',
				isnull(imd_prctrm,'') as 'imu_prctrm',
				imu_relatn,
				isnull(imd_fmlopt,'') as 'imu_fmlopt',


				isnull(imd_bcurcde,'N/A') as 'imu_bcurcde',
				isnull(imd_basprc,0) as 'imu_basprc',
			--isnull(imd_icttl,0) as 'imu_ftycst',
			case imp_negprc when 0 then
				isnull(imp_calftyprc,0) 
			else
				isnull(imp_negprc,0)
			end as 'imu_ftycst',
			--isnull(imd_icttl,0) as 'imu_ftyprc' ,
			case imp_negprc when 0 then
				isnull(imp_calftyprc,0) 
			else
				isnull(imp_negprc,0)
			end + isnull(imp_ftybomcst,0) as 'imu_ftyprc',
			isnull(imp_ftybomcst,0) as 'imu_bomcst' ,
			case imp_negprc when 0 then
				isnull(imp_calftyprc,0) 
			else
				isnull(imp_negprc,0)
			end + isnull(imp_ftybomcst,0) as 'imu_calftyprc',
				cast(cis_timstp as int ) as 'cis_timstp',

				isnull(bas.ibi_tirtyp,'0') as 'ibi_tirtyp',
				isnull(bas.ibi_moqctn,'0') as 'ibi_moq',
				isnull(bas.ibi_moa,'0') as 'ibi_moa',
				isnull(ivi_venno,'N/A') as 'ivi_venno',
				isnull(ivi_venno,'N/A') + ' - ' + isnull(vbi_vensna ,'') as 'ivi_vensna',
				isnull(ivi_subcde,'') as 'ivi_subcde',
				isnull(ivi_venitm,'') as 'ivi_venitm',
				isnull(vbi_vensts,'N/A') as 'vbi_vensts',
				yco_moq,
				yco_moa,
				yco_curcde,
				isnull(icf_colcde,'@#') as 'icf_colcde',
				imu_cft , 		
			--Added by Mark Lau 20070623
			cis_conftr, cis_contopc	, cis_pcprc
		-- Added by Mark Lau 20081107
			,isnull(cis_cusstyno,'') as 'cis_cusstyno',''  as 'imu_std'
		--Frankie Cheung 20110228
			,ltrim(rtrim(str(year(cis_qutdat)))) + '-' + right('00' + ltrim(rtrim(str(month(cis_qutdat)))),2) as 'cis_qutdat'
			From 
				CUITMSUM 
	
	--			left join imbasinf  on bas.ibi_cocde = @cis_cocde and bas.ibi_itmno = @cis_itmno 
	--			left join IMVENINF on ivi_cocde = @cis_cocde and ivi_itmno = @cis_itmno and ivi_def = 'Y'
	--			left join VNBASINF on vbi_cocde = @cis_cocde and vbi_venno = ivi_venno
	--			left join IMMRKUP on imu_cocde =@cis_cocde and 
				left join imbasinf  bas on bas.ibi_itmno = @cis_itmno 
				left join IMVENINF on ivi_itmno = @cis_itmno and ivi_def = 'Y'
				left join VNBASINF on vbi_venno = ivi_venno
				left join IMMRKUP on 
						--imu_cocde =@cis_cocde and 
						imu_itmno = @cis_itmno  and  
				-- Allan Yuen Fix Error at 02/22/2003
				--		imu_venno   = ivi_venno and 
						imu_prdven = ivi_venno and 
				---------------------------------------------
						imu_ventyp = 'P' and 
						imu_pckunt =@cis_untcde and
						imu_inrqty = @cis_inrqty and
						imu_mtrqty=@cis_mtrqty and 
						--Added by Mark Lau 20070623
						imu_conftr = @cis_conftr

			left join IMMRKUPDTL on 
					imu_itmno =  imd_itmno and  
					--imu_prdven = imd_prdven and 
					--imu_ventyp = imd_ventyp and 
					imu_pckunt = imd_untcde and
					imu_inrqty = imd_inrqty and
					imu_mtrqty = imd_mtrqty and 
					imu_conftr = imd_conftr
			left join immrkupdtlpv on 
					imp_itmno = imd_itmno  and  
					--imu_prdven = imd_prdven and 
					imp_venno = imd_venno and
					--imu_ventyp = @temp and 
					imp_untcde =imd_untcde and
					imp_inrqty = imd_inrqty and
					imp_mtrqty=imd_mtrqty		and
					imp_conftr = imd_conftr	and
					imp_cus1no = imd_cus1no and
					imp_cus2no = imd_cus2no
				left join SYCOMINF on yco_cocde = @cis_cocde
	
	--			left join IMCOLINF on icf_cocde = @cis_cocde and icf_itmno = @cis_itmno and icf_colcde = @cis_colcde
--				left join IMCOLINF on icf_itmno = @cis_itmno and icf_colcde = @cis_colcde
				left join IMCOLINF on icf_itmno = @cis_itmno and icf_vencol = @cis_colcde
	
			Where 
				--cis_cocde = @cis_cocde and
				cis_itmno = @cis_itmno and 			
				cis_cusno in (select cbi_cusno from cubasinf where cbi_cusali = @cis_cusno or cbi_cusno = @cis_cusno) and 
				cis_seccus = @cis_seccus and
				cis_colcde = @cis_colcde and                             
				cis_inrqty = @cis_inrqty and
				cis_mtrqty = @cis_mtrqty and
				cis_untcde = @cis_untcde and
				--Added by Mark Lau 20070623
				cis_conftr = @cis_conftr and
				imu_prctrm is not null
			and isnull(imd_cus1no,'') = @cis_cusno and isnull(imd_cus2no,'') = @cis_seccus and imu_prdven = imp_prdven
			------------------------------------------------------ 


		end
		else
		begin
			SET @temp = 'p'
			------------------------------------------------------
			Select
				cis_cocde,
				cis_cusno,
				cis_seccus,
				cis_itmno,
				cis_itmdsc,
				cis_cusitm,
				cis_colcde,
				cis_coldsc,
				cis_cuscol,
				cis_untcde,
				cis_refdoc,
				cis_docdat,
				cis_cussku,
				cis_curcde,
				cis_ordqty,
				cis_selprc,	
				ISNULL(Case bas.ibi_itmsts when 'CMP' then 'CMP - Active Item with complete Info.'
						when 'INC' then 'INC - Active Item with incomplete Info.'
						when 'HLD' then 'HLD - Active Item Hold by the system'
						when 'DIS' then 'DIS - Discontinue Item'
						when 'INA' then 'INA - Inactive Item'
						when 'CLO' then 'CLO - Closed (UCP Item)'
						when 'TBC' then 'TBC - To be confirmed Item'
						--Lester Wu 2006-09-17
						when 'OLD' then 'OLD - Old Item'	
						end,'N/A') as 'ibi_itmsts',
				Isnull(bas.ibi_typ,'N/A') as 'ibi_typ',
				Isnull(bas.ibi_curcde,'N/A') as 'ibi_curcde',
				isnull(imp_curcde,'USD')as 'imu_curcde',
				isnull(imd_prctrm,'') as 'imu_prctrm',
				imu_relatn,
				isnull(imd_fmlopt,'') as 'imu_fmlopt',
				isnull(imd_bcurcde,'N/A') as 'imu_bcurcde',
				isnull(imd_basprc,0) as 'imu_basprc',
			--isnull(imd_icttl,0) as 'imu_ftycst',
			case imp_negprc when 0 then
				isnull(imp_calftyprc,0) 
			else
				isnull(imp_negprc,0)
			end as 'imu_ftycst',
			--isnull(imd_icttl,0) as 'imu_ftyprc' ,
			case imp_negprc when 0 then
				isnull(imp_calftyprc,0) 
			else
				isnull(imp_negprc,0)
			end + isnull(imp_ftybomcst,0) as 'imu_ftyprc',
			isnull(imp_ftybomcst,0) as 'imu_bomcst' ,
			case imp_negprc when 0 then
				isnull(imp_calftyprc,0) 
			else
				isnull(imp_negprc,0)
			end + isnull(imp_ftybomcst,0) as 'imu_calftyprc',
				cast(cis_timstp as int ) as 'cis_timstp',
				isnull(bas.ibi_tirtyp,'0') as 'ibi_tirtyp',
				isnull(bas.ibi_moqctn,'0') as 'ibi_moq',
				isnull(bas.ibi_moa,'0') as 'ibi_moa',
				isnull(ivi_venno,'N/A') as 'ivi_venno',
				isnull(ivi_venno,'N/A') + ' - ' + isnull(vbi_vensna ,'') as 'ivi_vensna',
				isnull(ivi_subcde,'') as 'ivi_subcde',
				isnull(ivi_venitm,'') as 'ivi_venitm',
				isnull(vbi_vensts,'N/A') as 'vbi_vensts',
				yco_moq,
				yco_moa,
				yco_curcde,
				isnull(icf_colcde,'@#') as 'icf_colcde',
				imu_cft , 			
			--Added by Mark Lau 20070623
			cis_conftr, cis_contopc, cis_pcprc
		-- Added by Mark Lau 20081107
			,isnull(cis_cusstyno,'') as 'cis_cusstyno',''  as 'imu_std'
			From 
				CUITMSUM 
	
	--			left join imbasinf  on bas.ibi_cocde = @cis_cocde and bas.ibi_itmno = @cis_itmno 
	--			left join IMVENINF on ivi_cocde = @cis_cocde and ivi_itmno = @cis_itmno and ivi_def = 'Y'
	--			left join VNBASINF on vbi_cocde = @cis_cocde and vbi_venno = ivi_venno
	--			left join IMMRKUP on imu_cocde =@cis_cocde and 
				left join imbasinf bas on bas.ibi_alsitmno = @cis_itmno 
				left join imbasinf old on bas.ibi_alsitmno = old.ibi_itmno 		-- Lester Wu 2006-09-25
				left join IMVENINF on ivi_itmno = bas.ibi_itmno  and ivi_def = 'Y'
				left join VNBASINF on vbi_venno = ivi_venno
				left join IMMRKUP on 
						--imu_cocde =@cis_cocde and 
						imu_itmno =  bas.ibi_itmno and  
				-- Allan Yuen Fix Error at 02/22/2003
						imu_venno   = ivi_venno and 
				--		imu_prdven = ivi_venno and 
				---------------------------------------------
						imu_ventyp = @temp and 
						imu_pckunt =@cis_untcde and
						imu_inrqty = @cis_inrqty and
						imu_mtrqty=@cis_mtrqty and 
						--Added by Mark Lau 20070623
						imu_conftr = @cis_conftr

			left join IMMRKUPDTL on 
					imu_itmno =  imd_itmno and  
					--imu_prdven = imd_prdven and 
					--imu_ventyp = imd_ventyp and 
					imu_pckunt = imd_untcde and
					imu_inrqty = imd_inrqty and
					imu_mtrqty = imd_mtrqty and 
					imu_conftr = imd_conftr
			left join immrkupdtlpv on 
					imp_itmno = imd_itmno  and  
					--imu_prdven = imd_prdven and 
					imp_venno = imd_venno and
					--imu_ventyp = @temp and 
					imp_untcde =imd_untcde and
					imp_inrqty = imd_inrqty and
					imp_mtrqty=imd_mtrqty		and
					imp_conftr = imd_conftr	and
					imp_cus1no = imd_cus1no and
					imp_cus2no = imd_cus2no
				left join SYCOMINF on yco_cocde = @cis_cocde
	
	--			left join IMCOLINF on icf_cocde = @cis_cocde and icf_itmno = @cis_itmno and icf_colcde = @cis_colcde
--				left join IMCOLINF on icf_itmno = @cis_itmno and icf_colcde = @cis_colcde
				left join IMCOLINF on icf_itmno = @cis_itmno and icf_vencol = @cis_colcde
			Where 
				--cis_cocde = @cis_cocde and
				cis_itmno = @cis_itmno and 
				cis_cusno in (select cbi_cusno from cubasinf where cbi_cusali = @cis_cusno or cbi_cusno = @cis_cusno) and
				cis_seccus = @cis_seccus and
				cis_colcde = @cis_colcde and                             
				cis_inrqty = @cis_inrqty and
				cis_mtrqty = @cis_mtrqty and
				cis_untcde = @cis_untcde and
				--Added by Mark Lau 20070623
				cis_conftr = @cis_conftr and
				isnull(old.ibi_itmsts,'') <> 'OLD'
			and isnull(imd_cus1no,'') = @cis_cusno and isnull(imd_cus2no,'') = @cis_seccus and imu_prdven = imp_prdven
		end
	end



GO
GRANT EXECUTE ON [dbo].[sp_select_CUITMSUM_SCCopy_wCust] TO [ERPUSER] AS [dbo]
GO
