/****** Object:  StoredProcedure [dbo].[sp_list_FtyPay_EDI]    Script Date: 09/29/2017 15:29:09 ******/
DROP PROCEDURE [dbo].[sp_list_FtyPay_EDI]
GO
/****** Object:  StoredProcedure [dbo].[sp_list_FtyPay_EDI]    Script Date: 09/29/2017 15:29:09 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO








/*
=========================================================
Program ID	: 	sp_list_FtyPay_EDI
Description   	: 	Profit Center Reporting
Programmer  	: 	Marco Chan
ALTER  Date   	: 	20 Sept 2003
Last Modified  	: 
Table Read(s) 	:	
Table Write(s) 	:
=========================================================
 Modification History                                    
=========================================================

               
=========================================================     
*/
--sp_list_FtyPay_EDI '', '03/22/2004 00:00:00.00', '03/28/2004 23:59:59.99', '', '', 'A', 'B', 'A', 'SH', 'XIJ', 'HKD'
CREATE      procedure [dbo].[sp_list_FtyPay_EDI]
@defCocde nvarchar(6),
@InvDatFm	datetime,
@InvDatTo	datetime,
@CoCdeFm	nvarchar(20),
@CoCdeTo	nvarchar(20),
@PrdVenFm	nvarchar(20),
@PrdVenTo	nvarchar(20),
@InvStatus	nvarchar(1),
@InvType	nvarchar(2),
@VenType	nvarchar(3),
@CurrCde	nvarchar(3)

AS

Begin

declare 
@OptInvDat nvarchar(1),
@OptCoCde nvarchar(1),
@OptVenTyp nvarchar(1),
@OptPrdVen nvarchar(1),
@OptVenTypE nvarchar(1),
@OptVenTypI nvarchar(1),
@OptVenTypJ nvarchar(1)

if @InvDatFm = ''
   set @OptInvDat = 'N'
else
   set @OptInvDat = 'Y'

if @CoCdeFm = ''
   set @OptCoCde = 'N'
else
   set @OptCoCde = 'Y'

if @PrdVenFm = ''
   set @OptPrdVen = 'N'
else
   set @OptPrdVen = 'Y'

if @InvStatus = ''
   set @InvStatus = 'A'

if @InvType=''
   set @InvType = 'A'

if @VenType = ''
   set @OptVenTyp = 'N'
else
begin
   set @OptVenTyp = 'Y'

   if substring(@VenType, 1, 1) = 'E'
	set @OptVenTypE = 'Y'
   else
	set @OptVenTypE = 'N'

   if substring(@VenType, 2, 1) = 'I'
	set @OptVenTypI = 'Y'
   else
	set @OptVenTypI = 'N'

   if substring(@VenType, 3, 1) = 'J'
	set @OptVenTypJ = 'Y'
   else
	set @OptVenTypJ = 'N'

end

if @CurrCde = 'HKD' 
	set @CurrCde = 'HKD'
else
	set @CurrCde = 'USD'


declare @curcde nvarchar(10)
declare @fixbuyrat numeric(16,11)
declare @fixselrat numeric(16,11)

select @fixbuyrat = ysi_buyrat, @fixselrat = ysi_selrat from SYSETINF where ysi_typ = '06' and ysi_cde = 'HKD'

create table #TEMP_RESULT (
   tmp_cocde	nvarchar(6),
   tmp_shpno	nvarchar(20),
   tmp_shpseq	int,
   tmp_slnonb	nvarchar(20),
   tmp_invdat	nvarchar(20),
   tmp_cusno	nvarchar(12),
   tmp_cussna	nvarchar(20),
   tmp_invno	nvarchar(20),
   tmp_scno	nvarchar(20),
   tmp_jobno	nvarchar(40),
   tmp_dgnven	nvarchar(6),
   tmp_prdven	nvarchar(6),
   tmp_itmno	nvarchar(20),
   tmp_packing	nvarchar(100),
   tmp_colcde	nvarchar(30),
   tmp_qty	int,
   tmp_untcde	nvarchar(6),
   tmp_untdesc	nvarchar(100),
   tmp_untconvert	numeric(12,4),
   tmp_curcde	nvarchar(6),
   tmp_itmcst	numeric(13,4),
   tmp_bomcur	nvarchar(6),
   tmp_bomcst	numeric(13,4),
   tmp_purord	nvarchar(40),
   tmp_ttlitmcst	numeric(13,4)
)

