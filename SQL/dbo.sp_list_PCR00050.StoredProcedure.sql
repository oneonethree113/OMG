/****** Object:  StoredProcedure [dbo].[sp_list_PCR00050]    Script Date: 09/29/2017 15:29:09 ******/
DROP PROCEDURE [dbo].[sp_list_PCR00050]
GO
/****** Object:  StoredProcedure [dbo].[sp_list_PCR00050]    Script Date: 09/29/2017 15:29:10 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO



/*
==================================================================================================================
Program ID	: 	sp_list_PCR00050
Description   	: 	Custom Vendor to Production Vendor Distribution Report
Programmer  	: 	Lester Wu
ALTER  Date   	: 	3rd Jun, 2005
Last Modified  	: 
Table Read(s) 	:	
Table Write(s) 	:
==================================================================================================================
 Modification History                                    
==================================================================================================================
 Last Update	Updated by		Description
==================================================================================================================     

==================================================================================================================     
*/

--sp_list_PCR00050 '', '','', '','', '01/01/2004 00:00:00.000','01/05/2004 23:59:59', '50001', '50001', '','', '','', '','', '','', 'XIJ','R','SH'

--sp_list_PCR00050 'UCPP','','','01/01/2005','01/05/2005','','','','','A','A','','','','','','','','','R','SH','DTL'
--sp_list_PCR00050 'UCPP','','','01/01/2005','01/05/2005','','','','','','','','','','','','','','','R','A','DTL'



/****** Object:  Stored Procedure dbo.sp_list_PCR00050    Script Date: 11/18/2003 9:32:54 AM ******/


CREATE      procedure [dbo].[sp_list_PCR00050]
@defCocde 	nvarchar(6),

@PCNOFM	varchar(6),
@PCNOTO	varchar(6),

@InvDatFm	datetime,
@InvDatTo	datetime,

@InvNoFm	varchar(20),
@InvNoTo		varchar(20),

@SCNoFm	varchar(20),
@SCNoTo		varchar(20),

@CusVenFm	varchar(20),
@CusVenTo	varchar(20),

@DesVenFm	varchar(20),
@DesVenTo	varchar(20),

@PrdVenFm	varchar(20),
@PrdVenTo	varchar(20),

@ItmNoFm	varchar(20),
@ItmNoTo	varchar(20),

@CoCdeFm	varchar(20),
@CoCdeTo	varchar(20),

@InvStatus	varchar(1),

@InvType	nvarchar(2),

@RptType		varchar(3)

AS

Begin

declare 
@OptInvDat varchar(1),
@OptInvNo varchar(1),
@OptSCNo varchar(1),
@OptCusVen varchar(1),
@OptDesVen varchar(1),
@OptPrdVen varchar(1),
@OptItmNo varchar(1),
@OptCoCde varchar(1),
@OptPcNo varchar(1)


if @InvDatFm = ''
   set @OptInvDat = 'N'
else
   set @OptInvDat = 'Y'

if @InvNoFm = ''
   set @OptInvNo = 'N'
else
   set @OptInvNo = 'Y'

if @SCNoFm = ''
   set @OptSCNo = 'N'
else
   set @OptSCNo = 'Y'

if @DesVenFm = ''
   set @OptDesVen = 'N'
else
   set @OptDesVen = 'Y'

if @PrdVenFm = ''
   set @OptPrdVen = 'N'
else
   set @OptPrdVen = 'Y'

if @ItmNoFm = ''
   set @OptItmNo = 'N'
else
   set @OptItmNo = 'Y'

if @CoCdeFm = ''
   set @OptCoCde = 'N'
else
   set @OptCoCde = 'Y'

if @InvStatus = ''
   set @InvStatus = 'A'

if @InvType=''
   set @InvType = 'A'

if @CusVenFm = ''
   set @OptCusVen = 'N'
else
   set @OptCusVen = 'Y'

if @PCNOFM = ''
   set @OptPcNo = 'N'
else
   set @OptPcNo = 'Y'


declare @curcde nvarchar(10)
declare @buyrat numeric(16,11)
declare @selrat numeric(16,11)
declare @fixbuyrat numeric(16,11)
declare @fixselrat numeric(16,11)

select @fixbuyrat = ysi_buyrat, @fixselrat = ysi_selrat from SYSETINF where ysi_typ = '06' and ysi_cde = 'HKD'

declare @ttlamt numeric(13,4)
declare @invamt numeric(13,4)
declare @afamt numeric(13,4)
declare @discntamt numeric(13,4)
declare @premamt numeric(13,4)

