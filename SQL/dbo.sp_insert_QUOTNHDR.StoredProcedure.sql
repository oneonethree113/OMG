/****** Object:  StoredProcedure [dbo].[sp_insert_QUOTNHDR]    Script Date: 09/29/2017 15:29:09 ******/
DROP PROCEDURE [dbo].[sp_insert_QUOTNHDR]
GO
/****** Object:  StoredProcedure [dbo].[sp_insert_QUOTNHDR]    Script Date: 09/29/2017 15:29:09 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO




CREATE  PROCEDURE [dbo].[sp_insert_QUOTNHDR] 

@quh_cocde	nvarchar(6),	@quh_qutno	nvarchar(20),	@quh_issdat	datetime,
@quh_rvsdat	datetime,		@quh_cus1no	nvarchar(6),	@quh_cus2no	nvarchar(6),
@quh_relatn	nvarchar(1),	@quh_cus1ad	nvarchar(200),	@quh_cus2ad	nvarchar(200),
@quh_cus1st	nvarchar(20),	@quh_cus1cy	nvarchar(6),	@quh_cus1zp	nvarchar(20),
@quh_cus2st	nvarchar(20),	@quh_cus2cy	nvarchar(6),	@quh_cus2zp	nvarchar(20),
@quh_cus1cp	nvarchar(50),	@quh_cus2cp	nvarchar(50),	@quh_salrep	nvarchar(30),
@quh_cusagt	nvarchar(6),	@quh_valdat	datetime,		@quh_smpprd	nvarchar(20),
@quh_smpfgt	nvarchar(20),	@quh_prctrm	nvarchar(6),	@quh_paytrm	nvarchar(6),	
@quh_curcde	nvarchar(6),	@quh_qutsts	nvarchar(10),	@quh_rmk		nvarchar(300),	
@quh_conalltopc	nvarchar(1),	@quh_Year	nvarchar(4),	@quh_Season	nvarchar(100),
@quh_Desc	nvarchar(255),	@quh_quplus	numeric(13,4),	@quh_quminus	numeric(13,4),
@quh_curexrat	numeric(16,11),	@quh_curexeffdat	datetime,		@quh_cugrptyp_int	nvarchar(20),
@quh_cugrptyp_ext	nvarchar(20),	@quh_dept		nvarchar(20),	@quh_saldivtem	nvarchar(20),
@quh_srname	nvarchar(30),	
@quh_ftyshpstr	 datetime,
@quh_ftyshpend 	datetime,
@quh_cushpstr 	datetime,
@quh_cushpend 	datetime,
@quh_creusr	nvarchar(30)

AS

insert into [QUOTNHDR] (
	quh_cocde ,	quh_qutno ,	quh_issdat ,
	quh_rvsdat ,	quh_qutsts ,	quh_cus1no ,
	quh_cus2no ,	quh_relatn ,	quh_cus1ad ,
	quh_cus2ad ,	quh_cus1st ,	quh_cus1cy ,
	quh_cus1zp ,	quh_cus2st ,	quh_cus2cy ,
	quh_cus2zp ,	quh_cus1cp ,	quh_cus2cp ,
	quh_salrep ,	quh_cusagt ,	quh_valdat ,
	quh_smpprd ,	quh_smpfgt ,	quh_paytrm ,
	quh_relcnt ,	quh_curcde ,	quh_creusr ,
	quh_updusr ,	quh_credat ,	quh_upddat ,
	quh_rmk , 		quh_conalltopc ,	quh_Year  ,
	quh_Season  ,	quh_Desc ,		quh_quplus,
	quh_quminus,	quh_curexrat ,	quh_curexeffdat ,
	quh_prctrm,	quh_cugrptyp_int,	quh_cugrptyp_ext,
	quh_dept,		quh_saldivtem,	quh_srname,
	quh_ftyshpstr ,quh_ftyshpend  ,
	quh_cushpstr ,quh_cushpend 
	)
values (
	@quh_cocde ,	@quh_qutno ,	getdate() ,
	getdate() ,		@quh_qutsts ,	@quh_cus1no ,
	@quh_cus2no ,	@quh_relatn ,	@quh_cus1ad ,
	@quh_cus2ad ,	@quh_cus1st ,	@quh_cus1cy ,
	@quh_cus1zp ,	@quh_cus2st ,	@quh_cus2cy ,
	@quh_cus2zp ,	@quh_cus1cp ,	@quh_cus2cp ,
	@quh_salrep ,	@quh_cusagt ,	@quh_valdat ,
	@quh_smpprd ,	@quh_smpfgt ,	@quh_paytrm ,
	0 ,		@quh_curcde ,	@quh_creusr ,
	@quh_creusr ,	getdate() ,		getdate() ,
	@quh_rmk ,	@quh_conalltopc ,	@quh_Year  ,
	@quh_Season  ,	@quh_Desc ,	@quh_quplus ,
	@quh_quminus ,	@quh_curexrat ,	@quh_curexeffdat ,
	@quh_prctrm,	@quh_cugrptyp_int,	@quh_cugrptyp_ext,
	@quh_dept,	@quh_saldivtem,	@quh_srname,
	@quh_ftyshpstr ,@quh_ftyshpend  ,
	@quh_cushpstr ,@quh_cushpend 
)






GO
GRANT EXECUTE ON [dbo].[sp_insert_QUOTNHDR] TO [ERPUSER] AS [dbo]
GO
