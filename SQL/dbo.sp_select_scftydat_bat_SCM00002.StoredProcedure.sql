/****** Object:  StoredProcedure [dbo].[sp_select_scftydat_bat_SCM00002]    Script Date: 09/29/2017 15:29:09 ******/
DROP PROCEDURE [dbo].[sp_select_scftydat_bat_SCM00002]
GO
/****** Object:  StoredProcedure [dbo].[sp_select_scftydat_bat_SCM00002]    Script Date: 09/29/2017 15:29:10 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO

















/*  
=========================================================  
Description    : sp_select_scftydat_bat_SCM00002  
Programmer   : Mark Lau  
ALTER  Date    :   
Last Modified   : 2009-06-29  
Table Read(s)  :  
Table Write(s)  :  
=========================================================  
 Modification History                                      
=========================================================  
 Date        Initial    Description                            
=========================================================       

*/  
  
CREATE   PROCEDURE [dbo].[sp_select_scftydat_bat_SCM00002]   
  
@cocde nvarchar(6),  
@from nvarchar(20),  
@to nvarchar(20),  
@fntyp nvarchar(1),  
@lotno		nvarchar(255),
@filename	nvarchar(255),
@usrid nvarchar(30)  
  
AS  
  
BEGIN  

declare @feed varchar(10)
set @feed = '
'
---------------------------------------------------------------------------------------------------  
 IF @fntyp = 'Y'   
 BEGIN  
     
  DECLARE   
  @rate  numeric(13,11),  
  @rate1  numeric(13,11),  
  @tmpamt  numeric(13,4),  
  @ShpStartDate datetime,  
  @ShpEndDate datetime  
     
  DECLARE -- SCORDDTLHDR  
  @sco_ordno nvarchar(20),  
  @sco_cusven nvarchar(6),  
  @sco_purord nvarchar(20),  
  @sco_purseq  int,  
  @sco_ttlctn  int,  
  @sco_ttlamt numeric(13,4)  
--  @sco_rmk nvarchar(400)  
    
  DECLARE -- SCORDDTL  
  @sdt_fcurcde  nvarchar(6),  
  @sdt_itmsts  nvarchar(4),  
  @sdt_venno  nvarchar(6),       
  @sdt_cusven  nvarchar(6),  
  @sdt_purord  nvarchar(20),  
  @sdt_purseq   int,  
  @sdt_cocde  nvarchar(6),  
  @sdt_ordno  nvarchar(20),  
  @sdt_ordseq  int,  
  @sdt_updpo  nvarchar(1),  
  @sdt_chgfty  nvarchar(1),  
  @sdt_itmno  nvarchar(20),  
  @sdt_itmtyp  nvarchar(4),  
  @sdt_itmdsc  nvarchar(800),  
  @sdt_colcde  nvarchar(30),  
  @sdt_cuscol  nvarchar(30),  
  @sdt_coldsc  nvarchar(300),  
  @sdt_pckseq  int,  
--  @sdt_pckunt  nvarchar(4),  
  @sdt_pckunt  nvarchar(6),  
  @sdt_inrctn  int,  
  @sdt_mtrctn  int,  
  @sdt_cft   numeric(11,4),  
  @sdt_cbm   numeric(11,4),  
  @sdt_qutno  nvarchar(20),  
  @sdt_refdat  datetime,  
  @sdt_cusitm  nvarchar(20),  
  @sdt_cussku  nvarchar(20),  
  @sdt_resppo  nvarchar(20),  
  @sdt_cuspo  nvarchar(20),  
  @sdt_ordqty  int,  
  @sdt_discnt  numeric(6,3),  
  @sdt_ftyprc  numeric(13,4),  
  @sdt_ftycst  numeric(13,4),  
  @sdt_oneprc  Nvarchar(1),  
  @sdt_curcde  Nvarchar(6),  
  @sdt_selprc  numeric(13,4),  
  @sdt_hrmcde  nvarchar(12),  
  @sdt_dtyrat  numeric(6,3),  
  @sdt_dept   nvarchar(20),  
  @sdt_typcode  nvarchar(1),  
--  @sdt_Code1  nvarchar(15),   @sdt_Code2  nvarchar(15),  
--  @sdt_Code3  nvarchar(15),  
-- Frankie Cheung 20100524
  @sdt_Code1  nvarchar(25),   @sdt_Code2  nvarchar(25),  
  @sdt_Code3  nvarchar(25),  
  @sdt_cususd  numeric(13,4),  
  @sdt_cuscad  numeric(13,4),  
  @sdt_inrdin  numeric(11,4),  
  @sdt_inrwin  numeric(11,4),  
  @sdt_inrhin  numeric(11,4),  
  @sdt_mtrdin  numeric(11,4),  
  @sdt_mtrwin  numeric(11,4),  
  @sdt_mtrhin  numeric(11,4),  
  @sdt_inrdcm  numeric(11,4),  
  @sdt_inrwcm  numeric(11,4),  
  @sdt_inrhcm  numeric(11,4),  
  @sdt_mtrdcm  numeric(11,4),  
  @sdt_mtrwcm  numeric(11,4),  
  @sdt_mtrhcm  numeric(11,4),  
  @sdt_shpstr  datetime,  
  @sdt_shpend  datetime,  
  @sdt_candat  datetime,  
  @sdt_ctnstr  int,  
  @sdt_ctnend  int,  
  @sdt_ttlctn   int,  
  @sdt_rmk   nvarchar(300),  
  @sdt_invqty  int,  
      @sdt_shpqty  int,  
  @sdt_subcde  nvarchar(10),  
  @sdt_cussub  nvarchar(10),  
  @sdt_venitm  nvarchar(20),  
  @sdt_pckitr  nvarchar(300),  
  @sdt_oldpurord  nvarchar(20),  
  @sdt_oldpurseq  int,  
  @sdt_pjobno  varchar(20),  
  @sdt_seccusitm  varchar(20)  , 
-- Lester Wu 2006-09-26
  @sod_alsitmno varchar(20) , 
   @sod_alscolcde varchar(30),
	@sdt_posstr	datetime,
	@sdt_posend	datetime,
	@sdt_poscan	datetime
 
       
     DECLARE   
  @ret_code nvarchar(20),  
      @vbi_tsttim int,  
  @vbi_bufday int  
       
     DECLARE -- POORDHDR  
      @poh_cocde nvarchar(6),  
  @poh_purord nvarchar(20),  
  @poh_pursts nvarchar(3),  
  @poh_issdat datetime,  
  @poh_venno nvarchar(6),  
  @poh_puradr nvarchar(200),  
  @poh_purstt nvarchar(20),  
  @poh_purcty nvarchar(6),  
  @poh_purpst nvarchar(20),  
  @poh_porctp nvarchar(20),  
  @poh_puragt nvarchar(6),  
  @poh_salrep nvarchar(30),  
  @poh_prmcus nvarchar(6),  
  @poh_seccus nvarchar(6),  
  @poh_shpadr nvarchar(200),  
  @poh_shpstt nvarchar(20),  
  @poh_shpcty nvarchar(6),  
  @poh_shppst nvarchar(20),  
  @poh_prctrm nvarchar(20),  
  @poh_paytrm nvarchar(20),  
  @poh_ttlcbm numeric(13,4),  
  @poh_ttlctn int,  
  @poh_curcde nvarchar(6),  
  @poh_ttlamt numeric(13,4),  
  @poh_discnt numeric(6,3),  
  @poh_netamt numeric(13,4),  
  @poh_spoflg nvarchar(1),  
  @poh_cuspno nvarchar(20),  
  @poh_cpodat datetime,  
  @poh_reppno nvarchar(20),  
  @poh_pocdat datetime,  
  @poh_shpstr datetime,  
  @poh_shpend datetime,  
  @poh_lbldue datetime,  
  @poh_lblven nvarchar(20),  
  @poh_rmk  nvarchar(400)  ,
  -- Added by Mark Lau 20081202
  @poh_purchnadr nvarchar(255),
  @poh_cusctn int,
  @poh_dest nvarchar(30)

  
     DECLARE -- POORDDTL  
      @pod_cocde nvarchar(6),  
  @pod_purord nvarchar(20),  
  @pod_purseq int,  
  @pod_itmno nvarchar(20),  
  @pod_itmsts nvarchar(1),  
  @pod_venitm nvarchar(20),  
  @pod_cusitm nvarchar(20),  
  @pod_cussku nvarchar(20),  
  @pod_engdsc nvarchar(800),  
  @pod_chndsc nvarchar(1600),  
  @pod_vencol nvarchar(30),  
  @pod_cuscol nvarchar(30),  
  @pod_coldsc nvarchar(300),  
  @pod_pckseq int,  
  --@pod_untcde nvarchar(4),  
  @pod_untcde nvarchar(6),  
  @pod_inrctn int,  
  @pod_mtrctn int,  
  @pod_cubcft numeric(11,4),  
  @pod_cbm numeric(11,4),  
  @pod_dept  nvarchar(20),  
  @pod_ordqty int,  
  @pod_recqty int,  
  @pod_ftyprc numeric(13,4),  
  @pod_cuspno nvarchar(20),  
  @pod_respno nvarchar(20),  
  @pod_hrmcde nvarchar(20),  
--  @pod_lblcde nvarchar(20),  
-- Frankie Cheung 20100524
  @pod_lblcde nvarchar(75),  
  @pod_cususd numeric(13,4),  
  @pod_cuscad numeric(13,4),  
  @pod_shpstr datetime,  
  @pod_shpend datetime,  
  @pod_candat datetime,  
  @pod_ctnstr int,  
  @pod_ctnend int,  
  @pod_scno nvarchar(20),  
  @pod_ttlctn int,  
  @pod_lneamt numeric(13,4),  
  @pod_lnecub numeric(13,4),  
  @pod_ttlqty int,  
  @pod_scline int,  
  @pod_jobord nvarchar(20),  
  @pod_runno nvarchar(20),  
  @pod_assflg nvarchar(1),  
  @pod_updusr nvarchar(30),  
  @pod_upddat datetime,  
  @pod_prdven varchar(6),  
  @pod_prdsubcde varchar(10),  
  @pod_seccusitm varchar(20),   
  @dtyrat  numeric(6,3),  
  @typcode  nvarchar(1),  
--  @Code1  nvarchar(15),   
--  @Code2  nvarchar(15),  
--  @Code3  nvarchar(15),  
-- Frankie Cheung 20100514
  @Code1  nvarchar(25),   
  @Code2  nvarchar(25),  
  @Code3  nvarchar(25), 

  @pod_pckitr nvarchar(300)  
  
     DECLARE -- POSHPMRK  
  @psm_shptyp nvarchar(30),  
  @psm_engdsc nvarchar(1600),  
  @psm_chndsc nvarchar(3200),  
  @psm_engrmk nvarchar(1600),  
  @psm_chnrmk nvarchar(3200),  
  @psm_imgpth nvarchar(200),  
  @psm_imgnam nvarchar(30)  
    
 DECLARE -- POCNTINF  
  @pci_cocde nvarchar(6),  
  @pci_purord nvarchar(20),  
  @pci_csenam nvarchar(20),  
  @pci_cseadr nvarchar(200),  
  @pci_csestt  nvarchar(20),  
  @pci_csecty nvarchar(20),  
  @pci_csezip nvarchar(20),  
  @pci_fwdtyp nvarchar(2),  
  @pci_fwdacc nvarchar(20),  
  @pci_fwddsc nvarchar(200),  
  @pci_fwditr nvarchar(20),  
  @pci_noptyp nvarchar(2),  
  @pci_nopadr nvarchar(200),  
  @pci_nopstt nvarchar(20),  
  @pci_nopcty nvarchar(20),  
  @pci_nopzip nvarchar(20),  
  @pci_noptil nvarchar(20),  
  @pci_nopphn nvarchar(30),  
  @pci_nopfax nvarchar(30),  
  @pci_nopeml nvarchar(50)  
  
 DECLARE    
  @pda_itmno nvarchar(20),  
  @pda_assitm nvarchar(20),  
  @pda_assdsc nvarchar(800),  
  @pda_cusitm nvarchar(20),  
  @pda_colcde nvarchar(30),  
  @pda_coldsc nvarchar(300),  
  @pda_cussku nvarchar(20),  
  @pda_upcean nvarchar(15),  
  @pda_cusrtl nvarchar(20),   @pda_pckunt nvarchar(6),  
  @pda_inrqty int,  
  @pda_mtrqty int  
  
    
 DECLARE   
  @pdc_cocde Nvarchar(6),  
  @pdc_purord nvarchar(20),  

  @pdc_seq int,  
  @pdc_from int,  
  @pdc_to     int,  
  @pdc_ttlctn int  
    
/*
 DECLARE -- PODTLSHP  
  @pds_cocde nvarchar(6),  
  @pds_purord nvarchar(20),  
  @pds_seq int,  
  @pds_from datetime,  
  @pds_to  datetime,  
  @pds_ttlctn int  
*/

DECLARE -- PODTLSHP
@pds_cocde	nvarchar(6),
@pds_purord	nvarchar(20),
@pds_seq	int,
@pds_scfrom	datetime,
@pds_scto	datetime,
@pds_pofrom	datetime,
@pds_poto	datetime,
@pds_ttlctn	int,
@pds_ordqty	int,
@pds_ctnstr	int,
@pds_ctnend	int,
@pds_dest	nvarchar(50)

    
 DECLARE -- PODTLBOM  
  @pdb_cocde nvarchar(6),  
  @pdb_purord nvarchar(20),  
  @pdb_seq int,  
  @pdb_assitm nvarchar(20),  
  @pdb_bomitm nvarchar(20),  
  @pdb_colcde nvarchar(30),  
--  @pdb_pckunt nvarchar(4),  
  @pdb_pckunt nvarchar(6),  
  @pdb_bomqty int,  
  @pdb_venno nvarchar(6),  
  @pdb_ordqty  int,  
  @pdb_bomcst numeric(13,4),  
  @pdb_bcurcde varchar(6),  
  @pdb_imftyprc numeric(13,4),  
  @pdb_imcurcde varchar(6),  
  @pdb_curcde varchar(6),  
  @pdb_ftyprc numeric(13,4)  , 
    
  @pdb_bompoflg char(1) 
    
 DECLARE  
  @imu_curcde nvarchar(6),  
  @imu_ftyprc numeric(13,4),  
  @imu_bcurcde nvarchar(6),  
  @imu_ftycst numeric(13,4),  
  @vbi_curcde nvarchar(6),  
  -- Modified by Solo So as at 03-03-2002   
  -- exist flag of PO for no insert of PO Header  
  @po_exist int,  
  @VendorType char(1)  
    
 DECLARE   
  @startflag int  
  SET @startflag = 0  

--Lester Wu 2006-06-23
DECLARE
  @SC_ORD_NO nvarchar(20)

-- Added by Mark Lau 20090709
declare @jobord nvarchar(20)
declare @poftyprc numeric(13,4)
declare @polneamt numeric(13,4)
declare @currdt datetime
declare @scno nvarchar(20)
declare @scseq int
declare @popv nvarchar(20)
set @jobord = ''
set @poftyprc = 0
set @polneamt = 0
set @currdt = getdate()
set @scno = ''
set @scseq = 0
set @popv = ''


-- New SC PO Ship Date Calculation 20151116
declare @csf_cus1no nvarchar(10), @csf_cus2no nvarchar(10)
declare @csf_shpstrbuf int, @csf_shpendbuf int, @csf_cancelbuf int, @ventyp nvarchar(10)
set @csf_cus1no = ''
set @csf_cus2no = ''
set @csf_shpstrbuf = 0
set @csf_shpendbuf = 0
set @csf_cancelbuf = 0
set @ventyp = ''


  
  DECLARE cur_SCORDDTLHDR CURSOR FOR   
   
  SELECT   
   DISTINCT d.sod_ordno, d.sod_cusven  
  FROM   
   SCORDDTL d, SCORDHDR h  
  WHERE   
   h.soh_ordsts = 'ACT' AND  
   h.soh_ordno >= @from AND  
   h.soh_ordno <= @to AND  
   h.soh_cocde = @cocde AND  
   --d.sod_updpo = 'Y' AND **TBD   
   d.sod_ordno = h.soh_ordno AND  
   d.sod_cocde = h.soh_cocde   
  GROUP   
   BY  d.sod_ordno, d.sod_cusven  
-- Add by Allan Yuen at for prevent the incorrect sorting sequence 2004-07-05  
  order  BY    
   d.sod_ordno, d.sod_cusven  
