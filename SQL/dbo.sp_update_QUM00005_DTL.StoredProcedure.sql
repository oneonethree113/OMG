/****** Object:  StoredProcedure [dbo].[sp_update_QUM00005_DTL]    Script Date: 09/29/2017 15:29:08 ******/
DROP PROCEDURE [dbo].[sp_update_QUM00005_DTL]
GO
/****** Object:  StoredProcedure [dbo].[sp_update_QUM00005_DTL]    Script Date: 09/29/2017 15:29:10 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO










/*  
=========================================================  
Description    : sp_update_QUM00005_DTL
=========================================================  
 Modification History                                      
=========================================================  
 Date      Initial   Description                            
=========================================================       
*/  
  
CREATE         PROCEDURE [dbo].[sp_update_QUM00005_DTL]   
  
@qud_qutno  nvarchar(20),	@qud_qutseq  int


AS  

Declare
---------------
@qud_cocde nvarchar(6),	
--@qud_qutno  nvarchar(20),	@qud_qutseq  int,  
@qud_itmno  nvarchar(20),	@qud_itmsts  nvarchar(4),	@qud_itmdsc  nvarchar(800),  
@qud_alsitmno nvarchar(20),	@qud_alscolcde nvarchar(20),	@qud_conftr numeric(9),
@qud_contopc nvarchar(1),	@qud_pcprc numeric(13,4),	@qud_hstref  nvarchar(20),
@qud_colcde  nvarchar(30),	@qud_cuscol  nvarchar(30),	@qud_coldsc  nvarchar(300),
@qud_pckseq  int,		@qud_untcde  nvarchar(6),	@qud_inrqty  int,
@qud_mtrqty  int,		@qud_cft numeric(11,4),	@qud_curcde  nvarchar(6),
@qud_cus1sp  numeric(13,4),	@qud_cus2sp numeric(13,4),	@qud_cus1dp  numeric(13,4),
@qud_cus2dp  numeric(13,4),	@qud_onetim  nvarchar(1),	@qud_discnt  numeric(6,3),   
@qud_moflag char(1),		@qud_orgmoq  int,		@qud_orgmoa numeric(11,4),
@qud_moq  int,		@qud_moa  numeric(11,4),	@qud_smpqty  int,
@qud_hrmcde  nvarchar(12),	@qud_dtyrat  numeric(6,3),	@qud_dept  nvarchar(20),
@qud_cususd  numeric(13,4),	@qud_cuscad  numeric(13,4),	@qud_venno  nvarchar(6),
@qud_subcde nvarchar(10),	@qud_venitm  nvarchar(20),	@qud_ftyprc  numeric(13,4),
@qud_ftycst  numeric(13,4),	@qud_note  nvarchar(300),	@qud_image  nvarchar(1),
@qud_inrdin  numeric(11,4),	@qud_inrwin  numeric(11,4),	@qud_inrhin  numeric(11,4),
@qud_mtrdin  numeric(11,4),	@qud_mtrwin  numeric(11,4),	@qud_mtrhin  numeric(11,4),
@qud_inrdcm  numeric(11,4),	@qud_inrwcm  numeric(11,4),	@qud_inrhcm  numeric(11,4),
@qud_mtrdcm  numeric(11,4),	@qud_mtrwcm  numeric(11,4),	@qud_mtrhcm  numeric(11,4),
@qud_grswgt  numeric(6,3),	@qud_netwgt  numeric(6,3),	@qud_cosmth  nvarchar(50),
@qud_smpprc numeric(13,4),	@qud_cusitm nvarchar(20),	@cus1no  nvarchar(6),
@cus1na  nvarchar(20),	@cus2no  nvarchar(6),		@cus2na  nvarchar(20),
@qud_prcsec nvarchar(3),	@qud_grsmgn numeric(6,3),	@qud_basprc numeric(13,4),
@qud_tbm nvarchar(1),	@qud_tbmsts nvarchar(3),	@rvsdat  datetime,
@qud_apprve nvarchar(1),	
--@qud_pdabpdiff nvarchar(1),	
@qud_pckitr nvarchar(300),
@qud_stkqty int,		@qud_cusqty int,		@qud_smpunt nvarchar(6),
@qud_qutitmsts nvarchar(25),	@qud_fcurcde nvarchar(6),	
--@smpprd nvarchar(6),
@qud_itmtyp nvarchar(4),	@quh_qutsts nvarchar(10),	@qud_prctrm nvarchar(10),
@qud_cusven varchar(6),	@qud_cussub varchar(10),	@qud_ftyprctrm varchar(20),
@qud_cusstyno nvarchar(50),	@qud_cbm numeric(11, 4),	@qud_upc nvarchar(50),
@qud_specpck nvarchar(255),	@qud_ftytmpitm nvarchar(1),	@qud_ftytmpitmno nvarchar(20),
@qud_custitmcat nvarchar(12),	@qud_custitmcatfml nvarchar(6),	@qud_custitmcatamt numeric(13,4),
@qud_pmu nvarchar(100),	@qud_imrmk nvarchar(255),	@qud_rndsts nvarchar(255),
@qud_calpmu numeric(13,4),	@qud_moqunttyp nvarchar(6),	@qud_qutdat datetime,
@qud_cus1no nvarchar(6),	@qud_cus2no nvarchar(6),	@qud_trantrm nvarchar(10),
@qud_effdat datetime,		@qud_expdat datetime,	@qud_itmnotyp nvarchar(1),
@qud_itmnoreal nvarchar(20),	@qud_itmnotmp nvarchar(20),	@qud_itmnoven nvarchar(20),
@qud_itmnovenno nvarchar(6),	@qud_imgpth nvarchar(200),	@qud_cususdcur nvarchar(6),
@qud_cuscadcur nvarchar(6),	@qud_dv	nvarchar(10),
@qud_tv	nvarchar(10),
@qud_ftyaud	nvarchar(10),
@qud_buyer	nvarchar(20),
@qud_toqty	int,
@qud_tormk	nvarchar(300),
@qud_ftyshpstr	datetime,
@qud_ftyshpend	datetime,
@qud_cushpstr	datetime,
@qud_cushpend	datetime,
@qud_creusr	nvarchar(30),
@qud_updusr	nvarchar(30)

