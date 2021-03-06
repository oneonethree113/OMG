/****** Object:  StoredProcedure [dbo].[sp_update_SYMUSRCO]    Script Date: 09/29/2017 15:29:08 ******/
DROP PROCEDURE [dbo].[sp_update_SYMUSRCO]
GO
/****** Object:  StoredProcedure [dbo].[sp_update_SYMUSRCO]    Script Date: 09/29/2017 15:29:10 ******/
SET ANSI_NULLS OFF
GO
SET QUOTED_IDENTIFIER OFF
GO




/****** Object:  Stored Procedure dbo.sp_update_SYMUSRCO    Script Date: 03/15/2003 9:12:53 ******/
/*
=========================================================
Program ID	: sp_update_SYMUSRCO
Description   	:update data to table SYMUSRCO
Programmer  	: Lewis To
Create Date   	: 09 June  2003
Last Modified  	: 
Table Read(s) 	: 
Table Write(s) 	:SYMUSRCO
=========================================================
 Modification History                                    
=========================================================
               
=========================================================     
*/


CREATE procedure [dbo].[sp_update_SYMUSRCO]
                                                                                                                                                                                                                                                               
--declare
@company		nvarchar(6),
@yuc_cocde	nvarchar(6),
@yuc_usrid	nvarchar(30),
@yuc_shtnam	nvarchar(25),
@yuc_usrgrp	nvarchar(6),
@yuc_usrank	int,
@yuc_supid	nvarchar(30),
@yuc_rmk		nvarchar(100),
@yuc_flgcst	nvarchar(5),
@yuc_flgcstext	nvarchar(5),
@yuc_flgrel	nvarchar(1),
@yuc_flgdef	nvarchar(1),
@yuc_updusr	nvarchar(30),
@yuc_updprg	nvarchar(20)
AS

--declare
--@yuc_flgdel varchar(1)

update   	SYMUSRCO set
	yuc_usrid = @yuc_usrid,
	yuc_cocde = @yuc_cocde,
	yuc_shtnam = @yuc_shtnam,
	yuc_usrgrp = @yuc_usrgrp,
	yuc_usrank = @yuc_usrank,
	yuc_supid = @yuc_supid ,
	yuc_rmk = @yuc_rmk ,
	yuc_flgcst = @yuc_flgcst,
	yuc_flgcstext = @yuc_flgcstext,
	yuc_flgrel =@yuc_flgrel,
	yuc_flgdef = @yuc_flgdef,
	--yuc_creusr =,
	yuc_updusr =@yuc_updusr,
	--yuc_credat =,
	yuc_upddat =getdate(),
	yuc_updprg =@yuc_updprg 
	
where yuc_usrid = @yuc_usrid and yuc_cocde = @yuc_cocde  
 
if @yuc_flgdef = 'Y'
	begin
	update syusrprf set yup_usrgrp = @yuc_usrgrp,
			yup_usrank = @yuc_usrank,
			yup_supid = @yuc_supid,
			yup_flgcst = @yuc_flgcst,
			yup_flgrel = @yuc_flgrel,
			yup_updusr =@yuc_updusr,
			yup_upddat =getdate()
	where yup_cocde = @yuc_cocde and yup_usrid = @yuc_usrid
	end







GO
GRANT EXECUTE ON [dbo].[sp_update_SYMUSRCO] TO [ERPUSER] AS [dbo]
GO