-- Add by Allan Yuen at for prevent the incorrect sorting sequence 2004-07-05  
    
    
  OPEN cur_SCORDDTLHDR  
  FETCH NEXT FROM cur_SCORDDTLHDR INTO   
  @sco_ordno, @sco_cusven  
    
  IF @@fetch_status <> 0 AND @startflag = 0  
  BEGIN  
   PRINT 'Order No Not Found'  
   RETURN(99)  
  END    

  WHILE @@fetch_status = 0  
  BEGIN  

	select @csf_cus1no = soh_cus1no, @csf_cus2no = soh_cus2no from SCORDHDR (nolock) where soh_ordno = @sco_ordno
	select @ventyp = case vbi_ventyp when 'E' then 'EXT' else 'INT' end from VNBASINF (nolock) where vbi_venno = @sco_cusven

	if (select count(*) from CUSHPFML where csf_cus1no = @csf_cus1no and csf_cus2no = @csf_cus2no and csf_venno = @sco_cusven) = 1
	begin
		select @csf_shpstrbuf = csf_shpstrbuf, @csf_shpendbuf = csf_shpendbuf, @csf_cancelbuf = csf_cancelbuf
		from CUSHPFML where csf_cus1no = @csf_cus1no and csf_cus2no = @csf_cus2no and csf_venno = @sco_cusven
	end
	else if (select count(*) from CUSHPFML where csf_cus1no = @csf_cus1no and csf_cus2no = @csf_cus2no and csf_venno = @ventyp) = 1
	begin
		select @csf_shpstrbuf = csf_shpstrbuf, @csf_shpendbuf = csf_shpendbuf, @csf_cancelbuf = csf_cancelbuf
		from CUSHPFML where csf_cus1no = @csf_cus1no and csf_cus2no = @csf_cus2no and csf_venno = @ventyp
	end
	else if (select count(*) from CUSHPFML where csf_cus1no = @csf_cus1no and csf_cus2no = '' and csf_venno = @sco_cusven) = 1
	begin
		select @csf_shpstrbuf = csf_shpstrbuf, @csf_shpendbuf = csf_shpendbuf, @csf_cancelbuf = csf_cancelbuf
		from CUSHPFML where csf_cus1no = @csf_cus1no and csf_cus2no = '' and csf_venno = @sco_cusven
	end
	else
	begin
		select @csf_shpstrbuf = csf_shpstrbuf, @csf_shpendbuf = csf_shpendbuf, @csf_cancelbuf = csf_cancelbuf
		from CUSHPFML where csf_cus1no = @csf_cus1no and csf_cus2no = '' and csf_venno = @ventyp
	end


   SET @startflag = 1  
   DECLARE cur_SCORDDTL CURSOR  
   FOR   
   SELECT   
    sod_fcurcde, sod_itmsts,  sod_cusven,   
    sod_purord,  sod_purseq,  sod_cocde,                    
    sod_ordno,  sod_ordseq, sod_updpo,  
    sod_chgfty, sod_itmno,  sod_itmtyp,  
    sod_itmdsc, sod_colcde, sod_cuscol,  
    sod_coldsc, sod_pckseq, sod_pckunt,  
    sod_inrctn,  sod_mtrctn, sod_cft,  
    sod_cbm,  sod_qutno,  sod_refdat,  
    sod_cusitm, sod_cussku, sod_resppo,  
    sod_cuspo,  sod_ordqty, sod_discnt,  
    sod_oneprc, sod_curcde, sod_selprc,  
    sod_hrmcde, sod_dtyrat,  sod_dept,  
    sod_typcode, sod_Code1, sod_Code2,  
    sod_Code3, sod_cususd, sod_cuscad,  
    sod_inrdin,  sod_inrwin, sod_inrhin,  
    sod_mtrdin, sod_mtrwin, sod_mtrhin,  
    sod_inrdcm, sod_inrwcm, sod_inrhcm,  
    sod_mtrdcm, sod_mtrwcm, sod_mtrhcm,  
    sod_shpstr,  sod_shpend, sod_candat,  
    sod_ctnstr,  sod_ctnend, sod_ttlctn,  
    sod_rmk,  sod_invqty, sod_shpqty,  
    sod_ftyprc,  sod_ftycst,  sod_subcde,  
    sod_venitm, sod_pckitr,  sod_oldpurord,  
    sod_oldpurseq,   
    sod_cusven, sod_cussub, sod_pjobno,   
    sod_seccusitm, sod_venno  ,
    sod_alsitmno , sod_alscolcde,
    sod_posstr,	sod_posend, sod_poscan
                                              
   FROM SCORDDTL   
   WHERE   
   sod_ordno = @sco_ordno AND  
   sod_cusven = @sco_cusven AND  
   sod_cocde = @cocde  
   ORDER BY sod_purord DESC, sod_purseq, sod_itmno  
  -- ORDER BY sod_purord DESC, sod_purseq, sod_ordseq   
     
     
   OPEN cur_SCORDDTL  
   FETCH NEXT FROM cur_SCORDDTL INTO   
    @sdt_fcurcde, @sdt_itmsts, @sdt_cusven,   
    @sdt_purord, @sdt_purseq, @sdt_cocde,  
    @sdt_ordno, @sdt_ordseq, @sdt_updpo,  
    @sdt_chgfty, @sdt_itmno, @sdt_itmtyp,  
    @sdt_itmdsc, @sdt_colcde, @sdt_cuscol,  
    @sdt_coldsc, @sdt_pckseq, @sdt_pckunt,  
    @sdt_inrctn, @sdt_mtrctn, @sdt_cft,  
    @sdt_cbm,  @sdt_qutno, @sdt_refdat,  
    @sdt_cusitm, @sdt_cussku, @sdt_resppo,  
    @sdt_cuspo, @sdt_ordqty, @sdt_discnt,  
    @sdt_oneprc, @sdt_curcde, @sdt_selprc,  
    @sdt_hrmcde, @sdt_dtyrat, @sdt_dept,   
    @sdt_typcode, @sdt_Code1, @sdt_Code2,  
    @sdt_Code3, @sdt_cususd, @sdt_cuscad,  
    @sdt_inrdin, @sdt_inrwin, @sdt_inrhin,  
    @sdt_mtrdin, @sdt_mtrwin, @sdt_mtrhin,  
    @sdt_inrdcm, @sdt_inrwcm, @sdt_inrhcm,  
    @sdt_mtrdcm, @sdt_mtrwcm, @sdt_mtrhcm,  
    @sdt_shpstr, @sdt_shpend, @sdt_candat,  
    @sdt_ctnstr, @sdt_ctnend, @sdt_ttlctn,  
    @sdt_rmk,  @sdt_invqty, @sdt_shpqty,  
    @sdt_ftyprc, @sdt_ftycst, @sdt_subcde,  
    @sdt_venitm, @sdt_pckitr, @sdt_oldpurord,   
    @sdt_oldpurseq,  
    @sdt_cusven, @sdt_cussub, @sdt_pjobno,   
    @sdt_seccusitm, @sdt_venno  ,
    @sod_alsitmno, @sod_alscolcde,
    @sdt_posstr,@sdt_posend, @sdt_poscan
  
  
   DECLARE   
   @hdr_upf nvarchar(1),  
   @cur_purord nvarchar(20),  
   @seqno int  
     
   SET @hdr_upf = 'Y'  
  
   WHILE @@fetch_status = 0                              
   BEGIN  
  
    SET @cur_purord = ''  
   -- Add by Solo, 22/02/02  for Keep Seq No if update PO Flag is "N"   
  
    IF @sdt_updpo = 'N'  and @sdt_chgfty = 'N'  
    BEGIN  
     IF @sdt_purord <> '' AND @sdt_purseq <> 0                                                                                                                                                                                                                 
              
        BEGIN      
         SET @cur_purord = @sdt_purord  
      SET @seqno = @sdt_purseq   
         END                                                                                 
    END  
   -----   
    IF @sdt_updpo = 'Y' or @sdt_chgfty = 'Y'  
    BEGIN                                                  
        IF @sdt_purord <> '' AND @sdt_purseq <> 0                                                                                                                                                                                                              
                 
        BEGIN      
         SET @cur_purord = @sdt_purord  
      SET @seqno = @sdt_purseq  
         END                                                                                                                                                                                                                                                   
                  
     ELSE          
     BEGIN  
      IF @cur_purord = ''   
      BEGIN  
       SELECT   
        @cur_purord = poh_purord  
       FROM   
        POORDHDR  
       WHERE   
        poh_cocde = @cocde AND  
        poh_venno = @sco_cusven AND  
        poh_ordno = @sco_ordno  
         
       IF @cur_purord <> ''  
       BEGIN  
        SELECT @seqno = MAX(pod_purseq) + 1  
        FROM POORDDTL  
        WHERE pod_cocde = @cocde AND  
        pod_purord = @cur_purord   
       END  
       ELSE  
       BEGIN  
        EXECUTE sp_select_doc_gen_po @cocde, "PO", @usrid, @purord = @cur_purord OUTPUT                                                                                                                                                                        
                   
        SET @seqno = 1  
       END  
      END  
      ELSE  
      BEGIN  
       SET @seqno = @seqno + 1  
      END  
     END                                                                                                                                                                                                                                                       
     
                
               SET @ret_code = @cur_purord                                                                                                                                                                                                                     
                          
                                                                                                                                                                                                                                                               
          
     UPDATE   
      SCORDDTL   
     SET   
      sod_purord = @ret_code,   
      sod_purseq = @seqno,  
      sod_upddat = GETDATE(),  
      sod_updusr = 'SYSTEM'                                                                                                                                                                                                     
     WHERE   
      sod_cocde = @cocde AND                                                                                                                                                                                                                                   
     
      sod_ordno = @sdt_ordno AND                                                                                                                                                                                                                               
           
      sod_cusven = @sdt_cusven AND                                                                                                                                                                                                                             
             
      sod_itmno = @sdt_itmno AND                                                                                                                                                                                                                               
           
      sod_colcde = @sdt_colcde AND                                                                                                                                                                                                                             
           
      sod_pckseq = @sdt_pckseq AND                                                                                                                                                                                                                             
           
      sod_pckunt = @sdt_pckunt AND                                                                                                                                                                                                                             
           
      sod_inrctn = @sdt_inrctn AND                                                                                                                                                                                                                             
           
      sod_mtrctn = @sdt_mtrctn AND  
      sod_cft = @sdt_cft                                                                                                                                                                                                                                       
     
                                                                                                                                                                                                                                                               
          
     SELECT   
      @poh_discnt = vbi_discnt,                                                                                                                                                                                                                                
    
      @vbi_tsttim = vbi_tsttim,                                                                                                                                                                                                                                
           
      @vbi_bufday = vbi_bufday,  
      @poh_paytrm = vbi_paytrm,  
      @poh_prctrm = vbi_prctrm,  
      @poh_curcde = vbi_curcde                                                                                                                                                                                                                                 
           
     FROM   
      VNBASINF                                                                                                                                                                                                                                                 
      
     WHERE   
     --vbi_cocde = @cocde AND                                                                                                                                                                                                                                  
      
     vbi_venno = @sco_cusven                                                                                                                                                                                                                                   
           
       
     IF @sdt_updpo = 'Y'  or @sdt_chgfty = 'Y'   
     BEGIN  
    --  DELETE FROM POORDDTL  
    --  WHERE pod_cocde = @cocde AND   
    --  pod_purord = @ret_code AND  
    --  pod_purseq = @seqno  
        
      DELETE FROM PODTLSHP  
      WHERE pds_cocde = @cocde AND   
      pds_purord = @ret_code AND  
      pds_seq = @seqno  
         
      DELETE FROM PODTLCTN  
      WHERE pdc_cocde = @cocde AND   
      pdc_purord = @ret_code AND  
      pdc_seq = @seqno  
        
      DELETE FROM PODTLASS  
      WHERE pda_cocde = @cocde AND   
      pda_purord = @ret_code AND  
      pda_seq = @seqno  
  
      --- Reset all BOM item order qty to 0 ---  
      UPDATE PODTLBOM   
      SET PDB_ORDQTY = 0  
      WHERE pdb_cocde = @cocde AND   
      pdb_purord = @ret_code AND  
      pdb_seq = @seqno  
        
     END                                                                                                                                                                                                                                                       
          
                                                                                                                                                                                                                                                               
          
     -- INSERT NEW PO HEADER                                                                                                                                                                                                                                   
          
     IF (@sdt_updpo = 'Y' AND @hdr_upf = 'Y') or (@sdt_chgfty = 'Y' AND @hdr_upf = 'Y')                                                                                                                                                                        
                                                                       
     BEGIN  
  --    DELETE FROM POORDHDR   
  --    WHERE poh_cocde = @cocde AND   
  --    poh_purord = @ret_code  
        
      DELETE FROM POSHPMRK  

      WHERE psm_cocde = @cocde AND   
      psm_purord = @ret_code  
        
      DELETE FROM POCNTINF  
      WHERE pci_cocde = @cocde AND   
      pci_purord = @ret_code  
                                                                                                                                                                                                                                                               
     
      SELECT @poh_puradr = ct.vci_adr,     
      -- Added by Mark Lau 20081202
      @poh_purchnadr = isnull(ct.vci_chnadr,''),
      @poh_purstt = isnull(ct.vci_stt,''),
      @poh_purcty = isnull(ct.vci_cty,''),
      @poh_purpst = isnull(ct.vci_zip,''),
      @poh_porctp = isnull(cp.vci_cntctp, '')
      FROM VNCNTINF ct
	left join VNCNTINF cp on ct.vci_venno = cp.vci_venno and cp.vci_cntdef = 'Y' and cp.vci_cnttyp = 'GENL'

      WHERE   
       ct.vci_cnttyp = 'M' and  
       ct.vci_venno = @sco_cusven  
  
      SELECT   
       @poh_puragt = soh_agt,                                                                                                                                                                                                                                  
 
       @poh_salrep = soh_salrep,                                                                                                                                                                                                                               
        
       @poh_prmcus = soh_cus1no,                                                                                                                                                                                                                               
        
       @poh_seccus = soh_cus2no,                                                                                                                                                                                                                               
        
       @poh_shpadr = soh_biladr,                                                                                                                                                                                                                               
        
       @poh_shpstt = soh_bilstt,                                                                                                                                                                                                                               
        
       @poh_shpcty = soh_bilcty,                                                                                                                                                                                                                               
        
       @poh_shppst = soh_bilzip,                                                                                                                                                                                                                               
                                                                                                                                                                                                                                            
       @poh_ttlcbm = soh_ttlvol,                                                                                                                                                                                                                               
        
       @poh_ttlctn = soh_ttlctn,                                                                                                                                                                                                                               
                                                                                                                                                                                                                         
       @poh_ttlamt = soh_ttlamt,                                                                                                                                                                                                                               
        
       @poh_spoflg = soh_smpsc,                                                                                                                                                                                                                                
        
       @poh_cuspno = soh_cuspo,                                                                                                                                                                                                                                
        
       @poh_cpodat = soh_cpodat,                                                                                                                                                                                                                               
        
       @poh_reppno = soh_resppo,                                                                                                                                                                                                                               
        
       @poh_lbldue = soh_lbldue,                                                                                                                                                                                                                               
        
       @poh_lblven = soh_lblven,                                                                                                                                                                                                                               
        
       @poh_issdat = soh_issdat,                                                                                                                                                                                                                               
        
       @poh_pocdat = soh_candat,                                                                                                                                                                                                                               
        
       @poh_shpstr = soh_shpstr,                                                                                                                                                                                                                               
        
       @poh_shpend = soh_shpend,  
      -- @sco_rmk = soh_rmk            
       @poh_rmk = soh_rmk,
       @poh_cusctn = soh_cusctn,
       @poh_dest = soh_dest
      FROM   
       SCORDHDR  
      WHERE   
       soh_cocde = @cocde AND  
       soh_ordno = @sdt_ordno                                                                                                                                                                                                                                  
        
                                                                                                                                                                                                                                                       
       
      IF @poh_pocdat <> '1900-01-01'  
      BEGIN  
--       SET @poh_pocdat = @poh_pocdat - @vbi_tsttim - @vbi_bufday
       SET @poh_pocdat = @poh_pocdat - @csf_cancelbuf
      END  
--      SET @poh_shpstr = @poh_shpstr - @vbi_tsttim - @vbi_bufday
--      SET @poh_shpend = @poh_shpend - @vbi_tsttim - @vbi_bufday
	SET @poh_shpstr = @poh_shpstr - @csf_shpstrbuf
	SET @poh_shpend = @poh_shpend - @csf_shpendbuf
                                                                                                                                                                                                                                                               
/*       
      IF GETDATE() > @poh_pocdat AND @poh_pocdat <> '1900-01-01'                                                                                                                                                                                               
                                        
      BEGIN                                                                                                                                                                                                                                                    
       
       SET @poh_pocdat = GETDATE()                                                                                                                                                                                                                             
    
      END  
        
      IF GETDATE() > @poh_shpstr                                                                                                                                                                                                                               
       
      BEGIN                                                                                                                                                                                                                                                    
       
       SET @poh_shpstr = GETDATE()                                                                                                                                                                                                                             

    
      END                                                                                                                                                                                                                                                      
       
                                                                                                                                                                                                                                                               
       
      IF GETDATE() > @poh_shpend                                                                                                                                                                                                                               
       
      BEGIN                                                                                                                                                                                                                                                    
       
       SET @poh_shpend = GETDATE()                                                                                                                                                                                                                             
    
      END                                                                                                                                                                                                                                                      
*/       
        
      ---- Preset the Ship Start Date & Stop Date as today ----  
      ---SET @poh_shpend = @ShpStartDate   
      ---SET @poh_shpstr = @ShpEndDate   
      ------------------------------------------------------------------                                                                                                                                                                                       
                                                                          
      SET @poh_cocde = @cocde                                                                                                                                                                                                                                  
      
      SET @poh_purord = @ret_code                                                                                                                                                                                                                              
       
      SET @poh_pursts = 'OPE'                                                                                                                                                                                                                                  
       
      SET @poh_venno = @sco_cusven                                                                                                                                                                                                                             
       
  
      UPDATE   
       POORDHDR   
      SET   
       poh_pursts = @poh_pursts,  
       poh_issdat = GETDATE(),                                                                                                                                                                                                                                 
                     
       poh_spoflg = @poh_spoflg,                                                                                                                                                                                                                               
                     
       poh_cuspno = @poh_cuspno,                                                                                                                                                                                                                               
                     
       poh_cpodat = @poh_cpodat,                                                                                                                                                                                                                               
                     
       poh_reppno = @poh_reppno,   
       poh_curcde = @poh_curcde,                                                                                                                                                                                                                               
                    
