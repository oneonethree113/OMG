/****** Object:  StoredProcedure [dbo].[sp_insert_GRNTRFDTL]    Script Date: 09/29/2017 15:29:09 ******/
DROP PROCEDURE [dbo].[sp_insert_GRNTRFDTL]
GO
/****** Object:  StoredProcedure [dbo].[sp_insert_GRNTRFDTL]    Script Date: 09/29/2017 15:29:09 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO






/*
=========================================================
Program ID	: sp_insert_GRNTRFDTL
Description   	: 
Programmer  	: Lester Wu
Create Date   	:
Last Modified  	: 
Table Read(s) 	:
Table Write(s) 	:
=========================================================
 Modification History                                    
=========================================================
Date			Author		Description
=========================================================     
2005-10-14	Lester Wu		Insert Cust UM and Dtl Remark field
*/
--sp_help GRNTRFDTL

CREATE Procedure [dbo].[sp_insert_GRNTRFDTL]
@cocde		varchar(6),
@Grd_GrnNo	varchar(20),
@Grd_Type	varchar(50) ,
@Grd_MpoNo	varchar(20) ,	
@Grd_RefNo	varchar(20),
@Grd_ItmNo	varchar(20) ,
@Grd_ItmNam	nvarchar(60) ,
@Grd_ItmDsc	nvarchar(50) ,
@Grd_Curr	varchar(6) ,
@Grd_UntPrc	numeric(13,4) ,    
@Grd_Color	nvarchar(30) ,
@Grd_CustCat	nvarchar(20) ,
@Grd_Cty		nvarchar(20) ,	     
@Grd_CTNFm	varchar(20) ,
@Grd_CTNTo	varchar(20) ,
@Grd_TtlCTN	numeric(13,0) ,    
@Grd_CtnUM	nvarchar(30) ,
@Grd_GW	numeric(13,4) ,    
@Grd_NW	numeric(13 ,4) ,    
@Grd_TtlGW	numeric(13,4) ,    
@Grd_TtlNW	numeric(13,4) ,    
@Grd_PckWgt	numeric(18,4) ,    
@Grd_PckUM	nvarchar(30) ,
@Grd_Grp		nvarchar(40) ,
@Grd_TtlShpQty	numeric(13,2) ,    
@Grd_ShpUM	nvarchar(30) ,
@Grd_RevDept	nvarchar(50) ,
@Grd_CustUM	nvarchar(30) , 
@Grd_DtlRmk	nvarchar(300) , 
@Grd_CustQty	numeric(13,4) ,    
@Grd_PrtGrp		int,	-- Frankie Cheung 20091015
@UsrID		varchar(30)
as
BEGIN

	Declare	
		@Row_Idx		int,
		@Err_Idx			int

	Begin Tran

		INSERT INTO
			GRNTRFDTL
				(
				Grd_GrnNo , 
				Grd_Seq , 
				Grd_Type , 
				Grd_MpoNo , 
				Grd_RefNo,
				Grd_ItmNo , 
				Grd_ItmNam , 
				Grd_ItmDsc , 
				Grd_Color , 
				Grd_Curr , 
				Grd_UntPrc , 
				Grd_TtlShpQty , 
				Grd_ShpUM , 
				Grd_RevDept , 
				Grd_CustCat , 
				Grd_Cty , 
				Grd_CTNFm , 
				Grd_CTNTo , 
				Grd_TtlCTN , 
				Grd_CtnUM , 
				Grd_GW , 
				Grd_NW , 
				Grd_TtlGW , 
				Grd_TtlNW , 
				Grd_PckWgt , 
				Grd_PckUM , 
				Grd_Grp , 
				-- Lestser Wu 2005-10-14				
				Grd_CustUM ,
				Grd_DtlRmk , 
				-------------------------------
				Grd_CreUsr , 
				Grd_CreDat , 
				Grd_UpdUsr , 
				Grd_UpdDat ,
				Grd_CustQty,
				Grd_PrtGrp
				)
		Select
			@Grd_GrnNo , 
			isnull(max(Grd_Seq),0) + 1 ,
			@Grd_Type , 
			@Grd_MpoNo , 
			@Grd_RefNo,
			@Grd_ItmNo , 
			@Grd_ItmNam , 
			@Grd_ItmDsc , 
			@Grd_Color , 
			@Grd_Curr , 
			@Grd_UntPrc , 
			@Grd_TtlShpQty , 
			@Grd_ShpUM , 
			@Grd_RevDept , 
			@Grd_CustCat , 
			@Grd_Cty , 
			@Grd_CTNFm , 
			@Grd_CTNTo , 
			@Grd_TtlCTN , 
			@Grd_CtnUM , 
			@Grd_GW , 
			@Grd_NW , 
			@Grd_TtlGW , 
			@Grd_TtlNW , 
			@Grd_PckWgt , 
			@Grd_PckUM , 
			@Grd_Grp , 
			-- Lestser Wu 2005-10-14				
			@Grd_CustUM ,
			@Grd_DtlRmk , 
			-------------------------------
			@UsrID , 
			Getdate() , 
			@UsrID , 
			Getdate(),
			@Grd_CustQty,
			@Grd_PrtGrp	
		From
			GRNTRFDTL 
		Where 
			Grd_GrnNo = @Grd_GrnNo


	select @Err_Idx = @@error, @Row_Idx = @@RowCount

	if @Err_Idx = 0 
	begin
		commit tran
		select max(Grd_Seq) from GRNTRFDTL where Grd_GrnNo = @Grd_GrnNo
	end
	else
	begin
		rollback tran
		return (@Err_Idx)
	end


END


GO
GRANT EXECUTE ON [dbo].[sp_insert_GRNTRFDTL] TO [ERPUSER] AS [dbo]
GO
