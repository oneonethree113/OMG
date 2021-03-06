/****** Object:  StoredProcedure [dbo].[sp_select_MSR00011]    Script Date: 09/29/2017 15:29:09 ******/
DROP PROCEDURE [dbo].[sp_select_MSR00011]
GO
/****** Object:  StoredProcedure [dbo].[sp_select_MSR00011]    Script Date: 09/29/2017 15:29:10 ******/
SET ANSI_NULLS OFF
GO
SET QUOTED_IDENTIFIER OFF
GO










/************************************************************************************************************************************
    Modification History
*************************************************************************************************************************************
-- Modifed by		Modified on		Description	
*************************************************************************************************************************************
   Lester Wu		Feb 18 , 2005		Add "ALL" Company Selection
						Cater Customer Alias
   Lester Wu		2005-03-31		replace ALL with UC-G, exclude MS company data from UC-G, retrieve company name from database
   Lester Wu		2005-06-20		show production vendor instead of custom vendor
*************************************************************************************************************************************/


--sp_select_MSR00011 'UCPP','01/01/2003 00:00:00.000','12/31/2003 23:59:59.000','','','10001','50356','50016 - ASCA','50016 - ASCA','','','','','Y','','','Q'

--sp_select_MSR00011 'UCPP','','','','','10001','50356','50016 - ASCA','50016 - ASCA','','','','','Y','','','Q'

--sp_select_MSR00011 'ALL','07/01/2003 00:00:00.000','07/31/2003 23:59:59.000','','','','','','','A','A','','','Y','','','Q'


CREATE         PROCEDURE [dbo].[sp_select_MSR00011]

	@cocde 		nvarchar	(6),
	@issueFm		nvarchar	(30),
	@issueTo		nvarchar	(30),
	@proLineFm	nvarchar	(20),
	@proLineTo	nvarchar	(20),
	@custFm		nvarchar	(20),
	@custTo		nvarchar	(20),
	@custNameFm		nvarchar	(30),
	@custNameTo		nvarchar	(30),
	@venFm		nvarchar	(20),
	@venTo		nvarchar	(20),
	@venItemFm	nvarchar	(20),
	@venItemTo	nvarchar	(20),
	@printAmt	nvarchar	(1),
	@qtyText		int,
	@amtText		int,	
	@sorting		nvarchar	(1)

AS

Declare	
	@issueOpt		nvarchar	(1),
	@ProLineOpt	nvarchar 	(1),
	@custOpt		nvarchar	(1),
	@venOpt		nvarchar	(1),
	@venItemOpt	nvarchar	(1)
	
	
SET @issueOpt = 'N'
	If @issueFm <> '' or @issueTo <> ''
	begin
		SET @issueOpt = 'Y'
	end


SET @ProLineOpt = 'N'
	If @proLineFm <> '' or @proLineTo <> ''
	begin
		SET @ProLineOpt = 'Y'
	end


SET @custOpt = 'N'
	If @custFm <> '' or @custTo <> ''
	begin
		SET @custOpt = 'Y'
	end



SET @venOpt = 'N'
	If @venFm <> '' or @venTo <> ''
	begin
		SET @venOpt = 'Y'
	end


SET @venItemOpt = 'N'
	If @venItemFm <> '' or @venItemFm <> ''
	begin
		SET @venItemOpt = 'Y'
	end


-- Lester Wu 2005-03-31, retrieve company name from database -------------------------------------
declare @compName varchar(100)
set @compName = 'UNITED CHINESE GROUP'
if @cocde <> 'UC-G'
begin
	select @compName = yco_conam from sycominf where yco_cocde = @cocde
end
-------------------------------------------------------------------------------------------------------------------


------------------------------------------------------------------------------------------------------------------------------------------------

Declare 
--	@rate 	numeric	(13,11),
	@H	nvarchar	(20)

		-- HKD to USD (Rate)
