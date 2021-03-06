/****** Object:  StoredProcedure [dbo].[sp_insert_BAINVDTL]    Script Date: 09/29/2017 15:29:09 ******/
DROP PROCEDURE [dbo].[sp_insert_BAINVDTL]
GO
/****** Object:  StoredProcedure [dbo].[sp_insert_BAINVDTL]    Script Date: 09/29/2017 15:29:09 ******/
SET ANSI_NULLS OFF
GO
SET QUOTED_IDENTIFIER OFF
GO



















-- Checked by Allan Yuen at 28/07/2003

/****** Object:  Stored Procedure dbo.sp_insert_BAINVDTL    Script Date: 04/01/2003 9:33:31 ******/

--*************************************************************
--*Description	: Extract Invoice, Sample Invoice & Elliwell Invoice to File
--*		: It is assumed that the posting date will be 15 & 31 of each month
--*Input File 	: SHINVHDR, SHIPGDTL, SYCOMINF, SYDISPRM
--*Output File	: BAINVDTL
--*Create Date	: 2002-07-23
--*Create By	: Solo So
--*************************************************************
/*
=========================================================
 Modification History                                    
=========================================================
Date		Name		Description
25 Apr 2003	Lewis To		Add case for Shipping Invoice: (Shipping Status = REL in shipping header)  and 
							(last update date in invoice table within this week)
15 Aug 2003	Lewis To		Clear the Company Code of CUPRCINF for let it check the  SAINVHDR
				               
29 Sept 2003	Marco Chan		Profit Center Account Interface Implementation

17 Oct 2003	Marco Chan	For Inv with VenCode 0005 not use Profit Center Account

20 Oct 2003	Marco Chan	For SA, guard for SAINVHDR create date with 10/1 using Profit Center logic rather than SAINVDTL create date with 10/1 (case of Amelia's email at 20031020)

15 Nov 2003	Marco Chan	Fix SA bug , missing change sid_credat to sih_credat 

05 Dec 2003	Marco Chan	Fix for SA, rounding difference 0.01 problem

09 Dec 2003	Marco Chan 	Enhance with Product Line Information search for Profit Center
				Fix for not use Profit Center Account with VenCode 0005 to 0009

01 Feb 2004	Marco Chan	Fix for handling invoice with no details (deleted)

20 Feb 2004	Marco Chan	Fix for handling PG company

17 May 2004	Marco Chan	Send Transaction to Navision for transaction amount has no change

17 Feb 2005	Marco Chan	Modify for the adjustment method in Sample Invoice by using sum of detail instead of header amount

28 Feb 2005	Marco Chan	Handle EW Company

25 Apr 2005	Marco Chan	Handle MS Company

12 Jun 2005	Marco Chan	Fix for Invoice deleted without send 0 to Navision problem

10 Aug 2005	Marco Chan	Fix for handling invoice with Manufacturer Name bug

15 Oct 2005	Marco Chan	Fix for changing v_select_inr00001 bug

23 Mar 2009	Marco Chan	Change use ETD Date instead of Invoice Date to Navision
				For Invoice Date >= 2009-03-23, use ETD Date

8 July 2009	Marco Chan	For every month 15th generate Invoice batch

5 Oct 2010	Marco Chan	Remove 2003 UCP UCPP Item logic to solve the bug for OLD to NEW item
=========================================================     
*/
CREATE PROCEDURE [dbo].[sp_insert_BAINVDTL] 
AS

Begin

Declare 
@dateFm	datetime,
@dateFm_A	datetime,
@dateTo	datetime,

@Post_flag	nvarchar(1),
@Post_flag_A	nvarchar(1)


--Get Last Posting Date from Header Record of BAINVDTL
Select 	@dateFm = bid_txndat,
	@dateFm_A = bid_issdat
From 	BAINVDTL where bid_cocde = 'AHEAD'

Set @dateTo = Convert(char(10), getdate()-1, 101)  +   ' 23:59:59.998'

--For testing use only to enable SH task
--Set @dateTo = '2010-10-03 23:59:59.998'

Set @Post_flag = 'N'
--if datepart(dw,getdate()) = 2  or datepart(dd,getdate()) = 15	-- Monday or 15th
-- changed to Monday or 5th at 20140610
if datepart(dw,getdate()) = 2  or datepart(dd,getdate()) = 5	-- Monday or 15th
begin
	Set @Post_flag = 'Y'
end
Set @post_flag_A = 'Y'

-- For testing use only to enable SH task
--set @post_flag = 'Y'

Declare
@cocde	nvarchar(6),
@type		nvarchar(2),
@docno 	nvarchar(20),
@postdat	datetime,
@slnonbdat	datetime,

@AC_SH	nvarchar(15),
@AC_SA	nvarchar(15),
@AC_SHADJ	nvarchar(15),
@AC_SATRM	nvarchar(15),

/* Marco added for Profit Center Enhancement Begin */
@tempamtSH1	decimal(13, 4),
@tempamtSH2	decimal(13, 4),
@tempamtSH3	decimal(13, 4),
@tempamtSH4	decimal(13, 4),
@tempamtSA1	decimal(13, 4),
@tempamtSA2	decimal(13, 4),
@tempamtSA3	decimal(13, 4),
@tempamtSA4	decimal(13, 4),
/* Marco added for Profit Center Enhancement End */

@vw_cocde	nvarchar(6),
@vw_doctyp	nvarchar(2),
@vw_docno	nvarchar(20),
@vw_cusno	nvarchar(6),
@vw_paytrm	nvarchar(6),
@vw_prctrm	nvarchar(6),
@vw_dptyp	nvarchar(1),
@vw_disprm	nvarchar(6),
@vw_account	nvarchar(15),
@vw_curcde	nvarchar(6),
@vw_mannam	nvarchar(200),
@vw_hid_grswgt	nvarchar(10),
@vw_hid_netwgt	nvarchar(10),
@vw_MEAS	nvarchar(50),
@vw_amount	numeric(13,2),

@org_SH_bid_issdat	datetime, -- Marco added at 20040517


@nExist	int,		--Record exist in BAINVDTL
@Desc1	nvarchar(20),
@Desc		nvarchar(40),
@TxnDat	datetime,
@line		int

/* Marco modified for Profit Center Enhancement Start */
--Get Account Number from Company Control Table
select @AC_SH = pma_invacno,
	@AC_SA = pma_siacno,
	@AC_SHADJ = pma_iaacno,
	@AC_SATRM = pma_stacno

from PCMAC
where pma_pcno = 'STANDARD'
/* Marco modified for Profit Center Enhancement Start */

/* Marco added for Profit Center Enhancement Start */
CREATE TABLE #SH_RESULT(
	vw_pcno		nvarchar(20),
	vw_hid_ordno	nvarchar(20),	
	vw_hid_itmno	nvarchar(20),
	vw_hid_itmdsc	nvarchar(300),
	vw_cocde	nvarchar(6),
	vw_doctyp	nvarchar(2),
	vw_docno	nvarchar(20),
	vw_cusno	nvarchar(6),
	vw_paytrm	nvarchar(6),
	vw_prctrm	nvarchar(6),
	vw_dptyp	nvarchar(1),
	vw_disprm	nvarchar(6),
	vw_account	nvarchar(15),
	vw_curcde	nvarchar(6),
	vw_amount	numeric(13,2),
	vw_pcfty	nvarchar(20),
	vw_mannam	nvarchar(200),
	vw_hid_grswgt	nvarchar(10),
	vw_hid_netwgt	nvarchar(10),
	vw_MEAS		nvarchar(50)
)


CREATE TABLE #TMP_SH_RESULT(
	vw_pcno		nvarchar(20),
	vw_hid_ordno	nvarchar(20),	
	vw_hid_itmno	nvarchar(20),
	vw_hid_itmdsc	nvarchar(300),
	vw_cocde	nvarchar(6),
	vw_doctyp	nvarchar(2),
	vw_docno	nvarchar(20),
	vw_cusno	nvarchar(6),
	vw_paytrm	nvarchar(6),
	vw_prctrm	nvarchar(6),
	vw_dptyp	nvarchar(1),
	vw_disprm	nvarchar(6),
	vw_account	nvarchar(15),
	vw_curcde	nvarchar(6),
	vw_amount	numeric(13,2),
	vw_pcfty	nvarchar(20),
	vw_mannam	nvarchar(200),
	vw_hid_grswgt	nvarchar(10),
	vw_hid_netwgt	nvarchar(10),
	vw_MEAS		nvarchar(50)
)


