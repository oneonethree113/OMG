/****** Object:  StoredProcedure [dbo].[sp_list_MPR00003_pck]    Script Date: 09/29/2017 15:29:09 ******/
DROP PROCEDURE [dbo].[sp_list_MPR00003_pck]
GO
/****** Object:  StoredProcedure [dbo].[sp_list_MPR00003_pck]    Script Date: 09/29/2017 15:29:09 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO















/*
=========================================================
Program ID	: sp_list_MPR00003_pck
Description   	: 6/F Costing Depart -- INVOICE
Programmer  	: Lester Wu
ALTER  Date   	:2005-08-25
Last Modified  	: 
Table Read(s) 	:
Table Write(s) 	:
=========================================================
 Modification History                                    
=========================================================
Date			Author		Description
2005-10-08	Lester Wu		Cater "Group" filed with value
2009-10-15	Frankie Cheung		Add Print Group
=========================================================     

*/

-- sp_list_MPR00003_pck 'UCPP','GT0800026','GT0800026','MIS'

CREATE  Procedure [dbo].[sp_list_MPR00003_pck]
@cocde	varchar(6),
@GRNFm	varchar(20),
@GRNTo	varchar(20),
@DP			int,
@HIDDEN	int,
@ynPRTGRP	varchar(1),
@UserID	varchar(30)
as
BEGIN
/*
declare 
@cocde	varchar(6),
@GRNFm	varchar(20),
@GRNTo	varchar(20),
@UserID	varchar(30)

set @cocde = 'UCPP'
set @GRNFm = 'GT0800026'
set @GRNTo = 'GT0800026'
set @UserID = 'MIS'
*/

select 
	Grh_GrnNo as '_GrnNo',
	isnull(ymc_catcde,'X') as '_CustType',
	case grd_grp when '' then sum(Grd_TtlCtn) else max(Grd_TtlCtn) end as '_Sum_TtlCtn',
	case grd_grp when '' then sum(Grd_GW * Grd_TtlCtn) else max(Grd_GW * Grd_TtlCtn) end '_Sum_TtlGW',
	case grd_grp when '' then sum(Grd_NW * Grd_TtlCtn) else max(Grd_NW * Grd_TtlCtn) end '_Sum_TtlNW' ,
	Grd_CTNUM as '_CTNUM',
	case grd_grp when '' then sum(Grd_custqty) else max(Grd_custqty) end  '_Sum_CustQty' 
	,Grd_Custum as '_CustUM'
	,grd_grp as '_Grp'
into #_Ttl_Tbl2
from 
GRNTRFHDR
LEFT JOIN GRNTRFDTL on Grh_GrnNo = Grd_GrnNo
LEFT JOIN SYMCATCDE on Grd_CustCat = ymc_catcde and ymc_type = '1'
Where
	Grh_GrnNo between @GRNFm and @GRNTo and
	Grd_Type <> 'Misc'
Group by 
	Grh_GrnNo, 
	isnull(ymc_catcde,'X'), 
	isnull(ymc_catdis,'其它') ,
	Grd_CTNUM
	,Grd_Custum
	,grd_grp 
--
select 
	_GrnNo , 
	_CustType , 
	sum(_Sum_TtlCtn) as _Sum_TtlCtn,
	sum(_Sum_TtlGW) as _Sum_TtlGW,
	sum(_Sum_TtlNW) as _Sum_TtlNW ,
	_CTNUM,
	sum(_Sum_CustQty) as _Sum_CustQty,
	_CustUM
into #_Ttl_Tbl
from #_Ttl_Tbl2
group by
	_GrnNo , 
	_CustType , 
	_CTNUM,
	_CustUM

--select * from #_Ttl_Tbl2
--select * from #_Ttl_Tbl left join SYMCATCDE on _CustType = ymc_catcde order by _CustType


select 

	Grh_GrnNo as 'Grh_GrnNo',
	isnull(inv.Gvi_VenNam,'') as 'Bill_Chin' , 
	isnull(inv.Gvi_EngNam,'') as 'Bill_Eng' ,
	isnull(inv.Gvi_EngAddr,'') as '_Addr',
--	isnull(inv.Gvi_EngAddr,'') as 'Bill_Addr',
	isnull(inv.Gvi_Tel1,'') as 'Bill_Tel1',
	isnull(inv.Gvi_Tel2,'') as 'Bill_Tel2', 
	isnull(inv.Gvi_Fax,'') as 'Bill_Fax',
	isnull(inv.Gvi_TLX,'') as 'Bill_TLX',
	isnull(dest.Gvi_VenNam,'') as '_Name',
	Grh_ShpAddr as 'Bill_Addr' , 
