/****** Object:  StoredProcedure [dbo].[sp_list_IMBASINF_1]    Script Date: 09/29/2017 15:29:09 ******/
DROP PROCEDURE [dbo].[sp_list_IMBASINF_1]
GO
/****** Object:  StoredProcedure [dbo].[sp_list_IMBASINF_1]    Script Date: 09/29/2017 15:29:09 ******/
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
Last Modified  	: 17 July 2003
Table Read(s) 	:
Table Write(s) 	:
=========================================================
 Modification History                                    
=========================================================
Date		Author		Description
=========================================================     
17 July 2003	Allan Yuen		For Merge Porject
*/


CREATE PROCEDURE [dbo].[sp_list_IMBASINF_1]

--***		Program ID:	sp_list_IMBASINF_1
--***		Description:	
--***				
--***		Created by:	Johnson Lai
--***		Created on:	Nov 19, 2001.
--***		Logics:		
--***				
--***		Process Elapse :
--***		Time:
--***		Used to check the reference between vendor and Item master to determine the permit of the delete vendor process

@ibi_cocde as nvarchar(6),
@ibi_venno as nvarchar(6)

AS

select top 1 * from imbasinf -- use top 1 to optimize the select process
where
--ibi_cocde = @ibi_cocde and
ibi_venno = @ibi_venno









GO
GRANT EXECUTE ON [dbo].[sp_list_IMBASINF_1] TO [ERPUSER] AS [dbo]
GO
