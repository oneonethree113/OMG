/****** Object:  StoredProcedure [dbo].[sp_select_MSR00010]    Script Date: 09/29/2017 15:29:09 ******/
DROP PROCEDURE [dbo].[sp_select_MSR00010]
GO
/****** Object:  StoredProcedure [dbo].[sp_select_MSR00010]    Script Date: 09/29/2017 15:29:10 ******/
SET ANSI_NULLS OFF
GO
SET QUOTED_IDENTIFIER OFF
GO










/************************************************************************************************************************************
    Modification History
*************************************************************************************************************************************
-- Modifed by		Modified on		Description	
*************************************************************************************************************************************
   Lester Wu		2005-03-31		replace ALL with UC-G, exclude MS company data from UC-G, retrieve company name from database
   Lester Wu		2005-03-31		show production vendor instead of custom vendor
*************************************************************************************************************************************/



--sp_select_MSR00010 'UCP','12/01/2003 00:00:00.000','12/31/2003 23:59:59.000','','','10001','50016','50016 - ASCA','50016 - ASCA','','','','','Y','','','S','Q'

--sp_select_MSR00010 'UCPP','12/01/2003 00:00:00.000','12/31/2003 23:59:59.000','','','50001','50001','50016 - ASCA','50016 - ASCA','','','','','Y','','2304','S','Q'


CREATE   PROCEDURE [dbo].[sp_select_MSR00010]

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
	@printAmt		nvarchar	(1),
	@qtyText		int,
	@amtText		int,
	@sp		nvarchar	(1),
	@sorting		nvarchar	(1)

AS

------------------------------------------------------------------------------------------------------------------------------------------------
Declare	
	@issueOpt		nvarchar	(1),
	@ProLineOpt	nvarchar 	(1),
	@custOpt		nvarchar	(1),
	@venOpt		nvarchar	(1),
	@venItemOpt	nvarchar	(1)
	


create table #tmp_MSR00010_SC(
tmp_venno		nvarchar(30),
tmp_venitm	nvarchar(20),
tmp_itmno		nvarchar(20),
tmp_engdsc	nvarchar(800),
tmp_untcde	nvarchar(200),
tmp_qty		int,
tmp_qtyPC		numeric(13,4),
tmp_amt		numeric(13,4)
)


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

------------------------------------------------------------------------------------------------------------------------------------------------

-- Lester Wu 2005-03-31, retrieve company name from database -------------------------------------
declare @compName varchar(100)
set @compName = 'UNITED CHINESE GROUP'
if @cocde <> 'UC-G'
begin
	select @compName = yco_conam from sycominf where yco_cocde = @cocde
end
-------------------------------------------------------------------------------------------------------------------

Declare 
--	@rate 	numeric	(13,11),
	@H	nvarchar	(20)

/*		
		-- HKD to USD (Rate)
		select @rate = ysi_buyrat  from SYSETINF where ysi_cde = 'HKD' and ysi_typ = '06' 
			--and ysi_cocde = @cocde 
*/
		--Having Value
		if @amtText <> ''
		begin		
			set @H = @amtText
		end		
		else
		begin
			set @H = '0'
		end			

select vw_cbi_cusno 
into #tmp_msr00010_CUSALI
from vw_cusali
where @custOpt='N' 
	or 
(@custOpt='Y' and vw_cbi_cusali in 
	(
	select distinct vw_cbi_cusali from vw_cusali
	where vw_cbi_cusno between @custFm and @custTo
	and vw_cbi_custyp='P'
	)
)

select soh_cocde,soh_ordno,soh_curcde
	, soh_curexrat -- Frankie Cheung 20091008
into #tmp_msr00010_SOH
from SCORDHDR , #tmp_msr00010_CUSALI
where 
	--Lester Wu 2005-03-31,replace ALL with UC-G, exclude MS company data from UC-G
	--(@cocde='ALL' or soh_cocde=@cocde)
	((@cocde='UC-G' and soh_cocde<>'MS') or soh_cocde=@cocde)
and 	((@issueOpt = 'Y' and soh_issdat between @issueFm and @issueTo) or @issueOpt = 'N')
and	soh_cus1no = vw_cbi_cusno


--select * from #tmp_msr00010_SOH
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
------------------------------------------------------------------------------------------------------------------------------------------------

