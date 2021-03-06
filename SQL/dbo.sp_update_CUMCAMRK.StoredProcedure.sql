/****** Object:  StoredProcedure [dbo].[sp_update_CUMCAMRK]    Script Date: 09/29/2017 15:29:08 ******/
DROP PROCEDURE [dbo].[sp_update_CUMCAMRK]
GO
/****** Object:  StoredProcedure [dbo].[sp_update_CUMCAMRK]    Script Date: 09/29/2017 15:29:10 ******/
SET ANSI_NULLS OFF
GO
SET QUOTED_IDENTIFIER OFF
GO



/*
=========================================================
Program ID	: sp_update_CUMCAMRK
Description   	: Update Data to  Customer Item Category Markup Table 
Programmer  	: Lewis To
Create Date   	: 18 Jun 2003
Last Modified  	: 
Table Read(s) 	:CUMCAMRK
Table Write(s) 	:CUMCAMRK
=========================================================
 Modification History                                    
=========================================================
Date		Author		Description
               
=========================================================     
*/

Create Procedure [dbo].[sp_update_CUMCAMRK]

@ccm_cocde	varchar(6),
@ccm_cusno	varchar(6),
@ccm_cat		varchar(20),
@ccm_ventyp	char(1),
@ccm_markup	varchar(5),
@ccm_effdat	datetime,
@ccm_updusr 	varchar(30),
@ccm_updprg	varchar(20)

as

begin



update CUMCAMRK set
	ccm_cocde = @ccm_cocde ,
	ccm_cusno = @ccm_cusno,
	ccm_cat = @ccm_cat,
	ccm_ventyp = @ccm_ventyp,
	ccm_markup = @ccm_markup,
	ccm_effdat = @ccm_effdat,
	ccm_updusr = @ccm_updusr,
	ccm_upddat = getdate(),
	ccm_updprg = @ccm_updprg
where ccm_cusno =@ccm_cusno and ccm_ventyp = @ccm_ventyp and  ccm_cat = @ccm_cat 

end





GO
GRANT EXECUTE ON [dbo].[sp_update_CUMCAMRK] TO [ERPUSER] AS [dbo]
GO