declare @ttlinvamt numeric(13,4)
declare @ttlafamt numeric(13,4)
declare @ttlpremamt numeric(13,4)
declare @ttldiscntamt numeric(13,4)

declare @invamtdiff numeric(13,4)
declare @afamtdiff numeric(13,4)
declare @premamtdiff numeric(13,4)
declare @discntamtdiff numeric(13,4)

declare @adjpcno nvarchar(20)
declare @adjinvdat datetime
declare @adjinvno nvarchar(20)
declare @adjscno nvarchar(20)

declare @netamt numeric(13,4)
declare @discnt int

create table #TEMP_RESULT_DTL (
   tmp_pcno	nvarchar(20),
   tmp_cocde	nvarchar(6),
   tmp_invdat	datetime,
   tmp_invno	nvarchar(20),
   tmp_scno	nvarchar(20),
   tmp_cusven	nvarchar(6),
   tmp_desven	nvarchar(6),
   tmp_prdven	nvarchar(6),
   tmp_itmno	nvarchar(20),
   tmp_selprc	numeric(13,4),
   tmp_qty		int,
   tmp_untcde	nvarchar(6),
   tmp_invamt	numeric(13,4),
--   tmp_purord	nvarchar(40),
   tmp_itmcst	numeric(13,4),
   tmp_bomcst	numeric(13,4),
   tmp_pcfty	nvarchar(20)
)


create table #TEMP_RESULT_GROUP (
   tmp_pcno	nvarchar(20),
   tmp_cocde	nvarchar(6),
   tmp_invdat	datetime,
   tmp_invno	nvarchar(20),
   tmp_scno	nvarchar(20),
   tmp_cusven	nvarchar(6),
   tmp_desven	nvarchar(6),
   tmp_prdven	nvarchar(6),
   tmp_itmno	nvarchar(20),
   tmp_selprc	numeric(13,4),
   tmp_qty	int,
   tmp_untcde	nvarchar(6),
   tmp_invamt	numeric(13,4),
   tmp_afamt	numeric(13,4),
   tmp_preamt	numeric(13,4),
   tmp_disamt	numeric(13,4),
   tmp_netsamt	numeric(13,4),
   tmp_itmcst	numeric(13,4),
   tmp_bomcst	numeric(13,4),
   tmp_netpft	numeric(13,4)
)

create table #RESULT (
   res_pcno		nvarchar(20),
   res_cocde	nvarchar(6),
   res_invdat	datetime,
   res_invno	nvarchar(20),
   res_scno		nvarchar(20),
   res_cusven	nvarchar(6),
   res_desven	nvarchar(6),
   res_prdven	nvarchar(6),
   res_itmno	nvarchar(20),
   res_selprc	numeric(13,4),
   res_qty	int,
   res_untcde	nvarchar(6),
   res_invamt	numeric(13,4),
   res_afamt	numeric(13,4),
   res_preamt	numeric(13,4),
   res_disamt	numeric(13,4),
   res_netsamt	numeric(13,4),
   res_itmcst	numeric(13,4),
   res_bomcst	numeric(13,4),
   res_netpft	numeric(13,4)
)


declare @yco_conam varchar(100)
set @yco_conam = 'United Chinese Group'


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
	and (@OptCoCde='N' or (hih_cocde between @CoCdeFm and @CoCdeTo))
	and (@OptInvDat = 'N' or (hiv_invdat between @InvDatFm and @InvDatTo))
	and (@OptInvNo = 'N' or (hiv_invno between @InvNoFm and @InvNoTo))
	and (@OptSCNo = 'N' or (soh_ordno between @SCNoFm and @SCNoTo))
	and (@InvType in ('A' ,'SH'))
	and ((@InvStatus='A' ) or (@InvStatus='R' and hih_shpsts='REL'))
Union

Select 	distinct sih_cocde, 'SA', sih_invno--, sih_issdat
From	SAINVHDR (nolock) 
	left join SAINVDTL (nolock) on sih_cocde = sid_cocde and sih_invno = sid_invno
	left join CUPRCINF (nolock) on sih_cus1no = cpi_cusno
