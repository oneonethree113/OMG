/****** Object:  StoredProcedure [dbo].[sp_select_IMITMDAT_invld]    Script Date: 09/29/2017 15:29:09 ******/
DROP PROCEDURE [dbo].[sp_select_IMITMDAT_invld]
GO
/****** Object:  StoredProcedure [dbo].[sp_select_IMITMDAT_invld]    Script Date: 09/29/2017 15:29:10 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO






/*
=========================================================
Program ID	: 	sp_select_IMITMDAT_Invld
Description   	: 	Retrieve IM Invalid Items
Programmer  	: 	David Yue
Date Created	:	2012-06-26
=========================================================
 Modification History                                    
=========================================================
2012-07-20	David Yue	Remvoed duplicate items from query
=========================================================     
*/

CREATE    PROCEDURE [dbo].[sp_select_IMITMDAT_invld]

@cocde		nvarchar(6),	@fromdate	nvarchar(10),	@todate		nvarchar(10),
@fromvendor	nvarchar(6),	@tovendor	nvarchar(6),	@fromline	nvarchar(10),
@toline		nvarchar(10),	@venitm		nvarchar(20),	@fromprdven	nvarchar(6),
@toprdven	nvarchar(6),	@fromCusVen	nvarchar(6),	@toCusVen	nvarchar(6),
@creusr		nvarchar(30)

AS

declare @no int
set @no = 1

select	@no as 'no',
	iid_stage,
	iid_stage as 'old_stage',
	iid_venno,
	isnull(iid_prctrm,'') as 'iid_prctrm',
	iid_cusven,  
	iid_prdven,  
	iid_venitm, 
	iid_itmno,  
	iid_itmtyp,  
	iid_mode,  
	iid_engdsc, 
	iid_pckitr,
	iid_sysmsg,
	isnull(iid_untcde,'') as 'iid_untcde',   
	isnull(iid_inrqty,0) as 'iid_inrqty', 
	isnull(iid_mtrqty,0) as 'iid_mtrqty',   
	isnull(iid_cft,0) as 'iid_cft',  
	iid_conftr,  
	isnull(iid_curcde,'') as 'iid_curcde', 
	isnull(iid_ftyprc,0) as 'iid_ftyprc',  
	iid_lnecde,  
	isnull(iid_ftycst,0) as 'iid_ftycst',  
	round(isnull(iic_negprc,0),4) as 'iic_negprc',
	iid_chndsc,  
	ltrim(str(month(iid_credat)))+'/'+ltrim(str(day(iid_credat)))+'/'+ltrim(str(year(iid_credat))) as 'iid_credat',  
	iid_itmsts, 
	iid_catlvl4, 
	iid_inrlcm,   
	iid_inrwcm, 
	iid_inrhcm, 
	iid_mtrlcm,   
	iid_mtrwcm, 
	iid_mtrhcm, 
	iid_grswgt,  
	iid_netwgt, 
	case when year(iid_period) = 1900 then '' else ltrim(str(year(iid_period))) + '-' +
		right('0' +  ltrim(str( month(iid_period))),2) end as 'iid_period',
	case when year(iid_cstexpdat) = 1900 then '' else iid_cstexpdat end as 'iid_cstexpdat',
	iid_creusr,  
	cast(iid_timstp as int) as 'iid_timstp',   
	iid_itmseq,  
	iid_upddat,   
	iid_updusr, 
	iid_recseq, 
	iid_chkdat,  
	iid_xlsfil,    
 	round(isnull(iid_ftyprc,0) / (case  when iid_conftr is NULL then 1 when iid_conftr = 0
		then 1 else iid_conftr end),4) as 'Fty Price in PC',
	isnull(iic_cus1no,'') as 'iic_cus1no',
	isnull(iic_cus2no,'') as 'iic_cus2no'
into	#tmptable
from	IMITMDAT
	left join IMITMDATCST on
	iic_cocde = iid_cocde and 
	iic_venno = iid_venno and  
	iic_prdven = iid_prdven and
	iic_venitm = iid_venitm and 
	iic_untcde = iid_untcde and  
	iic_inrqty = iid_inrqty and 
	iic_mtrqty = iid_mtrqty	and
	iic_itmseq = iid_itmseq and
	iic_recseq =iid_recseq and 
	iic_xlsfil = iid_xlsfil and
	iic_chkdat = iid_chkdat and
	iic_conftr = iid_assconftr
where	iid_credat >= (case @fromdate when '' then '1900-01-01' else @fromdate end) and  
 	iid_credat <= (case @todate when '' then '2099-12-31 23:59:59' else @todate + ' 23:59:59' end) and  
   	iid_cusven between (case @fromCusVen when '' then '' else @fromCusVen end) and
		(case @toCusVen when '' then 'ZZZZZZ' else @toCusVen end) and
	iid_venno between (case @fromvendor when '' then '' else @fromvendor end) and  
        	(case @tovendor when '' then 'ZZZZZZ' else @tovendor end) and
	iid_prdven between (case @fromprdven when '' then '' else @fromprdven end) and  
        	(case @toprdven when '' then 'ZZZZZZ' else @toprdven end) and
	iid_lnecde between (case @fromline when '' then '' else @fromline end) and  
        	(case @toline when '' then 'ZZZZZZZZZZ' else @toline end) and
	iid_venitm between (case @venitm when '' then '' else @venitm end) and  
		(case @venitm when '' then 'ZZZZZZZZZZZZZZZZZZZZ' else @venitm end) and
	iid_stage = 'I'
order by iid_venitm, iid_venno, iid_prdven, iic_cus1no, iic_cus2no, iid_untcde, iid_conftr, iid_inrqty, iid_mtrqty, iid_prctrm desc

delete from #tmptable
where	iid_timstp in
	(select a.iid_timstp
	 from	#tmptable a, #tmptable b
	 where	a.iid_venitm = b.iid_venitm and
		a.iid_venno = b.iid_venno and
		a.iid_prdven = b.iid_prdven and
		a.iid_untcde = b.iid_untcde and
		a.iid_inrqty = b.iid_inrqty and
		a.iid_mtrqty = b.iid_mtrqty and
		a.iid_conftr = b.iid_conftr and
		a.iid_prctrm = b.iid_prctrm and
		a.iic_cus1no = b.iic_cus1no and
		a.iic_cus2no = b.iic_cus2no and
		a.iid_timstp > b.iid_timstp
	)

select *
from #tmptable

drop table #tmptable








GO
GRANT EXECUTE ON [dbo].[sp_select_IMITMDAT_invld] TO [ERPUSER] AS [dbo]
GO
