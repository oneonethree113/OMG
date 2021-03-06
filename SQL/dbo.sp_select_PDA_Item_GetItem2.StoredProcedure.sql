/****** Object:  StoredProcedure [dbo].[sp_select_PDA_Item_GetItem2]    Script Date: 09/29/2017 15:29:09 ******/
DROP PROCEDURE [dbo].[sp_select_PDA_Item_GetItem2]
GO
/****** Object:  StoredProcedure [dbo].[sp_select_PDA_Item_GetItem2]    Script Date: 09/29/2017 15:29:10 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO





/*
=========================================================
Description   	: sp_select_PDA_Item_GetItem2
Programmer  	: Carlos Lui
ALTER  Date   	: 2012-06-26
Last Modified  	: 2012-06-26
Table Read(s) 	:
Table Write(s) 	:
=========================================================
 Modification History                                    
=========================================================
 Date      		Initial  		Description                          
=========================================================     

*/

CREATE  procedure [dbo].[sp_select_PDA_Item_GetItem2]
@itmno		nvarchar(20),
@isnewitmfmt	nvarchar(1)

as

set @isnewitmfmt = 'N'

Select 	isnull(	case when @isnewitmfmt = 'N' then
			case when ibi_itmno = @itmno then ''
			else
			case when ibi_alsitmno = @itmno then 'A'
			end
		end
	end ,'') as 'typ',
	ibi_credat,
	' ' as 'ibi_cocde',
	ibi_itmno,
	ivi_venitm,
	ibi_engdsc,
	ibi_venno,
	case rtrim(ltrim(ibi_imgpth))	when '' then 'N'
				else 'Y'
				end as 'ibi_img',
	isnull(pck.ipi_pckseq,1) as 'ipi_pckseq', 
	isnull(pck.ipi_inrqty,0) as 'ipi_inrqty', 
	isnull(pck.ipi_mtrqty,0) as 'ipi_mtrqty',
	isnull(pck.ipi_cft,0) as 'ipi_cft', 
	isnull(pck.ipi_pckunt,'N/A') as 'ipi_pckunt', 
	isnull(pck.ipi_conftr,1) as 'ipi_conftr',
	ibi_tirtyp, 
	isnull(yts_moq,0) as 'ibi_moqctn',
	isnull(yts_moa,0) as 'ibi_moa',
	isnull(imu_bcurcde,'') as'imu_bcurcde', 
	isnull(imu_basprc,0) as 'imu_basprc', 
	isnull(	case ycf_oper	when'*' then 'PC'
				when '/' then 'PC'
				else ipi_pckunt
		end,'N/A') as 'ipi_smpunt',
	isnull(ibi_alsitmno,' ') as  'ibi_alsitmno',			
	isnull(ibi_alscolcde,' ') as  'ibi_alscolcde',	
	vbi_ventyp,	
	ibi_catlvl3,
	col.icf_colcde as 'icf_colcde',
	ipi_qutdat,
	ibi_itmsts,
	imu_status,
	imu_cus1no,
	imu_cus2no,
	imu_hkprctrm,
	imu_ftyprctrm,
	imu_trantrm,
	imu_effdat,
	imu_expdat,
imm_cocde,
imm_itmno,
imm_cus1no,
imm_cus2no,
imm_tirtyp,
imm_moqunttyp,
imm_moqctn,
imm_qty,
imm_curcde,
imm_moa,
imm_creusr,
imm_updusr,
imm_credat,
imm_upddat

From	IMBASINF (NOLOCK)
left join	IMCOLINF col (NOLOCK) on	ibi_itmno = icf_itmno			and
				icf_colseq = 1
left join	IMPCKINF pck (NOLOCK) on	pck.ipi_itmno = ibi_itmno	--and 
--				pck.ipi_pckseq = (	select	min(spk.ipi_pckseq)
--						from	impckinf spk (NOLOCK)
--						where	spk.ipi_itmno = ibi_itmno)
left join	VNBASINF (NOLOCK) on	vbi_venno = ibi_venno
left join	IMPRCINF (NOLOCK) on 	--imu_ventyp = case vbi_ventyp when 'E' then 'D' else 'P' end and 
				imu_venno = ibi_venno		and 
				imu_itmno = ibi_itmno		and 
				imu_status = 'ACT'			and
				pck.ipi_pckunt = imu_pckunt		and
				pck.ipi_inrqty = imu_inrqty		and
				pck.ipi_mtrqty = imu_mtrqty		and
				pck.ipi_conftr = imu_conftr		/*and
				imu_effdat <= CONVERT(varchar(100), GETDATE(), 1)			and
				imu_expdat >= CONVERT(varchar(100),  dateadd(dd, 1, GETDATE()), 1)*/
