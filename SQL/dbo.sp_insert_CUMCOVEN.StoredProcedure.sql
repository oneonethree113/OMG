/****** Object:  StoredProcedure [dbo].[sp_insert_CUMCOVEN]    Script Date: 09/29/2017 15:29:09 ******/
DROP PROCEDURE [dbo].[sp_insert_CUMCOVEN]
GO
/****** Object:  StoredProcedure [dbo].[sp_insert_CUMCOVEN]    Script Date: 09/29/2017 15:29:09 ******/
SET ANSI_NULLS OFF
GO
SET QUOTED_IDENTIFIER ON
GO



/*
=========================================================
Program ID	: sp_insert_CUMCOVEN
Description   	: Insert Data form Customer Vendor Company relationship Table 
Programmer  	: Lewis To
Create Date   	: 18 Jun 2003
Last Modified  	: 
Table Read(s) 	:CUMCOVEN
Table Write(s) 	:
=========================================================
 Modification History                                    
=========================================================
Date		Author		Description
               
=========================================================     
*/

CREATE Procedure [dbo].[sp_insert_CUMCOVEN]

@running_cocde varchar(6),
@ccv_cocde varchar(6),
@ccv_cusno varchar(6),
@ccv_ventyp varchar(1),
@ccv_vendef varchar(1),
@ccv_effdat 	datetime,
@ccv_creusr varchar(30),
@ccv_updprg varchar(20)

AS
begin
insert into CUMCOVEN(
	ccv_cusno,
	ccv_ventyp ,
	ccv_cocde,
	ccv_vendef,
	ccv_effdat,
	ccv_creusr,
	ccv_updusr,
	ccv_credat,
	ccv_upddat,
	ccv_updprg)
values (
	@ccv_cusno,
	@ccv_ventyp ,
	@ccv_cocde,
	@ccv_vendef,
	@ccv_effdat,
	@ccv_creusr,
	@ccv_creusr,
	getdate(),
	getdate(),
	@ccv_updprg
	)


end




GO
GRANT EXECUTE ON [dbo].[sp_insert_CUMCOVEN] TO [ERPUSER] AS [dbo]
GO
