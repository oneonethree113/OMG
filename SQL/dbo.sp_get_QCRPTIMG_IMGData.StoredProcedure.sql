/****** Object:  StoredProcedure [dbo].[sp_get_QCRPTIMG_IMGData]    Script Date: 09/29/2017 15:29:09 ******/
DROP PROCEDURE [dbo].[sp_get_QCRPTIMG_IMGData]
GO
/****** Object:  StoredProcedure [dbo].[sp_get_QCRPTIMG_IMGData]    Script Date: 09/29/2017 15:29:09 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO

Create  PROCEDURE [dbo].[sp_get_QCRPTIMG_IMGData]
@tmprptno nvarchar(20),
@inspcde nvarchar(30),
@imgseq int
AS
BEGIN  
select qri_file from qcrptimg where 
        qri_tmprptno = @tmprptno and
        qri_inspcde = @inspcde and 
        qri_imgseq = @imgseq
END

GO
GRANT EXECUTE ON [dbo].[sp_get_QCRPTIMG_IMGData] TO [ERPUSER] AS [dbo]
GO