left join	IMMOQMOA (NOLOCK) on imm_itmno = imu_itmno and imm_cus1no = imu_cus1no
left join	SYCONFTR (NOLOCK) on	pck.ipi_pckunt = ycf_code1		and
				ycf_code2 = 'PC' 
left join	SYTIESTR (NOLOCK) on	ibi_tirtyp = '1'			and 
				pck.ipi_mtrqty >= yts_qtyfr		and 
				pck.ipi_mtrqty <= yts_qtyto		and
				ibi_venno = yts_venno			and
				yts_tirtyp = 'M'			and
				yts_itmtyp = 'R'			and
				yts_effdat = (	select	top 1 yts_effdat
						from	SYTIESTR
						where	yts_venno = ibi_venno
						order by	yts_effdat desc),
	IMVENINF (NOLOCK)
where 	ibi_itmno = ivi_itmno				and
	ibi_venno = ivi_venno				and
	ibi_venno not in ('0005','0006','0007','0008','0009')	and
	ibi_tirtyp = '1'				and
	ibi_typ = 'reg'				and 
	(ibi_itmsts = 'CMP'			or
	 ibi_itmsts = 'INC')				and
	ivi_venitm <> ''				and 
	(((ibi_itmno = @itmno			or
	    ibi_alsitmno = @itmno) and
	    @isnewitmfmt = 'N')		or
	 (ibi_itmno = @itmno		and
	  @isnewitmfmt = ''))				--and
--	imu_std = 'Y'

UNION

Select 	isnull(	case when @isnewitmfmt = 'N' then
			case when ibi_itmno = @itmno then ''
			else
			case when ibi_alsitmno = @itmno then 'A'
			end  
		end
	end ,'') as 'typ',
	ibi_credat,
	' ' as 'ibi_cocde',
	ibi_itmno,
	ivi_venitm,
	ibi_engdsc,
	ibi_venno,
	case rtrim(ltrim(ibi_imgpth))	when '' then 'N'
				else 'Y'
				end as 'ibi_img',
	isnull(pck.ipi_pckseq,1) as 'ipi_pckseq', 
	isnull(pck.ipi_inrqty,0) as 'ipi_inrqty', 
	isnull(pck.ipi_mtrqty,0) as 'ipi_mtrqty',
	isnull(pck.ipi_cft,0) as 'ipi_cft', 
	isnull(pck.ipi_pckunt,'N/A') as 'ipi_pckunt', 
	isnull(pck.ipi_conftr,1) as 'ipi_conftr',
	ibi_tirtyp, 
	ibi_moqctn,
	ibi_moa,
	isnull(imu_bcurcde,'') as'imu_bcurcde', 
	isnull(imu_basprc,0) as 'imu_basprc', 
	isnull(	case ycf_oper	when'*' then 'PC'
				when '/' then 'PC'
				else ipi_pckunt
		end,'N/A') as 'ipi_smpunt',
	isnull(ibi_alsitmno,' ') as  'ibi_alsitmno',			
	isnull(ibi_alscolcde,' ') as  'ibi_alscolcde',	
	vbi_ventyp,	
	ibi_catlvl3,
	col.icf_colcde as 'icf_colcde',
	ipi_qutdat,
	ibi_itmsts,
	imu_status,
	imu_cus1no,
	imu_cus2no,
	imu_hkprctrm,
	imu_ftyprctrm,
	imu_trantrm,
	imu_effdat,
	imu_expdat,
imm_cocde,
imm_itmno,
imm_cus1no,
imm_cus2no,
imm_tirtyp,
imm_moqunttyp,
imm_moqctn,
imm_qty,
imm_curcde,
imm_moa,
imm_creusr,
imm_updusr,
imm_credat,
imm_upddat

