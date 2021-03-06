/****** Object:  StoredProcedure [dbo].[sp_select_MSR00019]    Script Date: 09/29/2017 15:29:09 ******/
DROP PROCEDURE [dbo].[sp_select_MSR00019]
GO
/****** Object:  StoredProcedure [dbo].[sp_select_MSR00019]    Script Date: 09/29/2017 15:29:10 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO







/***********************************************************************************************************************************************
Modification History
************************************************************************************************************************************************
Modified by		Modified on		Description
************************************************************************************************************************************************
Lester Wu			2005-04-02		replace ALL with UC-G, exclude MS from UC-G, retrieve company name from database
************************************************************************************************************************************************/
--sp_select_MSR00019 'UC-G', 'US1000001','US1000005','','','','','','','','','','','','ALL','EXCEL','mis'



-- Checked by Allan Yuen at 27/07/2003


CREATE  PROCEDURE [dbo].[sp_select_MSR00019] 


	@cocde 		nvarchar(6),
	@SCfrom		nvarchar(10),
	@SCto		nvarchar(10),
	@DateFrom	nvarchar(30),
	@DateTo		nvarchar(30),
	@PCCfrom	nvarchar(20),
	@PCCto		nvarchar(20),
	@PCC2from	nvarchar(20),
	@PCC2to		nvarchar(20),
	@PayTrm		nvarchar(1),
	@PrintAmt	nvarchar(1),
	@ShpFrom	nvarchar(30),
	@ShpTo		nvarchar(30),
	@Sort		nvarchar(20),
	@SCstatus	nvarchar(20),
	@RptType	nvarchar(10),
	@user		nvarchar(30)
AS


Declare 
	@optDate		nvarchar(1),
	@optSC		nvarchar(1),
	@optPCC		nvarchar(1),
	@optPCC2	nvarchar(1),
	@optShpDate	nvarchar(1)


set @optDate = 'N'
	If @DateFrom = '' and @DateTo = ''
	begin
		set @optDate = 'Y'
	end

set @optSC = 'N'
	If @SCfrom = '' and @SCto = ''
	begin
		set @optSC = 'Y'
	end

set @optPCC = 'N'
	If @PCCfrom = '' and @PCCto = ''
	begin
		set @optPCC = 'Y'
	end

set @optPCC2 = 'N'
	If @PCC2from = '' and @PCC2to = ''
	begin
		set @optPCC2 = 'Y'
	end

set @optShpdate = 'N'
	If @ShpFrom = '' and @ShpTo = ''
	begin
		set @optShpdate = 'Y'
	end


-- Lester Wu 2005-03-31, retrieve company name from database -------------------------------------
declare @compName varchar(100)
set @compName = 'UNITED CHINESE GROUP'
if @cocde <> 'UC-G'
begin
	select @compName = yco_conam from sycominf where yco_cocde = @cocde
end
-------------------------------------------------------------------------------------------------------------------

------------------------------------------------------------

declare @usrgrp as nvarchar(20)

select @usrgrp = yuc_usrgrp from SYMUSRCO where yuc_usrid = @user and yuc_flgdef = 'Y'


if @RptType = 'EXCEL'
begin

