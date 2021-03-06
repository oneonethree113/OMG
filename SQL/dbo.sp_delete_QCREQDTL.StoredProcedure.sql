/****** Object:  StoredProcedure [dbo].[sp_delete_QCREQDTL]    Script Date: 09/29/2017 15:29:09 ******/
DROP PROCEDURE [dbo].[sp_delete_QCREQDTL]
GO
/****** Object:  StoredProcedure [dbo].[sp_delete_QCREQDTL]    Script Date: 09/29/2017 15:29:09 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO

Create  PROCEDURE [dbo].[sp_delete_QCREQDTL]
	--SET QCREQDTL qcd_dtlsts to 'DEL'
	--update QCREQHDR qch_qcsts to 'DEL' if all QCREQDTL qcd_dtlsts is 'DEL
	--update QCPORDTL qpd_del to 'Y' IF all related PO qcd_dtlsts is 'DEL'

	--Basic
	@qcd_cocde nvarchar(6), @qcd_qcno nvarchar(20), @qcd_qcseq int,
	@qcd_flgpolink char(1),  @qcd_qcposeq int, 
	--@qcd_purord nvarchar(20), @pod_purseq int, 
	@usr nvarchar(30)
	
	
AS
BEGIN
	Declare @cur_time as datetime
	set @cur_time = getdate()

	Declare @row_cnt as int
	Declare @row_cntdel as int
	Declare @POrow_cnt as int
	Declare @POrow_cntdel as int
	
	
	--Step 1
	UPDATE QCREQDTL 
	SET 
		qcd_dtlsts = 'DEL',
		qcd_updusr = @usr, 
		qcd_upddat = @cur_time
	WHERE 
		qcd_qcno = @qcd_qcno
	AND qcd_qcseq = @qcd_qcseq
	
	--Step 2
	IF @qcd_flgpolink = 'Y'
	BEGIN
		SELECT @POrow_cnt = count(*) from QCREQDTL where qcd_qcno = @qcd_qcno and qcd_qcposeq = @qcd_qcposeq
		SELECT @POrow_cntdel = count(*) from QCREQDTL where qcd_qcno = @qcd_qcno and qcd_qcposeq = @qcd_qcposeq and qcd_dtlsts = 'DEL'
		
		--Update QCPORDTL
		if @POrow_cnt = @POrow_cntdel
		BEGIN
			UPDATE QCPORDTL 
			SET 
				qpd_del = 'Y',
				qpd_updusr = @usr, 
				qpd_upddat = @cur_time
			
			WHERE 
				qpd_qcno = @qcd_qcno
			AND qpd_qcposeq = @qcd_qcposeq
		END
	END
		
	
	SELECT @row_cnt = count(*) from QCREQDTL WHERE qcd_qcno = @qcd_qcno
	SELECT @row_cntdel = count(*) from QCREQDTL WHERE qcd_qcno = @qcd_qcno and qcd_dtlsts = 'DEL'
	--Update QCREQHDR
	if @row_cnt = @row_cntdel
	BEGIN
		UPDATE QCREQHDR
		SET 
			qch_qcsts = 'DEL',
			qch_updusr = @usr, 
			qch_upddat = @cur_time
			
		WHERE qch_qcno = @qcd_qcno
	END
		
	
	
END


GO
GRANT EXECUTE ON [dbo].[sp_delete_QCREQDTL] TO [ERPUSER] AS [dbo]
GO