Where	sih_invno <> '' 
	and (@OptCoCde='N' or (sih_cocde between @CoCdeFm and @CoCdeTo))
	and (@OptInvDat = 'N' or (sih_issdat between @InvDatFm and @InvDatTo))
	and (@OptInvNo = 'N' or (sih_invno between @InvNoFm and @InvNoTo))
	and (@InvType in ('A','SA'))
	and ((@InvStatus='A' and (sih_invsts = 'REL' or sih_invsts = 'CLO')) or (@InvStatus='R' and sih_invsts='REL'))
order by	2, 1, 3

Open cur_Invoice
Fetch next from cur_Invoice into
@cocde,
@type,
@docno

While @@fetch_status = 0
Begin

	If @type = 'SH'
	begin
		---------------------------------------------------------------------------------------------------
		select 	@ttlamt = isnull(hiv_ttlamt, 0),
			@invamt = isnull(hiv_invamt, 0), 
			@afamt = isnull(hiv_afamt, 0),
			@curcde = hiv_untamt, 
			@buyrat = ysi_buyrat 
		from SHINVHDR (nolock), SYSETINF (nolock)
		where hiv_cocde = @cocde and hiv_invno = @docno and ysi_cde = hiv_untamt and ysi_typ = '06'

		select @discntamt = isnull(sum(hdp_amt), 0) from SHDISPRM (nolock) where hdp_cocde = @cocde and hdp_invno = @docno and hdp_type = 'D'

		select @premamt = isnull(sum(hdp_amt), 0) from SHDISPRM (nolock) where hdp_cocde = @cocde and hdp_invno = @docno and hdp_type = 'P'

		if @curcde = 'HKD'
		begin
			set @ttlamt = @ttlamt * @buyrat
			set @invamt = @invamt * @buyrat
			set @afamt = @afamt * @buyrat
			set @discntamt = @discntamt * @buyrat
			set @premamt = @premamt * @buyrat
		end		

		-- Get SHIPGDTL into #TEMP_RESULT_DTL (ibi_itmno)
		insert into #TEMP_RESULT_DTL
		select 	isnull(pdv.pdv_pcno, 'STANDARD'), 
			hih.hih_cocde,
			hiv.hiv_invdat, 
			hiv.hiv_invno,
			hid.hid_ordno,
			case hid.hid_cusven
				when '0005' then case sod.sod_cussub
						when 'WTX' then 'B'
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
				else isnull(hid.hid_cusven, '') end,		--Custom Vendor
			isnull(ibi.ibi_venno,''),				--Design Vendor
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
					   else isnull(hid.hid_venno, '') end,		--Production Vendor
			--vbi.vbi_ventyp,
			hid.hid_itmno,
			case hid.hid_untsel when 'HKD' then (Case (case when hiv.hiv_aformat = '2' then 'C' else ( case when hiv.hiv_aformat = '1' then 'A' else 'C' end) end)
								when 'A' then round(hid.hid_selprc/1.05,2) else hid.hid_selprc end) * cursel.ysi_buyrat 
						else (Case (case when hiv.hiv_aformat = '2' then 'C' else ( case when hiv.hiv_aformat = '1' then 'A' else 'C' end) end)
								when 'A' then round(hid.hid_selprc/1.05,2) else hid.hid_selprc end) end,
			hid.hid_shpqty,
			hid.hid_untcde, 
			case hid.hid_untsel when 'HKD' then (Case (case when hiv_aformat = '2' then 'C' else ( case when hiv_aformat = '1' then 'A' else 'C' end) end)
								when 'A' then round(hid_shpqty*round(hid_selprc/1.05,2),2) else round(hid_shpqty*hid_selprc,2) end) * cursel.ysi_buyrat
						else (Case (case when hiv_aformat = '2' then 'C' else ( case when hiv_aformat = '1' then 'A' else 'C' end) end)
								when 'A' then round(hid_shpqty*round(hid_selprc/1.05,2),2) else round(hid_shpqty*hid_selprc,2) end) end,
			--hid.hid_purord,
			case poh.poh_curcde when 'HKD' then (isnull(pod.pod_ftyprc,0)*(1.00 - isnull(poh.poh_discnt,0)/100.00)) * curpo.ysi_buyrat
						else (isnull(pod.pod_ftyprc,0)*(1.00 - isnull(poh.poh_discnt,0)/100.00)) end,
			case pbh.pbh_curcde when 'HKD' then (isnull(pbd.pbd_ftyprc,0)*(1.00 - isnull(pbh.pbh_disprc,0)/100.00)) * curpobom.ysi_buyrat
						else (isnull(pbd.pbd_ftyprc,0)*(1.00 - isnull(pbh.pbh_disprc,0)/100.00)) end,
			isnull(yli.yli_pcfty,'')
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
		
			left join POBOMDTL pbd (nolock) on pbd.pbd_cocde = pod.pod_cocde
							and pbd.pbd_refpo = pod.pod_purord
							and pbd.pbd_regitm = pod.pod_itmno 
	 						and pbd.pbd_untcde = pod.pod_untcde
							and pbd.pbd_colcde = pod.pod_vencol
							and pbd.pbd_ordqty <> 0
		
			left join POBOMHDR pbh (nolock) on pbh.pbh_bompo = pbd.pbd_bompo
		
			left join IMBASINF ibi (nolock) on hid.hid_itmno = ibi.ibi_itmno and ibi_itmsts <> 'CLO'

			left join SYSETINF cursel (nolock) on cursel.ysi_cde = hid.hid_untsel and cursel.ysi_typ = '06'

			left join SYSETINF curpo (nolock) on curpo.ysi_cde = poh.poh_curcde and curpo.ysi_typ = '06'

			left join SYSETINF curpobom (nolock) on curpobom.ysi_cde = pbh.pbh_curcde and curpobom.ysi_typ = '06'

			left join SYLNEINF yli (nolock) on yli.yli_lnecde = ibi.ibi_lnecde
			left join PCMDV pdv (nolock) on pdv.pdv_vencde = ibi.ibi_cusven

		where 
			hiv.hiv_cocde = @cocde and
			hih.hih_shpsts in ('OPE','REL') and
			hiv.hiv_invsts <> 'C' and
			hiv.hiv_invno = @docno and
			hiv.hiv_invamt <> 0
			and ibi.ibi_venno not in ('0005','0006','0007','0008','0009')