CREATE TABLE #SA_RESULT(
	vw_pcno		nvarchar(20),
	vw_cocde	nvarchar(6),
	vw_doctyp	nvarchar(2),
	vw_docno	nvarchar(20),
	vw_cusno	nvarchar(6),
	vw_paytrm	nvarchar(6),
	vw_prctrm	nvarchar(6),
	vw_dptyp	nvarchar(1),
	vw_disprm	nvarchar(6),
	vw_account	nvarchar(15),
	vw_curcde	nvarchar(6),
	vw_amount	numeric(13,2),
	vw_pcfty	nvarchar(20)

)


CREATE TABLE #TMP_SA_RESULT(
	vw_pcno		nvarchar(20),
	vw_cocde	nvarchar(6),
	vw_doctyp	nvarchar(2),
	vw_docno	nvarchar(20),
	vw_cusno	nvarchar(6),
	vw_paytrm	nvarchar(6),
	vw_prctrm	nvarchar(6),
	vw_dptyp	nvarchar(1),
	vw_disprm	nvarchar(6),
	vw_account	nvarchar(15),
	vw_curcde	nvarchar(6),
	vw_amount	numeric(13,2),
	vw_pcfty	nvarchar(20)
)


/* Marco added for Profit Center Enhancement End */


--Get System Date to Posting Date
Set @TxnDat = getdate()

--Extract Invoice
Declare cur_Invoice cursor
for
Select	distinct hiv_cocde, 'SH', hiv_invno, hiv_invdat, hih_slnonb
From	SHIPGHDR
	left join SHIPGDTL on hih_cocde = hid_cocde and hih_shpno = hid_shpno
	left join SHINVHDR on hih_cocde = hiv_cocde and hid_shpno = hiv_shpno and hid_invno = hiv_invno
	left join SHDISPRM on hih_cocde = hdp_cocde and hiv_invno = hdp_invno and hiv_invno = hdp_invno
	left join SYDISPRM on 
			--hih_cocde = ydp_cocde and 
			hdp_type = ydp_type and 
			hdp_cde = ydp_cde
where	
hiv_invdat >= '2002-09-01' and hiv_upddat between @dateFm and @dateTo
and	hiv_invsts <> 'C' and (hih_shpsts = 'OPE' or hih_shpsts = 'REL') 
and	hiv_cocde in ('UCPP', 'UCP', 'PG', 'EW', 'MS')
and	@Post_flag = 'Y'
/* Added for handling invoice with no detail 20040201 */
Union
select distinct hiv_cocde, 'SH', hiv_invno, hiv_invdat, hih_slnonb
from SHINVHDR 
left join BAINVDTL on hiv_invno = bid_docno and bid_doctyp = 'SH'
left join SHIPGHDR on hiv_cocde = hih_cocde and hiv_shpno = hih_shpno
left join SHIPGDTL on hih_cocde = hid_cocde and hih_shpno = hid_shpno and hid_invno = hiv_invno
where hiv_upddat between @dateFm and @dateTo
and hiv_invsts <> 'C'
and bid_cocde is not null
and hid_cocde is null
and @Post_flag = 'Y' 
/* Added for handling invoice with no detail 20040201 */
/* Added for handling invoice header change of ETD date without change invoice date 20090323 */
Union
select distinct hiv_cocde, 'SH', hiv_invno, hiv_invdat, hih_slnonb
from SHINVHDR 
left join BAINVDTL on hiv_invno = bid_docno and bid_doctyp = 'SH'
left join SHIPGHDR on hiv_cocde = hih_cocde and hiv_shpno = hih_shpno
left join SHIPGDTL on hih_cocde = hid_cocde and hih_shpno = hid_shpno and hid_invno = hiv_invno
where (not hiv_upddat between @dateFm and @dateTo) and ( hih_upddat between @dateFm and @dateTo )
and hiv_invsts <> 'C' and (hih_shpsts = 'OPE' or hih_shpsts = 'REL')
and convert(nvarchar(20), hih_slnonb, 111) <> convert(nvarchar(20), bid_issdat, 111)
--and hiv_invdat >= '2009-03-23'
and @Post_flag = 'Y' 
/* Added for handling invoice header change of ETD date without change invoice date 20090323 */
Union
Select 	distinct sih_cocde, 'SA', sih_invno, sih_issdat, '01/01/1900'
From	SAINVHDR
	left join SAINVDTL on sih_cocde = sid_cocde and sih_invno = sid_invno
	left join CUPRCINF on --sih_cocde = cpi_cocde and  	-- Remark by Lewis on 15 Aug 2003
			sih_cus1no = cpi_cusno
Where	sih_invno <> '' 
--and sih_issdat >= '2002-04-01' 
and sih_upddat between @dateFm_A and @dateTo
and	sih_invsts = 'REL'
and	@Post_flag_A = 'Y'
Union
Select	distinct 'ELLI', hie_invtyp, hie_invno, hie_invdat, '01/01/1900'
From	SHINVELL
Where	(((hie_invsts = 'OPE' or hie_invsts = 'REL') and hie_invtyp = 'EL') or (hie_invsts = 'REL' and hie_invtyp = 'EA'))
--and 	hie_invdat >= '2002-07-01'
and	((hie_upddat between @dateFm and @dateTo and hie_invtyp = 'EL' and @Post_flag = 'Y') or
	(hie_upddat between @dateFm_A and @dateTo and hie_invtyp = 'EA' and @Post_flag_A = 'Y'))
order by	2, 1, 3

Open cur_Invoice
Fetch next from cur_Invoice into
@cocde,
@type,
@docno,
@postdat,
@slnonbdat