--       poh_pocdat = @poh_pocdat,                                                                                                                                                                                                                               
                     
--       poh_shpstr = @poh_shpstr,                                                                                                                                                                                                                               
                     
--       poh_shpend = @poh_shpend,                                                                                                                                                                                                                               
                     
       poh_updusr = @usrid,                                                                                                                                                                                                                                  
                     
       poh_subcde = ''                                                                                                                                                                                                                                         
                  
      WHERE   
       poh_cocde = @cocde AND   
       poh_purord = @ret_code  
  
      IF @@rowcount = 0   
      BEGIN                                                                                                                                                                                                                                                
       INSERT INTO POORDHDR (                                                                                                                                                                                                                                  
        
       poh_cocde,                                                                                                                                                                                                                                              
       
       poh_purord,                                                                                                                                                                                                                                             
        
       poh_pursts,                                                                                                                                                                                                                                             
        
       poh_issdat,                                                                                                                                                                                                                                             
        
       poh_venno,                                                                                                                                                                                                                                              
       
       poh_puradr,                                                                                                                                                                                                                                             
        
       poh_purstt,                                                                                                                                                                                                                                             
        
       poh_purcty,                                                                                                                                                                                                                                             
        
       poh_purpst,                                                                                                                                                                                                                                             
        
       poh_porctp,                                                                                                                                                                                                                                             
        
       poh_puragt,                                                                                                                                                                                                                                             
        
       poh_salrep,                                                                                                                        
       poh_prmcus,                                                                                                                                                                                                                                            
         
       poh_seccus,                                                                                                                                                                                                                                             
        
       poh_shpadr,                                                                                                                                                                                                                                             
        
       poh_shpstt,                                                                                                                                                                                                                                             
        
       poh_shpcty,                                                                                                                                                                                                                                             
        
       poh_shppst,                                                                                                                                                                                                                                             
        
       poh_prctrm,                                                                                                                                                                                                                                             
        
       poh_paytrm,                                                                                                                                                                                                                                             
        
       poh_ttlcbm,                                                                                                                                                                                                                                             
        
       poh_ttlctn,                                                                                                                                                                                                                                             
        
       poh_curcde,                                                                                                                                                                                                                                             
        
       poh_ttlamt,                                                                                                                                                                                                                                             
        
       poh_discnt,                                                                                                                                                                                                                                             
        
       poh_spoflg,                                                                                                                                                                                                                                             
        
       poh_cuspno,                                                                                                                                                                                                                                             
        
       poh_cpodat,                                                                                                                                                                                                                                             
        
       poh_reppno,                                                                                                                                                                                                                                             
        
       poh_pocdat,                                                                                                                                                                                                                                             
        
       poh_shpstr,                                                                                                                                                                                                                                             
        
       poh_shpend,                                                                                                                                                                                                                                             
        
       poh_lbldue,                                                                                                                                                                                                                                             
        
       poh_lblven,                                                                                                                                                                                                                                             
        
       poh_netamt,                                                                                                                                                                                                                                             
        
       poh_creusr,                                                                                                                                                                                                                                             
        
       poh_updusr,                                                                                                                                                                                                                                             
        
       poh_subcde,                                                                                                                                                                                                                                             
        
       poh_rmk,                                                                                                                                                                                                                                                
        
       poh_ordno ,
      -- Added by Mark Lau 20081202
      poh_purchnadr,
	poh_cusctn, 
        poh_dest,
	poh_signappflg,
	poh_prctrmflg,
	poh_paytrmflg,
	poh_lastprctrm,
	poh_lastpaytrm
       ) VALUES (                                                                                                                                                                                                                                              
        
       @cocde,                                                                                                                                                                                                                                                 
        
       @ret_code,                                                                                                                                                                                                                                              
        
       @poh_pursts,                                                                                                                                                                                                                                            
        
       GETDATE(),                                                                                                                                                                                                                                              
        
       @poh_venno,                                                                                                                                                                                                                                             
        
       @poh_puradr,                                                                                                                                                                                                                                            
        
       @poh_purstt,  
       @poh_purcty,                                                                                                                                                                                                                                            
        
       @poh_purpst,                                                                                                                                                                                                                                            
        
       @poh_porctp,                                                                                                                                                                                                                                            
        
       @poh_puragt,                                                                                                                                                                                                                                            
        

       @poh_salrep,                                                                                                                                                                                                                                            
        
       @poh_prmcus,                                                                                                                                                                                                                                            
        
       @poh_seccus,                                                                                                                                                                                                                                            
        
       @poh_shpadr,                                                                                                                                                                                                                                            
        
       @poh_shpstt,                                                                                                                                                                                                                                            
        
       @poh_shpcty,                                                                                                                                                                                                                                            
        
       @poh_shppst,                                                                                                                                                                                                                                            
   
       @poh_prctrm,                                                                                                                                                                                                                                            
        
       @poh_paytrm,                                                                                                                                                                                                                                            
        
       @poh_ttlcbm,                                                                                                                                                                                                                                            
        
       0,                                                                                                                                                                                                                                                    
       @poh_curcde,                                                                                                                                                                                                                                            
        
       0,                                                                                                                                                                                                                                                    
       @poh_discnt,                                                                                                                                                                                                                                            
        
       @poh_spoflg,                                                                                                                                                                                                                                            
        
       @poh_cuspno,                                                                                                                                                                                                                                            
        
       @poh_cpodat,                                                                                                                                                                                                                                            
        
       @poh_reppno,                                                                                                                                                                                                                                            
        
       @poh_pocdat,                                                                                                                                                                                                                                            
        
       @poh_shpstr,                                                                                                                                                                                                                                            
        
       @poh_shpend,                                                                                                                                                                                                                                            
        
       @poh_lbldue,                                                                                                                                                                    
       @poh_lblven,                                                                                                                                                                                                                                           
         
       0,                                                                                                                                                                                                                                                      
        
       @usrid,                                                                                                                                                                                                                                               
        
       @usrid, 
        
       '',                                                                                                                                                                                                                                                    
       @poh_rmk,                                                                                                                                                                                                                                               
              
       @sco_ordno  ,
      -- Added by Mark Lau 20081202
      @poh_purchnadr,
      @poh_cusctn,
      @poh_dest,
	'Y',
	'',
	'',
	@poh_prctrm,
	@poh_paytrm
       )                                                                                                                                                                                                                                               
                                                                                                                                                                                                                                                               
        
       IF @@ERROR <> 0                                                                                                                                                                                                                                         
        
       BEGIN  
           -- Return 99 to the calling program to indicate failure.                                                                                                                                                                                            
         
           PRINT 'An error occurred when inserting into POORDHDR'                                                                                                                                                                                              
         
           RETURN(99)  
          END  
      END                                                                                                                                                                                                                                                      
       
                                                                                                                                                                                                                                                               
       
      SELECT                                                                                                                          
      @pci_csenam = sci_csenam,                                                                                                                                                                                                                               
        
      @pci_cseadr = sci_cseadr,                                                                                                                                                                                                                                
       
      @pci_csestt = sci_csestt,                                                                                                                                                                                                                                
       
      @pci_csecty = sci_csecty,                                                                                                                                                                                                                                
       
      @pci_csezip = sci_csezip,                                                                                                                                                                                                                                
       
      @pci_fwdtyp = sci_fwdtyp,                                                                                                                                                                                                                                
       
      @pci_fwdacc = sci_fwdno ,                                                                                                                                                                                                                                
       
      @pci_fwddsc = sci_fwddsc,                                                                                                                                                                                                                                
       
      @pci_fwditr = sci_fwditr,                                                                                                                                                                                                                                
       
      @pci_noptyp = sci_noptyp,                                                                                                                                                                                                                                
       
      @pci_nopadr = sci_nopadr,                                                                                                                                                                                                                                
       
      @pci_nopstt = sci_nopstt,                                                                                                                                                                                                                                
       
      @pci_nopcty = sci_nopcty,                                                                                                                                                                                                                                
       
      @pci_nopzip = sci_nopzip,                                                                                                                                                                                                                                
       
      @pci_noptil = sci_noptil,                                                                                                                                                                                                                                
        
      @pci_nopphn = sci_nopphn,                                                                                                                                                                                                                                
       
      @pci_nopfax = sci_nopfax,                                                                                                                                                                                                                                
       
      @pci_nopeml = sci_nopeml                                                                                                                                                                                                                                 
       
      FROM SCCNTINF                                                                                                                                                                                                                                            
       
      WHERE sci_cocde = @cocde AND                                                                                                                                                                                                                             
       
      sci_ordno = @sdt_ordno                                                                                                                                                                                                                                   
       
                                                                                                                                                                                                                                                               
                      
      INSERT INTO POCNTINF (                                                                                                                                                                                                                                   
       
      pci_cocde,                                                                                                                                                                                                                                               
      
      pci_purord,                                                                                                                                                                                                                                              
       
      pci_csenam,                                                                                                                                                                                                                                              
       
      pci_cseadr,                                                                                                                                                                                                                                              
       
      pci_csestt,                                                                                                                                                                                                                                              
       
      pci_csecty,                                                                                                                                                                                                                                              
       
      pci_csezip,                                                                                                                                                                                                                                              
       
      pci_fwdtyp,                                                                                                                                                                                                                                              
       
      pci_fwdacc,                                                                                                                                                                                                                                              
       
      pci_fwddsc,                                                                                                                                                                                                                                              
       
      pci_fwditr,                                                                                                                                                                                                                                              
       
      pci_noptyp,                                                                                                                                                                                                                                              
       
      pci_nopadr,                                                                                                                                                                                                                                              
       
      pci_nopstt,                                                                                                                                                                                                                                              
       
      pci_nopcty,                                                                                                                                                                                                                                              
       
      pci_nopzip,                                                                                                                                                                                                                                              
       
      pci_noptil,                                                                                                                                                                                                                                              
       
      pci_nopphn,                                                                                                                                                                                                                                              
       
      pci_nopfax,                                                                                                                                                                                                                                              
       
      pci_nopeml,                                                                                                                                                                                                                                              
       
      pci_creusr,                                                                                                                                                                                                                                              
       
      pci_updusr                                                                                                                                                                                                                                               
       
      ) VALUES (                                                                                                                                                                                             
      @cocde,                                                                                                                                                                                                                                                 
        
      @ret_code,                                                                                                                                                        
      @pci_csenam,                                                                                                                                                    
      @pci_cseadr,                                                                                                                                                    
      @pci_csestt,                                                                                                                                                    
      @pci_csecty,                                                                                                                                                    
      @pci_csezip,                                                                                                                                                    
      @pci_fwdtyp,                                                                                                                                                    
      @pci_fwdacc,                                                                                                                                                    
      @pci_fwddsc,                                                                                                                                                        

      @pci_fwditr,                                                                                                                                                        
      @pci_noptyp,                                                                                                                                                        
      @pci_nopadr,                                                                                                                                                        
      @pci_nopstt,                                                                                                                                                        
      @pci_nopcty,                                                                                                                                                            
      @pci_nopzip,                                                                                                                                                            
      @pci_noptil,                                                                                                                                                            
      @pci_nopphn,                                                                                                                                                            
      @pci_nopfax,                                                                                                                                                            
      @pci_nopeml,                                                                                                                                                                                                                                             
       
     @usrid, 
       
      @usrid 
       
      )                                                                                                                                                                                                                                                        
       
                                                                                                                                                                                                                                                               
       
      IF @@ERROR <> 0                                                                                                                                                                                                                                          
       
      BEGIN                                                                                                                                                                                                                                                    
       
         -- Return 99 to the calling program to indicate failure.                                                                                                                                                                                              
       
         PRINT 'An error occurred when inserting into POCNTINF'                                                                                                                                                                                                
       
         RETURN(99)                                                                                                                                                                                                                                            
       
      END    
        
      DECLARE cur_SCSHPMRK CURSOR  
      FOR SELECT   
      ssm_shptyp,  
      ssm_engdsc,  
      ssm_chndsc,  
      ssm_engrmk,  
      ssm_chnrmk,  
      ssm_imgpth,  
      ssm_imgnam  
      FROM SCSHPMRK  
      WHERE  
      ssm_cocde = @cocde AND  
      ssm_ordno = @sco_ordno   
       
      OPEN cur_SCSHPMRK  
      FETCH NEXT FROM cur_SCSHPMRK INTO   
      @psm_shptyp,   
      @psm_engdsc,   
      @psm_chndsc,   
      @psm_engrmk,   
      @psm_chnrmk,   
      @psm_imgpth,   
      @psm_imgnam   
        
      WHILE @@fetch_status = 0  
      BEGIN  
       
       INSERT INTO POSHPMRK(  
       psm_cocde,  
       psm_purord,  
       psm_shptyp,   
       psm_engdsc,  
       psm_chndsc,  

       psm_engrmk,  
       psm_chnrmk,  
       psm_imgpth,  

       psm_imgnam,  
       psm_creusr,  
       psm_updusr  
       ) VALUES (  
       @cocde,  
       @ret_code,  
       @psm_shptyp,  
       @psm_engdsc,  
       @psm_chndsc,  
       @psm_engrmk,  
       @psm_chnrmk,  
       @psm_imgpth,  
       @psm_imgnam,  
      @usrid , 
      @usrid 
       )  
         
       IF @@ERROR <> 0   
       BEGIN  
          -- Return 99 to the calling program to indicate failure.  
          PRINT 'An error occurred when inserting into POSHPMRK'  
          RETURN(99)  
       END   
            
       FETCH NEXT FROM cur_SCSHPMRK INTO   
       @psm_shptyp,   
       @psm_engdsc,   
       @psm_chndsc,   
       @psm_engrmk,   
       @psm_chnrmk,   
       @psm_imgpth,   
       @psm_imgnam   
        
      END  
      CLOSE cur_SCSHPMRK                                     
      DEALLOCATE cur_SCSHPMRK     
      
      SET @hdr_upf = 'N'                                                                                                                                                                                                                                       
                          
     END                                                                                                                                                                                                                                                       
          
        
     SET @pod_jobord = ''    
     set @pod_runno = ''  
     If @sdt_oldpurord <> ''   
     BEGIN  
      select   
       @pod_jobord = pod_jobord,  
       @pod_runno = pod_runno,  
       @sdt_rmk = pod_rmk  
         
      FROM POORDDTL  
      WHERE   
       pod_cocde = @cocde  
      AND   pod_purord = @sdt_oldpurord  
      AND   pod_purseq = @sdt_oldpurseq  
     END  
                                                                                                                                                                                                                                        
     SET @pod_cocde  = @cocde                                                                                                                                                                                                                                  
          
     SET @pod_purord = @ret_code                                                                                                                                                                                                                               
          
     SET @pod_purseq = @seqno                                                                                                                                                                                                                                  
          
     SET @pod_itmno  = @sdt_itmno                                                                                                                                                                                                                              
          
     SET @pod_cusitm = @sdt_cusitm                                                                                                                                                                                                                             
          
     SET @pod_cussku = @sdt_cussku  
     SET @pod_engdsc = @sdt_itmdsc  
  
          --- Allan Yuen added at 2005-06-01  
     SET @pod_prdven = @sdt_venno  
     SET @pod_prdsubcde = @sdt_subcde  
     SET @pod_seccusitm = @sdt_seccusitm  
  
       
     SET @pod_vencol = ''                                                                                                                                                                                                                                      
                              
     SELECT @pod_vencol = icf_vencol                                                                                                                                                                                                              
     FROM IMCOLINF                                                                                                                                                                                                                                             
          
     WHERE   
     --icf_cocde = @cocde AND                                                                                                                                                                                                                                  
      
     icf_itmno = @sdt_itmno AND                                                                                                                                                                                                                                
          
     icf_colcde = @sdt_colcde  
     --icf_vencol = @sdt_colcde  
  
     if @pod_vencol is NULL or @pod_vencol = ''  
     begin  
      Set @pod_vencol = @sdt_colcde  
     end                                                                                                                                                                                    
                                   
                                   SELECT @pod_chndsc = ibi_chndsc  
                                   FROM IMBASINF  
                                   WHERE   
       --ibi_cocde = @cocde AND  
                                   ibi_itmno = @sdt_itmno   
                                                                                                                                                                                                                                                              
                       
     -- SET @pod_vencol =                                                                                                                                                                                                                                      
          
     SET @pod_cuscol = @sdt_cuscol                                                                                                                                                                                                                             
          
     SET @pod_coldsc = @sdt_coldsc                                                                                                                                                                                                                             
          
     SET @pod_pckseq = @sdt_pckseq                                                                                                                                                                                                                             
          
     SET @pod_untcde = @sdt_pckunt                                                                                                                                                                                                                             
          
     SET @pod_inrctn = @sdt_inrctn                                                                                                                                                                                                                             
          
     SET @pod_mtrctn = @sdt_mtrctn                                                                                                                                                                                                                             
          
     SET @pod_cubcft = @sdt_cft                                                                                                                                                                                                                                
          
     SET @pod_cbm    = @sdt_cbm                                                                                                                                                                                                                                
          
     SET @pod_dept   = @sdt_dept                                                                                                                                                                                                                               
          
     SET @pod_ordqty = @sdt_ordqty                                                                                                                                                                                                                             
          
     SET @pod_recqty = @sdt_shpqty          
       
     execute SP_SELECT_EXRATE @cocde, @sdt_fcurcde, @poh_curcde, "B", @return_rate = @rate output                                                                                                                                                              
                                                                                                                                                                                                                                                               
                                               