create table #RESULT (
   res_cocde	nvarchar(6),
   res_shpno	nvarchar(20),
   res_shpseq	int,
   res_slnonb	nvarchar(20),
   res_invdat	nvarchar(20),
   res_cusno	nvarchar(12),
   res_cussna	nvarchar(20),
   res_invno	nvarchar(20),
   res_screqno	nvarchar(20),
   res_jobno	nvarchar(40),
   res_dv	nvarchar(6),
   res_pv	nvarchar(6),
   res_itmno	nvarchar(20),
   res_packing	nvarchar(100),
   res_colcde	nvarchar(30),
   res_qty	int,
   res_untcde	nvarchar(6),
   res_untdesc	nvarchar(100),
   res_untconvert	numeric(12,4),
   res_curcde	nvarchar(6),
   res_untcst	numeric(13,4),
   res_bomcur	nvarchar(6),
   res_bomcst	numeric(13,4),
   res_pono	nvarchar(40),
   res_ttlitmcst	numeric(13,4)
)


declare @cocde nvarchar(6), @type nvarchar(2), @docno nvarchar(20)

Declare cur_Invoice cursor
for
--Extract Invoice
Select	distinct hiv_cocde, 'SH', hiv_invno--, hiv_invdat
From	SHIPGHDR (nolock)
	left join SHIPGDTL (nolock) on hih_cocde = hid_cocde and hih_shpno = hid_shpno
	left join SHINVHDR (nolock) on hih_cocde = hiv_cocde and hid_shpno = hiv_shpno and hid_invno = hiv_invno
	left join SHDISPRM (nolock) on hih_cocde = hdp_cocde and hiv_invno = hdp_invno and hiv_invno = hdp_invno
	left join SYDISPRM (nolock) on hdp_type = ydp_type and hdp_cde = ydp_cde
	left join SCORDHDR (nolock) on soh_cocde = hid_cocde and soh_ordno = hid_ordno
where	hiv_invsts <> 'C' 
	and  ((@InvStatus='A' ) or (@InvStatus='R' and hih_shpsts='REL'))
--	and (@OptInvDat = 'N' or (hiv_invdat between @InvDatFm and @InvDatTo))
--	and (@OptInvDat = 'N' or (hih_upddat between @InvDatFm and @InvDatTo))
	and (@OptInvDat = 'N' or ((hiv_upddat between @InvDatFm and @InvDatTo) or (hih_slnonb + 5 between @InvDatFm and @InvDatTo)))
	and (@InvType in ('A' ,'SH'))
Union
Select 	distinct sih_cocde, 'SA', sih_invno--, sih_issdat
From	SAINVHDR (nolock) 
	left join SAINVDTL (nolock) on sih_cocde = sid_cocde and sih_invno = sid_invno
	left join CUPRCINF (nolock) on sih_cus1no = cpi_cusno
Where	sih_invno <> '' 
	and ((@InvStatus='A' and (sih_invsts = 'REL' or sih_invsts = 'CLO')) or (@InvStatus='R' and sih_invsts='REL'))
	and (@OptInvDat = 'N' or (sih_issdat between @InvDatFm and @InvDatTo))
	and (@InvType in ('A','SA'))

order by	2, 1, 3

Open cur_Invoice
Fetch next from cur_Invoice into
@cocde,
@type,
@docno