SELECT 
soh_ordno as 'S/C No.',
soh_ordsts as 'Status',
soh_verno as 'Version No.',
isnull(p.cbi_cusno,'') as 'Pri Cust No.',
isnull(p.cbi_cussna,'') as 'Primary Customer',
isnull(s.cbi_cusno,'') as 'Sec Cust No.',
isnull(s.cbi_cussna,'') as 'Secondary Customer',
soh_cuspo as 'Customer PO No.',
convert(nvarchar(20), soh_issdat, 101) as 'Issue Date',
convert(nvarchar(20), soh_cpodat,101) as 'Customer PO Date',
isnull(ysi_dsc,'') as 'Payment Term',
convert(nvarchar(20), soh_shpstr, 101) + ' - ' + convert(nvarchar(20), soh_shpend, 101) as 'Ship Start & End Date',
soh_curcde as 'Currency',
soh_ttlamt as 'Total Amount',
soh_ttlvol as 'Total Cube (CBM)',
soh_ttlctn as 'Total Carton',
isnull(ltrim(smm.ssm_imgnam),'') as 'Main Ship Mark',
isnull(ltrim(sms.ssm_imgnam),'') as 'Side Ship Mark',
isnull(ltrim(smi.ssm_imgnam),'') as 'Inner Ship Mark',
soh_cttper as 'Contact Person'
FROM SCORDHDR
left join SCSHPMRK smm on soh_cocde = smm.ssm_cocde and soh_ordno = smm.ssm_ordno and smm.ssm_shptyp = 'M'
left join SCSHPMRK sms on soh_cocde = sms.ssm_cocde and soh_ordno = sms.ssm_ordno and sms.ssm_shptyp = 'S'
left join SCSHPMRK smi on soh_cocde = smi.ssm_cocde and soh_ordno = smi.ssm_ordno and smi.ssm_shptyp = 'I'
left join VW_CUSALI vwp on soh_cus1no = vwp.vw_cbi_cusno
left join CUBASINF p on vwp.vw_cbi_cusali = p.cbi_cusno  
left join SYSALREP on p.cbi_salrep = ysr_code1 and ysr_cocde = ' '
left join VW_CUSALI vws on soh_cus2no = vws.vw_cbi_cusno
left join CUBASINF s on vws.vw_cbi_cusali = s.cbi_cusno  
left join SYSETINF on soh_paytrm = ysi_cde and ysi_typ = '04'

WHERE 
((@cocde='UC-G' and soh_cocde<>'MS' ) or soh_cocde=@cocde)
---------------------------------------
and 	soh_ordsts = case when @SCstatus = 'ALL' then soh_ordsts else @SCstatus end
and ((@optDate = 'N' and soh_issdat between @DateFrom and @DateTo) or @optDate = 'Y')
and 	((@optSC = 'N' and soh_ordno between @SCfrom and @SCto) or @optSC = 'Y')
and 	((@optPCC = 'N' and vwp.vw_cbi_cusali between @PCCfrom and @PCCto) or @optPCC = 'Y')
and 	((@optPCC2 = 'N' and vws.vw_cbi_cusali between @PCC2from and @PCC2to) or @optPCC2 = 'Y')
and 	((@optShpdate = 'N' and soh_shpstr between @ShpFrom and @ShpTo) or @optShpdate = 'Y')
and 	(	
		exists
		(	
			select 1 from syusrright
			where yur_usrid = @user  and yur_doctyp = 'SC' and yur_lvl = 0
		)
		or ysr_saltem in 
		(	
			select yur_para from syusrright
			where yur_usrid = @user and yur_doctyp = 'SC' and yur_lvl = 1
		)
		or soh_cus1no in 
		(
			select yur_para from syusrright
			where yur_usrid = @user and yur_doctyp = 'SC' and yur_lvl = 2
		)
	)
ORDER BY soh_ordno


end
else
begin

SELECT 
	-- Parameter
	@cocde,	
	@SCfrom,	@SCto,
	@DateFrom,	@DateTo,
	@PCCfrom,	@PCCto,
--	@PCC2from,	@PCC2to,
	@ShpFrom,	@ShpTo,	
	
case when @SCstatus = 'ALL' then 'ALL - All Status' else
case when @SCstatus = 'ACT' then 'ACT - Active' else
case when @SCstatus = 'HLD' then 'HLD - Waiting for Approval' else
case when @SCstatus = 'REL' then 'REL - Released' else
case when @SCstatus = 'CAN' then 'CAN - Cancel' else
case when @SCstatus = 'CLO' then 'CLO - Close' else
'ERR' end end end end end end as 'SCstatus',

	@Sort, 		@PayTrm,
