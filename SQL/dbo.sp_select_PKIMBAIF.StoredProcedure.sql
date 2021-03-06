/****** Object:  StoredProcedure [dbo].[sp_select_PKIMBAIF]    Script Date: 09/29/2017 15:29:09 ******/
DROP PROCEDURE [dbo].[sp_select_PKIMBAIF]
GO
/****** Object:  StoredProcedure [dbo].[sp_select_PKIMBAIF]    Script Date: 09/29/2017 15:29:10 ******/
SET ANSI_NULLS OFF
GO
SET QUOTED_IDENTIFIER OFF
GO









CREATE procedure [dbo].[sp_select_PKIMBAIF]
                                                                                                                                                                                                                                                                 

 @pib_pgitmno nvarchar(20)
 
AS

begin

Select	 
pib_pgitmno ,
	pib_cate ,
	ypc_pakna, 
	pib_year,
	pib_status ,
	pib_chndsc ,
	pib_engdsc ,
	pib_remark ,
	pib_EInchL ,  
	pib_EInchW ,
	pib_EInchH , 
	pib_EcmL , 
	pib_EcmW ,
	pib_EcmH ,
	pib_FInchL ,
	pib_FInchW ,
	pib_FInchH , 
	pib_FcmL , 
	pib_FcmW ,
	pib_FcmH ,
	pib_cus1no ,
	pib_cus2no ,
	pib_matral , 
	pib_tiknes , 
	pib_prtmtd , 
	pib_clrfot , 
	pib_clrbck ,
	pib_finish , 
	pib_matDsc,
	pib_tikDsc,
	pib_prtDsc,
	pib_barcde ,
	pib_img , 
	pib_season,
	isnull(pib_estflg,'') as 'pib_estflg',
	pib_creusr , 
	pib_updusr , 
	pib_credat , 
	pib_upddat 
from PKIMBAIF
left join SYPAKCAT on pib_cate = ypc_code
where pib_pgitmno = @pib_pgitmno



end











GO
GRANT EXECUTE ON [dbo].[sp_select_PKIMBAIF] TO [ERPUSER] AS [dbo]
GO