---------------
declare @qpe_cocde	nvarchar(6),	@qpe_qutno	nvarchar(20),	@qpe_qutseq	int,
@qpe_itmno	nvarchar(20),	@qpe_untcde	nvarchar(6),	@qpe_inrqty	int,
@qpe_mtrqty	int,		@qpe_cft		numeric(11,4),	@qpe_cbm		numeric(11,4),
@qpe_ftyprctrm	nvarchar(10),	@qpe_prctrm	nvarchar(10),	@qpe_trantrm	nvarchar(10),
@qpe_fml_cus1no	nvarchar(10),	@qpe_fml_cus2no	nvarchar(10),	@qpe_fml_cat		nvarchar(20),
@qpe_fml_venno	nvarchar(10),	@qpe_fml_ventranflg	char(1),		@qpe_fcurcde	nvarchar(10),
@qpe_ftycst	numeric(13, 4),	@qpe_ftyprc	numeric(13, 4),	@qpe_curcde	nvarchar(10),
@qpe_basprc	numeric(13, 4),	@qpe_mu		numeric(13, 4),	@qpe_mumin	numeric(13, 4),
@qpe_muprc	numeric(13, 4),	@qpe_cus1sp	numeric(13, 4),	@qpe_cus1dp	numeric(13, 4),
@qpe_cushcstbufper	numeric(13, 4),	@qpe_cushcstbufamt	numeric(13, 4),	@qpe_othdisper	numeric(13, 4),
@qpe_maxapvper	numeric(13, 4),	@qpe_maxapvamt	numeric(13, 4),	@qpe_spmuper	numeric(13, 4),
@qpe_dpmuper	numeric(13, 4),	@qpe_cumu	numeric(13, 4),	@qpe_pm		numeric(13, 4),
@qpe_cush	numeric(13, 4),	@qpe_thccusper	numeric(13, 4),	@qpe_upsper	numeric(13, 4),
@qpe_labper	numeric(13, 4),	@qpe_faper	numeric(13, 4),	@qpe_cstbufper	numeric(13, 4),
@qpe_othper	numeric(13, 4),	@qpe_pliper	numeric(13, 4),	@qpe_dmdper	numeric(13, 4),
@qpe_rbtper	numeric(13, 4),	@qpe_subttlper	numeric(13, 4),	@qpe_pkgper	numeric(13, 4),
@qpe_comper	numeric(13, 4),	@qpe_icmper	numeric(13, 4),	@qpe_stdprc	numeric(13,4),
@qpe_ftycstA	numeric(13, 4), @qpe_ftycstB	numeric(13, 4), @qpe_ftycstC	numeric(13, 4),
@qpe_ftycstD	numeric(13, 4), @qpe_ftycstTran	numeric(13, 4), @qpe_ftycstPack	numeric(13, 4),
@qpe_lightspec	nvarchar(300), 
@qpe_creusr	nvarchar(30),
@qpe_updusr	nvarchar(30)

----------------------  
---------------------  
update	QUOTNDTL   
set	qud_qutitmsts = 'A',	qud_apprve = 'Y'
where	
	qud_qutno = @qud_qutno	and
	qud_qutseq = @qud_qutseq
  
