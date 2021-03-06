/****** Object:  StoredProcedure [dbo].[sp_list_QUOTNDTL_olditm]    Script Date: 09/29/2017 15:29:09 ******/
DROP PROCEDURE [dbo].[sp_list_QUOTNDTL_olditm]
GO
/****** Object:  StoredProcedure [dbo].[sp_list_QUOTNDTL_olditm]    Script Date: 09/29/2017 15:29:10 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO




--update quh
--set quh.quh_qutsts = 'H'	-- HOLD

CREATE procedure  [dbo].[sp_list_QUOTNDTL_olditm]
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
			vw_itmno		varchar(30) , 
			vw_colcde		varchar(30) , 
			vw_pckunt		varchar(100) , 
			vw_engdsc		varchar(50) , 
			vw_alsitmno	varchar(30) , 
			vw_alscolcde	varchar(30) 
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
			qud_untcde + '/' + ltrim(rtrim( str(qud_inrqty))) + '/' + rtrim(ltrim( str(qud_mtrqty))) as 'qud_untcde', 
			'' as 'vw_itmno',
			'' as 'vw_colcde',
			'' as 'vw_pckunt',
			'' as 'vw_engdsc',
			'' as 'vw_alsitmno',
			'' as 'vw_alscolcde'
	
		from
			QUOTNDTL qud (nolock)
			left join IMBASINF old (nolock) on qud_itmno = old.ibi_itmno
		where 
			isnull(old.ibi_itmsts,'') = 'OLD' and isnull(qud_ftytmpitm,'') <> 'Y' and 
			qud_cocde = @cocde and
			qud_qutno = @qutno
		

		---update 	#tmp_DTL
		--set	UPD = '' , vw_itmno = '', vw_colcde = '', vw_pckunt = '', vw_engdsc = '', vw_alsitmno = '', vw_alscolcde = ''
		
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
			left join IMCOLINF col on bas.ibi_alsitmno = col.icf_itmno
		where
			isnull(col.icf_colcde,'') = dtl.qud_colcde 
		
		-- Packing
		update
			dtl
		set
			vw_pckunt = isnull(rtrim(ltrim(ipi_pckunt)) + '/' +  rtrim(ltrim(str(ipi_inrqty))) + '/' +  rtrim(ltrim(str(ipi_mtrqty))),'')
		from
			#tmp_DTL dtl , IMPCKINF pck
		where
			ltrim(rtrim(dtl.vw_itmno)) <> '' and
			dtl.vw_itmno = pck.ipi_itmno and 
			dtl.qud_untcde = isnull(rtrim(ltrim(ipi_pckunt)) + '/' +  rtrim(ltrim(str(ipi_inrqty))) + '/' +  rtrim(ltrim(str(ipi_mtrqty))),'')
		
		update
			#tmp_DTL
		set
			vw_engdsc = case vw_colcde 
					when '' then case vw_pckunt when '' then 'Item & Color Not Match.' else '' end 
					else case vw_pckunt when '' then 'Packing Not Match.' else '' end 
				end

		/*-----------------------------------
		Added by Mark Lau 20061109
		check the matched whether is in discontinued status
		--------------------------------------------*/
		update 
			dtl
		set 
			--vw_engdsc = case bas.ibi_itmsts when 'DIS' then 'The matched item is in Discontinued Status.' else vw_engdsc end

			vw_engdsc = 'The matched item is in ' + case bas.ibi_itmsts 	
							
							--when 'HLD' then 'Hold'
							when 'DIS' then  'Discontinued'
							--when 'INA' then 'Inactive'
							--when 'TBC' then 'To Be Confirmed '
							--when 'OLD' then 'Old Item'
					end + ' Status.'
		from
			#tmp_DTL dtl 
			left join IMBASINF bas on dtl.vw_itmno = bas.ibi_itmno 
				
		/*-----------------------------------*/
		


		select * from #tmp_DTL order by qud_qutseq
			
		
		drop table #tmp_DTL 

	end
	else if @opt = 'LST'
	begin
		--select * from IMPCKINF where ipi_itmno = '06A52DA018A01'

		select distinct 
			qud_itmno,
			qud_qutseq,
			new.ibi_itmno as 'vw_itmno',
			isnull(new.ibi_engdsc,'') as 'vw_engdsc',
			isnull(col.icf_colcde,'') as 'vw_colcde', 
			isnull(rtrim(ltrim(pck.ipi_pckunt)) + '/' +  rtrim(ltrim(str(pck.ipi_inrqty))) + '/' +  rtrim(ltrim(str(pck.ipi_mtrqty))),'') as 'vw_pckunt',
			--' ' as 'vw_pckunt',
			isnull(new.ibi_alsitmno,'') as 'ibi_alsitmno',
			isnull(new.ibi_alscolcde,'') as 'ibi_alscolcde',


			--Added by Mark Lau 20061109
			 'The matched item is in ' + case new.ibi_itmsts 	
							
							--when 'HLD' then 'Hold'
							when 'DIS' then  'Discontinued'
							--when 'INA' then 'Inactive'
							--when 'TBC' then 'To Be Confirmed '
							--when 'OLD' then 'Old Item'
					end + ' Status.' as 'Remarks'
		from 
			QUOTNDTL qud (nolock)
			left join IMBASINF old (nolock) on qud_itmno = old.ibi_itmno
			left join IMBASINF new (nolock) on qud_itmno = new.ibi_alsitmno 
			left join IMCOLINF col (nolock) on new.ibi_itmno = col.icf_itmno
			left join IMPCKINF pck (nolock) on new.ibi_itmno = pck.ipi_itmno
		where
			isnull(old.ibi_itmsts,'') = 'OLD' and  isnull(qud_ftytmpitm,'') <> 'Y' and 
			--qud_cocde = 'UCPP' and
			--qud_qutno = 'UQ0601914'
			qud_cocde = @cocde and
			qud_qutno = @qutno
		order by 
			qud_itmno, qud_qutseq, vw_itmno
			
			
		
		
	end
End



GO
GRANT EXECUTE ON [dbo].[sp_list_QUOTNDTL_olditm] TO [ERPUSER] AS [dbo]
GO
