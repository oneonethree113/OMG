/****** Object:  StoredProcedure [dbo].[sp_update_CUMCOVEN]    Script Date: 09/29/2017 15:29:08 ******/
DROP PROCEDURE [dbo].[sp_update_CUMCOVEN]
GO
/****** Object:  StoredProcedure [dbo].[sp_update_CUMCOVEN]    Script Date: 09/29/2017 15:29:10 ******/
SET ANSI_NULLS OFF
GO
SET QUOTED_IDENTIFIER ON
GO



/*
=========================================================
Program ID	: sp_update_CUMCOVEN
Description   	: Update Data form Customer Vendor Company relationship Table 
Programmer  	: Lewis To
Create Date   	: 18 Jun 2003
Last Modified  	: 
Table Read(s) 	:CUMCOVEN
Table Write(s) 	:CUMCOVEN
=========================================================
 Modification History                                    
=========================================================
Date		Author		Description
               
=========================================================     
*/

CREATE Procedure [dbo].[sp_update_CUMCOVEN]

@running_cocde varchar(6),
@ccv_cocde varchar(6),
@ccv_cusno varchar(6),
@ccv_ventyp varchar(1),
@ccv_vendef varchar(1),
@ccv_effdat	datetime,
@ccv_updusr varchar(30),
@ccv_updprg varchar(20)

AS
begin
update CUMCOVEN set 
	--ccv_cusno,
	--ccv_ventyp ,
	--ccv_cocde,
	ccv_vendef = @ccv_vendef,
	ccv_effdat = @ccv_effdat,
	--ccv_creusr =,
	ccv_updusr = @ccv_updusr,
	--ccv_credat,
	ccv_upddat = getdate(),
	ccv_updprg = @ccv_updprg
where ccv_cusno = @ccv_cusno and
          ccv_ventyp = @ccv_ventyp and
          ccv_cocde = @ccv_cocde

end




GO
GRANT EXECUTE ON [dbo].[sp_update_CUMCOVEN] TO [ERPUSER] AS [dbo]
GO
