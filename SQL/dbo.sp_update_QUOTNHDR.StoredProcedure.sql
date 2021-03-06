/****** Object:  StoredProcedure [dbo].[sp_update_QUOTNHDR]    Script Date: 09/29/2017 15:29:08 ******/
DROP PROCEDURE [dbo].[sp_update_QUOTNHDR]
GO
/****** Object:  StoredProcedure [dbo].[sp_update_QUOTNHDR]    Script Date: 09/29/2017 15:29:10 ******/
SET ANSI_NULLS OFF
GO
SET QUOTED_IDENTIFIER OFF
GO







/*	Author : Tommy Ho	*/

CREATE  PROCEDURE [dbo].[sp_update_QUOTNHDR] 

@quh_cocde	nvarchar(6),	@quh_qutno	nvarchar(20),	@quh_issdat	datetime,
@quh_rvsdat	datetime,		@quh_cus1no	nvarchar(6),	@quh_cus2no	nvarchar(6),
@quh_relatn	nvarchar(1),	@quh_cus1ad	nvarchar(200),	@quh_cus2ad	nvarchar(200),
@quh_cus1st	nvarchar(20),	@quh_cus1cy	nvarchar(6),	@quh_cus1zp	nvarchar(20),
@quh_cus2st	nvarchar(20),	@quh_cus2cy	nvarchar(6),	@quh_cus2zp	nvarchar(20),
@quh_cus1cp	nvarchar(50),	@quh_cus2cp	nvarchar(50),	@quh_salrep	nvarchar(30),
@quh_cusagt	nvarchar(6),	@quh_valdat	datetime,		@quh_smpprd	nvarchar(20),
@quh_smpfgt	nvarchar(20),	@quh_prctrm	nvarchar(6),	@quh_paytrm	nvarchar(6),	
@quh_curcde	nvarchar(6),	@quh_qutsts	nvarchar(10),	@quh_rmk		nvarchar(300),	
@quh_conalltopc	nvarchar(1),	@quh_Year	nvarchar(4),	@quh_Season 	nvarchar(100),
@quh_Desc 	nvarchar(255),	@quh_quplus 	numeric(13,4),	@quh_quminus 	numeric(13,4),
@quh_curexrat 	numeric(16,11),	@quh_curexeffdat 	datetime,		@quh_cugrptyp_int	nvarchar(20),
@quh_cugrptyp_ext	nvarchar(20),	@quh_dept		nvarchar(20),	@quh_saldivtem	nvarchar(20),
@quh_srname	nvarchar(30),	
@quh_ftyshpstr	 datetime,
@quh_ftyshpend 	datetime,
@quh_cushpstr 	datetime,
@quh_cushpend 	datetime,
@quh_creusr	nvarchar(30)


AS

UPDATE 	QUOTNHDR
SET	quh_rvsdat = getdate(),		quh_cus1no = @quh_cus1no,	quh_cus1ad = @quh_cus1ad,
	quh_cus1st = @quh_cus1st,	quh_cus1cy = @quh_cus1cy,	quh_cus1zp = @quh_cus1zp,
	quh_cus1cp = @quh_cus1cp,	quh_cus2no = @quh_cus2no,	quh_cus2ad = @quh_cus2ad,
	quh_cus2st = @quh_cus2st,	quh_cus2cy = @quh_cus2cy,	quh_cus2zp = @quh_cus2zp,
	quh_cus2cp = @quh_cus2cp,	quh_relatn = @quh_relatn,	quh_cusagt = @quh_cusagt,
	quh_salrep = @quh_salrep,	quh_smpprd = @quh_smpprd,	quh_smpfgt = @quh_smpfgt,
	quh_paytrm = @quh_paytrm,	quh_curcde = @quh_curcde,	quh_valdat = @quh_valdat,
	quh_qutsts = @quh_qutsts,	quh_upddat = getdate(),	quh_rmk = @quh_rmk,
	quh_conalltopc = @quh_conalltopc,quh_Year = @quh_Year,	quh_Season = @quh_Season,
	quh_Desc = @quh_Desc,	quh_prctrm = @quh_prctrm,	quh_curexrat = @quh_curexrat,	
	quh_curexeffdat = @quh_curexeffdat,	quh_cugrptyp_int = @quh_cugrptyp_int,	quh_cugrptyp_ext = @quh_cugrptyp_ext,
	quh_dept = @quh_dept,	quh_saldivtem = @quh_saldivtem,		quh_srname = @quh_srname,
	quh_ftyshpstr= @quh_ftyshpstr,quh_ftyshpend= @quh_ftyshpend,
	quh_cushpstr= @quh_cushpstr,quh_cushpend= @quh_cushpend,
	quh_updusr = @quh_creusr
WHERE	quh_cocde = @quh_cocde 	and
 	quh_qutno = @quh_qutno






GO
GRANT EXECUTE ON [dbo].[sp_update_QUOTNHDR] TO [ERPUSER] AS [dbo]
GO
