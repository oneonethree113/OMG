/****** Object:  StoredProcedure [dbo].[sp_select_SCM00002_2]    Script Date: 09/29/2017 15:29:09 ******/
DROP PROCEDURE [dbo].[sp_select_SCM00002_2]
GO
/****** Object:  StoredProcedure [dbo].[sp_select_SCM00002_2]    Script Date: 09/29/2017 15:29:10 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO




/*  
=========================================================  
Description :	sp_select_SCM00002_2
Programmer :	Carlos Lui
Create Date :	11 Jul, 2012
Last Modified :	
Table Read(s) :	
Table Write(s) :	
=========================================================  
 Modification History                                      
=========================================================  
 Date        Initial    Description                            
=========================================================       

*/  

CREATE  PROCEDURE [dbo].[sp_select_SCM00002_2]
  
@cocde	nvarchar(6),  
@from	nvarchar(20),  
@to	nvarchar(20),  
@fntyp	nvarchar(1),  
@usrid	nvarchar(30)  
  
AS  
  
begin  
	if @fntyp = 'Y'   
	begin  
     		DECLARE		@rate numeric(13,11),		@rate1 numeric(13,11),	@tmpamt numeric(13,4),
				@ShpStartDate datetime,	@ShpEndDate datetime
     
		DECLARE -- SCORDDTLHDR  
				@sco_ordno nvarchar(20),	@sco_cusven nvarchar(6),	@sco_purord nvarchar(20),
				@sco_purseq int,		@sco_ttlctn int,		@sco_ttlamt numeric(13,4)

		DECLARE -- SCORDDTL  
				@sdt_fcurcde nvarchar(6),	@sdt_itmsts nvarchar(4),	@sdt_venno nvarchar(6),
				@sdt_cusven nvarchar(6),	@sdt_purord nvarchar(20),	@sdt_purseq int,
				@sdt_cocde nvarchar(6),	@sdt_ordno nvarchar(20),	@sdt_ordseq int,
				@sdt_updpo nvarchar(1),	@sdt_chgfty nvarchar(1),	@sdt_itmno nvarchar(20),  
				@sdt_itmtyp nvarchar(4),	@sdt_itmdsc nvarchar(800),	@sdt_colcde nvarchar(30),  
				@sdt_cuscol nvarchar(30),	@sdt_coldsc nvarchar(300),	@sdt_pckseq int,
				@sdt_pckunt nvarchar(6),	@sdt_inrctn int,  		@sdt_mtrctn int,  
				@sdt_cft numeric(11,4),  	@sdt_cbm numeric(11,4),  	@sdt_qutno nvarchar(20),  
				@sdt_refdat datetime,  		@sdt_cusitm nvarchar(20),  	@sdt_cussku nvarchar(20),  
				@sdt_resppo nvarchar(20),  	@sdt_cuspo nvarchar(20),  	@sdt_ordqty int,  
				@sdt_discnt numeric(6,3),  	@sdt_ftyprc numeric(13,4),  	@sdt_ftycst numeric(13,4),  
				@sdt_oneprc nvarchar(1),  	@sdt_curcde nvarchar(6),  	@sdt_selprc numeric(13,4),  
				@sdt_hrmcde nvarchar(12),  	@sdt_dtyrat numeric(6,3),  	@sdt_dept nvarchar(20),  
				@sdt_typcode nvarchar(1),  	@sdt_Code1 nvarchar(25),   	@sdt_Code2 nvarchar(25),  
				@sdt_Code3 nvarchar(25), 	@sdt_cususd numeric(13,4),  	@sdt_cuscad numeric(13,4),  
				@sdt_inrdin numeric(11,4),  	@sdt_inrwin numeric(11,4),  	@sdt_inrhin numeric(11,4),  
				@sdt_mtrdin numeric(11,4),  	@sdt_mtrwin numeric(11,4),  	@sdt_mtrhin numeric(11,4),  
				@sdt_inrdcm numeric(11,4),  	@sdt_inrwcm numeric(11,4),  	@sdt_inrhcm  numeric(11,4),  
				@sdt_mtrdcm numeric(11,4),  	@sdt_mtrwcm numeric(11,4),  	@sdt_mtrhcm numeric(11,4),  
				@sdt_shpstr datetime,  	@sdt_shpend datetime,  	@sdt_candat datetime,  
				@sdt_ctnstr int,  		@sdt_ctnend int,  		@sdt_ttlctn int,  
				@sdt_rmk nvarchar(300),  	@sdt_invqty int,  		@sdt_shpqty int,  
				@sdt_subcde nvarchar(10),  	@sdt_cussub nvarchar(10),  	@sdt_venitm nvarchar(20),  
				@sdt_pckitr nvarchar(300),  	@sdt_oldpurord nvarchar(20),  	@sdt_oldpurseq int,  
				@sdt_pjobno varchar(20),  	@sdt_seccusitm varchar(20),	@sod_alsitmno varchar(20), 
				@sod_alscolcde varchar(30),	@sod_qutdat datetime,		@sod_imqutdat datetime,
				@sod_cus1no nvarchar(6),	@sod_cus2no nvarchar(6),	@sod_hkprctrm nvarchar(10),
				@sod_ftyprctrm nvarchar(10),	@sod_trantrm nvarchar(10),	@sod_effdat datetime,
				@sod_expdat datetime
       
		DECLARE		@ret_code nvarchar(20),  	@vbi_tsttim int,  		@vbi_bufday int  
       
		DECLARE -- POORDHDR  
				@poh_cocde nvarchar(6),  	@poh_purord nvarchar(20),  	@poh_pursts nvarchar(3),  
				@poh_issdat datetime,  	@poh_venno nvarchar(6),  	@poh_puradr nvarchar(200),  
				@poh_purstt nvarchar(20),  	@poh_purcty nvarchar(6),  	@poh_purpst nvarchar(20),  
				@poh_porctp nvarchar(20),  	@poh_puragt nvarchar(6),  	@poh_salrep nvarchar(30),  
				@poh_prmcus nvarchar(6),  	@poh_seccus nvarchar(6),  	@poh_shpadr nvarchar(200),  
				@poh_shpstt nvarchar(20),  	@poh_shpcty nvarchar(6),  	@poh_shppst nvarchar(20),  
				@poh_prctrm nvarchar(20),  	@poh_paytrm nvarchar(20),  	@poh_ttlcbm numeric(13,4),  
				@poh_ttlctn int,  		@poh_curcde nvarchar(6),  	@poh_ttlamt numeric(13,4),  
				@poh_discnt numeric(6,3),  	@poh_netamt numeric(13,4),  	@poh_spoflg nvarchar(1),  
				@poh_cuspno nvarchar(20),  	@poh_cpodat datetime,  	@poh_reppno nvarchar(20),  
				@poh_pocdat datetime,  	@poh_shpstr datetime,  	@poh_shpend datetime,  
				@poh_lbldue datetime,  	@poh_lblven nvarchar(20),  	@poh_rmk  nvarchar(400),
				@poh_purchnadr nvarchar(255)
  
		DECLARE -- POORDDTL  
				@pod_cocde nvarchar(6),  	@pod_purord nvarchar(20),  	@pod_purseq int,  
				@pod_itmno nvarchar(20),  	@pod_itmsts nvarchar(1),  	@pod_venitm nvarchar(20),  
				@pod_cusitm nvarchar(20),  	@pod_cussku nvarchar(20),  	@pod_engdsc nvarchar(800),  
				@pod_chndsc nvarchar(1600),  	@pod_vencol nvarchar(30),  	@pod_cuscol nvarchar(30),  
				@pod_coldsc nvarchar(300),  	@pod_pckseq int,  		@pod_untcde nvarchar(6),  
				@pod_inrctn int,  		@pod_mtrctn int,  		@pod_cubcft numeric(11,4),  
				@pod_cbm numeric(11,4),  	@pod_dept  nvarchar(20),  	@pod_ordqty int,  
				@pod_recqty int,  		@pod_ftyprc numeric(13,4),  	@pod_cuspno nvarchar(20),  
				@pod_respno nvarchar(20),  	@pod_hrmcde nvarchar(20),  	@pod_lblcde nvarchar(75), 
				@pod_cususd numeric(13,4),  	@pod_cuscad numeric(13,4),  	@pod_shpstr datetime,  
				@pod_shpend datetime,  	@pod_candat datetime,  	@pod_ctnstr int,  
				@pod_ctnend int,  		@pod_scno nvarchar(20),  	@pod_ttlctn int,  
				@pod_lneamt numeric(13,4),  	@pod_lnecub numeric(13,4),  	@pod_ttlqty int,  
				@pod_scline int,  		@pod_jobord nvarchar(20),  	@pod_runno nvarchar(20),  
				@pod_assflg nvarchar(1),  	@pod_updusr nvarchar(30),  	@pod_upddat datetime,  
				@pod_prdven varchar(6),  	@pod_prdsubcde varchar(10),  	@pod_seccusitm varchar(20),   
				@dtyrat  numeric(6,3),  	@typcode  nvarchar(1),  	@Code1  nvarchar(25),   
				@Code2  nvarchar(25),  	@Code3  nvarchar(25), 	@pod_pckitr nvarchar(300),
				@pod_cus1no nvarchar(6),	@pod_cus2no nvarchar(6),	@pod_hkprctrm nvarchar(10),
				@pod_ftyprctrm nvarchar(10),	@pod_trantrm nvarchar(10),	@pod_effdat datetime,
				@pod_expdat datetime

		DECLARE -- POSHPMRK  
				@psm_shptyp nvarchar(30),  	@psm_engdsc nvarchar(1600),  	@psm_chndsc nvarchar(3200),  
				@psm_engrmk nvarchar(1600),  	@psm_chnrmk nvarchar(3200),  	@psm_imgpth nvarchar(200),  
				@psm_imgnam nvarchar(30)  

		DECLARE -- POCNTINF  
				@pci_cocde nvarchar(6),  	@pci_purord nvarchar(20),  	@pci_csenam nvarchar(20),  
				@pci_cseadr nvarchar(200),  	@pci_csestt  nvarchar(20),  	@pci_csecty nvarchar(20),  
				@pci_csezip nvarchar(20),  	@pci_fwdtyp nvarchar(2),  	@pci_fwdacc nvarchar(20),  
				@pci_fwddsc nvarchar(200),  	@pci_fwditr nvarchar(20),  	@pci_noptyp nvarchar(2),  
				@pci_nopadr nvarchar(200),  	@pci_nopstt nvarchar(20),  	@pci_nopcty nvarchar(20),  
				@pci_nopzip nvarchar(20),  	@pci_noptil nvarchar(20),  	@pci_nopphn nvarchar(30),  
				@pci_nopfax nvarchar(30),  	@pci_nopeml nvarchar(50)  

		DECLARE    	@pda_itmno nvarchar(20),  	@pda_assitm nvarchar(20),  	@pda_assdsc nvarchar(800),  
				@pda_cusitm nvarchar(20),  	@pda_colcde nvarchar(30),  	@pda_coldsc nvarchar(300),  
				@pda_cussku nvarchar(20),  	@pda_upcean nvarchar(15),  	@pda_cusrtl nvarchar(20),
				@pda_pckunt nvarchar(6),  	@pda_inrqty int,  		@pda_mtrqty int,
				@pda_imperiod datetime  

		DECLARE   	@pdc_cocde Nvarchar(6),  	@pdc_purord nvarchar(20),  	@pdc_seq int,  
				@pdc_from int,  		@pdc_to int,  		@pdc_ttlctn int  

		DECLARE -- PODTLSHP  
				@pds_cocde nvarchar(6),  	@pds_purord nvarchar(20),  	@pds_seq int,  
				@pds_from datetime,  		@pds_to  datetime,  		@pds_ttlctn int  

		DECLARE -- PODTLBOM  
				@pdb_cocde nvarchar(6),  	@pdb_purord nvarchar(20),  	@pdb_seq int,  
				@pdb_assitm nvarchar(20),  	@pdb_bomitm nvarchar(20),  	@pdb_colcde nvarchar(30),  
				@pdb_pckunt nvarchar(6),  	@pdb_bomqty int,  		@pdb_venno nvarchar(6),  
				@pdb_ordqty  int,  		@pdb_bomcst numeric(13,4),  	@pdb_bcurcde varchar(6),  
				@pdb_imftyprc numeric(13,4),  	@pdb_imcurcde varchar(6),  	@pdb_curcde varchar(6),  
				@pdb_ftyprc numeric(13,4),    	@pdb_bompoflg char(1),	@pdb_imperiod datetime

		DECLARE  	@imu_curcde nvarchar(6),  	@imu_ftyprc numeric(13,4),  	@imu_bcurcde nvarchar(6),  
				@imu_ftycst numeric(13,4),  	@vbi_curcde nvarchar(6),  	@po_exist int,  
				@VendorType char(1)  

		DECLARE   	@startflag int  

		SET @startflag = 0  

		DECLARE		@SC_ORD_NO nvarchar(20)

		DECLARE 	@exeffdat datetime,		@exeffdat_old datetime,	@rate_old numeric(13,11),
				@ftyexrate_old numeric(13,11),	@bomexrate_old numeric(13,11),	@rateffdat datetime

		DECLARE		@testex nvarchar(1),		@debug nvarchar(1)

		set @testex = 1
		set @debug = 1

		-- New SC PO Ship Date Calculation 20151116
		declare @csf_cus1no nvarchar(10), @csf_cus2no nvarchar(10)
		declare @csf_shpstrbuf int, @csf_shpendbuf int, @csf_cancelbuf int, @ventyp nvarchar(10)
		set @csf_cus1no = ''
		set @csf_cus2no = ''
		set @csf_shpstrbuf = 0
		set @csf_shpendbuf = 0
		set @csf_cancelbuf = 0
		set @ventyp = ''

		DECLARE	cur_SCORDDTLHDR CURSOR FOR   
		select	distinct	d.sod_ordno,	d.sod_cusven  
		from	SCORDDTL d (nolock),
			SCORDHDR h  (nolock)
		where	h.soh_ordsts = 'ACT'		AND  
			h.soh_ordno >= @from	AND
			h.soh_ordno <= @to		AND
			h.soh_cocde = @cocde		AND
			d.sod_ordno = h.soh_ordno	AND
			d.sod_cocde = h.soh_cocde
		group by	d.sod_ordno, d.sod_cusven  
		order by	d.sod_ordno, d.sod_cusven  
        
		OPEN	cur_SCORDDTLHDR  
		FETCH NEXT
		FROM	cur_SCORDDTLHDR
		INTO   	@sco_ordno, @sco_cusven  

		if	@@fetch_status <> 0 AND @startflag = 0  
		begin  
			PRINT 'Order No Not Found'  
			RETURN(99)  
		end    

		WHILE @@fetch_status = 0  
		begin  
			SET @startflag = 1  

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

			DECLARE	cur_SCORDDTL CURSOR FOR   
	  		select	sod_fcurcde,	sod_itmsts,		sod_cusven,   
				sod_purord, 	sod_purseq,  	sod_cocde,                    
				sod_ordno,  	sod_ordseq,	sod_updpo,  
				sod_chgfty, 	sod_itmno,  	sod_itmtyp,  
				sod_itmdsc, 	sod_colcde, 	sod_cuscol,  
				sod_coldsc, 	sod_pckseq, 	sod_pckunt,  
				sod_inrctn, 	sod_mtrctn, 	sod_cft,  
				sod_cbm,  		sod_qutno,  	sod_refdat,  
				sod_cusitm, 	sod_cussku, 	sod_resppo,  
				sod_cuspo,  	sod_ordqty,	sod_discnt,  
				sod_oneprc, 	sod_curcde,	sod_selprc,  
				sod_hrmcde, 	sod_dtyrat,  	sod_dept,  
				sod_typcode,	sod_Code1, 	sod_Code2,  
				sod_Code3, 	sod_cususd, 	sod_cuscad,  
				sod_inrdin,  	sod_inrwin,	sod_inrhin,  
				sod_mtrdin, 	sod_mtrwin, 	sod_mtrhin,  
				sod_inrdcm, 	sod_inrwcm, 	sod_inrhcm,  
				sod_mtrdcm, 	sod_mtrwcm,	sod_mtrhcm,  
				sod_shpstr,  	sod_shpend, 	sod_candat,  
				sod_ctnstr,  	sod_ctnend, 	sod_ttlctn,  
				sod_rmk,  		sod_invqty, 	sod_shpqty,  
				sod_ftyprc,  	sod_ftycst,  	sod_subcde,  
				sod_venitm, 	sod_pckitr,  	sod_oldpurord,  
				sod_oldpurseq,   	sod_cusven, 	sod_cussub, 
				sod_pjobno,   	sod_seccusitm, 	sod_venno,
				sod_alsitmno, 	sod_alscolcde,	sod_qutdat,
				sod_imqutdat,	sod_cus1no,	sod_cus2no,
				sod_hkprctrm,	sod_ftyprctrm,	sod_trantrm,
				sod_effdat,		sod_expdat	                                      
			from	SCORDDTL (nolock)   
			where	sod_ordno = @sco_ordno	AND  
				sod_cusven = @sco_cusven	AND  
				sod_cocde = @cocde  
			order by	sod_purord desc, sod_purseq, sod_itmno  

			OPEN	cur_SCORDDTL  
			FETCH NEXT
			FROM	cur_SCORDDTL
			INTO   	@sdt_fcurcde, 	@sdt_itmsts, 	@sdt_cusven,   
				@sdt_purord, 	@sdt_purseq, 	@sdt_cocde,  
				@sdt_ordno, 	@sdt_ordseq, 	@sdt_updpo,  
				@sdt_chgfty,	@sdt_itmno, 	@sdt_itmtyp,  
				@sdt_itmdsc, 	@sdt_colcde, 	@sdt_cuscol,  
				@sdt_coldsc, 	@sdt_pckseq, 	@sdt_pckunt,  
				@sdt_inrctn, 	@sdt_mtrctn, 	@sdt_cft,  
				@sdt_cbm,  	@sdt_qutno, 	@sdt_refdat,  
				@sdt_cusitm,	@sdt_cussku, 	@sdt_resppo,  
				@sdt_cuspo,	@sdt_ordqty, 	@sdt_discnt,  
				@sdt_oneprc, 	@sdt_curcde, 	@sdt_selprc,  
				@sdt_hrmcde,	@sdt_dtyrat, 	@sdt_dept,   
				@sdt_typcode, 	@sdt_Code1, 	@sdt_Code2,  
				@sdt_Code3, 	@sdt_cususd, 	@sdt_cuscad,  
				@sdt_inrdin, 	@sdt_inrwin, 	@sdt_inrhin,  
				@sdt_mtrdin, 	@sdt_mtrwin, 	@sdt_mtrhin,  
				@sdt_inrdcm, 	@sdt_inrwcm, 	@sdt_inrhcm,  
				@sdt_mtrdcm, 	@sdt_mtrwcm, 	@sdt_mtrhcm,  
				@sdt_shpstr, 	@sdt_shpend, 	@sdt_candat,  
				@sdt_ctnstr, 	@sdt_ctnend, 	@sdt_ttlctn,  
				@sdt_rmk,  	@sdt_invqty, 	@sdt_shpqty,  
				@sdt_ftyprc, 	@sdt_ftycst, 	@sdt_subcde,  
				@sdt_venitm, 	@sdt_pckitr, 	@sdt_oldpurord,   
				@sdt_oldpurseq,  	@sdt_cusven, 	@sdt_cussub, 
				@sdt_pjobno,   	@sdt_seccusitm,	@sdt_venno,
				@sod_alsitmno, 	@sod_alscolcde,	@sod_qutdat,
				@sod_imqutdat,	@sod_cus1no,	@sod_cus2no,
				@sod_hkprctrm,	@sod_ftyprctrm,	@sod_trantrm,
				@sod_effdat,	@sod_expdat

			DECLARE	@hdr_upf nvarchar(1),	@cur_purord nvarchar(20), @seqno int  
	
			SET @hdr_upf = 'Y'  
	  
			WHILE @@fetch_status = 0                              
			begin  
				select	@poh_discnt = vbi_discnt,	@vbi_tsttim = vbi_tsttim,	@vbi_bufday = vbi_bufday,  
					@poh_paytrm = vbi_paytrm,	@poh_prctrm = vbi_prctrm,	@poh_curcde = vbi_curcde                                                                                                                                                                                                                                 	   
				from   	VNBASINF (nolock)                                                                                                                                                                                                                                                 	
				where	vbi_venno = @sco_cusven
		
				execute SP_SELECT_MEXRATE @cocde, @sdt_fcurcde, @poh_curcde, "B", '', @return_effdat = @exeffdat output,@return_rate = @rate output  

				set @rateffdat = @exeffdat	  
	  
				SET @cur_purord = ''  
	  
				if @sdt_updpo = 'N' and @sdt_chgfty = 'N'  
				begin  
					if @sdt_purord <> '' AND @sdt_purseq <> 0                                                                                                                                                                                                                 
					begin
						SET @cur_purord = @sdt_purord  
						SET @seqno = @sdt_purseq   
					end                                                                                 
				end

				if @sdt_updpo = 'Y' or @sdt_chgfty = 'Y'  
				begin	                      
					if @sdt_purord <> '' AND @sdt_purseq <> 0                                                                                                                                                                                                              
					begin
						SET @cur_purord = @sdt_purord  
						SET @seqno = @sdt_purseq  
					end
					else
					begin
						if @cur_purord = ''   	
						begin
							select	@cur_purord = poh_purord  
							from	POORDHDR (nolock)  
							where	poh_cocde = @cocde		AND  
								poh_venno = @sco_cusven	AND  
								poh_ordno = @sco_ordno  
	         
							if @cur_purord <> ''  
							begin
								select	@seqno = MAX(pod_purseq) + 1  
								from	POORDDTL (nolock)  
								where	pod_cocde = @cocde	AND
									pod_purord = @cur_purord   
							end
							else
       							begin
								execute sp_select_doc_gen_po @cocde, "PO", @usrid, @purord = @cur_purord output
	                   
								SET @seqno = 1  
							end
						end
	      					else
	      					begin
			       				SET @seqno = @seqno + 1  
	      					end
	  				end

					SET @ret_code = @cur_purord                                                                                                                                                                                                                     
	                                              
					declare	@old_poh_curcde as nvarchar(6)

					set @old_poh_curcde = ''

					select	@old_poh_curcde = isnull(poh_curcde,'')
					from	poordhdr
					where	poh_purord = @cur_purord
	          		
					if ( @old_poh_curcde <> '' ) 
					begin
						set @poh_curcde = @old_poh_curcde

						execute SP_SELECT_MEXRATE @cocde, @sdt_fcurcde, @poh_curcde, "B", '', @return_effdat = @exeffdat output,@return_rate = @rate output  

						set @rateffdat = @exeffdat	
					end
			
					update	SCORDDTL   
					set	sod_purord = @ret_code,	sod_purseq = @seqno,		sod_upddat = GETDATE(),  
						sod_updusr = 'SYSTEM'                                                                                                                                                                                                     
					where	sod_cocde = @cocde		and
						sod_ordno = @sdt_ordno	and
						sod_cusven = @sdt_cusven	and
						sod_itmno = @sdt_itmno	and
						sod_colcde = @sdt_colcde	and
						sod_pckseq = @sdt_pckseq	and
						sod_pckunt = @sdt_pckunt	and
						sod_inrctn = @sdt_inrctn	and
						sod_mtrctn = @sdt_mtrctn	and
						sod_cft = @sdt_cft		and
						sod_cus1no = @sod_cus1no	and
						sod_cus2no = @sod_cus2no	and
						sod_hkprctrm = @sod_hkprctrm	and
						sod_ftyprctrm = @sod_ftyprctrm	and
						sod_trantrm = @sod_trantrm	and
						sod_effdat = @sod_effdat	and
						sod_expdat = @sod_expdat

					if @sdt_updpo = 'Y'  or @sdt_chgfty = 'Y'   
					begin
						delete
						from	PODTLSHP  
						where	pds_cocde = @cocde		AND
							pds_purord = @ret_code	AND  
							pds_seq = @seqno  
			 
						delete
						from	PODTLCTN  
						where	pdc_cocde = @cocde		AND
							pdc_purord = @ret_code	AND  
							pdc_seq = @seqno  
			
						delete
						from	PODTLASS  
						where	pda_cocde = @cocde		AND
							pda_purord = @ret_code	AND
							pda_seq = @seqno  
			
						--- Reset all BOM item order qty to 0 ---  
						update	PODTLBOM   
						set	PDB_ORDQTY = 0  
						where	pdb_cocde = @cocde		AND
							pdb_purord = @ret_code	AND
							pdb_seq = @seqno  
					end

					-- INSERT NEW PO HEADER                                                                                                                                                                                                                                   
					if (@sdt_updpo = 'Y' AND @hdr_upf = 'Y') or (@sdt_chgfty = 'Y' AND @hdr_upf = 'Y')                                                                                                                                                                        	                                                                       
					begin
						delete
						from	POSHPMRK  	
						where	psm_cocde = @cocde		AND
							psm_purord = @ret_code  
	        
						delete
						from	POCNTINF  
						where	pci_cocde = @cocde		AND   
							pci_purord = @ret_code  
	                                                                                                                                                                                                                                                               	     
						select	@poh_puradr = isnull(ct.vci_adr,''),
						     	@poh_purchnadr = isnull(ct.vci_chnadr,''),
							@poh_purstt = isnull(ct.vci_stt,''),
							@poh_purcty = isnull(ct.vci_cty,''),
							@poh_purpst = isnull(ct.vci_zip,''),
							@poh_porctp = isnull(cp.vci_cntctp, '')                                                                                                                                                                                                                 				           
						from	VNCNTINF ct
							left join VNCNTINF cp on ct.vci_venno = cp.vci_venno and cp.vci_cntdef = 'Y' and cp.vci_cnttyp = 'GENL'
						where
							ct.vci_cnttyp = 'M' 		AND  
							ct.vci_venno = @sco_cusven  
	  
						select	@poh_puragt = soh_agt,	@poh_salrep = soh_salrep,	@poh_prmcus = soh_cus1no,                                                                                                                                                                                                                               				
							@poh_seccus = soh_cus2no,	@poh_shpadr = soh_biladr,	@poh_shpstt = soh_bilstt,                                                                                                                                                                                                                               				
							@poh_shpcty = soh_bilcty,	@poh_shppst = soh_bilzip,	@poh_ttlcbm = soh_ttlvol,                                                                                                                                                                                                                               				
							@poh_ttlctn = soh_ttlctn,	@poh_ttlamt = soh_ttlamt,	@poh_spoflg = soh_smpsc,                                                                                                                                                                                                                                				
							@poh_cuspno = soh_cuspo,	@poh_cpodat = soh_cpodat,	@poh_reppno = soh_resppo,                                                                                                                                                                                                                               				
							@poh_lbldue = soh_lbldue,	@poh_lblven = soh_lblven,	@poh_issdat = soh_issdat,                                                                                                                                                                                                                               				
							@poh_pocdat = soh_candat,	@poh_shpstr = soh_shpstr,	@poh_shpend = soh_shpend,  
							@poh_rmk = soh_rmk                                                                                                                                                                                                                              
						from	SCORDHDR (nolock)  
						where	soh_cocde = @cocde 		AND  
							soh_ordno = @sdt_ordno                                                                                                                                                                                                                                  
	        	                                                                                                                                                                                                                                                               	       
						if @poh_pocdat <> '1900-01-01'  
						begin
							--SET @poh_pocdat = @poh_pocdat - @vbi_tsttim - @vbi_bufday
							SET @poh_pocdat = @poh_pocdat - @csf_cancelbuf
						end

						--SET @poh_shpstr = @poh_shpstr - @vbi_tsttim - @vbi_bufday
						--SET @poh_shpend = @poh_shpend - @vbi_tsttim - @vbi_bufday

						SET @poh_shpstr = @poh_shpstr - @csf_shpstrbuf
						SET @poh_shpend = @poh_shpend - @csf_shpendbuf
                                                                                                                                                                      	       
						if GETDATE() > @poh_pocdat AND @poh_pocdat <> '1900-01-01'                                                                                                                                                                                               				                                
						begin
							SET @poh_pocdat = GETDATE()                                                                                                                                                                                                                             				
						end
				
						if GETDATE() > @poh_shpstr                                                                                                                                                                                                                               				
						begin
							SET @poh_shpstr = GETDATE()                                                                                                                                                                                                                             				
						end
	       	                                                                                                                                                                                                                                                               	       
						if GETDATE() > @poh_shpend                                                                                                                                                                                                                               				
						begin
							SET @poh_shpend = GETDATE()                                                                                                                                                                                                                             				
						end	       

						SET @poh_cocde = @cocde                                                                                                                                                                                                                                  				
						SET @poh_purord = @ret_code                                                                                                                                                                                                                              				
						SET @poh_pursts = 'OPE'                                                                                                                                                                                                                                  				
						SET @poh_venno = @sco_cusven                                                                                                                                                                                                                             
	
						update	POORDHDR   
						set	poh_pursts = @poh_pursts,	poh_issdat = GETDATE(),	poh_spoflg = @poh_spoflg,                                                                                                                                                                                                                               			             
							poh_cuspno = @poh_cuspno,	poh_cpodat = @poh_cpodat,	poh_reppno = @poh_reppno,   
							poh_curcde = @poh_curcde,	poh_updusr = 'SCM02-SYS',	poh_subcde = ''                                                                                                                                                                                                                                         		          
						where	poh_cocde = @cocde		AND   
							poh_purord = @ret_code  
	  
						if @@rowcount = 0   
						begin
							insert
							into	POORDHDR
								(poh_cocde,	poh_purord,	poh_pursts,
								 poh_issdat,	poh_venno,	poh_puradr,
								 poh_purstt,	poh_purcty,	poh_purpst,
								 poh_porctp,	poh_puragt,	poh_salrep,
								 poh_prmcus,	poh_seccus,	poh_shpadr,
								 poh_shpstt,	poh_shpcty,	poh_shppst,
								 poh_prctrm,	poh_paytrm,	poh_ttlcbm,
								 poh_ttlctn,		poh_curcde,	poh_ttlamt,
								 poh_discnt,	poh_spoflg,	poh_cuspno,
								 poh_cpodat,	poh_reppno,	poh_pocdat,
								 poh_shpstr,	poh_shpend,	poh_lbldue,
								 poh_lblven,	poh_netamt,	poh_creusr,
								 poh_updusr,	poh_subcde,	poh_rmk,
								 poh_ordno,	poh_purchnadr)
							values	(@cocde,		@ret_code,		@poh_pursts,
								 getdate(),		@poh_venno,	@poh_puradr,
								 @poh_purstt,	@poh_purcty,	@poh_purpst,
								 @poh_porctp,	@poh_puragt,	@poh_salrep,
								 @poh_prmcus,	@poh_seccus,	@poh_shpadr,
								 @poh_shpstt,	@poh_shpcty,	@poh_shppst,
								 @poh_prctrm,	@poh_paytrm,	@poh_ttlcbm,
								 0,		@poh_curcde,	0,
								 @poh_discnt,	@poh_spoflg,	@poh_cuspno,
								 @poh_cpodat,	@poh_reppno,	@poh_pocdat,
								 @poh_shpstr,	@poh_shpend,	@poh_lbldue,
								 @poh_lblven,	0,		'SCM02-SYS',
								 'SCM02-SYS',	'',		@poh_rmk,
								 @sco_ordno,	@poh_purchnadr)

							if @@ERROR <> 0                                                                                                                                                                                                                                         				
							begin
								PRINT 'An error occurred when inserting into POORDHDR'                                                                                                                                                                                              				 
								RETURN(99)  
							end
						end                                                                                                                                                                                                                                           

						select	@pci_csenam = sci_csenam,	@pci_cseadr = sci_cseadr,	@pci_csestt = sci_csestt,                                                                                                                                                                                                                                			
							@pci_csecty = sci_csecty,	@pci_csezip = sci_csezip,	@pci_fwdtyp = sci_fwdtyp,
							@pci_fwdacc = sci_fwdno,	@pci_fwddsc = sci_fwddsc,	@pci_fwditr = sci_fwditr,
							@pci_noptyp = sci_noptyp,	@pci_nopadr = sci_nopadr,	@pci_nopstt = sci_nopstt,
							@pci_nopcty = sci_nopcty,	@pci_nopzip = sci_nopzip,	@pci_noptil = sci_noptil,
							@pci_nopphn = sci_nopphn,	@pci_nopfax = sci_nopfax,	@pci_nopeml = sci_nopeml
						from	SCCNTINF (nolock)                                                                                                                                                                                                                                            			
						where	sci_cocde = @cocde		AND
							sci_ordno = @sdt_ordno

						insert
						into	POCNTINF
							(pci_cocde,		pci_purord,		pci_csenam,                                                                                                                                                                                                                                              			
							 pci_cseadr,	pci_csestt,		pci_csecty,
							 pci_csezip,		pci_fwdtyp,	pci_fwdacc,                                                                                                                                                                                                                                              			
							 pci_fwddsc,	pci_fwditr,		pci_noptyp,                                                                                                                                                                                                                                              			
							 pci_nopadr,	pci_nopstt,		pci_nopcty,                                                                                                                                                                                                                                              			
							 pci_nopzip,	pci_noptil,		pci_nopphn,                                                                                                                                                                                                                                              			
							 pci_nopfax,	pci_nopeml,	pci_creusr,                                                                                                                                                                                                                                              			
							 pci_updusr)
						values	(@cocde,		@ret_code,		@pci_csenam,                                                                                                                                                    
							 @pci_cseadr,	@pci_csestt,	@pci_csecty,                                                                                                                                                    
							 @pci_csezip,	@pci_fwdtyp,	@pci_fwdacc,                                                                                                                                                    
							 @pci_fwddsc,	@pci_fwditr,	@pci_noptyp,                                                                                                                                                        
							 @pci_nopadr,	@pci_nopstt,	@pci_nopcty,                                                                                                                                                            
							 @pci_nopzip,	@pci_noptil,	@pci_nopphn,                                                                                                                                                            
							 @pci_nopfax,	@pci_nopeml,	'SCM02-SYS', 			
							 'SCM02-SYS')                                                                                                                                                                                                                                                        

						if @@ERROR <> 0                                                                                                                                                                                                                                          			
						begin
							 PRINT 'An error occurred when inserting into POCNTINF'                                                                                                                                                                                                				
							 RETURN(99)                                                                                                                                                                                                                                            			
						end

						--cur_SCORDDTLHDR --> cur_SCORDDTL --> cur_SCSHPMRK
						DECLARE		cur_SCSHPMRK CURSOR FOR
						SELECT   		ssm_shptyp,	ssm_engdsc,	ssm_chndsc,  
								ssm_engrmk,	ssm_chnrmk,	ssm_imgpth,  
								ssm_imgnam  
						FROM		SCSHPMRK (nolock)  
						WHERE		ssm_cocde = @cocde		AND
								ssm_ordno = @sco_ordno   
						OPEN		cur_SCSHPMRK  
						FETCH NEXT
						FROM		cur_SCSHPMRK
						INTO   		@psm_shptyp,   	@psm_engdsc,   	@psm_chndsc,   
								@psm_engrmk,   	@psm_chnrmk,   	@psm_imgpth,   
								@psm_imgnam   
	        
						WHILE @@fetch_status = 0  
						begin	       
							insert
							into	POSHPMRK
								(psm_cocde,	psm_purord,  	psm_shptyp,   
								 psm_engdsc,  	psm_chndsc,  	psm_engrmk,  
								 psm_chnrmk,  	psm_imgpth,  	psm_imgnam,  
								 psm_creusr,  	psm_updusr)
							values	(@cocde,  		@ret_code,  	@psm_shptyp,  
								 @psm_engdsc,  	@psm_chndsc,  	@psm_engrmk,  
								 @psm_chnrmk,  	@psm_imgpth,  	@psm_imgnam,  
								 'SCM02-SYS' , 	'SCM02-SYS')  
	
							if @@ERROR <> 0   
							begin
								PRINT 'An error occurred when inserting into POSHPMRK'  
								RETURN(99)  
							end	            

							FETCH NEXT
							FROM	cur_SCSHPMRK
							INTO   	@psm_shptyp,   	@psm_engdsc,   	@psm_chndsc,   
								@psm_engrmk,   	@psm_chnrmk,   	@psm_imgpth,   
								@psm_imgnam   
						end

						CLOSE cur_SCSHPMRK                                     
						DEALLOCATE cur_SCSHPMRK     
	      
						SET @hdr_upf = 'N'                                                                                                                                                                                                                                       
			                  
					end  -- End of (IF (@sdt_updpo = 'Y' AND @hdr_upf = 'Y') or (@sdt_chgfty = 'Y' AND @hdr_upf = 'Y')  )

					SET @pod_jobord = ''    
					set @pod_runno = ''  

					if @sdt_oldpurord <> ''   
					begin  
						select	@pod_jobord = pod_jobord,	@pod_runno = pod_runno,  	@sdt_rmk = pod_rmk  			 
						from	POORDDTL (nolock)  
						where	pod_cocde = @cocde		AND
							pod_purord = @sdt_oldpurord  	AND
							pod_purseq = @sdt_oldpurseq  
					end
                                                                                                                                                                                                                                        
					SET @pod_cocde  = @cocde                                                                                                                                                                                                                                  		  
					SET @pod_purord = @ret_code                                                                                                                                                                                                                               		  
					SET @pod_purseq = @seqno                                                                                                                                                                                                                                  		  
					SET @pod_itmno  = @sdt_itmno                                                                                                                                                                                                                              		  
					SET @pod_cusitm = @sdt_cusitm                                                                                                                                                                                                                             		  
					SET @pod_cussku = @sdt_cussku  
					SET @pod_engdsc = @sdt_itmdsc  
					SET @pod_prdven = @sdt_venno  
					SET @pod_prdsubcde = @sdt_subcde  
					SET @pod_seccusitm = @sdt_seccusitm  				
					SET @pod_vencol = ''                                                                                                                                                                                                                                      
	                              
					select	@pod_vencol = icf_vencol
					from	IMCOLINF (nolock)                                                                                                                                                                                                                                      		  
					where	icf_itmno = @sdt_itmno	AND
						icf_colcde = @sdt_colcde

					if @pod_vencol is NULL or @pod_vencol = ''  
					begin  
						Set @pod_vencol = @sdt_colcde  
					end                                                                                                                                                                                    
	                                   
					select	@pod_chndsc = ibi_chndsc  
					from	IMBASINF  
					where	ibi_itmno = @sdt_itmno   
		  
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
                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                         
					select	@VendorType = vbi_ventyp  
					from	vnbasinf
					where	vbi_venno = @sdt_cusven  

					set @rate_old = 0		

					select	@rate_old  = isnull(pod_curexrat,0)
					from	POORDDTL (nolock)
					where	pod_cocde = @cocde		and
						pod_purord = @ret_code	and
						pod_purseq = @seqno		and
						@sdt_fcurcde = pod_orgcur
	
					if @rate_old = 0
					begin
						SET @pod_ftyprc = @sdt_ftycst * @rate  
					end		
					else
					begin
						SET @pod_ftyprc = @sdt_ftycst * @rate_old  
					end

					SET @pod_cuspno = @sdt_cuspo                                                                                                                                                                                                                              		  
					SET @pod_respno = @sdt_resppo                                                                                                                                                                                                                             		  
					SET @pod_hrmcde = @sdt_hrmcde                                                                                                                                                                                                                             		  
					SET @pod_lblcde = @sdt_code1 + @sdt_code2 + @sdt_code3                                                                                                                                                                                                    		  
					SET @pod_cususd = @sdt_cususd                                                                                                                                                                                                                             		  
					SET @pod_cuscad = @sdt_cuscad                                                                                                                                                                                                                             		  

					--SET @pod_shpstr = @sdt_shpstr - @vbi_tsttim - @vbi_bufday
					--SET @pod_shpend = @sdt_shpend - @vbi_tsttim - @vbi_bufday

					SET @pod_shpstr = @sdt_shpstr - @csf_shpstrbuf
					SET @pod_shpend = @sdt_shpend - @csf_shpendbuf

					SET @pod_candat = @sdt_candat                                                                                                                                                                                                           


					if @sdt_candat <> '1900-01-01'  
					begin
						--SET @pod_candat = @sdt_candat - @vbi_tsttim - @vbi_bufday
						SET @pod_candat = @sdt_candat - @csf_cancelbuf
					end

					if GETDATE() > @pod_candat AND @pod_candat <> '1900-01-01'                                                                                                                                                                                                		                                  
					begin
						SET @pod_candat = GETDATE()                                                                                                                                                                                                                              		
					end
				          
					if GETDATE() > @pod_shpstr                                                                                                                                                                                                                                		  
					begin
						SET @pod_shpstr = GETDATE()                                                                                                                                                                                                                              		
					end
				          	                                                                                                                                                                                                                                                              	          
					if GETDATE() > @pod_shpend                                                                                                                                                                                                                                		  
					begin
						SET @pod_shpend = GETDATE()                                                                                                                                                                                                                              		
					end

					SET @pod_ctnstr = @sdt_ctnstr                                                                                                                                                                                                                             		  
					SET @pod_ctnend = @sdt_ctnend                                                                                                                                                                                                                             		  
					SET @pod_scno   = @sdt_ordno                                                                                                                                                                                                                              		  
					SET @pod_ttlctn = @sdt_ttlctn                                                                                                                                                                                                                             
					SET @pod_lneamt = round(@sdt_ordqty * @pod_ftyprc,2)                                                                                                                                                                                                      
					SET @pod_lnecub = @sdt_cft * @sdt_ttlctn                                                                                                                                                                                                                            
					SET @pod_ttlqty = 0                                                                                                                                                                                                                                       		  
					SET @pod_scline = @sdt_ordseq                                                                                                                                                                                                                             
					SET @pod_assflg = ''                                                                                                                                                                                                                                      		  
					SET @dtyrat = @sdt_dtyrat                                                                                                                                                                                                                             		  
					SET @typcode = @sdt_typcode                                                                                                                                                                                                                            		  
					SET @Code1 = @sdt_Code1                                                                                                                                                                                                                              		  
					SET @Code2 = @sdt_Code2                                                                                                                                                                                                                              		  
					SET @Code3 = @sdt_Code3  
					SET @pod_venitm = @sdt_venitm                                                                                                                                                                                                                             		   
					SET @pod_pckitr = @sdt_pckitr        

					--cur_SCORDDTLHDR --> cur_SCORDDTL
					if @sdt_updpo = 'Y'   
					begin
						update	POORDDTL 
						set	pod_itmsts = @sdt_itmsts,  	pod_venitm = @pod_venitm,  	pod_cusitm = @pod_cusitm,  
							pod_cussku = @pod_cussku,  	pod_engdsc = @pod_engdsc,  	pod_cuscol = @pod_cuscol,  
							pod_coldsc = @pod_coldsc,  	pod_cbm    = @pod_cbm,  	pod_cubcft = @pod_cubcft,  
							pod_dept   = @pod_dept,  	pod_ordqty = @pod_ordqty,  	pod_ftyprc = @pod_ftyprc,  
							pod_cuspno = @pod_cuspno,  	pod_respno = @pod_respno,  	pod_hrmcde = @pod_hrmcde,  
							pod_lblcde = @pod_lblcde,  	pod_cususd = @pod_cususd,  	pod_cuscad = @pod_cuscad,  
							pod_ctnstr = @pod_ctnstr,  	pod_ctnend = @pod_ctnend,  	pod_ttlctn = @pod_ttlctn,  
							pod_lneamt = @pod_lneamt,  	pod_lnecub = @pod_lnecub,  	pod_ttlqty = @pod_ttlqty,  
							pod_assflg = @pod_assflg,  	pod_dtyrat = @dtyrat,  		pod_typcode= @typcode,  
							pod_Code1  = @Code1,  	pod_Code2  = @Code2,  	pod_Code3  = @Code3,  
							pod_updusr = 'SCM02-SYS',  	pod_pckitr  = @pod_pckitr ,  	pod_prdven  = @pod_prdven,   
							pod_prdsubcde = @pod_prdsubcde, pod_seccusitm = @pod_seccusitm, pod_alsitmno = @sod_alsitmno , 
							pod_alscolcde = @sod_alscolcde,	pod_upddat = getdate(),	pod_orgcur  =@sdt_fcurcde,
							pod_curexrat = @rate,		pod_curexeffdat = @exeffdat,	pod_qutdat = @sod_qutdat,
							pod_imqutdat = @sod_imqutdat,	pod_cus1no = @sod_cus1no,	pod_cus2no = @sod_cus2no,
							pod_hkprctrm = @sod_hkprctrm,	pod_ftyprctrm = @sod_ftyprctrm,	pod_trantrm = @sod_trantrm,
							pod_effdat = @sod_effdat,	pod_expdat = @sod_expdat
						where	pod_cocde = @cocde		AND
							pod_purord = @ret_code	AND
							pod_purseq = @seqno   
	       
						if @@rowcount = 0   
						begin
							-- INSERT NEW PO DETAIL                                                                                                                                                                                                                                  	           
							insert
							into	POORDDTL
								(pod_cocde,	pod_purord,	pod_purseq,                                                                                                                                                                                                                                              				                                                                                                                                                                                                                                                       				                                            
								 pod_itmno,	pod_itmsts,	pod_venitm,
								 pod_cusitm,	pod_cussku,	pod_engdsc,                                                                                                                                                                                                                                              				                                                                                                                                                                                                                                                       				                                            
								 pod_chndsc,	pod_vencol,	pod_cuscol,                                                                                                                                                                                                                                              				                                                                                                                                                                                                                                                       				                                            
								 pod_coldsc,	pod_pckseq,	pod_untcde,                                                                                                                                                                                                                                              				                                                                                                                                                                                                                                                       				                                            
								 pod_inrctn,	pod_mtrctn,	pod_cubcft,                                                                                                                                                                                                                                              				                                                                                                                                                                                                                                                       				                                            
								 pod_cbm,		pod_dept,		pod_ordqty,                                                                                                                                                                                                                                              				                                                                                                                                                                                                                                                       				                                            
								 pod_recqty,	pod_ftyprc,		pod_cuspno,                                                                                                                                                                                                                                              				                                                                                                                                                                                                                                                       				                                            
								 pod_respno,	pod_hrmcde,	pod_lblcde,                                                                                                                                                                                                                                              				                                                                                                                                                                                                                                                       				                                            
								 pod_cususd,	pod_cuscad,	pod_shpstr,                                                                                                                                                                                                                                              				                                                                                                                                                                                                                                                       				                                            
								 pod_shpend,	pod_candat,	pod_ctnstr,                                                                                                                                                                                                                                              				                                                                                                                                                                                                                                                       				                                            
								 pod_ctnend,	pod_scno,		pod_ttlctn,                                                                                                                                                                                                                                              				                                                                                                                                                                                                                                                       				                                            
								 pod_lneamt,	pod_lnecub,	pod_ttlqty,                                                                                                                                                                                                                                              				                                                                                                                                                                                                                                                       				                                            
								 pod_scline,	pod_jobord,	pod_runno,  
								 pod_assflg,	pod_dtyrat,		pod_typcode,                                                                                                                                                                                                                                             				                                                                                                                                                                                                                                                       				                 
								 pod_Code1,	pod_Code2,	pod_Code3,                                                                                                                                                                                                                                               				                                                                                                                                                                                                                                                       				                                            
								 pod_creusr,	pod_updusr,	pod_pckitr,  
								 pod_rmk,		pod_prdven,	pod_prdsubcde,  
								 pod_seccusitm,	pod_alsitmno,	pod_alscolcde,
								 pod_orgcur,	pod_curexrat,	pod_curexeffdat,
								 pod_qutdat,	pod_imqutdat,	pod_cus1no,
								 pod_cus2no,	pod_hkprctrm,	pod_ftyprctrm,
								 pod_trantrm,	pod_effdat,		pod_expdat)
							values	(@pod_cocde,	@pod_purord,	@pod_purseq,                                                                                                                                                                                                                                             								
								 @pod_itmno,	@sdt_itmsts,	@pod_venitm,                                                                                                                                                                                                                                             				
								 @pod_cusitm,	@pod_cussku,	@pod_engdsc,                                                                                                                                                                                                                                             				
								 @pod_chndsc,	@pod_vencol,	@pod_cuscol,                                                                                                                                                                                                                                             				
								 @pod_coldsc,	@pod_pckseq,	@pod_untcde,                                                                                                                                                                                                                                             				
								 @pod_inrctn,	@pod_mtrctn,	@pod_cubcft,                                                                                                                                                                                                                                             				
								 @pod_cbm,	@pod_dept,	@pod_ordqty - @pod_recqty,                                                                                                                                                                                                                               				        
								 0,		@pod_ftyprc,	@pod_cuspno,                                                                                                                                                                                                                                             				
								 @pod_respno,	@pod_hrmcde,	@pod_lblcde,                                                                                                                                                                                                                                             				
								 @pod_cususd,	@pod_cuscad,	@pod_shpstr,                                                                                                                                                                                                                                             				
								 @pod_shpend,	@pod_candat,	@pod_ctnstr,                                                                                                                                                                                                                                             				
								 @pod_ctnend,	@pod_scno,	@pod_ttlctn,                                                                                                                                                                                                                                             				
								 @pod_lneamt,	@pod_lnecub,	@pod_ttlqty,                                                                                                                                                                                                                                             				
								 @pod_scline,	@pod_jobord,	@pod_runno,                                                                                                                                                                                                                                              				
								 @pod_assflg,	@dtyrat,		@typcode,                                                                                                                                                                                                                                                				
								 @Code1,		@Code2,		@Code3,                                                                                                                                                                                                                                                  				
								 'SCM02-SYS',	'SCM02-SYS',	@pod_pckitr,  
								 @sdt_rmk,	@pod_prdven,	@pod_prdsubcde,  
								 @pod_seccusitm,	@sod_alsitmno,	@sod_alscolcde,
								 @sdt_fcurcde,	@rate,		@exeffdat,
								 @sod_qutdat,	@sod_imqutdat,	@sod_cus1no,
								 @sod_cus2no,	@sod_hkprctrm,	@sod_ftyprctrm,
								 @sod_trantrm,	@sod_effdat,	@sod_expdat)      
						end  -- End of (IF @@rowcount = 0)
	         
						if @@ERROR <> 0                                                                                                                                                                                                                                         			    
						begin
							 PRINT 'An error occurred when inserting into POORDDTL'                                                                                                                                                                                                				   
							 RETURN(99)                                                                                                                                                                                                                                            			   
						end
					end  -- End of (IF @sdt_updpo = 'Y')
    
					--- Change Factory ----  
					if @sdt_chgfty = 'Y'  
					begin
						select	@pod_chndsc=pod_chndsc,  	@pod_shpstr=pod_shpstr,  	@pod_shpend=pod_shpend,  
							@pod_candat=pod_candat,  	@sdt_rmk=pod_rmk  
						from	POORDDTL (nolock)   
						where   	pod_cocde = @cocde		and
							pod_purord = @sdt_oldpurord	and  
							pod_purseq = @sdt_oldpurseq
	       
						update	POORDDTL
						set	pod_itmsts = @sdt_itmsts,  	pod_venitm = @pod_venitm,  	pod_cusitm = @pod_cusitm,  
							pod_cussku = @pod_cussku,  	pod_engdsc = @pod_engdsc,  	pod_cuscol = @pod_cuscol,  
							pod_coldsc = @pod_coldsc,	pod_cbm    = @pod_cbm,  	pod_dept   = @pod_dept,  
							pod_ordqty = @pod_ordqty,  	pod_ftyprc = @pod_ftyprc,  	pod_cuspno = @pod_cuspno,  
							pod_respno = @pod_respno,  	pod_hrmcde = @pod_hrmcde,  	pod_lblcde = @pod_lblcde,  
							pod_cususd = @pod_cususd,  	pod_cuscad = @pod_cuscad,  	pod_shpstr = @pod_shpstr,  
							pod_shpend = @pod_shpend,  	pod_candat = @pod_candat,  	pod_ctnstr = @pod_ctnstr,  
							pod_ctnend = @pod_ctnend,  	pod_ttlctn = @pod_ttlctn,  	pod_lneamt = @pod_lneamt,  
							pod_lnecub = @pod_lnecub,  	pod_ttlqty = @pod_ttlqty,  	pod_assflg = @pod_assflg,  
							pod_dtyrat = @dtyrat,  		pod_typcode= @typcode,  	pod_Code1  = @Code1,  
							pod_Code2  = @Code2,  	pod_Code3  = @Code3,  	pod_updusr = 'SCM02-SYS', 
							pod_pckitr  = @pod_pckitr,  	pod_prdven  = @pod_prdven,   	pod_prdsubcde = @pod_prdsubcde,  
							pod_seccusitm = @pod_seccusitm, pod_alsitmno = @sod_alsitmno,	pod_alscolcde = @sod_alscolcde,
							pod_orgcur  =@sdt_fcurcde,	pod_curexrat = @rate,		pod_curexeffdat = @exeffdat,
							pod_qutdat = @sod_qutdat,	pod_imqutdat = @sod_imqutdat,	pod_cus1no = @sod_cus1no,
							pod_cus2no = @sod_cus2no,	pod_hkprctrm = @sod_hkprctrm,	pod_ftyprctrm = @sod_ftyprctrm,
							pod_trantrm = @sod_trantrm,	pod_effdat = @sod_effdat,	pod_expdat = @sod_expdat
						where	pod_cocde = @cocde		AND
							pod_purord = @ret_code	AND
							pod_purseq = @seqno   

						if @@rowcount = 0   
						begin
							-- INSERT NEW PO DETAIL                                                                                                                                                                                                                                  	           
							insert
							into	POORDDTL
								(pod_cocde,	pod_purord,	pod_purseq,                                                                                                                                                                                                                                              				                                                                                                                                                                                                                        
								 pod_itmno,	pod_itmsts,	pod_venitm,                                                                                                                                                                                                                                              				                                                                                                                                                                                                                                                       				                                            
								 pod_cusitm,	pod_cussku,	pod_engdsc,                                                                                                                                                                                                                                              				                                                                                                                                                                                                                                                       				                                            
								 pod_chndsc,	pod_vencol,	pod_cuscol,                                                                                                                                                                                                                                              				                                                                                                                                                                                                                                                       				                                            
								 pod_coldsc,	pod_pckseq,	pod_untcde,                                                                                                                                                                                                                                              				                                                                                                                                                                                                                                                       				                                            
								 pod_inrctn,	pod_mtrctn,	pod_cubcft,                                                                                                                                                                                                                                              				                                                                                                                                                                                                                                                       				                                            
								 pod_cbm,		pod_dept,		pod_ordqty,                                                                                                                                                                                                                                              				                                                                                                                                                                                                                                                       				                                            
								 pod_recqty,	pod_ftyprc,		pod_cuspno,                                                                                                                                                                                                                                              				                                                                                                                                                                                                                                                       				                                            
								 pod_respno,	pod_hrmcde,	pod_lblcde,                                                                                                                                                                                                                                              				                                                                                                                                                                                                                                                       				                                            
								 pod_cususd,	pod_cuscad,	pod_shpstr,                                                                                                                                                                                                                                              				                                                                                                                                                                                                                                                       				                                            
								 pod_shpend,	pod_candat,	pod_ctnstr,                                                                                                                                                                                                                                              				                                                                                                                                                                                                                                                       				                                            
								 pod_ctnend,	pod_scno,		pod_ttlctn,                                                                                                                                                                                                                                              				                                                                                                                                                                                                                                                       				                                            
								 pod_lneamt,	pod_lnecub,	pod_ttlqty,                                                                                                                                                                                                                                              				                                                                                                                                                                                                                   
								 pod_scline,	pod_jobord,	pod_runno,                                                                                                                                                                                                                                               				                                                                                                                                                                                                                                                       				                                           
								 pod_assflg,	pod_dtyrat,		pod_typcode,                                                                                                                                                                                                                                             				                                                                                                                                                                                                                                                       				                                            
								 pod_Code1,	pod_Code2,	pod_Code3,                                                                                                                                                                                                                                               				                                                                                                                                                                                                                                                       				                                            
								 pod_creusr,	pod_updusr,	pod_pckitr,  
								 pod_rmk,		pod_prdven,	pod_prdsubcde,  
								 pod_seccusitm,	pod_alsitmno,	pod_alscolcde,
								 pod_orgcur,	pod_curexrat,	pod_curexeffdat,
								 pod_qutdat,	pod_imqutdat,	pod_cus1no,
								 pod_cus2no,	pod_hkprctrm,	pod_ftyprctrm,
								 pod_trantrm,	pod_effdat,		pod_expdat)
							values	(@pod_cocde,	@pod_purord,	@pod_purseq,                                                                                                                                                                                                                                             				
								 @pod_itmno,	@sdt_itmsts,	@pod_venitm,                                                                                                                                                                                                                                             				
								 @pod_cusitm,	@pod_cussku,	@pod_engdsc,                                                                                                                                                                                                                                             				
								 @pod_chndsc,	@pod_vencol,	@pod_cuscol,                                                                                                                                                                                                                                             				
								 @pod_coldsc,	@pod_pckseq,	@pod_untcde,                                                                                                                                                                                                                                             				
								 @pod_inrctn,	@pod_mtrctn,	@pod_cubcft,                                                                                                                                                                                                                                            				
								 @pod_cbm,	@pod_dept,	@pod_ordqty - @pod_recqty,                                                                                                                                                                                                                               				        
								 0,		@pod_ftyprc,	@pod_cuspno,                                                                                                                                                                                                                                             				
								 @pod_respno,	@pod_hrmcde,	@pod_lblcde,                                                                                                                                                                                                                                             				
								 @pod_cususd,	@pod_cuscad,	@pod_shpstr,                                                                                                                                                                                                                                             				
								 @pod_shpend,	@pod_candat,	@pod_ctnstr,                                                                                                                                                                                                                                            				
								 @pod_ctnend,	@pod_scno,	@pod_ttlctn,                                                                                                                                                                                                                                             				
								 @pod_lneamt,	@pod_lnecub,	@pod_ttlqty,                                                                                                                                                                                                                                             				
								 @pod_scline,	@pod_jobord,  	@pod_runno,                                                                                                                                                                                                                                              				
								 @pod_assflg,	@dtyrat,		@typcode,                                                                                                                                                                                                                                                				
								 @Code1,		@Code2,		@Code3,                                                                                                                      
								 'SCM02-SYS',	'SCM02-SYS',	@pod_pckitr,  
								 @sdt_rmk,	@pod_prdven,	@pod_prdsubcde,  
								 @pod_seccusitm,	@sod_alsitmno,	@sod_alscolcde,
								 @sdt_fcurcde,	@rate,		@exeffdat,
								 @sod_qutdat,	@sod_imqutdat,	@sod_cus1no,
								 @sod_cus2no,	@sod_hkprctrm,	@sod_ftyprctrm,
								 @sod_trantrm,	@sod_effdat,	@sod_expdat)
						end
         
						if @@ERROR <> 0                                                                                                                                                                                                                                         			    
						begin
							 PRINT 'An error occurred when inserting into POORDDTL'                                                                                                                                                                                                				   
							 RETURN(99)                                                                                                                                                                                                                                            			   
						end
					end -- End of (IF  @sdt_chgfty = 'Y')
                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                         
					--cur_SCORDDTLHDR --> cur_SCORDDTL -->  cur_SCASSINF   
					DECLARE	cur_SCASSINF CURSOR
					FOR
					select	sai_itmno,		sai_assitm,		sai_assdsc,                                                                                                                                                                                                                                      
						sai_cusitm,		sai_colcde,		sai_coldsc,                                                                                                                                                                                                                                               		 
						sai_cussku,		sai_upcean,		sai_cusrtl,                                                                                                                                                                                                                                               		  
						sai_untcde,		sai_inrqty,		sai_mtrqty,
						sai_imperiod                                                                                                                                                                                                                                          		  
					from	SCASSINF (nolock)                                                                                                                                                                                                                                             		  
					where	sai_cocde = @cocde		AND
						sai_ordno = @sdt_ordno	AND
						sai_ordseq = @sdt_ordseq
					OPEN	cur_SCASSINF                                                                                                                                                                                                                                         	  
					FETCH NEXT
					FROM	cur_SCASSINF
					INTO	@pda_itmno,	@pda_assitm,	@pda_assdsc,                                                                                                                                                                                                                                              		  
						@pda_cusitm,	@pda_colcde,	@pda_coldsc,                                                                                                                                                                                                                                              		
						@pda_cussku,	@pda_upcean,	@pda_cusrtl,                                                                                                                                                                                                                                              		  
						@pda_pckunt,	@pda_inrqty,	@pda_mtrqty,
						@pda_imperiod

					WHILE @@fetch_status = 0                                                                                                                                                                                                                                  		  
					begin
						if @sdt_updpo = 'Y' or @sdt_chgfty = 'Y'
						begin
							insert
							into	PODTLASS
								(pda_cocde,	pda_purord,	pda_seq,
								 pda_itmno,	pda_assitm,	pda_assdsc,                                                                                                                                                                                                                                             				
								 pda_cusitm,	pda_colcde,	pda_coldsc,                                                                                                                                                                                                                                             				
								 pda_cussku,	pda_upcean,	pda_cusrtl,                                                                                                                                                                                                                                             				
								 pda_pckunt,	pda_inrqty,		pda_mtrqty,                                                                                                                                                                                                                                     				
								 pda_creusr,	pda_updusr,	pda_imperiod)
							values	(@cocde,		@ret_code,		@seqno,                                                                                                                                                                                                                                                 				
								 @pda_itmno,	@pda_assitm,	@pda_assdsc,                                                                                                                                                                                                                                            				
								 @pda_cusitm,	@pda_colcde,	@pda_coldsc,                                                                                                                                                                                                                                            				
								 @pda_cussku,	@pda_upcean,	@pda_cusrtl,                                                                                                                                                                                                                                            				
								 @pda_pckunt,	@pda_inrqty,	@pda_mtrqty,                                                                                                                                                                                                                                            				
								 'SCM02-SYS',	'SCM02-SYS',	@pda_imperiod)                                                                                                                                                                                                                                                       

							if @@ERROR <> 0                                                                                                                                                                                                                                         				
							begin
								  PRINT 'An error occurred when inserting into PODTLASS'                                                                                                                                                                                               					
								  RETURN(99)                                                                                                                                                                                                                                           				
							end
						end  -- End of (IF @sdt_updpo = 'Y'  or @sdt_chgfty = 'Y'  )                                                                                                                                                                                                                                                    
	                                                                                                                                                                                                                                        
						--cur_SCORDDTLHDR --> cur_SCORDDTL -->  cur_SCASSINF -->  cur_BOM2	                                                                                                                                                       
						DECLARE	cur_BOM2 CURSOR                                                                                                                                                                                                                                 			
						FOR
						select	sbi_assitm,		sbi_bomitm,	sbi_pckunt,    
							sbi_ordqty,		sbi_venno,		sbi_fcurcde,  
							sbi_ftyprc,		sbi_colcde,		vbi_curcde,   
							sbi_bcurcde,	sbi_bomcst,	sbi_bompoflg,
							sbi_imperiod
						from	SCBOMINF (nolock),	VNBASINF (nolock)   
						where	sbi_cocde = @cocde		AND
							sbi_ordno = @sdt_ordno	AND
							sbi_ordseq = @sdt_ordseq	AND
							vbi_venno = sbi_venno	AND
							sbi_assitm = @pda_assitm
						OPEN	cur_BOM2                                                                                                                                                                                                                                            			
						FETCH NEXT
						FROM	cur_BOM2
						INTO	@pdb_assitm,	@pdb_assitm,	@pdb_pckunt,                                                                                                                                                                                                                   			                      
							@pdb_bomqty, 	@pdb_venno, 	@pdb_bcurcde,                                                                                                                                                                                                                   			                      
							@pdb_bomcst, 	@pdb_colcde, 	@vbi_curcde,  
							@pdb_curcde, 	@pdb_ftyprc, 	@pdb_bompoflg,
							@pdb_imperiod                                                                                                                                                                                                                                        			

						WHILE @@fetch_status = 0                                                                                                                                                                                                                                 			
						begin
							SET @pdb_ordqty = (@pod_ordqty * @pda_mtrqty)/@pod_mtrctn * @pdb_bomqty                                                                                                                                                                                 

							if @sdt_updpo = 'Y'  or @sdt_chgfty = 'Y'  	  	  
							begin
								execute SP_SELECT_MEXRATE @cocde, @pdb_bcurcde, @vbi_curcde, "B", '', @return_effdat = @exeffdat output,@return_rate = @rate output      

								set @rateffdat = @exeffdat	                                                                                                                                                        
								set @rate1 = 0  

								execute SP_SELECT_MEXRATE @cocde, @pdb_curcde, @vbi_curcde, "B", '', @return_effdat = @exeffdat output,@return_rate = @rate1 output  
	
								select	@ftyexrate_old = isnull(pdb_ftycurexrat,0),	@bomexrate_old = isnull(pdb_bomcurexrat,0)
								from	PODTLBOM (nolock)
								where	pdb_cocde = @cocde		AND
									pdb_purord = @ret_code	AND
									pdb_seq = @seqno		AND
									pdb_assitm = @pda_assitm	AND
									pdb_bomitm = @pdb_assitm	AND
									pdb_colcde = @pdb_colcde

								if @ftyexrate_old <> 0 
								begin
									set @rate1 = @ftyexrate_old	
								end

								if @bomexrate_old <> 0 
								begin
									set @rate = @bomexrate_old	
								end
					
								update	PODTLBOM  
								set	 pdb_ordqty = @pdb_ordqty,  	 pdb_imcurcde  = @pdb_curcde,		pdb_imftyprc  =   @pdb_ftyprc,   
									 pdb_curcde = @vbi_curcde,  	 pdb_ftyprc  =  @pdb_ftyprc*@rate1,     	pdb_bcurcde = @pdb_bcurcde,  
									 pdb_bomcst =  @pdb_bomcst*@rate, pdb_pckunt = @pdb_pckunt,  		pdb_bomqty  = @pdb_bomqty,   
									 pdb_venno = @pdb_venno,   	 pdb_upddat = GETDATE(),  		pdb_updusr = 'SCM02-SYS', 
									 pdb_bompoflg = @pdb_bompoflg, pdb_imperiod = @pdb_imperiod
								where	 pdb_cocde = @cocde		AND
									 pdb_purord = @ret_code	AND
									 pdb_seq = @seqno		AND
									 pdb_assitm = @pda_assitm	AND
									 pdb_bomitm = @pdb_assitm	AND
									 pdb_colcde = @pdb_colcde  

								if @@rowcount = 0  
								begin
									insert
									into	PODTLBOM   
										(pdb_cocde,	pdb_purord,	pdb_seq,
										 pdb_assitm,  	pdb_bomitm, 	pdb_colcde,
								 		 pdb_pckunt, 	pdb_bomqty,	pdb_venno,
								 		 pdb_curcde, 	pdb_imcurcde,	pdb_imftyprc,          
										 pdb_ftyprc,  	pdb_bcurcde, 	pdb_bomcst,
								 		 pdb_ordqty,	pdb_bpolne,	pdb_bompno,
								 		 pdb_creusr,	pdb_updusr, 	pdb_bompoflg,
									 	 pdb_ftycurexrat, 	pdb_ftycurexeffdat,	pdb_bomcurexrat, 
										 pdb_bomcurexeffdat,	pdb_imperiod)   
									values	 (@cocde,  		@ret_code,  	@seqno,
							  			 @pda_assitm,	@pdb_assitm,	@pdb_colcde,
								 		 @pdb_pckunt, 	@pdb_bomqty,	@pdb_venno,
								 		 @vbi_curcde, 	@pdb_curcde,	@pdb_ftyprc,                                                                                                                                                                                                    						                                    
										 @pdb_ftyprc*@rate1,	@pdb_bcurcde, 	@pdb_bomcst*@rate,
										 @pdb_ordqty,	0,		'',
						  				 'SCM02-SYS',	'SCM02-SYS',	 @pdb_bompoflg,
									 	 @rate1, 		@exeffdat, 		@rate, 
										 @rateffdat,	@pdb_imperiod)  
								end

								if @@ERROR <> 0                                                                                                                                                                                                                                        					
								begin
									   PRINT 'An error occurred when inserting into PODTLBOM'                                                                                                                                                                                              						
									   RETURN(99)                                                                                                                                                                                                                                          					
								end
							end -- End of (IF @sdt_updpo = 'Y'  or @sdt_chgfty = 'Y' )

							FETCH NEXT
							FROM	cur_BOM2
							INTO	@pdb_assitm,	@pdb_assitm,	@pdb_pckunt,                                                                                                                                                                                                                   			                      
								@pdb_bomqty, 	@pdb_venno, 	@pdb_bcurcde,                                                                                                                                                                                                                   			                      
								@pdb_bomcst,	@pdb_colcde, 	@vbi_curcde,  
								@pdb_curcde, 	@pdb_ftyprc,	@pdb_bompoflg,
								@pdb_imperiod
						end

						CLOSE cur_BOM2                                                                                                                                                                                                                                           			
						DEALLOCATE cur_BOM2                                                                                                                                                                                                                                      
	                                                                                                                                                                                                                                                               	       
						FETCH NEXT
						FROM	cur_SCASSINF
						INTO	@pda_itmno,	@pda_assitm,	@pda_assdsc,                                                                                                                                                                                                                                             		
							@pda_cusitm,	@pda_colcde,	@pda_coldsc,                                                                                                                                                                                                                                             		
							@pda_cussku,	@pda_upcean,	@pda_cusrtl,                                                                                                                                                                                                                                             		
							@pda_pckunt,	@pda_inrqty,	@pda_mtrqty,
							@pda_imperiod
					end

					CLOSE cur_SCASSINF                                                                                                                                                                                                                                        		  
					DEALLOCATE cur_SCASSINF                                                                                                                                                                                                                                   

					--cur_SCORDDTLHDR --> cur_SCORDDTL --> cur_SCDTLCTN         
					DECLARE	cur_SCDTLCTN CURSOR
					FOR
					SELECT	sdc_ctnseq,		sdc_from,		sdc_to,                                                                                                                                                                                                                                                   		  
						sdc_ttlctn                                                                                                                                                                                                                                                		  
					FROM	SCDTLCTN                                                                                                                                                                                                                                             		  
					WHERE	sdc_cocde = @cocde		AND
						sdc_ordno = @sdt_ordno	AND
						sdc_seq = @sdt_ordseq
					OPEN	cur_SCDTLCTN                                                                                                                                                                                                                                         		  
					FETCH NEXT
					FROM	cur_SCDTLCTN
					INTO	@pdc_seq,		@pdc_from,	@pdc_to,                                                                                                                                                                                                                                                  		
						@pdc_ttlctn                                                                                                                                                                                                                                               	          	                                                                                                                                                                                                                                                               	          

					WHILE @@fetch_status = 0                                                                                                                                                                                                                                  		  
					begin
						if @sdt_updpo = 'Y'  or @sdt_chgfty = 'Y'  
						begin
							insert
							into	PODTLCTN
								(pdc_cocde,	pdc_purord,	pdc_seq,                                                                                                                                                                                                                                                				
								 pdc_from,		pdc_to,		pdc_ttlctn,                                                                                                                                                                                                                                             				
								 pdc_ctnseq,	pdc_creusr,		pdc_updusr)
							values	(@cocde,		@ret_code,		@seqno,                                                                                                                                                                                                                                                 				
								 @pdc_from,	@pdc_to,		@pdc_ttlctn,                                                                                                                                                                                                                                            				
								 @pdc_seq,	'SCM02-SYS',	'SCM02-SYS')                                                                                                                                                                                                                                                       	        	                                                                                                                                                                                                                                                               
	        
							if @@ERROR <> 0                                                                                                                                                                                                                           
							begin
								PRINT 'An error occurred when inserting into PODTLCTN'                                                                                                                                                                                               					
								RETURN(99)                                                                                                                                                                                                                                           				
							end
						end --End of (IF @sdt_updpo = 'Y'  or @sdt_chgfty = 'Y'  )

						FETCH NEXT
						FROM	cur_SCDTLCTN
						INTO	@pdc_seq,		@pdc_from,	@pdc_to,                                                                                                                                                                                                                                                 		
							@pdc_ttlctn                                                                                                                                                                                                                                              		
					end

					CLOSE cur_SCDTLCTN                                                                                                                                                                                                                                        		  
					DEALLOCATE cur_SCDTLCTN                                                                                                                                                                                                                                   

					--cur_SCORDDTLHDR --> cur_SCORDDTL --> cur_SCDTLSHP   	  
					DECLARE	cur_SCDTLSHP CURSOR                                                                                                                                                                                                                               		  
					FOR
					SELECT	sds_shpseq,	sds_from,		sds_to,                                                                                                                                                                                                                                                   		  
						sds_ttlctn                                                                                                                                                                                                                                                		  
					FROM	SCDTLSHP (nolock)                                                                                                                                                                                                                                             		  
					WHERE	sds_cocde = @cocde		AND
						sds_ordno = @sdt_ordno	AND
						sds_seq = @sdt_ordseq
					OPEN	cur_SCDTLSHP                                                                                                                                                                                                                                         		  
					FETCH NEXT
					FROM	cur_SCDTLSHP
					INTO	@pds_seq,		@pds_from,	@pds_to,                                                                                                                                                                                                                                                  		
						@pds_ttlctn                                                                                                                                           		                                                                                                                                                                                                                                                      

					WHILE @@fetch_status = 0                                                                                                                                                                                                                                  	          
					begin
						if @sdt_updpo = 'Y'    
						begin
							/*
							insert
							into	PODTLSHP
								(pds_cocde,	pds_purord,	pds_seq,                                                                                                                                                                             
								 pds_from,		pds_to,		pds_ttlctn,                                                                                                                                                                                                                                             				
								 pds_shpseq,	pds_creusr,		pds_updusr)
							values	(@cocde,		@ret_code,		@seqno,                                                                                                                                                                                                                                                 				
								 case when GETDATE() > @pds_from - @vbi_tsttim - @vbi_bufday then convert(nvarchar,getdate(),23)
								        else @pds_from - @vbi_tsttim - @vbi_bufday
								        end,		case when GETDATE() > @pds_to - @vbi_tsttim - @vbi_bufday then convert(nvarchar,getdate(),23)
										       else @pds_to - @vbi_tsttim - @vbi_bufday
										       end,		@pds_ttlctn,                                                                                                                                                                                                                                            				
								@pds_seq,		'SCM02-SYS',	'SCM02-SYS')                                                                                                                                                                                                                                                       
							*/
							insert
							into	PODTLSHP
								(pds_cocde,	pds_purord,	pds_seq,
								 pds_from,		pds_to,		pds_ttlctn,
								 pds_shpseq,	pds_creusr,		pds_updusr)
							values	(@cocde,		@ret_code,		@seqno,
								 case when GETDATE() > @pds_from - @csf_shpstrbuf then convert(nvarchar,getdate(),23)
								        else @pds_from - @csf_shpstrbuf
								        end,		case when GETDATE() > @pds_to - @csf_shpendbuf then convert(nvarchar,getdate(),23)
										       else @pds_to - @csf_shpendbuf
										       end,		@pds_ttlctn,
								@pds_seq,		'SCM02-SYS',	'SCM02-SYS')

							if @@ERROR <> 0                                                                                                                                                                                                                                         				
							begin
								PRINT 'An error occurred when inserting into PODTLSHP'                                                                                                                                                                                               					
								RETURN(99)                                                                                                                                                                  
							end
						end  -- End of (IF @sdt_updpo = 'Y') 

						FETCH NEXT
						FROM	cur_SCDTLSHP
						INTO	@pds_seq,		@pds_from,	@pds_to,                                                                                                                                                                                                                                                 		
							@pds_ttlctn                                                                                                                                                                                                                                              		
					end                                                                                                                                                                                                                                                       		  		                                                                                                                                                                                                                                                       		  

					CLOSE cur_SCDTLSHP                                                                                                                                                                                                                                        		  
					DEALLOCATE cur_SCDTLSHP                                                                                                                                                                                                                                   

					if  @sdt_chgfty = 'Y'  
					begin  
						insert
						into	PODTLSHP 
							(pds_cocde,	pds_purord,	pds_seq,                                                                                                                                                                             
							 pds_from,		pds_to,		pds_ttlctn,                                                                                                                                                                                                                                              			
							 pds_shpseq,	pds_creusr,		pds_updusr)   

						select	@cocde,		@ret_code,		@seqno,  
							pds_from,		pds_to,		pds_ttlctn,                                                                                                                                                                                                                                             			
							pds_shpseq,	'SCM02-SYS',	'SCM02-SYS' 
						from	PODTLSHP   
						where	pds_purord = @sdt_oldpurord	AND
							pds_seq = @sdt_oldpurseq                                                                                                                                                                                                                                

						if @@ERROR <> 0                                                                                                                                                                                                                                          			
						begin
							 PRINT 'An error occurred when inserting into PODTLSHP'                                                                                                                                                                                                				
							 RETURN(99)                                                                                                                                                                                                                                            			
						end
					end
	  
					--- Cater Regular Item with BOM Only ---  		
					--cur_SCORDDTLHDR --> cur_SCORDDTL --> cur_BOM1   	  
					DECLARE	cur_BOM1 CURSOR                                                                                                                                                                                                                                   		  
					FOR	  
					SELECT	sbi_assitm,  	sbi_bomitm,  	sbi_pckunt,    
						sbi_ordqty,  	sbi_venno,  	sbi_fcurcde,  
						sbi_ftyprc,   	sbi_colcde,   	vbi_curcde,   
						sbi_bcurcde,  	sbi_bomcst,	sbi_bompoflg,
						sbi_imperiod
					from	SCBOMINF (nolock), VNBASINF (nolock)   
					where	sbi_cocde = @cocde		AND
						sbi_ordno = @sdt_ordno	AND
						sbi_ordseq = @sdt_ordseq	AND
						vbi_venno = sbi_venno	AND
						ltrim(rtrim(sbi_assitm)) = ''
					OPEN	cur_BOM1                                                                                                                                                                                                                                             		  
					FETCH NEXT
					FROM	cur_BOM1
					INTO	@pda_assitm,	@pdb_assitm, 	@pdb_pckunt,                                                                                                                                                                                                                    			                     
						@pdb_bomqty, 	@pdb_venno, 	@pdb_bcurcde,                                                                                                                                                                                                                    			                     
						@pdb_bomcst, 	@pdb_colcde, 	@vbi_curcde,  
						@pdb_curcde, 	@pdb_ftyprc, 	@pdb_bompoflg,
						@pdb_imperiod

					WHILE @@fetch_status = 0                                                                                                                                                                                                                                  		  
					begin
						SET @pdb_ordqty = @pod_ordqty * @pdb_bomqty                                                                                                                                                                                                              						

						if @sdt_updpo = 'Y'  or @sdt_chgfty = 'Y'  
						begin
							set @rate1 = 0  

							execute SP_SELECT_MEXRATE @cocde, @pdb_bcurcde, @vbi_curcde, "B", '', @return_effdat = @exeffdat output,@return_rate = @rate1 output                                                                                                                                                                     

							select	@ftyexrate_old = isnull(pdb_ftycurexrat,0),	@bomexrate_old = isnull(pdb_bomcurexrat,0)
							from	PODTLBOM
							where	pdb_cocde = @cocde		AND
								pdb_purord = @ret_code	AND
								pdb_seq = @seqno		AND
								pdb_assitm = @pda_assitm	AND 
								pdb_bomitm = @pdb_assitm	AND  
								pdb_colcde = @pdb_colcde  

							if @ftyexrate_old <> 0 
							begin
								set @rate1 = @ftyexrate_old	
							end
	
							if @bomexrate_old <> 0 
							begin
								set @rate = @bomexrate_old	
							end
		
							update	PODTLBOM  
							set	pdb_ordqty = @pdb_ordqty,  	pdb_imcurcde  = @pdb_curcde,  		pdb_imftyprc  =   @pdb_ftyprc,   
								pdb_curcde = @vbi_curcde,  	pdb_ftyprc  =  @pdb_ftyprc*@rate1,     	pdb_bcurcde = @pdb_bcurcde,  
								pdb_bomcst =  @pdb_bomcst*@rate, pdb_pckunt = @pdb_pckunt,  		pdb_bomqty  = @pdb_bomqty,   
								pdb_venno = @pdb_venno,   	pdb_upddat = GETDATE(),  		pdb_updusr = 'SCM02-SYS' , 
								pdb_bompoflg = @pdb_bompoflg, pdb_imperiod = @pdb_imperiod
							where	pdb_cocde = @cocde		AND
								pdb_purord = @ret_code 	AND  
								pdb_seq = @seqno 		AND  
								pdb_assitm = @pda_assitm 	AND  
								pdb_bomitm = @pdb_assitm 	AND  
								pdb_colcde = @pdb_colcde  

							if @@rowcount = 0  
							begin
								insert
								into	PODTLBOM   
									(pdb_cocde,  	pdb_purord,	pdb_seq,
							  		 pdb_assitm,	pdb_bomitm, 	pdb_colcde,
							 		 pdb_pckunt, 	pdb_bomqty,	pdb_venno,
							 		 pdb_curcde, 	pdb_imcurcde,	pdb_imftyprc,         
									 pdb_ftyprc,  	pdb_bcurcde,	pdb_bomcst,
							 		 pdb_ordqty,	pdb_bpolne, 	pdb_bompno,
							 		 pdb_creusr,	pdb_updusr,	pdb_bompoflg,
							 		 pdb_ftycurexrat, 	pdb_ftycurexeffdat,	pdb_bomcurexrat, 
									 pdb_bomcurexeffdat,	pdb_imperiod)   
								values	(@cocde,		@ret_code,  	@seqno,
						  			 @pda_assitm,	@pdb_assitm,	@pdb_colcde,
							 		 @pdb_pckunt, 	@pdb_bomqty,	@pdb_venno,
							 		 @vbi_curcde, 	@pdb_curcde,	@pdb_ftyprc,                                                                                                                                                                                                     					                                   
									 @pdb_ftyprc*@rate1,	@pdb_bcurcde, 	@pdb_bomcst*@rate,
									 @pdb_ordqty,	0,  		'',
									 'SCM02-SYS',	'SCM02-SYS',	@pdb_bompoflg,
								 	 @rate1,		@exeffdat,		@rate,
									 @rateffdat,	@pdb_imperiod)  
							end

							if @@ERROR <> 0                                                                                                                                                                                                                                         				
							begin
								PRINT 'An error occurred when inserting into PODTLBOM'                                                                                                                                                                                               					
								RETURN(99)                                                                                                                                                                                                                                           				
							end
						end -- End of (IF @sdt_updpo = 'Y'  or @sdt_chgfty = 'Y'  )

						FETCH NEXT
						FROM	cur_BOM1
						INTO	@pda_assitm,	@pdb_assitm,	@pdb_pckunt,                                                                                                                                                                                                                   		                      
							@pdb_bomqty,	@pdb_venno,	@pdb_bcurcde,                                                                                                                                                                                                                   		                      
							@pdb_bomcst,	@pdb_colcde,	@vbi_curcde,  
							@pdb_curcde,	@pdb_ftyprc,	@pdb_bompoflg,
							@pdb_imperiod
					end                                                                                                                                                                                                                                                       	          	                                                                                                                                                                                                                                                               	          

					CLOSE cur_BOM1                                                                                                                                                                                                                                            		  
					DEALLOCATE cur_BOM1  	  	  
				end -- End of (IF @sdt_updpo = 'Y' or @sdt_chgfty = 'Y')
	                 
				FETCH NEXT
				FROM	cur_SCORDDTL
				INTO	@sdt_fcurcde, 	@sdt_itmsts, 	@sdt_cusven,   
					@sdt_purord, 	@sdt_purseq, 	@sdt_cocde,  
					@sdt_ordno, 	@sdt_ordseq, 	@sdt_updpo,  
					@sdt_chgfty, 	@sdt_itmno, 	@sdt_itmtyp,  
					@sdt_itmdsc, 	@sdt_colcde,	 @sdt_cuscol,  
					@sdt_coldsc, 	@sdt_pckseq, 	@sdt_pckunt,  
					@sdt_inrctn, 	@sdt_mtrctn, 	@sdt_cft,  
					@sdt_cbm,  	@sdt_qutno, 	@sdt_refdat,  
					@sdt_cusitm, 	@sdt_cussku, 	@sdt_resppo,  
					@sdt_cuspo, 	@sdt_ordqty, 	@sdt_discnt,  
					@sdt_oneprc, 	@sdt_curcde, 	@sdt_selprc,  
					@sdt_hrmcde, 	@sdt_dtyrat, 	@sdt_dept,   
					@sdt_typcode, 	@sdt_Code1, 	@sdt_Code2,  
					@sdt_Code3, 	@sdt_cususd, 	@sdt_cuscad,  
					@sdt_inrdin, 	@sdt_inrwin, 	@sdt_inrhin,  
					@sdt_mtrdin, 	@sdt_mtrwin, 	@sdt_mtrhin,  
					@sdt_inrdcm, 	@sdt_inrwcm, 	@sdt_inrhcm,  
					@sdt_mtrdcm, 	@sdt_mtrwcm, 	@sdt_mtrhcm,  
					@sdt_shpstr, 	@sdt_shpend, 	@sdt_candat,  
					@sdt_ctnstr, 	@sdt_ctnend, 	@sdt_ttlctn,  
					@sdt_rmk,  	@sdt_invqty, 	@sdt_shpqty,  
					@sdt_ftyprc, 	@sdt_ftycst, 	@sdt_subcde,  
					@sdt_venitm, 	@sdt_pckitr, 	@sdt_oldpurord,   
					@sdt_oldpurseq,  	@sdt_cusven, 	@sdt_cussub, 
					@sdt_pjobno, 	@sdt_seccusitm,	@sdt_venno,
					@sod_alsitmno, 	@sod_alscolcde,	@sod_qutdat,
					@sod_imqutdat,	@sod_cus1no,	@sod_cus2no,
					@sod_hkprctrm,	@sod_ftyprctrm,	@sod_trantrm,
					@sod_effdat,	@sod_expdat
			end

			CLOSE cur_SCORDDTL                                    
			DEALLOCATE cur_SCORDDTL                                

			---- Calculate the Ship Start Date & Ship End Date ---  
			select	@ShpStartDate = MIN(pod_shpstr)
			from	POORDDTL (nolock)
			where	POD_COCDE = @cocde	AND
				POD_PURORD = @ret_code   

			select	@ShpEndDate =  MAX(pod_shpend)
			from	POORDDTL (nolock)
			where	POD_COCDE = @cocde	AND
				POD_PURORD = @ret_code      

			select	@pod_ttlctn = SUM(pod_ttlctn),	@pod_lnecub = SUM(pod_lnecub),	@pod_lneamt = round(SUM(pod_lneamt),2),  
				@pod_jobord = ''  
			from	POORDDTL (nolock)
			where	pod_cocde = @cocde		AND  
				pod_purord = @ret_code  
			
			update	PODISPRM
			set	pdp_paamt = Round(@pod_lneamt * pdp_purpct / 100,2)  
			where	pdp_cocde = @cocde		AND  
				pdp_purord = @ret_code	AND  
				pdp_pctamt = 'P'  

			select	@tmpamt = SUM(p.pdp_paamt) - SUM(d.pdp_paamt)  
			from	PODISPRM p (nolock), PODISPRM d (nolock)  
			where	p.pdp_cocde = @cocde		AND  
				p.pdp_purord = @ret_code 	AND  
				p.pdp_pdptyp = 'P'		AND  
				d.pdp_cocde = p.pdp_cocde 	AND  
				d.pdp_purord = p.pdp_purord 	AND  
				d.pdp_pdptyp = 'D'  
	
			if @tmpamt IS NULL  
			begin
				SET @tmpamt = 0  
			end

			update	POORDHDR   
			set	poh_shpstr = @ShpStartDate,	poh_shpend = @ShpEndDate,	poh_ttlctn = @pod_ttlctn,  
				poh_ttlcbm = @pod_lnecub,	poh_ttlamt = @pod_lneamt,	poh_netamt = round((@pod_lneamt + @tmpamt) * (1 - (@poh_discnt/100)),2),
				poh_upddat = GETDATE(),	poh_updusr = 'SCM02-SYS'  
			where	poh_cocde = @cocde 		AND  
				poh_purord = @ret_code   
                                   
			FETCH NEXT
			FROM	cur_SCORDDTLHDR
			INTO	@sco_ordno,	@sco_cusven  
		end

		CLOSE cur_SCORDDTLHDR                                     
		DEALLOCATE cur_SCORDDTLHDR                                
			  
		-- Change Factory Processing --  
		-- update old purchase order's order qty.        
		update	p
		set	p.pod_ordqty = p.pod_recqty,		p.pod_lneamt = p.pod_recqty * p.pod_ftyprc,	p.pod_lnecub = p.pod_cubcft * p.pod_recqty / p.pod_mtrctn,  
			p.pod_ttlctn = p.pod_recqty / p.pod_mtrctn,	p.pod_scno = '',			p.pod_scline = 0,  
			p.pod_jobord = '',  			p.pod_runno = '',  			p.pod_upddat = GETDATE(),  
			p.pod_updusr = 'SCM02-SYS'  
		FROM	POORDDTL p (nolock), SCORDDTL s(nolock), SCORDHDR h (nolock)  
		WHERE	h.soh_cocde = s.sod_cocde 		AND  
			h.soh_ordno = s.sod_ordno 		AND  
			s.sod_cocde = p.pod_cocde 		AND  
			s.sod_oldpurord = p.pod_purord 		AND  
			s.sod_oldpurseq = p.pod_purseq 		AND  
			(s.sod_oldpurord <> s.sod_purord	or
			 s.sod_oldpurseq <> s.sod_purseq) 	AND  
			h.soh_ordsts = 'ACT' 			AND
			h.soh_ordno >= @from 		AND
			h.soh_ordno <= @to 			AND  
			h.soh_cocde = @cocde  
			-- check for old purord & purseq <> current purord and purseq   

		DECLARE		@purord nvarchar(20),		@purseq int  
		
		DECLARE		@bompno nvarchar(20),  	@bpolne int,  	@bomitm nvarchar(20),  
				@bomcolcde nvarchar(30),  	@ordqty int,  	@ttlamt numeric (13,4),  
				@disprc numeric (13,4),  	@disamt numeric (13,4)  
		        
		DECLARE	cur_OLDPO CURSOR  
		FOR
		select	distinct d.sod_oldpurord  
		from	SCORDDTL d (nolock), SCORDHDR h (nolock)  
		where	h.soh_ordsts = 'ACT' 		AND  
			h.soh_ordno >= @from 	AND  
			h.soh_ordno <= @to 		AND  
			h.soh_cocde = @cocde 	AND  
			d.sod_ordno = h.soh_ordno 	AND  
			d.sod_cocde = h.soh_cocde 	AND  
			d.sod_oldpurord <> '' 		AND  
			d.sod_oldpurord IS NOT NULL    
		group by	d.sod_oldpurord  
    		OPEN	cur_OLDPO  
		FETCH NEXT
		FROM	cur_OLDPO
		INTO	@purord   
    
		WHILE @@fetch_status = 0  
		begin  
			select	@pod_ttlctn = SUM(pod_ttlctn),	@pod_lnecub = SUM(pod_lnecub),	@pod_lneamt = SUM(pod_lneamt)  
			from	POORDDTL (nolock)  
			where	pod_cocde = @cocde		AND  
				pod_purord = @purord  
		     
			update	PODISPRM
			set	pdp_paamt = Round(@pod_lneamt * pdp_purpct / 100,2)  
			where	pdp_cocde = @cocde 		AND
				pdp_purord = @purord	AND
				pdp_pctamt = 'P'  
		         
			select	@tmpamt = SUM(p.pdp_paamt) - SUM(d.pdp_paamt)  
			from	PODISPRM p (nolock), PODISPRM d (nolock)  
			where	p.pdp_cocde = @cocde 	AND  
				p.pdp_purord = @purord 	AND   
				p.pdp_pdptyp = 'P' 		AND  
				d.pdp_cocde = p.pdp_cocde 	AND  
				d.pdp_purord = p.pdp_purord 	AND  
				d.pdp_pdptyp = 'D'  
		     
			if @tmpamt IS NULL  
			begin
				SET @tmpamt = 0  
			end
		           
			update	POORDHDR
			set	poh_ttlctn = @pod_ttlctn,  	poh_ttlcbm = @pod_lnecub,  		poh_ttlamt = @pod_lneamt,  
				poh_netamt = round((@pod_lneamt + @tmpamt) * (1 - (@poh_discnt/100)),2),
							poh_upddat = GETDATE(),  		poh_updusr = 'SCM02-SYS'  
			where	poh_cocde = @cocde 		AND  
				poh_purord = @purord   
		  
			FETCH NEXT
			FROM	cur_OLDPO
			INTO	@purord   
		end

		CLOSE cur_OLDPO                                     
		DEALLOCATE cur_OLDPO         

		DECLARE	cur_OLDPO CURSOR  
		FOR 
		select	distinct d.sod_oldpurord, d.sod_oldpurseq  
		from	SCORDDTL d (nolock), SCORDHDR h (nolock)  
		where	h.soh_ordsts = 'ACT' 		AND  
			h.soh_ordno >= @from 	AND  
			h.soh_ordno <= @to 		AND  
			h.soh_cocde = @cocde 	AND  
			d.sod_ordno = h.soh_ordno 	AND  
			d.sod_cocde = h.soh_cocde 	AND  
			d.sod_oldpurord <> '' 		AND  
			d.sod_oldpurord IS NOT NULL    
		group by	d.sod_oldpurord, d.sod_oldpurseq  
		    
		OPEN	cur_OLDPO  
		FETCH NEXT
		FROM	cur_OLDPO
		INTO   	@purord,	@purseq  
    
		WHILE @@fetch_status = 0  
		begin
			--- Update BOM PO Information ---  
			DECLARE	cur_BOMPO CURSOR  
			FOR   
			select	PDB_BOMPNO,	PDB_BPOLNE,   PDB_BOMITM,
				PDB_COLCDE,   	PDB_ORDQTY  
			from	PODTLBOM (nolock)  
			where	PDB_COCDE = @cocde 	AND  
				PDB_PURORD = @PURORD	AND  
				PDB_SEQ = @PURSEQ  
			OPEN	cur_BOMPO  
			FETCH NEXT
			FROM	cur_BOMPO
			INTO	@bompno,		@bpolne,	@bomitm,   
				@bomcolcde, 	@ordqty   
	
			WHILE @@fetch_status = 0  
			begin
				if LTRIM(RTRIM(@bompno)) <> ''   
				begin
					update	POBOMDTL  
					set	PBD_ORGORDQTY = 0,  	PBD_ORDQTY = 0,		PBD_ADJQTY = 0,  
						PBD_BOMAMT = 0,  	PBD_RIOQTY = 0,  		PBD_REFPO = '',  
						PBD_UPDUSR = 'SCM02-SYS',	PBD_UPDDAT = GETDATE()  
					where	PBD_COCDE = @cocde 		AND
						PBD_BOMPO = @BOMPNO 		AND  
						PBD_BOMSEQ  = @BPOLNE 		AND  
						PBD_ITMNO = @BOMITM 		AND  
						PBD_VENCOL = @BOMCOLCDE  
		  
					select	@TTLAMT = SUM(PBD_BOMAMT)   
					from	POBOMDTL (nolock)  
					where	PBD_COCDE = @cocde 		AND
						PBD_BOMPO = @BOMPNO  
		  
					select	@DISPRC = PBH_DISPRC  
					from	POBOMHDR (nolock)  
					where	PBH_COCDE = @cocde 		AND
						PBH_BOMPO = @BOMPNO  
		   
					SET @DISAMT = ROUND(@TTLAMT - (@TTLAMT * @DISPRC / 100),2)  
       
					update	POBOMHDR  
					set	PBH_TTLAMT = @TTLAMT,	PBH_DISAMT = @DISAMT,  	PBH_UPDUSR = 'SCM02-SYS',  
						PBH_UPDDAT = GETDATE()  
					where	PBH_COCDE = @cocde 		AND
							PBH_BOMPO = @BOMPNO            
				end
	
				FETCH NEXT
				FROM	cur_BOMPO
				INTO	@bompno,		@bpolne,	@bomitm ,  
					@bomcolcde, 	@ordqty   
			end
	
			CLOSE cur_BOMPO  
			DEALLOCATE cur_BOMPO  
	  
			-- Reset the Order Qty --  
			update	PODTLBOM  
			set	PDB_ORDQTY = 0,  	PDB_BOMPNO = '',  PDB_BPOLNE = 0      
			where	PDB_COCDE = @cocde 	AND
				PDB_PURORD = @PURORD 	AND  
				PDB_SEQ = @PURSEQ  
	     
			FETCH NEXT
			FROM	cur_OLDPO
			INTO	@purord,	@purseq  
		end
   
		CLOSE cur_OLDPO                                     
		DEALLOCATE cur_OLDPO         
	
		update	d
		set	d.sod_oldpurord = '',	d.sod_oldpurseq = 0  
		from	SCORDDTL d, SCORDHDR h  
		where	h.soh_ordsts = 'ACT' 		AND  
			h.soh_ordno >= @from 	AND  
			h.soh_ordno <= @to 		AND  
			h.soh_cocde = @cocde 	AND  
			d.sod_ordno = h.soh_ordno 	AND  
			d.sod_cocde = h.soh_cocde 	AND
			(d.sod_updpo = 'Y'	or
			 d.sod_chgfty = 'Y') 		AND  
			d.sod_oldpurord <> '' 		AND  
			d.sod_oldpurord IS NOT NULL    
		    
		update	d
		set	d.sod_updpo = 'N',	d.sod_chgfty = 'N'   
		from	SCORDDTL d, SCORDHDR h  
		where	h.soh_ordsts = 'ACT' 		AND  
			h.soh_ordno >= @from 	AND  
			h.soh_ordno <= @to 		AND  
			h.soh_cocde = @cocde 	AND  
			d.sod_ordno = h.soh_ordno 	AND  
			d.sod_cocde = h.soh_cocde   
	     
		DECLARE	cur_SCNO CURSOR
		FOR
		select	distinct soh_ordno 
		from	SCORDHDR (nolock) 
		where	soh_ordsts = 'ACT' 		AND  
			soh_ordno >= @from 		AND  
			soh_ordno <= @to 		AND  
			soh_cocde = @cocde   
		OPEN	cur_SCNO 
		FETCH NEXT
		FROM	cur_SCNO
		INTO	@SC_ORD_NO
	    
		WHILE @@fetch_status = 0  
		begin  
			update	SCORDHDR
			set	soh_ordsts = 'REL',	soh_upddat = GETDATE(),	soh_updusr = 'SCM02-SYS'   
			where	soh_cocde = @cocde		AND
				soh_ordno =  @SC_ORD_NO
		
			FETCH NEXT
			FROM	cur_SCNO
			INTO	@SC_ORD_NO
		end
	
		CLOSE cur_SCNO  
		DEALLOCATE cur_SCNO  
	
		if @@ERROR <> 0   
		begin
			PRINT 'An error occurred when updating into SCORDHDR'  
			RETURN(99)  
		end
		else
		begin
			RETURN(0)  
		end
	end  -- End of ( IF @fntyp = 'Y')  at early start                                                       
                                                               
	if @fntyp = 'N'                                               
	begin
		update	SCORDHDR
		set	soh_ordsts = 'ACT',	soh_rvsdat = GETDATE(),	soh_verno = soh_verno + 1,  
			soh_upddat = GETDATE()   
		where	soh_ordsts = 'REL' 		AND  
			soh_ordno >= @from 		AND  
			soh_ordno <= @to 		AND  
			soh_cocde = @cocde   
	
		if @@rowcount = 0                        
		begin
			PRINT 'Order No Not Found'  
			RETURN(99)  
		end
	end
end







GO
GRANT EXECUTE ON [dbo].[sp_select_SCM00002_2] TO [ERPUSER] AS [dbo]
GO
