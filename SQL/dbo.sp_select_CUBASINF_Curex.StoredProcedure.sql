/****** Object:  StoredProcedure [dbo].[sp_select_CUBASINF_Curex]    Script Date: 09/29/2017 15:29:09 ******/
DROP PROCEDURE [dbo].[sp_select_CUBASINF_Curex]
GO
/****** Object:  StoredProcedure [dbo].[sp_select_CUBASINF_Curex]    Script Date: 09/29/2017 15:29:10 ******/
SET ANSI_NULLS OFF
GO
SET QUOTED_IDENTIFIER OFF
GO




-- Mulit Currency
-- Simulate the result of sp_select_CUBASINF_P
-- Assume from USD to other currency

--
--sp_select_CUBASINF_Curex '','USD',1,'1900-01-01','N'
--go
--sp_select_CUBASINF_Curex '','HKD',7.75,'1900-01-01','N'
--go
--sp_select_CUBASINF_Curex '','',1,'1900-01-01','N'
--go                    
--      


CREATE procedure [dbo].[sp_select_CUBASINF_Curex]

                           

                                                                                                                                                                
@cocde 	nvarchar(6),
@curcde	nvarchar(6),
@curexrat	numeric(16,11),
@curexeffdat	datetime,
@dummy	nvarchar(1)
 
AS



begin


select 
yce_cocde as 'ysi_cocde',
--'' as 'ysi_typ' ,
yce_tocur as 'ysi_cde',
--'' as 'ysi_dsc',
--'' as 'ysi_value',
'Y' as 'ysi_def',
--'' as 'ysi_sys',
cast(1 / yce_buyrat as numeric(16,11)) as 'ysi_buyrat',
cast(1 / yce_selrat as numeric(16,11)) as 'ysi_selrat',
yce_buyrat ,
yce_selrat ,
yce_effdat,
yce_iseff
into #tmp_US
from sycurex where yce_frmcur = 'USD' and yce_tocur = 'USD' and yce_iseff = 'Y'



if @curcde <> ''
begin


if @curcde = 'USD' 

begin

	select
	'' as 'ysi_cocde',
	@curcde as 'ysi_cde',
	'Y' as 'ysi_def',
	0 as 'ysi_buyrat',
	cast(1 / @curexrat as numeric(16,11))as 'ysi_selrat',
	0 as 'yce_buyrat',
	@curexrat  as 'yce_selrat',
	@curexeffdat as 'yce_effdat',
	'' as yce_iseff

	union

	select 
	yce_cocde as 'ysi_cocde',
	--'' as 'ysi_typ' ,
	yce_tocur as 'ysi_cde',
	--'' as 'ysi_dsc',
	--'' as 'ysi_value',
	'N' as 'ysi_def',
	--'' as 'ysi_sys',
	cast(1 / yce_buyrat as numeric(16,11)) as 'ysi_buyrat',
	cast(1 / yce_selrat as numeric(16,11)) as 'ysi_selrat',
	yce_buyrat ,
	yce_selrat ,
	yce_effdat,
	yce_iseff
	from sycurex where yce_frmcur = @curcde and yce_tocur <> @curcde and yce_iseff = 'Y'


end 


else
begin
	
	select * from #tmp_US
	union
	select
	'' as 'ysi_cocde',
	@curcde as 'ysi_cde',
	'N' as 'ysi_def',
	0 as 'ysi_buyrat',
	cast(1 / @curexrat as numeric(16,11))as 'ysi_selrat',
	0 as 'yce_buyrat',
	@curexrat  as 'yce_selrat',
	@curexeffdat as 'yce_effdat',
	'' as yce_iseff

	union

	select 
	yce_cocde as 'ysi_cocde',
	--'' as 'ysi_typ' ,
	yce_tocur as 'ysi_cde',
	--'' as 'ysi_dsc',
	--'' as 'ysi_value',
	'N' as 'ysi_def',
	--'' as 'ysi_sys',
	cast(1 / yce_buyrat as numeric(16,11)) as 'ysi_buyrat',
	cast(1 / yce_selrat as numeric(16,11)) as 'ysi_selrat',
	yce_buyrat ,
	yce_selrat ,
	yce_effdat,
	yce_iseff
	from sycurex where yce_frmcur = 'USD' and yce_tocur <> @curcde and yce_tocur <> 'USD' and yce_iseff = 'Y'

end 
end 
else

begin


select * from #tmp_US
union
select 
yce_cocde as 'ysi_cocde',
--'' as 'ysi_typ' ,
yce_tocur as 'ysi_cde',
--'' as 'ysi_dsc',
--'' as 'ysi_value',
'N' as 'ysi_def',
--'' as 'ysi_sys',
cast(1 / yce_buyrat as numeric(16,11)) as 'ysi_buyrat',
cast(1 / yce_selrat as numeric(16,11)) as 'ysi_selrat',
yce_buyrat,
yce_selrat,
yce_effdat,
yce_iseff

from sycurex where yce_frmcur = 'USD' and yce_tocur <> 'USD' and yce_iseff = 'Y'

end 
end



GO
GRANT EXECUTE ON [dbo].[sp_select_CUBASINF_Curex] TO [ERPUSER] AS [dbo]
GO