--		select @rate =ysi_buyrat from SYSETINF where ysi_cde = 'HKD' and ysi_typ = '06' 
		--and ysi_cocde = @cocde 
		
		--Having Value
		if @amtText <> ''
		begin		
			set @H = @amtText
		end		
		else
		begin
			set @H = '0'
		end		
	
------------------------------------------------------------------------------------------------------------------------------------------------

-- 2004/02/18 Lester Wu
/*
select vw_cbi_cusno,vw_cbi_cusali	-- Customer Alias
into #tmp_msr00011_cusali
from vw_cusali
where (@custOpt= 'N' or (@custOpt='Y' and  vw_cbi_cusali in (
select distinct vw_cbi_cusali from vw_cusali
--where vw_cbi_cusno between '10011' and '10011'
where vw_cbi_cusno between @custFm and @custTo
and vw_cbi_custyp = 'P'
)))
*/
/*
select hih_cocde,hih_shpno
into #tmp_msr00011_HIH
from SHIPGHDR, vw_cusali 
where (@cocde='ALL' or hih_cocde = @cocde)
and 	(@custOpt = 'N' 
		or 
	(@custOpt = 'Y'  
	and hih_cus1no = vw_cbi_cusno
	and vw_cbi_cusali in 	(

			select distinct vw_cbi_cusali from vw_cusali
			where vw_cbi_cusno between @custFm and @custTo
			and vw_cbi_custyp = 'P' 
			)
	))
*/		
select vw_cbi_cusno
into #tmp_msr00011_CUSALI
from vw_cusali
where @custOpt = 'N' 
	or 
(@custOpt = 'Y'  and vw_cbi_cusali in 
	(
	select distinct vw_cbi_cusali from vw_cusali
	where vw_cbi_cusno between @custFm and @custTo
	and vw_cbi_custyp = 'P' 
	)
)

select hih_cocde,hih_shpno
into #tmp_msr00011_HIH
from SHIPGHDR, #tmp_msr00011_CUSALI
where hih_cus1no = vw_cbi_cusno

--Lester Wu 2005-03-31 replace ALL with UC-G and exclude MS company data from UC-G
--if @cocde<>'ALL' 
if @cocde <> 'UC-G'
begin
	delete from #tmp_msr00011_HIH where hih_cocde <> @cocde
end
else
begin
	delete from #tmp_msr00011_HIH where hih_cocde = 'MS'
end

--select * from #tmp_msr00007_cusali order by vw_cbi_cusali
--drop table #tmp_msr00007_cusali

-- convert input customer no and short name to customer alias
select @custFm = case @custFm when '' then '' else min(vw_cbi_cusali) end,
         @custTo = case @custTo when '' then '' else max(vw_cbi_cusali) end
from vw_cusali 
where vw_cbi_cusno between @custFm and @custTo
and vw_cbi_custyp='P'
--
select @custNameFm = case @custFm when '' then '' else cbi_cusno + ' - ' + cbi_cussna end
from CUBASINF 
where cbi_cusno = @custFm

select @custNameTo = case @custTo when '' then '' else cbi_cusno + ' - ' + cbi_cussna end
from CUBASINF
where cbi_cusno = @custTo
-------------------------------------------------------------------


Select 
	-- Parameter
	@cocde 'cocde',
	@issueFm 'issueFm',		
	@issueTo 'issueTo',
	@proLineFm 'proLineFm',	
	@proLineTo 'proLineTo',
	@custFm 'custFm',		
	@custTo 'custTo',
	@custNameFm 'custNameFm',	
	@custNameTo 'custNameTo',
	@venFm 'venFm',		
	@venTo 'venTo',
	@venItemFm 'venItemFm',	
	@venItemTo 'venItemTo',
	@printAmt 'printAmt',
	@qtyText 'qtyText',
	@amtText 'amtText',

	-- POORDHDR 
