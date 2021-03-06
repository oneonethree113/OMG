/****** Object:  StoredProcedure [dbo].[sp_insert_IMVENPCK]    Script Date: 09/29/2017 15:29:09 ******/
DROP PROCEDURE [dbo].[sp_insert_IMVENPCK]
GO
/****** Object:  StoredProcedure [dbo].[sp_insert_IMVENPCK]    Script Date: 09/29/2017 15:29:09 ******/
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


/************************************************************************
Author:		Kenny Chan
Date:		20th September, 2001
************************************************************************/
------------------------------------------------- 
CREATE procedure [dbo].[sp_insert_IMVENPCK]
                                                                                                                                                                                                                                                                 
---------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------- 
@ivp_cocde nvarchar(6) = ' ',
@ivp_itmno nvarchar(20) ,
@ivp_pckseq int,
@ivp_venno nvarchar(6),
@ivp_relatn nvarchar(4),
@ivp_updusr nvarchar(30)
                                    
---------------------------------------------- 
 
AS


begin

Insert into IMVENPCK
-----------------------------
(ivp_cocde,
ivp_itmno,
ivp_pckseq,
ivp_venno,
ivp_relatn,
ivp_creusr,
ivp_updusr,
ivp_credat,
ivp_upddat)


                                  
values (
--@ivp_cocde,
' ',
@ivp_itmno,
@ivp_pckseq,
@ivp_venno,
@ivp_relatn,
@ivp_updusr,
@ivp_updusr,
getdate(),
getdate()
)


--------------------------------- 
end










GO
GRANT EXECUTE ON [dbo].[sp_insert_IMVENPCK] TO [ERPUSER] AS [dbo]
GO