insert into #tmp_MSR00010_SC
	Select
	
		pod_prdven  + ' -' + vbi_vensna as 'venno',
		pod_venitm, 
		ibi_itmno,
		ibi_engdsc,
		untcde = ysi_dsc,
		qty = Case @sp when 'P' then pod_ordqty else sod_ordqty end,
		qty_PC =  Case @sp when 'P' then pod_ordqty* isnull(ycf_value, 0) else sod_ordqty* isnull(ycf_value, 0) end,
--		amount = round(Case @sp when 'P' then (Case poh_curcde when 'HKD' then pod_ordqty * pod_ftyprc * @rate else pod_ordqty * pod_ftyprc end)
--			else (Case soh_curcde when 'HKD' then sod_selprc * @rate else sod_selprc end)end,4)
--		Frankie Cheung 20091008
		amount = Round(Case @sp when 'P' then (pod_ordqty * pod_ftyprc * isnull(yce_buyrat,0)) 
			else case soh_curexrat when 0 then 0 else isnull(sod_selprc / soh_curexrat, 0) end end, 4)
	from 	
		SCORDDTL
		left join SYCONFTR on sod_pckunt = ycf_code1  and ycf_code2 = 'PC',
		#tmp_msr00010_SOH, --SCORDHDR, 
		IMBASINF, POORDDTL, POORDHDR, VNBASINF, SYSETINF--,SYCONFTR
		,SYCUREX -- Frankie Cheung 20091008
	where 	
		sod_cocde = soh_cocde and sod_ordno = soh_ordno
	and 	sod_itmno = ibi_itmno
	and	ibi_itmsts<>'CLO'
	and 	sod_cocde = pod_cocde and sod_purord = pod_purord and sod_purseq = pod_purseq
	and 	pod_cocde = poh_cocde and pod_purord = poh_purord
	and 	pod_prdven = vbi_venno
	and 	sod_pckunt = ysi_cde and ysi_typ = '05'
--	and 	sod_pckunt = ycf_code1 and ycf_code2 = 'PC'
	and 	((@ProLineOpt = 'Y' and ibi_lnecde between @proLineFm and @proLineTo) or @ProLineOpt = 'N')
	and 	((@venOpt = 'Y' and pod_prdven between @venFm and @venTo) or @venOpt = 'N')
	and 	((@venItemOpt = 'Y' and pod_venitm between @venItemFm and @venItemTo) or @venItemOpt = 'N')
	AND	VBI_VENTYP <> 'E'
	-- Frankie Cheung 20091008
	and 	yce_frmcur = poh_curcde and yce_tocur = 'USD' and yce_iseff = 'Y'

insert into #tmp_MSR00010_SC
	Select
	
		pod_prdven  + ' -' + vbi_vensna as 'venno',
		pod_venitm, 
		ibi_itmno,
		ibi_engdsc,
		untcde = ysi_dsc,
		qty = Case @sp when 'P' then pod_ordqty else sod_ordqty end,
		qty_PC =  Case @sp when 'P' then pod_ordqty* isnull(ycf_value, 0) else sod_ordqty* isnull(ycf_value, 0) end,
--		amount = round(Case @sp when 'P' then (Case poh_curcde when 'HKD' then pod_ordqty * pod_ftyprc * @rate else pod_ordqty * pod_ftyprc end)
--			else (Case soh_curcde when 'HKD' then sod_selprc * @rate else sod_selprc end)end,4)
--		Frankie Cheung 20091008
		amount = Round(Case @sp when 'P' then (pod_ordqty * pod_ftyprc * isnull(yce_buyrat,0)) 
			else case soh_curexrat when 0 then 0 else isnull(sod_selprc / soh_curexrat, 0) end end, 4)
	from 	
		SCORDDTL
		left join SYCONFTR on sod_pckunt = ycf_code1  and ycf_code2 = 'PC',
		#tmp_msr00010_SOH, --SCORDHDR, 
		IMBASINF, POORDDTL, POORDHDR, VNBASINF, SYSETINF--,SYCONFTR
		, IMCOLINF 
		,SYCUREX -- Frankie Cheung 20091008
	where 	
		sod_cocde = soh_cocde and sod_ordno = soh_ordno
	and 	sod_itmno = ibi_itmno
	and	SOD_COLCDE = ICF_COLCDE and sod_itmno = icf_itmno
	and	ibi_itmsts<>'CLO'
	and 	sod_cocde = pod_cocde and sod_purord = pod_purord and sod_purseq = pod_purseq
	and 	pod_cocde = poh_cocde and pod_purord = poh_purord
	and 	pod_prdven = vbi_venno
	and 	sod_pckunt = ysi_cde and ysi_typ = '05'