------------------------------------------       
     select @VendorType = vbi_ventyp  
     from vnbasinf where vbi_venno = @sdt_cusven  
     /*  
     --IF @cocde = 'UCPP'  
     --BEGIN  
     -- SET @pod_ftyprc = @sdt_ftyprc * @rate                                                                                                                                                                                                                  
                    
     --END  
     --ELSE  
     --BEGIN  
     -- SET @pod_ftyprc = @sdt_ftycst * @rate  
     --END  
     */  
  
     -- Allan Yuen Change the logic of factory cost retrive at 15/09/2004  
     SET @pod_ftyprc = @sdt_ftycst * @rate  
     --IF @COCDE = 'UCPP'   
     -- SET @pod_ftyprc = @sdt_ftyprc * @rate  
     --ELSE  
     -- IF @VendorType = 'I' or @VendorType = 'J'   
     --  SET @pod_ftyprc = @sdt_ftyprc * @rate  
     -- ELSE   
     --  SET @pod_ftyprc = @sdt_ftycst * @rate  
  
--     print @VendorType   
--     print @pod_ftyprc   
-------------------------------------------  
     SET @pod_cuspno = @sdt_cuspo                                                                                                                                                                                                                              
          
     SET @pod_respno = @sdt_resppo                                                                                                                                                                                                                             
          
     SET @pod_hrmcde = @sdt_hrmcde                                                                                                                                                                                                                             
          
     SET @pod_lblcde = @sdt_code1 + @sdt_code2 + @sdt_code3                                                                                                                                                                                                    
          
     SET @pod_cususd = @sdt_cususd                                                                                                                                                                                                                             
          
     SET @pod_cuscad = @sdt_cuscad                                                                                                                                                                                                                             
  

        
	--SET @pod_shpstr = @sdt_shpstr - @vbi_tsttim - @vbi_bufday
	--SET @pod_shpend = @sdt_shpend - @vbi_tsttim - @vbi_bufday 



	--SET @pod_shpstr = @sdt_shpstr - @csf_shpstrbuf
	if @sdt_posstr <> '1900-01-01'
	begin
		set @pod_shpstr = @sdt_posstr
	end
	else
	begin
		set @pod_shpstr = @sdt_shpstr - @csf_shpstrbuf
	end


	--SET @pod_shpend = @sdt_shpend - @csf_shpendbuf 
	if @sdt_posend <> '1900-01-01'
	begin
		set @pod_shpend = @sdt_posend
	end
	else
	begin
		set @pod_shpend = @sdt_shpend - @csf_shpendbuf
	end


 
     SET @pod_candat = @sdt_candat                                                                                                                                                                                                           
     IF @sdt_candat <> '1900-01-01'  
     BEGIN  
--      SET @pod_candat = @sdt_candat - @vbi_tsttim - @vbi_bufday
      SET @pod_candat = @sdt_candat - @csf_cancelbuf
     END  
/*
     IF GETDATE() > @pod_candat AND @pod_candat <> '1900-01-01'                                                                                                                                                                                                
                                          
     BEGIN                                                                                                                                                                                                                                                     
          
      SET @pod_candat = GETDATE()                                                                                                                                                                                                                              
       
     END                                                                                                                                                                                                                                                       
          
                                                                                                                                                                                                                                                               
          
     IF GETDATE() > @pod_shpstr                                                                                                                                                                                                                                
          
     BEGIN                                                                                                                                                                                                                                                     
          
      SET @pod_shpstr = GETDATE()                                                                                                                                                                                                                              
        
     END                                                                                                                                                                                                                                                       
          
                                                                                                                                                                                                                                                               
          
     IF GETDATE() > @pod_shpend                                                                                                                                                                                                                                
          
     BEGIN                                                                                                                                                                                                                                                     
          
      SET @pod_shpend = GETDATE()                                                                                                                                                                                                                              
       
     END                                                                                                                                                                                                                                                       
*/          
                                                                                                                                                                                                                                                               
       
     SET @pod_ctnstr = @sdt_ctnstr                                                                                                                                                                                                                             
          
     SET @pod_ctnend = @sdt_ctnend                                                                                                                                                                                                                             
          
     SET @pod_scno   = @sdt_ordno                                                                                                                                                                                                                              
          
     SET @pod_ttlctn = @sdt_ttlctn                                                                                                                                                                                                                             
          
   --  SET @pod_lneamt = @sdt_ordqty * @sdt_ftyprc                                                                                                                                                                                                             
                                                                                                                                                                                                                                                           
-- AY Fix the Round Error at 06/12/2003  
     SET @pod_lneamt = round(@sdt_ordqty * @pod_ftyprc,2)                                                                                                                                                                                                      
     SET @pod_lnecub = @sdt_cft * @sdt_ttlctn                                                                                                                                                                                                                            
------------------------------------------------  
     SET @pod_ttlqty = 0                                                                                                                                                                                                                                       
          
     SET @pod_scline = @sdt_ordseq                                                                                                                                                                                                                             
          
    -- SET @pod_jobord = ''                                                                                                                                                                                                                                    
            
     SET @pod_assflg = ''                                                                                                                                                                                                                                      
          
     SET @dtyrat     = @sdt_dtyrat                                                                                                                                                                                                                             
          
     SET @typcode    = @sdt_typcode                                                                                                                                                                                                                            
          
     SET @Code1      = @sdt_Code1                                                                                                                                                                                                                              
          
     SET @Code2      = @sdt_Code2                                                                                                                                                                                                                              
          
     SET @Code3      = @sdt_Code3  
     SET @pod_venitm = @sdt_venitm                                                                                                                                                                                                                             
           
     SET @pod_pckitr = @sdt_pckitr        
       
     IF @sdt_updpo = 'Y'   
     BEGIN    

 select 
 @jobord = isnull(pod_jobord,''),
 @poftyprc = isnull(pod_ftyprc,0),
 @polneamt = isnull( pod_lneamt,0),
 @scno = isnull(pod_scno,''),
 @scseq = isnull(pod_scline,0),
@popv = isnull(pod_prdven,'')
from POORDDTL
WHERE pod_cocde = @cocde AND   
pod_purord = @ret_code AND  
pod_purseq = @seqno  

       
      UPDATE POORDDTL SET  
      pod_itmsts = @sdt_itmsts,  
      pod_venitm = @pod_venitm,  
      pod_cusitm = @pod_cusitm,  
      pod_cussku = @pod_cussku,  
      pod_engdsc = @pod_engdsc,  
     -- pod_chndsc = @pod_chndsc,  
     -- pod_vencol = @pod_vencol,  
      pod_cuscol = @pod_cuscol,  
      pod_coldsc = @pod_coldsc,  
      pod_cbm    = @pod_cbm,  
      pod_cubcft = @pod_cubcft,  
      pod_dept   = @pod_dept,  
      pod_ordqty = @pod_ordqty,  
      pod_ftyprc = @pod_ftyprc,  
      pod_cuspno = @pod_cuspno,  
      pod_respno = @pod_respno,  
      pod_hrmcde = @pod_hrmcde,  
      pod_lblcde = @pod_lblcde,  
      pod_cususd = @pod_cususd,  
      pod_cuscad = @pod_cuscad,  
--      pod_shpstr = @pod_shpstr,  
--      pod_shpend = @pod_shpend,  
--      pod_candat = @pod_candat,  
      pod_ctnstr = @pod_ctnstr,  
      pod_ctnend = @pod_ctnend,  
      pod_ttlctn = @pod_ttlctn,  
      pod_lneamt = @pod_lneamt,  
      pod_lnecub = @pod_lnecub,  
      pod_ttlqty = @pod_ttlqty,  
      pod_assflg = @pod_assflg,  
      pod_dtyrat = @dtyrat,  
      pod_typcode= @typcode,  
      pod_Code1  = @Code1,  
      pod_Code2  = @Code2,  
      pod_Code3  = @Code3,  
     -- pod_creusr = 'SYSTEM',  
      pod_updusr = @usrid,  
      pod_pckitr  = @pod_pckitr ,  
      pod_prdven  = @pod_prdven,   
      pod_tradeven = @sco_cusven,
      pod_examven = @sco_cusven,
      pod_prdsubcde = @pod_prdsubcde,  
      pod_seccusitm = @pod_seccusitm  , 
     -- pod_jobord = @pod_jobord                                                                                                                                                                                                                               
      --Lester Wu 2006-09-26
      pod_alsitmno = @sod_alsitmno , 
      pod_alscolcde = @sod_alscolcde

                                 --      pod_rmk = @sdt_rmk                                                                                                                                                                                     
      WHERE pod_cocde = @cocde AND   
      pod_purord = @ret_code AND  
      pod_purseq = @seqno   
      
  
      IF @@rowcount = 0   
      BEGIN    
                                                                                                                                                                                                                                           
      -- INSERT NEW PO DETAIL                                                                                                                                                                                                                                  
           
      INSERT INTO POORDDTL (                                                                                                                                                                                                                                           
      pod_cocde,                                                                                                                                                                                                                                               
      pod_purord,                                                                                                                                                                                                                                              
      pod_purseq,                                                                                                                                                                                                                                              
      pod_itmno,                                                                                                                                                                                                                                               
      pod_itmsts,                                                                                                                                                                                                                                              
      pod_venitm,                                                                                                                                                                                                                                              
      pod_cusitm,                                                                                                                                                                                                                                              
      pod_cussku,                                                                                                                                                                                                                                              
       pod_engdsc,                                                                                                                                                                                                                                              
     pod_chndsc,                                                                                                                                                                                                                                              
      pod_vencol,                                                                                                                                                                                                                                              
     pod_cuscol,                                                                                                                                                                                                                                              
      pod_coldsc,                                                                                                                                                                                                                                              
      pod_pckseq,                                                                                                                                                                                                                                              
      pod_untcde,                                                                                                                                                                                                                                              
      pod_inrctn,                                                                                                                                                                                                                                              
      pod_mtrctn,                                                                                                                                                                                                                                              
                                                                                                                                                                                                                                                               
                                                    
      pod_cubcft,                                                                                                                                                                                                                                              
                                                                                                                                                                                                                                                               
                                                    
      pod_cbm,                                                                                                                                                                                                                                                 
                                                                                                                                                                                                                                                               
                                                    
      pod_dept,                                                                                                                                                                                                                                                
                                                                                                                                                                                                                                                               
                                                    
      pod_ordqty,                                                                                                                                                                                                                                              
                                                                                                                                                                                                                                                               
                                                    
      pod_recqty,                                                                                                                                                                                                                                              
                                                                                                                                                                                                                                                               
                                                    
      pod_ftyprc,                                                                                                                                                                                                                                              
                                                                                                                                                                                                                               
      pod_cuspno,                                                                                                                                                                                                                                              
                                                                                                                                                                                                                                                               
                                                    
      pod_respno,                                                                                                                                                                                                                                              
                                                                                                                                                                                                                                                               
                                                    
      pod_hrmcde,                                                                                                                                                                                                                                              
                                                                                                                                                                                                                                                               
                                                    
      pod_lblcde,                                                                                                                                                                                                                                              
                                                                                                                                                                                                                                                               
                                                    
      pod_cususd,                                                                                                                                                                                                                                              
                                                                                                                                                                                                                                                               
                                                    
      pod_cuscad,                                                                                                                                                                                                                                              
                                                                                                                                                                                                                                                               
                                                    
      pod_shpstr,                                                                                                                                                                                                                                              
                                                                                                                                                                                                                                                               
                                                    
      pod_shpend,                                                                                                                                                                                                                                              
                                                                                                                                                                                                                                                               
                                                    
      pod_candat,                                                                                                                                                                                                                                              
                                                                                                                                                                                                                                                               
                                                    
      pod_ctnstr,                                                                                                                                                                                                                                              
                                                                                                                                                                                                                                                               
                                                    
      pod_ctnend,                                                                                                                                                                                                                                              
                                                                                                                                                                                                                                                               
                                                    
      pod_scno,                                                                                                                                                                                                                                                
                                                                                                                                                                                                                                                               
                                                    
      pod_ttlctn,                                                                                                                                                                                                                                              
                                                                                                                                                                                                                                                               
                                                    
      pod_lneamt,                                                                                                                                                                                                                                              
                                                                                                                                                                                                                                                               
                                                    
      pod_lnecub,                                                                                                                                                                                                                                              
                                                                                                                                                                                                                                                               
                                                    
      pod_ttlqty,                                                                                                                                                                                                                                              
                                                                                                                                                                                                                                                               
                                                    
      pod_scline,                                                                                                                                                                                                                                              
                                                                                                                                                                                                                                                               
                                                    
      pod_jobord,                                                                                                                                                                                                                                              
                                                                                                                                                                                                                                                               
                                                    
      pod_runno,  
      pod_assflg,                                                                                                                                                                                                                                              
                                                                                                                                                                                                                                                               
                                                    
      pod_dtyrat,                                                                                                                                                                                                                                              
                                                                                                                                                                                                                                                               
                                                    
      pod_typcode,                                                                                                                                                                                                                                             
                                                                                                                                                                                                                                                               
                         
      pod_Code1,                                                                                                                                                                                                                                               
                                                                                                                                                                                                                                                               
                                                    
      pod_Code2,                                                                                                                                                                                                                                               
                                                                                                                                                                                                                                                               
                                                    
      pod_Code3,                                                                                                                                                                                                                                               
                                                                                                                                                                                                                                                               
                                                    
      pod_creusr,                                                                                                                                                                                                                                              
                                                                                                                                                                                                                                                               
                                                    
      pod_updusr,                                                                                                                                                                                                                                              
                                                                                                                                                                                                                                                               
                                                    
      pod_pckitr,  
      pod_rmk,  
      pod_prdven,   
      pod_tradeven,
      pod_examven,
      pod_prdsubcde,  
      pod_seccusitm  , 
                                                                                                                                                                                                                                                               
     pod_alsitmno , 
     pod_alscolcde
                        
      ) VALUES (                                                                                                                                                                                                                                               
       
      @pod_cocde,                                                                                                                                                                                                                                              
       
      @pod_purord,                                                                                                                                                                                                                                             
       
      @pod_purseq,                                                                                                                                                                                                                                             
       
      @pod_itmno,                                                                                                                                                                                                                                              
       
      @sdt_itmsts,                                                                                                                                                                                                                                             
       
      @pod_venitm,                                                                                                                                                                                                                                             
       
      @pod_cusitm,                                                                                                                                                                                                                                             
       
      @pod_cussku,                                                                                                                                                                                                                                             
       
      @pod_engdsc,                                                                                                                                                                                                                                             
       
      @pod_chndsc,                                                                                                                                                                                                                                             
       
      @pod_vencol,                                                                                                                                                                                                                                             
       
      @pod_cuscol,                                                                                                                                                                                                                                             
       
      @pod_coldsc,                                                                                                                                           
      @pod_pckseq,                                                                                                                                                                                                                                            
         
      @pod_untcde,                                                                                                                                                                                                                                             
       
      @pod_inrctn,                                                                                                                                                                                                                                             
       
      @pod_mtrctn,                                                                                                                                                                                                                                             
       
      @pod_cubcft,                                                                                                                                                                                                                                             
       
      @pod_cbm,                                                                                                                                                                                                                                                
       
      @pod_dept,                                                                                                                                                                                                                                               
       
    --  @pod_ordqty,   
    --  @pod_recqty,      
      @pod_ordqty - @pod_recqty,                                                                                                                                                                                                                               
                
       0,                                                                                                                                                                                                                                                    
      @pod_ftyprc,                                                                                                                                                                                                                                             
       
      @pod_cuspno,                                                                                                                                                                                                                                             
       
      @pod_respno,                                                                                                                                                                                                                                             
       
      @pod_hrmcde,                                                                                                                                                                                                                                             
       
      @pod_lblcde,                                                                                                                                                                                                                                             
       
      @pod_cususd,                                                                                                                        
      @pod_cuscad,                                                                                                                                                                                                                                            
        
      @pod_shpstr,                                                                                                                                                                                                                                             
       
      @pod_shpend,                                                                                                                                                                                                                                             
       
      @pod_candat,                                                                                                                                                                                                                                             
       
      @pod_ctnstr,                                                                                                                                                                                                                                             
       
      @pod_ctnend,                                                                                                                                                                                                                                             
       
      @pod_scno,                                                                                                                                                                                                                                               
       
      @pod_ttlctn,                                                                                                                                                                                                                                             
       
      @pod_lneamt,                                                                                                                                                                                                                                             
       
      @pod_lnecub,                                                                                                                                                                                                                                             
       
      @pod_ttlqty,                                                                                                                                                                                                                                             
       
      @pod_scline,                                                                                                                                                                                                                                             
       
      @pod_jobord,  
      @pod_runno,                                                                                                                                                                                                                                              
      
      @pod_assflg,                                                                                                                                                                                                                                             
       
      @dtyrat,                                                                                                                                                                                                                                                 
       
      @typcode,                                                                                                                                                                                                                                                
       
      @Code1,                                                                                                                                                                                                                                                  
       
      @Code2,                                                                                                                                                                                                                                                  
       
      @Code3,                                                                                                                                                                                                                                                  
       
     @usrid , 
       
     @usrid , 
       
      @pod_pckitr,  
      @sdt_rmk,  
      @pod_prdven, 
	@sco_cusven,
	@sco_cusven,  
      @pod_prdsubcde,  
      @pod_seccusitm  ,
      @sod_alsitmno , 
      @sod_alscolcde
       )      

		if @@rowcount > 0 
		begin
			-- Added by Mark Lau 20090709
			-- Record cannot be updated
			/*
			insert into SCFDBDTL (sbd_cocde,sbd_lotno,sbd_filename,sbd_jobord,sbd_chgtyp,sbd_before,sbd_after, sbd_flg,sbd_rmk,sbd_creusr,sbd_credat,sbd_updusr,sbd_upddat)
			values(@cocde,@lotno,@filename,@pod_jobord ,'03','',cast(@pod_ftyprc as nvarchar(255)),'S','New PO - ' + cast(@pod_purord as nvarchar(255)) + ' / ' + cast(@pod_purseq as nvarchar(255)),@usrid,@currdt,@usrid,@currdt)

			insert into SCFDBDTL (sbd_cocde,sbd_lotno,sbd_filename,sbd_jobord,sbd_chgtyp,sbd_before,sbd_after,sbd_flg,sbd_rmk,sbd_creusr,sbd_credat,sbd_updusr,sbd_upddat)
			values(@cocde,@lotno,@filename,@pod_jobord ,'04','',cast(@pod_lneamt as nvarchar(255)),'S','New PO - ' + cast(@pod_purord as nvarchar(255)) + ' / ' + cast(@pod_purseq as nvarchar(255)),@usrid,@currdt,@usrid,@currdt)
			*/

			insert into SCFDBDTL (sbd_cocde,sbd_lotno,sbd_filename,sbd_jobord,sbd_chgtyp,sbd_before,sbd_after,sbd_flg,sbd_rmk,sbd_creusr,sbd_credat,sbd_updusr,sbd_upddat)
			values(@cocde,@lotno,@filename,@pod_jobord ,'','','','S','New PO Item - ' + cast(@pod_purord as nvarchar(255)) + ' / ' + cast(@pod_purseq as nvarchar(255)),@usrid,@currdt,@usrid,@currdt)
					                                                                                                                                                              	
			
		end
       END  
         else
	
	begin
		if @poftyprc <> @pod_ftyprc
		begin
		insert into SCFDBDTL (sbd_cocde,sbd_lotno,sbd_filename,sbd_jobord,sbd_chgtyp,sbd_before,sbd_after, sbd_flg,sbd_rmk,sbd_creusr,sbd_credat,sbd_updusr,sbd_upddat)
		values(@cocde,@lotno,@filename,@jobord ,'03',cast(@poftyprc as nvarchar(255)),cast(@pod_ftyprc as nvarchar(255)),'S','',@usrid,@currdt,@usrid,@currdt)
		end

		if @polneamt <> @pod_lneamt
		begin
		insert into SCFDBDTL (sbd_cocde,sbd_lotno,sbd_filename,sbd_jobord,sbd_chgtyp,sbd_before,sbd_after,sbd_flg,sbd_rmk,sbd_creusr,sbd_credat,sbd_updusr,sbd_upddat)
		values(@cocde,@lotno,@filename,@jobord ,'04',cast((@polneamt ) as nvarchar(255) ),cast(@pod_lneamt as nvarchar(255)),'S','',@usrid,@currdt,@usrid,@currdt)
		end

		if @popv <> @pod_prdven
		begin
		insert into SCFDBDTL (sbd_cocde,sbd_lotno,sbd_filename,sbd_jobord,sbd_chgtyp,sbd_before,sbd_after,sbd_flg,sbd_rmk,sbd_creusr,sbd_credat,sbd_updusr,sbd_upddat)
		values(@cocde,@lotno,@filename,@jobord ,'07',cast(@popv as nvarchar(255) ),cast(@pod_prdven as nvarchar(255)),'S','',@usrid,@currdt,@usrid,@currdt)
		end		

	end

       IF @@ERROR <> 0                                                                                                                                                                                                                                         
            
      BEGIN                                                                                                                                                                                                                                                    
           
         -- Return 99 to the calling program to indicate failure.                                                                                                                                                                                              
           
         PRINT 'An error occurred when inserting into POORDDTL'                                                                                                                                                                                                
           
         RETURN(99)                                                                                                                                                                                                                                            
           
      END                                                                                                                                                                                                                                                      
            
     END  
       
     --- Change Factory ----  
     IF  @sdt_chgfty = 'Y'  
     BEGIN    
      SELECT  
       @pod_chndsc=pod_chndsc,  
       @pod_shpstr=pod_shpstr,  
       @pod_shpend=pod_shpend,  
       @pod_candat=pod_candat,  
       @sdt_rmk=pod_rmk  
      FROM  
       POORDDTL   
      where   
       pod_purord = @sdt_oldpurord and  
       pod_purseq = @sdt_oldpurseq                                           
 
 select 
 @jobord = isnull(pod_jobord,''),
 @poftyprc = isnull(pod_ftyprc,0),
 @polneamt = isnull( pod_lneamt,0),
 @scno = isnull(pod_scno,''),
 @scseq = isnull(pod_scline,0),
