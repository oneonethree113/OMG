/****** Object:  StoredProcedure [dbo].[sp_list_PKREQDTL_by_item]    Script Date: 09/29/2017 15:29:09 ******/
DROP PROCEDURE [dbo].[sp_list_PKREQDTL_by_item]
GO
/****** Object:  StoredProcedure [dbo].[sp_list_PKREQDTL_by_item]    Script Date: 09/29/2017 15:29:10 ******/
SET ANSI_NULLS OFF
GO
SET QUOTED_IDENTIFIER OFF
GO









CREATE  procedure [dbo].[sp_list_PKREQDTL_by_item]
                                                                                                                                                                                                                                                                 
@code nvarchar(10),
@itmno nvarchar(20)


---------------------------------------------- 

 
AS
 

begin

	 
select 
'N' as 'prd_action', 
prd_cocde,  
prd_reqno,  
prd_seq,  

prd_itemno + '/' + prd_assitm + '/' + prd_tmpitmno + '/' + prd_venno + '/' + prd_venitm as 'prd_itmall',

prd_itemno,  
prd_assitm,  
prd_tmpitmno,  
prd_venno,  
prd_venitm,  

prd_pckunt,  
prd_inrqty,  
prd_mtrqty,  
prd_cft,  
prd_colcde,  
prd_sku,  
prd_cusitm,  
prd_conftr,  
prd_ftyprctrm,  
prd_hkprctrm,  
prd_trantrm,  
prd_pkgitm,  
prd_pkgven,  
prd_cate,  
prd_chndsc,  
prd_engdsc,  
prd_remark,  
convert(varchar(20),prd_EInchL) +'X'+ convert(varchar(20),prd_EInchW) +'X'+ convert(varchar(20),prd_EInchH) as 'prd_EInchLWH',
prd_EInchL,  
prd_EInchW,  
prd_EInchH,  
convert(varchar(20),prd_EcmL) +'X'+ convert(varchar(20),prd_EcmW) +'X'+ convert(varchar(20),prd_EcmH) as 'prd_EcmLWH',
prd_EcmL,  
prd_EcmW,  
prd_EcmH,  
convert(varchar(20),prd_FInchL) +'X'+ convert(varchar(20),prd_FinchW) +'X'+ convert(varchar(20),prd_FinchH) as 'prd_FinchLWH',
prd_FInchL,  
prd_FinchW,  
prd_FinchH,  
convert(varchar(20),prd_FcmL) +'X'+ convert(varchar(20),prd_FcmW) +'X'+ convert(varchar(20),prd_FcmH) as 'prd_FcmLWH',
prd_FcmL,  
prd_FcmW,  
prd_FcmH,  
prd_matral,  
prd_matDsc,  
prd_tiknes,  
prd_tikDsc,
prd_prtmtd,  
prd_prtDsc,
prd_clrfot,  
prd_clrbck,  
prd_finish,  
prd_rmtnce,  
prd_addres,  
prd_state,  
prd_cntry,  
prd_zip,  
prd_Tel,  
prd_cntper,  
prd_sctoqty,  
prd_qtyum,  
prd_curcde,  
prd_multip,  
prd_ordqty,  
prd_wasper,  
prd_wasqty,  
prd_bonqty,  
prd_ttlordqty,  
prd_untprc,  
prd_ttlamtqty,  
prd_receqty,  
prd_ordno,  
prd_ordseq,  
prd_flag,  
prd_salprc,  
prd_ScToNo,  
prd_ScToSeq,  
prd_creusr,  
prd_updusr,  
prd_credat,  
prd_upddat,  
prd_timstp 
from PKREQDTL (nolock)
left join vnbasinf (nolock) on prd_pkgven = vbi_venno
left join SYPAKCAT (nolock) on prd_cate = ypc_code
left join PKREQHDR (nolock) on prd_cocde = prh_cocde and prd_reqno = prh_reqno
where prd_pkgitm = @itmno
and prh_status = 'OPE'
order by prd_reqno, prd_seq


end


 
 








GO
GRANT EXECUTE ON [dbo].[sp_list_PKREQDTL_by_item] TO [ERPUSER] AS [dbo]
GO