----------------------
---------------------
select 
@qud_itmno = qud_itmno,	@qud_itmsts = qud_itmsts,	@qud_itmdsc = qud_itmdsc,  
	@qud_alsitmno = qud_alsitmno,	@qud_alscolcde = qud_alscolcde,	@qud_conftr =  qud_conftr,
	@qud_contopc = qud_contopc,	@qud_pcprc = qud_pcprc,	@qud_hstref = qud_hstref,
	@qud_colcde = qud_colcde,	@qud_cuscol = qud_cuscol,	@qud_coldsc = qud_coldsc,
	@qud_pckseq = qud_pckseq,	@qud_untcde = qud_untcde,	@qud_inrqty = qud_inrqty,
	@qud_mtrqty = qud_mtrqty,	@qud_cft = qud_cft,		@qud_curcde = qud_curcde,
	@qud_cus1sp = qud_cus1sp,	@qud_cus2sp = qud_cus2sp,	@qud_cus1dp = qud_cus1dp,
	@qud_cus2dp = qud_cus2dp,	@qud_onetim = qud_onetim,	@qud_discnt = qud_discnt,
	@qud_moq = qud_moq,	@qud_moa = qud_moa,	@qud_smpqty = qud_smpqty,
	@qud_hrmcde = qud_hrmcde,	@qud_dtyrat = qud_dtyrat,	@qud_dept = qud_dept,
	@qud_cususd = qud_cususd,	@qud_cuscad = qud_cuscad,	@qud_venno = qud_venno,
	@qud_venitm = qud_venitm,	@qud_ftyprc = qud_ftyprc,	@qud_note = qud_note,
	@qud_image = qud_image,	@qud_inrdin = qud_inrdin,	@qud_inrwin = qud_inrwin,
	@qud_inrhin = qud_inrhin,	@qud_mtrdin = qud_mtrdin,	@qud_mtrwin = qud_mtrwin,
	@qud_mtrhin = qud_mtrhin,	@qud_inrdcm = qud_inrdcm,	@qud_inrwcm = qud_inrwcm,
	@qud_inrhcm = qud_inrhcm,	@qud_mtrdcm = qud_mtrdcm,	@qud_mtrwcm = qud_mtrwcm,
	@qud_mtrhcm = qud_mtrhcm,	@qud_grswgt = qud_grswgt,	@qud_netwgt = qud_netwgt,
	@qud_cosmth = qud_cosmth,	
	--@qud_updusr = qud_creusr,	
	--@qud_upddat = getdate(),
	@qud_smpprc = qud_smpprc,	@qud_cusitm = qud_cusitm,	@qud_prcsec = qud_prcsec,
	@qud_grsmgn = qud_grsmgn,	@qud_basprc = qud_basprc,	@qud_tbm = qud_tbm,
	@qud_tbmsts = qud_tbmsts,	@qud_apprve = qud_apprve,	--@qud_pdabpdiff=qud_pdabpdiff,
	@qud_pckitr = qud_pckitr,	@qud_stkqty = qud_stkqty,	@qud_cusqty = qud_cusqty,
	@qud_smpunt = qud_smpunt,	@qud_qutitmsts = qud_qutitmsts,	@qud_fcurcde = qud_fcurcde,
	@qud_itmtyp = qud_itmtyp,	@qud_subcde = qud_subcde,	@qud_ftycst = qud_ftycst,
	@qud_prctrm = qud_prctrm,	@qud_moflag = qud_moflag,	@qud_orgmoq = qud_orgmoq,
	@qud_orgmoa = qud_orgmoa,	@qud_cusven = qud_cusven,	@qud_cussub  = qud_cussub,
	@qud_ftyprctrm = qud_ftyprctrm,	@qud_cusstyno = isnull(qud_cusstyno ,''),	@qud_cbm = qud_cbm,
	@qud_upc = qud_upc,		@qud_specpck = qud_specpck,	@qud_ftytmpitm = qud_ftytmpitm,
	@qud_ftytmpitmno = isnull(qud_ftytmpitmno,''),	@qud_custitmcat = qud_custitmcat,	@qud_custitmcatfml = qud_custitmcatfml,
	@qud_custitmcatamt = qud_custitmcatamt,	@qud_pmu = qud_pmu,	@qud_imrmk = qud_imrmk,
	@qud_rndsts = qud_rndsts,	@qud_calpmu = qud_calpmu,	@qud_moqunttyp = qud_moqunttyp,
	@qud_qutdat = qud_qutdat,	@qud_cus1no = qud_cus1no,	@qud_cus2no = qud_cus2no,
	@qud_trantrm = qud_trantrm,	@qud_effdat = qud_effdat,	@qud_expdat = qud_expdat,
	@qud_itmnotyp = qud_itmnotyp,	@qud_itmnoreal = qud_itmnoreal,	@qud_itmnotmp = qud_itmnotmp,
	@qud_itmnoven = qud_itmnoven,	@qud_itmnovenno = qud_itmnovenno,	@qud_imgpth = qud_imgpth,
	@qud_cususdcur = qud_cususdcur,	
	@qud_cuscadcur = qud_cuscadcur,
	@qud_dv=qud_dv,
	@qud_tv=qud_tv,
	@qud_ftyaud=qud_ftyaud,
	@qud_buyer=qud_buyer,
	@qud_toqty=qud_toqty,
	@qud_tormk=qud_tormk,
	@qud_ftyshpstr=qud_ftyshpstr,
	@qud_ftyshpend=qud_ftyshpend,
	@qud_cushpstr=qud_cushpstr,
	@qud_cushpend=qud_cushpend,
	@qud_creusr = qud_creusr,
	@qud_updusr = qud_updusr

