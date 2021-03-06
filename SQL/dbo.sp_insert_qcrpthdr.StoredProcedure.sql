/****** Object:  StoredProcedure [dbo].[sp_insert_qcrpthdr]    Script Date: 09/29/2017 15:29:09 ******/
DROP PROCEDURE [dbo].[sp_insert_qcrpthdr]
GO
/****** Object:  StoredProcedure [dbo].[sp_insert_qcrpthdr]    Script Date: 09/29/2017 15:29:09 ******/
SET ANSI_NULLS OFF
GO
SET QUOTED_IDENTIFIER ON
GO



CREATE PROCEDURE [dbo].[sp_insert_qcrpthdr] 
	@qrh_tmprptno nvarchar(20), @qrh_rptno nvarchar(20), 
	@qrh_rpttyp nvarchar(15) , @qrh_insptime int, @qrh_reqflg char(1) , 
	@qrh_rptstatus nvarchar(20),
	@qrh_qcno nvarchar(20) , 
	@qrh_venno nvarchar(12) , @qrh_venadr nvarchar(200) ,@qrh_cus1no nvarchar(6) , @qrh_cus2no nvarchar(6) , 
	@qrh_itmno nvarchar(20) , @qrh_cusitm nvarchar(20) , 
	@qrh_postr nvarchar(1000) , @qrh_cuspostr nvarchar(500) ,  @qrh_itmdsc nvarchar(800), 
	
	@qrh_inspdat datetime, @qrh_morepo nvarchar(1000), 
	
	@qrh_othvensna nvarchar(30), @qrh_othcustomer nvarchar(30), @qrh_othitmno nvarchar(20), 
	@qrh_othcusitm nvarchar(20), @qrh_othpostr nvarchar(200), @qrh_othcuspostr nvarchar(200), 
	
	@qrh_mailflg char(1) , @qrh_mailsender nvarchar(500), 
	
	@qrh_uploadflg char(1), --Upload Control

	@qrh_creusr nvarchar(30), @qrh_updusr nvarchar(30),

	@qrh_inspresult nvarchar(20)
AS BEGIN
	Declare @cur_time as datetime
	set @cur_time = getdate()
	
	INSERT INTO QCRPTHDR(
		qrh_tmprptno, qrh_rptno, 
		qrh_rpttyp, qrh_insptime, qrh_reqflg, 
		qrh_rptstatus,
		qrh_qcno, qrh_venno, qrh_venadr, qrh_cus1no, qrh_cus2no, 
		qrh_itmno, qrh_cusitm, 
		qrh_postr, qrh_cuspostr, qrh_itmdsc, 
		
		qrh_inspdat, qrh_morepo, 
		qrh_othvensna, qrh_othcustomer, qrh_othitmno, 
		qrh_othcusitm, qrh_othpostr, qrh_othcuspostr, 
		
		qrh_mailflg, qrh_mailsender, 
		qrh_uploadflg, 
		
		qrh_creusr, qrh_updusr, qrh_credat, qrh_upddat,

		qrh_inspresult
	) SELECT
		@qrh_tmprptno, @qrh_rptno, 
		@qrh_rpttyp, @qrh_insptime, @qrh_reqflg, 
		@qrh_rptstatus,
		@qrh_qcno, @qrh_venno, @qrh_venadr, @qrh_cus1no, @qrh_cus2no, 
		@qrh_itmno, @qrh_cusitm, 
		@qrh_postr, @qrh_cuspostr, @qrh_itmdsc, 
		
		@qrh_inspdat, @qrh_morepo, 
		@qrh_othvensna, @qrh_othcustomer, @qrh_othitmno, 
		@qrh_othcusitm, @qrh_othpostr, @qrh_othcuspostr, 
		
		@qrh_mailflg, @qrh_mailsender, 
		@qrh_uploadflg, 
		
		@qrh_creusr, @qrh_updusr, @cur_time, @cur_time,

		@qrh_inspresult

END




GO
GRANT EXECUTE ON [dbo].[sp_insert_qcrpthdr] TO [ERPUSER] AS [dbo]
GO