--	Grh_ShpAddr as '_Addr' , 
	isnull(ymc_catdis,'其它') as 'CustDis',
	isnull(ymc_catdsc,'其它') as 'CustCat',
	Grd_Nw as 'NW',
	Grd_Gw as 'GW',
	Grd_CTNUM as 'CTN_UM',
	Grd_CTNFm as 'CTN_FM',
	Grd_CTNTo as 'CTN_TO',
	case isnull(Grd_Grp,'') when '' then sum(Grd_TtlCtn) else max(Grd_TtlCtn) end as 'CTN_Ttl',	
	case isnull(Grd_Grp,'') when '' then  sum(Grd_GW * Grd_TtlCtn) else max(Grd_GW * Grd_TtlCtn) end  'TtlGW',
	case isnull(Grd_Grp,'') when '' then  sum(Grd_NW * Grd_TtlCtn) else max(Grd_NW * Grd_TtlCtn) end 'TtlNW',
	-------------------------------------------------------------------------------------------------------------------------------------------
	_Sum_TtlCtn  as 'Sum_TtlCtn',
	_Sum_TtlGW as 'Sum_TtlGW',
	_Sum_TtlNW as 'Sum_TtlNW',
	_Sum_CustQty as 'Sum_TtlCustQty',
	--------------------------------------------------------
	right(Grh_DlvDat,2) + ' 年 ' + left(Grh_DlvDat,2) + ' 月 ' + substring(Grh_DlvDat,4,2) + ' 日' as 'Grh_DlvDat',
	Grh_CtrNo	 as 'Grh_CtrNo',
	Grh_car	 as 'Grh_CtrSiz',
	case isnull(Grd_grp,'') when '' then sum(isnull(Grd_CustQty,0)) else max(isnull(Grd_CustQty,0)) end  as 'Sum_CustQty' , 
	case isnull(_CustUM,'') when 'M' then '米' when 'KG' then '千克'  else  isnull(_CustUM,'') end as 'CustUM' , 
	isnull(ymc_cloth,'') as 'isCloth' , 
	case isnull(Grd_grp,'') when '' then sum(isnull(Grd_TtlShpQty,0)) else max(isnull(Grd_TtlShpQty,0)) end  as 'ShpQty' , 
	case grd_shpum when 'M' then '米' when 'KG' then '千克' else grd_shpum end as 'ShpUM',
	max(Grd_ItmNam) as 'ItemDesc',
	isnull(Grh_CusUM,'') as 'CUSTUM' , 
	isnull(Grh_InvUM,'') as 'INVUM' ,
	case @ynPRTGRP when 'Y' then convert(varchar(20),Grd_PrtGrp) else '***' end as 'PRTGRP', -- Frankie Cheung 20091028: Add print group
	--------------------------------------------------------
	len(ltrim(rtrim(Grd_CTNFm))) as 'LenFm' , 
	--len(ltrim(rtrim(Grd_CTNTo))) as 'LenTo'
	isnull(Grd_Grp,'')  as 'Grd_Grp'


from 
GRNTRFHDR
LEFT JOIN GRNTRFDTL on Grh_GrnNo = Grd_GrnNo
LEFT JOIN SYMCATCDE on Grd_CustCat = ymc_catcde and ymc_type = '1'
--LEFT JOIN #tmp_lh on Grh_ImpFty = _CustFty
LEFT JOIN GRNVENINF cust (NOLOCK)  on Grh_ImpFty = cust.Gvi_VenSna and cust.Gvi_Type = 'CUST'
LEFT JOIN GRNVENINF inv (NOLOCK)  on cust.Gvi_InvVen = inv.Gvi_VenSna and inv.Gvi_Type = 'INV'
LEFT JOIN GRNVENINF dest (NOLOCK)  on Grh_ShpPlc = dest.Gvi_VenSna and dest.Gvi_Type = 'CUST'
LEFT JOIN #_Ttl_Tbl on _GrnNo = Grd_GrnNo and _CustType = grd_custcat  and Grd_CTNUM = _CTNUM and grd_custum = _CustUM
Where
	Grh_GrnNo between @GRNFm and @GRNTo and
	Grd_Type <> 'Misc'
Group by 
	Grh_GrnNo,
	--isnull(_Bill_Chin,'') , 
	--isnull(_Bill_Eng,'') , 
	--------------------------------------------------------
	-- Lester Wu 2006-03-20
	right(Grh_DlvDat,2) + ' 年 ' + left(Grh_DlvDat,2) + ' 月 ' + substring(Grh_DlvDat,4,2) + ' 日' ,
	Grh_CtrNo	,
	Grh_car	,
	--------------------------------------------------------
	isnull(inv.Gvi_VenNam,'') ,
	isnull(inv.Gvi_EngNam,'') ,
	isnull(inv.Gvi_EngAddr,'') ,
	isnull(inv.Gvi_Tel1,'') ,
	isnull(inv.Gvi_Tel2,'') ,
	isnull(inv.Gvi_Fax,'') ,
	isnull(inv.Gvi_TLX,'') ,
	isnull(dest.Gvi_VenNam,'') ,
	Grh_ShpAddr ,
	isnull(ymc_catdis,'其它') , 
	isnull(ymc_catdsc,'其它') , 
	Grd_CTNFm,
	Grd_CTNTo,
	Grd_CTNUM,
	Grd_Nw,
	Grd_Gw,
	_Sum_TtlCtn ,
	_Sum_TtlGW,
	_Sum_TtlNW , 
	_Sum_CustQty , 
	isnull(Grd_Grp,''),
--	isnull(_Sum_CustQty,0) ,
	--case isnull(_CustUM,'') when 'M' then '米' else  isnull(_CustUM,'') end , 
	case isnull(_CustUM,'') when 'M' then '米' when 'KG' then '千克'  else  isnull(_CustUM,'') end,
	isnull(ymc_cloth,''),
	grd_shpum,
	isnull(Grh_CusUM,''),
	isnull(Grh_InvUM,'')
	,Grd_PrtGrp	-- Frankie Cheung 20091028: Add print group
order by 
	Grh_GrnNo,
	len(ltrim(rtrim(Grd_CTNFm))) ,
	--len(ltrim(rtrim(Grd_CTNTo))) , 
	Grd_CTNFm,
	Grd_CTNTo,
	isnull(ymc_catdsc,'其它') , 
	Grd_CTNUM,
	Grd_Nw,
	Grd_Gw


drop table #_Ttl_Tbl
drop table #_Ttl_Tbl2

--drop table #tmp_lh

END
















GO
GRANT EXECUTE ON [dbo].[sp_list_MPR00003_pck] TO [ERPUSER] AS [dbo]
GO