from quotndtl
	where qud_qutno = @qud_qutno 
		and qud_qutseq = @qud_qutseq


	--qpe
select
@qpe_itmno = qpe_itmno,	@qpe_untcde = qpe_untcde,	@qpe_inrqty = qpe_inrqty,
@qpe_mtrqty = qpe_mtrqty,	@qpe_cft = qpe_cft,		@qpe_cbm = qpe_cbm,
@qpe_ftyprctrm = qpe_ftyprctrm,	@qpe_prctrm = qpe_prctrm,	@qpe_trantrm = qpe_trantrm,
@qpe_fml_cus1no = qpe_fml_cus1no,	@qpe_fml_cus2no = qpe_fml_cus2no,	@qpe_fml_cat = qpe_fml_cat,
@qpe_fml_venno = qpe_fml_venno,	@qpe_fml_ventranflg = qpe_fml_ventranflg,	@qpe_fcurcde = qpe_fcurcde,
@qpe_ftycst = qpe_ftycst,	@qpe_ftyprc = qpe_ftyprc,	@qpe_curcde = qpe_curcde,
@qpe_basprc = qpe_basprc,	@qpe_mu = qpe_mu,		@qpe_mumin = qpe_mumin,
@qpe_muprc = qpe_muprc,	@qpe_cus1sp = qpe_cus1sp,	@qpe_cus1dp = qpe_cus1dp,
@qpe_cushcstbufper = qpe_cushcstbufper,	@qpe_cushcstbufamt = qpe_cushcstbufamt,	@qpe_othdisper = qpe_othdisper,
@qpe_maxapvper = qpe_maxapvper,	@qpe_maxapvamt = qpe_maxapvamt,	@qpe_spmuper = qpe_spmuper,
@qpe_dpmuper = qpe_dpmuper,	@qpe_cumu = qpe_cumu,	@qpe_pm = qpe_pm,
@qpe_cush = qpe_cush,	@qpe_thccusper = qpe_thccusper,	@qpe_upsper = qpe_upsper,
@qpe_labper = qpe_labper,	@qpe_faper = qpe_faper,	@qpe_cstbufper = qpe_cstbufper,
@qpe_othper = qpe_othper,	@qpe_pliper = qpe_pliper,	@qpe_dmdper = qpe_dmdper,
@qpe_rbtper = qpe_rbtper,	@qpe_subttlper = qpe_subttlper,	@qpe_pkgper = qpe_pkgper,
@qpe_comper = qpe_comper,	@qpe_icmper = qpe_icmper,	@qpe_stdprc = qpe_stdprc,
@qpe_ftycstA = qpe_ftycstA, 	@qpe_ftycstB = qpe_ftycstB,	@qpe_ftycstC = qpe_ftycstC,
@qpe_ftycstD = qpe_ftycstD,	@qpe_ftycstTran = qpe_ftycstTran,	@qpe_ftycstPack = qpe_ftycstPack,
@qpe_lightspec = qpe_lightspec,
@qpe_creusr = qpe_creusr,
@qpe_updusr = qpe_updusr,
@qpe_qutseq =qpe_qutseq

from QUPRCEMT (nolock)
where	
	qpe_qutno = @qud_qutno	and
	qpe_qutseq = @qud_qutseq

--test---
select @qpe_qutseq  as 'test'
--test---
select * from QUPRCEMT
where 
qpe_qutno = @qud_qutno	and
	qpe_qutseq = @qud_qutseq



-------------
declare	@cid_seqno int,	@smpqty_sum int,	@stkqty_sum int,  
	@cusqty_sum int,	@freqty_sum int,	@chgqty_sum int,  
	@yst_chgval int,	@avail int,		@freqty int,
	@chgqty int,	@sumqty int,	@sad_smpqty int,  
	@def nvarchar(6),	@selrat numeric(12,4),	@ycf_value int,
	@sad_cusqty int,	@Itmventyp char(1)
    
