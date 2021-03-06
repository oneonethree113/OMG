/****** Object:  StoredProcedure [dbo].[sp_list_PCR00001]    Script Date: 09/29/2017 15:29:09 ******/
DROP PROCEDURE [dbo].[sp_list_PCR00001]
GO
/****** Object:  StoredProcedure [dbo].[sp_list_PCR00001]    Script Date: 09/29/2017 15:29:09 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO









/****** Object:  Stored Procedure dbo.sp_list_PCR00001    Script Date: 11/18/2003 9:32:54 AM ******/


--sp_list_PCR00001 '', 'PC01', 'PC01', '09/16/2003', '09/16/2003', '', '', '', '', 'A', 'C', '', '', '', '', '02A', '02B', '', '', 'mis','N'
--sp_list_PCR00001 '',   '', '',   '2003-05-24', '2003-05-24',   'I0300464', 'I0300464',   '', '',   '', '',   '', '',   '', '',   '', '',   '', '', 'mis','N'
--sp_list_PCR00001 '',   '', '',   '10/02/2003 00:00:00.00', '10/02/2003 23:59:59',   'UA0301209', 'UA0301209',   '', '',   '', '',   '', '',   '', '',   '', '',   '', '', 'mis','A','A','1'
CREATE      procedure [dbo].[sp_list_PCR00001]
@defCocde nvarchar(6),
@PCNoFm	nvarchar(20),
@PCNoTo	nvarchar(20),
@InvDatFm	datetime,
@InvDatTo	datetime,
@InvNoFm	nvarchar(20),
@InvNoTo	nvarchar(20),
@SCNoFm	nvarchar(20),
@SCNoTo	nvarchar(20),
@DgnVenFm	nvarchar(20),
@DgnVenTo	nvarchar(20),
--2003/11/29----
@PcFtyFm	nvarchar(20),
@PcFtyTo		nvarchar(20),
--@OrgVenFm	nvarchar(20),
--@OrgVenTo	nvarchar(20),
-----------------------
@PrdVenFm	nvarchar(20),
@PrdVenTo	nvarchar(20),
@ItmNoFm	nvarchar(20),
@ItmNoTo	nvarchar(20),
@AgyCoFm	nvarchar(20),
@AgyCoTo	nvarchar(20),
@UserID	nvarchar(30),
@InvStatus	nvarchar(1),
@InvType		nvarchar(2),
@RptType		nvarchar(1)   
/**************************************************************
*    @RptType  =	1 : Profit Center Revenue Report (Details)
*		2:  Profit Center Revenue Report (Summary)
*		3:  Profit Center Costing Report (Details)
*		4:  Profit Center Costing Report (Summary)
*		5:  Profit Center - Agency Revenue Report (Details)
*		6:  Profit Center - Agency Revenue Report (Summary)
**************************************************************/

AS

Begin

declare 
@OptInvDat nvarchar(1),
@OptPCNo nvarchar(1),
@OptInvNo nvarchar(1),
@OptSCNo nvarchar(1),
@OptDgnVen nvarchar(1),
--@OptOrgVen nvarchar(1),
@OptPcFty nvarchar(1),
@OptPrdVen nvarchar(1),
@OptItmNo nvarchar(1),
@OptAgyCo nvarchar(1)

if @InvDatFm = ''
   set @OptInvDat = 'N'
else
   set @OptInvDat = 'Y'

if @PCNoFm = ''
   set @OptPCNo = 'N'
else
   set @OptPCNo = 'Y'

if @InvNoFm = ''
   set @OptInvNo = 'N'
else
   set @OptInvNo = 'Y'

if @SCNoFm = ''
   set @OptSCNo = 'N'
else
   set @OptSCNo = 'Y'

if @DgnVenFm = ''
   set @OptDgnVen = 'N'
else
   set @OptDgnVen = 'Y'

/*if @OrgVenFm = ''
   set @OptOrgVen = 'N'
else
   set @OptOrgVen = 'Y'
*/
-- 2003/11/29-----------------
if @PcFtyFm = '' 
   set @OptPcFty = 'N'
else
   set @OptPcFty = 'Y'
-----------------------------------

if @PrdVenFm = ''
   set @OptPrdVen = 'N'
else
   set @OptPrdVen = 'Y'

if @ItmNoFm = ''
   set @OptItmNo = 'N'
else
   set @OptItmNo = 'Y'

if @AgyCoFm = ''
   set @OptAgyCo = 'N'
else
   set @OptAgyCo = 'Y'


if @InvStatus = ''
   set @InvStatus = 'A'

if @InvType=''
   set @InvType = 'A'

declare @curcde nvarchar(10)
declare @buyrat numeric(16,11)
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
   tmp_invdat	datetime,
   tmp_invno	nvarchar(20),
----------------------------------------------
   tmp_slnonb	datetime,
   tmp_jobno	nvarchar(40),
   tmp_purord	nvarchar(40),
-----------------------------------------------
   tmp_scno	nvarchar(20),
--2003/11/11
   tmp_cusno	nvarchar(12),
--
   tmp_dgnven	nvarchar(6),
--   tmp_orgven	nvarchar(6),
   tmp_prdven	nvarchar(6),
   tmp_subcde	nvarchar(10),
   tmp_itmno	nvarchar(20),
   tmp_catlvl4	nvarchar(20),
   tmp_selprc	numeric(13,4),
   tmp_qty	int,
   tmp_untcde	nvarchar(6),
   tmp_invamt	numeric(13,4),
   tmp_itmcst	numeric(13,4),
   tmp_bomcst	numeric(13,4),
   tmp_agyco	nvarchar(6),
--2003/11/29----
   tmp_pcfty	nvarchar(20)
-------------------  
)

create table #TEMP_RESULT_GROUP (
   tmp_pcno	nvarchar(20),
   tmp_invdat	datetime,
   tmp_invno	nvarchar(20),
----------------------------------------------
   tmp_slnonb	datetime,
   tmp_jobno	nvarchar(40),
   tmp_purord	nvarchar(40),
-----------------------------------------------
   tmp_scno	nvarchar(20),
--2003/11/11
   tmp_cusno	nvarchar(12),
--
   tmp_dgnven	nvarchar(6),
--   tmp_orgven	nvarchar(6),
   tmp_prdven	nvarchar(6),
   tmp_subcde	nvarchar(10),
   tmp_itmno	nvarchar(20),
   tmp_catlvl4	nvarchar(20),
   tmp_selprc	numeric(13,4),
   tmp_qty	int,
   tmp_untcde	nvarchar(6),
   tmp_invamt	numeric(13,4),
   tmp_afamt	numeric(13,4),
   tmp_preamt	numeric(13,4),
   tmp_disamt	numeric(13,4),
   tmp_netsamt	numeric(13,4),
   tmp_itmcst	numeric(13,4),
   tmp_ttlitmcst	numeric(13,4),
   tmp_bomcst	numeric(13,4),
   tmp_agyco	nvarchar(6),
   tmp_agycrg	numeric(13,4),
   tmp_devcrg	numeric(13,4),
   tmp_netpft	numeric(13,4),

   tmp_agyfml	nvarchar(6),
   tmp_devfml	nvarchar(6),
