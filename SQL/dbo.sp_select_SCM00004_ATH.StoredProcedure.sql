/****** Object:  StoredProcedure [dbo].[sp_select_SCM00004_ATH]    Script Date: 09/29/2017 15:29:09 ******/
DROP PROCEDURE [dbo].[sp_select_SCM00004_ATH]
GO
/****** Object:  StoredProcedure [dbo].[sp_select_SCM00004_ATH]    Script Date: 09/29/2017 15:29:10 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO











CREATE procedure [dbo].[sp_select_SCM00004_ATH] 
@cocde as nvarchar(6) , 
@scFm as nvarchar(20) , 
@scTo as nvarchar(20) , 
@usrid	nvarchar(30),
@doctyp nvarchar(2),
@dummy as char(1)
as
begin

	create table #tmp_sc(
		_ordno	nvarchar(20),		
		_ordseq	int
	)
/*	
	insert into #tmp_sc(_ordno, _ordseq)
	select distinct sod_ordno, sod_ordseq
	from SCORDDTL, SCORDHDR
	where 
		sod_ordno = soh_ordno and
		soh_ordsts <> 'CLO' and soh_ordsts <> 'CAN' and
		sod_ordno >= @scFm and sod_ordno <= @scTo
*/
	-- Only Get SC without batch number - Frankie Cheung 20100408
	insert into #tmp_sc(_ordno, _ordseq)
	select distinct sod_ordno, sod_ordseq
	from SCORDDTL, SCORDHDR
	left join CUBASINF on soh_cus1no = cbi_cusno
	left join SYSALREP on cbi_salrep = ysr_code1 and ysr_cocde = ' '	
	where 
		sod_ordno = soh_ordno and
--		soh_ordsts <> 'CLO' and soh_ordsts <> 'CAN' and
		sod_ordno >= @scFm and sod_ordno <= @scTo 

		and 	(	
				exists
				(	
					select 1 from syusrright
					where yur_usrid = @usrid  and yur_doctyp = @doctyp and yur_lvl = 0
--					and yur_cogrp in (select yco_cogrp from sycominf where yco_cocde = @cocde)
				)
				or cbi_saltem in 
				(	
					select yur_para from syusrright
					where yur_usrid = @usrid and yur_doctyp = @doctyp and yur_lvl = 1
--					and yur_cogrp in (select yco_cogrp from sycominf where yco_cocde = @cocde)
				)
				or soh_cus1no in 
				(
					select yur_para from syusrright
					where yur_usrid = @usrid and yur_doctyp = @doctyp and yur_lvl = 2
--					and yur_cogrp in (select yco_cogrp from sycominf where yco_cocde = @cocde)
				)
			)



--	select distinct sod_ordno + ' - ' + ltrim(rtrim(convert(nvarchar(20),sod_ordseq))) as 'scseq'

	select 	distinct
		stm_cocde as 'stm_cocde', 
--		_ordno + ' - ' + ltrim(rtrim(convert(nvarchar(20),_ordseq))) + ' - ' + _itmdsc as 'scseq',
		_ordno + ' - ' + ltrim(rtrim(convert(nvarchar(20),_ordseq))) as 'scseq',
		stm_smkno as 'stm_smkno' , 
		'___' as 'stm_creusr'
	from 
		#tmp_sc
		left join SCTPSMRK on _ordno = stm_ordno and _ordseq = stm_ordseq
	where 
		stm_act <> 'DEL'

		
end

GO
GRANT EXECUTE ON [dbo].[sp_select_SCM00004_ATH] TO [ERPUSER] AS [dbo]
GO