While @@fetch_status = 0
Begin
	Set 	@nExist = 0
	Set	@line = 0
	Select	@nExist = count(distinct bid_txndat)
	From	BAINVDTL
	Where	bid_cocde = @cocde and bid_doctyp = @type and bid_docno = @docno

	set @nExist = @nExist + 1
	Set @Desc1 = Case @type 
			when 'SH' then 'Invoice - ' 
			when 'SA' then 'Sample Invoice - ' 
			when 'EL' then 'Invoice - ' 
			when 'EA' then 'Sample Invoice - '
			 else '' end
	Set @Desc = Case @nExist 
			when 1 then @Desc1 + ltrim(str(@nExist)) + 'st Posting' 
			when 2 then 'Adj. for ' + @Desc1 +  ltrim(str(@nExist)) + 'nd Posting' 
			when 3 then 'Adj. for ' + @Desc1 + ltrim(str(@nExist)) + 'rd Posting' 
			else 'Adj. for ' + @Desc1 +  ltrim(str(@nExist)) + 'th Posting' end

	If @type = 'SH'
	Begin

		/* 1. Orginal from BAINVDTL */
		insert into #SH_RESULT
		Select	vw_pcno = 'ORG',
			vw_hid_ordno = '',
			vw_hid_itmno = '',
			vw_hid_itmdsc = '',
			vw_cocde = bid_cocde,
			vw_doctyp = @type,
			vw_docno = @docno,
			vw_cusno = bid_cusno,
			vw_paytrm = bid_paytrm,
			vw_prctrm = bid_prctrm,
			vw_dptyp = bid_dptyp,
			vw_disprm = bid_disprm,
			vw_account = bid_account,
			vw_curcde = bid_curcde,
			vw_amount = -1 * sum(bid_amount),
			vw_pcfty = '',
			vw_mannam = '',
			vw_hid_grswgt = '',
			vw_hid_netwgt = '',
			vw_MEAS = ''
		From	BAINVDTL
		where	bid_cocde = @cocde and bid_doctyp = @type and bid_docno = @docno
		Group by	
			bid_cocde, bid_doctyp, bid_docno, bid_cusno, bid_paytrm, bid_prctrm, bid_dptyp, bid_disprm, bid_account, bid_curcde
		

		/* 2. get SH result for orginal ac for soh_credat before 2003-10-01 */
		insert into #SH_RESULT
		Select	distinct vw_pcno = 'ORG',
			vw_hid_ordno = hid.hid_ordno,
			vw_hid_itmno = hid.hid_itmno, 
			vw_hid_itmdsc = hid.hid_itmdsc,
			vw_cocde = hiv.hiv_cocde,
			vw_doctyp = @type,
			vw_docno = @docno,
			vw_cusno = hih.hih_cus1no,
			vw_paytrm = hiv.hiv_paytrm,
			vw_prctrm = hiv.hiv_prctrm,
			vw_dptyp = 'A',
			vw_disprm = '',
			vw_account = @AC_SH,
			vw_curcde = hiv.hiv_untamt,
			vw_amount = Case case when hiv_aformat = '2' then 'C' else case when hiv_aformat = '1' then 'A' else 'C' end end  
				  when 'A' then  vw.sumamtd else vw.sumamt end,
			vw_pcfty = '',
			vw_mannam = hid.hid_mannam,
			vw_hid_grswgt = vw.hid_grswgt,
			vw_hid_netwgt = vw.hid_netwgt,
			vw_MEAS = vw.MEAS
		From	SHIPGHDR hih
		left join SHIPGDTL hid on hih.hih_cocde = hid.hid_cocde and hih.hih_shpno = hid.hid_shpno
		left join SHINVHDR hiv on hih.hih_cocde = hiv.hiv_cocde and hid.hid_shpno = hiv.hiv_shpno and hid.hid_invno = hiv.hiv_invno
		left join SCORDHDR soh on soh.soh_cocde = hid.hid_cocde and soh.soh_ordno = hid.hid_ordno
		left join v_select_inr00001 vw on  vw.hid_cocde = hid.hid_cocde and   
							vw.hid_invno = hiv_invno  and   
							hid.hid_cuspo = vw.hid_cuspo and  
							hid.hid_ordno = vw.hid_ordno and   
							hid.hid_mannam = vw.hid_mannam and   
							hid.hid_itmno = vw.hid_itmno and   
							hid.hid_itmdsc = vw.hid_itmdsc and    
							hid.hid_inrctn = vw.hid_inrctn and   
							hid.hid_mtrctn = vw.hid_mtrctn and 
							hid.hid_selprc = vw.hid_selprc  
		where	hih.hih_cocde = @cocde and hih.hih_shpsts in ('OPE','REL') and hiv.hiv_invsts <> 'C'
		and	hiv.hiv_invno = @docno and hiv.hiv_invamt <> 0
		and	soh.soh_credat < '2003-10-01'


		/* 3. get SH result with profit center ac for soh_credat after 2003-10-01 (not standard)*/
		insert into #SH_RESULT
		Select  distinct 
			vw_pcno = case hid_venno	when '0005' then 'STANDARD' 
						 	when '0006' then 'STANDARD'
						 	when '0007' then 'STANDARD'
							when '0008' then 'STANDARD'
							when '0009' then 'STANDARD'
						 	else pdv.pdv_pcno end,
			vw_hid_ordno = hid.hid_ordno,
			vw_hid_itmno = hid.hid_itmno, 
			vw_hid_itmdsc = hid.hid_itmdsc,
			vw_cocde = hiv.hiv_cocde,
			vw_doctyp = @type,
			vw_docno = @docno,
			vw_cusno = hih.hih_cus1no,
			vw_paytrm = hiv.hiv_paytrm,
			vw_prctrm = hiv.hiv_prctrm,
			vw_dptyp = 'A',
			vw_disprm = '',
			vw_account = case hid_venno 	when '0005' then @AC_SH 
							when '0006' then @AC_SH
							when '0007' then @AC_SH
							when '0008' then @AC_SH
							when '0009' then @AC_SH
							else pma.pma_invacno end,
			vw_curcde = hiv.hiv_untamt,
			vw_amount = Case case when hiv.hiv_aformat = '2' then 'C' else case when hiv.hiv_aformat = '1' then 'A' else 'C' end end  
				  when 'A' then  vw.sumamtd else vw.sumamt end,
			vw_pcfty = isnull(yli_pcfty, ''),
			vw_mannam = hid.hid_mannam,
			vw_hid_grswgt = vw.hid_grswgt,
			vw_hid_netwgt = vw.hid_netwgt,
			vw_MEAS = vw.MEAS
		From	SHIPGHDR hih
		left join SHIPGDTL hid on hih.hih_cocde = hid.hid_cocde and hih.hih_shpno = hid.hid_shpno
		left join SHINVHDR hiv on hih.hih_cocde = hiv.hiv_cocde and hid.hid_shpno = hiv.hiv_shpno and hid.hid_invno = hiv.hiv_invno
		left join SCORDHDR soh on soh.soh_cocde = hid.hid_cocde and soh.soh_ordno = hid.hid_ordno
		left join v_select_inr00001 vw on  vw.hid_cocde = hid.hid_cocde and   
							vw.hid_invno = hiv_invno  and   
							hid.hid_cuspo = vw.hid_cuspo and  
							hid.hid_ordno = vw.hid_ordno and   
							hid.hid_mannam = vw.hid_mannam and   
							hid.hid_itmno = vw.hid_itmno and   
							hid.hid_itmdsc = vw.hid_itmdsc and    
							hid.hid_inrctn = vw.hid_inrctn and   
							hid.hid_mtrctn = vw.hid_mtrctn and 
							hid.hid_selprc = vw.hid_selprc  
--		left join IMBASINF ibi on (hid.hid_itmno = ibi.ibi_itmno or hid.hid_itmno = ibi.ibi_alsitmno) and ibi.ibi_itmsts <> 'CLO'
--		left join IMBASINF ibi on ((hid.hid_itmno = ibi.ibi_itmno or hid.hid_itmno = ibi.ibi_alsitmno) and hid.hid_itmno not in ('031328-00132') and ibi_itmsts <> 'CLO') or
--					  ((hid.hid_cocde = ibi.ibi_cocde) and ((hid.hid_itmno = ibi.ibi_itmno or hid.hid_itmno = ibi.ibi_alsitmno) and hid.hid_itmno in ('031328-00132')) and ibi_itmsts <> 'CLO')
		left join IMBASINF ibi on hid.hid_itmno = ibi.ibi_itmno
		left join SYLNEINF yli on ibi.ibi_lnecde = yli.yli_lnecde
		inner join PCMDV pdv on ibi.ibi_venno = pdv.pdv_vencde
		inner join PCMAC pma on pma.pma_pcno = pdv.pdv_pcno
		where	hih.hih_cocde = @cocde and hih.hih_shpsts in ('OPE','REL') and hiv.hiv_invsts <> 'C'
		and	hiv.hiv_invno = @docno and hiv.hiv_invamt <> 0
		and	soh.soh_credat >= '2003-10-01'
		and	pdv.pdv_pcno <> 'STANDARD'

		/* 4. get total amount without profit center ac for soh_credat after 2003-10-01 (default use STANDARD)*/
		insert into #SH_RESULT
		Select	distinct vw_pcno = 'STANDARD',
			vw_hid_ordno = hid.hid_ordno,
			vw_hid_itmno = hid.hid_itmno, 
			vw_hid_itmdsc = hid.hid_itmdsc,
			vw_cocde = hiv.hiv_cocde,
			vw_doctyp = @type,
			vw_docno = @docno,
			vw_cusno = hih.hih_cus1no,
			vw_paytrm = hiv.hiv_paytrm,
			vw_prctrm = hiv.hiv_prctrm,
			vw_dptyp = 'A',
			vw_disprm = '',
			vw_account = @AC_SH,
			vw_curcde = hiv.hiv_untamt,
			vw_amount = Case case when hiv.hiv_aformat = '2' then 'C' else case when hiv.hiv_aformat = '1' then 'A' else 'C' end end  
				  when 'A' then  vw.sumamtd else vw.sumamt end,
			vw_pcfty = isnull(yli_pcfty, ''),
			vw_mannam = hid.hid_mannam,
			vw_hid_grswgt = vw.hid_grswgt,
			vw_hid_netwgt = vw.hid_netwgt,
			vw_MEAS = vw.MEAS
		From	SHIPGHDR hih
		left join SHIPGDTL hid on hih.hih_cocde = hid.hid_cocde and hih.hih_shpno = hid.hid_shpno
		left join SHINVHDR hiv on hih.hih_cocde = hiv.hiv_cocde and hid.hid_shpno = hiv.hiv_shpno and hid.hid_invno = hiv.hiv_invno
		left join SCORDHDR soh on soh.soh_cocde = hid.hid_cocde and soh.soh_ordno = hid.hid_ordno
		left join v_select_inr00001 vw on  vw.hid_cocde = hid.hid_cocde and   
							vw.hid_invno = hiv_invno  and   
							hid.hid_cuspo = vw.hid_cuspo and  
							hid.hid_ordno = vw.hid_ordno and   
							hid.hid_mannam = vw.hid_mannam and   
							hid.hid_itmno = vw.hid_itmno and   
							hid.hid_itmdsc = vw.hid_itmdsc and    
							hid.hid_inrctn = vw.hid_inrctn and   
							hid.hid_mtrctn = vw.hid_mtrctn and 
							hid.hid_selprc = vw.hid_selprc  