--2003/11/29 ----------------------------
   tmp_pcfty	nvarchar(20),
   tmp_rbtfml	nvarchar(20),
   tmp_rbtamt	numeric(13,4)
--------------------------------------------
 )

create table #RESULT (
   res_pcno	nvarchar(20),
   res_invdat	datetime,
   res_invno	nvarchar(20),
----------------------------------------------
   res_slnonb	datetime,
   res_jobno	nvarchar(40),
   res_purord	nvarchar(40),
-----------------------------------------------
   res_scno	nvarchar(20),
   res_dgnven	nvarchar(6),
--   res_orgven	nvarchar(6),
   res_prdven	nvarchar(6),
   res_subcde	nvarchar(10),
   res_itmno	nvarchar(20),
   res_catlvl4	nvarchar(20),
   res_selprc	numeric(13,4),
   res_qty	int,
   res_untcde	nvarchar(6),
   res_gsamt	numeric(13,4),

   res_preamt	numeric(13,4),
   res_disamt	numeric(13,4),
   res_netsamt	numeric(13,4),
   res_itmcst	numeric(13,4),
   res_ttlitmcst	numeric(13,4),
   res_bomcst	numeric(13,4),
   res_agyco	nvarchar(6),
   res_agycrg	numeric(13,4),
   res_devcrg	numeric(13,4),
   res_netpft	numeric(13,4),
--2003/11/29------------
   res_pcfty		nvarchar(20),
   res_rbtamt	numeric(13,4)
---------------------------
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
where	hiv_invdat >= '2002-09-01' 
	and soh_credat > = '2003-10-01'
--	and hiv_invsts <> 'C' and (hih_shpsts = 'OPE' or hih_shpsts = 'REL')
	and hiv_invsts <> 'C' 
	and  ((@InvStatus='A' ) or (@InvStatus='R' and hih_shpsts='REL'))
--	and (hih_shpsts = 'OPE' or hih_shpsts = 'REL')
--
	and (@OptInvDat = 'N' or (hiv_invdat between @InvDatFm and @InvDatTo))
	and (@OptInvNo = 'N' or (hiv_invno between @InvNoFm and @InvNoTo))
	and (@InvType in ('A' ,'SH'))
Union
Select 	distinct sih_cocde, 'SA', sih_invno--, sih_issdat
From	SAINVHDR (nolock) 
	left join SAINVDTL (nolock) on sih_cocde = sid_cocde and sih_invno = sid_invno
	left join CUPRCINF (nolock) on sih_cus1no = cpi_cusno
Where	sih_invno <> '' 
	and sih_issdat >= '2002-04-01' 
	and sih_credat >= '2003-10-01'
--	and  (sih_invsts = 'REL' or sih_invsts = 'CLO')
	and ((@InvStatus='A' and (sih_invsts = 'REL' or sih_invsts = 'CLO')) or (@InvStatus='R' and sih_invsts='REL'))
--
	and (@OptInvDat = 'N' or (sih_issdat between @InvDatFm and @InvDatTo))
	and (@OptInvNo = 'N' or (sih_invno between @InvNoFm and @InvNoTo))
	and (@InvType in ('A','SA'))

order by	2, 1, 3

Open cur_Invoice
Fetch next from cur_Invoice into
@cocde,
@type,
@docno

While @@fetch_status = 0
Begin
	--select @cocde, @type, @docno

	If @type = 'SH'
	begin
		---------------------------------------------------------------------------------------------------
		select 	@ttlamt = isnull(hiv_ttlamt, 0),
			@invamt = isnull(hiv_invamt, 0), 
			@afamt = isnull(hiv_afamt, 0),
			@curcde = hiv_untamt, 
			@buyrat = ysi_buyrat 
		from SHINVHDR, SYSETINF
		where hiv_cocde = @cocde and hiv_invno = @docno and ysi_cde = hiv_untamt and ysi_typ = '06'

		select @discntamt = isnull(sum(hdp_amt), 0) from SHDISPRM where hdp_cocde = @cocde and hdp_invno = @docno and hdp_type = 'D'

		select @premamt = isnull(sum(hdp_amt), 0) from SHDISPRM where hdp_cocde = @cocde and hdp_invno = @docno and hdp_type = 'P'

		if @curcde = 'HKD'
		begin
			set @ttlamt = @ttlamt * @buyrat
			set @invamt = @invamt * @buyrat
			set @afamt = @afamt * @buyrat
			set @discntamt = @discntamt * @buyrat
			set @premamt = @premamt * @buyrat
		end		



		-- Get SHIPGDTL into #TEMP_RESULT_DTL
		insert into #TEMP_RESULT_DTL
		select 	isnull(pdv.pdv_pcno, 'STANDARD'), 
			hiv.hiv_invdat, 
			hiv.hiv_invno,
			------------------------
			hih.hih_slnonb,
			hid.hid_jobno,
			hid.hid_purord,
			------------------------
			hid.hid_ordno,
			hih.hih_cus1no,
			isnull(ibi.ibi_venno, ''),
			/*case ibi.ibi_orgdvenno when '' then isnull(ibi.ibi_venno, '')
					       else isnull(ibi.ibi_orgdvenno, '') end,*/
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
			isnull(sod.sod_subcde, ''),
			hid.hid_itmno,
			isnull(ibi.ibi_catlvl4, ''),
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
			case poh.poh_curcde when 'HKD' then (isnull(pod.pod_ftyprc,0)*(1.00 - isnull(poh.poh_discnt,0)/100.00)) * curpo.ysi_buyrat
						else (isnull(pod.pod_ftyprc,0)*(1.00 - isnull(poh.poh_discnt,0)/100.00)) end,
			case pbh.pbh_curcde when 'HKD' then (isnull(pbd.pbd_ftyprc,0)*(1.00 - isnull(pbh.pbh_disprc,0)/100.00)) * curpobom.ysi_buyrat
						else (isnull(pbd.pbd_ftyprc,0)*(1.00 - isnull(pbh.pbh_disprc,0)/100.00)) end,
			
			hih.hih_cocde,
			--2003/11/29--------
			isnull(yli.yli_pcfty,'')
			------------------------
		from
			SHIPGHDR hih (nolock) 
			left join SHIPGDTL hid (nolock) on hid.hid_cocde = hih.hih_cocde and hid.hid_shpno = hih.hih_shpno
			left join SHINVHDR hiv (nolock) on hiv.hiv_cocde = hih.hih_cocde and hid.hid_shpno = hiv.hiv_shpno and hid.hid_invno = hiv.hiv_invno

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
		
			left join IMBASINF ibi (nolock) on ((hid.hid_itmno = ibi.ibi_itmno or hid.hid_itmno = ibi_alsitmno) and hid.hid_itmno not in ('031328-00132') and ibi_itmsts <> 'CLO') or
				  ((hid.hid_cocde = ibi.ibi_cocde) and ((hid.hid_itmno = ibi.ibi_itmno or hid.hid_itmno = ibi_alsitmno) and hid.hid_itmno in ('031328-00132')) and ibi_itmsts <> 'CLO')
		