--	and 	sod_pckunt = ycf_code1 and ycf_code2 = 'PC'
--	and 	((@ProLineOpt = 'Y' and ibi_lnecde between @proLineFm and @proLineTo) or @ProLineOpt = 'N')
	and 	((@ProLineOpt = 'Y' and icf_lnecde between @proLineFm and @proLineTo) or @ProLineOpt = 'N')
	and 	((@venOpt = 'Y' and pod_prdven between @venFm and @venTo) or @venOpt = 'N')
	and 	((@venItemOpt = 'Y' and pod_venitm between @venItemFm and @venItemTo) or @venItemOpt = 'N')
	AND	VBI_VENTYP = 'E'
	-- Frankie Cheung 20091008
	and 	yce_frmcur = poh_curcde and yce_tocur = 'USD' and yce_iseff = 'Y'


-- Select Alias Item
insert into #tmp_MSR00010_SC
	Select
		pod_prdven  + ' -' + vbi_vensna as 'venno',
		pod_venitm, 
		bas.ibi_itmno,
		bas.ibi_engdsc,
		untcde = ysi_dsc,
		qty = Case @sp when 'P' then pod_ordqty else sod_ordqty end,
		qty_PC =  Case @sp when 'P' then pod_ordqty* isnull(ycf_value, 0) else sod_ordqty* isnull(ycf_value, 0) end,
--		amount = round(Case @sp when 'P' then (Case poh_curcde when 'HKD' then pod_ordqty * pod_ftyprc * @rate else pod_ordqty * pod_ftyprc end)
--			else (Case soh_curcde when 'HKD' then sod_selprc * @rate else sod_selprc end)end,4)
--		Frankie Cheung 20091008
		amount = Round(Case @sp when 'P' then (pod_ordqty * pod_ftyprc * isnull(yce_buyrat,0)) 
			else case soh_curexrat when 0 then 0 else isnull(sod_selprc / soh_curexrat, 0) end end, 4)
	from 	SCORDDTL
		left join SYCONFTR on sod_pckunt = ycf_code1  and ycf_code2 = 'PC',
		#tmp_msr00010_SOH, --SCORDHDR, 
		 POORDDTL, POORDHDR, VNBASINF, SYSETINF,--SYCONFTR,
		IMBASINF bas
		--Added by Mark Lau 20070730
		left join imbasinf als on  als.ibi_itmno =  bas.ibi_alsitmno 
		,SYCUREX -- Frankie Cheung 20091008		
	where 	
		sod_cocde = soh_cocde and sod_ordno = soh_ordno
	and 	sod_itmno = bas.ibi_alsitmno 
	and	bas.ibi_itmsts<>'CLO'
	and 	als.ibi_itmsts <> 'OLD' and als.ibi_itmsts <> 'CLO'
	and 	sod_cocde = pod_cocde and sod_purord = pod_purord and sod_purseq = pod_purseq
	and 	pod_cocde = poh_cocde and pod_purord = poh_purord
	and 	pod_prdven = vbi_venno
	and 	sod_pckunt = ysi_cde and ysi_typ = '05'
	and 	((@ProLineOpt = 'Y' and bas.ibi_lnecde between @proLineFm and @proLineTo) or @ProLineOpt = 'N')
	and 	((@venOpt = 'Y' and pod_prdven between @venFm and @venTo) or @venOpt = 'N')
	and 	((@venItemOpt = 'Y' and pod_venitm between @venItemFm and @venItemTo) or @venItemOpt = 'N')
	AND	VBI_VENTYP <> 'E'
	-- Frankie Cheung 20091008
	and 	yce_frmcur = poh_curcde and yce_tocur = 'USD' and yce_iseff = 'Y'