--		left join IMBASINF ibi on (hid.hid_itmno = ibi.ibi_itmno or hid.hid_itmno = ibi_alsitmno) and ibi_itmsts <> 'CLO'
--		left join IMBASINF ibi on ((hid.hid_itmno = ibi.ibi_itmno or hid.hid_itmno = ibi.ibi_alsitmno) and hid.hid_itmno not in ('031328-00132') and ibi_itmsts <> 'CLO') or
--					  ((hid.hid_cocde = ibi.ibi_cocde) and ((hid.hid_itmno = ibi.ibi_itmno or hid.hid_itmno = ibi.ibi_alsitmno) and hid.hid_itmno in ('031328-00132')) and ibi_itmsts <> 'CLO')
		left join IMBASINF ibi on hid.hid_itmno = ibi.ibi_itmno
		left join SYLNEINF yli on ibi.ibi_lnecde = yli.yli_lnecde
		left join PCMDV pdv on ibi.ibi_venno = pdv.pdv_vencde
		left join PCMAC pma on pma.pma_pcno = pdv.pdv_pcno
		where	hih.hih_cocde = @cocde and hih.hih_shpsts in ('OPE','REL') and hiv.hiv_invsts <> 'C'
		and	hiv.hiv_invno = @docno and hiv.hiv_invamt <> 0
		and	soh.soh_credat >= '2003-10-01'
		and	(pdv.pdv_pcno is null or pdv.pdv_pcno = '' or pdv.pdv_pcno = 'STANDARD')  


		/* Overwrite Profit Center to STANDARD for vw_pcfty is not blank */
		update #SH_RESULT set vw_pcno = 'STANDARD', vw_account = @AC_SH
		from #SH_RESULT 
		where vw_dptyp = 'A' and vw_pcfty <> '' and vw_pcfty is not null

		/* Apply Product Line with Profit Center Factory Logic for vw_pcfty is not blank*/
		update #SH_RESULT set vw_pcno = pdv_pcno, vw_account = pma_invacno
		from #SH_RESULT, PCMDV, PCMAC
		where 	vw_dptyp = 'A' and vw_pcfty <> '' and vw_pcfty is not null
		and	vw_pcfty = pdv_vencde
		and 	pdv_pcno = pma_pcno 


		select @tempamtSH1 = isnull(hiv_afamt, 0) from SHINVHDR where hiv_cocde = @cocde and hiv_invsts <> 'C' and hiv_invno = @docno and hiv_afamt <> 0


		/* 5 Get Discount and Premium amount for soh_credat before 2003-10-01 */
		insert into #TMP_SH_RESULT
		Select	distinct vw_pcno = 'ORG', 
			vw_hid_ordno = hid.hid_ordno,
			vw_hid_itmno = hid.hid_itmno, 
			vw_hid_itmdsc = hid.hid_itmdsc,
			vw_cocde = hiv.hiv_cocde,
			vw_doctyp = @type,
			vw_docno = @docno,
			vw_cusno = hih.hih_cus1no,
			vw_paytrm = hiv.hiv_paytrm,
			vw_prctrm = hiv.hiv_prctrm,
			vw_dptyp = 'B',
			vw_disprm = '',
			vw_account = @AC_SHADJ,	--Buying Commission, 8-05-10-00
			vw_curcde = hiv.hiv_untamt,
			vw_amount = round((Case case when hiv.hiv_aformat = '2' then 'C' else case when hiv.hiv_aformat = '1' then 'A' else 'C' end end  
				  when 'A' then vw.sumamtd else vw.sumamt end) * 0.05, 2),
			vw_pcfty = '',
			vw_mannam = hid.hid_mannam,
			vw_hid_grswgt = vw.hid_grswgt,
			vw_hid_netwgt = vw.hid_netwgt,
			vw_MEAS = vw.MEAS
		From	SHIPGHDR hih
		left join SHIPGDTL hid on hih.hih_cocde = hid.hid_cocde and hih.hih_shpno = hid.hid_shpno
		left join SHINVHDR hiv on hih.hih_cocde = hiv.hiv_cocde and hid.hid_shpno = hiv.hiv_shpno and hid.hid_invno = hiv.hiv_invno
		left join SCORDHDR soh on soh.soh_cocde = hid.hid_cocde and soh.soh_ordno = hid.hid_ordno
		left join v_select_inr00001 vw on  vw.hid_cocde = hid.hid_cocde and   
							vw.hid_invno = hiv_invno  and   
							hid.hid_cuspo = vw.hid_cuspo and  
							hid.hid_ordno = vw.hid_ordno and   
							hid.hid_mannam = vw.hid_mannam and   
							hid.hid_itmno = vw.hid_itmno and   
							hid.hid_itmdsc = vw.hid_itmdsc and    
							hid.hid_inrctn = vw.hid_inrctn and   
							hid.hid_mtrctn = vw.hid_mtrctn and 
							hid.hid_selprc = vw.hid_selprc  
		where	hih.hih_cocde = @cocde and hih.hih_shpsts in ('OPE','REL') and hiv.hiv_invsts <> 'C'
		and	hiv.hiv_invno = @docno and hiv.hiv_afamt <> 0
		and	soh.soh_credat < '2003-10-01'


		select @tempamtSH2 = isnull(sum(vw_amount), 0) from #TMP_SH_RESULT
		insert into #SH_RESULT select * from #TMP_SH_RESULT
		delete from #TMP_SH_RESULT

		/* 6 get discount and premium amount with profit center ac for soh_credat after 2003-10-01 (not standard)*/
		insert into #TMP_SH_RESULT
		Select	distinct 
			vw_pcno = case hid_venno	when '0005' then 'STANDARD' 
							when '0006' then 'STANDARD'
							when '0007' then 'STANDARD'
							when '0008' then 'STANDARD'
							when '0009' then 'STANDARD'
							else pdv.pdv_pcno end, 
			vw_hid_ordno = hid.hid_ordno,
			vw_hid_itmno = hid.hid_itmno, 
			vw_hid_itmdsc = hid.hid_itmdsc,
			vw_cocde = hiv.hiv_cocde,
			vw_doctyp = @type,
			vw_docno = @docno,
			vw_cusno = hih.hih_cus1no,
			vw_paytrm = hiv.hiv_paytrm,
			vw_prctrm = hiv.hiv_prctrm,
			vw_dptyp = 'B',
			vw_disprm = '',
			vw_account = case hid_venno	when '0005' then @AC_SHADJ 
							when '0006' then @AC_SHADJ
							when '0007' then @AC_SHADJ
							when '0008' then @AC_SHADJ
							when '0009' then @AC_SHADJ
							else pma.pma_iaacno end,
			vw_curcde = hiv.hiv_untamt,
			vw_amount = round((Case case when hiv.hiv_aformat = '2' then 'C' else case when hiv.hiv_aformat = '1' then 'A' else 'C' end end  
				  when 'A' then  vw.sumamtd else vw.sumamt end) * 0.05, 2),
			vw_pcfty = isnull(yli_pcfty, ''),
			vw_mannam = hid.hid_mannam,
			vw_hid_grswgt = vw.hid_grswgt,
			vw_hid_netwgt = vw.hid_netwgt,
			vw_MEAS = vw.MEAS
		From	SHIPGHDR hih
		left join SHIPGDTL hid on hih.hih_cocde = hid.hid_cocde and hih.hih_shpno = hid.hid_shpno
		left join SHINVHDR hiv on hih.hih_cocde = hiv.hiv_cocde and hid.hid_shpno = hiv.hiv_shpno and hid.hid_invno = hiv.hiv_invno
		left join SCORDHDR soh on soh.soh_cocde = hid.hid_cocde and soh.soh_ordno = hid.hid_ordno
		left join v_select_inr00001 vw on  vw.hid_cocde = hid.hid_cocde and   
							vw.hid_invno = hiv_invno  and   
							hid.hid_cuspo = vw.hid_cuspo and  
							hid.hid_ordno = vw.hid_ordno and   
							hid.hid_mannam = vw.hid_mannam and   
							hid.hid_itmno = vw.hid_itmno and   
							hid.hid_itmdsc = vw.hid_itmdsc and    
							hid.hid_inrctn = vw.hid_inrctn and   
							hid.hid_mtrctn = vw.hid_mtrctn and 
							hid.hid_selprc = vw.hid_selprc  
