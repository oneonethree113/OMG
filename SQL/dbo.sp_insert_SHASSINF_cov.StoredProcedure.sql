/****** Object:  StoredProcedure [dbo].[sp_insert_SHASSINF_cov]    Script Date: 09/29/2017 15:29:09 ******/
DROP PROCEDURE [dbo].[sp_insert_SHASSINF_cov]
GO
/****** Object:  StoredProcedure [dbo].[sp_insert_SHASSINF_cov]    Script Date: 09/29/2017 15:29:09 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO






CREATE      procedure [dbo].[sp_insert_SHASSINF_cov]
@hai_shpno  nvarchar(20) 	, 
@hai_shpseq  int, 
@hai_ordno  nvarchar(20) 	, 
@hai_ordseq  int, 
@hai_itmno  nvarchar(20) 	, 
@hai_assitm  nvarchar(20) 	, 
@hai_assdsc  nvarchar(800)  , 
@hai_cusitm  nvarchar(20)  , 
@hai_colcde  nvarchar(30) 	, 
@hai_coldsc  nvarchar(300)  , 
@hai_cussku  nvarchar(20)  , 
@hai_upcean  nvarchar(15)  , 
@hai_cusrtl  nvarchar(20)  , 
@hai_untcde  nvarchar(6) 	, 
@hai_inrqty  int, 
@hai_mtrqty  int, 
@hai_imperiod  datetime, 
@hai_cusstyno  nvarchar(30)   , 
@hai_tordno  nvarchar(20)   , 
@hai_tordseq  int  , 
@creusr		nvarchar(30)

as


insert into SHASSINF_cov
(	
hai_shpno ,
hai_shpseq , 
hai_ordno ,
hai_ordseq , 
hai_itmno ,
hai_assitm ,
hai_assdsc ,
hai_cusitm ,
hai_colcde ,
hai_coldsc ,
hai_cussku ,
hai_upcean ,
hai_cusrtl ,
hai_untcde ,
hai_inrqty , 
hai_mtrqty , 
hai_imperiod ,
hai_cusstyno ,
hai_tordno ,
hai_tordseq , 
hai_creusr,	hai_updusr,
	hai_credat,	hai_upddat
)
values
(	
@hai_shpno ,
@hai_shpseq , 
@hai_ordno ,
@hai_ordseq , 
@hai_itmno ,
@hai_assitm ,
@hai_assdsc ,
@hai_cusitm ,
@hai_colcde ,
@hai_coldsc ,
@hai_cussku ,
@hai_upcean ,
@hai_cusrtl ,
@hai_untcde ,
@hai_inrqty , 
@hai_mtrqty , 
@hai_imperiod ,
@hai_cusstyno ,
@hai_tordno ,
@hai_tordseq , 
@creusr,	@creusr,
	getdate(),	getdate()
)















GO
GRANT EXECUTE ON [dbo].[sp_insert_SHASSINF_cov] TO [ERPUSER] AS [dbo]
GO