@popv = isnull(pod_prdven,'')
from POORDDTL
WHERE pod_cocde = @cocde AND   
pod_purord = @ret_code AND  
pod_purseq = @seqno  
       
      UPDATE POORDDTL SET  
      pod_itmsts = @sdt_itmsts,  
      pod_venitm = @pod_venitm,  
      pod_cusitm = @pod_cusitm,  
      pod_cussku = @pod_cussku,  
      pod_engdsc = @pod_engdsc,  
      pod_cuscol = @pod_cuscol,  
      pod_coldsc = @pod_coldsc,  
      pod_cbm    = @pod_cbm,  
      pod_dept   = @pod_dept,  
      pod_ordqty = @pod_ordqty,  
      pod_ftyprc = @pod_ftyprc,  
      pod_cuspno = @pod_cuspno,  
      pod_respno = @pod_respno,  
      pod_hrmcde = @pod_hrmcde,  
      pod_lblcde = @pod_lblcde,  
      pod_cususd = @pod_cususd,  
      pod_cuscad = @pod_cuscad,  
      pod_shpstr = @pod_shpstr,  
      pod_shpend = @pod_shpend,  
      pod_candat = @pod_candat,  
      pod_ctnstr = @pod_ctnstr,  
      pod_ctnend = @pod_ctnend,  
      pod_ttlctn = @pod_ttlctn,  
      pod_lneamt = @pod_lneamt,  
      pod_lnecub = @pod_lnecub,  
      pod_ttlqty = @pod_ttlqty,  
      pod_assflg = @pod_assflg,  
      pod_dtyrat = @dtyrat,  
      pod_typcode= @typcode,  
      pod_Code1  = @Code1,  
      pod_Code2  = @Code2,  
      pod_Code3  = @Code3,  
     -- pod_creusr = 'SYSTEM',  
      pod_updusr = @usrid, 
      pod_pckitr  = @pod_pckitr,  
      pod_prdven  = @pod_prdven,   
      pod_tradeven = @sco_cusven,
      pod_examven = @sco_cusven,
      pod_prdsubcde = @pod_prdsubcde,  

      pod_seccusitm = @pod_seccusitm  ,
     -- pod_jobord = @pod_jobord                                                                                                                                                                                                                               
      --Lester Wu 2006-09-26
     pod_alsitmno = @sod_alsitmno , 
     pod_alscolcde = @sod_alscolcde

                                 --      pod_rmk = @sdt_rmk                                                                                                                                                                                     
      WHERE pod_cocde = @cocde AND   
      pod_purord = @ret_code AND  
      pod_purseq = @seqno   
        
      IF @@rowcount = 0   
      BEGIN                                                                                                                                                                                                                                                
      -- INSERT NEW PO DETAIL                                                                                                                                                                                                                                  
           
      INSERT INTO POORDDTL (                                                                                                                                                                                                                                   
           
      pod_cocde,                                                                                                                                                                                                                                               
                                                                                                                                                                                                                                                               
                                               
      pod_purord,                                                                                                                                                                                                                                              
                                                                                                                                                                                                                                                               
                                                    
      pod_purseq,                                                                                                                                                                                                                                              
                                                                                                                                                                                                                                
      pod_itmno,                                                                                                                                                                                                                                              
                                                                                                                                                                                                                                                               
                                                     
      pod_itmsts,                                                                                                                                                                                                                                              
                                                                                                                                                                                                                                                               
                                                    
      pod_venitm,                                                                                                                                                                                                                                              
                                                                                                                                                                                                                                                               
                                                    
      pod_cusitm,                                                                                                                                                                                                                                              
                                                                                                                                                                                                                                                               
                                                    
      pod_cussku,                                                                                                                                                                                                                                              
                                                                                                                                                                                                                                                               
                                                    
      pod_engdsc,                                                                                                                                                                                                                                              
                                                                                                                                                                                                                                                               
                                                    
      pod_chndsc,                                                                                                                                                                                                                                              
                                                                                                                                                                                                                                                               
                                                    
      pod_vencol,                                                                                                                                                                                                                                              
                                                                                                                                                                                                                                                               
                                                    
      pod_cuscol,                                                                                                                                                                                                                                              
                                                                                                                                                                                                                                                               
                                                    
      pod_coldsc,                                                                                                                                                                                                                                              
                                                                                                                                                                                                                                                               
                                                    
      pod_pckseq,                                                                                                                                                                                                                                              
                                                                                                                                                                                                                                                               
                                                    
      pod_untcde,                                                                                                                                                                                                                                              
                                                                                                                                                                                                                                                               
                                                    
      pod_inrctn,                                                                                                                                                                                                                                              
                                                                                                                                                                                                                                                               
                                                    
      pod_mtrctn,                                                                                                                                                                                                                                              
                                                                                                                                                                                                                                                               
                                                    
      pod_cubcft,                                                                                                                                                                                                                                              
                                                                                                                                                                                                                                                               
                                                    
      pod_cbm,                                                                                                                                                                                                                                                 
                                                                                                                                                                                                                                                               
                                                    
      pod_dept,                                                                                                                                                                                                                                                
                                                                                                                                                                                                                                                               
                                                    
      pod_ordqty,                                                                                                                                                                                                                                              
                                                                                                                                                                                                                                                               
                                                    
      pod_recqty,                                                                                                                                                                                                                                              
                                                                                                                                                                                                                                                               
                                                    
      pod_ftyprc,                                                                                                                                                                                                                                              
                                                                                                                                                                                                                                                               
                                                    
      pod_cuspno,                                                                                                                                                                                                                                              
                                                                                                                                                                                                                                                               
                                                    
      pod_respno,                                                                                                                                                                                                                                              
                                                                                                                                                                                                                                                               
                                                    
      pod_hrmcde,                                                                                                                                                                                                                                              
                                                                                                                                                                                                                                                               
                                                    
      pod_lblcde,                                                                                                                                                                                                                                              
                                                                                                                                                                                                                                                               
                                                    
      pod_cususd,                                                                                                                                                                                                                                              
                                                                                                                                                                                                                                                               
                                                    
      pod_cuscad,                                                                                                                                                                                                                                              
                                                                                                                                                                                                                                                               
                                                    
      pod_shpstr,                                                                                                                                                                                                                                              
                                                                                                                                                                                                                                                               
                                                    
      pod_shpend,                                                                                                                                                                                                                                              
                                                                                                                                                                                                                                                               
                                                    
      pod_candat,                                                                                                                                                                                                                                              
                                                                                                                                                                                                                                                               
                              
      pod_ctnstr,                                                                                                                                                                                                                                              
                                                                                                                                                                                                                                                               
                                                    
      pod_ctnend,                                                                                                                                                                                                                                              
                                                                                                                                                                                                                                                               
                                                    
      pod_scno,                                                                                                                                                                                                                                                
                                                                                                                                                                                                                                                               
                                                    
      pod_ttlctn,                                                                                                                                                                                                                                              
                                                                                                                                                                                                                                                               
                                                    
      pod_lneamt,                                                                                                                                                                                                                                              
                                                                                                                                                                                                                                                               
                                                    
      pod_lnecub,                                                                                                                                                                                                                                              
                                                                                                                                                                                                                                                               
                                                    
      pod_ttlqty,                                                                                                                                                                                                                                              
                                                                                                                                                                                                                           
      pod_scline,                                                                                                                                                                                                                                              
                                                                                                                                                                                                                                                               
                                                    
      pod_jobord,  
      pod_runno,                                                                                                                                                                                                                                               
                                                                                                                                                                                                                                                               
                                                   
      pod_assflg,                                                                                                                                                                                                                                              
                                                                                                                                                                                                                                                               
                                                    
      pod_dtyrat,                                                                                                                                                                                                                                              
                                                                                                                                                                                                                                                               
                                                    
      pod_typcode,                                                                                                                                                                                                                                             
                                                                                                                                                                                                                                                               
                                                    
      pod_Code1,                                                                                                                                                                                                                                               
                                                                                                                                                                                                                                                               
                                                    
      pod_Code2,                                                                                                                                                                                                                                               
                                                                                                                                                                                                                                                               
                                                    
      pod_Code3,                                                                                                                                                                                                                                               
                                                                                                                                                                                                                                                               
                                                    
      pod_creusr,                                                                                                                                                                                                                                              
                                                                                                                                                                                                                                                               
                                                    
      pod_updusr,                                                                                                                                                                                                                                              
                                                                                                                                                                                                                                                               
                                                    
      pod_pckitr,  
      pod_rmk ,  
      pod_prdven,  
      pod_tradeven,
      pod_examven,
      pod_prdsubcde,  
      pod_seccusitm  ,
      -- Lester Wu 2006-09-26
      pod_alsitmno , 
      pod_alscolcde
                                                                                                                                                                                                                                                               
                                                                                                                                                                                                                                                               
                                                                                                                                                                                                                                                               
                                                                                                                                                                                                                                                               
                                                                                                                                                                                                                                                               
                                                                    
      ) VALUES (                                                                                                                                                                                                                                               
       
      @pod_cocde,                                                                                                                                                                                                                                              
       
      @pod_purord,                                                                                                                                                                                                                                             
       
      @pod_purseq,                                                                                                                                                                                                                                             
       
      @pod_itmno,                                                                                                                                                                                                                                              
       
      @sdt_itmsts,                                                                                                                                                                                                                                             
       
      @pod_venitm,                                                                                                                                                                                                                                             
       
      @pod_cusitm,                                                                                                                                                                                                                                             
       
      @pod_cussku,                                                                                                                                                                                                                                             
       
      @pod_engdsc,                                                                                                                                                                                                                                             
       
      @pod_chndsc,                                                                                                                                                                                                                                             
       
      @pod_vencol,                                                                                                                                                                                                                                             
       
      @pod_cuscol,                                                                                                                                                                                                                                             
       
      @pod_coldsc,                                                                                                                                                                                                                                             
       
      @pod_pckseq,                                                                                                                                                                                                                                             
       
      @pod_untcde,                                                                                                                                                                                                                                             
       
      @pod_inrctn,                                                                                                                                                                                                                                             
       
      @pod_mtrctn,                                                                                                                                                                                              
      @pod_cubcft,                                                                                                                                                                                                                                            
        
      @pod_cbm,                                                                                                                                                                                                                                                
       
      @pod_dept,                                                                                                                                                                                                                                               
       
    --  @pod_ordqty,   
    --  @pod_recqty,      
      @pod_ordqty - @pod_recqty,                                                                                                                                                                                                                               
                
       0,                                                                                                                                                                                                                                                    
      @pod_ftyprc,                                                                                                                                                                                                                                             
       
      @pod_cuspno,                                                                                                                                                                                                                                             
       
      @pod_respno,                                                                                                                                                                                                                                             
       
      @pod_hrmcde,                                                                                                                                                                                                                                             
       
      @pod_lblcde,                                                                                                                                                                                                                                             
       
      @pod_cususd,                                                                                                                                                                                                                                             
       
      @pod_cuscad,                                                                                                                                                                                                                                             
       
      @pod_shpstr,                                                                                                                                                                                                                                             
       
      @pod_shpend,                                                                                                                                                                                                                                             
       
      @pod_candat,                                                                                                                                                                         
      @pod_ctnstr,                                                                                                                                                                                                                                            
        
      @pod_ctnend,                                                                                                                                                                                                                                             
       

      @pod_scno,                                                                                                                                                                                                                                               
       
      @pod_ttlctn,                                                                                                                                                                                                                                             
       
      @pod_lneamt,                                                                                                                                                                                                                                             
       
      @pod_lnecub,                                                                                                                                                                                                                                             
       
      @pod_ttlqty,                                                                                                                                                                                                                                             
       
      @pod_scline,                                                                                                                                                                                                                                             
       
      @pod_jobord,    
      @pod_runno,                                                                                                                                                                                                                                              
    
      @pod_assflg,                                                                                                                                                                                                                                             
       
      @dtyrat,                                                                                                                                                                                                                                                 
       
      @typcode,                                                                                                                                                                                                                                                
       
      @Code1,                                                                                                                                                                                                                                                  
       
      @Code2,                                                                                                                                                                                                                                                  
       
      @Code3,                                                                                                                      
      @usrid, 
        
     @usrid, 
       
      @pod_pckitr,  
      @sdt_rmk,  
      @pod_prdven,   
	@sco_cusven,
	@sco_cusven,
      @pod_prdsubcde,  
      @pod_seccusitm  ,
      -- Lester Wu 2006-09-26
      @sod_alsitmno , 
      @sod_alscolcde
       )   

		if @@rowcount > 0 
		begin
			-- Added by Mark Lau 20090709
			-- Record cannot be updated
			/*
			insert into SCFDBDTL (sbd_cocde,sbd_lotno,sbd_filename,sbd_jobord,sbd_chgtyp,sbd_before,sbd_after, sbd_flg,sbd_rmk,sbd_creusr,sbd_credat,sbd_updusr,sbd_upddat)
			values(@cocde,@lotno,@filename,@pod_jobord ,'03','',cast(@pod_ftyprc as nvarchar(255)),'S','New PO - ' + cast(@pod_purord as nvarchar(255)) + ' / ' + cast(@pod_purseq as nvarchar(255)),@usrid,@currdt,@usrid,@currdt)

			insert into SCFDBDTL (sbd_cocde,sbd_lotno,sbd_filename,sbd_jobord,sbd_chgtyp,sbd_before,sbd_after,sbd_flg,sbd_rmk,sbd_creusr,sbd_credat,sbd_updusr,sbd_upddat)
			values(@cocde,@lotno,@filename,@pod_jobord ,'04','',cast(@pod_lneamt as nvarchar(255)),'S','New PO - ' + cast(@pod_purord as nvarchar(255)) + ' / ' + cast(@pod_purseq as nvarchar(255)),@usrid,@currdt,@usrid,@currdt)
			*/
			insert into SCFDBDTL (sbd_cocde,sbd_lotno,sbd_filename,sbd_jobord,sbd_chgtyp,sbd_before,sbd_after,sbd_flg,sbd_rmk,sbd_creusr,sbd_credat,sbd_updusr,sbd_upddat)
			values(@cocde,@lotno,@filename,@pod_jobord ,'','','','S','New PO Item - ' + cast(@pod_purord as nvarchar(255)) + ' / ' + cast(@pod_purseq as nvarchar(255)),@usrid,@currdt,@usrid,@currdt)
				                                                                                                                                                              	
			
		end
       END  
         else

	begin
		if @poftyprc<> @pod_ftyprc
		begin
		insert into SCFDBDTL (sbd_cocde,sbd_lotno,sbd_filename,sbd_jobord,sbd_chgtyp,sbd_before,sbd_after, sbd_flg,sbd_rmk,sbd_creusr,sbd_credat,sbd_updusr,sbd_upddat)
		values(@cocde,@lotno,@filename,@jobord ,'03',cast(@poftyprc as nvarchar(255)),cast(@pod_ftyprc as nvarchar(255)),'S','',@usrid,@currdt,@usrid,@currdt)
		end
		
		if @polneamt <> @pod_lneamt
		begin
		insert into SCFDBDTL (sbd_cocde,sbd_lotno,sbd_filename,sbd_jobord,sbd_chgtyp,sbd_before,sbd_after,sbd_flg,sbd_rmk,sbd_creusr,sbd_credat,sbd_updusr,sbd_upddat)
		values(@cocde,@lotno,@filename,@jobord ,'04',cast((@polneamt ) as nvarchar(255) ),cast(@pod_lneamt as nvarchar(255)),'S','',@usrid,@currdt,@usrid,@currdt)
		end 


		if @popv <> @pod_prdven
		begin
		insert into SCFDBDTL (sbd_cocde,sbd_lotno,sbd_filename,sbd_jobord,sbd_chgtyp,sbd_before,sbd_after,sbd_flg,sbd_rmk,sbd_creusr,sbd_credat,sbd_updusr,sbd_upddat)
		values(@cocde,@lotno,@filename,@jobord ,'07',cast(@popv as nvarchar(255) ),cast(@pod_prdven as nvarchar(255)),'S','',@usrid,@currdt,@usrid,@currdt)
		end		


	end
 
         
       IF @@ERROR <> 0                                                                                                                                                                                                                                         
            
      BEGIN                                                                                                                                                                                                                                                    
           
         -- Return 99 to the calling program to indicate failure.                                                                                                                                                                                              
           
         PRINT 'An error occurred when inserting into POORDDTL'                                                                                                                                                                                                
           
         RETURN(99)                                                                                                                                                                                                                                            
           
      END                                                                                                                                                                                                                                                      
            
  
     END  
                                                                                                                                                                                                                                                          
                                                                                                                                                                                                                                                               
          
     DECLARE cur_SCASSINF CURSOR                                                                                                                                                                                                                               
          
     FOR SELECT                                                                                                                                                                                                                                                
          
     sai_itmno,                                                                                                                                                                                                                                                
          
     sai_assitm,                                                                                                                                                                                                                                               
          
     sai_assdsc,                                                                                                                                                                                                                                      
     sai_cusitm,                                                                                                                                                                                                                                              
           
     sai_colcde,   
     sai_coldsc,                                                                                                                                                                                                                                               
         
     sai_cussku,                                                                                                                                                                                                                                               
          
     sai_upcean,                                                                                                                                                                                                                                               
          
     sai_cusrtl,                                                                                                                                                                                                                                               
          
     sai_untcde,                                                                                                                                                                                                                                               
          
     sai_inrqty,                                                                                                                                                                                                                                               
          
     sai_mtrqty                                                                                                                                                                                                                                                
          
     FROM SCASSINF                                                                                                                                                                                                                                             
          
     WHERE                                                                                                                                                                                                                                                     
          
     sai_cocde = @cocde AND                                                                                                                                                                                                                                    
          
     sai_ordno = @sdt_ordno AND                                                                                                                                                                                                                                
          
     sai_ordseq = @sdt_ordseq                                                                                                                                                                                                                                  
          
                                                                                                                                                                                                                                                               
                      
     OPEN cur_SCASSINF                                                                                                                                                                                                                                         
  
     FETCH NEXT FROM cur_SCASSINF INTO                                                                                                                                                                                                                         
          
     @pda_itmno,                                                                                                                                                                                                                                               
          
     @pda_assitm,                                                                                                                                                                                                                                              
          
     @pda_assdsc,                                                                                                                                                                                                                                              
          
     @pda_cusitm,                                                                                                                                                                                                                                              
          
     @pda_colcde,      
     @pda_coldsc,                                                                                                                                                                                                                                              
      
     @pda_cussku,                                                                                                                                                                                                                                              
          
     @pda_upcean,                                                                                                                                                                                                                                              
          
     @pda_cusrtl,                                                                                                                                                                                                                                              
          
     @pda_pckunt,                                                                                                                                                                                                                                              
          
     @pda_inrqty,                                                                                                                                                                                                                                              
          
     @pda_mtrqty  
  
  
                                                                                                                                                                                                                                                               
                      
     WHILE @@fetch_status = 0                                                                                                                                                                                                                                  
          
     BEGIN                                                                                                                                                                                                                                                     
          
        
      IF @sdt_updpo = 'Y'  or @sdt_chgfty = 'Y'  
      BEGIN                                                                                                                                                                                                                                                    
       INSERT INTO PODTLASS (                                                                                                                                                                                                                                  
        
       pda_cocde,                                                                                                                                                                                                                                              
       
       pda_purord,                                                                                                                                                                                                                                             
        
       pda_seq,                                                                                                                                                                                                                                                
        
       pda_itmno,                                                                                                                                                                                                                                              
        
       pda_assitm,                                                                                                                                                                                                                                             
        
       pda_assdsc,                                                                                                                                                                                                                                             
        
       pda_cusitm,                                                                                                                                                                                                                                             
        
       pda_colcde,   
       pda_coldsc,                                                                                                                                                                                                                                             
       
       pda_cussku,                                                                                                                                                                                                                                             
        
       pda_upcean,                                                                                                                                                                                                                                             
        
       pda_cusrtl,                                                                                                                                                                                                                                             
        
       pda_pckunt,                                                                                                                                                                                                                                             
        
       pda_inrqty,                                                                                                                                                                                                                                             
        
       pda_mtrqty,                                                                                                                                                                                                                                             
        
       pda_creusr,                                                                                                                                                                                                                                             
        
       pda_updusr                                                                                                                                                                                                                                              
        
       ) VALUES (                                                                                                                                                                                                                                              
        
       @cocde,                                                                                                                                                                                                                                                 
        
       @ret_code,                                                                                                                                                                                                                                              
        
       @seqno,                                                                                                                                                                                                                                                 
   
       @pda_itmno,                                                                                                                                                                                                                                             
        
       @pda_assitm,                                                                                                                                                                                                                                            
        
       @pda_assdsc,                                                                                                                                                                                                                                            
        
       @pda_cusitm,                                                                                                                                                                                                                                            
        
       @pda_colcde,    
       @pda_coldsc,                                                                                                                                                                                                                                            
      
       @pda_cussku,                                                                                                                                                                                                                                            
        
       @pda_upcean,                                                                                                                                                                                                                                            
        
       @pda_cusrtl,                                                                                                                                                                                                                                            
        
       @pda_pckunt,                                                                                                                                                                                                                                           
       @pda_inrqty,                                                                                                                                                                                                                                           
         
       @pda_mtrqty,                                                                                                                                                                                                                                            
        
      @usrid , 
        
      @usrid
        
       )                                                                                                                                                                                                                                                       
        
                                                                                                                                                                                                                                                               
        
       IF @@ERROR <> 0                                                                                                                                                                                                                                         
        
       BEGIN                                                                                                                                                                                                                                                   
        
          -- Return 99 to the calling program to indicate failure.                                                                                                                                                                                             
        
          PRINT 'An error occurred when inserting into PODTLASS'                                                                                                                                                                                               
        
          RETURN(99)                                                                                                                                                                                                                                           
        
       END   
      END                                                                                                                                                                                                                                                      
   
      ---------------------------------                                                                                                                                                                                                                        
       
                                                                                                                                                                                                                                        
                                                                                                                                                       
      DECLARE cur_BOM2 CURSOR                                                                                                                                                                                                                                 
        
      FOR   
        
      /*  
      SELECT  
      s.iba_assitm, s.iba_pckunt, s.iba_bomqty, f.ibi_venno,  
      --u.imu_curcde, u.imu_ftyprc, s.iba_colcde, v.vbi_curcde  
      u.imu_curcde, u.imu_ttlcst, s.iba_colcde, v.vbi_curcde  
      FROM  
       IMBOMASS s,  
       IMBASINF f,  
       IMMRKUP u,  
       VNBASINF v  
      WHERE  
      --s.iba_cocde = @cocde AND  
      s.iba_itmno = @pda_assitm AND  
      --f.ibi_cocde = s.iba_cocde AND  
      f.ibi_itmno = s.iba_assitm AND  
      --u.imu_cocde = s.iba_cocde AND  
      u.imu_itmno = s.iba_assitm AND  
      u.imu_ventyp = 'D' AND  
      u.imu_typ = 'BOM' AND  
      u.imu_venno = f.ibi_venno AND  
      --v.vbi_cocde = @cocde AND  
      v.vbi_venno = f.ibi_venno  
      */  
  
  
      SELECT   
       sbi_assitm,  sbi_bomitm,  sbi_pckunt,    
       sbi_ordqty,  sbi_venno,  sbi_fcurcde,  
       sbi_ftyprc,   sbi_colcde,   vbi_curcde,   
       sbi_bcurcde,  sbi_bomcst  , sbi_bompoflg
      from   
       SCBOMINF,  
       VNBASINF   
      WHERE  
       sbi_cocde = @cocde AND  
       sbi_ordno = @sdt_ordno AND  
       sbi_ordseq = @sdt_ordseq and  
       vbi_venno = sbi_venno and  
       sbi_assitm = @pda_assitm  
  
  
  
                                                                                                                                                                                                                                                               
      
      OPEN cur_BOM2                                                                                                                                                                                                                                            
       
      FETCH NEXT FROM cur_BOM2 INTO  
      @pdb_assitm, @pdb_assitm, @pdb_pckunt,                                                                                                                                                                                                                   
                              
      @pdb_bomqty, @pdb_venno, @pdb_bcurcde,                                                                                                                                                                                                                   
                              
      @pdb_bomcst, @pdb_colcde, @vbi_curcde,  
      @pdb_curcde, @pdb_ftyprc  , @pdb_bompoflg
                                                                                                                                                                                                                                                    
  
      WHILE @@fetch_status = 0                                                                                                                                                                                                                                 
       
      BEGIN                                                                                                                                                                                                                                                    
       
  
  
       SET @pdb_ordqty = (@pod_ordqty * @pda_mtrqty)/@pod_mtrctn * @pdb_bomqty                                                                                                                                                                                 
    
