/****** Object:  StoredProcedure [dbo].[sp_select_MSR00036]    Script Date: 09/29/2017 15:29:09 ******/
DROP PROCEDURE [dbo].[sp_select_MSR00036]
GO
/****** Object:  StoredProcedure [dbo].[sp_select_MSR00036]    Script Date: 09/29/2017 15:29:10 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO


/***************************************************************************************************************************
Program ID	: sp_select_MSR00036
Programmer 	: Lester Wu
Description		: Show Customer's Shipping Summary Records 
***************************************************************************************************************************
Modification History
***************************************************************************************************************************
Modified by		Modified on		Description
***************************************************************************************************************************

***************************************************************************************************************************/
--sp_select_MSR00036 'UCP','50015','50015','','Z','01/01/2005','01/31/2005','','MIS'

create procedure [dbo].[sp_select_MSR00036]
@cocde	as varchar(6), 
@CNF	as varchar(20), 
@CNT	as varchar(20), 
@CNF2	as varchar(20), 
@CNT2	as varchar(20), 
@ETDFm	as varchar(10), 
@ETDTo	as varchar(10),
@CUSTPO	as varchar(6) , 
@chkExport	as char(1) , 
@gsUsrID	as varchar(30)
as
Begin
	
	-- Lester Wu 2005-11-28
	Declare @COMPNAME as varchar(100) 

	set @COMPNAME = 'UNITED CHINESE GROUP'
	if @cocde <> 'UC-G' 
	begin
		select @COMPNAME = yco_conam from SYCOMINF where yco_cocde = @cocde
	end
		

	--Lester Wu 2005-11-24, add search by OD/OP 
	Declare @CUSTPO_tmp as varchar(8)
	
	set @CUSTPO_tmp = ''
	if ltrim(rtrim(@CUSTPO)) <> ''
	begin
		set @CUSTPO_tmp = '%' + ltrim(rtrim(@CUSTPO)) + '%'
	end

	

	select 
		hih_cus1no as '_Cus1No', 
		hih_cus2no as '_Cus2No', 
		Case isnull(ltrim(hid_pckrmk), '') when '' then isnull(hid_ctrsiz,'OTH') else isnull(hid_ctrsiz,'OTH') + '  - ' + isnull(hid_pckrmk,'') end as '_CtrSiz',
		sum(isnull(hid_ttlvol,0)) as '_TtlCBM' , 
		isnull(hid_ctrcfs,'') as '_CtrCfs' , 
		isnull(hid_invno,'') as '_InvNo'	
		--hid_shpno,
		--hih_slnonb
	into 
		#TMP_CTR
	
	from 
		SHIPGHDR(Nolock)
		left join SHIPGDTL(Nolock) on hih_cocde = hid_cocde and hih_shpno = hid_shpno
	where 
		(@ETDFm = '01/01/1900'  or (@ETDFm <> '01/01/1900' and hih_slnonb between @ETDFm and @ETDTo)) and 
		(@CNF = '' or (@CNF <> '' and hih_cus1no between @CNF and @CNT )) and 
		(@CNF2 = '' or (@CNF2 <> '' and hih_cus2no between @CNF2 and @CNT2  ))
		--Lester Wu 2005-11-16
		and (@cocde = 'UC-G' or hih_cocde = @cocde)
		-- Lester Wu 2005-11-24
		and (@CUSTPO_tmp  = '' or hid_cuspo like @CUSTPO_tmp )
		-- Lester Wu 2005-11-26
		and hid_invno is not null
	group by 
		hih_cus1no, 
		hih_cus2no,
		Case isnull(ltrim(hid_pckrmk), '') when '' then isnull(hid_ctrsiz,'OTH') else isnull(hid_ctrsiz,'OTH') + '  - ' + isnull(hid_pckrmk,'') end , 
		isnull(hid_ctrcfs,'') , 
		isnull(hid_invno,'')
	
	
	--select * from #TMP_CTR

	select  _Cus1No, _Cus2No, _CtrSiz, count(1) as '_Cnt'
	into #TMP_CTR_CTRCNT
	from (
	select distinct _Cus1No, _Cus2No, _CtrSiz, case _CtrCfs when '' then _InvNo else _CtrCfs end as '_Ctr'
	from #TMP_CTR
	) _a
	group by _Cus1No, _Cus2No, _CtrSiz
	

	--select * from #TMP_CTR_CTRCNT
	
	select  _Cus1No, _Cus2No, _CtrSiz, count(1) as '_Cnt'
	into #TMP_CTR_INVCNT
	from (
	select distinct _Cus1No, _Cus2No, _CtrSiz,  _InvNo 
	from #TMP_CTR
	) _b
	group by _Cus1No, _Cus2No, _CtrSiz
	order by _CtrSiz
	
	--select * from #TMP_CTR_INVCNT
	
	select a._Cus1No as '_PriCust', a._Cus2No as '_SecCust', a._CtrSiz as '_CtrSiz', sum(a._TtlCBM) as '_TtlCBM', ctr._Cnt as '_TtlCtrCnt', inv._Cnt as '_TtlInvCnt'
	into #RESULT
	from #TMP_CTR   a
	Left Join #TMP_CTR_CTRCNT ctr on  a._Cus1No = ctr._Cus1No and a. _Cus2No = ctr. _Cus2No and a. _CtrSiz = ctr. _CtrSiz
	Left Join #TMP_CTR_INVCNT inv  on  a._Cus1No = inv._Cus1No and a. _Cus2No = inv. _Cus2No and a. _CtrSiz = inv. _CtrSiz
	Left Join CUBASINF pri on a._Cus1No = pri.cbi_cusno
	Left Join CUBASINF sec on a._Cus2No = sec.cbi_cusno
	group by a._Cus1No, a._Cus2No, a._CtrSiz, ctr._Cnt, inv._Cnt
	
	
	if @chkExport = '1' 
	begin
		select  
			_PriCust + ' - ' + pri.cbi_cussna as 'Primary Customer', 
			case isnull(_SecCust,'') when '' then '' else _SecCust + ' - ' + sec.cbi_cussna end as 'Secondary Customer' ,
			_CtrSiz as 'Container Size',
			_TtlCBM as 'Total CBM',
			--_TtlCtrCnt as 'No of Container',
			case _CtrSiz when 'CFS' then 0 else _TtlCtrCnt end  as 'No of Container',
			_TtlInvCnt as 'No of Invoice'
		
		from 
		
			#RESULT
			left join CUBASINF pri on pri.cbi_cusno = _PriCust
			left join CUBASINF sec on sec.cbi_cusno = _SecCust
		order by 
			_PriCust, _SecCust, _CtrSiz
	end
	else
	begin
		select  
			_PriCust + ' - ' + pri.cbi_cussna as 'Primary Customer', 
			case isnull(_SecCust,'') when '' then '' else _SecCust + ' - ' + sec.cbi_cussna end as 'Secondary Customer' ,
			_CtrSiz as 'Container Size',
			_TtlCBM as 'Total CBM',
			--_TtlCtrCnt as 'No of Container',
			case _CtrSiz when 'CFS' then 0 else _TtlCtrCnt end  as 'No of Container',
			_TtlInvCnt as 'No of Invoice' , 
			@ETDFm as 'ETDFrom' , 
			@ETDTo	as 'ETDTo'  , 
			@COMPNAME as 'COMPNAME'
		
		from 
		
			#RESULT
			left join CUBASINF pri on pri.cbi_cusno = _PriCust
			left join CUBASINF sec on sec.cbi_cusno = _SecCust
		order by 
			_PriCust, _SecCust, _CtrSiz
	end	
	
	drop table #RESULT
	drop table #TMP_CTR
	drop table #TMP_CTR_CTRCNT
	drop table #TMP_CTR_INVCNT
	
End	





GO
GRANT EXECUTE ON [dbo].[sp_select_MSR00036] TO [ERPUSER] AS [dbo]
GO