--			left join IMVENINF ivi (nolock) on ivi.ivi_itmno = ibi.ibi_itmno and ivi.ivi_def = 'Y'
		
			--2003/11/29----
			left join SYLNEINF yli (nolock) on yli.yli_lnecde = ibi.ibi_lnecde
			left join VNBASINF vbi (nolock) on vbi.vbi_venno = ibi.ibi_venno	-- get the vendor type of design vendor
			--------------------
			left join SYSETINF cursel (nolock) on cursel.ysi_cde = hid.hid_untsel and cursel.ysi_typ = '06'

			left join SYSETINF curpo (nolock) on curpo.ysi_cde = poh.poh_curcde and curpo.ysi_typ = '06'

			left join SYSETINF curpobom (nolock) on curpobom.ysi_cde = pbh.pbh_curcde and curpobom.ysi_typ = '06'

			left join PCMDV pdv (nolock) on pdv.pdv_vencde = ibi.ibi_venno
		where 
			hih.hih_cocde = @cocde and
			hih.hih_shpsts in ('OPE','REL') and
			hiv.hiv_invsts <> 'C' and
			hiv.hiv_invno = @docno and
			hiv.hiv_invamt <> 0
			and ibi.ibi_venno not in ('0005','0006','0007','0008','0009')


		--*************************************************************************
		--# set tmp_pcno to "STANDARD" if a Product Line belongs to a PC Factory
		--# it will be regained after apply the correcponding formula
		update #TEMP_RESULT_DTL
		set tmp_pcno = 'STANDARD'
		where tmp_pcfty<>''
		--**************************************************************************


		update #TEMP_RESULT_DTL 
		set tmp_pcno = pdv_pcno
		from #TEMP_RESULT_DTL , PCMDV (nolock)
		where tmp_pcfty <> '' 
		and tmp_pcfty =  pdv_vencde


		-- Group #TEMP_RESULT_DTL into #TEMP_RESULT_GROUP
		insert into #TEMP_RESULT_GROUP
--2003/11/11	select 	tmp_pcno, tmp_invdat, tmp_invno, tmp_scno,tmp_dgnven, 
		select 	tmp_pcno, tmp_invdat, tmp_invno,tmp_slnonb,tmp_jobno,tmp_purord, tmp_scno,tmp_cusno,tmp_dgnven, 
		 	--tmp_orgven, 
			tmp_prdven, tmp_subcde, tmp_itmno, tmp_catlvl4, 
			tmp_selprc,
			 sum(tmp_qty), tmp_untcde, sum(tmp_invamt), 
			@afamt*(sum(tmp_invamt)/@invamt),
			@premamt*(sum(tmp_invamt)/@invamt), 
			@discntamt*(sum(tmp_invamt)/@invamt),
			0, --Net Amount
			tmp_itmcst,tmp_itmcst * sum(tmp_qty), tmp_bomcst * sum(tmp_qty),
			tmp_agyco,
			0,0,0, '', '',tmp_pcfty,'',0
		from #TEMP_RESULT_DTL
--2003/11/11	group by tmp_pcno, tmp_invdat, tmp_invno, tmp_scno,tmp_dgnven, 
		group by   tmp_pcno, tmp_invdat, tmp_invno, tmp_slnonb,tmp_jobno,tmp_purord,tmp_scno,tmp_cusno,tmp_dgnven, 
		 	--tmp_orgven, 
			tmp_prdven, tmp_subcde, tmp_itmno, tmp_catlvl4, 
			tmp_selprc, tmp_untcde, tmp_itmcst, tmp_bomcst, tmp_agyco,tmp_pcfty