From	IMBASINF (NOLOCK)
left join	IMCOLINF col (NOLOCK) on	ibi_itmno = icf_itmno			and
				icf_colseq = 1
left join	IMPCKINF pck (NOLOCK) on	pck.ipi_itmno = ibi_itmno	--and 
--				pck.ipi_pckseq = (	select	min(spk.ipi_pckseq)
--						from	impckinf spk (NOLOCK)
--						where	spk.ipi_itmno = ibi_itmno)
left join	VNBASINF (NOLOCK) on	vbi_venno = ibi_venno
left join	IMPRCINF (NOLOCK) on	--imu_ventyp = case vbi_ventyp when 'E' then 'D' else 'P' end and 
				imu_venno = ibi_venno		and 
				imu_itmno = ibi_itmno		and 
				imu_status = 'ACT'			and
				pck.ipi_pckunt = imu_pckunt		and
				pck.ipi_inrqty = imu_inrqty		and
				pck.ipi_mtrqty = imu_mtrqty		and
				pck.ipi_conftr = imu_conftr		/*and
				imu_effdat <= CONVERT(varchar(100), GETDATE(), 1)			and
				imu_expdat >= CONVERT(varchar(100),  dateadd(dd, 1, GETDATE()), 1)*/
left join	IMMOQMOA (NOLOCK) on imm_itmno = imu_itmno and imm_cus1no = imu_cus1no
left join	SYCONFTR (NOLOCK)  on	pck.ipi_pckunt = ycf_code1		and
				ycf_code2 = 'PC',
	IMVENINF (NOLOCK)
where	ibi_itmno= ivi_itmno				and
	ibi_venno = ivi_venno				and
	ibi_venno not in ('0005','0006','0007','0008','0009')	and
	ibi_typ = 'reg'				and
	ibi_tirtyp = '2'				and
	(ibi_itmsts = 'CMP'			or
	 ibi_itmsts = 'INC')				and 
	ivi_venitm <> ''				and
	(((ibi_itmno = @itmno			or
	    ibi_alsitmno = @itmno) and
	    @isnewitmfmt = 'N')		or
	 (ibi_itmno = @itmno		and
	  @isnewitmfmt = ''))				--and
	--imu_std = 'Y'

UNION

Select 	isnull(	case when @isnewitmfmt = 'N' then
			case when ibi_itmno = @itmno then ''
			else
			case when ibi_alsitmno = @itmno then 'A'
			end  
		end
	end ,'') as 'typ',
	ibi_credat,
	' ' as 'ibi_cocde',
	ibi_itmno,
	ivi_venitm,
	ibi_engdsc,
	ibi_venno,
	case rtrim(ltrim(ibi_imgpth))	when '' then 'N'
				else 'Y'
				end as 'ibi_img',
	isnull(pck.ipi_pckseq,1) as 'ipi_pckseq',
	isnull(pck.ipi_inrqty,0) as 'ipi_inrqty', 
	isnull(pck.ipi_mtrqty,0) as 'ipi_mtrqty',
	isnull(pck.ipi_cft,0) as 'ipi_cft', 
	isnull(pck.ipi_pckunt,'N/A') as 'ipi_pckunt', 
	isnull(pck.ipi_conftr,1) as 'ipi_conftr',
	ibi_tirtyp, 
	isnull(yts_moq,0) as 'ibi_moqctn',
	isnull(yts_moa,0) as 'ibi_moa',
	isnull(imu_bcurcde,'') as'imu_bcurcde', 
	isnull(imu_basprc,0) as 'imu_basprc', 
	isnull(	case ycf_oper	when'*' then 'PC'
				when '/' then 'PC'
				else ipi_pckunt
		end,'N/A') as 'ipi_smpunt',
	isnull(ibi_alsitmno,' ') as  'ibi_alsitmno',			
	isnull(ibi_alscolcde,' ') as  'ibi_alscolcde',	
	vbi_ventyp,	
	ibi_catlvl3,
	col.icf_colcde as 'icf_colcde',
	ipi_qutdat,
	ibi_itmsts,
	imu_status,
	imu_cus1no,
	imu_cus2no,
	imu_hkprctrm,
	imu_ftyprctrm,
	imu_trantrm,
	imu_effdat,
	imu_expdat,
