/****** Object:  StoredProcedure [dbo].[sp_SYS_UCPP_to_UCP]    Script Date: 09/29/2017 15:29:08 ******/
DROP PROCEDURE [dbo].[sp_SYS_UCPP_to_UCP]
GO
/****** Object:  StoredProcedure [dbo].[sp_SYS_UCPP_to_UCP]    Script Date: 09/29/2017 15:29:10 ******/
SET ANSI_NULLS OFF
GO
SET QUOTED_IDENTIFIER OFF
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

CREATE PROCEDURE [dbo].[sp_SYS_UCPP_to_UCP] 

@code nvarchar(2) 
AS

Declare 	@ysi_cocde  nvarchar(6),	@ysi_typ  nvarchar(2),
	@ysi_cde  nvarchar(6),	@ysi_dsc  nvarchar(200),
	@ysi_value  nvarchar(20),	@ysi_def  nvarchar(1),
	@ysi_sys  nvarchar(1),	@ysi_buyrat  numeric(16,11),
	@ysi_selrat  numeric(16,11),	@ysi_creusr  nvarchar(30),
	@ysi_updusr  nvarchar(30),	@ysi_upddat datetime

set nocount on

/*
DECLARE cur_SYSETINF CURSOR
FOR Select 	ysi_cocde,	ysi_typ,
		ysi_cde,		ysi_dsc,
		ysi_value,	ysi_def,
		ysi_sys,		ysi_buyrat,
		ysi_selrat,	ysi_creusr,
		ysi_updusr,	ysi_upddat
From SYSETINF 
Where	ysi_cocde = 'UCPP' and
	ysi_typ = @code
OPEN cur_SYSETINF
FETCH NEXT FROM cur_SYSETINF INTO
	@ysi_cocde,	@ysi_typ,
	@ysi_cde,	@ysi_dsc,
	@ysi_value,	@ysi_def,
	@ysi_sys,	@ysi_buyrat,
	@ysi_selrat,	@ysi_creusr,
	@ysi_updusr,	@ysi_upddat
While @@fetch_status = 0
Begin
	IF (Select count(*) from SYSETINF where ysi_cocde = 'UCP' and ysi_typ = @ysi_typ and ysi_cde = @ysi_cde) > 0
	BEGIN
		UPDATE SYSETINF SET 	ysi_dsc = @ysi_dsc , ysi_value = @ysi_value , 					
					ysi_buyrat = @ysi_buyrat , ysi_selrat = @ysi_selrat,
					ysi_updusr = 'SYSTEM_UPD'
		Where ysi_cocde = 'UCP' and ysi_typ = @code and ysi_cde = @ysi_cde and ysi_upddat < @ysi_upddat
	END
	ELSE
	BEGIN
		INSERT INTO SYSETINF 
		(ysi_cocde,	ysi_typ,
		ysi_cde,		ysi_dsc,
		ysi_value,	ysi_def,
		ysi_sys,		ysi_buyrat,
		ysi_selrat,	ysi_creusr,
		ysi_updusr,	ysi_credat,
		ysi_upddat)
		Values
		('UCP',		@ysi_typ,
		@ysi_cde,	@ysi_dsc,
		@ysi_value,	@ysi_def,
		@ysi_sys,	@ysi_buyrat,
		@ysi_selrat,	'SYSTEM_UPD',
		'SYSTEM_UPD',	GETDATE(),
		GETDATE())
		
	END
FETCH NEXT FROM cur_SYSETINF INTO
	@ysi_cocde,	@ysi_typ,
	@ysi_cde,	@ysi_dsc,
	@ysi_value,	@ysi_def,
	@ysi_sys,	@ysi_buyrat,
	@ysi_selrat,	@ysi_creusr,
	@ysi_updusr,	@ysi_upddat

END

CLOSE cur_SYSETINF
DEALLOCATE cur_SYSETINF
*/

set nocount off






GO
GRANT EXECUTE ON [dbo].[sp_SYS_UCPP_to_UCP] TO [ERPUSER] AS [dbo]
GO
