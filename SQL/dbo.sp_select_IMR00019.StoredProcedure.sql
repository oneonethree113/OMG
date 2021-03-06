/****** Object:  StoredProcedure [dbo].[sp_select_IMR00019]    Script Date: 09/29/2017 15:29:09 ******/
DROP PROCEDURE [dbo].[sp_select_IMR00019]
GO
/****** Object:  StoredProcedure [dbo].[sp_select_IMR00019]    Script Date: 09/29/2017 15:29:10 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO




/*
Modification History
--------------------------------------------------------------------------------------------------------------------------------
Modified on	Modified by	Description
--------------------------------------------------------------------------------------------------------------------------------
--------------------------------------------------------------------------------------------------------------------------------
*/

--drop procedure sp_select_IMR00019
CREATE    PROCEDURE [dbo].[sp_select_IMR00019] 

@cocde		nvarchar(6),
@Venno		nvarchar(6),
@ItmCreDatFm	datetime,
@ItmCreDatTo	datetime,
@usrid		nvarchar(30)

AS










/*
select 
vbi_venno + ' - ' + vbi_vennam as 'vbi_vennam',
vci_adr, 
convert(varchar(20), @ItmCreDatFm, 111) as 'itmcredateFm',
convert(varchar(20), @ItmCreDatTo, 111) as 'itmcredateTo',
ivi_venitm, 
ibi_itmno, 
ibi_engdsc, 
ibi_imgpth, 
ipi_pckunt,
ipi_inrqty,
ipi_mtrqty,
ipi_cbm,
ipi_pckitr,
imu_curcde,
--imu_ftycst,
imu_ftyprc,
imu_bomcst,
imu_ttlcst,
yfi_fml,
imu_bcurcde,
imu_basprc,
imu_prctrm
from 
IMBASINF (nolock)
left join IMVENINF (nolock) on ibi_itmno = ivi_itmno and ivi_def = 'Y'
left join VNBASINF (nolock) on vbi_venno = ivi_venno
left join VNCNTINF (nolock) on vbi_venno = vci_venno and vci_cnttyp = 'M'
left join IMPCKINF (nolock) on ibi_itmno = ipi_itmno
left join IMMRKUP (nolock) on imu_itmno = ibi_itmno and imu_prdven = ivi_venno and imu_pckunt = ipi_pckunt and imu_inrqty = ipi_inrqty and imu_mtrqty = ipi_mtrqty
left join SYFMLINF (nolock) on imu_fmlopt = yfi_fmlopt
where
vbi_venno = @Venno and 
ibi_credat between @ItmCreDatFm and @ItmCreDatTo
order by ibi_itmno
*/

select 
-- Chanegd by Mark Lau 20090102
--vbi_venno + ' - ' + vbi_vennam as 'vbi_vennam',
vbi_venno + ' - ' +  case when isnull(vbi_venchnnam,'') <> '' then isnull(vbi_venchnnam,'') else isnull(vbi_vennam,'') end as 'vbi_vennam',
-- vci_adr,
case when isnull(vci_chnadr,'') <> '' then isnull(vci_chnadr,'') else vci_adr end as 'vci_adr', 

convert(varchar(20), @ItmCreDatFm, 111) as 'itmcredateFm',
convert(varchar(20), @ItmCreDatTo, 111) as 'itmcredateTo',
isnull(ivi_venitm, '') as 'ivi_venitm',  
isnull(ibi_itmno, '') as 'ibi_itmno',
isnull(ibi_engdsc, '') as 'ibi_engdsc',
isnull(ibi_imgpth, '') as 'ibi_imgpth',
isnull(ipi_pckunt, '') as 'ipi_pckunt',
isnull(ipi_inrqty, 0) as 'ipi_inrqty',
isnull(ipi_mtrqty, 0) as 'ipi_mtrqty',
isnull(ipi_cbm, 0) as 'ipi_cbm', 
isnull(ipi_pckitr, '') as 'ipi_pckitr',
isnull(imu_curcde,'') as 'imu_curcde',
--imu_ftycst,
isnull(imu_ftyprc, 0) as 'imu_ftyprc',
isnull(imu_bomcst, 0) as 'imu_bomcst',
isnull(imu_ttlcst, 0) as 'imu_ttlcst',
isnull(imu_ftyprctrm,'') as 'imu_ftyprctrm', 	--Lester Wu 2006-04-27
isnull(yfi_fml, '') as 'yfi_fml',
isnull(imu_itmprc,0) as 'imu_itmprc' , 	 --Lester Wu 2006-04-27
isnull(imu_bomprc,0) as 'imu_bomprc' ,  	--Lester Wu 2006-04-27
isnull(imu_bcurcde, '') as 'imu_bcurcde',
isnull(imu_basprc, 0) as 'imu_basprc',
isnull(imu_prctrm, '') as 'imu_prctrm',
isnull(case ibi_tirtyp when '2' then ibi_moqctn else yco_moq end, 0) as 'ibi_moqctn',
isnull(case ibi_tirtyp when '2' then ibi_curcde else yco_curcde end, '') as 'ibi_curcde',
isnull(case ibi_tirtyp when '2' then ibi_moa else yco_moa end, 0) as 'ibi_moa'
from 
IMBASINF (nolock)
left join IMVENINF (nolock) on ibi_itmno = ivi_itmno and ivi_def = 'Y'
left join VNBASINF (nolock) on vbi_venno = ivi_venno
left join VNCNTINF (nolock) on vbi_venno = vci_venno and vci_cnttyp = 'M'
left join IMPCKINF (nolock) on ibi_itmno = ipi_itmno
left join IMMRKUP (nolock) on imu_itmno = ibi_itmno and imu_prdven = ivi_venno and imu_pckunt = ipi_pckunt and imu_inrqty = ipi_inrqty and imu_mtrqty = ipi_mtrqty
left join SYFMLINF (nolock) on imu_fmlopt = yfi_fmlopt
left join SYCOMINF (nolock) on yco_cocde = 'UCP'
where
vbi_venno = @Venno and 
ibi_credat between @ItmCreDatFm and @ItmCreDatTo
order by ibi_itmno





GO
GRANT EXECUTE ON [dbo].[sp_select_IMR00019] TO [ERPUSER] AS [dbo]
GO