--		left join IMBASINF ibi on (hid.hid_itmno = ibi.ibi_itmno or hid.hid_itmno = ibi_alsitmno) and ibi_itmsts <> 'CLO'
--		left join IMBASINF ibi on ((hid.hid_itmno = ibi.ibi_itmno or hid.hid_itmno = ibi.ibi_alsitmno) and hid.hid_itmno not in ('031328-00132') and ibi_itmsts <> 'CLO') or
--					  ((hid.hid_cocde = ibi.ibi_cocde) and ((hid.hid_itmno = ibi.ibi_itmno or hid.hid_itmno = ibi.ibi_alsitmno) and hid.hid_itmno in ('031328-00132')) and ibi_itmsts <> 'CLO')
		left join IMBASINF ibi on hid.hid_itmno = ibi.ibi_itmno
		left join SYLNEINF yli on ibi.ibi_lnecde = yli.yli_lnecde
		inner join PCMDV pdv on ibi.ibi_venno = pdv.pdv_vencde
		inner join PCMAC pma on pma.pma_pcno = pdv.pdv_pcno
		where	hih.hih_cocde = @cocde and hih.hih_shpsts in ('OPE','REL') and hiv.hiv_invsts <> 'C'
		and	hiv.hiv_invno = @docno and hiv.hiv_afamt <> 0
		and	soh.soh_credat >= '2003-10-01'
		and	pdv.pdv_pcno <> 'STANDARD'


		select @tempamtSH3 = isnull(sum(vw_amount),0) from #TMP_SH_RESULT
		insert into #SH_RESULT select * from #TMP_SH_RESULT
		delete from #TMP_SH_RESULT

		/* 7 get discount and premium amount without profit center ac for soh_credat after 2003-10-01 (default use STANDARD)*/
		insert into #TMP_SH_RESULT
		Select	distinct vw_pcno = 'STANDARD',
			vw_hid_ordno = hid.hid_ordno,
			vw_hid_itmno = hid.hid_itmno, 
			vw_hid_itmdsc = hid.hid_itmdsc,
			vw_cocde = hiv.hiv_cocde,
			vw_doctyp = @type,
			vw_docno = @docno,
			vw_cusno = hih.hih_cus1no,
			vw_paytrm = hiv.hiv_paytrm,
			vw_prctrm = hiv.hiv_prctrm,
			vw_dptyp = 'B',
			vw_disprm = '',
			vw_account = @AC_SHADJ,
			vw_curcde = hiv.hiv_untamt,
			vw_amount = round((Case case when hiv.hiv_aformat = '2' then 'C' else case when hiv.hiv_aformat = '1' then 'A' else 'C' end end  
				  when 'A' then  vw.sumamtd else vw.sumamt end) * 0.05, 2),
			vw_pcfty = isnull(yli_pcfty, ''),
			vw_mannam = hid.hid_mannam,
			vw_hid_grswgt = vw.hid_grswgt,
			vw_hid_netwgt = vw.hid_netwgt,
			vw_MEAS = vw.MEAS
		From	SHIPGHDR hih
		left join SHIPGDTL hid on hih.hih_cocde = hid.hid_cocde and hih.hih_shpno = hid.hid_shpno
		left join SHINVHDR hiv on hih.hih_cocde = hiv.hiv_cocde and hid.hid_shpno = hiv.hiv_shpno and hid.hid_invno = hiv.hiv_invno
		left join SCORDHDR soh on soh.soh_cocde = hid.hid_cocde and soh.soh_ordno = hid.hid_ordno
		left join v_select_inr00001 vw on  vw.hid_cocde = hid.hid_cocde and   
							vw.hid_invno = hiv_invno  and   
							hid.hid_cuspo = vw.hid_cuspo and  
							hid.hid_ordno = vw.hid_ordno and   
							hid.hid_mannam = vw.hid_mannam and   
							hid.hid_itmno = vw.hid_itmno and   
							hid.hid_itmdsc = vw.hid_itmdsc and    
							hid.hid_inrctn = vw.hid_inrctn and   
							hid.hid_mtrctn = vw.hid_mtrctn and 
							hid.hid_selprc = vw.hid_selprc  
--		left join IMBASINF ibi on (hid.hid_itmno = ibi.ibi_itmno or hid.hid_itmno = ibi_alsitmno) and ibi_itmsts <> 'CLO'
--		left join IMBASINF ibi on ((hid.hid_itmno = ibi.ibi_itmno or hid.hid_itmno = ibi.ibi_alsitmno) and hid.hid_itmno not in ('031328-00132') and ibi_itmsts <> 'CLO') or
--					  ((hid.hid_cocde = ibi.ibi_cocde) and ((hid.hid_itmno = ibi.ibi_itmno or hid.hid_itmno = ibi.ibi_alsitmno) and hid.hid_itmno in ('031328-00132')) and ibi_itmsts <> 'CLO')
		left join IMBASINF ibi on hid.hid_itmno = ibi.ibi_itmno
		left join SYLNEINF yli on ibi.ibi_lnecde = yli.yli_lnecde
		left join PCMDV pdv on ibi.ibi_venno = pdv.pdv_vencde
		left join PCMAC pma on pma.pma_pcno = pdv.pdv_pcno
		where	hih.hih_cocde = @cocde and hih.hih_shpsts in ('OPE','REL') and hiv.hiv_invsts <> 'C'
		and	hiv.hiv_invno = @docno and hiv.hiv_afamt <> 0
		and	soh.soh_credat >= '2003-10-01'
		and	(pdv.pdv_pcno is null or pdv.pdv_pcno = '' or pdv.pdv_pcno = 'STANDARD')

		select @tempamtSH4 = isnull(sum(vw_amount),0) from #TMP_SH_RESULT
		insert into #SH_RESULT select * from #TMP_SH_RESULT
		delete from #TMP_SH_RESULT

		/* Overwrite Profit Center to STANDARD for vw_pcfty is not blank */
		update #SH_RESULT set vw_pcno = 'STANDARD', vw_account = @AC_SH
		from #SH_RESULT 
		where vw_dptyp = 'B' and vw_pcfty <> '' and vw_pcfty is not null

		/* Apply Product Line with Profit Center Factory Logic for vw_pcfty is not blank*/
		update #SH_RESULT set vw_pcno = pdv_pcno, vw_account = pma_invacno
		from #SH_RESULT, PCMDV, PCMAC
		where 	vw_dptyp = 'B' and vw_pcfty <> '' and vw_pcfty is not null
		and	vw_pcfty = pdv_vencde
		and 	pdv_pcno = pma_pcno 


		/* 8. Adjustment for rounding error */
		insert into #SH_RESULT
		select  distinct vw_pcno = 'STANDARD', 
			vw_hid_ordno = '',
			vw_hid_itmno = '', 
			vw_hid_itmdsc = '',
			vw_cocde = hiv_cocde,
			vw_doctyp = @type,
			vw_docno = @docno,
			vw_cusno = hih_cus1no,
			vw_paytrm = hiv_paytrm,
			vw_prctrm = hiv_prctrm,
			vw_dptyp = 'B',
			vw_disprm = '',
			vw_account = @AC_SHADJ,	
			vw_curcde = hiv_untamt,
			vw_amount = @tempamtSH1 - @tempamtSH2 - @tempamtSH3 - @tempamtSH4, 
			vw_pcfty = '',
			vw_mannam = '',
			vw_hid_grswgt = '',
			vw_hid_netwgt = '',
			vw_MEAS = ''
		from 	SHIPGHDR
		left join SHIPGDTL on hih_cocde = hid_cocde and hih_shpno = hid_shpno
		left join SHINVHDR on hih_cocde = hiv_cocde and hid_shpno = hiv_shpno and hid_invno = hiv_invno
		where	hih_cocde = @cocde and hih_shpsts in ('OPE','REL') and hiv_invsts <> 'C'
		and	hiv_invno = @docno and hiv_afamt <> 0

		/* 9. Premium and Discount */
		insert into #SH_RESULT
		Select	vw_pcno = 'ORG',
			vw_hid_ordno = '',
			vw_hid_itmno = '', 
			vw_hid_itmdsc = '',
			vw_cocde = hiv_cocde,
			vw_doctyp = @type,
			vw_docno = @docno,
			vw_cusno = hih_cus1no,
			vw_paytrm = hiv_paytrm,
			vw_prctrm = hiv_prctrm,
			vw_dptyp = hdp_type,
			vw_disprm = hdp_cde,
			vw_account = ydp_account,
			vw_curcde = hiv_untamt,
			vw_amount = Case hdp_type when 'P' then sum(hdp_amt) else -1 * sum(hdp_amt) end, 
			vw_pcfty = '',
			vw_mannam = '',
			vw_hid_grswgt = '',
			vw_hid_netwgt = '',
			vw_MEAS = ''
		From	SHIPGHDR, SHINVHDR, SHDISPRM, SYDISPRM
		where	hih_cocde = hiv_cocde and hih_shpno = hiv_shpno
		and	hih_cocde = hdp_cocde and hiv_invno = hdp_invno 
		--and	hih_cocde = ydp_cocde 
		and hdp_type = ydp_type and hdp_cde = ydp_cde
