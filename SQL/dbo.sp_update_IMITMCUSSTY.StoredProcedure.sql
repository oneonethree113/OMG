/****** Object:  StoredProcedure [dbo].[sp_update_IMITMCUSSTY]    Script Date: 09/29/2017 15:29:08 ******/
DROP PROCEDURE [dbo].[sp_update_IMITMCUSSTY]
GO
/****** Object:  StoredProcedure [dbo].[sp_update_IMITMCUSSTY]    Script Date: 09/29/2017 15:29:10 ******/
SET ANSI_NULLS OFF
GO
SET QUOTED_IDENTIFIER ON
GO




CREATE procedure [dbo].[sp_update_IMITMCUSSTY]

@cocde	varchar(6) , 
@iic_upload	datetime,
@iic_seq	int,
@iic_sts	varchar(1),
@iic_itmno	nvarchar(40),
@iic_cusno	nvarchar(12),
@iic_cusstyno	nvarchar(60),
@iic_mode	nvarchar(12),
@iic_sysmsg	nvarchar(400),
@iic_filnam	nvarchar(400),
@iic_creusr	nvarchar(40),
@iic_updusr	nvarchar(40),
@iic_credat	datetime,
@iic_upddat	datetime,
@usrid		varchar(30)

AS

BEGIN TRANSACTION

	insert into IMITMCUSSTYH
	(
		iic_upload,	
		iic_seq,
		iic_sts,		
		iic_itmno,
		iic_cusno,	
		iic_cusstyno,
		iic_mode,	
		iic_sysmsg,
		iic_filnam,	
		iic_creusr,	
		iic_updusr,	
		iic_credat,	
		iic_upddat	
	)
	values
	(
		@iic_upload,	
		@iic_seq,	
		@iic_sts,		
		@iic_itmno,	
		@iic_cusno,	
		@iic_cusstyno,	
		@iic_mode,	
		@iic_sysmsg,	
		@iic_filnam,	
		@iic_creusr,	
		@usrid,	
		@iic_credat,
		getdate()
	)	
	
	IF @@ERROR <> 0
	BEGIN
		ROLLBACK
		RAISERROR ('Error in insert record into  IMITMCUSSTYH', 16, 1)
		RETURN
	END
	
	delete from IMITMCUSSTY where iic_upload = @iic_upload and iic_seq = @iic_seq and (iic_sts  = 'A' or iic_sts = 'O' or iic_sts = 'R' or iic_sts = 'W') 

	IF @@ERROR <> 0
	BEGIN
		ROLLBACK
		RAISERROR ('Error in delete record from  IMITMCUSSTY', 16, 1)
		RETURN
	END

COMMIT



GO
GRANT EXECUTE ON [dbo].[sp_update_IMITMCUSSTY] TO [ERPUSER] AS [dbo]
GO