--Lester Wu 2005-06-20, show production vendor instead of custom vendor
--	poh_venno  + ' -' + vbi_vensna,
	pod_prdven  + ' -' + vbi_vensna as 'pod_prdven',
	
	-- POORDDTL
	pod_venitm, 
	pod_itmno,

	-- IMBASINF
	ibi_engdsc,

	-- SYSETINF
	untcde = isnull(ysi_dsc,''),

	-- SHIPGDTL 
	qty = sum(hid_shpqty),	
	qty_PC = 	sum(hid_shpqty * isnull(ycf_value, 0)),
	qty_PCstr = str(sum(hid_shpqty * isnull(ycf_value, 0))),

--	amount = sum(Case poh_curcde when 'HKD' then hid_shpqty * pod_ftyprc * @rate else hid_shpqty * pod_ftyprc end),
--	Frankie Cheung 20091008
	amount = sum(hid_shpqty * pod_ftyprc * isnull(yce_buyrat,0)),
---------------------------------
	@compName as 'compName'


/*
from SHINVHDR (nolock)
left join #tmp_msr00011_HIH (nolock) on hiv_cocde = hih_cocde and hiv_shpno = hih_shpno
left join SHIPGDTL (nolock) on hih_cocde=hid_cocde and hih_shpno=hid_shpno
left join IMBASINF (nolock) on hid_itmno = ibi_itmno
left join SYSETINF (nolock) on hid_untcde = ysi_cde and ysi_typ = '05'
left join SYCONFTR (nolock) on hid_untcde =  ycf_code1 --and ycf_code2 = 'PC'
left join POORDDTL (nolock) on pod_cocde = hid_cocde and pod_purord = hid_purord and pod_purseq = hid_purseq
left join POORDHDR (nolock) on poh_cocde = pod_cocde and poh_purord = pod_purord
left join VNBASINF (nolock) on poh_venno = vbi_venno
*/
into
	#tmptable1

from 
	SHINVHDR (nolock)
left join SHIPGDTL (nolock) on hiv_cocde=hid_cocde and hiv_shpno=hid_shpno and hiv_invno=hid_invno
left join #tmp_msr00011_HIH (nolock) on hih_cocde=hid_cocde and hih_shpno=hid_shpno
left join IMBASINF (nolock) on hid_itmno = ibi_itmno
left join SYSETINF (nolock) on hid_untcde = ysi_cde and ysi_typ = '05'
left join SYCONFTR (nolock) on hid_untcde =  ycf_code1 --and ycf_code2 = 'PC'
left join POORDDTL (nolock) on pod_cocde = hid_cocde and pod_purord = hid_purord and pod_purseq = hid_purseq
left join POORDHDR (nolock) on poh_cocde = pod_cocde and poh_purord = pod_purord
--Lester Wu 2005-06-20, show production vendor instead of custom vendor
--left join VNBASINF (nolock) on poh_venno = vbi_venno
left join VNBASINF (nolock) on pod_prdven = vbi_venno
,SYCUREX -- Frankie Cheung 20091008

Where	
hiv_cocde = hih_cocde and 
len(ltrim(rtrim(vbi_venno))) = 1 and
((@issueOpt = 'Y' and hiv_invdat between @issueFm and @issueTo) or @issueOpt = 'N')
and 	((@ProLineOpt = 'Y' and ibi_lnecde between @proLineFm and @proLineTo) or @ProLineOpt = 'N')
--Lester Wu 2005-06-20, show production vendor instead of custom vendor -----------------------------------
--and 	((@venOpt = 'Y' and poh_venno between @venFm and @venTo) or @venOpt = 'N')
and 	((@venOpt = 'Y' and pod_prdven between @venFm and @venTo) or @venOpt = 'N')
--------------------------------------------------------------------------------------------------------------------------------
and 	((@venItemOpt = 'Y' and pod_venitm between @venItemFm and @venItemTo) or @venItemOpt = 'N')
-- Frankie Cheung 20091008
and 	yce_frmcur = poh_curcde and yce_tocur = 'USD' and yce_iseff = 'Y'

 --Lester Wu 2005-06-20, show production vendor instead of custom vendor
