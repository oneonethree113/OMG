/****** Object:  StoredProcedure [dbo].[sp_select_SYTIESTR_Grp]    Script Date: 09/29/2017 15:29:08 ******/
DROP PROCEDURE [dbo].[sp_select_SYTIESTR_Grp]
GO
/****** Object:  StoredProcedure [dbo].[sp_select_SYTIESTR_Grp]    Script Date: 09/29/2017 15:29:10 ******/
SET ANSI_NULLS OFF
GO
SET QUOTED_IDENTIFIER OFF
GO




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

/*
Samuel Chan
*/
------------------------------------------------- 
CREATE procedure [dbo].[sp_select_SYTIESTR_Grp]
                                                                                                                                                                                                                                                                 
---------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------- 
@yts_cocde	nvarchar(6) = ' ', 
@yts_venno	nvarchar(6),
@yts_tirtyp	nvarchar(1)

---------------------------------------------- 
 
AS

 Select 
	distinct yts_effdat
 from 
	SYTIESTR
where
                                                                                                                                                                                                                                                                 
---------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------- 
-- yts_cocde = @yts_cocde and
 yts_cocde = ' ' and
yts_venno = @yts_venno and
yts_tirtyp = @yts_tirtyp 

order by 
yts_effdat desc

-------------------------- 

                                                           









GO
GRANT EXECUTE ON [dbo].[sp_select_SYTIESTR_Grp] TO [ERPUSER] AS [dbo]
GO
