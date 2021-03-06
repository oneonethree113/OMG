/****** Object:  StoredProcedure [dbo].[sp_update_ZSITMLST]    Script Date: 09/29/2017 15:29:08 ******/
DROP PROCEDURE [dbo].[sp_update_ZSITMLST]
GO
/****** Object:  StoredProcedure [dbo].[sp_update_ZSITMLST]    Script Date: 09/29/2017 15:29:10 ******/
SET ANSI_NULLS OFF
GO
SET QUOTED_IDENTIFIER OFF
GO




/*
=========================================================
Program ID	: 
Description   	: 
Programmer  	: 
Create Date   	: 2005/08/11
Last Modified  	: 
Table Read(s) 	:
Table Write(s) 	:
=========================================================
 Modification History                                    
=========================================================
Date		Author		Description
=========================================================     
2005-10-12	Allan Yuen		Add columns
*/

CREATE PROCEDURE [dbo].[sp_update_ZSITMLST] 

@Zil_cocde	nvarchar(6),
@zil_itmno	varchar(20),
@zil_um		varchar(6),
@zil_cur		varchar(6),
@zil_prc		numeric(13,4),
@zil_custum	varchar(6),
@zil_catcde1	nvarchar(20),
@zil_catcde2	nvarchar(20),
@zil_updusr	varchar(30)

AS

UPDATE 
	ZSITMLST
SET
	zil_um = @zil_um,
	zil_cur = @zil_cur,
	zil_prc = @zil_prc,
	zil_custum = @zil_custum,
	zil_catcde1 = @zil_catcde1,
	zil_catcde2 = @zil_catcde2,
	zil_upddat = getdate(),
	zil_updusr = @zil_updusr
where
	zil_itmno = @zil_itmno





GO
GRANT EXECUTE ON [dbo].[sp_update_ZSITMLST] TO [ERPUSER] AS [dbo]
GO
