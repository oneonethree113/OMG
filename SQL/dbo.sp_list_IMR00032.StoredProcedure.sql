/****** Object:  StoredProcedure [dbo].[sp_list_IMR00032]    Script Date: 09/29/2017 15:29:09 ******/
DROP PROCEDURE [dbo].[sp_list_IMR00032]
GO
/****** Object:  StoredProcedure [dbo].[sp_list_IMR00032]    Script Date: 09/29/2017 15:29:09 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO






/*
--------------------------------------------------------------------------------------------------------------------------------------------------------------------
-- Modification History
---------------------------------------------------------------------------------------------------------------------------------------------------------------------
-- Modify on	-- Modify by	-- Modification
---------------------------------------------------------------------------------------------------------------------------------------------------------------------
---------------------------------------------------------------------------------------------------------------------------------------------------------------------
*/
--sp_list_IMR00032 '', '50068', 'mis'
CREATE         PROCEDURE [dbo].[sp_list_IMR00032]
@cocde nvarchar(6),
@customer nvarchar(10),
@etdfm	datetime,
@etdto	datetime,
@usrid nvarchar(30)
AS


set @etdto = dateadd(DD,1,@etdto)



select 
distinct
soh_cocde as 'Company Code',
pod_purord as 'PO No', 
isnull(pod_jobord,'') as 'Job No',
isnull(c1.cbi_cussna, '') as 'Pri Cust Name',
soh_cuspo as 'Cust PO No',
sod_cusitm as 'Cust Item No',
sod_venitm as 'Vendor Item No',
sod_itmdsc as 'Item Desc',
sod_ordqty as 'Order Qty',
sod_pckunt as 'UM',
sod_ordqty - sod_shpqty as 'O/S Qty',
hid_shpqty as 'Shipped Qty',
sod_shpqty as 'Total Shipped Qty',
sod_cususd as 'Customer Retail (USD)',
isnull(convert(varchar(20),pod_shpstr,111),'') as 'Ship Date (Fty)',
isnull(convert(varchar(20),sod_shpstr,111),'') as 'Ship Date (SC)',
isnull(convert(varchar(20),sod_candat,111),'') as 'SC Cancel Date',
isnull(convert(nvarchar(10),hih_slnonb,111),'') as 'ETD Date', 
isnull(convert(int, hih_slnonb - 5 - sod_candat),0) as 'Days of delay',
'    ' as 'Penalty percentage',
convert(numeric(13,4),0) as 'Penalty Amount',
isnull(cv.vbi_venno + ' - ' + cv.vbi_vensna, '') as 'CV'
into #TEMP_RESULT
from SCORDHDR (nolock) 
left join SCORDDTL (nolock) on soh_cocde = sod_cocde and soh_ordno = sod_ordno
left join POORDDTL (nolock) on sod_cocde = pod_cocde and pod_scno = sod_ordno and pod_scline = sod_ordseq
left join SHIPGDTL (nolock) on sod_cocde = hid_cocde and sod_ordno = hid_ordno and sod_ordseq = hid_ordseq
left join SHIPGHDR (nolock) on hid_cocde = hih_cocde and hid_shpno = hih_shpno
left join CUBASINF c1 (nolock) on soh_cus1no = c1.cbi_cusno
left join VNBASINF cv (nolock) on sod_cusven = cv.vbi_venno
where soh_cus1no = '50068'
and sod_ordqty > 0
--and  sod_ordqty - sod_shpqty > 0
and hih_slnonb >= @etdfm and hih_slnonb <= @etdto



update #TEMP_RESULT set [Penalty percentage] = '1%',[Penalty Amount] = convert(numeric(13,4),[Shipped Qty] * [Customer Retail (USD)] * 1 / 100) where [Days of delay] between 1 and 7
update #TEMP_RESULT set [Penalty percentage] = '2%',[Penalty Amount] = convert(numeric(13,4),[Shipped Qty] * [Customer Retail (USD)] * 2 / 100) where [Days of delay] between 8 and 14
update #TEMP_RESULT set [Penalty percentage] = '5%',[Penalty Amount] = convert(numeric(13,4),[Shipped Qty] * [Customer Retail (USD)] * 5 / 100) where [Days of delay] between 15 and 21
update #TEMP_RESULT set [Penalty percentage] = '10%',[Penalty Amount] = convert(numeric(13,4),[Shipped Qty] * [Customer Retail (USD)] * 10 / 100) where [Days of delay] >= 22

select * from #TEMP_RESULT where [Days of delay] > 0 order by [CV], [ETD Date]

drop table #TEMP_RESULT




GO
GRANT EXECUTE ON [dbo].[sp_list_IMR00032] TO [ERPUSER] AS [dbo]
GO