--group by 	poh_venno  + ' -' + vbi_vensna,pod_venitm, pod_itmno, ibi_engdsc, ysi_dsc
--and 	VBI_VENTYP <> 'E' 
group by 	pod_prdven  + ' -' + vbi_vensna,pod_venitm, pod_itmno, ibi_engdsc, ysi_dsc
--having 	sum(Case poh_curcde when 'HKD' then hid_shpqty * pod_ftyprc * @rate else hid_shpqty * pod_ftyprc end) > @H
--Frankie Cheung 20091009
having 	sum(hid_shpqty * pod_ftyprc * isnull(yce_buyrat,0)) > @H





Select 
	-- Parameter
	@cocde 'cocde',
	@issueFm 'issueFm',		
	@issueTo 'issueTo',
	@proLineFm 'proLineFm',	
	@proLineTo 'proLineTo',
	@custFm 'custFm',		
	@custTo 'custTo',
	@custNameFm 'custNameFm',	
	@custNameTo 'custNameTo',
	@venFm 'venFm',		
	@venTo 'venTo',
	@venItemFm 'venItemFm',	
	@venItemTo 'venItemTo',
	@printAmt 'printAmt',
	@qtyText 'qtyText',
	@amtText 'amtText',

	-- POORDHDR 
--Lester Wu 2005-06-20, show production vendor instead of custom vendor
--	poh_venno  + ' -' + vbi_vensna,
	pod_prdven  + ' -' + vbi_vensna as 'pod_prdven',
	
	-- POORDDTL
	pod_venitm, 
	pod_itmno,

	-- IMBASINF
	ibi_engdsc,

	-- SYSETINF
	untcde = isnull(ysi_dsc,''),

	-- SHIPGDTL 
	qty = sum(hid_shpqty),	
	qty_PC = 	sum(hid_shpqty * isnull(ycf_value, 0)),
	qty_PCstr = str(sum(hid_shpqty * isnull(ycf_value, 0))),

--	amount = sum(Case poh_curcde when 'HKD' then hid_shpqty * pod_ftyprc * @rate else hid_shpqty * pod_ftyprc end),
--	Frankie Cheung 20091008
	amount = sum(hid_shpqty * pod_ftyprc * isnull(yce_buyrat,0)),
---------------------------------
	@compName as 'compName'
/*
from SHINVHDR (nolock)
left join #tmp_msr00011_HIH (nolock) on hiv_cocde = hih_cocde and hiv_shpno = hih_shpno
left join SHIPGDTL (nolock) on hih_cocde=hid_cocde and hih_shpno=hid_shpno
left join IMBASINF (nolock) on hid_itmno = ibi_itmno
left join SYSETINF (nolock) on hid_untcde = ysi_cde and ysi_typ = '05'
left join SYCONFTR (nolock) on hid_untcde =  ycf_code1 --and ycf_code2 = 'PC'
left join POORDDTL (nolock) on pod_cocde = hid_cocde and pod_purord = hid_purord and pod_purseq = hid_purseq
left join POORDHDR (nolock) on poh_cocde = pod_cocde and poh_purord = pod_purord
left join VNBASINF (nolock) on poh_venno = vbi_venno
*/
into
	#tmptable2

from 
	SHINVHDR (nolock)
left join SHIPGDTL (nolock) on hiv_cocde=hid_cocde and hiv_shpno=hid_shpno and hiv_invno=hid_invno
left join #tmp_msr00011_HIH (nolock) on hih_cocde=hid_cocde and hih_shpno=hid_shpno
left join IMBASINF (nolock) on hid_itmno = ibi_itmno
left join SYSETINF (nolock) on hid_untcde = ysi_cde and ysi_typ = '05'
left join SYCONFTR (nolock) on hid_untcde =  ycf_code1 --and ycf_code2 = 'PC'
left join POORDDTL (nolock) on pod_cocde = hid_cocde and pod_purord = hid_purord and pod_purseq = hid_purseq
left join POORDHDR (nolock) on poh_cocde = pod_cocde and poh_purord = pod_purord
--Lester Wu 2005-06-20, show production vendor instead of custom vendor
--left join VNBASINF (nolock) on poh_venno = vbi_venno
left join VNBASINF (nolock) on pod_prdven = vbi_venno
left join IMCOLINF (nolock) on hid_colcde = icf_colcde and hid_itmno = icf_itmno
,SYCUREX -- Frankie Cheung 20091008

