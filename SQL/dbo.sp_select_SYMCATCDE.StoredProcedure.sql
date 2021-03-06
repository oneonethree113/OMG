/****** Object:  StoredProcedure [dbo].[sp_select_SYMCATCDE]    Script Date: 09/29/2017 15:29:08 ******/
DROP PROCEDURE [dbo].[sp_select_SYMCATCDE]
GO
/****** Object:  StoredProcedure [dbo].[sp_select_SYMCATCDE]    Script Date: 09/29/2017 15:29:10 ******/
SET ANSI_NULLS OFF
GO
SET QUOTED_IDENTIFIER OFF
GO





/*
=========================================================
Program ID	: 
Description   	: 
Programmer  	: 
Create Date   	: 2005/08/11
Last Modified  	: 
Table Read(s) 	:
Table Write(s) 	:
=========================================================
 Modification History                                    
=========================================================
Date		Author		Description
=========================================================     
20030715	Allan Yuen		
*/

CREATE PROCEDURE [dbo].[sp_select_SYMCATCDE] 

@ymc_cocde	nvarchar(6) = ' ',
@ymc_type	char(1),
@ymc_catcde	nvarchar(20)
AS

declare @ymc_timstp int

--Set  @ymc_timstp = (Select max(cast(ymc_timstp as int)) from SYMCATCDE where ymc_cocde = @ymc_cocde and ymc_type = @ymc_type and ymc_catcde = @ymc_catcde)
Set  @ymc_timstp = (Select max(cast(ymc_timstp as int)) from SYMCATCDE where ymc_cocde = ' ' and ymc_type = @ymc_type and ymc_catcde = @ymc_catcde)

begin
Select 
ymc_creusr as 'ymc_status',
ymc_cocde,
ymc_type,
ymc_catcde,
ymc_creusr,
ymc_updusr,
ymc_credat,
ymc_upddat,
@ymc_timstp as ymc_timstp

from SYMCATCDE

where 
ymc_cocde = ' ' and 
ymc_type = @ymc_type and 
ymc_catcde = @ymc_catcde
order by 
ymc_type, ymc_catcde

end










GO
GRANT EXECUTE ON [dbo].[sp_select_SYMCATCDE] TO [ERPUSER] AS [dbo]
GO
