/****** Object:  StoredProcedure [dbo].[sp_update_QCPORATT]    Script Date: 09/29/2017 15:29:08 ******/
DROP PROCEDURE [dbo].[sp_update_QCPORATT]
GO
/****** Object:  StoredProcedure [dbo].[sp_update_QCPORATT]    Script Date: 09/29/2017 15:29:10 ******/
SET ANSI_NULLS OFF
GO
SET QUOTED_IDENTIFIER OFF
GO


Create   procedure [dbo].[sp_update_QCPORATT]
	@qch_cocde nvarchar(6),
	@qch_qcno nvarchar(20), 
	@qpd_purord nvarchar(20)
AS

BEGIN
	UPDATE QCPORDTL
	SET qpd_verdoc = qch_verno
	FROM QCPORDTL
	INNER JOIN QCREQHDR
		ON qch_cocde = qpd_cocde
		AND qch_qcno = qpd_qcno
	WHERE
		qch_cocde = @qch_cocde
	AND qch_qcno = @qch_qcno
	AND qpd_purord = @qpd_purord
		
	
END


GO
GRANT EXECUTE ON [dbo].[sp_update_QCPORATT] TO [ERPUSER] AS [dbo]
GO
