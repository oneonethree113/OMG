/****** Object:  StoredProcedure [dbo].[sp_select_SYSMPTRM]    Script Date: 09/29/2017 15:29:08 ******/
DROP PROCEDURE [dbo].[sp_select_SYSMPTRM]
GO
/****** Object:  StoredProcedure [dbo].[sp_select_SYSMPTRM]    Script Date: 09/29/2017 15:29:10 ******/
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

/*'************************************
     S A M U E L

*/
CREATE PROCEDURE [dbo].[sp_select_SYSMPTRM] 

@yst_cocde	nvarchar(6) = ' '


AS

declare @yst_timstp int

--Set  @yst_timstp = (Select max(cast(yst_timstp as int)) from sysmptrm where yst_cocde = @yst_cocde)
Set  @yst_timstp = (Select max(cast(yst_timstp as int)) from sysmptrm where yst_cocde = ' ' )

begin
Select 
yst_creusr as 'yst_status',
yst_cocde,
yst_trmcde,
yst_trmdsc,
yst_charge,
yst_chgval,
yst_creusr,
yst_updusr,
yst_credat,
yst_upddat,
@yst_timstp as yst_timstp

from SYSMPTRM

where 
--yst_cocde = @yst_cocde 
yst_cocde = ' '

order by yst_trmcde

end








GO
GRANT EXECUTE ON [dbo].[sp_select_SYSMPTRM] TO [ERPUSER] AS [dbo]
GO
