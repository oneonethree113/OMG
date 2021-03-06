/****** Object:  StoredProcedure [dbo].[sp_select_QCM00009_POULFILE2]    Script Date: 09/29/2017 15:29:09 ******/
DROP PROCEDURE [dbo].[sp_select_QCM00009_POULFILE2]
GO
/****** Object:  StoredProcedure [dbo].[sp_select_QCM00009_POULFILE2]    Script Date: 09/29/2017 15:29:10 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO




Create     procedure [dbo].[sp_select_QCM00009_POULFILE2]
@cocde as nvarchar(6) , 
@qcno as nvarchar(20) , 
@usrid as nvarchar(30)


as
begin

CREATE table #TEMP_ORDNO(tmp_ordno nvarchar(20), tmp_ordseq int , tmp_type nvarchar(1)) on [PRIMARY]
	
INSERT INTO #TEMP_ORDNO 
SELECT puf_ordno, puf_ordseq, puf_type
FROM POULFILE 
WHERE puf_ordno = @qcno
AND puf_act <> 'DEL'

INSERT INTO #TEMP_ORDNO
SELECT puf_ordno, puf_ordseq, puf_type
FROM QCREQHDR
LEFT JOIN QCPORDTL 
ON qch_qcno = qpd_qcno
INNER JOIN POULFILE
ON qpd_purord = puf_ordno
AND puf_act <> 'DEL'
WHERE
	qch_qcno = @qcno


--SELECT * FROM #TEMP_ORDNO
	
select 
	puf_ordno,
	puf_ordseq,
	puf_ordnoseq,
	puf_jobno,
	puf_filepath,
	puf_file,
	puf_creusr, 
	
	puf_type
from POULFILE 
INNER JOIN #TEMP_ORDNO
	ON puf_ordno = tmp_ordno 
	AND puf_ordseq = tmp_ordseq
	AND puf_type = tmp_type
where
--puf_ordno >= @poFm and puf_ordno <= @poTo 
	puf_act <> 'DEL'                


 end










GO
GRANT EXECUTE ON [dbo].[sp_select_QCM00009_POULFILE2] TO [ERPUSER] AS [dbo]
GO