--- Get Item Vendor Type ---  
set @Itmventyp = isnull(
			(SELECT	VBI_VENTYP    
			 FROM	IMBASINF (NOLOCK)   
			 LEFT JOIN VNBASINF (NOLOCK) ON VBI_VENNO = IBI_VENNO  
			 WHERE	IBI_ITMNO = @qud_itmno	and
				VBI_VENTYP IS NOT NULL)
		,' ')  

--IMCUSSTY
declare @cusstyno as nvarchar(30)
declare @chkdgt as integer
set @cusstyno = isnull(@qud_cusstyno ,'')
if @cusstyno <> '' 
begin
	select @chkdgt = isnull(max(ics_chkdgt) + 1,0) from IMCUSSTY (nolock) where ics_cusno = @cus1no and ics_cusstyno = @cusstyno 

	if (select count(*) from IMCUSSTY (nolock) where  ics_cusstyno = @cusstyno and  ics_cusno = @cus1no and ics_itmno = @qud_itmno) = 0
	begin
		insert into IMCUSSTY (ics_cusno,ics_cusstyno,ics_chkdgt,ics_itmno,ics_creusr,ics_updusr,ics_credat,ics_upddat)
		values (@cus1no,@cusstyno,@chkdgt,@qud_itmno,@qud_creusr,@qud_creusr,getdate(),getdate())
	end
end





declare @quh_year nvarchar(20)
declare @quh_season nvarchar(20)
declare @quh_cus1no nvarchar(10)
declare @quh_cus2no nvarchar(10)


select @quh_year = quh_year, @quh_season = quh_season, @quh_cus1no = quh_cus1no, @quh_cus2no = quh_cus2no from QUOTNHDR (nolock) where        quh_qutno = @qud_qutno

--test---
select @quh_cus1no as 'test'

declare @cis_flg as char(1)

declare @cis_key_cocde as nvarchar(10)
declare @cis_key_cusno as nvarchar(10)
declare @cis_key_seccus as nvarchar(10)
declare @cis_key_itmno as nvarchar(20)
declare @cis_key_colcde as nvarchar(30)
declare @cis_key_untcde as nvarchar(10)
declare @cis_key_conftr as int
declare @cis_key_inrqty as int
declare @cis_key_mtrqty as int
declare @cis_key_hkprctrm as nvarchar(10)
declare @cis_key_ftyprctrm as nvarchar(10)
declare @cis_key_trantrm as nvarchar(10)

--
declare @cip_key_cocde as nvarchar(10)
declare @cip_key_cusno as nvarchar(10)
declare @cip_key_seccus as nvarchar(10)
declare @cip_key_itmno as nvarchar(20)
declare @cip_key_venno as nvarchar(20)
declare @cip_key_prdven as nvarchar(20)
declare @cip_key_colcde as nvarchar(30)
declare @cip_key_untcde as nvarchar(10)
declare @cip_key_conftr as int
declare @cip_key_inrqty as int
declare @cip_key_mtrqty as int
declare @cip_key_hkprctrm as nvarchar(10)
declare @cip_key_ftyprctrm as nvarchar(10)
declare @cip_key_trantrm as nvarchar(10)
declare @cip_key_effdat as datetime
declare @cip_key_expdat as datetime



if @qud_itmnoreal <> '' and @qud_qutitmsts = 'A' --and @quh_qutsts = 'A' and @qud_qutitmsts = 'A - Active'	and (@qud_apprve = '' or @qud_apprve = 'Y')
	set @cis_flg = 'Y'
else
	set @cis_flg = 'N'

if @cis_flg = 'Y'
begin

--test---
select * from QUPRCEMT
where 
qpe_qutno = @qud_qutno	and
	qpe_qutseq = @qud_qutseq

	-- Insert / Update CUITMHIS
	set @cis_key_cocde = ''
	set @cis_key_cusno = @quh_cus1no
	set @cis_key_seccus = @quh_cus2no
	set @cis_key_itmno = @qud_itmnoreal
	set @cis_key_colcde = @qud_colcde
	set @cis_key_untcde = @qud_untcde
	set @cis_key_conftr = @qud_conftr
	set @cis_key_inrqty = @qud_inrqty
	set @cis_key_mtrqty = @qud_mtrqty
	set @cis_key_hkprctrm = @qud_prctrm
	set @cis_key_ftyprctrm = @qud_ftyprctrm
	set @cis_key_trantrm = @qud_trantrm

	-- Insert / Update CUITMPRC
	set @cip_key_cocde = ''
	set @cip_key_cusno = @quh_cus1no
	set @cip_key_seccus = @quh_cus2no
	set @cip_key_itmno = @qud_itmnoreal
	set @cip_key_venno = @qud_dv
	set @cip_key_prdven = @qud_venno
	set @cip_key_colcde = @qud_colcde
	set @cip_key_untcde = @qpe_untcde 
	set @cip_key_conftr = @qud_conftr
	set @cip_key_inrqty = @qpe_inrqty
	set @cip_key_mtrqty = @qpe_mtrqty
	set @cip_key_hkprctrm = @qpe_prctrm
	set @cip_key_ftyprctrm = @qpe_ftyprctrm
	set @cip_key_trantrm = @qpe_trantrm
	set @cip_key_effdat = @qud_effdat
	set @cip_key_expdat = @qud_expdat