--
		-- Get SHIPGDTL into #TEMP_RESULT_DTL (ibi_itmno)
		insert into #TEMP_RESULT_DTL
		select 	isnull(pdv.pdv_pcno, 'STANDARD'), 
			hih.hih_cocde,
			hiv.hiv_invdat, 
			hiv.hiv_invno,
			hid.hid_ordno,
			case hid.hid_cusven
				when '0005' then case sod.sod_cussub
						when 'WTX' then 'B'
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
				else isnull(hid.hid_cusven, '') end,		--Custom Vendor
			isnull(ibi.ibi_venno,''),				--Design Vendor
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
					   else isnull(hid.hid_venno, '') end,		--Production Vendor
			--vbi.vbi_ventyp,
			hid.hid_itmno,
			case hid.hid_untsel when 'HKD' then (Case (case when hiv.hiv_aformat = '2' then 'C' else ( case when hiv.hiv_aformat = '1' then 'A' else 'C' end) end)
								when 'A' then round(hid.hid_selprc/1.05,2) else hid.hid_selprc end) * cursel.ysi_buyrat 
						else (Case (case when hiv.hiv_aformat = '2' then 'C' else ( case when hiv.hiv_aformat = '1' then 'A' else 'C' end) end)
								when 'A' then round(hid.hid_selprc/1.05,2) else hid.hid_selprc end) end,
			hid.hid_shpqty,
			hid.hid_untcde, 
			case hid.hid_untsel when 'HKD' then (Case (case when hiv_aformat = '2' then 'C' else ( case when hiv_aformat = '1' then 'A' else 'C' end) end)
								when 'A' then round(hid_shpqty*round(hid_selprc/1.05,2),2) else round(hid_shpqty*hid_selprc,2) end) * cursel.ysi_buyrat
						else (Case (case when hiv_aformat = '2' then 'C' else ( case when hiv_aformat = '1' then 'A' else 'C' end) end)
								when 'A' then round(hid_shpqty*round(hid_selprc/1.05,2),2) else round(hid_shpqty*hid_selprc,2) end) end,
			--hid.hid_purord,
			case poh.poh_curcde when 'HKD' then (isnull(pod.pod_ftyprc,0)*(1.00 - isnull(poh.poh_discnt,0)/100.00)) * curpo.ysi_buyrat
						else (isnull(pod.pod_ftyprc,0)*(1.00 - isnull(poh.poh_discnt,0)/100.00)) end,
			case pbh.pbh_curcde when 'HKD' then (isnull(pbd.pbd_ftyprc,0)*(1.00 - isnull(pbh.pbh_disprc,0)/100.00)) * curpobom.ysi_buyrat
						else (isnull(pbd.pbd_ftyprc,0)*(1.00 - isnull(pbh.pbh_disprc,0)/100.00)) end,
			isnull(yli.yli_pcfty,'')
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
		
			left join POBOMDTL pbd (nolock) on pbd.pbd_cocde = pod.pod_cocde
							and pbd.pbd_refpo = pod.pod_purord
							and pbd.pbd_regitm = pod.pod_itmno 
	 						and pbd.pbd_untcde = pod.pod_untcde
							and pbd.pbd_colcde = pod.pod_vencol
							and pbd.pbd_ordqty <> 0
		
			left join POBOMHDR pbh (nolock) on pbh.pbh_bompo = pbd.pbd_bompo
		
			--left join IMBASINF ibi (nolock) on hid.hid_itmno = ibi.ibi_itmno and ibi_itmsts <> 'CLO'
			left join IMBASINF ibi (nolock) on hid.hid_itmno = ibi.ibi_alsitmno and ibi_itmsts <> 'CLO'

			left join SYSETINF cursel (nolock) on cursel.ysi_cde = hid.hid_untsel and cursel.ysi_typ = '06'

			left join SYSETINF curpo (nolock) on curpo.ysi_cde = poh.poh_curcde and curpo.ysi_typ = '06'

			left join SYSETINF curpobom (nolock) on curpobom.ysi_cde = pbh.pbh_curcde and curpobom.ysi_typ = '06'

			left join SYLNEINF yli (nolock) on yli.yli_lnecde = ibi.ibi_lnecde
			left join PCMDV pdv (nolock) on pdv.pdv_vencde = ibi.ibi_cusven

		where 
			hiv.hiv_cocde = @cocde and
			hih.hih_shpsts in ('OPE','REL') and
			hiv.hiv_invsts <> 'C' and
			hiv.hiv_invno = @docno and
			hiv.hiv_invamt <> 0
			and ibi.ibi_venno not in ('0005','0006','0007','0008','0009')


		update #TEMP_RESULT_DTL
		set tmp_pcno = 'STANDARD'
		where tmp_pcfty<>''

		update #TEMP_RESULT_DTL 
		set tmp_pcno = pdv_pcno
		from #TEMP_RESULT_DTL , PCMDV (nolock)
		where tmp_pcfty <> '' 
		and tmp_pcfty =  pdv_vencde


		-- Group #TEMP_RESULT_DTL into #TEMP_RESULT_GROUP
		insert into #TEMP_RESULT_GROUP
		select 	tmp_pcno,	tmp_cocde,	tmp_invdat, tmp_invno, 
			tmp_scno,	tmp_cusven,tmp_desven, tmp_prdven,
			tmp_itmno, tmp_selprc, sum(tmp_qty), tmp_untcde, sum(tmp_qty) * tmp_selprc, 
			@afamt*(sum(tmp_invamt)/@invamt),
			@premamt*(sum(tmp_invamt)/@invamt), 
			@discntamt*(sum(tmp_invamt)/@invamt),
			0, --Net Amount
			tmp_itmcst * sum(tmp_qty), tmp_bomcst * sum(tmp_qty),
			0
		from #TEMP_RESULT_DTL
		group by tmp_pcno,tmp_cocde,tmp_invdat, tmp_invno, 
			tmp_scno,tmp_cusven,tmp_desven, tmp_prdven,
			tmp_itmno, tmp_selprc, tmp_untcde,tmp_itmcst,tmp_bomcst

		update #TEMP_RESULT_GROUP set tmp_netsamt = tmp_invamt + tmp_preamt - tmp_disamt + tmp_afamt

		-- Rounding Display

		update #TEMP_RESULT_GROUP set tmp_netsamt = round(tmp_netsamt, 2), tmp_itmcst = round(tmp_itmcst, 2), tmp_bomcst = round(tmp_bomcst, 2)
		update #TEMP_RESULT_GROUP set tmp_netpft = tmp_netsamt - tmp_itmcst - tmp_bomcst

		insert into #RESULT
		select tmp_pcno,tmp_cocde, tmp_invdat, tmp_invno, 
			tmp_scno,tmp_cusven, tmp_desven,tmp_prdven,
			tmp_itmno, tmp_selprc, tmp_qty, tmp_untcde, tmp_invamt, tmp_afamt,
			tmp_preamt, tmp_disamt, tmp_netsamt, tmp_itmcst, tmp_bomcst, tmp_netpft
		from #TEMP_RESULT_GROUP

		delete from #TEMP_RESULT_DTL
		delete from #TEMP_RESULT_GROUP
	---------------------------------------------------------------------------------------------------

	end
	else if @type = 'SA'
	begin
	
		select @netamt = case sih_curcde when 'HKD' then isnull(sih_netamt,0) * ysi_buyrat else isnull(sih_netamt, 0) end, @discnt = isnull(sih_discnt, 0)  
		from SAINVHDR, SYSETINF 
		where sih_cocde = @cocde and sih_invno = @docno and ysi_cde = sih_curcde and ysi_typ = '06'
		
		if (@discnt >= 100)
		begin
			set @ttlamt = @netamt
		end
		else
		begin
			set @ttlamt = @netamt / (1-(@discnt/100.0))
		end

		-- Sample Invoice (ibi_itmno)
		insert into #TEMP_RESULT_DTL
		select 	isnull(pdv.pdv_pcno, 'STANDARD'), -- Profit Center
			sih.sih_cocde,
			sih.sih_issdat, 
			sih.sih_invno, 
			sid.sid_reqno, -- Req Number
			case sid.sid_cusven when '0005' then 
						case sid.sid_cussub when 'WTX' then 'B'
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
					   else isnull(sid.sid_cusven, '') end,-- Production Vendor

			isnull(ibi.ibi_venno,''),
			case sid.sid_venno when '0005' then 
						case sid.sid_subcde when 'WTX' then 'B'
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
					   else isnull(sid.sid_venno, '') end,-- Production Vendor
			sid.sid_itmno,
			case sid.sid_curcde when 'HKD' then isnull(sid.sid_selprc, 0) * cur.ysi_buyrat
							else isnull(sid.sid_selprc, 0) end, -- Selling Price
			sid.sid_chgqty, -- Qty
			sid.sid_untcde, -- UM
			case sid.sid_curcde when 'HKD' then isnull(sid.sid_ttlamt, 0) * cur.ysi_buyrat
							else isnull(sid.sid_ttlamt, 0) end, -- inv Amount
			case sid.sid_fcurcde when 'HKD' then isnull(sid.sid_ftyprc, 0) * fcur.ysi_buyrat
							else isnull(sid.sid_ftyprc, 0) end,
			0,  -- BOM cost
			isnull(yli.yli_pcfty,'')

		from SAINVHDR sih (nolock)
		left join SAINVDTL sid (nolock) on sih.sih_cocde = sid.sid_cocde and sih.sih_invno = sid.sid_invno
		left join IMBASINF ibi (nolock) on sid.sid_itmno = ibi.ibi_itmno and ibi_itmsts <> 'CLO'
		left join SYSETINF cur (nolock) on cur.ysi_cde = sid.sid_curcde and cur.ysi_typ = '06'
		left join SYSETINF fcur (nolock) on fcur.ysi_cde = sid.sid_fcurcde and fcur.ysi_typ = '06'

		left join SYLNEINF yli (nolock) on yli.yli_lnecde = ibi.ibi_lnecde
		left join PCMDV pdv (nolock) on pdv.pdv_vencde = ibi.ibi_venno

		where sih_cocde = @cocde and sih_invno = @docno
		and	sih_netamt > 0
		and ibi.ibi_venno not in ('0005','0006','0007','0008','0009')



		-- Sample Invoice (ibi_alsitmno)
		insert into #TEMP_RESULT_DTL
		select 	isnull(pdv.pdv_pcno, 'STANDARD'), -- Profit Center
			sih.sih_cocde,
			sih.sih_issdat, 
			sih.sih_invno, 
			sid.sid_reqno, -- Req Number
			case sid.sid_cusven when '0005' then 
						case sid.sid_cussub when 'WTX' then 'B'
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
					   else isnull(sid.sid_cusven, '') end,-- Custom Vendor
			isnull(ibi.ibi_venno,''),				-- Design Vendor
			case sid.sid_venno when '0005' then 
						case sid.sid_subcde when 'WTX' then 'B'
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
					   else isnull(sid.sid_venno, '') end,-- Production Vendor
			sid.sid_itmno,
			case sid.sid_curcde when 'HKD' then isnull(sid.sid_selprc, 0) * cur.ysi_buyrat
							else isnull(sid.sid_selprc, 0) end, -- Selling Price
			sid.sid_chgqty, -- Qty
			sid.sid_untcde, -- UM
			case sid.sid_curcde when 'HKD' then isnull(sid.sid_ttlamt, 0) * cur.ysi_buyrat
							else isnull(sid.sid_ttlamt, 0) end, -- inv Amount
			case sid.sid_fcurcde when 'HKD' then isnull(sid.sid_ftyprc, 0) * fcur.ysi_buyrat
							else isnull(sid.sid_ftyprc, 0) end,
			0,  -- BOM cost
			isnull(yli.yli_pcfty,'')

		from SAINVHDR sih (nolock)
		left join SAINVDTL sid (nolock) on sih.sih_cocde = sid.sid_cocde and sih.sih_invno = sid.sid_invno
		left join IMBASINF ibi (nolock) on sid.sid_itmno = ibi.ibi_alsitmno and ibi_itmsts <> 'CLO'
		left join SYSETINF cur (nolock) on cur.ysi_cde = sid.sid_curcde and cur.ysi_typ = '06'
		left join SYSETINF fcur (nolock) on fcur.ysi_cde = sid.sid_fcurcde and fcur.ysi_typ = '06'

		left join SYLNEINF yli (nolock) on yli.yli_lnecde = ibi.ibi_lnecde
		left join PCMDV pdv (nolock) on pdv.pdv_vencde = ibi.ibi_venno

		where sih_cocde = @cocde and sih_invno = @docno
		and	sih_netamt > 0
		and ibi.ibi_venno not in ('0005','0006','0007','0008','0009')

		update #TEMP_RESULT_DTL
		set tmp_pcno = 'STANDARD'
		where tmp_pcfty<>''

		update #TEMP_RESULT_DTL 
		set tmp_pcno = pdv_pcno
		from #TEMP_RESULT_DTL , PCMDV (nolock)
		where tmp_pcfty <> '' 
		and tmp_pcfty =  pdv_vencde

		-- Group #TEMP_RESULT_DTL into #TEMP_RESULT_GROUP
		insert into #TEMP_RESULT_GROUP
		select 	tmp_pcno,tmp_cocde, 
			tmp_invdat, tmp_invno, tmp_scno, 
			tmp_cusven,tmp_desven,tmp_prdven, 
			tmp_itmno, tmp_selprc, sum(tmp_qty), tmp_untcde, sum(tmp_qty) * tmp_selprc, 
			0,
			0, 
			sum(tmp_invamt) * (@discnt/100.0),
			0, --Net Amount
			tmp_itmcst * sum(tmp_qty), 0,
			0
		from #TEMP_RESULT_DTL
		group by tmp_pcno,tmp_cocde, 
			tmp_invdat, tmp_invno, tmp_scno, 
			tmp_cusven,tmp_desven,tmp_prdven, 
			tmp_itmno, tmp_selprc, tmp_untcde, tmp_itmcst, tmp_bomcst

		update #TEMP_RESULT_GROUP set tmp_netsamt = tmp_invamt - tmp_disamt
		

		-- Rounding Display

		update #TEMP_RESULT_GROUP set tmp_netsamt = round(tmp_netsamt, 2), tmp_itmcst = round(tmp_itmcst, 2)
		update #TEMP_RESULT_GROUP set tmp_netpft = tmp_netsamt - tmp_itmcst


		insert into #RESULT
		select tmp_pcno,tmp_cocde, tmp_invdat, tmp_invno, 
			tmp_scno,tmp_cusven, tmp_desven,tmp_prdven,
			tmp_itmno, tmp_selprc, tmp_qty, tmp_untcde, tmp_invamt, tmp_afamt,
			tmp_preamt, tmp_disamt, tmp_netsamt, tmp_itmcst, tmp_bomcst, tmp_netpft
		from #TEMP_RESULT_GROUP

		delete from #TEMP_RESULT_DTL
		delete from #TEMP_RESULT_GROUP
	end

	Fetch next from cur_Invoice into
	@cocde,
	@type,
	@docno