/*  
PRINT @sdt_ordno  
PRINT @sdt_ordseq  
PRINT 'XXX'  
PRINT @pod_ordqty   
PRINT @pda_mtrqty  
PRINT @pod_mtrctn   
PRINT @pdb_bomqty  
PRINT @pdb_ordqty   
PRINT '---'  
*/  
                                                                                                                                                                                                                                                               
                                                                                                                                                                  
  
       IF @sdt_updpo = 'Y'  or @sdt_chgfty = 'Y'  
  
  
       BEGIN      
        -- Allan Yuen Fix the Change Factory  Error -------------  
        --if @sdt_oldpurord is not null and @sdt_oldpurord <> ''  
        --begin  
        -- UPDATE   
        --  PODTLBOM  
        -- SET   
        --  pdb_ordqty = 0,  
        --  pdb_upddat = GETDATE(),  
        --  pdb_updusr = 'SYSTEM'  
        -- WHERE   
        --  pdb_cocde = @cocde AND  
        --  pdb_purord = @sdt_oldpurord  AND  
        --  pdb_seq = @sdt_oldpurseq  
        --end  
        ---------------------------------------------------------------------   
        set @rate1 = 0  
        execute SP_SELECT_EXRATE @cocde, @pdb_curcde, @vbi_curcde, "B", @return_rate = @rate1 output                                                                                                                                                           
                                                                                    
        --------------------------------------------------------------------  
        --select   
        -- @imu_ftycst = imu_ftycst,  
        -- @imu_bcurcde = imu_bcurcde  
        --from  
        -- immrkup   
        --where  
        -- imu_itmno = @pdb_assitm  
        ---------------------------------------------------------------------  
        execute SP_SELECT_EXRATE @cocde, @pdb_bcurcde, @vbi_curcde, "B", @return_rate = @rate output                                                                                                                                                           
                                                                                    
        ---------------------------------------------------------------------   
        UPDATE   
         PODTLBOM  
        SET   
         pdb_ordqty = @pdb_ordqty,  
         pdb_imcurcde  = @pdb_curcde,  
         pdb_imftyprc  =   @pdb_ftyprc,   
         pdb_curcde = @vbi_curcde,  
         pdb_ftyprc  =  @pdb_ftyprc*@rate1,     
         pdb_bcurcde = @pdb_bcurcde,  
         pdb_bomcst =  @pdb_bomcst*@rate,      
         pdb_pckunt = @pdb_pckunt,  
         pdb_bomqty  = @pdb_bomqty,   
         pdb_venno = @pdb_venno,   
         pdb_upddat = GETDATE(),  
         pdb_updusr = @usrid, 
         pdb_bompoflg = @pdb_bompoflg	--Lester Wu 2006-05-18
        WHERE   
         pdb_cocde = @cocde AND  
         pdb_purord = @ret_code AND  
         pdb_seq = @seqno AND  
         pdb_assitm = @pda_assitm AND  
         pdb_bomitm = @pdb_assitm AND  
         pdb_colcde = @pdb_colcde  
        ---------------------------------------------------------------------   
        IF @@rowcount = 0  
        BEGIN  
         INSERT INTO PODTLBOM   
         (  
         pdb_cocde,  pdb_purord, pdb_seq,  pdb_assitm,  
         pdb_bomitm, pdb_colcde, pdb_pckunt, pdb_bomqty,                                                                                                                                                                                                       
                                          
         pdb_venno, pdb_curcde, pdb_imcurcde, pdb_imftyprc,          pdb_ftyprc,  pdb_bcurcde, pdb_bomcst, pdb_ordqty,                                                                                                                                         
                                                                                                        
         pdb_bpolne, pdb_bompno, pdb_creusr, pdb_updusr, 
         pdb_bompoflg 
         )   
         VALUES   
         (                                                                                                                                                                                                                                                  
         @cocde,  @ret_code,  @seqno,  @pda_assitm,                                                                                                                                                                                                            
                                 
         @pdb_assitm, @pdb_colcde, @pdb_pckunt, @pdb_bomqty,                                                                                                                                                                                                   
                                          
         @pdb_venno, @vbi_curcde, @pdb_curcde, @pdb_ftyprc,                                                                                                                                                                                                    
                                            
         @pdb_ftyprc*@rate1, @pdb_bcurcde, @pdb_bomcst*@rate, @pdb_ordqty,                                                                                                                                                                                     
                                                           
         0,  '',  @usrid,@usrid , 
         @pdb_bompoflg
         )  
        END  
          
        IF @@ERROR <> 0                                                                                                                                                                                                                                        
     
        BEGIN                                                                                                                                                                                                                                                  
     
           -- Return 99 to the calling program to indicate failure.                                                                                                                                                                                            
     
           PRINT 'An error occurred when inserting into PODTLBOM'                                                                                                                                                                                              
     
           RETURN(99)                                                                                                                                                                                                                                          
     
        END                                                                                                                                                                                                                                        
       END  
                                                                                                                                                                                                                                                               
    
       FETCH NEXT FROM cur_BOM2 INTO  
      @pdb_assitm, @pdb_assitm, @pdb_pckunt,                                                                                                                                                                                                                   
                              
      @pdb_bomqty, @pdb_venno, @pdb_bcurcde,                                                                                                                                                                                                                   
                              
      @pdb_bomcst, @pdb_colcde, @vbi_curcde,  
      @pdb_curcde, @pdb_ftyprc, @pdb_bompoflg
      END                                                                                                                                                                                                                                                      
       
                                                                                                                                                                                                                                                               
       
      CLOSE cur_BOM2                                                                                                                                                                                                                                           
       
      DEALLOCATE cur_BOM2                                                                                                                                                                                                                                      
       
                                                                                                                                                                                                                                                               
    
                                                                                                                                                                                                                                                               
       
      --------------------------------                                                                                                                                                                                                                         
       
                                                                                                                                                                                                                                                               
       
      FETCH NEXT FROM cur_SCASSINF INTO                                                                                                                                                                                                                        
       
      @pda_itmno,                                                                                                                                                                                                                                              
       
      @pda_assitm,                                                                                                                                                                                                                                             
       
      @pda_assdsc,                                                                                                                                                                                                                                             
       
      @pda_cusitm,                                                                                                                                                                                                                                             
       
      @pda_colcde,    
      @pda_coldsc,                                                                                                                                                                                                                                             
     
      @pda_cussku,                                                                                                                                                                                                                                             
       
      @pda_upcean,                                                                                                                                                                                                                                             
       
      @pda_cusrtl,                                                                                                                                                                                                                                             
       
      @pda_pckunt,                                                                                                                                                                                                                                             
       
      @pda_inrqty,                                                                                                                                                                                                                                             
       
      @pda_mtrqty                                                                                                                                                                                                                                              
       
                                                                                                                                                                                                                                                               
       
     END                                                                                                                                                                                                                                                       
          
                                                                                                                                                                                                                                                               
          
     CLOSE cur_SCASSINF                                                                                                                                                                                                                                        
          
     DEALLOCATE cur_SCASSINF                                                                                                                                                                                                                                   
          

