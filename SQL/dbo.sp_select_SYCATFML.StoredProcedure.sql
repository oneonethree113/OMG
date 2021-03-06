/****** Object:  StoredProcedure [dbo].[sp_select_SYCATFML]    Script Date: 09/29/2017 15:29:08 ******/
DROP PROCEDURE [dbo].[sp_select_SYCATFML]
GO
/****** Object:  StoredProcedure [dbo].[sp_select_SYCATFML]    Script Date: 09/29/2017 15:29:10 ******/
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

/*
 Samuel
*/

CREATE PROCEDURE [dbo].[sp_select_SYCATFML] 

@yaf_cocde 	nvarchar(6) = ' ',
@yaf_lnecde	nvarchar(12)
AS

declare @yaf_timstp int,
@no int

--Set  @yaf_timstp = (Select max(cast(yaf_timstp as int)) from sycatfml where yaf_cocde = @yaf_cocde and yaf_lnecde = @yaf_lnecde)
Set  @yaf_timstp = (Select max(cast(yaf_timstp as int)) from sycatfml where yaf_cocde = ' ' and yaf_lnecde = @yaf_lnecde)
Set @no = 1

begin

Select 
yaf_creusr as 'yaf_status',
yaf_cocde,
yaf_lnecde,
@no as 'no',
yaf_catcde,
yaf_fmlopt + ' - ' + yaf_fml as 'yaf_fmlopt',
--yaf_fmlopt,
yaf_fml,
yaf_updusr,
yaf_credat,
yaf_upddat,
@yaf_timstp as 'yaf_timstp',
'~*UPD*~' as 'yaf_creusr'

from SYCATFML

--where yaf_cocde = @yaf_cocde
where yaf_cocde = ' '
and    yaf_lnecde = @yaf_lnecde

order by yaf_catcde
end




GO
GRANT EXECUTE ON [dbo].[sp_select_SYCATFML] TO [ERPUSER] AS [dbo]
GO