--************ modify to include shipping status = REL in getting detail ************* by Lewis on 25 Apr 2003
		and	hih_cocde = @cocde and hih_shpsts in ('OPE','REL') and hiv_invsts <> 'C'
		and	hiv_invno = @docno and hdp_type is Not NULL and hdp_amt <> 0
		Group by
			hiv_cocde, hih_cus1no, hiv_paytrm, hiv_prctrm, hdp_type, hdp_cde, ydp_account, hiv_untamt

		update #SH_RESULT set vw_mannam = '', vw_hid_grswgt = '', vw_hid_netwgt = '', vw_MEAS = ''

		Declare cur_BAINVDTL_SH cursor
		for
		Select	vw_cocde,
			vw_doctyp,
			vw_docno,
			vw_cusno,
			vw_paytrm,
			vw_prctrm,
			vw_dptyp,
			vw_disprm,
			vw_account,
			vw_curcde,
			vw_mannam,
			vw_hid_grswgt,
			vw_hid_netwgt,
			vw_MEAS,
			sum(vw_amount)
		from	#SH_RESULT vw
		where vw_amount <> 0
		Group by
			vw_cocde, vw_doctyp, vw_docno, vw_cusno, vw_paytrm, vw_prctrm, vw_dptyp, vw_disprm, vw_account, vw_curcde, vw_mannam, vw_hid_grswgt, vw_hid_netwgt, vw_MEAS
--		having sum(vw_amount) <> 0		

		Open cur_BAINVDTL_SH 
		Fetch next from cur_BAINVDTL_SH into
		@vw_cocde,
		@vw_doctyp,
		@vw_docno,
		@vw_cusno,
		@vw_paytrm,
		@vw_prctrm,
		@vw_dptyp,
		@vw_disprm,
		@vw_account,
		@vw_curcde,
		@vw_mannam,
		@vw_hid_grswgt,
		@vw_hid_netwgt,
		@vw_MEAS,
		@vw_amount

		While @@fetch_status = 0
		begin

			set @org_SH_bid_issdat = '01/01/1900'

			select @org_SH_bid_issdat = bid_issdat
			from BAINVDTL
			Where	bid_cocde = @cocde and bid_doctyp = @type and bid_seqno = @nExist
			and 	bid_docno = @docno and convert(char(10), bid_txndat, 101) = convert(char(10), getdate(), 101)
			and 	bid_account = @vw_account

			if not (@org_SH_bid_issdat = @postdat and @vw_amount = 0)
			begin

				Select	@line = count(*) + 1
				From	BAINVDTL
				Where	bid_cocde = @cocde and bid_doctyp = @type and bid_seqno = @nExist
				and 	bid_docno = @docno and convert(char(10), bid_txndat, 101) = convert(char(10), getdate(), 101)
	

				if @postdat >= '2009-03-23'
				begin
					set @postdat = @slnonbdat
				end
	
				-- Insert into BAINVDTL
				Insert into BAINVDTL (
				bid_cocde,
				bid_doctyp,
				bid_docno,
				bid_issdat,
				bid_txndat,
				bid_cusno,
				bid_paytrm,
				bid_prctrm,
				bid_seqno,
				bid_pstno,
				bid_dptyp,
				bid_disprm,
				bid_account,
				bid_desc,
				bid_curcde,
				bid_amount,
				bid_credat,
				bid_creusr,
				bid_upddat,
				bid_updusr )
				values (
				@vw_cocde,
				@vw_doctyp,
				@vw_docno,
				@postdat,
				@TxnDat,
				@vw_cusno,
				@vw_paytrm,
				@vw_prctrm,
				@nExist,
				@line,
				@vw_dptyp,
				@vw_disprm,
				@vw_account,
				@Desc,
				@vw_curcde,
				@vw_amount,
				getdate(),
				'PostUsr',
				getdate(),
				'PostUsr' )
	
				If @@rowcount = 0
				begin
					Print @vw_doctyp + ' / ' + @vw_docno
				end
				-- Write to Export File
			end

			Fetch next from cur_BAINVDTL_SH into
			@vw_cocde,
			@vw_doctyp,
			@vw_docno,
			@vw_cusno,
			@vw_paytrm,
			@vw_prctrm,
			@vw_dptyp,
			@vw_disprm,
			@vw_account,
			@vw_curcde,
			@vw_mannam,
			@vw_hid_grswgt,
			@vw_hid_netwgt,
			@vw_MEAS,
			@vw_amount
		End
		Close cur_BAINVDTL_SH
		Deallocate cur_BAINVDTL_SH

		delete from #SH_RESULT
	End

	If @type = 'SA'
	Begin
		insert into #SA_RESULT
		Select	vw_pcno = 'ORG',
			vw_cocde = bid_cocde,
			vw_doctyp = @type,
			vw_docno = @docno,
			vw_cusno = bid_cusno,
			vw_paytrm = bid_paytrm,
			vw_prctrm = bid_prctrm,
			vw_dptyp = bid_dptyp,
			vw_disprm = bid_disprm,
			vw_account = bid_account,
			vw_curcde = bid_curcde,
			vw_amount = -1 * sum(bid_amount),
			vw_pcfty = ''
		From	BAINVDTL
		where	bid_cocde = @cocde and bid_doctyp = @type and bid_docno = @docno
		Group by	
			bid_cocde, bid_doctyp, bid_docno, bid_cusno, bid_paytrm, bid_prctrm, bid_dptyp, bid_disprm, bid_account, bid_curcde


--		select @tempamtSA1 = isnull(sih_netamt, 0) from SAINVHDR where sih_cocde = @cocde and sih_invno = @docno and sih_netamt > 0

		declare @tempamtSA1_1	decimal(13, 4), @tempamtSA1_2	decimal(13, 4)

		select @tempamtSA1_1 = isnull(sum(sid_ttlamt * (1-(sih_discnt/100.0))), 0)
		From	SAINVHDR
		left join SAINVDTL on sih_cocde = sid_cocde and sih_invno = sid_invno
		Where	sih_cocde = @cocde and sih_invno = @docno 
		and	sih_netamt > 0

		set @tempamtSA1_2 = round(@tempamtSA1_1,2,-1)
		
		if @tempamtSA1_1 - @tempamtSA1_2 > 0.00
		begin
			set @tempamtSA1 = @tempamtSA1_2 + 0.01
		end
		else
		begin
			set @tempamtSA1 = @tempamtSA1_2
		end


		insert into #TMP_SA_RESULT
		Select	vw_pcno = 'ORG', 
			vw_cocde = sih_cocde,
			vw_doctyp = @type,
			vw_docno = @docno,
			vw_cusno = sih_cus1no,
			vw_paytrm = cpi_paytrm,
			vw_prctrm = sih_prctrm,
			vw_dptyp = 'A',
			vw_disprm = '',
			vw_account = @AC_SA,
			vw_curcde = sih_curcde,
			vw_amount = round(sum(sid_ttlamt * (1-(sih_discnt/100.0))),2),
			vw_pcfty = ''
		From	SAINVHDR
		left join SAINVDTL on sih_cocde = sid_cocde and sih_invno = sid_invno
		left join CUPRCINF on sih_cus1no = cpi_cusno
		Where	sih_cocde = @cocde and sih_invno = @docno 
		and	sih_netamt > 0
