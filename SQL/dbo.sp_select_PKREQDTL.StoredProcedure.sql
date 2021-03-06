/****** Object:  StoredProcedure [dbo].[sp_select_PKREQDTL]    Script Date: 09/29/2017 15:29:09 ******/
DROP PROCEDURE [dbo].[sp_select_PKREQDTL]
GO
/****** Object:  StoredProcedure [dbo].[sp_select_PKREQDTL]    Script Date: 09/29/2017 15:29:10 ******/
SET ANSI_NULLS OFF
GO
SET QUOTED_IDENTIFIER OFF
GO









CREATE  procedure [dbo].[sp_select_PKREQDTL]
                                                                                                                                                                                                                                                                 
@code nvarchar(10),
@reqno nvarchar(20)


---------------------------------------------- 

 
AS
 

begin

	 
select prd_cocde, prd_reqno, prd_seq, 
prd_itemno, prd_assitm,prd_tmpitmno, prd_venno, 
prd_venitm, prd_pckunt, prd_inrqty, prd_mtrqty, prd_cft,prd_colcde, prd_conftr,
prd_ftyprctrm, prd_hkprctrm, prd_trantrm, prd_pkgitm,
 prd_pkgven + ' - ' + vbi_vensna as 'prd_pkgven', prd_cate + ' - ' + ypc_pakna as 'prd_cate' , prd_chndsc, prd_engdsc, 
prd_remark, prd_EInchL, prd_EInchW, prd_EInchH, 
prd_EcmL, prd_EcmW, prd_EcmH, prd_FInchL, prd_FinchW, 
prd_FinchH, prd_FcmL, prd_FcmW, prd_FcmH, prd_matral, 
prd_tiknes, prd_prtmtd, prd_clrfot, prd_clrbck, prd_finish, prd_matDsc, prd_tikDsc,prd_prtDsc,
prd_rmtnce, prd_addres, prd_state, prd_cntry, prd_zip, prd_Tel, 
prd_cntper, prd_sctoqty, prd_qtyum, prd_curcde, prd_multip, prd_ordqty, prd_bonqty,
prd_wasper, prd_wasqty, prd_ttlordqty, 
cast(prd_untprc as numeric(13,5)) as 'prd_untprc', 
cast(prd_ttlamtqty as numeric(13,2)) as 'prd_ttlamtqty', 
prd_receqty,
 prd_creusr, prd_updusr, prd_credat, prd_upddat , prd_ordno , prd_salprc , prd_ScToNo,prd_ScToSeq 
,prd_sku , prd_cusitm 
 from PKREQDTL (nolock)
left join vnbasinf (nolock) on prd_pkgven = vbi_venno
 left join SYPAKCAT (nolock) on prd_cate = ypc_code
				
where prd_cocde = @code and prd_reqno =  @reqno

end


 
 







GO
GRANT EXECUTE ON [dbo].[sp_select_PKREQDTL] TO [ERPUSER] AS [dbo]
GO
