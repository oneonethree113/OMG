/****** Object:  StoredProcedure [dbo].[sp_list_QUOTNDTL_upditm2]    Script Date: 09/29/2017 15:29:09 ******/
DROP PROCEDURE [dbo].[sp_list_QUOTNDTL_upditm2]
GO
/****** Object:  StoredProcedure [dbo].[sp_list_QUOTNDTL_upditm2]    Script Date: 09/29/2017 15:29:10 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO



CREATE procedure  [dbo].[sp_list_QUOTNDTL_upditm2]
@cocde	varchar(6),
@qutno	varchar(30),
@opt	char(3)
as
Begin
	if @opt = 'DTL'
	begin
		create table #tmp_DTL(
			UPD		char(1) , 
			NO		int , 
			qud_qutno		varchar(30) , 
			qud_qutseq		int,
			qud_itmno		varchar(30),
			qud_colcde		varchar(30),
			qud_untcde		varchar(100) , 
			qud_conftr		int,
			qud_ftytmpitm	nvarchar(1),
			qud_curcde		nvarchar(6),
			qud_basprc		numeric(13,4),
			vw_itmno		varchar(30) , 
			vw_colcde		varchar(30) , 
			vw_pckunt		varchar(100) , 
			vw_conftr		int,
			vw_ftytmpitm	nvarchar(1),
			vw_basprc		numeric(13,4),
			qce_spcurcde	nvarchar(6),		
			qce_amt		numeric(13,4),
			vw_engdsc		varchar(50) , 
			vw_alsitmno	varchar(30) , 
			vw_alscolcde	varchar(30) ,
			vw_remark	nvarchar(255)
		)
		
		insert into 	
			#tmp_DTL
		select 
			'N' as 'UPD' ,
			qud_qutseq as 'NO',
			qud_qutno ,
			qud_qutseq,
			qud_itmno,
			qud_colcde,
			qud_untcde + '/' + ltrim(rtrim( str(qud_inrqty))) + '/' + rtrim(ltrim( str(qud_mtrqty)))   as 'qud_untcde', 
			qud_conftr,
			qud_ftytmpitm,
			qud_curcde,
			qud_basprc,		
			'' as 'vw_itmno',
			'' as 'vw_colcde',
			'' as 'vw_pckunt',
			0 as 'vw_conftr',
			'' as 'vw_ftytmpitm',
			0 as 'vw_basprc',
			qud_curcde,
			isnull(qce_amt,0)  as 'qce_amt',
			'' as 'vw_engdsc',
			'' as 'vw_alsitmno',
			'' as 'vw_alscolcde',
			'' as 'vw_remark'
		from
			QUOTNDTL qud (nolock)
			left join qucstemt on qud_qutno = qce_qutno and qud_qutseq = qce_qutseq and qce_cecde = '04'
			left join IMBASINF old (nolock) on qud_itmno = old.ibi_itmno
			left join SYSETINF on ysi_cde = qce_cecde and ysi_typ = '17'
		where 
			(isnull(old.ibi_itmsts,'') <> 'OLD'	or
			 isnull(qud_ftytmpitm,'') = 'Y')	and
			qud_tbm <> 'Y'		and 
			qud_cocde = @cocde		and
			qud_qutno = @qutno		and
			qud_apprve <> 'Y'

		-- Item & Color
		update 
			dtl
		set 
			vw_itmno = isnull(bas.ibi_itmno,'') , 
			vw_colcde = isnull(col.icf_colcde,'') ,
			vw_alsitmno = isnull(bas.ibi_alsitmno,'') ,  
			vw_alscolcde = isnull(bas.ibi_alscolcde,'')
		from
			#tmp_DTL dtl 
			-- Match Alias Item and Alias Color Code
			left join IMBASINF bas on dtl.qud_itmno = bas.ibi_alsitmno and dtl.qud_colcde = bas.ibi_alscolcde
			left join IMCOLINF col on bas.ibi_itmno = col.icf_itmno
		where
			isnull(col.icf_colcde,'') = dtl.qud_colcde 

		-- Packing
		update
			dtl
		set
			vw_pckunt = isnull(rtrim(ltrim(ipi_pckunt)) + '/' +  rtrim(ltrim(str(ipi_inrqty))) + '/' +  rtrim(ltrim(str(ipi_mtrqty))) ,'') ,
			vw_basprc = isnull(imu_basprc,0) ,
			vw_conftr = isnull(ipi_conftr,0)
		from
			#tmp_DTL dtl , IMPCKINF pck, imprcinf, quotnhdr
		where
			ltrim(rtrim(dtl.vw_itmno)) <> ''		and
			dtl.vw_itmno = pck.ipi_itmno		and 
			dtl.qud_untcde = isnull(rtrim(ltrim(ipi_pckunt)) + '/' +  rtrim(ltrim(str(ipi_inrqty))) + '/' +  rtrim(ltrim(str(ipi_mtrqty))) ,'') and
			dtl.qud_conftr = ipi_conftr		and
			--pck.ipi_pckseq = imd_pckseq		and
			pck.ipi_itmno = imu_itmno		and
			pck.ipi_pckunt = imu_pckunt		and
			pck.ipi_inrqty = imu_inrqty		and
			pck.ipi_mtrqty = imu_mtrqty		and
			imu_ventyp = 'D'			and
			dtl.qud_qutno = quh_qutno		/*and
			quh_cus1no = imd_cus1no		and
			quh_cus2no = imd_cus2no*/
	
		-- Packing
		/*update
			dtl
		set
			vw_pckunt = isnull(rtrim(ltrim(ipi_pckunt)) + '/' +  rtrim(ltrim(str(ipi_inrqty))) + '/' +  rtrim(ltrim(str(ipi_mtrqty))) ,'') ,
			vw_basprc = case when isnull(imu_std,'') = 'N' then 0 else isnull(imu_basprc,0) end,
			vw_conftr = isnull(ipi_conftr,0)
		from
			#tmp_DTL dtl , IMPCKINF pck, immrkup
		where
			ltrim(rtrim(dtl.vw_itmno)) <> '' and
			dtl.vw_itmno = pck.ipi_itmno and 
			dtl.qud_untcde = isnull(rtrim(ltrim(ipi_pckunt)) + '/' +  rtrim(ltrim(str(ipi_inrqty))) + '/' +  rtrim(ltrim(str(ipi_mtrqty))) ,'')
			and dtl.qud_conftr =ipi_conftr
			and pck.ipi_pckseq = imu_pckseq and
			 pck.ipi_itmno = imu_itmno
			and  imu_ventyp = 'D' and vw_pckunt = ''*/
		
		update
			#tmp_DTL
		set
			vw_engdsc = case vw_colcde 
					when '' then case vw_pckunt when '' then 'Item & Color Not Match.' else '' end 
					else case vw_pckunt when '' then 'Packing Not Match.' else '' end 
		end
		where 
			qud_ftytmpitm = 'Y'

		update
			#tmp_DTL
		set
			vw_remark = case when isnull(vw_itmno,'') <> '' then 'FG#' else '' end 

		/*-----------------------------------
		Added by Mark Lau 20061109
		check the matched whether is in discontinued status
		--------------------------------------------*/
		update 
			dtl
		set 
			vw_engdsc =  case bas.ibi_itmsts 	
					when 'DIS' then 'The matched item is in ' + 'Discontinued' + ' Status.'
					else vw_engdsc end 
		from
			#tmp_DTL dtl 
			left join IMBASINF bas on dtl.vw_itmno = bas.ibi_itmno 
				
		select * from #tmp_DTL order by qud_qutseq
		
		drop table #tmp_DTL 
	end
	else if @opt = 'LST'
	begin
		select distinct 
			qud_itmno,
			qud_qutseq,
			new.ibi_itmno as 'vw_itmno',
			isnull(new.ibi_engdsc,'') as 'vw_engdsc',
			isnull(col.icf_colcde,'') as 'vw_colcde', 
			isnull(rtrim(ltrim(pck.ipi_pckunt)) + '/' +  rtrim(ltrim(str(pck.ipi_inrqty))) + '/' +  rtrim(ltrim(str(pck.ipi_mtrqty))) ,'') as 'vw_pckunt',
			isnull(new.ibi_alsitmno,'') as 'ibi_alsitmno',
			isnull(new.ibi_alscolcde,'') as 'ibi_alscolcde',
			 'The matched item is in ' + case new.ibi_itmsts 	
						when 'DIS' then  'Discontinued'
					end + ' Status.' as 'Remarks'
		from 
			QUOTNDTL qud (nolock)
			left join IMBASINF old (nolock) on qud_itmno = old.ibi_itmno
			left join IMBASINF new (nolock) on qud_itmno = new.ibi_alsitmno 
			left join IMCOLINF col (nolock) on new.ibi_itmno = col.icf_itmno
			left join IMPCKINF pck (nolock) on new.ibi_itmno = pck.ipi_itmno
		where
			(isnull(old.ibi_itmsts,'') <> 'OLD'	or
			 isnull(qud_ftytmpitm,'') = 'Y')	and
			qud_tbm <> 'Y'		and 
			qud_cocde = @cocde		and
			qud_qutno = @qutno
		order by 
			qud_itmno, qud_qutseq, vw_itmno
	end
End




GO
GRANT EXECUTE ON [dbo].[sp_list_QUOTNDTL_upditm2] TO [ERPUSER] AS [dbo]
GO