--select * from #TEMP_RESULT_GROUP
		-- Calculate rounding difference

		select 	@ttlinvamt = sum(tmp_invamt),
			@ttlafamt = sum(tmp_afamt),
			@ttlpremamt = sum(tmp_preamt), 
			@ttldiscntamt = sum(tmp_disamt) 
		from #TEMP_RESULT_GROUP


		set @invamtdiff = @invamt - @ttlinvamt
		set @afamtdiff = @afamt - @ttlafamt
		set @premamtdiff = @premamt - @ttlpremamt
		set @discntamtdiff = @discntamt - @ttldiscntamt


		select 
		top 1 
		@adjpcno = tmp_pcno, @adjinvdat = tmp_invdat, @adjinvno = tmp_invno, @adjscno = tmp_scno
		from #TEMP_RESULT_GROUP order by tmp_pcno desc, tmp_invdat desc, tmp_invno desc, tmp_scno desc

		
		-- Adjustment for the rounding difference
		update #TEMP_RESULT_GROUP set 	tmp_invamt = tmp_invamt + @invamtdiff,
						tmp_afamt = tmp_afamt + @afamtdiff,
						tmp_preamt = tmp_preamt + @premamtdiff,
						tmp_disamt = tmp_disamt + @discntamtdiff
		where tmp_pcno = @adjpcno and tmp_invdat = @adjinvdat and tmp_invno = @adjinvno and tmp_scno = @adjscno



		-- Fill in Agency Charge and Dev Charge Formula
		update #TEMP_RESULT_GROUP
		set tmp_agyfml = pac_hdcfmlopt
		from #TEMP_RESULT_GROUP, PCMAGYCRG (nolock)
		where tmp_pcno = pac_pcno and tmp_agyco = pac_cocde and tmp_cusno = pac_cusno
		
		

		update #TEMP_RESULT_GROUP
		set tmp_agyfml = pac_hdcfmlopt
		from #TEMP_RESULT_GROUP, PCMAGYCRG (nolock)
		where tmp_pcno = pac_pcno and tmp_agyco = pac_cocde and pac_cusno = 'STANDARD' and tmp_agyfml = ''


		update #TEMP_RESULT_GROUP
		set tmp_agyfml = pac_hdcfmlopt
		from #TEMP_RESULT_GROUP, PCMAGYCRG (nolock)
		where tmp_pcno = pac_pcno and pac_cocde = 'STANDARD' and pac_cusno = 'STANDARD' and tmp_agyfml = ''




		-- Calculate Agency Charge 
		update #TEMP_RESULT_GROUP 
		set tmp_agycrg = case len(yfi_fml) when 2 then (tmp_invamt + tmp_afamt)
						when 5 then 
							case left(yfi_fml, 1) 	when '*' then (tmp_invamt + tmp_afamt) * (right(yfi_fml, 4))
										when '/' then (tmp_invamt + tmp_afamt) / (right(yfi_fml,4)) 
										end
						when 10 then
							case left(yfi_fml, 1)	when '*' then
											case substring(yfi_fml, 6, 1)	when '*' then (tmp_invamt + tmp_afamt) * (substring(yfi_fml,2,4)) * (substring(yfi_fml,7,4))
															when '/' then (tmp_invamt + tmp_afamt) * (substring(yfi_fml,2,4)) / (substring(yfi_fml,7,4))
															end
										when '/' then
											case substring(yfi_fml, 6, 1)	when '*' then (tmp_invamt + tmp_afamt) / (substring(yfi_fml,2,4)) * (substring(yfi_fml,7,4))
															when '/' then (tmp_invamt + tmp_afamt) / (substring(yfi_fml,2,4)) / (substring(yfi_fml,7,4))
															end
										end
						end
		from #TEMP_RESULT_GROUP, SYFMLINF (nolock)
		where tmp_agyfml = yfi_fmlopt



		update #TEMP_RESULT_GROUP
		set tmp_devfml = pdc_decfmlopt
		from #TEMP_RESULT_GROUP, PCMDEVCRG (nolock)
		where tmp_pcno = pdc_pcno and tmp_dgnven = pdc_facde and tmp_cusno = pdc_cusno and  tmp_pcfty<> tmp_prdven

		update #TEMP_RESULT_GROUP
		set tmp_devfml = pdc_decfmlopt
		from #TEMP_RESULT_GROUP, PCMDEVCRG (nolock)
		where tmp_pcno = pdc_pcno and tmp_dgnven = pdc_facde and pdc_cusno = 'STANDARD' and tmp_devfml = '' and  tmp_pcfty<> tmp_prdven

		update #TEMP_RESULT_GROUP
		set tmp_devfml = pdc_decfmlopt
		from #TEMP_RESULT_GROUP, PCMDEVCRG (nolock)
		where tmp_pcno = pdc_pcno and pdc_facde = 'STANDARD' and pdc_cusno = 'STANDARD' and tmp_devfml = '' and  tmp_pcfty<> tmp_prdven



		update #TEMP_RESULT_GROUP 
		set 
		tmp_devcrg = case len(yfi_fml) 	when 2 then (tmp_invamt + tmp_afamt)
						when 5 then 
							case left(yfi_fml, 1) 	when '*' then (tmp_invamt + tmp_afamt) * (right(yfi_fml, 4))
										when '/' then (tmp_invamt + tmp_afamt) / (right(yfi_fml,4)) 
										end
						when 10 then
							case left(yfi_fml, 1)	when '*' then
											case substring(yfi_fml, 6, 1)	when '*' then (tmp_invamt + tmp_afamt) * (substring(yfi_fml,2,4)) * (substring(yfi_fml,7,4))
															when '/' then (tmp_invamt + tmp_afamt) * (substring(yfi_fml,2,4)) / (substring(yfi_fml,7,4))
															end
										when '/' then
											case substring(yfi_fml, 6, 1)	when '*' then (tmp_invamt + tmp_afamt) / (substring(yfi_fml,2,4)) * (substring(yfi_fml,7,4))
															when '/' then (tmp_invamt + tmp_afamt) / (substring(yfi_fml,2,4)) / (substring(yfi_fml,7,4))
															end
										end
						end
		from #TEMP_RESULT_GROUP, SYFMLINF (nolock)
		where tmp_devfml = yfi_fmlopt

		--********2003/12/01****** Rebate Amount *****************
		update #TEMP_RESULT_GROUP
		set tmp_rbtfml = cmr_rbtfmlopt
		from #TEMP_RESULT_GROUP,CUMRBT
		where tmp_cusno = cmr_cusno


		update #TEMP_RESULT_GROUP 
		set tmp_rbtamt = case len(yfi_fml) 	when 2 then (tmp_invamt + tmp_afamt)
						when 5 then 
							case left(yfi_fml, 1) 	when '*' then (tmp_invamt + tmp_afamt) * (right(yfi_fml, 4))
										when '/' then (tmp_invamt + tmp_afamt) / (right(yfi_fml,4)) 
										end
						when 10 then
							case left(yfi_fml, 1)	when '*' then
											case substring(yfi_fml, 6, 1)	when '*' then (tmp_invamt + tmp_afamt) * (substring(yfi_fml,2,4)) * (substring(yfi_fml,7,4))
															when '/' then (tmp_invamt + tmp_afamt) * (substring(yfi_fml,2,4)) / (substring(yfi_fml,7,4))
															end
										when '/' then
											case substring(yfi_fml, 6, 1)	when '*' then (tmp_invamt + tmp_afamt) / (substring(yfi_fml,2,4)) * (substring(yfi_fml,7,4))
															when '/' then (tmp_invamt + tmp_afamt) / (substring(yfi_fml,2,4)) / (substring(yfi_fml,7,4))
															end
										end
						end
		from #TEMP_RESULT_GROUP, SYFMLINF (nolock)
		where tmp_rbtfml = yfi_fmlopt
		
		--*******************************************************
		




		update #TEMP_RESULT_GROUP set tmp_netsamt = tmp_invamt + tmp_afamt + tmp_preamt - tmp_disamt - tmp_rbtamt

		-- Rounding Display


		


		update #TEMP_RESULT_GROUP set tmp_netsamt = round(tmp_netsamt, 2), tmp_ttlitmcst = round(tmp_ttlitmcst, 2), tmp_bomcst = round(tmp_bomcst, 2), tmp_agycrg = round(tmp_agycrg, 2), tmp_devcrg = round(tmp_devcrg, 2)

if @RptType='1' or @RptType='2'
begin
		update #TEMP_RESULT_GROUP set tmp_netpft = tmp_netsamt - tmp_ttlitmcst - tmp_bomcst - tmp_agycrg - tmp_devcrg
end
else if @RptType='5' or @RptType='6'
begin
		update #TEMP_RESULT_GROUP set tmp_netpft = case tmp_pcno when 'STANDARD' then  tmp_netsamt - tmp_ttlitmcst - tmp_bomcst  else tmp_agycrg end
end 