--		and 	sid_credat < '2003-10-01'	-- Marco at 20031020
		and 	sih_credat < '2003-10-01'
		group by sih_cocde, sih_cus1no, cpi_paytrm, sih_prctrm, sih_curcde

		select @tempamtSA2 = isnull(sum(vw_amount), 0) from #TMP_SA_RESULT
		insert into #SA_RESULT select * from #TMP_SA_RESULT
		delete from #TMP_SA_RESULT


		insert into #TMP_SA_RESULT
		Select	vw_pcno = case sid_venno	when '0005' then 'STANDARD' 
							when '0006' then 'STANDARD'
							when '0007' then 'STANDARD'
							when '0008' then 'STANDARD'
							when '0009' then 'STANDARD'
							else pdv_pcno end,
			vw_cocde = sih_cocde,
			vw_doctyp = @type,
			vw_docno = @docno,
			vw_cusno = sih_cus1no,
			vw_paytrm = cpi_paytrm,
			vw_prctrm = sih_prctrm,
			vw_dptyp = 'A',
			vw_disprm = '',
			vw_account = case sid_venno	when '0005' then @AC_SA 
							when '0006' then @AC_SA
							when '0007' then @AC_SA
							when '0008' then @AC_SA
							when '0009' then @AC_SA
							else pma_siacno end,
			vw_curcde = sih_curcde, 
			vw_amount = round(sum(sid_ttlamt * (1-(sih_discnt/100.0))),2),
			vw_pcfty = isnull(yli.yli_pcfty, '')
		From	SAINVHDR
		left join SAINVDTL on sih_cocde = sid_cocde and sih_invno = sid_invno
		left join CUPRCINF on sih_cus1no = cpi_cusno
--		left join IMBASINF ibi on (sid_itmno = ibi_itmno or sid_itmno = ibi_alsitmno) and ibi_itmsts <> 'CLO'
--		left join IMBASINF ibi on ((sid_itmno = ibi_itmno or sid_itmno = ibi_alsitmno) and sid_itmno not in ('031328-00132') and ibi_itmsts <> 'CLO') or
--					  ((sid_cocde = ibi_cocde) and ((sid_itmno = ibi_itmno or sid_itmno = ibi_alsitmno) and sid_itmno in ('031328-00132')) and ibi_itmsts <> 'CLO')
		left join IMBASINF ibi on sid_itmno = ibi_itmno
		left join SYLNEINF yli on ibi.ibi_lnecde = yli.yli_lnecde
		inner join PCMDV on ibi_venno = pdv_vencde
		inner join PCMAC on pma_pcno = pdv_pcno 
		Where	sih_cocde = @cocde and sih_invno = @docno 
		and	sih_netamt > 0
--		and 	sid_credat >= '2003-10-01'	-- Marco at 20031020
		and 	sih_credat >= '2003-10-01'
		and	pdv_pcno <> 'STANDARD'
		group by pdv_pcno, sih_cocde, sih_cus1no, cpi_paytrm, sih_prctrm, pma_siacno, sih_curcde, sid_venno, yli_pcfty


		select @tempamtSA3 = isnull(sum(vw_amount), 0) from #TMP_SA_RESULT
		insert into #SA_RESULT select * from #TMP_SA_RESULT
		delete from #TMP_SA_RESULT


		insert into #TMP_SA_RESULT
		Select	vw_pcno = 'STANDARD',
			vw_cocde = sih_cocde,
			vw_doctyp = @type,
			vw_docno = @docno,
			vw_cusno = sih_cus1no,
			vw_paytrm = cpi_paytrm,
			vw_prctrm = sih_prctrm,
			vw_dptyp = 'A',
			vw_disprm = '',
			vw_account = @AC_SA,
			vw_curcde = sih_curcde,
			vw_amount = round(sum(sid_ttlamt * (1-(sih_discnt/100.0))),2),
			vw_pcfty = isnull(yli.yli_pcfty, '')
		From	SAINVHDR
		left join SAINVDTL on sih_cocde = sid_cocde and sih_invno = sid_invno
		left join CUPRCINF on sih_cus1no = cpi_cusno
--		left join IMBASINF ibi on (sid_itmno = ibi_itmno or sid_itmno = ibi_alsitmno) and ibi_itmsts <> 'CLO'
--		left join IMBASINF ibi on ((sid_itmno = ibi_itmno or sid_itmno = ibi_alsitmno) and sid_itmno not in ('031328-00132') and ibi_itmsts <> 'CLO') or
--					  ((sid_cocde = ibi_cocde) and ((sid_itmno = ibi_itmno or sid_itmno = ibi_alsitmno) and sid_itmno in ('031328-00132')) and ibi_itmsts <> 'CLO')
		left join IMBASINF ibi on sid_itmno = ibi_itmno
		left join SYLNEINF yli on ibi.ibi_lnecde = yli.yli_lnecde
		left join PCMDV on ibi_venno = pdv_vencde
		left join PCMAC on pma_pcno = 'STANDARD'
		Where	sih_cocde = @cocde and sih_invno = @docno 
		and	sih_netamt > 0
