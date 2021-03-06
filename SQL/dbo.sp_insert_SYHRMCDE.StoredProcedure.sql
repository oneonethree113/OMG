/****** Object:  StoredProcedure [dbo].[sp_insert_SYHRMCDE]    Script Date: 09/29/2017 15:29:09 ******/
DROP PROCEDURE [dbo].[sp_insert_SYHRMCDE]
GO
/****** Object:  StoredProcedure [dbo].[sp_insert_SYHRMCDE]    Script Date: 09/29/2017 15:29:09 ******/
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
Description:	Insert data into SYCOLINF
Parameter:	1. Company Code range    
		2. Color Code range    
************************************************************************/

CREATE PROCEDURE [dbo].[sp_insert_SYHRMCDE] 
--------------------------------------------------------------------------------------------------------------------------------------
@yhc_cocde	nvarchar(6) = ' ',
@yhc_tarzon	nvarchar(2),
@yhc_hrmcde	nvarchar(12),
@yhc_hrmdsc	nvarchar(300),
@yhc_dtyrat	numeric(6,3),
@yhc_updusr	nvarchar(30)
--@cbi_updusr	nvarchar(30)


--------------------------------------------------------------------------------------------------------------------------------------
AS

INSERT INTO  SYHRMCDE

(
yhc_cocde,
yhc_tarzon,
yhc_hrmcde,
yhc_hrmdsc,
yhc_dtyrat,
yhc_creusr,
yhc_updusr,
yhc_credat,
yhc_upddat
)
--------------------------------------------------------------------------------------------------------------------------------------
values
(
--@yhc_cocde,
' ',
@yhc_tarzon,
@yhc_hrmcde,
@yhc_hrmdsc,
@yhc_dtyrat,
@yhc_updusr,
@yhc_updusr,
getdate(),
getdate()
)










GO
GRANT EXECUTE ON [dbo].[sp_insert_SYHRMCDE] TO [ERPUSER] AS [dbo]
GO
