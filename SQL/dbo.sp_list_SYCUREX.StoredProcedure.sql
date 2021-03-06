/****** Object:  StoredProcedure [dbo].[sp_list_SYCUREX]    Script Date: 09/29/2017 15:29:09 ******/
DROP PROCEDURE [dbo].[sp_list_SYCUREX]
GO
/****** Object:  StoredProcedure [dbo].[sp_list_SYCUREX]    Script Date: 09/29/2017 15:29:10 ******/
SET ANSI_NULLS OFF
GO
SET QUOTED_IDENTIFIER OFF
GO









CREATE PROCEDURE [dbo].[sp_list_SYCUREX]
	@cocde NVARCHAR(6),
	@effdat datetime
AS

Begin


declare @effdat_real datetime

select @effdat_real = max(yce_effdat) from SYCUREX

if (select count(*) from SYCUREX where yce_effdat = @effdat + ' 00:00:00') = 0 
begin
	set @effdat = @effdat_real
end


select 
yce_cocde ,
yce_frmcur ,
yce_tocur ,
yce_buyrat ,
yce_selrat ,
yce_effdat ,
yce_iseff ,
yce_creusr ,
yce_credat ,
yce_updusr ,
yce_upddat 
from SYCUREX
where
(
( @effdat = '1900-01-01' and yce_iseff = 'Y' ) or ( yce_effdat = @effdat + ' 00:00:00' )
)

END




GO
GRANT EXECUTE ON [dbo].[sp_list_SYCUREX] TO [ERPUSER] AS [dbo]
GO
