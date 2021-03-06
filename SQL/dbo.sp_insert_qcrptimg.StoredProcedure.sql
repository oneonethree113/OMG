/****** Object:  StoredProcedure [dbo].[sp_insert_qcrptimg]    Script Date: 09/29/2017 15:29:09 ******/
DROP PROCEDURE [dbo].[sp_insert_qcrptimg]
GO
/****** Object:  StoredProcedure [dbo].[sp_insert_qcrptimg]    Script Date: 09/29/2017 15:29:09 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO




CREATE PROCEDURE [dbo].[sp_insert_qcrptimg] 
	@qri_tmprptno nvarchar(20), 
	@qri_inspcde nvarchar(30), 
	@qri_imgseq int, 
	@qri_filepath nvarchar(300), 
	@qri_file nvarchar(MAX),
	@qri_creusr nvarchar(30), 
	@qri_updusr nvarchar(30)

	
AS BEGIN
	Declare @cur_time as datetime
	set @cur_time = getdate()

	insert into QCRPTIMG(
		qri_tmprptno, qri_inspcde, qri_imgseq, qri_filepath, 
		qri_file, 
		qri_creusr, qri_updusr, qri_credat, qri_upddat
	) SELECT
		@qri_tmprptno, @qri_inspcde, @qri_imgseq, @qri_filepath, 
		cast(N'' as xml).value('xs:base64Binary(sql:variable("@qri_file"))', 'varbinary(max)'),
		@qri_creusr, @qri_updusr, @cur_time, @cur_time

END




GO
