/****** Object:  StoredProcedure [dbo].[sp_select_CLCUREX]    Script Date: 09/29/2017 15:29:09 ******/
DROP PROCEDURE [dbo].[sp_select_CLCUREX]
GO
/****** Object:  StoredProcedure [dbo].[sp_select_CLCUREX]    Script Date: 09/29/2017 15:29:10 ******/
SET ANSI_NULLS OFF
GO
SET QUOTED_IDENTIFIER ON
GO









create  PROCEDURE [dbo].[sp_select_CLCUREX]
	@cocde NVARCHAR(6),
	@frmcur	nvarchar(6),
	@geteffdat nvarchar(1)
AS

Begin

if ( @geteffdat = 'N' )
begin
select 
cce_cocde as 'DEL',
cce_cocde,
cce_frmcur,
cce_tocur,
cce_buyrat,
cce_selrat,
cce_effdat,
cce_iseff,
cce_creusr,
convert(nvarchar(10),cce_credat) as 'cce_credat',
cce_updusr ,
cce_upddat ,
cce_display,
cce_tor

from CLCUREX
--where cce_display = 'Y'
order by cce_frmcur,cce_tocur asc
end

else if ( @geteffdat = 'Y' )

begin
select
distinct
cce_effdat,
cce_iseff
from CLCUREX
--where cce_display = 'Y'
order by cce_iseff desc, cce_effdat desc
end 

END




GO
GRANT EXECUTE ON [dbo].[sp_select_CLCUREX] TO [ERPUSER] AS [dbo]
GO