end
close cur_Invoice
deallocate cur_Invoice


if @RptType = 'DTL'
begin

	select 
	@PCNOFM,
	@PCNOTO,
	convert(nvarchar(20),@InvDatFm,101),
	convert(nvarchar(20),@InvDatTo,101),
	@InvNoFm,
	@InvNoTo,
	@SCNoFm,
	@SCNoTo,
	@CusVenFm,
	@CusVenTo,
	@DesVenFm,
	@DesVenTo,
	@PrdVenFm,
	@PrdVenTo,
	@ItmNoFm,
	@ItmNoTo,
	@CoCdeFm,
	@CoCdeTo,
	@InvStatus,
	@InvType,
	@RptType,
	case res_pcno when 'STANDARD' then 'STD' else res_pcno end,
	res_cocde,
	convert(nvarchar(20),res_invdat,101),
	res_invno,
	res_scno,
	res_cusven + ' - ' + isnull(cus.vbi_vensna,''),
	res_desven  + ' - ' + isnull(des.vbi_vensna,''),
	res_prdven  + ' - ' + isnull(prd.vbi_vensna,''),
	res_itmno,
	convert(varchar(20),res_selprc),
	res_qty,
	res_untcde,
	res_invamt,
	res_preamt,
	res_disamt,
	res_netsamt,
	res_afamt,	
	res_itmcst,
	res_bomcst,
	res_netpft, 
	@yco_conam
	
	from #RESULT 
	left join vnbasinf cus (nolock) on res_cusven = cus.vbi_venno
	left join vnbasinf des (nolock) on res_desven = des.vbi_venno
	left join vnbasinf prd (nolock) on res_prdven = prd.vbi_venno
	where
	       (@OptPcNo = 'N' or (res_pcno between @PCNOFM and @PCNOTO))
	and (@OptCusVen = 'N' or (res_cusven between @CusVenFm and @CusVenTo))
	and (@OptDesVen = 'N' or (res_desven between @DesVenFm and @DesVenTo))
	and (@OptPrdVen = 'N' or (res_prdven between @PrdVenFm and @PrdVenTo))
	and (@OptItmNo = 'N' or (res_itmno between @ItmNoFm and @ItmNoTo))
	order by res_cusven,res_prdven,res_desven,res_invdat, res_invno,res_scno