Where	
hiv_cocde = hih_cocde and 
len(ltrim(rtrim(vbi_venno))) > 1 and
((@issueOpt = 'Y' and hiv_invdat between @issueFm and @issueTo) or @issueOpt = 'N')
--and 	((@ProLineOpt = 'Y' and ibi_lnecde between @proLineFm and @proLineTo) or @ProLineOpt = 'N')
and 	((@ProLineOpt = 'Y' and icf_lnecde between @proLineFm and @proLineTo) or @ProLineOpt = 'N')
--Lester Wu 2005-06-20, show production vendor instead of custom vendor -----------------------------------
--and 	((@venOpt = 'Y' and poh_venno between @venFm and @venTo) or @venOpt = 'N')
and 	((@venOpt = 'Y' and pod_prdven between @venFm and @venTo) or @venOpt = 'N')
--------------------------------------------------------------------------------------------------------------------------------
and 	((@venItemOpt = 'Y' and pod_venitm between @venItemFm and @venItemTo) or @venItemOpt = 'N')
-- Frankie Cheung 20091008
and 	yce_frmcur = poh_curcde and yce_tocur = 'USD' and yce_iseff = 'Y'

 --Lester Wu 2005-06-20, show production vendor instead of custom vendor
--group by 	poh_venno  + ' -' + vbi_vensna,pod_venitm, pod_itmno, ibi_engdsc, ysi_dsc
--and 	VBI_VENTYP <> 'E' 
group by 	pod_prdven  + ' -' + vbi_vensna,pod_venitm, pod_itmno, ibi_engdsc, ysi_dsc

--having 	sum(Case poh_curcde when 'HKD' then hid_shpqty * pod_ftyprc * @rate else hid_shpqty * pod_ftyprc end) > @H
--Frankie Cheung 20091009
having 	sum(hid_shpqty * pod_ftyprc * isnull(yce_buyrat,0)) > @H


--	cocde ,issueFm,issueTo,proLineFm,proLineTo,
--	custFm,custTo,custNameFm,custNameTo,venFm,
--	venTo,venItemFm,venItemTo,printAmt,qtyText,
--	amtText,pod_prdven,pod_venitm,pod_itmno,ibi_engdsc,
--	untcde,qty,qty_PC,qty_PCstr,amount,compName


if @sorting = 'Q'
	select * from #tmptable1
	union
	select * from #tmptable2
	order by pod_prdven, qty_pc desc

if @sorting = 'A'
	select * from #tmptable1
	union
	select * from #tmptable2
	order by pod_prdven, amount desc

if @sorting = 'T'
	select * from #tmptable1
	union
	select * from #tmptable2
	order by pod_prdven, pod_venitm

	--poh_venno  + ' -' + vbi_vensna, --Lester Wu 2005-06-20, show production vendor instead of custom vendor 	
	--pod_prdven  + ' -' + vbi_vensna,
--	Case @sorting when 'Q' then str(sum(hid_shpqty * isnull(ycf_value, 0))) else '' end desc,
--	Case @sorting when 'A' then str(sum(Case poh_curcde when 'HKD' then hid_shpqty * pod_ftyprc * @rate else hid_shpqty * pod_ftyprc end)) else '' end desc ,
--	Case @sorting when 'I' then pod_venitm else '' end
--	pod_prdven, qty_pc desc
--	Case @sorting when 'Q' then qty_PC else '' end desc
--	Case @sorting when 'A' then str(amount) else '' end desc ,
--	Case @sorting when 'I' then pod_venitm else '' end

--sp_select_MSR00011 'ALL','07/01/2003 00:00:00.000','07/31/2003 23:59:59.000','','','','','','','A','A','','','Y','','','Q'









GO
GRANT EXECUTE ON [dbo].[sp_select_MSR00011] TO [ERPUSER] AS [dbo]
GO
