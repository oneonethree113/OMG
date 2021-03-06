/****** Object:  StoredProcedure [dbo].[sp_select_QCVENINF_QCAPP]    Script Date: 09/29/2017 15:29:09 ******/
DROP PROCEDURE [dbo].[sp_select_QCVENINF_QCAPP]
GO
/****** Object:  StoredProcedure [dbo].[sp_select_QCVENINF_QCAPP]    Script Date: 09/29/2017 15:29:10 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO


Create  PROCEDURE [dbo].[sp_select_QCVENINF_QCAPP]
	
AS
BEGIN


	SELECT 
		qvi_cocde
		,qvi_qcno
		,qvi_venno
		,qvi_adr
		,qvi_cty
		,qvi_stt
		,qvi_city
		,qvi_town
		,qvi_zip
		,qvi_cntctp
		,qvi_cnttil
		,qvi_cntphn
		,qvi_cntfax
		,qvi_cnteml
		,qvi_creusr
		,qvi_updusr
		,convert(char, qvi_credat,120) qvi_credat
		,convert(char, qvi_upddat,120) qvi_upddat
	FROM QCVENINF
	left join qcreqhdr
	ON qvi_qcno = qch_qcno
	WHERE qch_qcsts = 'REL'
	

END


GO
GRANT EXECUTE ON [dbo].[sp_select_QCVENINF_QCAPP] TO [ERPUSER] AS [dbo]
GO
