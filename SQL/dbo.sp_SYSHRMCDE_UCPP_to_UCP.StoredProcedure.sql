/****** Object:  StoredProcedure [dbo].[sp_SYSHRMCDE_UCPP_to_UCP]    Script Date: 09/29/2017 15:29:08 ******/
DROP PROCEDURE [dbo].[sp_SYSHRMCDE_UCPP_to_UCP]
GO
/****** Object:  StoredProcedure [dbo].[sp_SYSHRMCDE_UCPP_to_UCP]    Script Date: 09/29/2017 15:29:10 ******/
SET ANSI_NULLS OFF
GO
SET QUOTED_IDENTIFIER ON
GO



-- Checked by Allan Yuen at 28/07/2003
-- Disable all function at merge project

/*
=========================================================
Program ID	: 
Description   	: 
Programmer  	: 
Create Date   	: 
Last Modified  	: 15 July 2003
Table Read(s) 	:
Table Write(s) 	:
=========================================================
 Modification History                                    
=========================================================
Date		Author		Description
=========================================================     
20030715	Allan Yuen		Modify For Merge Porject
*/

CREATE PROCEDURE [dbo].[sp_SYSHRMCDE_UCPP_to_UCP] 


AS

Declare 	
@yhc_cocde  nvarchar(6) ,
@yhc_tarzon  nvarchar(2),
@yhc_hrmcde  nvarchar(12),
@yhc_hrmdsc  nvarchar(300),
@yhc_dtyrat  numeric(6,3),
@yhc_creusr  nvarchar(30),
@yhc_updusr  nvarchar(30),
@yhc_upddat  datetime    
set nocount on

/*
DECLARE cur_SYHRMCDE CURSOR
FOR Select 	yhc_cocde,	yhc_tarzon,
		yhc_hrmcde,	yhc_hrmdsc,
		yhc_dtyrat,	yhc_creusr,
		yhc_updusr,	
		yhc_upddat

From SYHRMCDE
Where	yhc_cocde = 'UCPP' 
OPEN cur_SYHRMCDE
FETCH NEXT FROM cur_SYHRMCDE INTO
	 	@yhc_cocde,	@yhc_tarzon,
		@yhc_hrmcde,	@yhc_hrmdsc,
		@yhc_dtyrat,	@yhc_creusr,
		@yhc_updusr,
		@yhc_upddat

While @@fetch_status = 0
Begin
	IF (Select count(*) from SYHRMCDE where yhc_cocde = 'UCP' and yhc_tarzon = @yhc_tarzon and yhc_hrmcde = @yhc_hrmcde) > 0
	BEGIN
		UPDATE SYHRMCDE SET yhc_hrmdsc = @yhc_hrmdsc , yhc_dtyrat = @yhc_dtyrat ,
					yhc_updusr = 'SYSTEM_UPD'
		Where 	yhc_cocde = 'UCP' and
			 yhc_tarzon = @yhc_tarzon and yhc_hrmcde = @yhc_hrmcde and yhc_upddat < @yhc_upddat
	END
	ELSE
	BEGIN
		INSERT INTO SYHRMCDE 
		(yhc_cocde,
		yhc_tarzon,
		yhc_hrmcde,
		yhc_hrmdsc,
		yhc_dtyrat,
		yhc_creusr,
		yhc_updusr,
		yhc_credat,
		yhc_upddat)
		Values
		('UCP',		
		@yhc_tarzon,
		@yhc_hrmcde,
		@yhc_hrmdsc,
		@yhc_dtyrat,
		'SYSTEM_UPD',
		'SYSTEM_UPD',	
		GETDATE(),
		GETDATE())
		
	END
FETCH NEXT FROM cur_SYHRMCDE INTO
	 	@yhc_cocde,	@yhc_tarzon,
		@yhc_hrmcde,	@yhc_hrmdsc,
		@yhc_dtyrat,	@yhc_creusr,
		@yhc_updusr,	
		@yhc_upddat


END

CLOSE cur_SYHRMCDE
DEALLOCATE cur_SYHRMCDE
*/

set nocount off






GO
GRANT EXECUTE ON [dbo].[sp_SYSHRMCDE_UCPP_to_UCP] TO [ERPUSER] AS [dbo]
GO
