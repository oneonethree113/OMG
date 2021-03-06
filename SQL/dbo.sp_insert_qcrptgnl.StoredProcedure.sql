/****** Object:  StoredProcedure [dbo].[sp_insert_qcrptgnl]    Script Date: 09/29/2017 15:29:09 ******/
DROP PROCEDURE [dbo].[sp_insert_qcrptgnl]
GO
/****** Object:  StoredProcedure [dbo].[sp_insert_qcrptgnl]    Script Date: 09/29/2017 15:29:09 ******/
SET ANSI_NULLS OFF
GO
SET QUOTED_IDENTIFIER ON
GO



CREATE PROCEDURE [dbo].[sp_insert_qcrptgnl] 
	@qrg_tmprptno nvarchar(20), 
	@qrg_inspcde nvarchar(30), 
	@qrg_result nvarchar(100), 
	@qrg_detail nvarchar(500), 
	@qrg_creusr nvarchar(30), 
	@qrg_updusr nvarchar(30)
AS BEGIN
	Declare @cur_time as datetime
	set @cur_time = getdate()

	insert into QCRPTGNL(
		qrg_tmprptno, qrg_inspcde, qrg_result, qrg_detail, 
		qrg_creusr, qrg_updusr, qrg_credat, qrg_upddat
	) SELECT
		@qrg_tmprptno, @qrg_inspcde, @qrg_result, @qrg_detail, 
		@qrg_creusr, @qrg_updusr, @cur_time, @cur_time


END




GO