if @quh_cus1no is not null 
begin

--test---
select * from QUPRCEMT
where 
qpe_qutno = @qud_qutno	and
	qpe_qutseq = @qud_qutseq

	if ((select count(*) from CUITMHIS (nolock) 
			where cis_cocde = @cis_key_cocde and
				cis_cusno = @cis_key_cusno and
				cis_seccus = @cis_key_seccus and
				cis_itmno = @cis_key_itmno and
				cis_colcde = @cis_key_colcde and
				cis_untcde = @cis_key_untcde and
				cis_conftr = @cis_key_conftr and
				cis_inrqty = @cis_key_inrqty and
				cis_mtrqty = @cis_key_mtrqty and
				cis_hkprctrm = @cis_key_hkprctrm and
				cis_ftyprctrm = @cis_key_ftyprctrm and
				cis_trantrm = @cis_key_trantrm ) = 0 )
	begin
		insert into CUITMHIS
		(cis_cocde,cis_cusno,cis_cussna,cis_seccus,cis_secsna,
		cis_itmno,cis_itmdsc,cis_cusitm,cis_colcde,cis_coldsc,
		cis_cuscol,cis_untcde,cis_conftr,cis_inrqty,cis_mtrqty,
		cis_cft,cis_cbm,cis_venno,cis_prdven,cis_cusven,
		cis_tradeven,cis_examven,cis_hkprctrm,cis_ftyprctrm,
		cis_trantrm,cis_cus1no,cis_cus2no,cis_refdoc,cis_docdat,
		cis_qutno,cis_qutseq,cis_cussku,cis_ordqty,cis_moqchg,
		cis_hrmcde,cis_dtyrat,cis_dept,cis_typcode,cis_code1,
		cis_code2,cis_code3,cis_cususdcur,cis_cususd,cis_cuscadcur,
		cis_cuscad,cis_inrdin,cis_inrwin,cis_inrhin,cis_mtrdin,
		cis_mtrwin,cis_mtrhin,cis_inrdcm,cis_inrwcm,cis_inrhcm,
		cis_mtrdcm,cis_mtrwcm,cis_mtrhcm,cis_pckitr,cis_itmventyp,
		cis_tirtyp,cis_moqunttyp,cis_moq,cis_moacur,cis_moa,
		cis_contopc,cis_pcprc,cis_ftytmpitm,cis_cusstyno,cis_year,
		cis_season,cis_creusr,cis_updusr,cis_credat,cis_upddat)
		values
		(@cis_key_cocde,@cis_key_cusno,@cus1na,@cis_key_seccus,@cus2na,
		@cis_key_itmno,@qud_itmdsc,@qud_cusitm,@cis_key_colcde,@qud_coldsc,
		@qud_cuscol,@cis_key_untcde,@cis_key_conftr,@cis_key_inrqty,@cis_key_mtrqty,
		@qud_cft,@qud_cbm,ltrim(rtrim(@qud_dv)),ltrim(rtrim(@qud_venno)),ltrim(rtrim(@qud_cusven)),
		ltrim(rtrim(@qud_tv)),ltrim(rtrim(@qud_ftyaud)),@cis_key_hkprctrm,@cis_key_ftyprctrm,
		@cis_key_trantrm,@qud_cus1no,@qud_cus2no,@qud_qutno,@rvsdat,
		@qud_qutno,@qud_qutseq,'',0,0,
		@qud_hrmcde,@qud_dtyrat,@qud_dept,'U','',
		'','',@qud_cususdcur,@qud_cususd,@qud_cuscadcur,
		@qud_cuscad,@qud_inrdin,@qud_inrwin,@qud_inrhin,@qud_mtrdin,
		@qud_mtrwin,@qud_mtrhin,@qud_inrdcm,@qud_inrwcm,@qud_inrhcm,
		@qud_mtrdcm,@qud_mtrwcm,@qud_mtrhcm,@qud_pckitr,@ItmVenTyp,
		1,@qud_moqunttyp,@qud_moq,@qud_curcde,@qud_moa,
		@qud_contopc,@qud_pcprc,@qud_ftytmpitm,@qud_cusstyno,@quh_year,
		@quh_season,@qud_creusr,@qud_creusr,getdate(),getdate())
	end
	else
	begin
		update CUITMHIS	set
		cis_itmdsc = @qud_itmdsc, 
		cis_cusitm = @qud_cusitm, 
		cis_coldsc = @qud_coldsc, 
		cis_cuscol = @qud_cuscol, 
		cis_cft = @qud_cft, 
		cis_cbm = @qud_cbm, 
		cis_venno = ltrim(rtrim(@qud_dv)), 
		cis_prdven = ltrim(rtrim(@qud_venno)), 
		cis_cusven = ltrim(rtrim(@qud_cusven)), 
		cis_tradeven = ltrim(rtrim(@qud_tv)), 
		cis_examven = ltrim(rtrim(@qud_ftyaud)), 
		cis_cus1no = @qud_cus1no, 
		cis_cus2no = @qud_cus2no, 
		cis_refdoc = @qud_qutno, 
		cis_docdat = @rvsdat, 
		cis_qutno = @qud_qutno, 
		cis_qutseq = @qud_qutseq, 
		--cis_cussku = '', 
		--cis_ordqty = 0, 
		--cis_moqchg = 0, 
		cis_hrmcde = @qud_hrmcde, 
		cis_dtyrat = @qud_dtyrat, 
		cis_dept = @qud_dept, 
		--cis_typcode = 'U', 
		--cis_code1 = '', 
		--cis_code2 = '', 
		--cis_code3 = '', 
		cis_cususdcur = @qud_cususdcur, 
		cis_cususd = @qud_cususd, 
		cis_cuscadcur = @qud_cuscadcur, 
		cis_cuscad = @qud_cuscad, 
		cis_inrdin = @qud_inrdin, 
		cis_inrwin = @qud_inrwin, 
		cis_inrhin = @qud_inrhin, 
		cis_mtrdin = @qud_mtrdin, 
		cis_mtrwin = @qud_mtrwin, 
		cis_mtrhin = @qud_mtrhin, 
		cis_inrdcm = @qud_inrdcm, 
		cis_inrwcm = @qud_inrwcm, 
		cis_inrhcm = @qud_inrhcm, 
		cis_mtrdcm = @qud_mtrdcm, 
		cis_mtrwcm = @qud_mtrwcm, 
		cis_mtrhcm = @qud_mtrhcm, 
		cis_pckitr = @qud_pckitr, 
		cis_itmventyp = @ItmVenTyp, 
		--cis_tirtyp = 1, 
		cis_moqunttyp = @qud_moqunttyp, 
		cis_moq = @qud_moq, 
		cis_moacur = @qud_curcde, 
		cis_moa = @qud_moa, 
		cis_contopc = @qud_contopc, 
		cis_pcprc = @qud_pcprc, 
		cis_ftytmpitm = @qud_ftytmpitm, 
		cis_cusstyno = @qud_cusstyno, 
		cis_year = @quh_year, 
		cis_season = @quh_season, 
		cis_updusr = @qud_creusr, 
		cis_upddat = getdate()
		where 	cis_cocde = @cis_key_cocde and 
			cis_cusno = @cis_key_cusno and 
			cis_seccus = @cis_key_seccus and 
			cis_itmno = @cis_key_itmno and 
			cis_colcde = @cis_key_colcde and 
			cis_untcde = @cis_key_untcde and 
			cis_conftr = @cis_key_conftr and 
			cis_inrqty = @cis_key_inrqty and 
			cis_mtrqty = @cis_key_mtrqty and 
			cis_hkprctrm = @cis_key_hkprctrm and 
			cis_ftyprctrm = @cis_key_ftyprctrm and 
			cis_trantrm = @cis_key_trantrm
	end

	--PRC
