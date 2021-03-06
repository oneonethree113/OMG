/****** Object:  StoredProcedure [dbo].[sp_insert_IMNEGDAT]    Script Date: 09/29/2017 15:29:09 ******/
DROP PROCEDURE [dbo].[sp_insert_IMNEGDAT]
GO
/****** Object:  StoredProcedure [dbo].[sp_insert_IMNEGDAT]    Script Date: 09/29/2017 15:29:09 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO


--select * from IMNEGDAT
CREATE Procedure [dbo].[sp_insert_IMNEGDAT]
@cocde		varchar(6) ,
@vendorN		varchar(6) , 
@venItmN		varchar(30) , 
@umN		varchar(12) , 
@InnerN		int , 
@MasterN		int , 
@cftN		numeric(9,4) , 
@NegItmCostN	numeric(9,4) , 
@ChkDat 		varchar(30) ,
@Stage 		nvarchar(3) ,
@xlsfil  		nvarchar(30) , 
@gsUsrID		varchar(30) 
as
Begin

	insert into IMNEGDAT 
	(
		ind_Cocde , 
		ind_VenNo , 
		ind_VenItm , 
		ind_untcde , 
		ind_inrqty , 
		ind_mtrqty , 
		ind_cft , 
		ind_negcst , 
		ind_stage , 
		ind_xlsfil , 
		ind_chkdat , 
		ind_recseq , 
		ind_credat , 
		ind_creusr , 
		ind_upddat , 
		ind_updusr
	)
	select 
		@cocde , 
		@vendorN	, 
		@venItmN	, 
		@umN , 
		@InnerN , 
		@MasterN , 
		@cftN , 
		@NegItmCostN , 
		@Stage , 
		@xlsfil , 
		@ChkDat , 
		isnull(max(ind_recseq),0) + 1, 
		getdate() , 
		@gsUsrID , 
		getdate() , 
		@gsUsrID 
	from 
		IMNEGDAT (NOLOCK) 
	where 
		ind_cocde = @cocde
End







GO
GRANT EXECUTE ON [dbo].[sp_insert_IMNEGDAT] TO [ERPUSER] AS [dbo]
GO
