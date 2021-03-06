/****** Object:  StoredProcedure [dbo].[sp_select_SYMSHC]    Script Date: 09/29/2017 15:29:08 ******/
DROP PROCEDURE [dbo].[sp_select_SYMSHC]
GO
/****** Object:  StoredProcedure [dbo].[sp_select_SYMSHC]    Script Date: 09/29/2017 15:29:10 ******/
SET ANSI_NULLS OFF
GO
SET QUOTED_IDENTIFIER OFF
GO










/************************************************************************
Author:		Marco Chan
Date:		15th February, 2011
Description:	insert data into SYMSHC
***********************************************************************
*/

CREATE procedure [dbo].[sp_select_SYMSHC]


@ysc_cocde	nvarchar(6),
@ysc_chgtyp	nvarchar(20)

 
AS

BEGIN

--------------------------------------------------------------------------------------------------

if @ysc_chgtyp = 'D'
begin

SELECT	
'' as ysc_del,
ysc_chgcde,
ysc_chgdsc,
ysc_chgtyp,
ysc_creusr,
ysc_updusr,
ysc_credat,
ysc_upddat,
cast(ysc_timstp as int) as ysc_timstp
from SYMSHC
where ysc_chgtyp = 'D'
order by ysc_chgtyp, ysc_chgcde


end
else
begin

SELECT	
'' as ysc_del,
ysc_chgcde,
ysc_chgdsc,
ysc_chgtyp,
ysc_creusr,
ysc_updusr,
ysc_credat,
ysc_upddat,
cast(ysc_timstp as int) as ysc_timstp
from SYMSHC
order by ysc_chgtyp, ysc_chgcde

end

END








GO
GRANT EXECUTE ON [dbo].[sp_select_SYMSHC] TO [ERPUSER] AS [dbo]
GO