While @@fetch_status = 0
Begin
--	select @cocde, @type, @docno, getdate()
--	print @cocde + ' : ' + @type + ' : ' + @docno + ' : ' + 'Marco001' + convert(varchar(50), getdate(), 109)

	-- Get SHIPGDTL into #TEMP_RESULT_DTL (ibi_itmno)
	insert into #TEMP_RESULT
	select 	hiv.hiv_cocde,
		hid.hid_shpno,
		hid.hid_shpseq,
		isnull(convert(nvarchar(20),hih.hih_slnonb,101), ''),
		isnull(convert(nvarchar(20),hiv.hiv_invdat,101), ''),
		hih.hih_cus1no,
		cbi.cbi_cussna,
		hiv.hiv_invno,
		hid.hid_ordno,
		hid.hid_jobno,
		isnull(ibi.ibi_venno, ''),
		case hid.hid_venno when '0005' then 
					case sod.sod_subcde when 'WTX' then 'B'
							    when 'WY' then 'C'
							    when '0007' then 'D'
							    when 'HE' then 'E'
							    when 'HEC' then 'E'
							    when 'FC' then 'F'
							    when 'UGIL' then 'G'
							    when 'HY' then 'H'
							    when 'WM' then 'J'
							    when 'WB' then 'K'
							    when 'LW' then 'L'
							    when 'TY' then 'T'
							    else 'A' end
				   when '0006' then 'H'
				   else isnull(hid.hid_venno, '') end,
		hid.hid_itmno,
		convert(varchar(50), hid.hid_inrctn) + ' / ' + convert(varchar(50), hid.hid_mtrctn) + ' / ' + convert(varchar(50), hid.hid_vol),
		hid.hid_colcde, 
		hid.hid_shpqty,
		hid.hid_untcde, 
		ycf.ycf_dsc1,
		ycf.ycf_value,
		poh.poh_curcde,
		isnull(pod.pod_ftyprc,0)*(1.00 - isnull(poh.poh_discnt,0)/100.00),
		sod.sod_fcurcde,
		sod.sod_bomcst,
		hid.hid_purord,
		0
	from
		SHIPGHDR hih (nolock)
		left join SHIPGDTL hid (nolock) on hih.hih_cocde = hid.hid_cocde and hih.hih_shpno = hid.hid_shpno
		left join SHINVHDR hiv (nolock) on hih.hih_cocde = hiv.hiv_cocde and hid.hid_shpno = hiv.hiv_shpno and hid.hid_invno = hiv.hiv_invno

		left join SCORDDTL sod (nolock) on sod.sod_cocde = hid.hid_cocde and sod_ordno = hid_ordno and sod_ordseq = hid_ordseq

		left join POORDDTL pod (nolock) on pod.pod_cocde = hid.hid_cocde
						and pod.pod_purord = hid.hid_purord
						and pod.pod_purseq = hid.hid_purseq

		left join POORDHDR poh (nolock) on pod.pod_cocde = poh.poh_cocde
						and pod.pod_purord = poh.poh_purord

		left join IMBASINF ibi (nolock) on hid.hid_itmno = ibi.ibi_itmno and ibi_itmsts <> 'CLO'

		left join VNBASINF vbi (nolock) on vbi.vbi_venno = hid.hid_venno	-- get the vendor type of production vendor

		left join CUBASINF cbi (nolock) on cbi.cbi_cusno = hih.hih_cus1no

		left join SYCONFTR ycf (nolock) on ycf.ycf_code1 = hid.hid_untcde
	where 
		hiv.hiv_cocde = @cocde and
		hih.hih_shpsts in ('OPE','REL') and
		hiv.hiv_invsts <> 'C' and
		hiv.hiv_invno = @docno and
		hiv.hiv_invamt <> 0
		and ibi.ibi_venno not in ('0005','0006','0007','0008','0009')
		and (@OptCoCde = 'N' or (hiv_cocde between @CoCdeFm and @CoCdeTo))
		and (@OptVenTyp = 'N' or ((@OptVenTypE='Y' and vbi.vbi_ventyp='E') or (@OptVenTypI='Y' and vbi.vbi_ventyp='I') or (@OptVenTypJ='Y' and vbi.vbi_ventyp='J')))



	-- Get SHIPGDTL into #TEMP_RESULT_DTL (ibi_alsitmno)
	insert into #TEMP_RESULT
	select 	hiv.hiv_cocde,
		hid.hid_shpno,
		hid.hid_shpseq,
		isnull(convert(nvarchar(20),hih.hih_slnonb,101), ''),
		isnull(convert(nvarchar(20),hiv.hiv_invdat,101), ''),
		hih.hih_cus1no,
		cbi.cbi_cussna,
		hiv.hiv_invno,
		hid.hid_ordno,
		hid.hid_jobno,
		isnull(ibi.ibi_venno, ''),
		case hid.hid_venno when '0005' then 
					case sod.sod_subcde when 'WTX' then 'B'
							    when 'WY' then 'C'
							    when '0007' then 'D'
							    when 'HE' then 'E'
							    when 'HEC' then 'E'
							    when 'FC' then 'F'
							    when 'UGIL' then 'G'
							    when 'HY' then 'H'
							    when 'WM' then 'J'
							    when 'WB' then 'K'
							    when 'LW' then 'L'
							    when 'TY' then 'T'
							    else 'A' end
				   when '0006' then 'H'
				   else isnull(hid.hid_venno, '') end,
		hid.hid_itmno,
		convert(varchar(50), hid.hid_inrctn) + ' / ' + convert(varchar(50), hid.hid_mtrctn) + ' / ' + convert(varchar(50), hid.hid_vol),
		hid.hid_colcde, 
		hid.hid_shpqty,
		hid.hid_untcde, 
		ycf.ycf_dsc1,
		ycf.ycf_value,
		poh.poh_curcde,
		isnull(pod.pod_ftyprc,0)*(1.00 - isnull(poh.poh_discnt,0)/100.00),
		sod.sod_fcurcde,
		sod.sod_bomcst,
		hid.hid_purord,
		0
	from
		SHIPGHDR hih (nolock)
		left join SHIPGDTL hid (nolock) on hih.hih_cocde = hid.hid_cocde and hih.hih_shpno = hid.hid_shpno
		left join SHINVHDR hiv (nolock) on hih.hih_cocde = hiv.hiv_cocde and hid.hid_shpno = hiv.hiv_shpno and hid.hid_invno = hiv.hiv_invno

		left join SCORDDTL sod (nolock) on sod.sod_cocde = hid.hid_cocde and sod_ordno = hid_ordno and sod_ordseq = hid_ordseq

		left join POORDDTL pod (nolock) on pod.pod_cocde = hid.hid_cocde
						and pod.pod_purord = hid.hid_purord
						and pod.pod_purseq = hid.hid_purseq

		left join POORDHDR poh (nolock) on pod.pod_cocde = poh.poh_cocde
						and pod.pod_purord = poh.poh_purord

		left join IMBASINF ibi (nolock) on hid.hid_itmno = ibi.ibi_alsitmno and ibi_itmsts <> 'CLO'

		left join VNBASINF vbi (nolock) on vbi.vbi_venno = hid.hid_venno	-- get the vendor type of production vendor

		left join CUBASINF cbi (nolock) on cbi.cbi_cusno = hih.hih_cus1no

		left join SYCONFTR ycf (nolock) on ycf.ycf_code1 = hid.hid_untcde
	where 
		hiv.hiv_cocde = @cocde and
		hih.hih_shpsts in ('OPE','REL') and
		hiv.hiv_invsts <> 'C' and
		hiv.hiv_invno = @docno and
		hiv.hiv_invamt <> 0
		and ibi.ibi_venno not in ('0005','0006','0007','0008','0009')
		and (@OptCoCde = 'N' or (hiv_cocde between @CoCdeFm and @CoCdeTo))
		and (@OptVenTyp = 'N' or ((@OptVenTypE='Y' and vbi.vbi_ventyp='E') or (@OptVenTypI='Y' and vbi.vbi_ventyp='I') or (@OptVenTypJ='Y' and vbi.vbi_ventyp='J')))


	


	insert into #RESULT
	select tmp_cocde, tmp_shpno, tmp_shpseq, tmp_slnonb, tmp_invdat, tmp_cusno, tmp_cussna, tmp_invno, tmp_scno, tmp_jobno,
		tmp_dgnven, tmp_prdven, tmp_itmno, tmp_packing, tmp_colcde,
		sum(tmp_qty), tmp_untcde, tmp_untdesc, tmp_untconvert, tmp_curcde, tmp_itmcst, tmp_bomcur, tmp_bomcst, tmp_purord, 0
	from #TEMP_RESULT
	group by tmp_cocde, tmp_shpno, tmp_shpseq, tmp_slnonb, tmp_invdat, tmp_cusno, tmp_cussna, tmp_invno, tmp_scno, tmp_jobno,
		tmp_dgnven, tmp_prdven, tmp_itmno, tmp_packing, tmp_colcde,
		tmp_untcde, tmp_untdesc, tmp_untconvert, tmp_curcde, tmp_itmcst, tmp_bomcur, tmp_bomcst, tmp_purord

	delete from #TEMP_RESULT

	Fetch next from cur_Invoice into
	@cocde,
	@type,
	@docno