--test---
select * from QUPRCEMT
where 
qpe_qutno = @qud_qutno	and
	qpe_qutseq = @qud_qutseq

	if ((select count(*) from CUITMPRC (nolock) 
			where 	cip_cocde = @cip_key_cocde and 
				cip_cusno = @cip_key_cusno and
				cip_seccus = @cip_key_seccus and
				cip_itmno = @cip_key_itmno and
				cip_venno = @cip_key_venno and
				cip_prdven = @cip_key_prdven and
				cip_colcde = @cip_key_colcde and
				cip_untcde = @cip_key_untcde and
				cip_conftr = @cip_key_conftr and
				cip_inrqty = @cip_key_inrqty and
				cip_mtrqty = @cip_key_mtrqty and
				cip_hkprctrm = @cip_key_hkprctrm and
				cip_ftyprctrm = @cip_key_ftyprctrm and
				cip_trantrm = @cip_key_trantrm and
				--cip_effdat = @cip_key_effdat and
				--cip_expdat = @cip_key_expdat
				left(cip_effdat,10) = left(@cip_key_effdat,10) and
				left(cip_expdat,10) = left(@cip_key_expdat,10) 

				 ) = 0 ) 
	begin
--test---
select * from QUPRCEMT
where 
qpe_qutno = @qud_qutno	and
	qpe_qutseq = @qud_qutseq

		insert into CUITMPRC 
		(cip_cocde,cip_cusno,cip_seccus,cip_itmno,cip_venno,
		cip_prdven,cip_colcde,cip_untcde,cip_conftr,cip_inrqty,
		cip_mtrqty,cip_hkprctrm,cip_ftyprctrm,cip_trantrm,cip_cus1no,
		cip_cus2no,cip_effdat,cip_expdat,cip_refdoc,cip_refseq,
		cip_docdat,cip_fcurcde,cip_ftycst,cip_bomcst,cip_ftyprc,
		cip_curcde,cip_basprc,cip_markup,cip_mrkprc,cip_pckcst,
		cip_commsn,cip_itmcom,cip_stdprc,cip_discnt,cip_adjprc,
		cip_qutdat,cip_imqutdat,cip_creusr,cip_updusr,cip_credat,
		cip_upddat)
		values
		(@cip_key_cocde,@cip_key_cusno,@cip_key_seccus,@cip_key_itmno,@cip_key_venno,
		@cip_key_prdven,@cip_key_colcde,@cip_key_untcde,@cip_key_conftr,@cip_key_inrqty,
		@cip_key_mtrqty,@cip_key_hkprctrm,@cip_key_ftyprctrm,@cip_key_trantrm,@qud_cus1no,
		@qud_cus2no,@cip_key_effdat,@cip_key_expdat,
		@qud_qutno, -- same
		@qpe_qutseq,
		getdate(),@qpe_fcurcde,@qpe_ftycst,0,@qpe_ftyprc,
		@qpe_curcde,@qpe_basprc,@qpe_mu,@qpe_muprc,@qpe_pkgper,
		@qpe_comper,@qpe_icmper,@qpe_cus1sp,0,@qpe_cus1dp,
		@qud_qutdat,'1900/01/01',@qpe_creusr,@qpe_creusr,getdate(),
		getdate())
	end
	else
	begin