--select * from #TEMP_RESULT_GROUP


		insert into #RESULT
		select tmp_pcno, tmp_invdat, tmp_invno, tmp_slnonb,tmp_jobno,tmp_purord,tmp_scno, tmp_dgnven,
			--tmp_orgven, 
			tmp_prdven, tmp_subcde, tmp_itmno, tmp_catlvl4,
			tmp_selprc, tmp_qty, tmp_untcde, tmp_invamt + tmp_afamt,
			tmp_preamt, tmp_disamt, tmp_netsamt, tmp_itmcst, tmp_ttlitmcst, tmp_bomcst,
			tmp_agyco, tmp_agycrg, tmp_devcrg, tmp_netpft,
			--2003/11/29-----------
			tmp_pcfty,tmp_rbtamt
			--------------------------
		from #TEMP_RESULT_GROUP

		
		delete from #TEMP_RESULT_DTL
		delete from #TEMP_RESULT_GROUP
	---------------------------------------------------------------------------------------------------
	end
	else if @type = 'SA'
	begin
	---------------------------------------------------------------------------------------------------

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

		insert into #TEMP_RESULT_DTL
		select 	isnull(pdv.pdv_pcno, 'STANDARD'), -- Profit Center
			sih.sih_issdat, 
			sih.sih_invno, 
			null, --sailing date
			'', --jobno
			'', --purord
			sid.sid_reqno, -- Req Number
			sih.sih_cus1no,
			isnull(ibi.ibi_venno, ''),-- Design Vendor
			/*case ibi_orgdvenno when '' then ibi_venno
					   else ibi_orgdvenno end,-- Original Design Vendor*/
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
			isnull(sid.sid_subcde, ''),-- SubCode
			sid.sid_itmno,
			isnull(ibi.ibi_catlvl4, ''), -- Category Level 4
			case sid.sid_curcde when 'HKD' then isnull(sid.sid_selprc, 0) * cur.ysi_buyrat
							else isnull(sid.sid_selprc, 0) end, -- Selling Price
			sid.sid_chgqty, -- Qty
			sid.sid_untcde, -- UM
			case sid.sid_curcde when 'HKD' then isnull(sid.sid_ttlamt, 0) * cur.ysi_buyrat
							else isnull(sid.sid_ttlamt, 0) end, -- inv Amount
			case sid.sid_fcurcde when 'HKD' then isnull(sid.sid_ftyprc, 0) * fcur.ysi_buyrat
							else isnull(sid.sid_ftyprc, 0) end,
			0, -- BOM cost
			sih_cocde,
			--2003/12/01--
			isnull(yli.yli_pcfty,'')
			------------------

		from SAINVHDR sih (nolock)
		left join SAINVDTL sid (nolock) on sih.sih_cocde = sid.sid_cocde and sih.sih_invno = sid.sid_invno

		left join IMBASINF ibi (nolock) on ((sid.sid_itmno = ibi.ibi_itmno or sid.sid_itmno = ibi_alsitmno) and sid.sid_itmno not in ('031328-00132') and ibi_itmsts <> 'CLO') or
			  ((sid.sid_cocde = ibi.ibi_cocde) and ((sid.sid_itmno = ibi.ibi_itmno or sid.sid_itmno = ibi_alsitmno) and sid.sid_itmno in ('031328-00132')) and ibi_itmsts <> 'CLO')
	
		left join IMVENINF ivi (nolock) on ivi_itmno = ibi.ibi_itmno and ivi_def = 'Y'

		--2003/12/01----
		left join SYLNEINF yli (nolock) on yli.yli_lnecde = ibi.ibi_lnecde
		left join VNBASINF vbi (nolock) on vbi.vbi_venno = ibi.ibi_venno
		--------------------


		left join SYSETINF cur (nolock) on cur.ysi_cde = sid.sid_curcde and cur.ysi_typ = '06'

		left join SYSETINF fcur (nolock) on fcur.ysi_cde = sid.sid_fcurcde and fcur.ysi_typ = '06'

		left join PCMDV pdv (nolock) on pdv.pdv_vencde = ibi.ibi_venno
		where sih_cocde = @cocde and sih_invno = @docno
		and	sih_netamt > 0
		and ibi.ibi_venno not in ('0005','0006','0007','0008','0009')

		--*************************************************************************
		--# set tmp_pcno to "STANDARD" if a Product Line belongs to a PC Factory
		--# it will be regained after apply the correcponding formula
		update #TEMP_RESULT_DTL
		set tmp_pcno = 'STANDARD'
		where tmp_pcfty<>''
		--**************************************************************************
		update #TEMP_RESULT_DTL 
		set tmp_pcno = pdv_pcno
		from #TEMP_RESULT_DTL , PCMDV (nolock)
		where tmp_pcfty <> '' 
		and tmp_pcfty =  pdv_vencde


		insert into #TEMP_RESULT_GROUP
		select 	tmp_pcno, tmp_invdat, tmp_invno, tmp_slnonb,tmp_jobno,tmp_purord,
			tmp_scno,tmp_cusno,tmp_dgnven, 
		 	--tmp_orgven, 
			tmp_prdven, tmp_subcde, tmp_itmno, tmp_catlvl4, 
			tmp_selprc, sum(tmp_qty), tmp_untcde, sum(tmp_invamt), 
			0,
			0, 
			sum(tmp_invamt) * (@discnt/100.0),
			0, --Net Amount
			tmp_itmcst,tmp_itmcst * sum(tmp_qty), tmp_bomcst * sum(tmp_qty),
			tmp_agyco,
			0,0,0, '', '',tmp_pcfty,'',0
		from #TEMP_RESULT_DTL
		group by tmp_pcno, tmp_invdat, tmp_invno, tmp_slnonb,tmp_jobno,tmp_purord,tmp_scno, tmp_cusno,tmp_dgnven, 
		 	--tmp_orgven, 
			tmp_prdven, tmp_subcde, tmp_itmno, tmp_catlvl4, 
			tmp_selprc, tmp_untcde, tmp_itmcst, tmp_bomcst, tmp_agyco,tmp_pcfty
			
		select 	@ttlinvamt = sum(tmp_invamt),
			@ttldiscntamt = sum(tmp_disamt) from #TEMP_RESULT_GROUP

		set @invamtdiff = @ttlamt - @ttlinvamt
		set @discntamtdiff = (@ttlamt*(@discnt/100.0)) - @ttldiscntamt

		select 
		top 1 
		@adjpcno = tmp_pcno, @adjinvdat = tmp_invdat, @adjinvno = tmp_invno, @adjscno = tmp_scno
		 from #TEMP_RESULT_GROUP order by tmp_pcno desc, tmp_invdat desc, tmp_invno desc, tmp_scno desc
		
		update #TEMP_RESULT_GROUP set 	tmp_invamt = tmp_invamt + @invamtdiff,
						tmp_disamt = tmp_disamt + @discntamtdiff
		where tmp_pcno = @adjpcno and tmp_invdat = @adjinvdat and tmp_invno = @adjinvno and tmp_scno = @adjscno





		-- Fill in Agency Charge and Dev Charge Formula
		update #TEMP_RESULT_GROUP
		set tmp_agyfml = pac_hdcfmlopt
		from #TEMP_RESULT_GROUP, PCMAGYCRG (nolock)
		where tmp_pcno = pac_pcno and tmp_agyco = pac_cocde and tmp_cusno = pac_cusno

		update #TEMP_RESULT_GROUP
		set tmp_agyfml = pac_hdcfmlopt
		from #TEMP_RESULT_GROUP, PCMAGYCRG (nolock)
		where tmp_pcno = pac_pcno and tmp_agyco = pac_cocde and pac_cusno = 'STANDARD' and tmp_agyfml = ''

		update #TEMP_RESULT_GROUP
		set tmp_agyfml = pac_hdcfmlopt
		from #TEMP_RESULT_GROUP, PCMAGYCRG (nolock)
		where tmp_pcno = pac_pcno and pac_cocde = 'STANDARD' and pac_cusno = 'STANDARD' and tmp_agyfml = ''



		update #TEMP_RESULT_GROUP 
		set tmp_agycrg = case len(yfi_fml) when 2 then (tmp_invamt + tmp_afamt)
						when 5 then 
							case left(yfi_fml, 1) 	when '*' then (tmp_invamt + tmp_afamt) * (right(yfi_fml, 4))
										when '/' then (tmp_invamt + tmp_afamt) / (right(yfi_fml,4)) 
										end
						when 10 then
							case left(yfi_fml, 1)	when '*' then
											case substring(yfi_fml, 6, 1)	when '*' then (tmp_invamt + tmp_afamt) * (substring(yfi_fml,2,4)) * (substring(yfi_fml,7,4))
															when '/' then (tmp_invamt + tmp_afamt) * (substring(yfi_fml,2,4)) / (substring(yfi_fml,7,4))
															end
										when '/' then
											case substring(yfi_fml, 6, 1)	when '*' then (tmp_invamt + tmp_afamt) / (substring(yfi_fml,2,4)) * (substring(yfi_fml,7,4))
															when '/' then (tmp_invamt + tmp_afamt) / (substring(yfi_fml,2,4)) / (substring(yfi_fml,7,4))
															end
										end
						end
		from #TEMP_RESULT_GROUP, SYFMLINF (nolock)
		where tmp_agyfml = yfi_fmlopt

		update #TEMP_RESULT_GROUP
		set tmp_devfml = pdc_decfmlopt
		from #TEMP_RESULT_GROUP, PCMDEVCRG (nolock)
		where tmp_pcno = pdc_pcno and tmp_dgnven = pdc_facde and tmp_cusno = pdc_cusno and  tmp_pcfty<> tmp_prdven

		update #TEMP_RESULT_GROUP
		set tmp_devfml = pdc_decfmlopt
		from #TEMP_RESULT_GROUP, PCMDEVCRG (nolock)
		where tmp_pcno = pdc_pcno and tmp_dgnven = pdc_facde and pdc_cusno = 'STANDARD' and tmp_devfml = '' and  tmp_pcfty<> tmp_prdven

		update #TEMP_RESULT_GROUP
		set tmp_devfml = pdc_decfmlopt
		from #TEMP_RESULT_GROUP, PCMDEVCRG (nolock)
		where tmp_pcno = pdc_pcno and pdc_facde = 'STANDARD' and pdc_cusno = 'STANDARD' and tmp_devfml = '' and  tmp_pcfty<> tmp_prdven


		update #TEMP_RESULT_GROUP 
		set 
		tmp_devcrg = case len(yfi_fml) 	when 2 then (tmp_invamt + tmp_afamt)
						when 5 then 
							case left(yfi_fml, 1) 	when '*' then (tmp_invamt + tmp_afamt) * (right(yfi_fml, 4))
										when '/' then (tmp_invamt + tmp_afamt) / (right(yfi_fml,4)) 
										end
						when 10 then
							case left(yfi_fml, 1)	when '*' then
											case substring(yfi_fml, 6, 1)	when '*' then (tmp_invamt + tmp_afamt) * (substring(yfi_fml,2,4)) * (substring(yfi_fml,7,4))
															when '/' then (tmp_invamt + tmp_afamt) * (substring(yfi_fml,2,4)) / (substring(yfi_fml,7,4))
															end
										when '/' then
											case substring(yfi_fml, 6, 1)	when '*' then (tmp_invamt + tmp_afamt) / (substring(yfi_fml,2,4)) * (substring(yfi_fml,7,4))
															when '/' then (tmp_invamt + tmp_afamt) / (substring(yfi_fml,2,4)) / (substring(yfi_fml,7,4))
															end
										end
						end
		from #TEMP_RESULT_GROUP, SYFMLINF (nolock)
		where tmp_devfml = yfi_fmlopt
		
		--********2003/12/01****** Rebate Amount *****************
		update #TEMP_RESULT_GROUP
		set tmp_rbtfml = cmr_rbtfmlopt
		from #TEMP_RESULT_GROUP,CUMRBT
		where tmp_cusno = cmr_cusno


		update #TEMP_RESULT_GROUP 
		set tmp_rbtamt = case len(yfi_fml) 	when 2 then (tmp_invamt + tmp_afamt)
						when 5 then 
							case left(yfi_fml, 1) 	when '*' then (tmp_invamt + tmp_afamt) * (right(yfi_fml, 4))
										when '/' then (tmp_invamt + tmp_afamt) / (right(yfi_fml,4)) 
										end
						when 10 then
							case left(yfi_fml, 1)	when '*' then
											case substring(yfi_fml, 6, 1)	when '*' then (tmp_invamt + tmp_afamt) * (substring(yfi_fml,2,4)) * (substring(yfi_fml,7,4))
															when '/' then (tmp_invamt + tmp_afamt) * (substring(yfi_fml,2,4)) / (substring(yfi_fml,7,4))
															end
										when '/' then
											case substring(yfi_fml, 6, 1)	when '*' then (tmp_invamt + tmp_afamt) / (substring(yfi_fml,2,4)) * (substring(yfi_fml,7,4))
															when '/' then (tmp_invamt + tmp_afamt) / (substring(yfi_fml,2,4)) / (substring(yfi_fml,7,4))
															end
										end
						end
		from #TEMP_RESULT_GROUP, SYFMLINF (nolock)
		where tmp_rbtfml = yfi_fmlopt
		
		--*******************************************************


		
		update #TEMP_RESULT_GROUP set tmp_netsamt = tmp_invamt - tmp_disamt-tmp_rbtamt

		-- Rounding Display
		update #TEMP_RESULT_GROUP set tmp_netsamt = round(tmp_netsamt, 2), tmp_ttlitmcst = round(tmp_ttlitmcst, 2), tmp_bomcst = round(tmp_bomcst, 2), tmp_agycrg = round(tmp_agycrg, 2), tmp_devcrg = round(tmp_devcrg, 2)