--		and 	sid_credat >= '2003-10-01'	-- Marco at 20031020
		and 	sih_credat >= '2003-10-01'
		and	(pdv_pcno is null or pdv_pcno = '' or pdv_pcno = 'STANDARD')  
		group by pdv_pcno, sih_cocde, sih_cus1no, cpi_paytrm, sih_prctrm, pma_siacno, sih_curcde, yli_pcfty


		select @tempamtSA4 = isnull(sum(vw_amount), 0) from #TMP_SA_RESULT
		insert into #SA_RESULT select * from #TMP_SA_RESULT
		delete from #TMP_SA_RESULT



		/* Overwrite Profit Center to STANDARD for vw_pcfty is not blank */
		update #SA_RESULT set vw_pcno = 'STANDARD', vw_account = @AC_SA
		from #SA_RESULT 
		where vw_dptyp = 'A' and vw_pcfty <> '' and vw_pcfty is not null

		/* Apply Product Line with Profit Center Factory Logic for vw_pcfty is not blank*/
		update #SA_RESULT set vw_pcno = pdv_pcno, vw_account = pma_siacno
		from #SA_RESULT, PCMDV, PCMAC
		where 	vw_dptyp = 'A' and vw_pcfty <> '' and vw_pcfty is not null
		and	vw_pcfty = pdv_vencde
		and 	pdv_pcno = pma_pcno 


		/* Adjustment for rounding*/
		insert into #SA_RESULT
		Select	distinct vw_pcno = 'STANDARD',
			vw_cocde = sih_cocde,
			vw_doctyp = @type,
			vw_docno = @docno,
			vw_cusno = sih_cus1no,
			vw_paytrm = cpi_paytrm,
			vw_prctrm = sih_prctrm,
			vw_dptyp = 'A',

			vw_disprm = '',
			vw_account = @AC_SA,
			vw_curcde = sih_curcde,
			vw_amount = isnull(@tempamtSA1 - @tempamtSA2 - @tempamtSA3 - @tempamtSA4, 0),
			vw_pcfty = ''
		From	SAINVHDR
		left join SAINVDTL on sih_cocde = sid_cocde and sih_invno = sid_invno
		left join CUPRCINF on sih_cus1no = cpi_cusno
		Where	sih_cocde = @cocde and sih_invno = @docno 
		and	sih_netamt > 0

		Declare cur_BAINVDTL_SA cursor
		for
		Select	vw_cocde,
			vw_doctyp,
			vw_docno,
			vw_cusno,
			vw_paytrm,
			vw_prctrm,
			vw_dptyp,
			vw_disprm,
			vw_account,
			vw_curcde,
			sum(vw_amount)
  		from	#SA_RESULT vw
		where vw_amount <> 0
		Group by
			vw_cocde, vw_doctyp, vw_docno,  vw_cusno, vw_paytrm, vw_prctrm, vw_dptyp, vw_disprm, vw_account, vw_curcde
		having sum(vw_amount) <> 0

		Open cur_BAINVDTL_SA
		Fetch next from cur_BAINVDTL_SA into
		@vw_cocde,
		@vw_doctyp,
		@vw_docno,
		@vw_cusno,
		@vw_paytrm,
		@vw_prctrm,
		@vw_dptyp,
		@vw_disprm,
		@vw_account,
		@vw_curcde,
		@vw_amount

		While @@fetch_status = 0
		begin

			Select	@line = count(*) + 1
			From	BAINVDTL
			Where	bid_cocde = @cocde and bid_doctyp = @type and bid_seqno = @nExist
			and 	bid_docno = @docno and convert(char(10), bid_txndat, 101) = convert(char(10), getdate(), 101)

			-- Insert into BAINVDTL
			Insert into BAINVDTL (
			bid_cocde,
			bid_doctyp,
			bid_docno,
			bid_issdat,
			bid_txndat,
			bid_cusno,
			bid_paytrm,
			bid_prctrm,
			bid_seqno,
			bid_pstno,
			bid_dptyp,
			bid_disprm,
			bid_account,
			bid_desc,
			bid_curcde,
			bid_amount,
			bid_credat,
			bid_creusr,
			bid_upddat,
			bid_updusr )

			values (
			@vw_cocde,
			@vw_doctyp,
			@vw_docno,
			@postdat,
			@TxnDat,
			@vw_cusno,
			@vw_paytrm,
			@vw_prctrm,
			@nExist,
			@line,
			@vw_dptyp,
			@vw_disprm,
			@vw_account,
			@Desc,
			@vw_curcde,
			@vw_amount,
			getdate(),
			'PostUsr',
			getdate(),

			'PostUsr' )

			If @@rowcount = 0
			begin
				Print @vw_doctyp + ' / ' + @vw_docno
			end

			-- Write to Export File
		
			Fetch next from cur_BAINVDTL_SA into
			@vw_cocde,
			@vw_doctyp,
			@vw_docno,
			@vw_cusno,
			@vw_paytrm,
			@vw_prctrm,
			@vw_dptyp,
			@vw_disprm,
			@vw_account,
			@vw_curcde,
			@vw_amount
		End
		Close cur_BAINVDTL_SA
		Deallocate cur_BAINVDTL_SA
		delete from #SA_RESULT
	End

	If @type = 'EL' or @type = 'EA'
	Begin
		Declare cur_BAINVDTL_E cursor
		for
		Select	vw_cocde,
			vw_doctyp,
			vw_docno,
			vw_cusno,
			vw_paytrm,
			vw_prctrm,
			vw_dptyp,
			vw_disprm,
			vw_account,
			vw_curcde,
			sum(vw_amount)
		From
		(Select	vw_cocde = bid_cocde,
			vw_doctyp = @type,
			vw_docno = @docno,
			vw_cusno = bid_cusno,
			vw_paytrm = bid_paytrm,
			vw_prctrm = bid_prctrm,
			vw_dptyp = bid_dptyp,
			vw_disprm = bid_disprm,
			vw_account = bid_account,
			vw_curcde = bid_curcde,
			vw_amount = -1 * sum(bid_amount)
		From	BAINVDTL
		where	bid_cocde = 'ELLI' and bid_doctyp = @type and bid_docno = @docno
		Group by	
			bid_cocde, bid_doctyp, bid_docno, bid_cusno, bid_paytrm, bid_prctrm, bid_dptyp, bid_disprm, bid_account, bid_curcde
		Union

		Select	vw_cocde = 'ELLI', 
			vw_doctyp = @type,
			vw_docno = @docno,
			vw_cusno =  hie_cus1no,
			vw_paytrm = '002',		-- Assumption
			vw_prctrm = 'FOB HK',		-- Assumption
			vw_dptyp = 'A',
			vw_disprm = '',
			vw_account = Case @type When 'EL' then @AC_SH When 'EA' then @AC_SA Else '' end,
			vw_curcde = hie_curcde,
			vw_amount = hie_ttlamt
		From	SHINVELL
		Where	hie_cocde = 'UCP' and hie_invtyp = @type and hie_invno = @docno
		and	hie_ttlamt <> 0

		Union

		Select	vw_cocde = 'ELLI',
			vw_doctyp = @type,
			vw_docno = @docno,
			vw_cusno = hie_cus1no,
			vw_paytrm = '002',		-- Assumption
			vw_prctrm = 'FOB HK',		-- Assumption
			vw_dptyp = 'B',
			vw_disprm = '',
			vw_account = Case @type When 'EL' then @AC_SHADJ Else '' end,
			vw_curcde = hie_curcde,
			vw_amount = -1 * hie_disamt
		From	SHINVELL
		Where	hie_cocde = 'UCP' and hie_invtyp = @type and hie_invno = @docno
		and	hie_disamt <> 0
		) vw
		where vw_amount <> 0
		Group by
			vw_cocde, vw_doctyp, vw_docno, vw_cusno, vw_paytrm, vw_prctrm, vw_dptyp, vw_disprm, vw_account, vw_curcde
		having	sum(vw_amount) <> 0		

		Open cur_BAINVDTL_E
		Fetch next from cur_BAINVDTL_E into
		@vw_cocde,
		@vw_doctyp,
		@vw_docno,
		@vw_cusno,
		@vw_paytrm,
		@vw_prctrm,
		@vw_dptyp,
		@vw_disprm,
		@vw_account,
		@vw_curcde,
		@vw_amount

		While @@fetch_status = 0
		begin

			Select	@line = count(*) + 1
			From	BAINVDTL
			Where	bid_cocde = 'ELLI' and bid_doctyp = @type and bid_seqno = @nExist
			and 	bid_docno = @docno and convert(char(10), bid_txndat, 101) = convert(char(10), getdate(), 101)
	
			-- Insert into BAINVDTL
			Insert into BAINVDTL (
			bid_cocde,
			bid_doctyp,
			bid_docno,
			bid_issdat,
			bid_txndat,
			bid_cusno,
			bid_paytrm,
			bid_prctrm,
			bid_seqno,
			bid_pstno,
			bid_dptyp,
			bid_disprm,
			bid_account,
			bid_desc,
			bid_curcde,

			bid_amount,
			bid_credat,
			bid_creusr,
			bid_upddat,
			bid_updusr )
			values (
			'ELLI',		--@vw_cocde,
			@vw_doctyp,
			@vw_docno,
			@postdat,
			@TxnDat,
			@vw_cusno,
			@vw_paytrm,
			@vw_prctrm,
			@nExist,
			@line,
			@vw_dptyp,
			@vw_disprm,
			@vw_account,
			@Desc,
			@vw_curcde,
			@vw_amount,
			getdate(),
			'PostUsr',
			getdate(),
			'PostUsr' )

			If @@rowcount = 0
			begin
				Print @vw_doctyp + ' / ' + @vw_docno
			end

			-- Write to Export File

			Fetch next from cur_BAINVDTL_E into
			@vw_cocde,
			@vw_doctyp,

			@vw_docno,
			@vw_cusno,
			@vw_paytrm,
			@vw_prctrm,
			@vw_dptyp,
			@vw_disprm,
			@vw_account,
			@vw_curcde,
			@vw_amount
		End
		Close cur_BAINVDTL_E
		Deallocate cur_BAINVDTL_E

	End

	Fetch next from cur_Invoice into
	@cocde,
	@type,
	@docno,
	@postdat,
	@slnonbdat
End
Close cur_Invoice
Deallocate cur_Invoice

--Update the Last Posting Date after Posting
Set @dateTo = ltrim(str(year(getdate()))) + '-' + ltrim(str(month(getdate()))) + '-' +  ltrim(str(day(getdate())))  +   ' 00:00:00.000'
If @Post_flag = 'Y' or @Post_flag_A = 'Y'
begin
	Update	BAINVDTL 
	set 	bid_issdat = Case when @Post_flag_A = 'Y' then @dateTo else bid_issdat end,
		bid_txndat = Case when @Post_flag = 'Y' then @dateTo else bid_txndat end,
		bid_updusr = 'PostUsr', 
		bid_upddat = @TxnDat
	Where 	bid_cocde = 'AHEAD'
end

End
GO
GRANT EXECUTE ON [dbo].[sp_insert_BAINVDTL] TO [ERPUSER] AS [dbo]
GO
