/****** Object:  StoredProcedure [dbo].[sp_update_CUPRCINF_risk_credit_used]    Script Date: 09/29/2017 15:29:08 ******/
DROP PROCEDURE [dbo].[sp_update_CUPRCINF_risk_credit_used]
GO
/****** Object:  StoredProcedure [dbo].[sp_update_CUPRCINF_risk_credit_used]    Script Date: 09/29/2017 15:29:10 ******/
SET ANSI_NULLS OFF
GO
SET QUOTED_IDENTIFIER ON
GO




-- Checked by Allan Yuen at 
/*
=========================================================
Program ID	: 	sp_update_CUPRCINF_risk_credit_used
DePOription   	: 	Update CUPRINF Risk & Credit Used
Programmer  	: 	PIC
Create Date   	: 	
Last Modified  	: 
Table Read(s) 	:	
Table Write(s) 	:	
=========================================================
 Modification History                                    
=========================================================
2003-05-20 Allan Yuen Fix Error on select same payment at the same date
2003-06-05 Allan Yuen Reloate Audit Log Table Path
2003-08-10 Lewis To	Change to update Credit Use to CUBCR, not CUPRCINF
2004-02-25 Marco Chan	 Handle new Company PG
2005-02-28 Marco Chan    Handle new Company EW
2005-04-25 Marco Chan    Handle new Company MS
=========================================================     
*/

CREATE Procedure [dbo].[sp_update_CUPRCINF_risk_credit_used]
As

begin

Declare 	
@cocde		nvarchar(6),
@typ			nvarchar(2),
@cpi_cusno		nvarchar(6),
@cpi_amount		numeric(13,2),
@cpr_docno		varchar(20),	
@cpr_txndat		datetime,
@cpr_timestamp		timestamp,

@Date	datetime

/*
select 	@Date = vw.MaxDat
from	(select MaxDat = max(cpr_txndat) from CusCM_UCPP
	union
	select MaxDat = max(cpr_txndat) from CusCM_UCP
	union
	select MaxDat = max(cpr_txndat) from CusPay_UCPP
	union
	select MaxDat = max(cpr_txndat) from CusPay_UCPP) vw

Declare @nExist	int
--select @nExist = count(*) from CUPRCINF_AUD where cpi_credat = @Date
select @nExist = count(*) from UCPERPDB_AUD.DBO.CUPRCINF_AUD where cpi_credat = @Date

If @nExist > 0
begin
	Return 99
end
*/

Set @Date = getdate()

Declare	cur_CUPRCINF cursor
for

select	
	cocde = 'UCPP',
	'PA',
	cpr_cusno,
--	cpr_curcde,
	round(cpr_amount * cy2.ysi_selrat /cy1.ysi_selrat,2),
	cpr_docno,
	cpr_txndat,
	cpr_timestamp

from	CUBASINF, CusPay_UCPP, SYSETINF cy1, SYSETINF cy2, CUPRCINF
where	
	--cbi_cocde = 'UCPP' and 
	cbi_cusno = cpr_cusno
and	--cpi_cocde = cbi_cocde and 
	cpi_cusno = cbi_cusno

--and	cy1.ysi_cocde = 'UCPP' and cy1.ysi_cde = cpi_curcde and cy1.ysi_typ = '06'
--and	cy2.ysi_cocde = 'UCPP' and cy2.ysi_cde = cpr_curcde and cy2.ysi_typ = '06'
and	cy1.ysi_cde = cpi_curcde and cy1.ysi_typ = '06'
and	cy2.ysi_cde = cpr_curcde and cy2.ysi_typ = '06'



and	convert( char(10), cpr_txndat, 101) = convert( char(10), @Date,101)
union
select	cocde = 'UCP',
	'PA',
	cpr_cusno,
--	cpr_curcde,
	round(cpr_amount * cy2.ysi_selrat /cy1.ysi_selrat,2),
	cpr_docno,
	cpr_txndat,
	cpr_timestamp

from	CUBASINF, CusPay_UCP, SYSETINF cy1, SYSETINF cy2, CUPRCINF
where	
	--cbi_cocde = 'UCP' and 
	cbi_cusno = cpr_cusno
