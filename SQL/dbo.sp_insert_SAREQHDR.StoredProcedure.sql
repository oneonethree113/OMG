/****** Object:  StoredProcedure [dbo].[sp_insert_SAREQHDR]    Script Date: 09/29/2017 15:29:09 ******/
DROP PROCEDURE [dbo].[sp_insert_SAREQHDR]
GO
/****** Object:  StoredProcedure [dbo].[sp_insert_SAREQHDR]    Script Date: 09/29/2017 15:29:09 ******/
SET ANSI_NULLS OFF
GO
SET QUOTED_IDENTIFIER OFF
GO




-- Checked by Allan Yuen at 28/07/2003

/*	Author	:	Tommy Ho	*/
/*	Date    	: 	29 Jan 2002	*/

CREATE PROCEDURE [dbo].[sp_insert_SAREQHDR] 

@srh_cocde	nvarchar(6),	@srh_reqno	nvarchar(20),	@srh_venno	nvarchar(6),
@srh_subcde	nvarchar(10),	@srh_venadr	nvarchar(200),	@srh_venstt	nvarchar(20),	
@srh_vencty	nvarchar(6),	@srh_venpst	nvarchar(20),	@srh_venctp	nvarchar(50),	
@srh_salrep	nvarchar(30),	@srh_cus1no	nvarchar(6),	@srh_cus2no	nvarchar(6),
@srh_prctrm	nvarchar(6),	@srh_rmk	nvarchar(300),	@srh_saltem	nvarchar(20),
@srh_saldiv	nvarchar(20),	@srh_salmgt	nvarchar(20),	@srh_srname    nvarchar(30),
@srh_creusr	nvarchar(30)


AS



	insert into [SAREQHDR]	(	
	srh_cocde ,	srh_reqno ,	srh_reqsts ,
	srh_issdat ,		srh_rvsdat ,	srh_venno ,
	srh_subcde  ,	srh_venadr ,	srh_venstt ,
	srh_vencty ,	srh_venpst ,	srh_venctp ,
	srh_salrep ,	srh_cus1no ,	srh_cus2no ,
	srh_cussmppo ,	srh_cusdeldat ,	srh_vendeldat ,
	srh_prctrm ,	srh_rmk ,	srh_saltem,
	srh_saldiv,	srh_salmgt ,	srh_srname,
	srh_creusr ,	srh_updusr ,	srh_credat ,	
	srh_upddat 
	)
	values
	(
	@srh_cocde ,	@srh_reqno ,	'A' ,
	getdate() ,		getdate() ,		@srh_venno ,
	@srh_subcde,	@srh_venadr ,	@srh_venstt ,
	@srh_vencty ,	@srh_venpst ,	@srh_venctp ,
	@srh_salrep ,	@srh_cus1no ,	@srh_cus2no ,
	'' ,		getdate() ,		getdate() ,	
	@srh_prctrm ,	@srh_rmk ,	@srh_saltem,
	@srh_saldiv ,	@srh_salmgt ,	@srh_srname,
	@srh_creusr ,	@srh_creusr ,	getdate() ,		
	getdate()
	)





GO
GRANT EXECUTE ON [dbo].[sp_insert_SAREQHDR] TO [ERPUSER] AS [dbo]
GO
