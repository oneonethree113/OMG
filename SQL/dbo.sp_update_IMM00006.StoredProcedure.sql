/****** Object:  StoredProcedure [dbo].[sp_update_IMM00006]    Script Date: 09/29/2017 15:29:08 ******/
DROP PROCEDURE [dbo].[sp_update_IMM00006]
GO
/****** Object:  StoredProcedure [dbo].[sp_update_IMM00006]    Script Date: 09/29/2017 15:29:10 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO





/*
======================================================
Program ID	: sp_update_IMM00006
Description	: update design vendor in IMBASINF,IMVENPCK,IMVENINF,IMMRKUP
Programmer	: Lester Wu
Create Date		: 14th Sep , 2004
Table Read(s)	: 
Table Write(s)	: IMBASINF,IMVENPCK,IMVENINF,IMMRKUP
======================================================
Modification History
======================================================
Date		Initial		Description
2005-05-23	Allan Yuen		Add Custom Vendor
======================================================


sp_update_IMM00006 'ucpp','43949802','C','A','mis'

*/

CREATE procedure [dbo].[sp_update_IMM00006]
@cocde	nvarchar(6),
@itmno	nvarchar(20),
@oriven	nvarchar(6),
@newven	nvarchar(6),
@old_cusven varchar(6),
@new_cusven varchar(6),
@usrid	nvarchar(30)
as
begin

--declare a variable to store the error code
declare @errcde as int
declare @rowcnt as int
declare @str as nvarchar(400)

declare	@TMPVEN		AS NVARCHAR(6),
	@CNT_DPVEN_MATCH	AS INT,
	@CNT_PVEN_MATCH	AS INT,
	@CNT_DVEN_MATCH	AS INT,
	@CNT_IMVENINF		AS INT,
	@CNT_IMVENPCK		AS INT,
	@CNT_IMBASINF		AS INT

SET @TMPVEN=@newven + '*'