end
close cur_Invoice
deallocate cur_Invoice


if @CurrCde = 'HKD' 
begin

update #RESULT set res_untcst = res_untcst / @fixbuyrat
where res_curcde = 'USD'

update #RESULT set res_bomcst = res_bomcst / @fixbuyrat
where res_bomcur = 'USD'

end
else
begin

update #RESULT set res_untcst = res_untcst * @fixbuyrat
where res_curcde = 'HKD'

update #RESULT set res_bomcst = res_bomcst * @fixbuyrat
where res_bomcur = 'USD'

end

-- Calculate ttlitmcst
update #RESULT set res_untcst = res_untcst + res_bomcst
update #RESULT set res_ttlitmcst = res_untcst * res_qty




declare @rptdate datetime
set @rptdate = getdate()

insert into FTYPAYDTL
select 
@rptdate,
res_cocde,
res_shpno,
res_shpseq,
res_slnonb,
res_invdat,
res_cusno,
res_cussna,
res_invno,
res_screqno,
res_jobno,
res_dv,
res_pv,
res_itmno,
res_packing,
res_colcde,
res_qty,
res_untcde,
res_untdesc,
res_untconvert,
res_untcst,
res_pono,
res_ttlitmcst
from #RESULT
where (@OptPrdVen = 'N' or (res_pv between @PrdVenFm and @PrdVenTo))

