/****** Object:  StoredProcedure [dbo].[sp_select_MSR00012_NET]    Script Date: 09/29/2017 15:29:09 ******/
DROP PROCEDURE [dbo].[sp_select_MSR00012_NET]
GO
/****** Object:  StoredProcedure [dbo].[sp_select_MSR00012_NET]    Script Date: 09/29/2017 15:29:10 ******/
SET ANSI_NULLS OFF
GO
SET QUOTED_IDENTIFIER OFF
GO










-- Checked by Allan Yuen at 27/07/2003
/*
Modification History
-----------------------------------------------------------------------------------------------------------------------------------------------------------
Modified by	Modified on	Description
-----------------------------------------------------------------------------------------------------------------------------------------------------------
Lester Wu		Feb 12 , 2004	ADD "ALL" COMPANY SELECTION and SECONDARY CUSTOMER SELECTION

Lester Wu		2004/03/08		Add access control on sales team
				Users can obtain the requested data if ;
				1)users are of the same team of the customer's sales representative / 
				2)users without a sales team / 
				3)users belongs to sales team 'S' 

Lester Wu		2005-03-21	Replace "ALL" with "UC-G"
				Cater "MS - Magic Silk" company
				Retrieve Company name from databse

Lester Wu		2005-06-02	Apply new logic for ship date range selection
*/

/************************************************************************
Author:		Kenny Chan
************************************************************************/
CREATE  PROCEDURE [dbo].[sp_select_MSR00012_NET] 

@cocde nvarchar(6),
@CustFrom nvarchar(6),
@CustTo nvarchar(6),
--@SecCustFrom nvarchar(6),
--@SecCustTo nvarchar(6),
@SecCust	nvarchar(1),
@ShpFrom datetime,
@ShpTo datetime,
@Sort	nvarchar(20)
,@SalTem	nvarchar(7)


AS

/*declare 
@SecCustOpt	nvarchar(1)

SET @SecCustOpt = 'N'
If @SecCustFrom<>'' and @SecCustTo<> ''
begin
	SET @SecCustOpt = 'Y'
end
*/
SET @ShpTo = @ShpTo + ' 23:59:59.988'

-- Lester Wu 2004/03/08
SET @SalTem = replace(@SalTem,'_','')
--------------
--Lester Wu 2005-03-21 Retrieve Company information from database
declare @compName as varchar(100)
set @compName = 'UNITED CHINESE GROUP'
if @cocde <> 'UC-G' 
begin
	select @compName = yco_conam from SYCOMINF where yco_cocde = @cocde
end 


Select 	@Sort as 'Sort'	,@cocde as 'cocde' ,		@CustFrom as 'CustFrom' ,	@CustTo as 'CustTo' ,	
	-- 2004/02/11 Lester Wu
	--@SecCustFrom as 'SecCustFrom' ,	@SecCustTo as 'SecCustTo' ,	
	-----------------------------
	-- 2004/02/17 Lester Wu
	@SecCust as 'SecCust',
	-----------------------------
	convert(varchar(10),@ShpFrom,101) as 'DateFrom',	
	convert(varchar(10),@ShpTo,101) as 'DateTo', 
	soh_cus1no,	Isnull(a.cbi_cussna,'') as 'soh_cus1nam', 	
	--soh_cus2no ,	Isnull(b.cbi_cussna,'') as 'soh_cus2nam', 	
	case @SecCust when 'Y' then isnull(soh_cus2no,'') else '' end as 'soh_cus2no' ,
	case @SecCust when 'Y' then Isnull(b.cbi_cussna,'') else '' end  as 'soh_cus2nam', 	
	soh_curcde , 
	Round(Sum((sod_ordqty-sod_shpqty) *sod_untprc),2) as 'sod_OrdAmt' ,	convert(varchar,min(sod_shpstr),103) as 'sod_Eshp' , convert(varchar,max(sod_shpend),103) as 'sod_Lshp' , 
	convert(varchar,max(soh_issdat),103) as 'sod_LOrd' , 	
	(Select convert(varchar,Max(hiv_invdat),103) 
	From 
		SHIPGHDR,SHINVHDR 
	Where hih_cocde = hiv_cocde and hih_shpno = hiv_shpno
	and hih_cus1no = soh_cus1no 
	--and hih_cus2no = soh_cus2no
	and case @SecCust when 'Y' then isnull(hih_cus2no,'') else '' end = case @SecCust when 'Y' then isnull(soh_cus2no,'') else '' end
	group by hih_cus1no,
	case @SecCust when 'Y' then isnull(hih_cus2no,'') else '' end
	) as 'sod_LInv' ,
	Case soh_curcde When 'HKD' then Round(Sum((sod_ordqty-sod_shpqty) *sod_untprc),2) else 0 end as 'TotalHKD',
	Case soh_curcde When 'USD' then Round(Sum((sod_ordqty-sod_shpqty) *sod_untprc),2) else  0 end as 'TotalUSD'
	
	--Lester Wu 2005-03-21 Retrieve company information form database
	,@compName as 'compName'

From SCORDDTL,SCORDHDR
--left join CUBASINF a on a.cbi_cocde = @cocde and a.cbi_cusno = soh_cus1no 
--left join CUBASINF b on b.cbi_cocde = @cocde and b.cbi_cusno = soh_cus2no 
left join CUBASINF a on a.cbi_cusno = soh_cus1no 
left join CUBASINF b on b.cbi_cusno = soh_cus2no 

-- 2004/03/08 Lester Wu
left join SYSALREP sal on a.cbi_salrep = sal.ysr_code1
-------------------------------------------------------------------

Where 	soh_ordsts <> 'CAN' and
	-- 2004/02/12 Lester Wu
	--sod_cocde = @cocde  and 
	
--Lester Wu 2005-03-21 Cater "MS - Magic Silk" company and replace "ALL" with "UC-G"
--(@cocde='ALL' or soh_cocde=@cocde) and 
((@cocde<>'UC-G' and  soh_cocde = @cocde)  or (@cocde = 'UC-G' and soh_cocde<>'MS')) and
------------------------------------------------
	----------------------------------
	soh_cocde = sod_cocde and
	soh_ordno = sod_ordno and
	(sod_ordqty - sod_shpqty) > 0 and
	soh_cus1no Between @CustFrom and @CustTo and
	--2004/02/12 Lester Wu ------------------------------------
	--((@SecCustOpt='Y' and soh_cus2no Between @SecCustFrom and @SecCustTo) or @SecCustOpt='N') and
	------------------------------------------------------------------
	--Lester Wu 2005-06-02, apply new logic for ship date range selection
	--soh_shpstr Between @ShpFrom and @ShpTo
	(
	soh_shpstr Between @ShpFrom and @ShpTo
	or 
	soh_shpend Between @ShpFrom and @ShpTo
	or
	(soh_shpstr < @ShpFrom and soh_shpend > @ShpTo  )
	)
	-- 2004/03/08 Lester Wu
	and (@SalTem='' or @SalTem='S' or isnull(sal.ysr_saltem,'')=@SalTem)
	------------------------------

group by soh_cus1no, a.cbi_cussna, 
case @SecCust when 'Y' then isnull(soh_cus2no,'') else '' end , 
case @SecCust when 'Y' then isnull(b.cbi_cussna,'') else '' end , 
soh_curcde
order by soh_curcde










GO
GRANT EXECUTE ON [dbo].[sp_select_MSR00012_NET] TO [ERPUSER] AS [dbo]
GO
