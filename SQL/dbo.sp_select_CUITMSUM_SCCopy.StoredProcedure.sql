/****** Object:  StoredProcedure [dbo].[sp_select_CUITMSUM_SCCopy]    Script Date: 09/29/2017 15:29:09 ******/
DROP PROCEDURE [dbo].[sp_select_CUITMSUM_SCCopy]
GO
/****** Object:  StoredProcedure [dbo].[sp_select_CUITMSUM_SCCopy]    Script Date: 09/29/2017 15:29:10 ******/
SET ANSI_NULLS OFF
GO
SET QUOTED_IDENTIFIER OFF
GO










-- Checked by Allan Yuen at 28/07/2003


/*
=========================================================
Program ID	: sp_select_CUITMSUM_SCCopy
Description   	: Select data From CUITMSUM
Programmer  	: Kenny Chan
Create Date   	: 03rd Jan, 2002
Last Modified  	: 
Table Read(s) 	:
Table Write(s) 	:
Parameter	: 1. Company
		  2. Item no
=========================================================
 Modification History                                    
=========================================================
 Date      Initial  	Description                          
=========================================================    
22/02/2003 Allan Yuen   	Bug Fixing the Copy Function.
15/09/2004 Allan Yuen	Add BOM Cost Column
10/03/2005 Allan Yuen 	Add Vendor Type
*/

------------------------------------------------- 

-- sp_select_CUITMSUM_SCCopy 'UCPP','03A
--sp_select_CUITMSUM_SCCopy 'UCPP','03A469-041826','','50001','DZ','Y-2361',1,48

CREATE procedure [dbo].[sp_select_CUITMSUM_SCCopy]
                                                                                                                                                                                                                                                                 
---------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------- 
@cis_cocde nvarchar(6) ,
@cis_itmno nvarchar(20),
@cis_seccus nvarchar(6),
@cis_cusno nvarchar(6),
@cis_untcde nvarchar(8),
@cis_colcde nvarchar(30),
@cis_inrqty int,
@cis_mtrqty int,
--Added by Mark Lau 20070623
@cis_conftr numeric(9)

---------------------------------------------- 
 
AS
declare @temp char(1)
declare @alsitmno char(1)
declare @ventyp char(1)


select imu_itmno as 'itmno' , imu_pckunt as 'untcde' , imu_inrqty as 'inrqty' ,imu_mtrqty as 'mtrqty' ,imu_conftr as 'conftr',
imu_ventyp as 'ventyp' ,imu_venno as 'venno' ,imu_prdven as 'prdven' , isnull( imu_std,'') as 'std' into #temp_immrkup
 from immrkup (nolock)
where
imu_itmno = @cis_itmno	and
imu_pckunt = @cis_untcde and
imu_inrqty = @cis_inrqty	and 	
imu_mtrqty = @cis_mtrqty 	and
imu_conftr = @cis_conftr and
imu_ventyp = 'D'

/*
If @cis_cocde = 'UCPP' 
	begin
*/

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
			isnull(imu_curcde,'USD')as 'imu_curcde',
			imu_prctrm,
			imu_relatn,
			imu_fmlopt,
			isnull(imu_bcurcde,'N/A') as 'imu_bcurcde',
			isnull(imu_basprc,0) as 'imu_basprc',
			isnull(imu_ftycst,0) as 'imu_ftycst',
			isnull(imu_ftyprc,0) as 'imu_ftyprc' ,
			isnull(imu_bomcst,0) as 'imu_bomcst' ,
			case imu_negprc when 0 then
				isnull(imu_calftyprc,0) 
			else
				isnull(imu_negprc,0)
			end as 'imu_calftyprc',

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
			,isnull(cis_cusstyno,'') as 'cis_cusstyno',isnull(std.std,'')  as 'imu_std'
		--Frankie Cheung 20110228
			--,case ltrim(rtrim(str(year(cis_qutdat)))) when '1900' then '' else ltrim(rtrim(str(year(cis_qutdat)))) + '-' + right('00' + ltrim(rtrim(str(month(cis_qutdat)))),2) end as 'cis_qutdat'
			, str(year(cis_qutdat),4) + '-' + right('00' + ltrim(rtrim(str(month(cis_qutdat)))),2) as 'cis_qutdat'

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
			left join SYCOMINF on yco_cocde = @cis_cocde

--			left join IMCOLINF on icf_cocde = @cis_cocde and icf_itmno = @cis_itmno and icf_colcde = @cis_colcde
			left join IMCOLINF on icf_itmno = bas.ibi_itmno and icf_colcde = @cis_colcde
--			left join IMCOLINF on icf_itmno = bas.ibi_itmno and icf_vencol = @cis_colcde
		left join #temp_immrkup std on
			imu_itmno = std.itmno	and
			imu_pckunt = std.untcde	and
			imu_inrqty = std.inrqty	and
			imu_mtrqty = std.mtrqty 	and
			imu_conftr = std.conftr 		
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
			-- Added by Mark Lau 20081124
			--and isnull(imu_std,'') <> 'N'
		------------------------------------------------------ 