--select * from #TEMP_RESULT_GROUP

if @RptType='1' or @RptType='2'
begin
		update #TEMP_RESULT_GROUP set tmp_netpft = tmp_netsamt - tmp_ttlitmcst - tmp_bomcst - tmp_agycrg - tmp_devcrg
end		
else if @RptType='5' or @RptType='6'
begin
		update #TEMP_RESULT_GROUP set tmp_netpft = case tmp_pcno when 'STANDARD' then  tmp_netsamt - tmp_ttlitmcst - tmp_bomcst  else tmp_agycrg end
end 

--select * from #TEMP_RESULT_GROUP

		insert into #RESULT
		select tmp_pcno, tmp_invdat, tmp_invno, tmp_slnonb,tmp_jobno,tmp_purord,tmp_scno, tmp_dgnven,
			--tmp_orgven, 
			tmp_prdven, tmp_subcde, tmp_itmno, tmp_catlvl4,
			tmp_selprc, tmp_qty, tmp_untcde, tmp_invamt + tmp_afamt,
			tmp_preamt, tmp_disamt, tmp_netsamt, tmp_itmcst,tmp_ttlitmcst, tmp_bomcst,
			tmp_agyco, tmp_agycrg, tmp_devcrg, tmp_netpft,
			--2003/12/01-----------
			tmp_pcfty,tmp_rbtamt
			--------------------------

		from #TEMP_RESULT_GROUP

		delete from #TEMP_RESULT_DTL
		delete from #TEMP_RESULT_GROUP
	---------------------------------------------------------------------------------------------------
	end

	Fetch next from cur_Invoice into
	@cocde,
	@type,
	@docno