and	--cpi_cocde = cbi_cocde and 
	cpi_cusno = cbi_cusno

--and	cy1.ysi_cocde = 'UCP' and cy1.ysi_cde = cpi_curcde and cy1.ysi_typ = '06'
--and	cy2.ysi_cocde = 'UCP' and cy2.ysi_cde = cpr_curcde and cy2.ysi_typ = '06'
and	cy1.ysi_cde = cpi_curcde and cy1.ysi_typ = '06'
and	cy2.ysi_cde = cpr_curcde and cy2.ysi_typ = '06'

and	convert( char(10), cpr_txndat, 101) = convert( char(10), @Date,101)
union
select	cocde = 'PG',
	'PA',
	cpr_cusno,
	round(cpr_amount * cy2.ysi_selrat /cy1.ysi_selrat,2),
	cpr_docno,
	cpr_txndat,
	cpr_timestamp

from	CUBASINF, CusPay_PG, SYSETINF cy1, SYSETINF cy2, CUPRCINF
where	
	cbi_cusno = cpr_cusno
and	cpi_cusno = cbi_cusno
and	cy1.ysi_cde = cpi_curcde and cy1.ysi_typ = '06'
and	cy2.ysi_cde = cpr_curcde and cy2.ysi_typ = '06'
and	convert( char(10), cpr_txndat, 101) = convert( char(10), @Date,101)
union
select	cocde = 'EW',
	'PA',
	cpr_cusno,
	round(cpr_amount * cy2.ysi_selrat /cy1.ysi_selrat,2),
	cpr_docno,
	cpr_txndat,
	cpr_timestamp

from	CUBASINF, CusPay_EW, SYSETINF cy1, SYSETINF cy2, CUPRCINF
where	
	cbi_cusno = cpr_cusno
and	cpi_cusno = cbi_cusno
and	cy1.ysi_cde = cpi_curcde and cy1.ysi_typ = '06'
and	cy2.ysi_cde = cpr_curcde and cy2.ysi_typ = '06'
and	convert( char(10), cpr_txndat, 101) = convert( char(10), @Date,101)
union
select	cocde = 'MS',
	'PA',
	cpr_cusno,
	round(cpr_amount * cy2.ysi_selrat /cy1.ysi_selrat,2),
	cpr_docno,
	cpr_txndat,
	cpr_timestamp

from	CUBASINF, CusPay_MS, SYSETINF cy1, SYSETINF cy2, CUPRCINF
where	
	cbi_cusno = cpr_cusno
and	cpi_cusno = cbi_cusno
and	cy1.ysi_cde = cpi_curcde and cy1.ysi_typ = '06'
and	cy2.ysi_cde = cpr_curcde and cy2.ysi_typ = '06'
and	convert( char(10), cpr_txndat, 101) = convert( char(10), @Date,101)
union
select	cocde = 'UCPP',
	'CM',
	cpr_cusno,
--	cpr_curcde,
	round(cpr_amount * cy2.ysi_selrat /cy1.ysi_selrat,2),
	cpr_docno,
	cpr_txndat,
	cpr_timestamp

from	CUBASINF, CusCM_UCPP, SYSETINF cy1, SYSETINF cy2, CUPRCINF
where	
	--cbi_cocde = 'UCPP' and 
	cbi_cusno = cpr_cusno
and	--cpi_cocde = cbi_cocde and 
	cpi_cusno = cbi_cusno

--and	cy1.ysi_cocde = 'UCPP' and cy1.ysi_cde = cpi_curcde and cy1.ysi_typ = '06'
--and	cy2.ysi_cocde = 'UCPP' and cy2.ysi_cde = cpr_curcde and cy2.ysi_typ = '06'
and	cy1.ysi_cde = cpi_curcde and cy1.ysi_typ = '06'
and	cy2.ysi_cde = cpr_curcde and cy2.ysi_typ = '06'



and	convert( char(10), cpr_txndat, 101) = convert( char(10), @Date,101)
union
select	cocde = 'UCP',
	'CM',
	cpr_cusno,
--	cpr_curcde,
	round(cpr_amount * cy2.ysi_selrat /cy1.ysi_selrat,2),
	cpr_docno,
	cpr_txndat,
	cpr_timestamp

