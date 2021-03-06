/****** Object:  StoredProcedure [dbo].[sp_update_PKIMBAIF]    Script Date: 09/29/2017 15:29:08 ******/
DROP PROCEDURE [dbo].[sp_update_PKIMBAIF]
GO
/****** Object:  StoredProcedure [dbo].[sp_update_PKIMBAIF]    Script Date: 09/29/2017 15:29:10 ******/
SET ANSI_NULLS OFF
GO
SET QUOTED_IDENTIFIER OFF
GO









CREATE procedure [dbo].[sp_update_PKIMBAIF]
                                                                                                                                                                                                                                                                 

	@pib_pgitmno  nvarchar(20),
	@pib_cate nvarchar(10), 
	@pib_year nvarchar(4),
	@pib_status nvarchar(10),
	@pib_chndsc nvarchar(200),
	@pib_engdsc nvarchar(200),
	@pib_remark nvarchar(200),
	@pib_EInchL numeric(13,4),  
	@pib_EInchW numeric(13,4),
	@pib_EInchH numeric(13,4), 
	@pib_EcmL numeric(13,4), 
	@pib_EcmW numeric(13,4),
	@pib_EcmH numeric(13,4),
	@pib_FInchL numeric(13,4),
	@pib_FInchW numeric(13,4),
	@pib_FInchH numeric(13,4), 
	@pib_FcmL numeric(13,4), 
	@pib_FcmW numeric(13,4),
	@pib_FcmH numeric(13,4),
	@pib_cus1no nvarchar(6),
	@pib_cus2no nvarchar(6),
	@pib_matral nvarchar(100), 
	@pib_tiknes nvarchar(100), 
	@pib_prtmtd nvarchar(100), 
	@pib_clrfot nvarchar(100), 
	@pib_clrbck nvarchar(100),
	@pib_finish nvarchar(500), 
	@pib_matDsc nvarchar(300),
	@pib_tikDsc nvarchar(300),
	@pib_prtDsc nvarchar(300),
	@pib_barcde nvarchar(10),
	@pib_img nvarchar(200), 
	@pib_season nvarchar(20),
	@pib_estflg	char(1),
	@user nvarchar(30) 
 
AS

begin

update PKIMBAIF
set  pib_status = @pib_status ,
	pib_chndsc = @pib_chndsc , 
	 pib_engdsc = @pib_engdsc , 
	 pib_remark = @pib_remark , 
	 pib_EInchL  =@pib_EInchL , 
	 pib_EInchW = @pib_EInchW , 
	 pib_EInchH = @pib_EInchH , 
	 pib_EcmL  =  @pib_EcmL , 
	pib_EcmW  = @pib_EcmW , 
	 pib_EcmH  = @pib_EcmH  , 
	 pib_FInchL =  @pib_FInchL  ,
	 pib_FInchW   = @pib_FInchW  ,
	 pib_FInchH  = @pib_FInchH ,
	 pib_FcmL  =  @pib_FcmL ,
	pib_FcmW  = @pib_FcmW ,
	pib_FcmH  = @pib_FcmH  ,
	pib_cus1no   = @pib_cus1no    ,
	pib_cus2no  = @pib_cus2no  ,
	pib_matral   = @pib_matral  ,
	pib_tiknes   = @pib_tiknes  ,
	pib_prtmtd  = @pib_prtmtd ,
	pib_clrfot   = @pib_clrfot   ,
	pib_clrbck  = @pib_clrbck ,
	pib_finish  = @pib_finish  ,
	pib_matDsc = @pib_matDsc ,
	pib_tikDsc  = @pib_tikDsc ,
	pib_prtDsc = @pib_prtDsc ,
	pib_barcde  = @pib_barcde   ,
	pib_img   = @pib_img   ,
	pib_season = @pib_season,
	pib_estflg = @pib_estflg,
	pib_updusr  = @user ,
	pib_upddat = getdate()
where  pib_pgitmno = @pib_pgitmno 

end












GO
GRANT EXECUTE ON [dbo].[sp_update_PKIMBAIF] TO [ERPUSER] AS [dbo]
GO