if ltrim(rtrim(@newven)) <> ''
begin
	BEGIN TRANSACTION

	--IMMRKUP
	SELECT 
		@CNT_DPVEN_MATCH = SUM(CASE WHEN IMU_VENNO=@oriven AND IMU_PRDVEN=@oriven THEN 1 ELSE 0 END),
		@CNT_PVEN_MATCH = SUM(CASE WHEN IMU_PRDVEN=@newven THEN 1 ELSE 0 END),
		@CNT_DVEN_MATCH = SUM(CASE WHEN IMU_VENNO=@oriven AND IMU_PRDVEN<>@oriven THEN 1 ELSE 0 END)

	FROM IMMRKUP
	WHERE IMU_ITMNO=@itmno 
	AND IMU_VENNO=@oriven
	
	--IMVENINF
	SELECT 
		@CNT_IMVENINF = COUNT(*)
	FROM IMVENINF
	WHERE IVI_ITMNO = @itmno
	AND IVI_VENNO = @oriven

	--IMVENPCK
	SELECT
		@CNT_IMVENPCK = COUNT(*)
	FROM IMVENPCK
	WHERE IVP_ITMNO = @itmno
	AND IVP_VENNO = @oriven

	--IMBASINF
	SELECT
		@CNT_IMBASINF = COUNT(*)
	FROM IMBASINF
	WHERE IBI_ITMNO=@itmno
	AND IBI_VENNO = @oriven

	/*SELECT 
	@TMPVEN,
	@CNT_DPVEN_MATCH,
	@CNT_PVEN_MATCH,
	@CNT_DVEN_MATCH,
	@CNT_IMVENINF,
	@CNT_IMVENPCK,
	@CNT_IMBASINF
	*/
	
	IF @CNT_PVEN_MATCH > 0 
	BEGIN
		UPDATE IMMRKUP 
		SET 	IMU_PRDVEN = @TMPVEN,
			IMU_UPDDAT = GETDATE(),
			IMU_UPDUSR = @usrid
		WHERE IMU_ITMNO=@itmno
		AND IMU_VENNO = @oriven
		AND IMU_PRDVEN = @newven
		
		--XXX  ERROR HANDLE   XXXXXXXXXXXXXXXXXXXXXXXXXXXXXX
		SELECT @errcde = @@ERROR , @rowcnt = @@ROWCOUNT
		IF @errcde <> 0 
		BEGIN
			ROLLBACK TRANSACTION
			RETURN(@errcde)
		END 
		IF @rowcnt <> @CNT_PVEN_MATCH
		BEGIN
			ROLLBACK TRANSACTION
			PRINT 'Preset Production Vendor No Failure!'
			RETURN(99)	
		END
		--XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX
	END
	
	IF @CNT_DPVEN_MATCH > 0 
	BEGIN
		UPDATE IMMRKUP
		SET 	IMU_VENNO = @newven,
			IMU_PRDVEN = @newven,
			IMU_UPDDAT = GETDATE(),
			IMU_UPDUSR = @usrid
		WHERE IMU_ITMNO = @itmno
		AND IMU_VENNO = @oriven
		AND IMU_PRDVEN = @oriven

		--XXX  ERROR HANDLE   XXXXXXXXXXXXXXXXXXXXXXXXXXXXXX
		SELECT @errcde = @@ERROR , @rowcnt = @@ROWCOUNT
		IF @errcde <> 0 
		BEGIN
			ROLLBACK TRANSACTION
			RETURN(@errcde)
		END 
		IF @rowcnt <> @CNT_DPVEN_MATCH
		BEGIN
			ROLLBACK TRANSACTION
			PRINT 'Update Design and Production Vendor Pair Failure!'
			RETURN(99)	
		END
		--XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX
		
	END

	IF @CNT_DVEN_MATCH > 0 
	BEGIN
		UPDATE IMMRKUP
		SET 	IMU_VENNO = @newven,
			IMU_UPDDAT = GETDATE(),
			IMU_UPDUSR = @usrid
		WHERE IMU_ITMNO = @itmno
		AND IMU_VENNO = @oriven
		AND IMU_PRDVEN <> @oriven

		--XXX  ERROR HANDLE   XXXXXXXXXXXXXXXXXXXXXXXXXXXXXX
		SELECT @errcde = @@ERROR , @rowcnt = @@ROWCOUNT
		IF @errcde <> 0 
		BEGIN
			ROLLBACK TRANSACTION
			RETURN(@errcde)
		END 
		IF @rowcnt <> @CNT_DVEN_MATCH
		BEGIN
			ROLLBACK TRANSACTION
			PRINT 'Update Design Vendor Failure!'
			RETURN(99)	
		END
		--XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX
		
	END
	

	IF @CNT_PVEN_MATCH > 0 
	BEGIN
		UPDATE IMMRKUP
		SET 	IMU_PRDVEN = @oriven,
			IMU_UPDDAT = GETDATE(),
			IMU_UPDUSR = @usrid
		WHERE IMU_ITMNO = @itmno
		AND IMU_PRDVEN = @TMPVEN
		--XXX  ERROR HANDLE   XXXXXXXXXXXXXXXXXXXXXXXXXXXXXX
		SELECT @errcde = @@ERROR , @rowcnt = @@ROWCOUNT
		IF @errcde <> 0 
		BEGIN
			ROLLBACK TRANSACTION
			RETURN(@errcde)
		END 
		IF @rowcnt <> @CNT_PVEN_MATCH
		BEGIN
			ROLLBACK TRANSACTION
			PRINT 'Update Production Vendor Failure!'
			RETURN(99)	
		END
		--XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX
		
	END


	IF NOT EXISTS(SELECT * FROM IMVENINF WHERE IVI_ITMNO = @itmno AND IVI_VENNO = @newven)
	BEGIN
		UPDATE IMVENINF
		SET 	IVI_VENNO = @newven,
			IVI_UPDDAT = GETDATE(),
			IVI_UPDUSR = @usrid
		WHERE IVI_ITMNO = @itmno
		AND IVI_VENNO = @oriven

		--XXX  ERROR HANDLE   XXXXXXXXXXXXXXXXXXXXXXXXXXXXXX
		SELECT @errcde = @@ERROR , @rowcnt = @@ROWCOUNT
		IF @errcde <> 0 
		BEGIN
			ROLLBACK TRANSACTION
			RETURN(@errcde)
		END 
		IF @rowcnt <> @CNT_IMVENINF
		BEGIN
			ROLLBACK TRANSACTION
			PRINT 'Update Vendor Information Failure!'
			RETURN(99)	
		END
		--XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX
	END

	IF NOT EXISTS(SELECT * FROM IMVENPCK WHERE IVP_ITMNO = @itmno AND IVP_VENNO = @newven)
	BEGIN
		UPDATE IMVENPCK
		SET 	IVP_VENNO = @newven,
			IVP_UPDDAT = GETDATE(),
			IVP_UPDUSR = @usrid
		WHERE IVP_ITMNO = @itmno
		AND IVP_VENNO = @oriven

		--XXX  ERROR HANDLE   XXXXXXXXXXXXXXXXXXXXXXXXXXXXXX
		SELECT @errcde = @@ERROR , @rowcnt = @@ROWCOUNT
		IF @errcde <> 0 
		BEGIN
			ROLLBACK TRANSACTION
			RETURN(@errcde)
		END 
		IF @rowcnt <> @CNT_IMVENPCK
		BEGIN
			ROLLBACK TRANSACTION
			PRINT 'Update Vendor Packing Failure!'
			RETURN(99)	
		END
		--XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX
	END


	UPDATE IMBASINF
	SET 	IBI_VENNO = @newven,
		IBI_ITMSTS = 'TBC',
		IBI_UPDDAT = GETDATE(),
		IBI_UPDUSR = @usrid
	WHERE IBI_ITMNO = @itmno
	AND IBI_VENNO = @oriven

	--XXX  ERROR HANDLE   XXXXXXXXXXXXXXXXXXXXXXXXXXXXXX
	SELECT @errcde = @@ERROR , @rowcnt = @@ROWCOUNT
	IF @errcde <> 0 
	BEGIN
		ROLLBACK TRANSACTION
		RETURN(@errcde)
	END 
	IF @rowcnt <> @CNT_IMBASINF
	BEGIN
		ROLLBACK TRANSACTION
		PRINT 'Update Item Basic Information Failure!'
		RETURN(99)	
	END
	--XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX
	COMMIT TRANSACTION
END



if ltrim(rtrim(@NEW_CUSVEN)) <> ''
BEGIN
		UPDATE IMBASINF
		SET 	
			IBI_CUSVEN = @NEW_CUSVEN,
			IBI_UPDDAT = GETDATE(),
			IBI_UPDUSR = @usrid
		WHERE 
			IBI_ITMNO = @itmno AND
			IBI_CUSVEN = @OLD_CUSVEN	

		--XXX  ERROR HANDLE   XXXXXXXXXXXXXXXXXXXXXXXXXXXXXX
		SELECT @errcde = @@ERROR , @rowcnt = @@ROWCOUNT
		IF @errcde <> 0 
			RETURN(@errcde)
END



END









GO
GRANT EXECUTE ON [dbo].[sp_update_IMM00006] TO [ERPUSER] AS [dbo]
GO
