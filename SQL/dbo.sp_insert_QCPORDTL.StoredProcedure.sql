/****** Object:  StoredProcedure [dbo].[sp_insert_QCPORDTL]    Script Date: 09/29/2017 15:29:09 ******/
DROP PROCEDURE [dbo].[sp_insert_QCPORDTL]
GO
/****** Object:  StoredProcedure [dbo].[sp_insert_QCPORDTL]    Script Date: 09/29/2017 15:29:09 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO

Create  PROCEDURE [dbo].[sp_insert_QCPORDTL]
	--Basic
	@qpd_cocde nvarchar(6), @qpd_qcno nvarchar(20), @qpd_qcposeq int, @qpd_purord nvarchar(20), 
	
	@mon char, @tue char, @wed char, @thur char, @fri char, @sat char, @sun char, 
	--@qpd_samhdl nvarchar(10), @qpd_sidate datetime, @qpd_cydate datetime, 
	@qpd_rmk nvarchar(300), 
	
	--Basic
	@usr nvarchar(30)
AS
BEGIN

	Insert into QCPORDTL (
		qpd_cocde, qpd_qcno, qpd_qcposeq, qpd_purord,
		
		qpd_mon, qpd_tue, qpd_wed, qpd_thur, qpd_fri, qpd_sat, qpd_sun, 
		--qpd_samhdl, qpd_sidate, qpd_cydate, 
		qpd_rmk,
		
		qpd_creusr, qpd_updusr
	)
	SELECT
		@qpd_cocde, @qpd_qcno, @qpd_qcposeq, @qpd_purord,
		
		@mon, @tue, @wed, @thur, @fri, @sat, @sun,
		--@qpd_samhdl, @qpd_sidate, @qpd_cydate, 
		@qpd_rmk,
		
		@usr, @usr

	
END


GO
GRANT EXECUTE ON [dbo].[sp_insert_QCPORDTL] TO [ERPUSER] AS [dbo]
GO