end
else
begin
		select 
	@PCNOFM,
	@PCNOTO,
	convert(nvarchar(20),@InvDatFm,101),
	convert(nvarchar(20),@InvDatTo,101),
	@InvNoFm,
	@InvNoTo,
	@SCNoFm,
	@SCNoTo,
	@CusVenFm,
	@CusVenTo,
	@DesVenFm,
	@DesVenTo,
	@PrdVenFm,
	@PrdVenTo,
	@ItmNoFm,
	@ItmNoTo,
	@CoCdeFm,
	@CoCdeTo,
	@InvStatus,
	@InvType,
	@RptType,
	case res_pcno when 'STANDARD' then 'STD' else res_pcno end,
	res_cocde,
	res_cusven + ' - ' + isnull(cus.vbi_vensna,''),
	res_desven  + ' - ' + isnull(des.vbi_vensna,''),
	res_prdven  + ' - ' + isnull(prd.vbi_vensna,''),
	sum(isnull(res_invamt,0)),
	sum(isnull(res_preamt,0)),
	sum(isnull(res_disamt,0)),
	sum(isnull(res_afamt,0)),	
	sum(isnull(res_netsamt,0)),
	sum(isnull(res_itmcst,0)),
	sum(isnull(res_bomcst,0)),
	sum(isnull(res_netpft,0)),
	@yco_conam
	
	from #RESULT 
	left join vnbasinf cus (nolock) on res_cusven = cus.vbi_venno
	left join vnbasinf des (nolock) on res_desven = des.vbi_venno
	left join vnbasinf prd (nolock) on res_prdven = prd.vbi_venno

	where
	       (@OptPcNo = 'N' or (res_pcno between @PCNOFM and @PCNOTO))
	and (@OptCusVen = 'N' or (res_cusven between @CusVenFm and @CusVenTo))
	and (@OptDesVen = 'N' or (res_desven between @DesVenFm and @DesVenTo))
	and (@OptPrdVen = 'N' or (res_prdven between @PrdVenFm and @PrdVenTo))
	and (@OptItmNo = 'N' or (res_itmno between @ItmNoFm and @ItmNoTo))
	group by 	case res_pcno when 'STANDARD' then 'STD' else res_pcno end,
		res_cocde,
		res_cusven + ' - ' + isnull(cus.vbi_vensna,''),
		res_desven  + ' - ' + isnull(des.vbi_vensna,''),
		res_prdven  + ' - ' + isnull(prd.vbi_vensna,'')
	order by	res_cusven + ' - ' + isnull(cus.vbi_vensna,''),
	res_desven  + ' - ' + isnull(des.vbi_vensna,''),
	res_prdven  + ' - ' + isnull(prd.vbi_vensna,'')

end

END



GO
GRANT EXECUTE ON [dbo].[sp_list_PCR00050] TO [ERPUSER] AS [dbo]
GO
