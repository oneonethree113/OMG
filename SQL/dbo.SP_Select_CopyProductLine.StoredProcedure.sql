/****** Object:  StoredProcedure [dbo].[SP_Select_CopyProductLine]    Script Date: 09/29/2017 15:29:09 ******/
DROP PROCEDURE [dbo].[SP_Select_CopyProductLine]
GO
/****** Object:  StoredProcedure [dbo].[SP_Select_CopyProductLine]    Script Date: 09/29/2017 15:29:10 ******/
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
20030715	Allan Yuen		Modify For Merge Porject
*/

CREATE PROCEDURE [dbo].[SP_Select_CopyProductLine]
@cocde nvarchar(6) = ' ',
@lnecde nvarchar(10),
@yli_lnecde nvarchar(10)

AS

BEGIN	

	INSERT INTO SYLNEINF 
	(yli_cocde, yli_lnecde, yli_lnedsc,
	yli_creusr, yli_updusr, yli_credat,
	yli_upddat)
	SELECT
	yli_cocde, @yli_lnecde, yli_lnedsc,
	yli_creusr, yli_updusr, GETDATE(),
	GETDATE()
	FROM SYLNEINF WHERE
--	yli_cocde = @cocde AND
	yli_cocde = ' ' AND
	yli_lnecde = @lnecde
	
	INSERT INTO SYLNECOL
	(ylc_cocde, ylc_lnecde, ylc_colcde,
	ylc_coldsc, ylc_prmstd, ylc_creusr,
	ylc_updusr, ylc_credat, ylc_upddat)
	SELECT
	ylc_cocde, @yli_lnecde, ylc_colcde,
	ylc_coldsc, ylc_prmstd, ylc_creusr,
	ylc_updusr, GETDATE(), GETDATE()
	FROM SYLNECOL WHERE
--	ylc_cocde = @cocde AND
	ylc_cocde = ' ' AND
	ylc_lnecde = @lnecde
	
	INSERT INTO SYCATFML
	(yaf_cocde, yaf_lnecde, yaf_catcde,
	yaf_fmlopt, yaf_fml, yaf_creusr,
	yaf_updusr, yaf_credat, yaf_upddat)
	SELECT
	yaf_cocde, @yli_lnecde, yaf_catcde,
	yaf_fmlopt, yaf_fml, yaf_creusr,
	yaf_updusr, GETDATE(), GETDATE()
	FROM SYCATFML WHERE
--	yaf_cocde = @cocde AND
	yaf_cocde = ' ' AND
	yaf_lnecde = @lnecde
	
	
	
	

END




GO
GRANT EXECUTE ON [dbo].[SP_Select_CopyProductLine] TO [ERPUSER] AS [dbo]
GO