end
close cur_Invoice
deallocate cur_Invoice


update #RESULT set res_pcno = 'STD' where res_pcno = 'STANDARD'

---------------------===========================


if @RptType='1' 
begin

select 
convert(nvarchar(20),@InvDatFm,101),
convert(nvarchar(20),@InvDatTo,101),
@PCNoFm,
@PCNoTo,
@InvNoFm,
@InvNoTo,
@SCNoFm,
@SCNoTo,
@DgnVenFm,
@DgnVenTo,
--@OrgVenFm,
--@OrgVenTo,
@PcFtyFm,
@PcFtyTo,
@PrdVenFm,
@PrdVenTo,
@ItmNoFm,
@ItmNoTo,
@AgyCoFm,
@AgyCoTo,
@InvStatus,
@InvType,
   res_pcno,  convert(nvarchar(18),res_invdat,101),   res_invno,   res_scno,   res_dgnven,   --res_orgven,  
   res_pcfty, res_prdven,
   res_subcde,   res_itmno,   res_catlvl4,   res_selprc,   res_qty,   res_untcde,   res_gsamt,
   res_preamt,   res_disamt,   res_netsamt,   res_ttlitmcst,   res_bomcst,
   res_agyco,   res_agycrg,   res_devcrg,   res_netpft
from #RESULT 
where
(@OptPCNo = 'N' or (res_pcno between @PCNoFm and @PCNoTo))
and (@OptSCNo = 'N' or (res_scno between @SCNoFm and @SCNoTo))
and (@OptDgnVen = 'N' or (res_dgnven between @DgnVenFm and @DgnVenTo))
--and (@OptOrgVen = 'N' or (res_orgven between @OrgVenFm and @OrgVenTo))
and (@OptPcFty='N' or (res_pcfty between @PcFtyFm and @PcFtyTo))
and (@OptPrdVen = 'N' or (res_prdven between @PrdVenFm and @PrdVenTo))
and (@OptItmNo = 'N' or (res_itmno between @ItmNoFm and @ItmNoTo))
and (@OptAgyCo = 'N' or (res_agyco between @AgyCoFm and @AgyCoTo))

order by res_pcno, res_invdat, res_invno, res_scno

end --RptType='1'
------------------------------------------------------
else if @RptType='2'
------------------------------------------------------
begin
select 
convert(nvarchar(20),@InvDatFm,101),
convert(nvarchar(20),@InvDatTo,101),
	@PCNoFm,
	@PCNoTo,
	@InvNoFm,
	@InvNoTo,
	@SCNoFm,
	@SCNoTo,
	@DgnVenFm,
	@DgnVenTo,
--	@OrgVenFm,
--	@OrgVenTo,
	@PcFtyFm,
	@PcFtyTo,
	@PrdVenFm,
	@PrdVenTo,
	@ItmNoFm,
	@ItmNoTo,
	@AgyCoFm,
	@AgyCoTo,
	@InvStatus,
	@InvType,
 res_pcno,
res_dgnven,
--res_orgven,
res_pcfty,
res_prdven,
sum(res_gsamt) as 'res_gsamt',
sum(res_preamt) as 'res_preamt',
sum(res_disamt) as 'res_disamt',
sum(res_netsamt) as 'res_netsamt',
sum(res_ttlitmcst) as 'res_itmcst',
sum(res_bomcst) as 'res_bomcst',
res_agyco,
sum(res_agycrg) as 'res_agycry',
sum(res_devcrg) as 'res_devcrg',
sum(res_netpft) as 'res_netpft'
from #RESULT
where
	(@OptPCNo = 'N' or (res_pcno between @PCNoFm and @PCNoTo))
	and (@OptSCNo = 'N' or (res_scno between @SCNoFm and @SCNoTo))
	and (@OptDgnVen = 'N' or (res_dgnven between @DgnVenFm and @DgnVenTo))
--	and (@OptOrgVen = 'N' or (res_orgven between @OrgVenFm and @OrgVenTo))
	and (@OptPcFty='N' or (res_pcfty between @PcFtyFm and @PcFtyTo))
	and (@OptPrdVen = 'N' or (res_prdven between @PrdVenFm and @PrdVenTo))
	and (@OptItmNo = 'N' or (res_itmno between @ItmNoFm and @ItmNoTo))
	and (@OptAgyCo = 'N' or (res_agyco between @AgyCoFm and @AgyCoTo))
group by 	res_pcno,res_dgnven,--res_orgven,
	res_pcfty,
	res_prdven,res_agyco
order by res_pcno
End --@RptType='2'
--/////////////////////////////////////////////////////////////\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\
----------------------------------------------
	else if @RptType='3'
----------------------------------------------
begin
select 
convert(nvarchar(20),@InvDatFm,101),
convert(nvarchar(20),@InvDatTo,101),
@PCNoFm,
@PCNoTo,
@InvNoFm,
@InvNoTo,
@SCNoFm,
@SCNoTo,
@DgnVenFm,
@DgnVenTo,
--@OrgVenFm,
--@OrgVenTo,
@PcFtyFm,
@PcFtyTo,
@PrdVenFm,
@PrdVenTo,
@ItmNoFm,
@ItmNoTo,
@AgyCoFm,
@AgyCoTo,
@InvStatus,
@InvType,
   res_pcno,   convert(nvarchar(20),res_invdat,101),   res_invno,   res_slnonb,   res_jobno,   res_purord,
   res_scno,   res_dgnven,   --res_orgven,   
   res_pcfty,
   res_prdven,   res_subcde,
   res_itmno,   res_catlvl4,   res_qty,   res_untcde,   res_itmcst,   res_ttlitmcst,
   res_bomcst,   res_agyco,   res_devcrg
from #RESULT 
where
(@OptPCNo = 'N' or (res_pcno between @PCNoFm and @PCNoTo))
and (@OptSCNo = 'N' or (res_scno between @SCNoFm and @SCNoTo))
and (@OptDgnVen = 'N' or (res_dgnven between @DgnVenFm and @DgnVenTo))
--and (@OptOrgVen = 'N' or (res_orgven between @OrgVenFm and @OrgVenTo))
and (@OptPcFty='N' or (res_pcfty between @PcFtyFm and @PcFtyTo))
and (@OptPrdVen = 'N' or (res_prdven between @PrdVenFm and @PrdVenTo))
and (@OptItmNo = 'N' or (res_itmno between @ItmNoFm and @ItmNoTo))
and (@OptAgyCo = 'N' or (res_agyco between @AgyCoFm and @AgyCoTo))