--	@PrintAmt,

	-- SCOPDHDR
	soh_verno, 	soh_ordsts,
	soh_ordno, 	soh_cuspo,		
	soh_issdat,		soh_shpstr,		soh_shpend,	

	case @usrgrp when 'SAL-ZG' then '' when 'SAL-ZE' then '' else soh_curcde end as 'soh_curcde',	
	case @usrgrp when 'SAL-ZG' then 0 when 'SAL-ZE' then 0 else soh_ttlamt end as 'soh_ttlamt',
	case @usrgrp when 'SAL-ZG' then 0 when 'SAL-ZE' then 0 else soh_netamt end as 'soh_netamt',
	

	-- CUBASINF Primary
	isnull(p.cbi_cusno,'') as 'cbi_pri_cusno',		isnull(p.cbi_cussna,'') as 'cbi_pri_custnam',

	-- CUBASINF Secondary
	isnull(s.cbi_cusno,'') as 'cbi_sec_cusno',		isnull(s.cbi_cussna,'') as 'cbi_sec_custnam',

	Isnull(ysi_dsc,'') as 'ysi_dsc',

	isnull(ltrim(smm.ssm_imgnam),'') as 'smm.ssm_imgnam',
	isnull(ltrim(sms.ssm_imgnam),'') as 'sms.ssm_imgnam',
	isnull(ltrim(smi.ssm_imgnam),'') as 'smi.ssm_imgnam',
	@compName as 'compName'

FROM SCORDHDR
left join SCSHPMRK smm on soh_cocde = smm.ssm_cocde and soh_ordno = smm.ssm_ordno and smm.ssm_shptyp = 'M'
left join SCSHPMRK sms on soh_cocde = sms.ssm_cocde and soh_ordno = sms.ssm_ordno and sms.ssm_shptyp = 'S'
left join SCSHPMRK smi on soh_cocde = smi.ssm_cocde and soh_ordno = smi.ssm_ordno and smi.ssm_shptyp = 'I'
left join VW_CUSALI vwp on soh_cus1no = vwp.vw_cbi_cusno
left join CUBASINF p on vwp.vw_cbi_cusali = p.cbi_cusno  
left join SYSALREP on p.cbi_salrep = ysr_code1 and ysr_cocde = ' '
left join VW_CUSALI vws on soh_cus2no = vws.vw_cbi_cusno
left join CUBASINF s on vws.vw_cbi_cusali = s.cbi_cusno  
left join SYSETINF on soh_paytrm = ysi_cde and ysi_typ = '04'

WHERE 
((@cocde='UC-G' and soh_cocde<>'MS' ) or soh_cocde=@cocde)
---------------------------------------
and 	soh_ordsts = case when @SCstatus = 'ALL' then soh_ordsts else @SCstatus end
and ((@optDate = 'N' and soh_issdat between @DateFrom and @DateTo) or @optDate = 'Y')
and 	((@optSC = 'N' and soh_ordno between @SCfrom and @SCto) or @optSC = 'Y')
and 	((@optPCC = 'N' and vwp.vw_cbi_cusali between @PCCfrom and @PCCto) or @optPCC = 'Y')
and 	((@optPCC2 = 'N' and vws.vw_cbi_cusali between @PCC2from and @PCC2to) or @optPCC2 = 'Y')
and 	((@optShpdate = 'N' and soh_shpstr between @ShpFrom and @ShpTo) or @optShpdate = 'Y')
and 	(	
		exists
		(	
			select 1 from syusrright
			where yur_usrid = @user  and yur_doctyp = 'SC' and yur_lvl = 0
		)
		or ysr_saltem in 
		(	
			select yur_para from syusrright
			where yur_usrid = @user and yur_doctyp = 'SC' and yur_lvl = 1
		)
		or soh_cus1no in 
		(
			select yur_para from syusrright
			where yur_usrid = @user and yur_doctyp = 'SC' and yur_lvl = 2
		)
	)
ORDER BY soh_ordno

end


GO
GRANT EXECUTE ON [dbo].[sp_select_MSR00019] TO [ERPUSER] AS [dbo]
GO