--test---
select * from QUPRCEMT
where 
qpe_qutno = @qud_qutno	and
	qpe_qutseq = @qud_qutseq

		update CUITMPRC set 
		cip_cus1no = @qud_cus1no,
		cip_cus2no = @qud_cus2no,
		cip_refdoc = @qud_qutno, -- same
		cip_refseq = @qpe_qutseq,
		cip_docdat = getdate(),
		cip_fcurcde = @qpe_fcurcde,
		cip_ftycst = @qpe_ftycst,
--		cip_bomcst = 0,
		cip_ftyprc = @qpe_ftyprc,
		cip_curcde = @qpe_curcde,
		cip_basprc = @qpe_basprc,
		cip_markup = @qpe_mu,
		cip_mrkprc = @qpe_muprc,
		cip_pckcst = @qpe_pkgper,
		cip_commsn = @qpe_comper,
		cip_itmcom = @qpe_icmper,
		cip_stdprc = @qpe_cus1sp,
--		cip_discnt = 0,
		cip_adjprc = @qpe_cus1dp,
		cip_qutdat = @qud_qutdat,
--		cip_imqutdat = '1900/01/01',
		cip_updusr = @qpe_creusr,
		cip_upddat = getdate()
		where 
		cip_cocde = @cip_key_cocde and
		cip_cusno = @cip_key_cusno and
		cip_seccus = @cip_key_seccus and
		cip_itmno = @cip_key_itmno and
		cip_venno = @cip_key_venno and
		cip_prdven = @cip_key_prdven and
		cip_colcde = @cip_key_colcde and
		cip_untcde = @cip_key_untcde and
		cip_conftr = @cip_key_conftr and
		cip_inrqty = @cip_key_inrqty and
		cip_mtrqty = @cip_key_mtrqty and
		cip_hkprctrm = @cip_key_hkprctrm and
		cip_ftyprctrm = @cip_key_ftyprctrm and
		cip_trantrm = @cip_key_trantrm and
--		cip_effdat = @cip_key_effdat and
--		cip_expdat = @cip_key_expdat
		left(cip_effdat,10) = left(@cip_key_effdat,10) and
		left(cip_expdat,10) = left(@cip_key_expdat,10)

	end





end

end














GO
GRANT EXECUTE ON [dbo].[sp_update_QUM00005_DTL] TO [ERPUSER] AS [dbo]
GO