order by res_dgnven, res_invdat, res_jobno
End --@RptType=3
-----------------------------------------
	else if @RptType='4'
-----------------------------------------
begin
select 
	convert(nvarchar(20),@InvDatFm,101),
	convert(nvarchar(20),@InvDatTo,101),
	@PCNoFm,
	@PCNoTo,
	@InvNoFm,
	@InvNoTo,
	@SCNoFm,
	@SCNoTo,
	@DgnVenFm,
	@DgnVenTo,
--	@OrgVenFm,
--	@OrgVenTo,
	@PcFtyFm,
	@PcFtyTo,
	@PrdVenFm,
	@PrdVenTo,
	@ItmNoFm,
	@ItmNoTo,
	@AgyCoFm,
	@AgyCoTo,
	@InvStatus,
	@InvType,
res_dgnven,
--res_orgven,
res_pcfty,
res_prdven,
sum(res_ttlitmcst) as 'res_itmcst',
sum(res_bomcst) as 'res_bomcst',
sum(res_devcrg) as 'res_devcrg'--,
from #RESULT
where
	(@OptPCNo = 'N' or (res_pcno between @PCNoFm and @PCNoTo))
	and (@OptSCNo = 'N' or (res_scno between @SCNoFm and @SCNoTo))
	and (@OptDgnVen = 'N' or (res_dgnven between @DgnVenFm and @DgnVenTo))
--	and (@OptOrgVen = 'N' or (res_orgven between @OrgVenFm and @OrgVenTo))
	and (@OptPcFty='N' or (res_pcfty between @PcFtyFm and @PcFtyTo))
	and (@OptPrdVen = 'N' or (res_prdven between @PrdVenFm and @PrdVenTo))
	and (@OptItmNo = 'N' or (res_itmno between @ItmNoFm and @ItmNoTo))
	and (@OptAgyCo = 'N' or (res_agyco between @AgyCoFm and @AgyCoTo))
group by 	res_dgnven,--res_orgven,
	res_pcfty,
	res_prdven
order by res_dgnven
end  --@RptType='4'

------------------------------------------------------
	else if @RptType='5'
------------------------------------------------------
begin
select 
convert(nvarchar(20),@InvDatFm,101),
convert(nvarchar(20),@InvDatTo,101),
@PCNoFm,
@PCNoTo,
@InvNoFm,
@InvNoTo,
@SCNoFm,
@SCNoTo,
@DgnVenFm,
@DgnVenTo,
--@OrgVenFm,
--@OrgVenTo,
@PcFtyFm,
@PcFtyTo,
@PrdVenFm,
@PrdVenTo,
@ItmNoFm,
@ItmNoTo,
@AgyCoFm,
@AgyCoTo,
@InvStatus,
@InvType,
   res_pcno,   convert(nvarchar(20),res_invdat,101),   res_invno,   res_scno,   res_dgnven,   
   --res_orgven,
  res_pcfty,
   res_prdven,   res_subcde,   res_itmno,   res_catlvl4,   res_selprc,   res_qty,
   res_untcde,   res_gsamt,   res_preamt,   res_disamt,   res_rbtamt,
   res_netsamt,   res_ttlitmcst,
   res_bomcst,   res_agyco,   res_agycrg,   res_devcrg,   res_netpft
from #RESULT 
where
(@OptPCNo = 'N' or (res_pcno between @PCNoFm and @PCNoTo))
and (@OptSCNo = 'N' or (res_scno between @SCNoFm and @SCNoTo))
and (@OptDgnVen = 'N' or (res_dgnven between @DgnVenFm and @DgnVenTo))
--and (@OptOrgVen = 'N' or (res_orgven between @OrgVenFm and @OrgVenTo))
and (@OptPcFty='N' or (res_pcfty between @PcFtyFm and @PcFtyTo))
and (@OptPrdVen = 'N' or (res_prdven between @PrdVenFm and @PrdVenTo))
and (@OptItmNo = 'N' or (res_itmno between @ItmNoFm and @ItmNoTo))
and (@OptAgyCo = 'N' or (res_agyco between @AgyCoFm and @AgyCoTo))

--order by res_pcno, res_invdat, res_invno, res_scno
order by res_agyco,res_invdat,res_invno,res_scno,res_itmno
end
------------------------------------------------------
	else if @RptType='6'
------------------------------------------------------
begin
select 
	convert(nvarchar(20),@InvDatFm,101),
	convert(nvarchar(20),@InvDatTo,101),
	@PCNoFm,
	@PCNoTo,
	@InvNoFm,
	@InvNoTo,
	@SCNoFm,
	@SCNoTo,
	@DgnVenFm,
	@DgnVenTo,
--	@OrgVenFm,
--	@OrgVenTo,
	@PcFtyFm,	
	@PcFtyTo,
	@PrdVenFm,
	@PrdVenTo,
	@ItmNoFm,
	@ItmNoTo,
	@AgyCoFm,
	@AgyCoTo,
	@InvStatus,
	@InvType,
 res_pcno,
res_dgnven,
--res_orgven,
res_pcfty,
res_prdven,
sum(res_gsamt) as 'res_gsamt',
sum(res_preamt) as 'res_preamt',
sum(res_disamt) as 'res_disamt',
sum(res_rbtamt) as 'res_rbtamt',
sum(res_netsamt) as 'res_netsamt',
sum(res_ttlitmcst) as 'res_itmcst',
sum(res_bomcst) as 'res_bomcst',
res_agyco,
sum(res_agycrg) as 'res_agycry',
sum(res_devcrg) as 'res_devcrg',
sum(res_netpft) as 'res_netpft'
from #RESULT
where
	(@OptPCNo = 'N' or (res_pcno between @PCNoFm and @PCNoTo))
	and (@OptSCNo = 'N' or (res_scno between @SCNoFm and @SCNoTo))
	and (@OptDgnVen = 'N' or (res_dgnven between @DgnVenFm and @DgnVenTo))
--	and (@OptOrgVen = 'N' or (res_orgven between @OrgVenFm and @OrgVenTo))
	and (@OptPcFty='N' or (res_pcfty between @PcFtyFm and @PcFtyTo))
	and (@OptPrdVen = 'N' or (res_prdven between @PrdVenFm and @PrdVenTo))
	and (@OptItmNo = 'N' or (res_itmno between @ItmNoFm and @ItmNoTo))
	and (@OptAgyCo = 'N' or (res_agyco between @AgyCoFm and @AgyCoTo))
--group by res_pcno,res_dgnven,res_orgven,res_prdven,res_agyco
group by 	res_agyco,res_dgnven,--res_orgven,
	res_pcfty,
	res_prdven,res_pcno
--order by res_pcno
order by res_agyco
end 
--/////////////////////////////////////////////////////////////\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\

---------------------===========================
End














GO
GRANT EXECUTE ON [dbo].[sp_list_PCR00001] TO [ERPUSER] AS [dbo]
GO
