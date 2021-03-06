/****** Object:  StoredProcedure [dbo].[sp_insert_SYFMLINF]    Script Date: 09/29/2017 15:29:09 ******/
DROP PROCEDURE [dbo].[sp_insert_SYFMLINF]
GO
/****** Object:  StoredProcedure [dbo].[sp_insert_SYFMLINF]    Script Date: 09/29/2017 15:29:09 ******/
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
Description:	Insert data into SYFMLINF
Parameter:	1. Company Code range    
		2. Color Code range    
************************************************************************/

CREATE PROCEDURE [dbo].[sp_insert_SYFMLINF] 
--------------------------------------------------------------------------------------------------------------------------------------

@yfi_cocde	nvarchar(6) = ' ',
--@ylf_lnecde	nvarchar(12),
@yfi_fmlopt	nvarchar(5),
@yfi_prcfml	nvarchar(50),
@yfi_fml		nvarchar(300),

@yfi_updusr	nvarchar(30)
--@cbi_updusr	nvarchar(30)


--------------------------------------------------------------------------------------------------------------------------------------
AS

INSERT INTO  SYFMLINF

(
yfi_cocde,
yfi_fmlopt,
yfi_prcfml,
yfi_fml,

yfi_creusr,
yfi_updusr,
yfi_credat,
yfi_upddat
)
--------------------------------------------------------------------------------------------------------------------------------------
values
(
--@yfi_cocde,
' ',
@yfi_fmlopt,
@yfi_prcfml,
@yfi_fml,

@yfi_updusr,
@yfi_updusr,
getdate(),
getdate()
)










GO
GRANT EXECUTE ON [dbo].[sp_insert_SYFMLINF] TO [ERPUSER] AS [dbo]
GO
