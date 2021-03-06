/****** Object:  StoredProcedure [dbo].[sp_insert_PKORDDTL_09]    Script Date: 09/29/2017 15:29:09 ******/
DROP PROCEDURE [dbo].[sp_insert_PKORDDTL_09]
GO
/****** Object:  StoredProcedure [dbo].[sp_insert_PKORDDTL_09]    Script Date: 09/29/2017 15:29:09 ******/
SET ANSI_NULLS OFF
GO
SET QUOTED_IDENTIFIER OFF
GO















CREATE   procedure [dbo].[sp_insert_PKORDDTL_09]
                                                                                                                                                                                                                                                                 
  @pod_cocde  nvarchar (6), 
  @pod_ordno  nvarchar(20)  ,
  @pod_seq  int  ,
  @pod_status  nvarchar(20),  
  @pod_pkgitm  nvarchar(20),   
  @pod_pkgven  nvarchar(10),   
  @pod_cate  nvarchar(20),   
  @pod_chndsc  nvarchar(200),   
 @pod_engdsc  nvarchar(200),   
  @pod_remark  nvarchar(300),   
@pod_EInchL  numeric(13,4)   ,
     @pod_EInchW  numeric(13,4)  , 
  @pod_EInchH  numeric(13,4)   ,
  @pod_EcmL  numeric(13,4)   ,
       @pod_EcmW  numeric(13,4)  , 
     @pod_EcmH  numeric(13,4)   ,
     @pod_FInchL  numeric(13,4)   ,
    @pod_FinchW  numeric(13,4)  , 
  @pod_FinchH  numeric(13,4)   ,
   @pod_FcmL  numeric(13,4)   ,
   @pod_FcmW  numeric(13,4)  , 
  @pod_FcmH  numeric(13,4)   ,
  @pod_matral  nvarchar(100)   ,
   @pod_tiknes  nvarchar(100)   ,
   @pod_prtmtd  nvarchar(100)   ,
    @pod_clrfot  nvarchar(100)  ,
    @pod_clrbck  nvarchar(100) ,  
 @pod_finish  nvarchar(500)   ,
   @pod_matDsc  nvarchar(300),   
    @pod_tikDsc  nvarchar(300)  ,
    @pod_prtDsc  nvarchar(300)   ,
    @pod_rmtnce  nvarchar (100)  ,
      @pod_addres  nvarchar(300)   ,
      @pod_state  nvarchar(50)   ,
   @pod_cntry  nvarchar(50)  ,
@pod_zip  nvarchar(50)   ,
 @pod_Tel  nvarchar (20)  ,
 @pod_cntper  nvarchar(30),   
   @pod_sctoqty  int   ,
 @pod_qtyum  nvarchar(10)   ,
@pod_curcde  nvarchar(10)   ,
   @pod_multip  int   ,
  @pod_ordqty  int   ,
 @pod_stkqty  int   ,
 @pod_wper  int,                           
 @pod_wqty  int ,  
 @pod_ttlordqty  int,   
@pod_untprc  numeric(11,6),   
 @pod_ttlamtqty  numeric(13,4),   
 @pod_receqty  int   ,
  @pod_Reqno  nvarchar(20)   ,
  @pod_Reqseq  int   ,
 @pod_Conmak  nvarchar(300)   ,
  @pod_bonqty  int   ,
 @pod_inwas nvarchar(10),
@user nvarchar(30)

---------------------------------------------- 

 
AS
 

begin

	 
insert into PKORDDTL
(pod_cocde, pod_ordno, pod_seq, pod_status, pod_itemno, pod_tmpitmno, pod_venno, pod_venitm, pod_pckunt, pod_inrqty, pod_mtrqty, pod_cft, pod_colcde, pod_ftyprctrm, pod_hkprctrm, pod_trantrm, pod_pkgitm, pod_pkgven, pod_cate, pod_chndsc, pod_engdsc, pod_remark, pod_EInchL, 
pod_EInchW, pod_EInchH, pod_EcmL, pod_EcmW, pod_EcmH, pod_FInchL, pod_FinchW, pod_FinchH, pod_FcmL, pod_FcmW, pod_FcmH, pod_matral, pod_tiknes, pod_prtmtd, pod_clrfot, pod_clrbck, pod_finish, pod_matDsc, pod_tikDsc, pod_prtDsc, pod_rmtnce, pod_addres, pod_state, pod_cntry, pod_zip, pod_Tel, pod_cntper, pod_sctoqty, pod_qtyum, 
pod_curcde, pod_multip, pod_ordqty, pod_stkqty, pod_wasper, pod_wasqty, pod_ttlordqty, pod_untprc, pod_ttlamtqty, pod_receqty, pod_Reqno, pod_Reqseq, pod_Conmak,pod_bonqty, pod_InWas,pod_MOA, pod_creusr, pod_updusr, pod_credat, pod_upddat)

values 
(
@pod_cocde   , 
  @pod_ordno    ,
  @pod_seq    ,
  @pod_status  ,
   '' , --itemno
   '' , --tmpitmno
   '' , --venno
   '' , --venitm
   '' , --pckunt
   0 , --inrqty
   0 , --mtrqty
   0 , --cft  
   '' , --colcde
   '' , --ftyprctrm
   '' , --hkprctrm
    '' , --trantrm
  @pod_pkgitm  ,   
  @pod_pkgven  ,   
  @pod_cate ,   
  @pod_chndsc  ,   
 @pod_engdsc  ,   
  @pod_remark  ,   
@pod_EInchL     ,
     @pod_EInchW    , 
  @pod_EInchH     ,
  @pod_EcmL     ,
       @pod_EcmW    , 
     @pod_EcmH     ,
     @pod_FInchL     ,
    @pod_FinchW    , 
  @pod_FinchH     ,
   @pod_FcmL     ,
   @pod_FcmW    , 
  @pod_FcmH     ,
  @pod_matral     ,
   @pod_tiknes     ,
   @pod_prtmtd     ,
    @pod_clrfot    ,
    @pod_clrbck   ,  
 @pod_finish     ,
   @pod_matDsc  ,   
    @pod_tikDsc    ,
    @pod_prtDsc     ,
    @pod_rmtnce     ,
      @pod_addres     ,
      @pod_state    ,
   @pod_cntry    ,
@pod_zip     ,
 @pod_Tel     ,
 @pod_cntper  ,   
   @pod_sctoqty     ,
 'PC'    , -- Change default pc on 11/27/2014
@pod_curcde     ,
   @pod_multip     ,
  @pod_ordqty     ,
 @pod_stkqty     ,
 @pod_wper  ,                           
 @pod_wqty   ,  
 @pod_ttlordqty  ,   
@pod_untprc  ,   
 @pod_ttlamtqty  ,   
 @pod_receqty     ,
  @pod_Reqno     ,
  @pod_Reqseq     ,
 @pod_Conmak     ,
@pod_bonqty,
@pod_inwas, --pod_Inwas
0 , --pod_bonqty
@user ,
@user,
getdate(),
getdate()
)


end






GO
GRANT EXECUTE ON [dbo].[sp_insert_PKORDDTL_09] TO [ERPUSER] AS [dbo]
GO