imm_cocde,
imm_itmno,
imm_cus1no,
imm_cus2no,
imm_tirtyp,
imm_moqunttyp,
imm_moqctn,
imm_qty,
imm_curcde,
imm_moa,
imm_creusr,
imm_updusr,
imm_credat,
imm_upddat

From	IMPDAINF(NOLOCK)
left join	IMCOLINF col (NOLOCK) on	pda_itmno = icf_itmno			and
				icf_colseq = 1
left join	IMBASINF (NOLOCK) on	pda_itmno = ibi_itmno
left join	IMPCKINF pck (NOLOCK) on	pck.ipi_itmno = ibi_itmno	--and 
--				pck.ipi_pckseq = (	select	min(spk.ipi_pckseq)
--						from	impckinf spk (NOLOCK)
--						where	spk.ipi_itmno = ibi_itmno)
left join	VNBASINF (NOLOCK) on	vbi_venno = ibi_venno
left join	IMPRCINF (NOLOCK) on	--imu_ventyp = case vbi_ventyp when 'E' then 'D' else 'P' end and 
				imu_venno = ibi_venno		and 
				imu_itmno = ibi_itmno		and 
				imu_status = 'ACT'			and
				pck.ipi_pckunt = imu_pckunt		and
				pck.ipi_inrqty = imu_inrqty		and
				pck.ipi_mtrqty = imu_mtrqty		and
				pck.ipi_conftr = imu_conftr		/*and
				imu_effdat <= CONVERT(varchar(100), GETDATE(), 1)			and
				imu_expdat >= CONVERT(varchar(100),  dateadd(dd, 1, GETDATE()), 1)*/
left join	IMMOQMOA (NOLOCK) on imm_itmno = imu_itmno and imm_cus1no = imu_cus1no
left join	SYCONFTR (NOLOCK) on	pck.ipi_pckunt = ycf_code1		and
				ycf_code2 = 'PC' 
left join	SYTIESTR (NOLOCK) on	ibi_tirtyp = '1'			and 
				pck.ipi_mtrqty >= yts_qtyfr		and 
				pck.ipi_mtrqty <= yts_qtyto		and
				ibi_venno = yts_venno			and
				yts_tirtyp = 'M'			and
				yts_itmtyp = 'R'			and
				yts_effdat = (	select	top 1 yts_effdat
						from	SYTIESTR
						where	yts_venno = ibi_venno
						order by	yts_effdat desc),
	IMVENINF (NOLOCK)
where 	ibi_itmno = ivi_itmno				and
	ibi_venno = ivi_venno				and
	ibi_venno not in ('0005','0006','0007','0008','0009')	and
	ibi_tirtyp = '1'				and
	ibi_typ = 'reg'				and 
	(ibi_itmsts = 'CMP'			or
	 ibi_itmsts = 'INC')				and
	ivi_venitm <> ''				and 
	ibi_itmno is not null				and
	(((pda_itmno = @itmno or
	    ibi_alsitmno = @itmno)	and
	  @isnewitmfmt = 'N')			or
	 (pda_itmno = @itmno		and
	  @isnewitmfmt = ''))				--and
	--imu_std = 'Y'

UNION

