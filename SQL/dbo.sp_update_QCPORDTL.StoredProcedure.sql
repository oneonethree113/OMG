/****** Object:  StoredProcedure [dbo].[sp_update_QCPORDTL]    Script Date: 09/29/2017 15:29:08 ******/
DROP PROCEDURE [dbo].[sp_update_QCPORDTL]
GO
/****** Object:  StoredProcedure [dbo].[sp_update_QCPORDTL]    Script Date: 09/29/2017 15:29:10 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO


Create  PROCEDURE [dbo].[sp_update_QCPORDTL]
	@qpd_cocde nvarchar(6), @qpd_qcno nvarchar(20), @qpd_qcposeq int, @qpd_del char(1),
	
	@qpd_mon char(1), @qpd_tue char(1), @qpd_wed char(1), @qpd_thur char(1), @qpd_fri char(1), @qpd_sat char(1), @qpd_sun char(1), 
	@qpd_rmk nvarchar(300),
	
	@qpd_updusr nvarchar(30)
AS
BEGIN


	UPDATE QCPORDTL
	SET
		qpd_cocde = @qpd_cocde,
		
		qpd_mon = @qpd_mon,
		qpd_tue = @qpd_tue,
		qpd_wed = @qpd_wed,
		qpd_thur = @qpd_thur,
		qpd_fri = @qpd_fri,
		qpd_sat = @qpd_sat,
		qpd_sun = @qpd_sun,
		qpd_rmk = @qpd_rmk, 
		
		qpd_del = @qpd_del, 
		
		
		qpd_upddat = getdate(),
		qpd_updusr = @qpd_updusr
		
	WHERE
		qpd_qcno = @qpd_qcno
	AND qpd_qcposeq = @qpd_qcposeq

	
END


GO
GRANT EXECUTE ON [dbo].[sp_update_QCPORDTL] TO [ERPUSER] AS [dbo]
GO