insert into FTYPAYDTL
select
distinct
@rptdate,
fpd_cocde,
fpd_shpno,
fpd_shpseq,
isnull(convert(nvarchar(20),hih_slnonb,101), ''),
isnull(convert(nvarchar(20),hiv_invdat,101), ''),
fpd_cusno,
fpd_cussna,
fpd_invno,
fpd_screqno,
fpd_jobno,
fpd_dv,
fpd_pv,
fpd_itmno,
fpd_packing,
fpd_colcde,
0,
fpd_untcde,
fpd_untdesc,
fpd_untconvert,
0,
fpd_pono,
0
from FTYPAYDTL (nolock)
left join SHINVHDR (nolock) on fpd_invno = hiv_invno
left join SHIPGHDR (nolock) on fpd_shpno = hih_shpno
left join SHIPGDTL (nolock) on fpd_shpno = hid_shpno and fpd_shpseq = hid_shpseq and hid_invno = fpd_invno
where hid_shpno is null
and ((hiv_upddat between @InvDatFm and @InvDatTo) or (hih_slnonb + 5 between @InvDatFm and @InvDatTo))

insert into 
FTYPAYDTLH
select FTYPAYDTL.*
from FTYPAYDTL, SHIPGHDR 
where fpd_shpno = hih_shpno and hih_shpsts = 'REL' and fpd_rptdat <> @rptdate

delete FTYPAYDTL from FTYPAYDTL, SHIPGHDR
where fpd_shpno = hih_shpno and hih_shpsts = 'REL' and fpd_rptdat <> @rptdate


select 
fpd_cocde as 'res_cocde',
fpd_slnonb as 'res_slnonb',
fpd_invdat as 'res_invdat',
fpd_cusno as 'res_cusno',
fpd_cussna as 'res_cussna',
fpd_screqno as 'res_screqno',
fpd_jobno as 'res_jobno',
fpd_dv as 'res_dv',
fpd_pv as 'res_pv',
fpd_itmno as 'res_itmno',
fpd_packing as 'res_packing',
fpd_colcde as 'res_colcde',
fpd_qty as 'res_qty',
fpd_untcde as 'res_untcde',
fpd_untdesc as 'res_untdesc',
fpd_untconvert as 'res_untconvert',
fpd_untcst as 'res_untcst',
fpd_pono as 'res_pono',
fpd_ttlitmcst as 'res_ttlitmcst',
fpd_invno as 'res_invno',
fpd_shpno as 'res_shpno',
fpd_shpseq as 'res_shpseq'
from FTYPAYDTL
where fpd_rptdat = @rptdate
order by fpd_cocde, fpd_shpno, fpd_shpseq, fpd_screqno, fpd_jobno, fpd_invno 




end










GO
GRANT EXECUTE ON [dbo].[sp_list_FtyPay_EDI] TO [ERPUSER] AS [dbo]
GO
