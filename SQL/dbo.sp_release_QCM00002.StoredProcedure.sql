/****** Object:  StoredProcedure [dbo].[sp_release_QCM00002]    Script Date: 09/29/2017 15:29:09 ******/
DROP PROCEDURE [dbo].[sp_release_QCM00002]
GO
/****** Object:  StoredProcedure [dbo].[sp_release_QCM00002]    Script Date: 09/29/2017 15:29:10 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO

CREATE  PROCEDURE [dbo].[sp_release_QCM00002]
	@qch_qcno nvarchar(20),
	@action nvarchar(1), 
	@usr nvarchar(30)
AS 
BEGIN

	DECLARE @cur_time as DATETIME
	SET @cur_time = getdate()
	
	declare @verno	as int
	set @verno= (select max(qch_verno) from QCREQHDR	WHERE	qch_qcno = @qch_qcno)
	declare @cocde	as nvarchar(6)
	set @cocde= (select top 1 qch_cocde from QCREQHDR	WHERE	qch_qcno = @qch_qcno)
	declare @oldsts	as nvarchar(5)
	set @oldsts= (select top 1 qch_qcsts from QCREQHDR	WHERE	qch_qcno = @qch_qcno)
	declare @insp_year 	as smallint
	set @insp_year= (select top 1 qch_inspyear from QCREQHDR	WHERE	qch_qcno = @qch_qcno)
	declare @insp_week 	as smallint
	set @insp_week= (select top 1 qch_inspweek from QCREQHDR	WHERE	qch_qcno = @qch_qcno)

	if @action = "R"
	BEGIN
		UPDATE QCREQHDR 
		SET 
			qch_qcsts = 'REL',
			qch_updusr = @usr,
			qch_upddat = @cur_time
		WHERE
			qch_qcno = @qch_qcno
		exec sp_insert_QCREQACT @cocde,@qch_qcno,@verno,@action ,@oldsts,'REL',@usr,@insp_year,@insp_week,''
	END
	ELSE IF @action = "U"
	BEGIN
		UPDATE QCREQHDR 
		SET 
			qch_qcsts = 'OPE',
			qch_verno = qch_verno +1,
			qch_updusr = @usr,
			qch_upddat = @cur_time
		WHERE
			qch_qcno = @qch_qcno
		exec sp_insert_QCREQACT @cocde,@qch_qcno,@verno,@action ,@oldsts,'OPE',@usr,@insp_year,@insp_week,''
	END
		
		
	--Update WEB DB
	--exec sp_upload_QC @qch_qcno, @cur_time	

	

END



GO
GRANT EXECUTE ON [dbo].[sp_release_QCM00002] TO [ERPUSER] AS [dbo]
GO
