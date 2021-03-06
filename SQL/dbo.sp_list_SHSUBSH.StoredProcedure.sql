/****** Object:  StoredProcedure [dbo].[sp_list_SHSUBSH]    Script Date: 09/29/2017 15:29:09 ******/
DROP PROCEDURE [dbo].[sp_list_SHSUBSH]
GO
/****** Object:  StoredProcedure [dbo].[sp_list_SHSUBSH]    Script Date: 09/29/2017 15:29:10 ******/
SET ANSI_NULLS OFF
GO
SET QUOTED_IDENTIFIER OFF
GO









/************************************************************************
Author:		Marco Chan
Date:		15th February, 2011
***********************************************************************
sp_list_SHSUBSH 'PG','50360', '01/01/2010', '10/01/2010','S', '','mis'
sp_list_SHSUBSH 'UCP', '', '05/01/2010','06/01/2010','L','HA1100008','mis'

*/


CREATE procedure [dbo].[sp_list_SHSUBSH]
@cocde nvarchar(6),
@cusno nvarchar(10),
@invdatfm datetime,
@invdatto datetime,
@type char(1),
@cinvno nvarchar(20),
@usrid nvarchar(30)
 
AS

BEGIN


if @type = 'S' 
begin

select 
'' as 'hsh_com',
--hiv_cocde as 'hsh_cocde',
@cocde as 'hsh_cocde',
hiv_invno as 'hsh_invno',
hih_shpno as 'hsh_shpno',
hih_cus1no as 'hsh_cusno',
cbi_cussna as 'hsh_cussna',
@usrid as 'hsh_creusr',
@usrid as 'hsh_updusr',
getdate() as 'hsh_credat',
getdate() as 'hsh_upddat',
'' as 'hsh_cinvno',
'' as 'hsh_cshpno'
from SHIPGHDR (nolock), SHINVHDR (nolock), CUBASINF (nolock)
where 
hih_cocde = @cocde 
and hiv_cocde = hih_cocde and hiv_shpno = hih_shpno
and hiv_invdat between @invdatfm and @invdatto
and hih_cus1no = @cusno
and hih_cus1no = cbi_cusno

end
else
begin

select '' as hsh_com,
hsh_cocde,
hsh_invno,
hsh_shpno,
hsh_cusno,
cbi_cussna as 'hsh_cussna',
hsh_creusr,
hsh_updusr,
hsh_credat,
hsh_upddat,
hsh_cinvno,
hsh_cshpno
from SHSUBSH (nolock), CUBASINF (nolock)
where hsh_cocde = @cocde 
and hsh_cinvno = @cinvno
and cbi_cusno = hsh_cusno

end



END








GO
GRANT EXECUTE ON [dbo].[sp_list_SHSUBSH] TO [ERPUSER] AS [dbo]
GO
