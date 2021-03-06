/****** Object:  StoredProcedure [dbo].[sp_select_POR00001_PDF]    Script Date: 09/29/2017 15:29:09 ******/
DROP PROCEDURE [dbo].[sp_select_POR00001_PDF]
GO
/****** Object:  StoredProcedure [dbo].[sp_select_POR00001_PDF]    Script Date: 09/29/2017 15:29:10 ******/
SET ANSI_NULLS OFF
GO
SET QUOTED_IDENTIFIER OFF
GO






/***********************************************************************************************************
Modification History
***********************************************************************************************************
Modified On		Modified By		Description
***********************************************************************************************************

***********************************************************************************************************/

--sp_select_POR00001_PDF 'UCPP','Y','UP0900001','UP0900101','N','1','1','1','Y','mis'

CREATE   PROCEDURE [dbo].[sp_select_POR00001_PDF]

	@cocde		nvarchar(6),
	@Sup0		nvarchar(1),
	@POfrom		nvarchar(20),	
	@POto		nvarchar(20),
	@Rvs		nvarchar(1),
	@sortBy		nvarchar(4)	,-- 1 : By Customer Item, 2 : By Item, 3 : By Input Seq
	@printGroup		nvarchar(1),--Added by Mark Lau 20060926
	@printAmt	nvarchar(1), -- Added by Marco 20090821
	@POCheck	nvarchar(1), -- Added by Marco 20090918
	@usrid		nvarchar(30), -- Added by Marco 20090918
	@doctyp	nvarchar(2)
AS


-- Read Company Information --
declare 
	@yco_conam varchar(50),	@yco_addr nvarchar(200),	@yco_logoimgpth varchar(100),	@yco_phoneno varchar(50),	@yco_faxno varchar(50)

SELECT 
	@yco_conam = yco_conam,	
	@yco_addr = yco_addr,
	@yco_logoimgpth = yco_logoimgpth, 
	@yco_phoneno = yco_phoneno,
	@yco_faxno = yco_faxno 
FROM
	SYCOMINF
WHERE
	YCO_COCDE = @cocde

set @POCheck = 'Y'	
create table #TEMP_PO_LIST
(
tmp_purord	nvarchar(20)
)

insert into #TEMP_PO_LIST
select poh_purord from POORDHDR
left join CUBASINF on cbi_cusno = poh_prmcus
left join SYSALREP on ysr_cocde = ' ' and ysr_code1 = cbi_salrep
where poh_purord >= @POfrom and poh_purord <= @POto and poh_cocde = @cocde 
and 	(	
		exists
		(	
			select 1 from syusrright
			where yur_usrid = @usrid  and yur_doctyp = @doctyp and yur_lvl = 0
		)
		or cbi_saltem in 
		(	
			select yur_para from syusrright
			where yur_usrid = @usrid and yur_doctyp = @doctyp and yur_lvl = 1
		)
		or cbi_cusno  in 
		(
			select yur_para from syusrright
			where yur_usrid = @usrid and yur_doctyp = @doctyp and yur_lvl = 2
		)
	)


Select
	distinct poh_purord
From	
POORDHDR
left join POORDDTL dtl on poh_cocde = dtl.pod_cocde and poh_purord = dtl.pod_purord
left join SCORDDTL on dtl.pod_cocde = sod_cocde and dtl.pod_scno = sod_ordno and dtl.pod_scline = sod_ordseq
left join SCORDHDR on poh_cocde = soh_cocde and poh_ordno = soh_ordno
left join CUBASINF on soh_cus1no = cbi_cusno
left join VNBASINF on poh_venno = vbi_venno
left join SYSETINF sys02 on poh_purcty = sys02.ysi_cde and sys02.ysi_typ = '02'
left join SYSETINF sys03 on poh_prctrm = sys03.ysi_cde and sys03.ysi_typ = '03'
left join SYSETINF sys04 on poh_paytrm = sys04.ysi_cde and sys04.ysi_typ = '04'
left join SYSETINF sys05 on dtl.pod_untcde = sys05.ysi_cde and sys05.ysi_typ = '05'
left join SYSALREP on poh_salrep = ysr_code1 
left join POSHPMRK mrk1 on poh_cocde = mrk1.psm_cocde and poh_purord = mrk1.psm_purord and mrk1.psm_shptyp = 'M'
left join POSHPMRK mrk2 on poh_cocde = mrk2.psm_cocde and poh_purord = mrk2.psm_purord and mrk2.psm_shptyp = 'I'
left join POSHPMRK mrk3 on poh_cocde = mrk3.psm_cocde and poh_purord = mrk3.psm_purord and mrk3.psm_shptyp = 'S'
Where 	
((@Sup0 = 'Y' and dtl.pod_ordqty > 0) or @Sup0 = 'N')
and	poh_purord >= @POfrom and poh_purord <= @POto and poh_cocde = @cocde
and 	(@POCheck = 'N' or (@POCheck = 'Y' and poh_purord in (select tmp_purord from #TEMP_PO_LIST))) -- Added by Marco 20090918
order by poh_purord asc




GO
GRANT EXECUTE ON [dbo].[sp_select_POR00001_PDF] TO [ERPUSER] AS [dbo]
GO