from	CUBASINF, CusCM_UCP, SYSETINF cy1, SYSETINF cy2, CUPRCINF
where	
	--i_cocde = 'UCP' and 
	cbi_cusno = cpr_cusno
and	--cpi_cocde = cbi_cocde and 
	cpi_cusno = cbi_cusno

--and	cy1.ysi_cocde = 'UCP' and cy1.ysi_cde = cpi_curcde and cy1.ysi_typ = '06'
--and	cy2.ysi_cocde = 'UCP' and cy2.ysi_cde = cpr_curcde and cy2.ysi_typ = '06'
and	cy1.ysi_cde = cpi_curcde and cy1.ysi_typ = '06'
and	cy2.ysi_cde = cpr_curcde and cy2.ysi_typ = '06'


and	convert( char(10), cpr_txndat, 101) = convert( char(10), @Date,101)
union
select	cocde = 'PG',
	'CM',
	cpr_cusno,
--	cpr_curcde,
	round(cpr_amount * cy2.ysi_selrat /cy1.ysi_selrat,2),
	cpr_docno,
	cpr_txndat,
	cpr_timestamp

from	CUBASINF, CusCM_PG, SYSETINF cy1, SYSETINF cy2, CUPRCINF
where	
	cbi_cusno = cpr_cusno
and	cpi_cusno = cbi_cusno
and	cy1.ysi_cde = cpi_curcde and cy1.ysi_typ = '06'
and	cy2.ysi_cde = cpr_curcde and cy2.ysi_typ = '06'
and	convert( char(10), cpr_txndat, 101) = convert( char(10), @Date,101)
union
select	cocde = 'EW',
	'CM',
	cpr_cusno,
--	cpr_curcde,
	round(cpr_amount * cy2.ysi_selrat /cy1.ysi_selrat,2),
	cpr_docno,
	cpr_txndat,
	cpr_timestamp

from	CUBASINF, CusCM_EW, SYSETINF cy1, SYSETINF cy2, CUPRCINF
where	
	cbi_cusno = cpr_cusno
and	cpi_cusno = cbi_cusno
and	cy1.ysi_cde = cpi_curcde and cy1.ysi_typ = '06'
and	cy2.ysi_cde = cpr_curcde and cy2.ysi_typ = '06'
and	convert( char(10), cpr_txndat, 101) = convert( char(10), @Date,101)
union
select	cocde = 'MS',
	'CM',
	cpr_cusno,
--	cpr_curcde,
	round(cpr_amount * cy2.ysi_selrat /cy1.ysi_selrat,2),
	cpr_docno,
	cpr_txndat,
	cpr_timestamp

from	CUBASINF, CusCM_MS, SYSETINF cy1, SYSETINF cy2, CUPRCINF
where	
	cbi_cusno = cpr_cusno
and	cpi_cusno = cbi_cusno
and	cy1.ysi_cde = cpi_curcde and cy1.ysi_typ = '06'
and	cy2.ysi_cde = cpr_curcde and cy2.ysi_typ = '06'
and	convert( char(10), cpr_txndat, 101) = convert( char(10), @Date,101)



Open cur_CUPRCINF
Fetch next from cur_CUPRCINF into
@cocde,
@typ,
@cpi_cusno,
@cpi_amount,
@cpr_docno,		
@cpr_txndat,
@cpr_timestamp

While @@fetch_status = 0
begin
	Update	CUBCR -- CUPRCINF
	set	cbc_rskuse = cbc_rskuse - @cpi_amount,
		cbc_cdtuse = cbc_cdtuse - @cpi_amount,
		cbc_upddat = @Date,
		cbc_updusr = 'SYSTEM'
	where	
		cbc_cocde = @cocde and 
		cbc_cusno = @cpi_cusno

	Fetch next from cur_CUPRCINF into
	@cocde,
	@typ,
	@cpi_cusno,
	@cpi_amount,
	@cpr_docno,		
	@cpr_txndat,
	@cpr_timestamp

end
Close cur_CUPRCINF
Deallocate cur_CUPRCINF

end





GO
GRANT EXECUTE ON [dbo].[sp_update_CUPRCINF_risk_credit_used] TO [ERPUSER] AS [dbo]
GO
