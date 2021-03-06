/****** Object:  StoredProcedure [dbo].[sp_update_QCM00002_cancelQC]    Script Date: 09/29/2017 15:29:08 ******/
DROP PROCEDURE [dbo].[sp_update_QCM00002_cancelQC]
GO
/****** Object:  StoredProcedure [dbo].[sp_update_QCM00002_cancelQC]    Script Date: 09/29/2017 15:29:10 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO

CREATE  PROCEDURE [dbo].[sp_update_QCM00002_cancelQC]
	@QCNo nvarchar(20), 
	@usr nvarchar(30)
AS
BEGIN
	--UPDATE QCREQDTL & QCREQHDR status to Cancel ('CAN')
	declare @action nvarchar(1)
	set @action ='C'
	
	declare @verno	as int
	set @verno= (select max(qch_verno) from QCREQHDR	WHERE	qch_qcno = @QCNo)
	declare @oldsts	as nvarchar(5)
	set @oldsts= (select top 1 qch_qcsts from QCREQHDR	WHERE	qch_qcno = @QCNo)
	declare @cocde	as nvarchar(6)
	set @cocde= (select top 1 qch_cocde from QCREQHDR	WHERE	qch_qcno = @QCNo)
	declare @insp_year 	as smallint
	set @insp_year= (select top 1 qch_inspyear from QCREQHDR	WHERE	qch_qcno = @QCNo)
	declare @insp_week 	as smallint
	set @insp_week= (select top 1 qch_inspweek from QCREQHDR	WHERE	qch_qcno = @QCNo)

	UPDATE QCREQHDR
	SET
		qch_qcsts = 'CAN'
	WHERE
		qch_qcno = @QCNo

	UPDATE QCREQDTL
	SET
		qcd_dtlsts = 'CAN'
	WHERE qcd_qcno = @QCNo
	
	exec sp_insert_QCREQACT @cocde,@QCNo,@verno,@action ,@oldsts,'CAN',@usr,@insp_year,@insp_week,''

END



GO
GRANT EXECUTE ON [dbo].[sp_update_QCM00002_cancelQC] TO [ERPUSER] AS [dbo]
GO
