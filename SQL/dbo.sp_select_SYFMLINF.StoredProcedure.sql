/****** Object:  StoredProcedure [dbo].[sp_select_SYFMLINF]    Script Date: 09/29/2017 15:29:08 ******/
DROP PROCEDURE [dbo].[sp_select_SYFMLINF]
GO
/****** Object:  StoredProcedure [dbo].[sp_select_SYFMLINF]    Script Date: 09/29/2017 15:29:10 ******/
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
20030715	Allan Yuen		For Merge Porject
*/

CREATE procedure [dbo].[sp_select_SYFMLINF]
	@yfi_cocde nvarchar(6)  = ' '
AS
declare @yfi_timstp int
--Set  @yfi_timstp = (Select max(cast(yfi_timstp as int)) from syfmlinf where yfi_cocde = @yfi_cocde)
Set  @yfi_timstp = (Select max(cast(yfi_timstp as int)) from syfmlinf where yfi_cocde = ' ')

begin
Select 

yfi_creusr as 'yfi_status',
yfi_cocde,
yfi_fmlopt,
yfi_prcfml,
yfi_fml,
yfi_creusr,
yfi_updusr,
yfi_credat,
yfi_upddat,
@yfi_timstp as yfi_timstp

from SYFMLINF
where                                                  
--yfi_cocde = @yfi_cocde
yfi_cocde = ' '

order by
yfi_fmlopt
end








GO
GRANT EXECUTE ON [dbo].[sp_select_SYFMLINF] TO [ERPUSER] AS [dbo]
GO
