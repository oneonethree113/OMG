/****** Object:  StoredProcedure [dbo].[sp_insert_QCREQHDR]    Script Date: 09/29/2017 15:29:09 ******/
DROP PROCEDURE [dbo].[sp_insert_QCREQHDR]
GO
/****** Object:  StoredProcedure [dbo].[sp_insert_QCREQHDR]    Script Date: 09/29/2017 15:29:09 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO


Create  PROCEDURE [dbo].[sp_insert_QCREQHDR]

	@qch_cocde nvarchar(6), @qch_qcno nvarchar(20), @qch_qcsts nvarchar(5), @qch_flgautogen char(1), 
	
	--key
	@qch_venno varchar(12), @qch_prmcus nvarchar(6), @qch_seccus nvarchar(6), 
	@qch_inspyear int, @qch_inspweek int, @qch_insptyp nvarchar(15), 

	--Data
	@qch_mon char(1), @qch_tue char(1), @qch_wed char(1), @qch_thur char(1), @qch_fri char(1), @qch_sat char(1), @qch_sun char(1), 
	@qch_samhdl nvarchar(10), 
	@qch_sidate datetime, @qch_cydate datetime, @qch_cispdate datetime,
	@qch_rmk nvarchar(300), 
	
	@usr nvarchar(30)
AS
BEGIN
	Declare @cur_time as datetime
	set @cur_time = getdate()

	Insert into QCREQHDR (
		qch_cocde, qch_qcno, qch_qcsts, qch_flgautogen, 
		
		qch_venno,  qch_prmcus, qch_seccus, 
		qch_inspyear, qch_inspweek, qch_insptyp,
		
		qch_mon, qch_tue, qch_wed, qch_thur, qch_fri, qch_sat, qch_sun, 
		qch_samhdl, 
		qch_sidate, qch_cydate, qch_cispdate,
		qch_rmk, 

		qch_creusr, qch_updusr
	)
	SELECT
		@qch_cocde, @qch_qcno, @qch_qcsts, @qch_flgautogen,
		
		@qch_venno, @qch_prmcus, @qch_seccus, 
		@qch_inspyear, @qch_inspweek, @qch_insptyp,

		@qch_mon, @qch_tue, @qch_wed, @qch_thur, @qch_fri, @qch_sat, @qch_sun, 
		@qch_samhdl, 
		@qch_sidate, @qch_cydate, @qch_cispdate,
		@qch_rmk, 

		@usr, @usr
	
END


GO
GRANT EXECUTE ON [dbo].[sp_insert_QCREQHDR] TO [ERPUSER] AS [dbo]
GO
