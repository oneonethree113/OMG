/****** Object:  StoredProcedure [dbo].[sp_update_SYLNEINF]    Script Date: 09/29/2017 15:29:08 ******/
DROP PROCEDURE [dbo].[sp_update_SYLNEINF]
GO
/****** Object:  StoredProcedure [dbo].[sp_update_SYLNEINF]    Script Date: 09/29/2017 15:29:10 ******/
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
ALTER  Date   	: 
Last Modified  	: 15 July 2003
Table Read(s) 	:
Table Write(s) 	:
=========================================================
 Modification History                                    
=========================================================
Date		Author		Description
=========================================================     
20030715	Allan Yuen		For Merge Porject
20031128	Lester Wu		Update one more field : @yli_pcfac
20040602	Lester Wu		Update one more field : @yli_dsgcde
*/

------------------------------------------------- 
CREATE   procedure [dbo].[sp_update_SYLNEINF]

                                                                                                                                                                                                                                                                 
---------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------- 
@yli_cocde	nvarchar(6) = ' ',
@yli_lnecde	nvarchar(12),
@yli_lnedsc	nvarchar(200),
--2003/11/28--
@yli_pcfty		nvarchar(20),
------------------
--2004/06/02--
@yli_dsgcde	nvarchar(6),
-----------------
@yli_updusr	nvarchar(30)

---------------------------------------------- 
 
AS


begin
update sylneinf
set 
--yli_cocde = @yli_cocde,
yli_lnecde= @yli_lnecde,
yli_lnedsc	=@yli_lnedsc,
-- 2003/11/28--
yli_pcfty = @yli_pcfty,
-------------------
--2004/06/02--
yli_dsgcde = @yli_dsgcde,
-----------------

yli_updusr = @yli_updusr,
yli_upddat=getdate()                                  

--------------------------------- 

where
                                                                                                                                                                                                                                                                 
---------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------- 
--yli_cocde = @yli_cocde and 
--yli_cocde = ' ' and 
yli_lnecde= @yli_lnecde 


end






GO
GRANT EXECUTE ON [dbo].[sp_update_SYLNEINF] TO [ERPUSER] AS [dbo]
GO
