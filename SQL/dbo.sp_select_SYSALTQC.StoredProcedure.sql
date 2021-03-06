/****** Object:  StoredProcedure [dbo].[sp_select_SYSALTQC]    Script Date: 09/29/2017 15:29:08 ******/
DROP PROCEDURE [dbo].[sp_select_SYSALTQC]
GO
/****** Object:  StoredProcedure [dbo].[sp_select_SYSALTQC]    Script Date: 09/29/2017 15:29:10 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO


CREATE  procedure [dbo].[sp_select_SYSALTQC]
	@yst_cocde nvarchar(6)  = ' '
AS
-------declare @yst_timstp int
--Set  @yst_timstp = (Select max(cast(yst_timstp as int)) from SYSALTQC where yst_cocde = @yst_cocde)
-------Set  @yst_timstp = (Select max(cast(yst_timstp as int)) from SYSALTQC where yst_cocde = ' ')

begin
Select 

yst_creusr as 'yst_status',
'' as 'yst_cocde',
ltrim(rtrim(yst_team)) as 'yst_team',
ltrim(rtrim(yst_cus)) as 'yst_cus',
ltrim(rtrim(yst_leader)) as 'yst_leader',
ltrim(rtrim(yst_prdshp)) as 'yst_prdshp',
ltrim(rtrim(yst_smptst)) as 'yst_smptst',


yst_creusr,
yst_updusr,
yst_credat,
yst_upddat,
yst_seq
--------@yst_timstp as yst_timstp

from SYSALTQC
--where                                                  
--yst_cocde = @yst_cocde
--yst_cocde = ' '

order by
yst_team,yst_cus
end



GO
GRANT EXECUTE ON [dbo].[sp_select_SYSALTQC] TO [ERPUSER] AS [dbo]
GO
