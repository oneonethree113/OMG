/****** Object:  StoredProcedure [dbo].[sp_select_QCREQDTL_QCAPP]    Script Date: 09/29/2017 15:29:09 ******/
DROP PROCEDURE [dbo].[sp_select_QCREQDTL_QCAPP]
GO
/****** Object:  StoredProcedure [dbo].[sp_select_QCREQDTL_QCAPP]    Script Date: 09/29/2017 15:29:10 ******/
SET ANSI_NULLS OFF
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[sp_select_QCREQDTL_QCAPP]
	
AS
BEGIN


SELECT
	qcd_cocde
	,qcd_qcno
	,qcd_qcseq
	,qcd_dtlsts
	,qcd_genby
	,qcd_flgpolink
	,qcd_qcposeq
	,qcd_purord
	,qcd_purseq
	,qcd_mon
	,qcd_tue
	,qcd_wed
	,qcd_thur
	,qcd_fri
	,qcd_sat
	,qcd_sun
	,qcd_samhdl
	,convert(char, qcd_sidate,120) qcd_sidate
	,convert(char, qcd_cydate,120) qcd_cydate
	,qcd_rmk
	,qcd_xitmno
	,qcd_xitmdsc
	,qcd_xcolor
	,qcd_xpack
	,qcd_xmtrdcm
	,qcd_xmtrwcm
	,qcd_xmtrhcm
	,qcd_xinrdcm
	,qcd_xinrwcm
	,qcd_xinrhcm
	,qcd_xgrswgt
	,qcd_xnetwgt
	,qcd_ordqty
	,qcd_schmon
	,qcd_schtue
	,qcd_schwed
	,qcd_schthur
	,qcd_schfri
	,qcd_schsat
	,qcd_schsun
	,qcd_person
	,convert(char, qcd_schdat,120) qcd_schdat
	,qcd_pid
	,qcd_creusr
	,qcd_updusr
	,convert(char, qcd_credat,120) qcd_credat
	,convert(char, qcd_upddat,120) qcd_upddat
FROM QCREQDTL
LEFT JOIN QCREQHDR 
	ON qch_cocde = qcd_cocde
	AND qch_qcno = qcd_qcno
WHERE qch_qcsts = 'REL'
and qch_inspweek > DATEPART(wk,GETDATE()) -3 and qch_inspyear = YEAR(GETDATE())

	
	
END






SET QUOTED_IDENTIFIER OFF 

GO
GRANT EXECUTE ON [dbo].[sp_select_QCREQDTL_QCAPP] TO [ERPUSER] AS [dbo]
GO
