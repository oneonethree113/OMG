/****** Object:  StoredProcedure [dbo].[sp_select_SYLNEINF]    Script Date: 09/29/2017 15:29:08 ******/
DROP PROCEDURE [dbo].[sp_select_SYLNEINF]
GO
/****** Object:  StoredProcedure [dbo].[sp_select_SYLNEINF]    Script Date: 09/29/2017 15:29:10 ******/
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
CREATE PROCEDURE [dbo].[sp_select_SYLNEINF] 

@yli_cocde	nvarchar(6) = ' ',
@yli_lnecde	nvarchar(12)
AS

declare @yli_timstp int

--Set  @yli_timstp = (Select max(cast(yli_timstp as int)) from sylneinf where yli_cocde = @yli_cocde and yli_lnecde = @yli_lnecde)
Set  @yli_timstp = (Select max(cast(yli_timstp as int)) from sylneinf where yli_cocde = ' ' and yli_lnecde = @yli_lnecde)

begin
Select 
yli_creusr as 'yci_status',
yli_cocde,
yli_lnecde,
yli_lnedsc,
yli_creusr,
yli_updusr,
yli_credat,
yli_upddat,
@yli_timstp as yli_timstp

from SYLNEINF

where 
--yli_cocde = @yli_cocde and 
yli_cocde = ' ' and 
yli_lnecde = @yli_lnecde

order by yli_lnecde

end




GO
GRANT EXECUTE ON [dbo].[sp_select_SYLNEINF] TO [ERPUSER] AS [dbo]
GO