insert into #tmp_MSR00010_SC
	Select
		pod_prdven  + ' -' + vbi_vensna as 'venno',
		pod_venitm, 
		bas.ibi_itmno,
		bas.ibi_engdsc,
		untcde = ysi_dsc,
		qty = Case @sp when 'P' then pod_ordqty else sod_ordqty end,
		qty_PC =  Case @sp when 'P' then pod_ordqty* isnull(ycf_value, 0) else sod_ordqty* isnull(ycf_value, 0) end,
--		amount = round(Case @sp when 'P' then (Case poh_curcde when 'HKD' then pod_ordqty * pod_ftyprc * @rate else pod_ordqty * pod_ftyprc end)
--			else (Case soh_curcde when 'HKD' then sod_selprc * @rate else sod_selprc end)end,4)
--		Frankie Cheung 20091008
		amount = Round(Case @sp when 'P' then (pod_ordqty * pod_ftyprc * isnull(yce_buyrat,0)) 
			else case soh_curexrat when 0 then 0 else isnull(sod_selprc / soh_curexrat, 0) end end, 4)
	from 	SCORDDTL
		left join SYCONFTR on sod_pckunt = ycf_code1  and ycf_code2 = 'PC',
		#tmp_msr00010_SOH, --SCORDHDR, 
		
		 POORDDTL, POORDHDR, VNBASINF, SYSETINF
		--,SYCONFTR
		, IMCOLINF,
		IMBASINF bas 		
		--Added by Mark Lau 20070730
		left join imbasinf als on  als.ibi_itmno =  bas.ibi_alsitmno 
		,SYCUREX -- Frankie Cheung 20091008		

	where 	
		sod_cocde = soh_cocde and sod_ordno = soh_ordno
	and 	sod_itmno = bas.ibi_alsitmno
	and 	SOD_COLCDE = ICF_COLCDE and sod_itmno = icf_itmno
	and	bas.ibi_itmsts<>'CLO'
	and 	als.ibi_itmsts <> 'OLD' and als.ibi_itmsts <> 'CLO'
	and 	sod_cocde = pod_cocde and sod_purord = pod_purord and sod_purseq = pod_purseq
	and 	pod_cocde = poh_cocde and pod_purord = poh_purord
	and 	pod_prdven = vbi_venno
	and 	sod_pckunt = ysi_cde and ysi_typ = '05'
	and 	((@ProLineOpt = 'Y' and icf_lnecde between @proLineFm and @proLineTo) or @ProLineOpt = 'N')
	and 	((@venOpt = 'Y' and pod_prdven between @venFm and @venTo) or @venOpt = 'N')
	and 	((@venItemOpt = 'Y' and pod_venitm between @venItemFm and @venItemTo) or @venItemOpt = 'N')
	AND	VBI_VENTYP = 'E'
	-- Frankie Cheung 20091008
	and 	yce_frmcur = poh_curcde and yce_tocur = 'USD' and yce_iseff = 'Y'


select 
	@cocde,
	@issueFm,		@issueTo,
	@proLineFm,	@proLineTo,
	@custFm,		@custTo,
	@custNameFm,	@custNameTo,
	@venFm,		@venTo,
	@venItemFm,	@venItemTo,
	@printAmt,
	@qtyText,
	@amtText,
	@sp,
	tmp_venno,
	tmp_venitm,
	tmp_itmno,
	tmp_engdsc,
	tmp_untcde,
	sum(tmp_qty),
	sum(tmp_qtyPC),
	qtyPCstr = str(sum(tmp_qtyPC)),
	sum(tmp_amt),
	--strAmt = str(sum(tmp_amt))
	--@H
	@compName as 'compName'
from #tmp_MSR00010_SC
group by 
	tmp_venno,tmp_venitm,tmp_itmno,tmp_engdsc,tmp_untcde
		
having 	sum(tmp_amt) >  @H

order by 
	tmp_venno,
	Case @sorting when 'Q' then str(sum(tmp_qtyPC)) else '' end desc,
	Case @sorting when 'A' then str(sum(tmp_amt)) else '' end desc,
	Case @sorting when 'I' then tmp_venitm else '' end





GO
GRANT EXECUTE ON [dbo].[sp_select_MSR00010] TO [ERPUSER] AS [dbo]
GO
