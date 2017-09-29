/****** Object:  StoredProcedure [dbo].[sp_physical_delete_SYTIESTR]    Script Date: 09/29/2017 15:29:09 ******/
DROP PROCEDURE [dbo].[sp_physical_delete_SYTIESTR]
GO
/****** Object:  StoredProcedure [dbo].[sp_physical_delete_SYTIESTR]    Script Date: 09/29/2017 15:29:10 ******/
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
Author:		SAMUEL CHAN
Date:		14th September, 2001
************************************************************************/
CREATE PROCEDURE [dbo].[sp_physical_delete_SYTIESTR] 

@yts_cocde	nvarchar(6) = ' ',
@yts_venno	nvarchar(6),
@yts_tirtyp	char(1),
@yts_tirseq	int

AS


delete from SYTIESTR
--where 	yts_cocde = @yts_cocde 
where 	yts_cocde = ' '
and	yts_venno = @yts_venno
and	yts_tirtyp = @yts_tirtyp
and 	yts_tirseq = @yts_tirseq








GO
GRANT EXECUTE ON [dbo].[sp_physical_delete_SYTIESTR] TO [ERPUSER] AS [dbo]
GO