DECLARE cur_SCDTLSHP CURSOR FOR
select	sds_shpseq,	sds_scfrom,	sds_scto,
	sds_pofrom,	sds_poto,	sds_ordqty,
	sds_ctnstr,	sds_ctnend,	sds_ttlctn,
	sds_dest
from	SCDTLSHP (nolock)
where	sds_cocde = @cocde and
	sds_ordno = @sdt_ordno and
	sds_seq = @sdt_ordseq

OPEN cur_SCDTLSHP	
FETCH NEXT FROM cur_SCDTLSHP INTO	
@pds_seq,	@pds_scfrom,	@pds_scto,
@pds_pofrom,	@pds_poto,	@pds_ordqty,
@pds_ctnstr,	@pds_ctnend,	@pds_ttlctn,
@pds_dest
                                                                                                                                                                                                                                                       
     WHILE @@fetch_status = 0                                                                                                                                                                                                                                  
          
     BEGIN                                                                                                                                                                                                                                                     
          
      IF @sdt_updpo = 'Y'    
      BEGIN                                                                                                                                                                                                                                                    
        
	if @pds_pofrom = '1900-01-01'
	begin
		--set @pds_pofrom = @pds_scfrom - @vbi_tsttim - @vbi_bufday
		set @pds_pofrom = @pds_scfrom - @csf_shpstrbuf
	end

-- 20150506 Remove PO Ship Date > getdate, use getdate logic
/*	if getdate() > @pds_pofrom
	begin
		set @pds_pofrom = getdate()
	end
*/	
	if @pds_poto = '1900-01-01'
	begin
		--set @pds_poto = @pds_scto - @vbi_tsttim - @vbi_bufday
		set @pds_poto = @pds_scto - @csf_shpendbuf
	end

-- 20150506 Remove PO Ship Date > getdate, use getdate logic
/*	if getdate() > @pds_poto
	begin
		set @pds_poto = getdate()
	end
*/	
	insert into PODTLSHP
	(	pds_cocde,	pds_purord,	pds_seq,
		pds_shpseq,	pds_from,	pds_to,
		pds_ordqty,	pds_ctnstr,	pds_ctnend,
		pds_ttlctn,	pds_dest,	pds_creusr,
		pds_updusr,	pds_credat,	pds_upddat
	)
	values
	(	@cocde,		@ret_code,	@seqno,
		@pds_seq,	@pds_pofrom,	@pds_poto,
		@pds_ordqty,	@pds_ctnstr,	@pds_ctnend,
		--@pds_ttlctn,	@pds_dest,	'SCM02-SYS',
		@pds_ttlctn,	@pds_dest,	left('X-' + @usrid, 30),
		--'SCM02-SYS',	getdate(),	getdate()
		left('X-' + @usrid, 30), getdate(), getdate()
	)
        
                                                                                                                                                                                                                                                               
        
       IF @@ERROR <> 0                                                                                                                                                                                                                                         
        
       BEGIN                                                                                                                                                                                                                                                   
        
          -- Return 99 to the calling program to indicate failure.                                                                                                                                                                                             
        
          PRINT 'An error occurred when inserting into PODTLSHP'                                                                                                                                                                                               
        
          RETURN(99)                                                                                                                                                                  
       END    
      END    
                                                                                                                                                                                                                                                              
    
	FETCH NEXT FROM cur_SCDTLSHP INTO	
	@pds_seq,	@pds_scfrom,	@pds_scto,
	@pds_pofrom,	@pds_poto,	@pds_ordqty,
	@pds_ctnstr,	@pds_ctnend,	@pds_ttlctn,
	@pds_dest                                                                                                                                                                                                                                        

     END                                                                                                                                                                                                                                                       
          
                                                                                                                                                                                                                                                               
          
     CLOSE cur_SCDTLSHP                                                                                                                                                                                                                                        
          
     DEALLOCATE cur_SCDTLSHP                                                                                                                                                                                                                                   
          
  
  
     IF  @sdt_chgfty = 'Y'  
     begin  
      INSERT INTO PODTLSHP (                                                                                                                                                                                                                                   
       
      pds_cocde,                                                                                                                                                                                                                                               
      
      pds_purord,                                                                                                                                                                             
      pds_seq,                                                                                                                                                                             
      pds_from,                                                                                                                                                                             
      pds_to, 
       pds_ctnstr,
       pds_ctnend,
	pds_ordqty,                                                                                                                                                                    
      pds_ttlctn,                                                                                                                                                                                                                                              
      pds_shpseq,                                                                                                                                                                                                                                              
      pds_creusr,                                                                                                                                                                                                                                              
      pds_updusr                                                                                                                                                                             
      )   
      select  
       @cocde,                                                                                                                                                                                                                                                 
       @ret_code,                                                                                                                                                                                                                                              
       @seqno,  
       pds_from,                                                                                                                                                                             
       pds_to,                                                                                                                                                                     
       pds_ctnstr,
       pds_ctnend,
	pds_ordqty,
       pds_ttlctn,                                                                                                                                                                                                                                             
        
       pds_shpseq,                                                                                                                                                                                                                                             
        
      left('Y-' + @usrid, 30), 
      left('Y-' + @usrid, 30) 
      FROM  
       PODTLSHP   
      WHERE  
       pds_purord = @sdt_oldpurord AND  
       pds_seq = @sdt_oldpurseq                                                                                                                                                                                                                                
                                       
  
      IF @@ERROR <> 0                                                                                                                                                                                                                                          
       
      BEGIN                                                                                                                                                                                                                                                    
       
         -- Return 99 to the calling program to indicate failure.                                                                                                                                                                                              
       
         PRINT 'An error occurred when inserting into PODTLSHP'                                                                                                                                                                                                
       
         RETURN(99)                                                                                                                                                                                                                                            
       
      END                                                                                                                                                                                                                                                      
                
     end  
  
  
     --- Cater Regular Item with BOM Only ---  
  
     DECLARE cur_BOM1 CURSOR                                                                                                                                                                                                                                   
          
     FOR   
  
     /*  
     SELECT                                                                                                                                                                                                                                                    
  
     s.iba_assitm, s.iba_pckunt, s.iba_bomqty, f.ibi_venno,                                                                                                                                                                                                    
      
     --u.imu_curcde, u.imu_ftyprc, s.iba_colcde, v.vbi_curcde                                                                                                                                                                                                  
                      
     u.imu_curcde, u.imu_ttlcst, s.iba_colcde, v.vbi_curcde                                                                                                                                                                                                    
                    
     FROM IMBOMASS s, IMBASINF f, IMMRKUP u, VNBASINF v                                                                                                                                                                                                        
                  
     WHERE                                                                                                                                                                                                                                                     
      
     --s.iba_cocde = @cocde AND                                                                                                                                                                                                                                
        
     s.iba_itmno = @pod_itmno AND                                                                                                                                                                                                                              
     
     --f.ibi_cocde = s.iba_cocde AND                                                                                                                                                                                                                           
        
     f.ibi_itmno = s.iba_assitm AND                                                                                                                                                                                                                            
      
     --u.imu_cocde = s.iba_cocde AND                                                                                                                                                                                                                           
        
     u.imu_itmno = s.iba_assitm AND                                                                                                                                                                                                                            
      
     u.imu_ventyp = 'D' AND                                                                                                                                                                                                                                    
      
     u.imu_typ = 'BOM' AND                                                                                                                                                                                                                                     
      
     u.imu_venno = f.ibi_venno AND  
     --v.vbi_cocde = @cocde AND  
     v.vbi_venno = f.ibi_venno                                                                                                                                                                                                                                 
             
     */  
  
     SELECT   
      sbi_assitm,  sbi_bomitm,  sbi_pckunt,    
      sbi_ordqty,  sbi_venno,  sbi_fcurcde,  
      sbi_ftyprc,   sbi_colcde,   vbi_curcde,   
      sbi_bcurcde,  sbi_bomcst  , sbi_bompoflg
     from   
      SCBOMINF,  
      VNBASINF   
     WHERE  
      sbi_cocde = @cocde AND  
      sbi_ordno = @sdt_ordno AND  
      sbi_ordseq = @sdt_ordseq and  
      vbi_venno = sbi_venno and  
      ltrim(rtrim(sbi_assitm)) = ''   
                                                                                                                                                                                                                                                               
          
     OPEN cur_BOM1                                                                                                                                                                                                                                             
          
     FETCH NEXT FROM cur_BOM1 INTO                                                                                                                                                                                                                             
          
     @pda_assitm, @pdb_assitm, @pdb_pckunt,                                                                                                                                                                                                                    
                             
     @pdb_bomqty, @pdb_venno, @pdb_bcurcde,                                                                                                                                                                                                                    
                             
     @pdb_bomcst, @pdb_colcde, @vbi_curcde,  
     @pdb_curcde, @pdb_ftyprc, @pdb_bompoflg
                                                                                                                                                                                                                                                               
          
     WHILE @@fetch_status = 0                                                                                                                                                                                                                                  
          
     BEGIN                                                                                                                                                                                                                                                     
          
       
      SET @pdb_ordqty = @pod_ordqty * @pdb_bomqty                                                                                                                                                                                                              
       
       
      IF @sdt_updpo = 'Y'  or @sdt_chgfty = 'Y'  
      BEGIN      
  
       -- Allan Yuen Fix the Change Factory  Error -------------  
       --if @sdt_oldpurord is not null and @sdt_oldpurord <> ''  
       --begin  
       -- UPDATE   
       --  PODTLBOM  
       -- SET   
       --  pdb_ordqty = 0,  
       --  pdb_upddat = GETDATE(),  
       --  pdb_updusr = 'SYSTEM'  
       -- WHERE   
       --  pdb_cocde = @cocde AND  
       --  pdb_purord = @sdt_oldpurord  AND  
       --  pdb_seq = @sdt_oldpurseq  
       --end  
       ---------------------------------------------------------------------   
       set @rate1 = 0  
       execute SP_SELECT_EXRATE @cocde, @pdb_bcurcde, @vbi_curcde, "B", @return_rate = @rate1 output  
       --------------------------------------------------------------------  
       --select   
       -- @imu_ftycst = imu_ftycst,  
       -- @imu_bcurcde = imu_bcurcde  
       --from  
       -- immrkup   
       --where  
       -- imu_itmno = @pdb_assitm  
       -----------------------------------------------------------------------  
       --execute SP_SELECT_EXRATE @cocde, @imu_bcurcde, @vbi_curcde, "B", @return_rate = @rate output                                                                                                                                                          
                                                                                            
       --execute SP_SELECT_EXRATE @cocde, @imu_curcde, @vbi_curcde, "B", @return_rate = @rate output                                                                                                                                                           
                                                                                                                                                                                                                                                               
                                                                      
  
       /*         
       UPDATE PODTLBOM  
       SET pdb_ordqty = @pdb_ordqty,  
       pdb_upddat = GETDATE(),  
       pdb_updusr = 'SYSTEM'  
       WHERE pdb_cocde = @cocde AND  
       pdb_purord = @ret_code AND  
       pdb_seq = @seqno AND  
       pdb_assitm = '' AND  
       pdb_bomitm = @pdb_assitm AND  
       pdb_colcde = @pdb_colcde  
       */  
       ---------------------------------------------------------------------   
       UPDATE   
        PODTLBOM  
       SET   
        pdb_ordqty = @pdb_ordqty,  
        pdb_imcurcde  = @pdb_curcde,  
        pdb_imftyprc  =   @pdb_ftyprc,   
        pdb_curcde = @vbi_curcde,  
        pdb_ftyprc  =  @pdb_ftyprc*@rate1,     
        pdb_bcurcde = @pdb_bcurcde,  
        pdb_bomcst =  @pdb_bomcst*@rate,      
        pdb_pckunt = @pdb_pckunt,  
        pdb_bomqty  = @pdb_bomqty,   
        pdb_venno = @pdb_venno,   
        pdb_upddat = GETDATE(),  
        pdb_updusr = @usrid, 
        pdb_bompoflg = @pdb_bompoflg
       WHERE   
        pdb_cocde = @cocde AND  
        pdb_purord = @ret_code AND  
        pdb_seq = @seqno AND  
        pdb_assitm = @pda_assitm AND  
        pdb_bomitm = @pdb_assitm AND  
        pdb_colcde = @pdb_colcde  
       ---------------------------------------------------------------------   
       IF @@rowcount = 0  
       BEGIN  
        INSERT INTO PODTLBOM   
        (  
        pdb_cocde,  pdb_purord, pdb_seq,  pdb_assitm,  
        pdb_bomitm, pdb_colcde, pdb_pckunt, pdb_bomqty,                                                                                                                                                                                                        
                                         
        pdb_venno, pdb_curcde, pdb_imcurcde, pdb_imftyprc,         pdb_ftyprc,  pdb_bcurcde, pdb_bomcst, pdb_ordqty,                                                                                                                                           
                                                                                                      
        pdb_bpolne, pdb_bompno, pdb_creusr, pdb_updusr, 
        pdb_bompoflg                                                                                                                                                              
        )   
        VALUES   
        (                                                                                                                                                                                                                                                  
        @cocde,  @ret_code,  @seqno,  @pda_assitm,                                                                                                                                                                                                            
                                 
        @pdb_assitm, @pdb_colcde, @pdb_pckunt, @pdb_bomqty,                                                                                                                                                                                                    
                                         
        @pdb_venno, @vbi_curcde, @pdb_curcde, @pdb_ftyprc,                                                                                                                                                                                                     
                                           
        @pdb_ftyprc*@rate1, @pdb_bcurcde, @pdb_bomcst*@rate, @pdb_ordqty,                                                                                                                                                                                      
                                                          
        0,  '', @usrid,@usrid, 
        @pdb_bompoflg                
        )  
       END  
  
  
  
  
  
       IF @@ERROR <> 0                                                                                                                                                                                                                                         
        
       BEGIN                                                                                                                                                                                                                                                   
        
          -- Return 99 to the calling program to indicate failure.                                                                                                                                                                                             
        
          PRINT 'An error occurred when inserting into PODTLBOM'                                                                                                                                                                                               
        
          RETURN(99)                                                                                                                                                                                                                                           
        
       END    
                                                                                                                                                                                                                                                             
      END  
                                                                                                                                                                                                                                                               
      
      FETCH NEXT FROM cur_BOM1 INTO                                                                                                                                                                                                                            
           
      @pda_assitm, @pdb_assitm, @pdb_pckunt,                                                                                                                                                                                                                   
                              
      @pdb_bomqty, @pdb_venno, @pdb_bcurcde,                                                                                                                                                                                                                   
                              
      @pdb_bomcst, @pdb_colcde, @vbi_curcde,  
      @pdb_curcde, @pdb_ftyprc  ,@pdb_bompoflg
  
     END                                                                                                                                                                                                                                                       
          
                                                                                                                                                                                                                                                               
          
     CLOSE cur_BOM1                                                                                                                                                                                                                                            
          
     DEALLOCATE cur_BOM1  
  
  
       END  
                 
    FETCH NEXT FROM cur_SCORDDTL INTO   
     @sdt_fcurcde, @sdt_itmsts, @sdt_cusven,   
     @sdt_purord, @sdt_purseq, @sdt_cocde,  
     @sdt_ordno, @sdt_ordseq, @sdt_updpo,  
     @sdt_chgfty, @sdt_itmno, @sdt_itmtyp,  
     @sdt_itmdsc, @sdt_colcde, @sdt_cuscol,  
     @sdt_coldsc, @sdt_pckseq, @sdt_pckunt,  
     @sdt_inrctn, @sdt_mtrctn, @sdt_cft,  
     @sdt_cbm,  @sdt_qutno, @sdt_refdat,  
     @sdt_cusitm, @sdt_cussku, @sdt_resppo,  
     @sdt_cuspo, @sdt_ordqty, @sdt_discnt,  
     @sdt_oneprc, @sdt_curcde, @sdt_selprc,  
     @sdt_hrmcde, @sdt_dtyrat, @sdt_dept,   
     @sdt_typcode, @sdt_Code1, @sdt_Code2,  
     @sdt_Code3, @sdt_cususd, @sdt_cuscad,  
     @sdt_inrdin, @sdt_inrwin, @sdt_inrhin,  
     @sdt_mtrdin, @sdt_mtrwin, @sdt_mtrhin,  
     @sdt_inrdcm, @sdt_inrwcm, @sdt_inrhcm,  
     @sdt_mtrdcm, @sdt_mtrwcm, @sdt_mtrhcm,  
     @sdt_shpstr, @sdt_shpend, @sdt_candat,  
     @sdt_ctnstr, @sdt_ctnend, @sdt_ttlctn,  
     @sdt_rmk,  @sdt_invqty, @sdt_shpqty,  
     @sdt_ftyprc, @sdt_ftycst, @sdt_subcde,  
     @sdt_venitm, @sdt_pckitr, @sdt_oldpurord,   
     @sdt_oldpurseq,  
     @sdt_cusven, @sdt_cussub, @sdt_pjobno,   
     @sdt_seccusitm, @sdt_venno  ,
     @sod_alsitmno, @sod_alscolcde,
     @sdt_posstr,@sdt_posend, @sdt_poscan
  
   END                                                   
   CLOSE cur_SCORDDTL                                    
   DEALLOCATE cur_SCORDDTL                                
  
  
   ---- Calculate the Ship Start Date & Ship End Date ---  
   SELECT @ShpStartDate = MIN(pod_shpstr) FROM POORDDTL WHERE POD_COCDE = @cocde AND POD_PURORD = @ret_code   
   SELECT @ShpEndDate =  MAX(pod_shpend) FROM POORDDTL WHERE POD_COCDE = @cocde AND POD_PURORD = @ret_code      
   ---------------------------------------------------------------  
  
     
   SELECT @pod_ttlctn = SUM(pod_ttlctn),  
   @pod_lnecub = SUM(pod_lnecub),  
