/****** Object:  StoredProcedure [dbo].[sp_insert_PKORDDTL]    Script Date: 09/29/2017 15:29:09 ******/
DROP PROCEDURE [dbo].[sp_insert_PKORDDTL]
GO
/****** Object:  StoredProcedure [dbo].[sp_insert_PKORDDTL]    Script Date: 09/29/2017 15:29:09 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
------------------------------------------------- 
CREATE PROCEDURE [dbo].[sp_insert_PKORDDTL] 

@cocde nvarchar(6),
@ordno nvarchar(20),
@seq   int,
@reqno nvarchar(20),
@reqseq int,
@unitprice numeric(11,6),
@ttlprice numeric(13,4),
@ttlqty int,
@wasper numeric(13,4),
@wasqty int,
@finalttlqty int,
@In_was nvarchar(10),
@bonqty int,
@user nvarchar(30)

AS





insert into PKORDDTL
select @cocde,@ordno,@seq,'OPE',
	prd_itemno,prd_tmpitmno,prd_venno,
	prd_venitm,prd_pckunt,prd_inrqty,
	prd_mtrqty,prd_cft,prd_colcde,prd_ftyprctrm,
	prd_hkprctrm,prd_trantrm,prd_pkgitm,
	prd_pkgven,prd_cate,prd_chndsc,
	prd_engdsc,prd_remark,prd_EInchL,
	prd_EInchW,prd_EInchH,prd_EcmL,
	prd_EcmW,prd_EcmH,prd_FInchL,
	prd_FinchW,prd_FinchH,prd_FcmL,
	prd_FcmW,prd_FcmH,prd_matral,
	prd_tiknes,prd_prtmtd,prd_clrfot,
	prd_clrbck,prd_finish,prd_matDsc,prd_tikDsc,prd_prtDsc,
	prd_rmtnce,prd_addres,prd_state,
	prd_cntry,prd_zip,prd_Tel,prd_cntper,
	prd_sctoqty,'PC',prd_curcde, --Change UM to Default 'PC' on 11/27/2014
	prd_multip,  @ttlqty as  'prd_ordqty',0 as 'stkqty', @wasper as 'prd_wasper',
	@wasqty as 'prd_wasqty', @bonqty as 'prd_bonqty', @finalttlqty as 'prd_ttlordqty' ,@unitprice as 'prd_untprc',
	@ttlprice as 'prd_ttlamtqty',prd_receqty,@reqno,
	@reqseq,'' as 'conmark',
	'1900-01-01' as 'shpstr',
	'1900-01-01' as 'shpend',
	'' as 'fty' ,
	@In_was as 'pod_InWas' ,
	0 as 'pod_MOA',
	@user,@user,getdate(),
	getdate(),null	,
	'',
	'',
	'',
	'',
	'',
	''

from PKREQDTL (NOLOCK)
where prd_reqno = @reqno and prd_seq = @reqseq


Update PKREQDTL set 
prd_ordno = @ordno,
prd_ordseq = @seq ,
prd_upddat = getdate(),
prd_updusr = @user
where prd_reqno = @reqno and prd_seq = @reqseq 


Update PKORDHDR set 
poh_ttlamt = poh_ttlamt + @ttlprice
where poh_ordno = @ordno

Update PKORDHDR set 
poh_TtlDelamt = poh_ttlamt + poh_Delamt
where poh_ordno = @ordno










GO
GRANT EXECUTE ON [dbo].[sp_insert_PKORDDTL] TO [ERPUSER] AS [dbo]
GO