/*	end
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
				isnull(imu_curcde,'USD')as 'imu_curcde',
				imu_prctrm,
				imu_relatn,
				imu_fmlopt,
				isnull(imu_bcurcde,'N/A') as 'imu_bcurcde',
				isnull(imu_basprc,0) as 'imu_basprc',
				isnull(imu_ftycst,0) as 'imu_ftycst',
				isnull(imu_ftyprc,0) as 'imu_ftyprc' ,
				isnull(imu_bomcst,0) as 'imu_bomcst' ,
				case imu_negprc when 0 then
					isnull(imu_calftyprc,0) 
				else
					isnull(imu_negprc,0)
				end as 'imu_calftyprc',
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
			,isnull(cis_cusstyno,'') as 'cis_cusstyno',isnull(std.std,'')  as 'imu_std'
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
				left join SYCOMINF on yco_cocde = @cis_cocde
	
	--			left join IMCOLINF on icf_cocde = @cis_cocde and icf_itmno = @cis_itmno and icf_colcde = @cis_colcde
				left join IMCOLINF on icf_itmno = @cis_itmno and icf_colcde = @cis_colcde
--				left join IMCOLINF on icf_itmno = @cis_itmno and icf_vencol = @cis_colcde
		left join #temp_immrkup std on
			imu_itmno = std.itmno	and
			imu_pckunt = std.untcde	and
			imu_inrqty = std.inrqty	and
			imu_mtrqty = std.mtrqty 	and
			imu_conftr = std.conftr 	
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
			-- Added by Mark Lau 20081124
			--and isnull(imu_std,'') <> 'N'
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
				isnull(imu_curcde,'USD')as 'imu_curcde',
				imu_prctrm,
				imu_relatn,
				imu_fmlopt,
				isnull(imu_bcurcde,'N/A') as 'imu_bcurcde',
				isnull(imu_basprc,0) as 'imu_basprc',
				isnull(imu_ftycst,0) as 'imu_ftycst',
				isnull(imu_ftyprc,0) as 'imu_ftyprc' ,
				isnull(imu_bomcst,0) as 'imu_bomcst' ,
				case imu_negprc when 0 then
					isnull(imu_calftyprc,0) 
				else

					isnull(imu_negprc,0)
				end as 'imu_calftyprc',
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
			,isnull(cis_cusstyno,'') as 'cis_cusstyno',isnull(std.std,'')  as 'imu_std'
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
				left join SYCOMINF on yco_cocde = @cis_cocde
	
	--			left join IMCOLINF on icf_cocde = @cis_cocde and icf_itmno = @cis_itmno and icf_colcde = @cis_colcde
--				left join IMCOLINF on icf_itmno = @cis_itmno and icf_colcde = @cis_colcde
				left join IMCOLINF on icf_itmno = @cis_itmno and icf_vencol = @cis_colcde
			left join #temp_immrkup std on
			imu_itmno = std.itmno	and
			imu_pckunt = std.untcde	and
			imu_inrqty = std.inrqty	and
			imu_mtrqty = std.mtrqty 	and
			imu_conftr = std.conftr 	
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
			-- Added by Mark Lau 20081124
			--and isnull(imu_std,'') <> 'N'
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
				isnull(imu_curcde,'USD')as 'imu_curcde',
				imu_prctrm,
				imu_relatn,
				imu_fmlopt,
				isnull(imu_bcurcde,'N/A') as 'imu_bcurcde',
				isnull(imu_basprc,0) as 'imu_basprc',
				isnull(imu_ftycst,0) as 'imu_ftycst',
				isnull(imu_ftyprc,0) as 'imu_ftyprc' ,
				isnull(imu_bomcst,0) as 'imu_bomcst' ,
				case imu_negprc when 0 then
					isnull(imu_calftyprc,0) 
				else
					isnull(imu_negprc,0)
				end as 'imu_calftyprc',
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
			,isnull(cis_cusstyno,'') as 'cis_cusstyno',isnull(std.std,'')  as 'imu_std'
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
				left join SYCOMINF on yco_cocde = @cis_cocde
	
	--			left join IMCOLINF on icf_cocde = @cis_cocde and icf_itmno = @cis_itmno and icf_colcde = @cis_colcde
--				left join IMCOLINF on icf_itmno = @cis_itmno and icf_colcde = @cis_colcde
				left join IMCOLINF on icf_itmno = @cis_itmno and icf_vencol = @cis_colcde
		left join #temp_immrkup std on
			imu_itmno = std.itmno	and
			imu_pckunt = std.untcde	and
			imu_inrqty = std.inrqty	and
			imu_mtrqty = std.mtrqty 	and
			imu_conftr = std.conftr 	
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
			-- Added by Mark Lau 20081124
			--and isnull(imu_std,'') <> 'N'
		end
	end
*/
drop table #temp_immrkup

GO
GRANT EXECUTE ON [dbo].[sp_select_CUITMSUM_SCCopy] TO [ERPUSER] AS [dbo]
GO
