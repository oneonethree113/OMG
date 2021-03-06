/****** Object:  StoredProcedure [dbo].[sp_copy_QCAttach]    Script Date: 09/29/2017 15:29:09 ******/
DROP PROCEDURE [dbo].[sp_copy_QCAttach]
GO
/****** Object:  StoredProcedure [dbo].[sp_copy_QCAttach]    Script Date: 09/29/2017 15:29:09 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO

Create  PROCEDURE [dbo].[sp_copy_QCAttach]
     @qcno nvarchar(20), 
     @qcno_new nvarchar(20),
     @puf_ordnoseq nvarchar(27)
AS
BEGIN

INSERT INTO POULFILE
(puf_cocde, puf_type, puf_ordno, puf_ordseq, puf_ordnoseq, puf_jobno, puf_filepath, puf_file, puf_athseq, puf_act, puf_creusr, puf_updusr)
SELECT puf_cocde, puf_type, @qcno_new, puf_ordseq, @puf_ordnoseq, puf_jobno, puf_filepath, puf_file, puf_athseq, puf_act, puf_creusr, puf_updusr
FROM POULFILE
WHERE 
     puf_ordno = @qcno 
AND puf_type = 'Q'
AND puf_act = 'ADD'
AND puf_file not like '%_REMARK.xlsx'

END

GO
GRANT EXECUTE ON [dbo].[sp_copy_QCAttach] TO [ERPUSER] AS [dbo]
GO
