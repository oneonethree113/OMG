/****** Object:  StoredProcedure [dbo].[sp_update_QCDFTIMG_filepath]    Script Date: 09/29/2017 15:29:08 ******/
DROP PROCEDURE [dbo].[sp_update_QCDFTIMG_filepath]
GO
/****** Object:  StoredProcedure [dbo].[sp_update_QCDFTIMG_filepath]    Script Date: 09/29/2017 15:29:10 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO

Create  PROCEDURE [dbo].[sp_update_QCDFTIMG_filepath]
@tmprptno nvarchar(20),
@dftseq int,
@dftcat nvarchar(10),
@imgseq int,
@filePath nvarchar(300)
AS
BEGIN  

update qcdftimg set qdt_filepath = @filePath, qdt_file = null where 
               qdt_tmprptno = @tmprptno and
				qdt_dftseq = @dftseq and 
				qdt_dftcat = @dftcat and
				qdt_imgseq = @imgseq

END

GO
GRANT EXECUTE ON [dbo].[sp_update_QCDFTIMG_filepath] TO [ERPUSER] AS [dbo]
GO
