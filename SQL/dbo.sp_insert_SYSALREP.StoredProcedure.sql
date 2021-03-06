/****** Object:  StoredProcedure [dbo].[sp_insert_SYSALREP]    Script Date: 09/29/2017 15:29:09 ******/
DROP PROCEDURE [dbo].[sp_insert_SYSALREP]
GO
/****** Object:  StoredProcedure [dbo].[sp_insert_SYSALREP]    Script Date: 09/29/2017 15:29:09 ******/
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
Description:	Insert data into SYSALREP
Parameter:	1. Company Code range    
		2. Color Code range    
************************************************************************/

CREATE PROCEDURE [dbo].[sp_insert_SYSALREP] 
--------------------------------------------------------------------------------------------------------------------------------------

@ysr_cocde	nvarchar(6) = ' ',
@ysr_code1	nvarchar(5),
@ysr_code		nvarchar(30),
@ysr_dsc		nvarchar(50),
@ysr_salmgr	nvarchar(30),
@ysr_saltem	nvarchar(6),
@ysr_ref		nvarchar(20),
@ysr_updusr	nvarchar(30)
--@cbi_updusr	nvarchar(30)


--------------------------------------------------------------------------------------------------------------------------------------
AS

INSERT INTO  SYSALREP

(
ysr_cocde,
ysr_code1,
ysr_code,
ysr_dsc,
ysr_salmgr,
ysr_saltem,
ysr_ref,
ysr_creusr,
ysr_updusr,
ysr_credat,
ysr_upddat
)
--------------------------------------------------------------------------------------------------------------------------------------
values
(
--@ysr_cocde,
' ',
@ysr_code1,
@ysr_code,
@ysr_dsc,
@ysr_salmgr,
@ysr_saltem,
@ysr_ref,
@ysr_updusr,
@ysr_updusr,
getdate(),
getdate()
)







GO
GRANT EXECUTE ON [dbo].[sp_insert_SYSALREP] TO [ERPUSER] AS [dbo]
GO
