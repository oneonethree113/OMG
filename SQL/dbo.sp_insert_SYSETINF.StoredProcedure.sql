/****** Object:  StoredProcedure [dbo].[sp_insert_SYSETINF]    Script Date: 09/29/2017 15:29:09 ******/
DROP PROCEDURE [dbo].[sp_insert_SYSETINF]
GO
/****** Object:  StoredProcedure [dbo].[sp_insert_SYSETINF]    Script Date: 09/29/2017 15:29:09 ******/
SET ANSI_NULLS OFF
GO
SET QUOTED_IDENTIFIER OFF
GO



-- Checked by Allan Yuen at 28/07/2003

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
20030715	Allan Yuen		For Merge Porject
*/


/************************************************************************
Author:		Samuel Chan   
Date:		15th September, 2001
Description:	Insert data into SYSETINF

************************************************************************/

CREATE PROCEDURE [dbo].[sp_insert_SYSETINF] 
--------------------------------------------------------------------------------------------------------------------------------------

@ysi_cocde	nvarchar(6) = ' ',
@ysi_typ		nvarchar(3),
@ysi_cde		nvarchar(6),
@ysi_dsc		nvarchar(200),
@ysi_value	nvarchar(20),
@ysi_def		nvarchar(1),
@ysi_sys		nvarchar(1),
@ysi_buyrat	numeric(16,11),
@ysi_selrat	numeric(16,11),
@ysi_updusr	nvarchar(30)
--@cbi_updusr	nvarchar(30)
--------------------------------------------------------------------------------------------------------------------------------------
AS

INSERT INTO  SYSETINF

(
ysi_cocde,
ysi_typ,
ysi_cde,
ysi_dsc,
ysi_value,
ysi_def,
ysi_sys,
ysi_buyrat,
ysi_selrat,
ysi_creusr,
ysi_updusr,
ysi_credat,
ysi_upddat
)
--------------------------------------------------------------------------------------------------------------------------------------
values
(
--@ysi_cocde,
' ',
@ysi_typ,
@ysi_cde,
@ysi_dsc,
@ysi_value,
@ysi_def,
@ysi_sys,
@ysi_buyrat,
@ysi_selrat,	
@ysi_updusr,
@ysi_updusr,
getdate(),
getdate()
)

/*
if @ysi_cocde = 'UCPP' and @ysi_typ = '05' and (select count(*) from SYSETINF where ysi_cocde = 'UCP' and ysi_typ = '05' and ysi_cde = @ysi_cde) = 0
begin
	INSERT INTO  SYSETINF
	(
	ysi_cocde,
	ysi_typ,
	ysi_cde,
	ysi_dsc,
	ysi_value,
	ysi_def,
	ysi_sys,
	ysi_buyrat,
	ysi_selrat,
	ysi_creusr,
	ysi_updusr,
	ysi_credat,
	ysi_upddat
	)
	values
	(
	'UCP',
	@ysi_typ,
	@ysi_cde,
	@ysi_dsc,
	@ysi_value,
	@ysi_def,
	@ysi_sys,
	@ysi_buyrat,
	@ysi_selrat,	
	'UCPP',
	'UCPP',
	getdate(),
	getdate()
	)
end
*/







GO
GRANT EXECUTE ON [dbo].[sp_insert_SYSETINF] TO [ERPUSER] AS [dbo]
GO
