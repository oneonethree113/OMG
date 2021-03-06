/****** Object:  StoredProcedure [dbo].[sp_select_IMR00019_S]    Script Date: 09/29/2017 15:29:09 ******/
DROP PROCEDURE [dbo].[sp_select_IMR00019_S]
GO
/****** Object:  StoredProcedure [dbo].[sp_select_IMR00019_S]    Script Date: 09/29/2017 15:29:10 ******/
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

--drop procedure sp_select_IMR00019_S
CREATE    PROCEDURE [dbo].[sp_select_IMR00019_S] 

@cocde		nvarchar(6),
@ItmCreDatFm	datetime,
@ItmCreDatTo	datetime,
@usrid		nvarchar(30)

AS




select 
vbi_venno + ' - ' + vbi_vensna 'vendor', count (*) 'total', 0 'miss_cst_pck', 0 'miss_cst', 0 'miss_image' 
into #RESULT
from 
IMBASINF (nolock)
left join IMVENINF (nolock) on ibi_itmno = ivi_itmno and ivi_def = 'Y'
left join VNBASINF (nolock) on vbi_venno = ivi_venno
left join IMPCKINF (nolock) on ibi_itmno = ipi_itmno
left join IMMRKUP (nolock) on imu_itmno = ibi_itmno and imu_prdven = ivi_venno and imu_pckunt = ipi_pckunt and imu_inrqty = ipi_inrqty and imu_mtrqty = ipi_mtrqty
where
vbi_venno > '0000' and vbi_venno < '9999' and
ibi_credat between @ItmCreDatFm and @ItmCreDatTo
--and (imu_ttlcst = 0 or imu_ttlcst is null) and (ipi_inrqty = 0 and ipi_mtrqty = 0)
-- and (imu_ttlcst = 0 or imu_ttlcst is null) /*missing Item Cost*/
-- and (ibi_imgpth = '' or ibi_imgpth is null) /*missing Photo*/
group by vbi_venno, vbi_vensna
order by vbi_venno, vbi_vensna


select 
vbi_venno + ' - ' + vbi_vensna 'vendor', count(*) 'miss_cst_pck'
into #RESULT_1
from 
IMBASINF (nolock)
left join IMVENINF (nolock) on ibi_itmno = ivi_itmno and ivi_def = 'Y'
left join VNBASINF (nolock) on vbi_venno = ivi_venno
left join IMPCKINF (nolock) on ibi_itmno = ipi_itmno
left join IMMRKUP (nolock) on imu_itmno = ibi_itmno and imu_prdven = ivi_venno and imu_pckunt = ipi_pckunt and imu_inrqty = ipi_inrqty and imu_mtrqty = ipi_mtrqty
where
vbi_venno > '0000' and vbi_venno < '9999' and
ibi_credat between @ItmCreDatFm and @ItmCreDatTo
and (imu_ttlcst = 0 or imu_ttlcst is null) and (ipi_inrqty = 0 and ipi_mtrqty = 0)
group by vbi_venno, vbi_vensna
order by vbi_venno, vbi_vensna


select 
vbi_venno + ' - ' + vbi_vensna 'vendor', count(*) 'miss_cst'
into #RESULT_2
from 
IMBASINF (nolock)
left join IMVENINF (nolock) on ibi_itmno = ivi_itmno and ivi_def = 'Y'
left join VNBASINF (nolock) on vbi_venno = ivi_venno
left join IMPCKINF (nolock) on ibi_itmno = ipi_itmno
left join IMMRKUP (nolock) on imu_itmno = ibi_itmno and imu_prdven = ivi_venno and imu_pckunt = ipi_pckunt and imu_inrqty = ipi_inrqty and imu_mtrqty = ipi_mtrqty
where
vbi_venno > '0000' and vbi_venno < '9999' and
ibi_credat between @ItmCreDatFm and @ItmCreDatTo
and (imu_ttlcst = 0 or imu_ttlcst is null) /*missing Item Cost*/
group by vbi_venno, vbi_vensna
order by vbi_venno, vbi_vensna


select 
vbi_venno + ' - ' + vbi_vensna 'vendor', count(*) 'miss_image' 
into #RESULT_3
from 
IMBASINF (nolock)
left join IMVENINF (nolock) on ibi_itmno = ivi_itmno and ivi_def = 'Y'
left join VNBASINF (nolock) on vbi_venno = ivi_venno
left join IMPCKINF (nolock) on ibi_itmno = ipi_itmno
left join IMMRKUP (nolock) on imu_itmno = ibi_itmno and imu_prdven = ivi_venno and imu_pckunt = ipi_pckunt and imu_inrqty = ipi_inrqty and imu_mtrqty = ipi_mtrqty
where
vbi_venno > '0000' and vbi_venno < '9999' and
ibi_credat between @ItmCreDatFm and @ItmCreDatTo
and (ibi_imgpth = '' or ibi_imgpth is null) /*missing Photo*/
group by vbi_venno, vbi_vensna
order by vbi_venno, vbi_vensna



update #RESULT set miss_cst_pck = b.miss_cst_pck from #RESULT a, #RESULT_1 b where a.vendor = b.vendor
update #RESULT set miss_cst = b.miss_cst from #RESULT a, #RESULT_2 b where a.vendor = b.vendor
update #RESULT set miss_image = b.miss_image from #RESULT a, #RESULT_3 b where a.vendor = b.vendor


select 
vendor,
total,
miss_cst_pck,
miss_cst,
miss_image
from #RESULT








GO
GRANT EXECUTE ON [dbo].[sp_select_IMR00019_S] TO [ERPUSER] AS [dbo]
GO
