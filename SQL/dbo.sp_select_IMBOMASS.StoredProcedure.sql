/****** Object:  StoredProcedure [dbo].[sp_select_IMBOMASS]    Script Date: 09/29/2017 15:29:09 ******/
DROP PROCEDURE [dbo].[sp_select_IMBOMASS]
GO
/****** Object:  StoredProcedure [dbo].[sp_select_IMBOMASS]    Script Date: 09/29/2017 15:29:10 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO

Create  PROCEDURE [dbo].[sp_select_IMBOMASS] 

@iba_cocde  	nvarchar(6),
@iba_itmno  	nvarchar(20)

AS

SELECT 
	distinct
	' ' as 'iba_status',
	iba_cocde,
	iba_itmno,
	iba_assitm,
	iba_altitmno,
	--iba_pckseq,
	iba_typ,
	iba_colcde,
	ISNULL(ibi_engdsc,'N/A') as 'ibi_engdsc',
	ISNULL(vbi_vensna,'N/A') as 'vbi_vensna',
	-- Frankie Cheung 20100303 Add Period
	case when year(iba_period) = 1900 then '' else
	ltrim(str(year(iba_period))) + '-' + right('0' +  ltrim(str( month(iba_period))),2) end as 'iba_period',
	iba_pckunt,
	iba_bomqty,
	iba_inrqty,
	iba_mtrqty,
	isnull(iba_fcurcde,'') as 'iba_fcurcde',
	isnull(iba_ftycst,0) as 'iba_ftycst',
	'0' as imu_ftyprc,
--	imu_ftyprc,
	isnull(cast(iba_ftyfmlopt as nvarchar(10)), '')  +  ' - ' + isnull(cast(fty.yfi_fml as nvarchar(50) ), '') as 'iba_ftyfmlopt',
	isnull(cast(iba_fmlopt as nvarchar(10)), '')  +  ' - ' + isnull(cast(hk.yfi_fml as nvarchar(50) ), '') as 'iba_fmlopt',
	isnull(iba_bombasprc,0) as 'iba_bombasprc',
	case iba_costing
		when 'Y' then 'Costing'
		when 'N' then 'Basic Price'
		else ''
	end as 'iba_costing',
	iba_genpo,
	iba_curcde,
	iba_untcst,
	iba_creusr,
	iba_updusr,
	iba_credat,
	iba_upddat,
	cast(iba_timstp as int) as 'iba_timstp',
	isnull(assvi.ivi_venitm, '') as 'ivi_venitm',
	iba_colcde as 'iba_orgcolcde'
from 
	IMBOMASS
	left join SYFMLINF fty on fty.yfi_fmlopt = iba_ftyfmlopt
	left join SYFMLINF hk on hk.yfi_fmlopt = iba_fmlopt
--	left join IMBASINF on ibi_cocde = @iba_cocde and ibi_itmno = iba_assitm
--	left join VNBASINF on vbi_cocde = @iba_cocde and ibi_venno = vbi_venno

	left join IMBASINF on ibi_itmno = iba_assitm
--	left join IMMRKUP  ON imu_itmno = ibi_itmno  and iba_pckunt = imu_pckunt
	left join VNBASINF on ibi_venno = vbi_venno
	left join IMVENINF vi on vi.ivi_itmno = iba_itmno and  vi.ivi_def = 'Y' 
	left join IMVENINF assvi on assvi.ivi_itmno = iba_assitm  and assvi.ivi_venno = vi.ivi_venno

where 
	--iba_cocde = @iba_cocde and
	iba_itmno = @iba_itmno


GO
GRANT EXECUTE ON [dbo].[sp_select_IMBOMASS] TO [ERPUSER] AS [dbo]
GO
