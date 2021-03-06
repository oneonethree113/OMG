/****** Object:  StoredProcedure [dbo].[sp_select_QCREQHDR_QCAPP]    Script Date: 09/29/2017 15:29:09 ******/
DROP PROCEDURE [dbo].[sp_select_QCREQHDR_QCAPP]
GO
/****** Object:  StoredProcedure [dbo].[sp_select_QCREQHDR_QCAPP]    Script Date: 09/29/2017 15:29:10 ******/
SET ANSI_NULLS OFF
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[sp_select_QCREQHDR_QCAPP]
	
AS
BEGIN


	SELECT 
		qch_cocde
		,qch_qcno
		,qch_qcsts
		,qch_flgautogen
		,qch_verno
		,qch_verdoc
		,qch_venno
		,qch_prmcus
		,qch_seccus
		,qch_inspyear
		,qch_inspweek
		,qch_insptyp
		,convert(char, qch_cydate,120) qch_cydate
		,convert(char, qch_sidate,120) qch_sidate
		,convert(char, qch_cispdate,120) qch_cispdate
		,qch_mon
		,qch_tue
		,qch_wed
		,qch_thur
		,qch_fri
		,qch_sat
		,qch_sun
		,qch_samhdl
		,qch_rmk
		,qch_schmon
		,qch_schtue
		,qch_schwed
		,qch_schthur
		,qch_schfri
		,qch_schsat
		,qch_schsun
		,qch_person
		,qch_flgupload
		,convert(char, qch_uploadat,120) qch_uploadat
		,qch_creusr
		,qch_updusr
		,convert(char, qch_credat,120) qch_credat
		,convert(char, qch_upddat,120) qch_upddat
	FROM QCREQHDR
	WHERE qch_qcsts = 'REL'
	
	and qch_inspweek > DATEPART(wk,GETDATE()) -3 and qch_inspyear = YEAR(GETDATE())
END






SET QUOTED_IDENTIFIER OFF 

GO
GRANT EXECUTE ON [dbo].[sp_select_QCREQHDR_QCAPP] TO [ERPUSER] AS [dbo]
GO
