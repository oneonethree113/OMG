/****** Object:  StoredProcedure [dbo].[sp_check_QUAPPPDTL_PacknTerms]    Script Date: 09/29/2017 15:29:09 ******/
DROP PROCEDURE [dbo].[sp_check_QUAPPPDTL_PacknTerms]
GO
/****** Object:  StoredProcedure [dbo].[sp_check_QUAPPPDTL_PacknTerms]    Script Date: 09/29/2017 15:29:09 ******/
SET ANSI_NULLS OFF
GO
SET QUOTED_IDENTIFIER ON
GO



CREATE PROCEDURE [dbo].[sp_check_QUAPPPDTL_PacknTerms] 

@qxd_tmpqutno nvarchar(50) ,

@qxd_itmno nvarchar(30),

@qxd_um nvarchar(30),
@qxd_inr nvarchar(30),
@qxd_mtr nvarchar(30),
@qxd_prctrm nvarchar(30),
@qxd_trantrm nvarchar(30),
@qxd_ftyprctrm nvarchar(30)
AS

--Init Variables
DECLARE @flg_found nvarchar(1)

DECLARE @tmp_itmno nvarchar(30)
DECLARE @tmp_um nvarchar(30)
DECLARE @tmp_inr nvarchar(30)
DECLARE @tmp_mtr nvarchar(30)
DECLARE @tmp_prctrm nvarchar(30)
DECLARE @tmp_trantrm nvarchar(30)
DECLARE @tmp_ftyprctrm nvarchar(30)

SET @flg_found = 'N'


CREATE table [dbo].[#TMP_QUAPPDTL](
	[qxd_itmno] nvarchar(30),
	[qxd_tmpqutseq] INT,
	[qxd_um] nvarchar(30),
	[qxd_inr] nvarchar(30),
	[qxd_mtr] nvarchar(30),
	[qxd_prctrm] nvarchar(30),
	[qxd_trantrm] nvarchar(30),
	[qxd_ftyprctrm] nvarchar(30)
)

INSERT INTO [dbo].[#TMP_QUAPPDTL](
	qxd_itmno,
	qxd_um, qxd_inr, qxd_mtr, 
	qxd_prctrm, qxd_trantrm, qxd_ftyprctrm
)
SELECT
	qxd_itmno, 
	qxd_um, qxd_inr, qxd_mtr, 
	qxd_prctrm, qxd_trantrm, qxd_ftyprctrm
FROM QUAPPDTL
WHERE 
	qxd_tmpqutno = @qxd_tmpqutno


DECLARE CURSOR_KEY CURSOR FOR
	SELECT 
		qxd_itmno,
		qxd_um, qxd_inr, qxd_mtr, 
		qxd_prctrm, qxd_trantrm, qxd_ftyprctrm
	FROM [dbo].[#TMP_QUAPPDTL]
	
open CURSOR_KEY
FETCH NEXT 
FROM CURSOR_KEY INTO
	@tmp_itmno,
	@tmp_um, @tmp_inr, @tmp_mtr, 
	@tmp_prctrm, @tmp_trantrm, @tmp_ftyprctrm
	
WHILE @@FETCH_STATUS = 0
BEGIN
	IF(
		@qxd_itmno = @tmp_itmno AND
		@qxd_um = @tmp_um AND
		@qxd_inr = @tmp_inr AND
		@qxd_mtr = @tmp_mtr AND
		@qxd_prctrm = @tmp_prctrm AND
		@qxd_trantrm = @tmp_trantrm AND
		@qxd_ftyprctrm = @tmp_ftyprctrm
	)
	BEGIN
		SET @flg_found = 'Y'
		BREAK
	END

	FETCH NEXT 
	FROM CURSOR_KEY INTO
		@tmp_itmno,
		@tmp_um, @tmp_inr, @tmp_mtr, 
		@tmp_prctrm, @tmp_trantrm, @tmp_ftyprctrm


END

CLOSE CURSOR_KEY
DEALLOCATE CURSOR_KEY
DROP TABLE #TMP_QUAPPDTL
	
SELECT @flg_found as flg_found


GO
GRANT EXECUTE ON [dbo].[sp_check_QUAPPPDTL_PacknTerms] TO [ERPUSER] AS [dbo]
GO