---- Allan Yuen remark the rounding error at 9th Oct, 2003  
   ---@pod_lneamt = SUM(Round(pod_lneamt,2)),  
   @pod_lneamt = round(SUM(pod_lneamt),2),  
   @pod_jobord = ''  
   FROM POORDDTL  
   WHERE pod_cocde = @cocde AND  
   pod_purord = @ret_code  
     
   UPDATE PODISPRM SET   
   pdp_paamt = Round(@pod_lneamt * pdp_purpct / 100,2)  
   WHERE pdp_cocde = @cocde AND  
   pdp_purord = @ret_code AND  
   pdp_pctamt = 'P'  
    
     
   SELECT @tmpamt = SUM(p.pdp_paamt) - SUM(d.pdp_paamt)  
   FROM PODISPRM p, PODISPRM d  
   WHERE   
   p.pdp_cocde = @cocde AND  
   p.pdp_purord = @ret_code AND  
   p.pdp_pdptyp = 'P' AND  
   d.pdp_cocde = p.pdp_cocde AND  
   d.pdp_purord = p.pdp_purord AND  
   d.pdp_pdptyp = 'D'  
     
   IF @tmpamt IS NULL  
   BEGIN  
    SET @tmpamt = 0  
   END  
           

   UPDATE   
    POORDHDR   
   SET   
    poh_shpstr = @ShpStartDate,   
    poh_shpend = @ShpEndDate ,  
    poh_ttlctn = @pod_ttlctn,  
    poh_ttlcbm = @pod_lnecub,  
    poh_ttlamt = @pod_lneamt,  
--	poh_netamt = @pod_lneamt + @tmpamt,  -- Marco fix poh_netamt problem 20110817
    poh_netamt = round((@pod_lneamt + @tmpamt) * (1 - (@poh_discnt/100)),2),
    poh_upddat = GETDATE(),  
    poh_updusr = @usrid 
   WHERE   
    poh_cocde = @cocde AND  
    poh_purord = @ret_code   
                                   
   FETCH NEXT FROM cur_SCORDDTLHDR INTO   
   @sco_ordno, @sco_cusven  
  END                                                       
  CLOSE cur_SCORDDTLHDR                                     
  DEALLOCATE cur_SCORDDTLHDR                                
  
   
  -- Change Factory Processing --  
  -- update old purchase order's order qty.        
      UPDATE p SET p.pod_ordqty = p.pod_recqty,  
      p.pod_lneamt = p.pod_recqty * p.pod_ftyprc,  
      p.pod_lnecub = p.pod_cubcft * p.pod_recqty / p.pod_mtrctn,  
      p.pod_ttlctn = p.pod_recqty / p.pod_mtrctn,  
  p.pod_scno = '',  
  p.pod_scline = 0,  
  p.pod_jobord = '',  
  p.pod_runno = '',  
  p.pod_upddat = GETDATE(),  
  p.pod_updusr = @usrid  
      FROM POORDDTL p, SCORDDTL s, SCORDHDR h  
      WHERE h.soh_cocde = s.sod_cocde AND  
  h.soh_ordno = s.sod_ordno AND  
  s.sod_cocde = p.pod_cocde AND  
      s.sod_oldpurord = p.pod_purord AND  
      s.sod_oldpurseq = p.pod_purseq AND  
  (s.sod_oldpurord <> s.sod_purord or s.sod_oldpurseq <> s.sod_purseq) AND  
  h.soh_ordsts = 'ACT' AND   h.soh_ordno >= @from AND  h.soh_ordno <= @to AND  
  h.soh_cocde = @cocde  
 -- check for old purord & purseq <> current purord and purseq   
       
      DECLARE  
      @purord nvarchar(20),  
  @purseq int  
  
  DECLARE  
  @bompno nvarchar(20),  
  @bpolne int,  
  @bomitm nvarchar(20),  
  @bomcolcde nvarchar(30),  
  @ordqty int,  
  @ttlamt numeric (13,4),  
  @disprc numeric (13,4),  
  @disamt numeric (13,4)  
        
      DECLARE cur_OLDPO CURSOR  
  FOR SELECT DISTINCT d.sod_oldpurord  
  FROM SCORDDTL d, SCORDHDR h  
  WHERE   
  h.soh_ordsts = 'ACT' AND  
  h.soh_ordno >= @from AND  
  h.soh_ordno <= @to AND  
  h.soh_cocde = @cocde AND  
  d.sod_ordno = h.soh_ordno AND  
  d.sod_cocde = h.soh_cocde AND  
  d.sod_oldpurord <> '' AND  
  d.sod_oldpurord IS NOT NULL    
  GROUP BY  d.sod_oldpurord  
    
  OPEN cur_OLDPO  
  FETCH NEXT FROM cur_OLDPO INTO   
  @purord   
    
  WHILE @@fetch_status = 0  
  BEGIN  
   SELECT @pod_ttlctn = SUM(pod_ttlctn),  
   @pod_lnecub = SUM(pod_lnecub),  
---   @pod_lneamt = SUM(Round(pod_lneamt,2))  
--- Remark round by Allan Yuen at 08/10/2003  
   @pod_lneamt = SUM(pod_lneamt)  
   FROM POORDDTL  
   WHERE pod_cocde = @cocde AND  
   pod_purord = @purord  
     
   UPDATE PODISPRM SET   
   pdp_paamt = Round(@pod_lneamt * pdp_purpct / 100,2)  
   WHERE pdp_cocde = @cocde AND  
   pdp_purord = @purord AND  
   pdp_pctamt = 'P'  
         
   SELECT @tmpamt = SUM(p.pdp_paamt) - SUM(d.pdp_paamt)  
   FROM PODISPRM p, PODISPRM d  
   WHERE   
   p.pdp_cocde = @cocde AND  
   p.pdp_purord = @purord AND   
   p.pdp_pdptyp = 'P' AND  
   d.pdp_cocde = p.pdp_cocde AND  
   d.pdp_purord = p.pdp_purord AND  
   d.pdp_pdptyp = 'D'  
     
   IF @tmpamt IS NULL  
   BEGIN  
    SET @tmpamt = 0  
   END  
           
   UPDATE POORDHDR SET poh_ttlctn = @pod_ttlctn,  
   poh_ttlcbm = @pod_lnecub,  
--- Add Round 2 decimal point by Allan Yuen at 08/10/2003  
   poh_ttlamt = @pod_lneamt,  
--	poh_netamt = @pod_lneamt + @tmpamt,  -- Marco fix poh_netamt problem 20110817
   poh_netamt = round((@pod_lneamt + @tmpamt) * (1 - (@poh_discnt/100)),2),
   poh_upddat = GETDATE(),  
   poh_updusr = @usrid
   WHERE poh_cocde = @cocde AND  
   poh_purord = @purord   
  
   FETCH NEXT FROM cur_OLDPO INTO   
   @purord   
  END  
    
  CLOSE cur_OLDPO                                     
  DEALLOCATE cur_OLDPO         
  
--//?????????????????????????????????????????????????????????????????????????????????????????


      DECLARE cur_OLDPO CURSOR  
  FOR 
  SELECT DISTINCT d.sod_oldpurord, d.sod_oldpurseq  
  FROM SCORDDTL d, SCORDHDR h  
  WHERE   
  h.soh_ordsts = 'ACT' AND  
  h.soh_ordno >= @from AND  
  h.soh_ordno <= @to AND  
  h.soh_cocde = @cocde AND  
  d.sod_ordno = h.soh_ordno AND  
  d.sod_cocde = h.soh_cocde AND  
  d.sod_oldpurord <> '' AND  
  d.sod_oldpurord IS NOT NULL    
  GROUP BY  d.sod_oldpurord, d.sod_oldpurseq  
    
  OPEN cur_OLDPO  
  FETCH NEXT FROM cur_OLDPO INTO   
  @purord, @purseq  
    
  WHILE @@fetch_status = 0  
  BEGIN  
   --- Update BOM PO Information ---  
       DECLARE cur_BOMPO CURSOR  
   FOR   
   SELECT  
    PDB_BOMPNO,  PDB_BPOLNE,   
    PDB_BOMITM,  PDB_COLCDE,   
    PDB_ORDQTY  
   FROM   
    PODTLBOM  
   WHERE  
    PDB_PURORD = @PURORD AND  
    PDB_SEQ = @PURSEQ  
  
   OPEN cur_BOMPO  
   FETCH NEXT FROM cur_BOMPO INTO   
   @bompno, @bpolne, @bomitm,   
   @bomcolcde, @ordqty   
  
   WHILE @@fetch_status = 0  
   BEGIN  
  
  
    IF LTRIM(RTRIM(@bompno)) <> ''   
    BEGIN  
  
      
  
     UPDATE    
      POBOMDTL  
     SET  
      PBD_ORGORDQTY = 0,  
      PBD_ORDQTY = 0,  
      PBD_ADJQTY = 0,  
      PBD_BOMAMT = 0,  
      PBD_RIOQTY = 0,  
      PBD_REFPO = '',  
      PBD_UPDUSR = @usrid,  
      PBD_UPDDAT = GETDATE()  
     WHERE  
      PBD_BOMPO = @BOMPNO AND  
      PBD_BOMSEQ  = @BPOLNE AND  
      PBD_ITMNO = @BOMITM AND  
      PBD_VENCOL = @BOMCOLCDE  
  
  
     SELECT   
      @TTLAMT = SUM(PBD_BOMAMT)   
     FROM   
      POBOMDTL  
     WHERE  
      PBD_BOMPO = @BOMPNO  
  
     SELECT    
      @DISPRC = PBH_DISPRC  
     FROM  
      POBOMHDR  
     WHERE   
      PBH_BOMPO = @BOMPNO  
   
     SET @DISAMT = ROUND(@TTLAMT - (@TTLAMT * @DISPRC / 100),2)  
       
     UPDATE   
      POBOMHDR  
     SET   
      PBH_TTLAMT = @TTLAMT,  
      PBH_DISAMT = @DISAMT,  
      PBH_UPDUSR = @usrid,  
      PBH_UPDDAT = GETDATE()  
     WHERE  
      PBH_BOMPO = @BOMPNO            
    END  
    FETCH NEXT FROM cur_BOMPO INTO   
    @bompno, @bpolne, @bomitm ,  
    @bomcolcde, @ordqty   
   END  
   CLOSE cur_BOMPO  
   DEALLOCATE cur_BOMPO  
  
   -- Reset the Order Qty --  
   UPDATE  
    PODTLBOM  
   SET   
    PDB_ORDQTY = 0,  
    PDB_BOMPNO = '',  
    PDB_BPOLNE = 0      
   WHERE  
    PDB_PURORD = @PURORD AND  
    PDB_SEQ = @PURSEQ  
   -------------------------------------------  
     
   FETCH NEXT FROM cur_OLDPO INTO   
   @purord, @purseq  
  END  
    
  CLOSE cur_OLDPO                                     
  DEALLOCATE cur_OLDPO         
--//????????????????????????????????? END ??????????????????????????????????????????????????????????????????????????????????????


  UPDATE d SET d.sod_oldpurord = '',    d.sod_oldpurseq = 0  
  FROM SCORDDTL d, SCORDHDR h  
  WHERE   
  h.soh_ordsts = 'ACT' AND  
  h.soh_ordno >= @from AND  
  h.soh_ordno <= @to AND  
  h.soh_cocde = @cocde AND  
  d.sod_ordno = h.soh_ordno AND  
  d.sod_cocde = h.soh_cocde AND (d.sod_updpo = 'Y' or d.sod_chgfty = 'Y') AND  
  d.sod_oldpurord <> '' AND  
  d.sod_oldpurord IS NOT NULL    
    
  UPDATE d SET d.sod_updpo = 'N', d.sod_chgfty = 'N'   
  FROM SCORDDTL d, SCORDHDR h  
  WHERE   
  h.soh_ordsts = 'ACT' AND  
  h.soh_ordno >= @from AND  
  h.soh_ordno <= @to AND  
  h.soh_cocde = @cocde AND  
  d.sod_ordno = h.soh_ordno AND  
  d.sod_cocde = h.soh_cocde   
   

/****************************************************************************/

/****************************************************************************/
/*
  UPDATE SCORDHDR SET soh_ordsts = 'REL',  
  soh_upddat = GETDATE(),  
  soh_updusr = @usrid   
  WHERE  
  soh_ordsts = 'ACT' AND  
  soh_ordno >= @from AND  
  soh_ordno <= @to AND  
  soh_cocde = @cocde   
*/
/****************************************************************************/
  
  Declare cur_SCNO Cursor For
	SELECT 
		DISTINCT soh_ordno 
	FROM
		SCORDHDR 
	WHERE  
		soh_ordsts = 'ACT' AND  
		soh_ordno >= @from AND  
		soh_ordno <= @to AND  
		soh_cocde = @cocde   
    

  OPEN cur_SCNO 
  FETCH NEXT FROM cur_SCNO INTO   
  @SC_ORD_NO 
    
  WHILE @@fetch_status = 0  
  BEGIN  
	  UPDATE SCORDHDR SET soh_ordsts = 'REL',  
	  soh_upddat = GETDATE(),  
	  soh_updusr = @usrid  
	  WHERE  
	 -- soh_ordsts = 'ACT' AND  
	 -- soh_cocde = @cocde  AND 
	 soh_ordno =  @SC_ORD_NO
	 
    
	FETCH NEXT FROM cur_SCNO INTO   
	@SC_ORD_NO

  END  
  CLOSE cur_SCNO  
  DEALLOCATE cur_SCNO  

/****************************************************************************/


      IF @@ERROR <> 0   
  BEGIN  
     -- Return 99 to the calling program to indicate failure.  
     PRINT 'An error occurred when updating into SCORDHDR'  
     RETURN(99)  
  END  
  ELSE  
  BEGIN  
   RETURN(0)  
  END                                                        
 END                                                           
                                                               
 IF @fntyp = 'N'                                               
 BEGIN                                                         
    
  UPDATE SCORDHDR SET soh_ordsts = 'ACT',  
  soh_rvsdat = GETDATE(),  
  soh_verno = soh_verno + 1,  
  soh_upddat = GETDATE()   
  WHERE   
  soh_ordsts = 'REL' AND  
  soh_ordno >= @from AND  
  soh_ordno <= @to AND  
  soh_cocde = @cocde   
    
 IF @@rowcount = 0                        
 BEGIN  
	   PRINT 'Order No Not Found'  
	   RETURN(99)  
 END  
	-- Concatenate SC DTL Rmk to PO DTL Rmk in SCORDDTL for version 2

	update	SCORDDTL
	set	sod_pormk = left(sod_pormk + case sod_pormk when '' then '' else @feed end + sod_rmk, 300),
		sod_upddat = getdate()
	from	SCORDDTL
		left join SCORDHDR (nolock) on
			soh_cocde = sod_cocde and
			soh_ordno = sod_ordno
	where	sod_cocde = @cocde and
		sod_ordno between @from and @to and
		soh_ordsts = 'ACT' and
		soh_verno = 2
                                                               
 END                                                           
---------------------------------------------------------------------------------------------------  
END




















GO
GRANT EXECUTE ON [dbo].[sp_select_scftydat_bat_SCM00002] TO [ERPUSER] AS [dbo]
GO
