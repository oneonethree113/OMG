/****** Object:  StoredProcedure [dbo].[sp_select_QCM00003]    Script Date: 09/29/2017 15:29:09 ******/
DROP PROCEDURE [dbo].[sp_select_QCM00003]
GO
/****** Object:  StoredProcedure [dbo].[sp_select_QCM00003]    Script Date: 09/29/2017 15:29:10 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO

CREATE  PROCEDURE [dbo].[sp_select_QCM00003]
	@from nvarchar(20),
	@to nvarchar(20),
	@f nvarchar(1),	
	@r nvarchar(1), --Check Rights
	@usrid nvarchar(30)
AS
BEGIN
	IF @r = ""
	BEGIN
		SELECT
			qch_qcno, 
			qch_qcsts,
			qch_inspweek,
			qch_inspyear
		FROM QCREQHDR
		WHERE
			qch_qcno >= @from 
		and	qch_qcno <= @to 
		and len(rtrim(qch_qcno)) = len(rtrim(@from))	--check QC# length to bound the incorrect input
		--and qch_qcsts <> (case @f when 'Y' then 'OPE' else 'REL' end)
	END
	ELSE
	BEGIN
		SELECT 
			qch_qcno, 
			qch_qcsts,
			qch_inspweek,
			qch_inspyear
		FROM QCREQHDR
		LEFT JOIN CUBASINF 
			ON cbi_cusno = qch_prmcus
		WHERE
			qch_qcno >= @from 
		and	qch_qcno <= @to 
		and len(rtrim(qch_qcno)) = len(rtrim(@from))	--check QC# length to bound the incorrect input
		AND (
			EXISTS (
				select 1 from syusrright
				where yur_usrid = @usrid  and yur_doctyp = 'SC' and yur_lvl = 0
			) 
			OR cbi_saltem in (	
				select yur_para from syusrright
				where yur_usrid = @usrid and yur_doctyp = 'SC' and yur_lvl = 1
			) or cbi_cusno in 
			(
				select yur_para from syusrright
				where yur_usrid = @usrid and yur_doctyp = 'SC' and yur_lvl = 2
			)
		)	
	END
	
END


GO
GRANT EXECUTE ON [dbo].[sp_select_QCM00003] TO [ERPUSER] AS [dbo]
GO