Select 	isnull(	case when @isnewitmfmt = 'N' then
			case when ibi_itmno = @itmno then ''
			else
			case when ibi_alsitmno = @itmno then 'A'
			end  
		end
	end ,'') as 'typ',
	ibi_credat,
	' ' as 'ibi_cocde',
	ibi_itmno,
	ivi_venitm,
	ibi_engdsc,
	ibi_venno,
	case rtrim(ltrim(ibi_imgpth))	when '' then 'N'
				else 'Y'
				end as 'ibi_img',
	isnull(pck.ipi_pckseq,1) as 'ipi_pckseq',
	isnull(pck.ipi_inrqty,0) as 'ipi_inrqty', 
	isnull(pck.ipi_mtrqty,0) as 'ipi_mtrqty',
	isnull(pck.ipi_cft,0) as 'ipi_cft', 
	isnull(pck.ipi_pckunt,'N/A') as 'ipi_pckunt', 
	isnull(pck.ipi_conftr,1) as 'ipi_conftr',
	ibi_tirtyp, 
	ibi_moqctn,
	ibi_moa,
	isnull(imu_bcurcde,'') as'imu_bcurcde', 
	isnull(imu_basprc,0) as 'imu_basprc', 
	isnull(	case ycf_oper	when'*' then 'PC'
				when '/' then 'PC'
				else ipi_pckunt
		end,'N/A') as 'ipi_smpunt',
	isnull(ibi_alsitmno,' ') as  'ibi_alsitmno',			
	isnull(ibi_alscolcde,' ') as  'ibi_alscolcde',	
	vbi_ventyp,	
	ibi_catlvl3,
	col.icf_colcde as 'icf_colcde',
	ipi_qutdat,
	ibi_itmsts,
	imu_status,
	imu_cus1no,
	imu_cus2no,
	imu_hkprctrm,
	imu_ftyprctrm,
	imu_trantrm,
	imu_effdat,
	imu_expdat,
imm_cocde,
imm_itmno,
imm_cus1no,
imm_cus2no,
imm_tirtyp,
imm_moqunttyp,
imm_moqctn,
imm_qty,
imm_curcde,
imm_moa,
imm_creusr,
imm_updusr,
imm_credat,
imm_upddat

From	IMPDAINF(NOLOCK)
left join	IMCOLINF col (NOLOCK) on	pda_itmno = icf_itmno			and
				icf_colseq = 1
left join	IMBASINF (NOLOCK) on	pda_itmno = ibi_itmno
left join	IMPCKINF pck (NOLOCK) on	pck.ipi_itmno = ibi_itmno	--and 
--				pck.ipi_pckseq = (	select	min(spk.ipi_pckseq)
--						from	impckinf spk (NOLOCK)
--						where	spk.ipi_itmno = ibi_itmno)
left join	VNBASINF (NOLOCK) on	vbi_venno = ibi_venno
left join	IMPRCINF (NOLOCK) on	--imu_ventyp = case vbi_ventyp when 'E' then 'D' else 'P' end and 
				imu_venno = ibi_venno		and 
				imu_itmno = ibi_itmno		and 
				imu_status = 'ACT'			and
				pck.ipi_pckunt = imu_pckunt		and
				pck.ipi_inrqty = imu_inrqty		and
				pck.ipi_mtrqty = imu_mtrqty		and
				pck.ipi_conftr = imu_conftr		/*and
				imu_effdat <= CONVERT(varchar(100), GETDATE(), 1)			and
				imu_expdat >= CONVERT(varchar(100),  dateadd(dd, 1, GETDATE()), 1)*/
left join	IMMOQMOA (NOLOCK) on imm_itmno = imu_itmno and imm_cus1no = imu_cus1no
left join	SYCONFTR (NOLOCK) on	pck.ipi_pckunt = ycf_code1		and
				ycf_code2 = 'PC',
	IMVENINF (NOLOCK)
where 	ibi_itmno = ivi_itmno				and
	ibi_venno = ivi_venno				and
	ibi_venno not in ('0005','0006','0007','0008','0009')	and
	ibi_tirtyp = '2'				and
	ibi_typ = 'reg'				and 
	(ibi_itmsts = 'CMP'			or
	 ibi_itmsts = 'INC')				and
	ivi_venitm <> ''				and 
	ibi_itmno is not null				and
	(((pda_itmno = @itmno or
	    ibi_alsitmno = @itmno)	and
	  @isnewitmfmt = 'N')			or
	 (pda_itmno = @itmno		and
	  @isnewitmfmt = ''))				--and
	--imu_std = 'Y'
order by ibi_itmno, ipi_pckunt, ipi_inrqty, ipi_mtrqty, ipi_conftr, imu_cus1no desc, imu_cus2no desc, imu_hkprctrm desc, imu_ftyprctrm desc, imu_trantrm desc, imu_effdat desc, imu_expdat desc






GO
GRANT EXECUTE ON [dbo].[sp_select_PDA_Item_GetItem2] TO [ERPUSER] AS [dbo]
GO
