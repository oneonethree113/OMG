/****** Object:  StoredProcedure [dbo].[sp_update_SYCATCDE]    Script Date: 09/29/2017 15:29:08 ******/
DROP PROCEDURE [dbo].[sp_update_SYCATCDE]
GO
/****** Object:  StoredProcedure [dbo].[sp_update_SYCATCDE]    Script Date: 09/29/2017 15:29:10 ******/
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
2004/09/15	Lester Wu		Update MOA
*/

/* Samuel 
*/

------------------------------------------------- 
CREATE procedure [dbo].[sp_update_SYCATCDE]

                                                                                                                                                                                                                                                                 
---------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------- 
@ycc_cocde	nvarchar(6) = ' ',
@ycc_level	nvarchar(2),
@ycc_catcde	nvarchar(20),
@ycc_catdsc	nvarchar(200),
@ycc_fflag		char(1),		--Lester Wu 2004/09/21
--@ycc_moflag	char(1),		--
@ycc_moq		numeric(10),	--
@ycc_moa		numeric(13,4),	--
@ycc_updusr	 nvarchar(30)

---------------------------------------------- 
 
AS

begin
update sycatcde
set 
--ycc_cocde= @ycc_cocde,
ycc_level	= @ycc_level,
ycc_catcde = @ycc_catcde,
ycc_catdsc = @ycc_catdsc,
ycc_updusr = @ycc_updusr,
--ycc_creusr = @ycc_updusr,	--Lester Wu 2004/09/16 -- Not Updaet Create User
ycc_upddat=getdate()
--,ycc_credat=getdate()		--Lester Wu 2004/09/16 -- Not Update Create Date
--------------------------------- 
,ycc_fflag = @ycc_fflag	--Lester Wu 2004/09/21
--,ycc_moflag = @ycc_moflag
,ycc_moq = @ycc_moq
,ycc_moa=@ycc_moa		--Lester Wu 2004/09/21
 where
                                                                                                                                                                                                                                                                 
---------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------- 
--ycc_cocde = @ycc_cocde and 
ycc_cocde = ' ' and 
ycc_level = @ycc_level and
ycc_catcde = @ycc_catcde


                                                           
---------------------------------------------------------- 
end












GO
GRANT EXECUTE ON [dbo].[sp_update_SYCATCDE] TO [ERPUSER] AS [dbo]
GO
