/****** Object:  StoredProcedure [dbo].[sp_select_PGM00007_report]    Script Date: 09/29/2017 15:29:09 ******/
DROP PROCEDURE [dbo].[sp_select_PGM00007_report]
GO
/****** Object:  StoredProcedure [dbo].[sp_select_PGM00007_report]    Script Date: 09/29/2017 15:29:10 ******/
SET ANSI_NULLS OFF
GO
SET QUOTED_IDENTIFIER OFF
GO



CREATE PROCEDURE [dbo].[sp_select_PGM00007_report] 
@cocde as nvarchar(6),
@ordno as nvarchar(20)

AS

BEGIN


select 
yco_conam,
yco_addr, 
yco_logoimgpth ,
'Tel:' + yco_phoneno + 'Fax ' + yco_faxno as 'Tel',
--Company Logo
poh_Pkgven, 
hdr.vbi_vensna as 'headerVen' , 
poh_address , 
poh_ctnper , 
poh_tel , 
poh_ordno , 
poh_issdat , 
poh_revdat ,  			--Header
pod_seq , 
pod_pkgitm , 
case pib_chndsc when '' then pib_engdsc else pib_chndsc end as 'pib_chndsc',
convert(varchar(20),pib_FInchL) + '"x' + convert(varchar(20),pib_FInchW) + '"x' + convert(varchar(20),pib_FInchH) as 'pib_FinchL' , 
convert(varchar(20),pib_EInchL) + '"x' + convert(varchar(20),pib_EInchW) + '"x' + convert(varchar(20),pib_EInchH) as 'pib_EinchL' , 
pod_ttlordqty , 
pod_untprc , 
pod_ttlamtqty ,
pib_img, 
pod_shpstr , 
pod_fty , 
isnull(dtl.vbi_vensna,'')as'DetailVen' ,
poh_dremark ,
pod_creusr,
pod_curcde,
'XXX' as 'pod_customer',
'YYYY' as 'pod_delivery',
'ZZZZ' as 'pod_address'
from pkordhdr 
left join pkorddtl on pod_ordno = poh_ordno
--left join cubasinf on poh_cus1no = cbi_cusno
--left join SYPAKCAT on pod_cate = ypc_code
left join vnbasinf  hdr on hdr.vbi_venno = poh_Pkgven
left join sycominf on @cocde = yco_cocde
left join vnbasinf dtl on dtl.vbi_venno = pod_fty
left join pkimbaif on pib_pgitmno = pod_pkgitm
where poh_ordno = @ordno and poh_cocde = @cocde 
order by pod_ordno,pod_seq




END


GRANT  EXECUTE  ON [sp_select_PGM00007_report]  TO [ERPUSER]


GO
GRANT EXECUTE ON [dbo].[sp_select_PGM00007_report] TO [ERPUSER] AS [dbo]
GO
