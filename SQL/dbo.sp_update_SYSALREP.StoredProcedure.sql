/****** Object:  StoredProcedure [dbo].[sp_update_SYSALREP]    Script Date: 09/29/2017 15:29:08 ******/
DROP PROCEDURE [dbo].[sp_update_SYSALREP]
GO
/****** Object:  StoredProcedure [dbo].[sp_update_SYSALREP]    Script Date: 09/29/2017 15:29:10 ******/
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

/* Samuel 
*/

------------------------------------------------- 
CREATE procedure [dbo].[sp_update_SYSALREP]

                                                                                                                                                                                                                                                                 
---------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------- 
@ysr_cocde	nvarchar(6) = ' ',
@ysr_code1	nvarchar(5),
@ysr_code		nvarchar(30),
@ysr_dsc		nvarchar(50),
@ysr_salmgr	nvarchar(30),
@ysr_saltem	nvarchar(6),
@ysr_ref		nvarchar(20),
@ysr_updusr	 nvarchar(30)

---------------------------------------------- 
 
AS

begin
update sysalrep
set 
--ysr_cocde= @ysr_cocde,
ysr_code1=@ysr_code1,
ysr_code=@ysr_code,
ysr_dsc=@ysr_dsc,
ysr_salmgr=@ysr_salmgr,
ysr_saltem=@ysr_saltem,
ysr_ref=@ysr_ref,
ysr_updusr = @ysr_updusr,
ysr_creusr = @ysr_updusr,
ysr_upddat=getdate(),                                  
ysr_credat=getdate()                                  
--------------------------------- 

 where
                                                                                                                                                                                                                                                                 
---------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------- 
-- ysr_cocde = @ysr_cocde and 
--ysr_cocde = ' ' and 
ysr_code = @ysr_code


                                                           
---------------------------------------------------------- 
end



GO
GRANT EXECUTE ON [dbo].[sp_update_SYSALREP] TO [ERPUSER] AS [dbo]
GO
