/****** Object:  StoredProcedure [dbo].[sp_select_SCM00004_SM]    Script Date: 09/29/2017 15:29:09 ******/
DROP PROCEDURE [dbo].[sp_select_SCM00004_SM]
GO
/****** Object:  StoredProcedure [dbo].[sp_select_SCM00004_SM]    Script Date: 09/29/2017 15:29:10 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO



CREATE procedure [dbo].[sp_select_SCM00004_SM] 
@cocde as nvarchar(6) , 
@scFm as nvarchar(20) , 
@scTo as nvarchar(20) , 
@usrid	nvarchar(30),
@doctyp nvarchar(2),
@dummy as char(1)
as

declare @sel as nvarchar(1)

set @sel = ''

begin
/*	
	select distinct sod_ordno + ' - ' + ltrim(rtrim(convert(nvarchar(20),sod_ordseq))) as 'scseq', sod_itmdsc as 'itmdsc'
	from SCORDDTL, SCORDHDR
	where 
		sod_ordno = soh_ordno and
		soh_ordsts <> 'CLO' and soh_ordsts <> 'CAN' and
		sod_ordno >= @scFm and sod_ordno <= @scTo
	order by scseq
*/
	-- Frankie Cheung 20100408 - Only get SC without Batch Number
--	select distinct sod_ordno + ' - ' + ltrim(rtrim(convert(nvarchar(20),sod_ordseq))) as 'scseq', sod_itmdsc as 'itmdsc'
	select distinct @sel as 'sod_sel', sod_ordno, sod_ordseq, pod_jobord, sod_itmno, 
			case isnull(pjd_jobord,'') when '' then 'N' else 'Y' end as 'uploaded',
			case isnull(pjd_jobord,'') when '' then '' else pjd_jobord end as 'pjd_jobno'	from	SCORDDTL 
			
		left join SCORDHDR on (sod_ordno = soh_ordno)
		left join POORDDTL on (sod_ordno = pod_scno and sod_ordseq = pod_scline)
		left  join  POJBBDTL on (pod_jobord = pjd_jobord) 
		left join CUBASINF on soh_cus1no = cbi_cusno
		left join SYSALREP on cbi_salrep = ysr_code1 and ysr_cocde = ' '	
	where 
		soh_cocde = @cocde and
--		Frankie Cheung 20100609
--		soh_ordsts <> 'CLO' and soh_ordsts <> 'CAN' and
		sod_ordno >= @scFm and sod_ordno <= @scTo 
--		and pjd_creusr <> 'MISBJ'

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



	order by sod_ordno,  sod_ordseq




		
end

GO
GRANT EXECUTE ON [dbo].[sp_select_SCM00004_SM] TO [ERPUSER] AS [dbo]
GO
