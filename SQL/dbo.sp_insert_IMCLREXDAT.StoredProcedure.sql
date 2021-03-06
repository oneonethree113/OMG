/****** Object:  StoredProcedure [dbo].[sp_insert_IMCLREXDAT]    Script Date: 09/29/2017 15:29:09 ******/
DROP PROCEDURE [dbo].[sp_insert_IMCLREXDAT]
GO
/****** Object:  StoredProcedure [dbo].[sp_insert_IMCLREXDAT]    Script Date: 09/29/2017 15:29:09 ******/
SET ANSI_NULLS OFF
GO
SET QUOTED_IDENTIFIER OFF
GO




/*
=========================================================
Program ID	: 	sp_insert_IMCLREXDAT
Description   	: 	
Programmer  	: 	
Date Created	:	
=========================================================
 Modification History                                    
=========================================================
2012-07-23	David Yue	Add User ID
=========================================================     
*/



CREATE  procedure [dbo].[sp_insert_IMCLREXDAT]                                                                                                                                                                                                                                                                 

@cocde  nvarchar(6),	@creusr	nvarchar(30)

    
AS

DECLARE 	-- TEMP
@ied_seqno	int,		@iad_seqno	int,		@ikd_seqno	int


DECLARE	-- IMITMEXDAT
@ied_cocde  	nvarchar(6),	@ied_venno 	nvarchar(6),	@ied_prdven	nvarchar(6),	
@ied_cusven 	nvarchar(6),	@ied_cus1no  	nvarchar(10),	@ied_cus2no	nvarchar(10),	
@ied_ucpno  	nvarchar(20),	@ied_itmseq 	int,		@ied_recseq	int,
@ied_venitm 	nvarchar(20),	@ied_ditmno 	nvarchar(20),	@ied_mode	nvarchar(3),
@ied_itmsts 	nvarchar(3),	@ied_stage 	nvarchar(3),	@ied_itmtyp	nvarchar(4),
@ied_catlvl4	nvarchar(20),	@ied_lnecde 	nvarchar(10),	@ied_engdsc	nvarchar(800),
@ied_chndsc 	nvarchar(1600),	@ied_finishing 	nvarchar(50),	@ied_matcde	nvarchar(50),
@ied_nat 	nvarchar(6),	@ied_prdtyp 	nvarchar(50),	@ied_prdsztyp	nvarchar(50),
@ied_prdszunt 	nvarchar(50),	@ied_prdszval 	nvarchar(50),	@ied_vencol	nvarchar(20),@ied_vencoldsc nvarchar(50),	@ied_untcde 	nvarchar(6),	@ied_inrqty	int,
@ied_mtrqty 	int,		@ied_cft 	numeric(13,4),	@ied_conftr	int,
@ied_inrlin 	numeric(13,4),	@ied_inrwin 	numeric(13,4),	@ied_inrhin	numeric(13,4),
@ied_mtrlin 	numeric(13,4),	@ied_mtrwin 	numeric(13,4),	@ied_mtrhin	numeric(13,4),
@ied_grswgt 	numeric(13,4),	@ied_netwgt 	numeric(13,4),	@ied_pckitr	nvarchar(300),
@ied_sysmsg 	nvarchar(300),	@ied_xlsfil 	nvarchar(50),	@ied_chkdat	datetime,
@ied_prctrm 	nvarchar(10),	@ied_curcde 	nvarchar(6),	@ied_ftycst 	numeric(13,4),
@ied_ftyprc 	numeric(13,4),	@ied_fcurcde 	nvarchar(6),	@ied_basprc 	numeric(13,4),
@ied_moqum 	nvarchar(6),	@ied_moq 	int,		@ied_moaccy	nvarchar(6),	
@ied_moa 	numeric(13,4),	@ied_qutdat 	datetime,	@ied_expdat	datetime, 		
@ied_refresh 	char(1),		@ied_remark 	nvarchar(2000),	@ied_bomprc	numeric(13,4),
@ied_bomcst	numeric(13,4),	@ied_fmlopt	nvarchar(10),	
@ied_creusr	nvarchar(30),	@ied_pckm	nvarchar(10),
@ied_updusr 	nvarchar(30),	@ied_credat 	datetime,	@ied_upddat	datetime	


DECLARE 	--IMBOMEXDAT
@ibd_cocde		nvarchar(6),		@ibd_ucpno		nvarchar(20),		@ibd_bomno		nvarchar(20),
@ibd_colcde		nvarchar(200),		@ibd_qty		int,			@ibd_xlsfil 		nvarchar(50),	
@ibd_chkdat		datetime,		@ibd_untcde		nvarchar(6),		@ibd_conftr		int,
@ibd_recseq		int,			@ibd_stage		nvarchar(3),		@ibd_sysmsg		nvarchar(300),	
@ibd_veneml		nvarchar(50),		@ibd_malsts		nvarchar(1),		@ibd_venno		nvarchar(6),	
@ibd_credat		datetime,		@ibd_prdven		nvarchar(6),		@ibd_seqno		int


DECLARE	--IMASSEXDAT
@iad_cocde		nvarchar(6),		@iad_asstno		nvarchar(20),		@iad_assdno		nvarchar(20),
@iad_colcde		nvarchar(200),		@iad_inrqty		int,			@iad_mtrqty		int,
@iad_xlsfil 		nvarchar(50),		@iad_chkdat		datetime,		@iad_untcde		nvarchar(6),	
@iad_conftr		int,			@iad_recseq		int,			@iad_stage		nvarchar(3),	
@iad_sysmsg		nvarchar(300),		@iad_veneml		nvarchar(50),		@iad_malsts		nvarchar(1),	
@iad_venno		nvarchar(6),		@iad_credat		datetime,		@iad_prdven		nvarchar(6)


DECLARE	--IMMBDEXDAT (Material Break Down)
@ikd_cocde		nvarchar(6),		@ikd_venno		nvarchar(6),		@ikd_prdven		nvarchar(6),
@ikd_ucpno		nvarchar(20),		@ikd_recseq		int,			
@ikd_matdsc		nvarchar(200),		@ikd_curcde		nvarchar(6),		@ikd_cst		numeric(13,4),
@ikd_cstper		numeric(13,4),		@ikd_wgtper		numeric(13,4),		@ikd_stage		nvarchar(3),
@ikd_sysmsg		nvarchar(300),		@ikd_xlsfil		nvarchar(50),		@ikd_chkdat		datetime,
@ikd_credat		datetime


set @iad_seqno = 0
set @ied_seqno = 0
set @ikd_seqno = 0
set @ibd_seqno = 0

--- CLEAR IMITMEXDAT START ----------------------------------------------------------------------------------------------------------

DECLARE cur_IMITMEXDAT CURSOR
FOR 	SELECT 		
	ied_cocde ,		ied_venno ,		ied_prdven ,	
	ied_cusven ,		ied_cus1no  ,		ied_cus2no ,	
	ied_ucpno  ,		ied_itmseq ,		ied_recseq ,
	ied_venitm ,		ied_ditmno ,		ied_mode ,
	ied_itmsts ,		ied_stage ,		ied_itmtyp ,
	ied_catlvl4 ,		ied_lnecde ,		ied_engdsc ,
	ied_chndsc ,		ied_finishing ,		ied_matcde ,
	ied_nat ,		ied_prdtyp ,		ied_prdsztyp ,
	ied_prdszunt ,		ied_prdszval ,		ied_vencol ,
	ied_vencoldsc ,	           ied_untcde ,		ied_inrqty ,
	ied_mtrqty ,		ied_cft ,		ied_conftr ,
	ied_inrlin ,		ied_inrwin ,		ied_inrhin ,
	ied_mtrlin ,		ied_mtrwin ,		ied_mtrhin ,
	ied_grswgt ,		ied_netwgt ,		ied_pckitr ,
	ied_sysmsg ,		ied_xlsfil ,		ied_chkdat ,
	ied_prctrm ,		ied_curcde ,		ied_ftycst ,
	ied_ftyprc ,		ied_fcurcde ,		ied_basprc ,
	ied_moqum ,		ied_moq ,		ied_moaccy ,	
	ied_moa ,		ied_qutdat, 		ied_expdat ,
	ied_refresh ,		ied_remark ,		ied_bomprc,
	ied_bomcst,		ied_fmlopt,		ied_pckm,
	ied_creusr ,		ied_updusr ,		ied_credat ,		
	ied_upddat 		
FROM 	
	IMITMEXDAT	
WHERE 	
	ied_stage <> 'W'  
ORDER BY 
	ied_itmtyp desc, ied_ucpno, ied_stage, ied_chkdat


OPEN cur_IMITMEXDAT
FETCH NEXT FROM cur_IMITMEXDAT INTO 
	@ied_cocde ,		@ied_venno ,		@ied_prdven ,	
	@ied_cusven ,		@ied_cus1no  ,		@ied_cus2no ,	
	@ied_ucpno  ,		@ied_itmseq ,		@ied_recseq ,
	@ied_venitm ,		@ied_ditmno ,		@ied_mode ,
	@ied_itmsts ,		@ied_stage ,		@ied_itmtyp ,
	@ied_catlvl4 ,		@ied_lnecde ,		@ied_engdsc ,
	@ied_chndsc ,		@ied_finishing ,		@ied_matcde ,
	@ied_nat ,		@ied_prdtyp ,		@ied_prdsztyp ,
	@ied_prdszunt ,		@ied_prdszval ,		@ied_vencol ,
	@ied_vencoldsc ,	@ied_untcde ,		@ied_inrqty ,
	@ied_mtrqty ,		@ied_cft ,		@ied_conftr ,
	@ied_inrlin ,		@ied_inrwin ,		@ied_inrhin ,
	@ied_mtrlin ,		@ied_mtrwin ,		@ied_mtrhin ,
	@ied_grswgt ,		@ied_netwgt ,		@ied_pckitr ,
	@ied_sysmsg ,		@ied_xlsfil ,		@ied_chkdat ,
	@ied_prctrm ,		@ied_curcde ,		@ied_ftycst ,
	@ied_ftyprc ,		@ied_fcurcde ,		@ied_basprc ,
	@ied_moqum ,		@ied_moq ,		@ied_moaccy ,	
	@ied_moa ,		@ied_qutdat, 		@ied_expdat ,
	@ied_refresh ,		@ied_remark ,		@ied_bomprc,
	@ied_bomcst,		@ied_fmlopt,		@ied_pckm,
	@ied_creusr ,		@ied_updusr ,		@ied_credat ,		
	@ied_upddat 	

WHILE @@fetch_status = 0
BEGIN

	select	@ied_seqno = (isnull(max(ied_seqno),0) + 1) 
	from	IMITMEXDATH 
	where
		ied_venno = @ied_venno and ied_prdven = @ied_prdven and 
		ied_ucpno = @ied_ucpno  and ied_xlsfil = @ied_xlsfil and
		ied_cus1no = @ied_cus1no and ied_cus2no = @ied_cus2no and
		ied_itmseq = @ied_itmseq and ied_recseq = @ied_recseq and
		ied_chkdat = @ied_chkdat
	
	insert into IMITMEXDATH 
	(	
		ied_cocde ,		ied_venno ,		ied_prdven ,	
		ied_cusven ,		ied_cus1no  ,		ied_cus2no ,	
		ied_ucpno  ,		ied_itmseq ,		ied_recseq ,
		ied_venitm ,		ied_ditmno ,		ied_mode ,
		ied_itmsts ,		ied_stage ,		ied_itmtyp ,
		ied_catlvl4 ,		ied_lnecde ,		ied_engdsc ,
		ied_chndsc ,		ied_finishing ,		ied_matcde ,
		ied_nat ,		ied_prdtyp ,		ied_prdsztyp ,
		ied_prdszunt ,		ied_prdszval ,		ied_vencol ,
		ied_vencoldsc ,		ied_untcde ,		ied_inrqty ,
		ied_mtrqty ,		ied_cft ,		ied_conftr ,
		ied_inrlin ,		ied_inrwin ,		ied_inrhin ,
		ied_mtrlin ,		ied_mtrwin ,		ied_mtrhin ,
		ied_grswgt ,		ied_netwgt ,		ied_pckitr ,
		ied_sysmsg ,		ied_xlsfil ,		ied_chkdat ,
		ied_prctrm ,		ied_curcde ,		ied_ftycst ,
		ied_ftyprc ,		ied_fcurcde ,		ied_basprc ,
		ied_moqum ,		ied_moq ,		ied_moaccy ,	
		ied_moa ,		ied_qutdat, 		ied_expdat ,
		ied_refresh ,		ied_remark ,		ied_bomprc,
		ied_bomcst,		ied_fmlopt,		ied_creusr ,	
		ied_updusr ,		ied_credat ,		ied_upddat,
		ied_seqno 	
	)
	values
	(	
		@ied_cocde ,		@ied_venno ,		@ied_prdven ,	
		@ied_cusven ,		@ied_cus1no  ,		@ied_cus2no ,	
		@ied_ucpno  ,		@ied_itmseq ,		@ied_recseq ,
		@ied_venitm ,		@ied_ditmno ,		@ied_mode ,
		@ied_itmsts ,		@ied_stage ,		@ied_itmtyp ,
		@ied_catlvl4 ,		@ied_lnecde ,		@ied_engdsc ,
		@ied_chndsc ,		@ied_finishing ,		@ied_matcde ,
		@ied_nat ,		@ied_prdtyp ,		@ied_prdsztyp ,
		@ied_prdszunt ,		@ied_prdszval ,		@ied_vencol ,
		@ied_vencoldsc ,	@ied_untcde ,		@ied_inrqty ,
		@ied_mtrqty ,		@ied_cft ,		@ied_conftr ,
		@ied_inrlin ,		@ied_inrwin ,		@ied_inrhin ,
		@ied_mtrlin ,		@ied_mtrwin ,		@ied_mtrhin ,
		@ied_grswgt ,		@ied_netwgt ,		@ied_pckitr ,
		@ied_sysmsg ,		@ied_xlsfil ,		@ied_chkdat ,
		@ied_prctrm ,		@ied_curcde ,		@ied_ftycst ,
		@ied_ftyprc ,		@ied_fcurcde ,		@ied_basprc ,
		@ied_moqum ,		@ied_moq ,		@ied_moaccy ,	
		@ied_moa ,		@ied_qutdat, 		@ied_expdat ,
		@ied_refresh ,		@ied_remark ,		@ied_bomprc,
		@ied_bomcst,		@ied_fmlopt,		@ied_creusr ,	
		@ied_updusr ,		@ied_credat ,		@ied_upddat,
		@ied_seqno 	
	)

	Delete from IMITMEXDAT 
	where
		ied_xlsfil = @ied_xlsfil and 
		ied_chkdat = @ied_chkdat and
		ied_recseq = @ied_recseq and
		ied_stage <> 'W'

FETCH NEXT FROM cur_IMITMEXDAT INTO 
	@ied_cocde ,		@ied_venno ,		@ied_prdven ,	
	@ied_cusven ,		@ied_cus1no  ,		@ied_cus2no ,	
	@ied_ucpno  ,		@ied_itmseq ,		@ied_recseq ,
	@ied_venitm ,		@ied_ditmno ,		@ied_mode ,
	@ied_itmsts ,		@ied_stage ,		@ied_itmtyp ,
	@ied_catlvl4 ,		@ied_lnecde ,		@ied_engdsc ,
	@ied_chndsc ,		@ied_finishing ,		@ied_matcde ,
	@ied_nat ,		@ied_prdtyp ,		@ied_prdsztyp ,
	@ied_prdszunt ,		@ied_prdszval ,		@ied_vencol ,
	@ied_vencoldsc ,	@ied_untcde ,		@ied_inrqty ,
	@ied_mtrqty ,		@ied_cft ,		@ied_conftr ,
	@ied_inrlin ,		@ied_inrwin ,		@ied_inrhin ,
	@ied_mtrlin ,		@ied_mtrwin ,		@ied_mtrhin ,
	@ied_grswgt ,		@ied_netwgt ,		@ied_pckitr ,
	@ied_sysmsg ,		@ied_xlsfil ,		@ied_chkdat ,
	@ied_prctrm ,		@ied_curcde ,		@ied_ftycst ,
	@ied_ftyprc ,		@ied_fcurcde ,		@ied_basprc ,
	@ied_moqum ,		@ied_moq ,		@ied_moaccy ,	
	@ied_moa ,		@ied_qutdat, 		@ied_expdat ,
	@ied_refresh ,		@ied_remark ,		@ied_bomprc,
	@ied_bomcst,		@ied_fmlopt,		@ied_pckm,
	@ied_creusr ,		@ied_updusr ,		@ied_credat ,		
	@ied_upddat 	
END	-- WHILE @@fetch_status = 0 BEGIN
CLOSE cur_IMITMEXDAT
DEALLOCATE cur_IMITMEXDAT

--- CLEAR IMITMEXDAT END ------------------------------------------------------------------------------------------------------------


--- CLEAR IMBOMEXDAT START -------------------------------------------------------------------------------------------------------

DECLARE cur_IMBOMEXDAT CURSOR
FOR SELECT 	ibd_cocde,	ibd_ucpno,	ibd_bomno,
		ibd_colcde,	ibd_qty,		ibd_xlsfil,	
		ibd_chkdat,	ibd_untcde,	ibd_conftr,
		ibd_recseq,	ibd_stage,	ibd_veneml,	
		ibd_malsts,	ibd_sysmsg,	ibd_venno,
		ibd_credat,	ibd_prdven
FROM	IMBOMEXDAT
WHERE	ibd_stage <> 'W'

OPEN cur_IMBOMEXDAT
FETCH NEXT FROM cur_IMBOMEXDAT INTO 
		@ibd_cocde,	@ibd_ucpno,	@ibd_bomno,
		@ibd_colcde,	@ibd_qty,	@ibd_xlsfil,	
		@ibd_chkdat,	@ibd_untcde,	@ibd_conftr,
		@ibd_recseq,	@ibd_stage,	@ibd_veneml,	
		@ibd_malsts,	@ibd_sysmsg,	@ibd_venno,
		@ibd_credat,	@ibd_prdven

WHILE @@fetch_status = 0
BEGIN	

	select	@ibd_seqno = isnull(max(ibd_seqno),0) + 1 
	from	IMBOMEXDATH 
	where	
		ibd_ucpno = @ibd_ucpno and ibd_bomno = @ibd_bomno and 
		ibd_venno = @ibd_venno and ibd_prdven = @ibd_prdven and
		ibd_xlsfil = @ibd_xlsfil and ibd_chkdat = @ibd_chkdat and
		ibd_recseq = @ibd_recseq and ibd_colcde = @ibd_colcde
		
	insert into IMBOMEXDATH
	(	ibd_cocde ,		ibd_ucpno ,		ibd_bomno ,
		ibd_recseq ,		ibd_colcde ,		ibd_qty ,
		ibd_untcde ,		ibd_conftr ,		ibd_stage ,
		ibd_sysmsg ,		ibd_xlsfil ,		ibd_veneml ,
		ibd_malsts ,		ibd_chkdat ,		ibd_creusr ,	
		ibd_updusr ,		ibd_credat ,		ibd_upddat ,
		ibd_venno ,		ibd_prdven , 		ibd_seqno,
		ibd_cus1no,		ibd_cus2no	
	)
	values
	(	@ibd_cocde,		@ibd_ucpno,		@ibd_bomno,
		@ibd_recseq,		@ibd_colcde,		@ibd_qty,	
		@ibd_untcde,		@ibd_conftr,		@ibd_stage,
		@ibd_sysmsg,		@ibd_xlsfil,		@ibd_veneml,
		@ibd_malsts,		@ibd_chkdat,		@creusr,
		@creusr,		getdate(),		@ibd_credat,
		@ibd_venno,		@ibd_prdven, 		@ibd_seqno,	
		isnull(@ied_cus1no,0),	isnull(@ied_cus2no,0)	
	)

	Delete from IMBOMEXDAT 
	where
		ibd_xlsfil = @ibd_xlsfil and 
		ibd_chkdat = @ibd_chkdat and
		ibd_recseq = @ibd_recseq and
		ibd_stage = @ibd_stage
	

FETCH NEXT FROM cur_IMBOMEXDAT INTO 
		@ibd_cocde,	@ibd_ucpno,	@ibd_bomno,
		@ibd_colcde,	@ibd_qty,	@ibd_xlsfil,	
		@ibd_chkdat,	@ibd_untcde,	@ibd_conftr,
		@ibd_recseq,	@ibd_stage,	@ibd_veneml,	
		@ibd_malsts,	@ibd_sysmsg,	@ibd_venno,
		@ibd_credat,	@ibd_prdven
END -- WHILE @@fetch_status = 0
CLOSE cur_IMBOMEXDAT
DEALLOCATE cur_IMBOMEXDAT

--Delete from IMBOMEXDAT Where	ibd_stage <> 'W'

--- CLEAR IMBOMEXDAT END ----------------------------------------------------------------------------------------------------------


--- CLEAR IMASSEXDAT START ---------------------------------------------------------------------------------------------------------

DECLARE cur_IMASSEXDAT CURSOR
FOR SELECT 	iad_cocde,	iad_asstno,	iad_assdno,
		iad_colcde,	iad_inrqty,	iad_mtrqty,
		iad_xlsfil,	iad_chkdat,	iad_untcde,	
		iad_conftr,	iad_recseq,	iad_stage,
		iad_veneml,	iad_malsts,	iad_sysmsg,
		iad_venno,	iad_credat,	iad_prdven
FROM	IMASSEXDAT
WHERE	iad_stage <> 'W'		

OPEN cur_IMASSEXDAT
FETCH NEXT FROM cur_IMASSEXDAT INTO 
		@iad_cocde,	@iad_asstno,	@iad_assdno,
		@iad_colcde,	@iad_inrqty,	@iad_mtrqty,
		@iad_xlsfil,	@iad_chkdat,	@iad_untcde,	
		@iad_conftr,	@iad_recseq,	@iad_stage,	
		@iad_veneml,	@iad_malsts,	@iad_sysmsg,
		@iad_venno,	@iad_credat,	@iad_prdven

WHILE @@fetch_status = 0
BEGIN	

	select @iad_seqno = isnull(max(iad_seqno),0) + 1 from IMASSEXDATH 
	where
		iad_asstno = @iad_asstno and iad_assdno = @iad_assdno and 
		iad_venno = @iad_venno and iad_prdven = @iad_prdven and			
		iad_xlsfil = @iad_xlsfil and iad_chkdat = @iad_chkdat and
		iad_colcde = @iad_colcde  and iad_recseq = @iad_recseq
	
	insert into IMASSEXDATH
	(	iad_cocde ,		iad_asstno ,		iad_assdno ,
		iad_recseq ,		iad_colcde ,		iad_inrqty ,
		iad_mtrqty,		iad_untcde ,		iad_conftr ,
		iad_stage ,		iad_sysmsg ,		iad_xlsfil ,
		iad_veneml ,		iad_malsts ,		iad_chkdat ,
		iad_creusr ,		iad_updusr ,		iad_credat ,
		iad_upddat ,		iad_venno ,		iad_prdven,	
		iad_seqno , 		iad_cus1no,		iad_cus2no	
	)
	values
	(	@iad_cocde,		@iad_asstno,		@iad_assdno,
		@iad_recseq,		@iad_colcde,		@iad_inrqty,	
		@iad_mtrqty,		@iad_untcde,		@iad_conftr,
		@iad_stage,		@iad_sysmsg,		@iad_xlsfil,
		@iad_veneml,		@iad_malsts,		@iad_chkdat,
		@creusr ,		@creusr ,		getdate(),
		@iad_credat,		isnull(@iad_venno,''),	isnull(@iad_prdven,''),
		@iad_seqno,		isnull(@ied_cus1no,''),	isnull(@ied_cus2no,'')
	)

	Delete from IMASSEXDAT 
	where
		iad_xlsfil = @iad_xlsfil and 
		iad_chkdat = @iad_chkdat and
		iad_recseq = @iad_recseq and
		iad_stage = @iad_stage

	
FETCH NEXT FROM cur_IMASSEXDAT INTO 
	@iad_cocde,	@iad_asstno,	@iad_assdno,
	@iad_colcde,	@iad_inrqty,	@iad_mtrqty,
	@iad_xlsfil,	@iad_chkdat,	@iad_untcde,	
	@iad_conftr,	@iad_recseq,	@iad_stage,	
	@iad_veneml,	@iad_malsts,	@iad_sysmsg,
	@iad_venno,	@iad_credat,	@iad_prdven
END -- WHILE @@fetch_status = 0
CLOSE cur_IMASSEXDAT
DEALLOCATE cur_IMASSEXDAT

-- delete from IMASSEXDAT where iad_stage <> 'W'

--- CLEAR IMASSEXDAT END ---------------------------------------------------------------------------------------------------------


--- CLEAR IMMBDEXDAT START ------------------------------------------------------------------------------------------------------

DECLARE cur_IMMBDEXDAT CURSOR
FOR 	SELECT 
	ikd_cocde,	ikd_venno,	ikd_prdven,
	ikd_ucpno,	ikd_recseq,
	ikd_matdsc,	ikd_curcde,	ikd_cst,
	ikd_cstper,	ikd_wgtper,	ikd_stage,		
	ikd_sysmsg,	ikd_xlsfil,	ikd_chkdat,	
	ikd_credat	
FROM 
	IMMBDEXDAT
WHERE	
	ikd_stage <> 'W'

OPEN cur_IMMBDEXDAT
FETCH NEXT FROM cur_IMMBDEXDAT INTO 
	@ikd_cocde,	@ikd_venno,	@ikd_prdven,
	@ikd_ucpno,	@ikd_recseq,
	@ikd_matdsc,	@ikd_curcde,	@ikd_cst,
	@ikd_cstper,	@ikd_wgtper,	@ikd_stage,		
	@ikd_sysmsg,	@ikd_xlsfil,	@ikd_chkdat,	
	@ikd_credat	

WHILE @@fetch_status = 0
BEGIN	

	select	@ikd_seqno = isnull(max(ikd_seqno),0) + 1 from IMMBDEXDATH 
		where	ikd_ucpno = @ikd_ucpno and ikd_matdsc = @ikd_matdsc and 
			ikd_venno = @ikd_venno and ikd_prdven = @ikd_prdven and 					
			ikd_recseq = @ikd_recseq and 	
			ikd_xlsfil = @ikd_xlsfil and ikd_chkdat = @ikd_chkdat
			
	insert into IMMBDEXDATH
	(	
		ikd_cocde,		ikd_venno,		ikd_prdven,
		ikd_ucpno,		ikd_recseq,	
		ikd_matdsc,		ikd_curcde,		ikd_cst,
		ikd_cstper,		ikd_wgtper,		ikd_stage,		
		ikd_sysmsg,		ikd_xlsfil,		ikd_chkdat,	
		ikd_creusr,		ikd_updusr,		ikd_credat,
		ikd_upddat, 		ikd_seqno,		ikd_cus1no,
		ikd_cus2no
	)
	values
	(
		@ikd_cocde,		isnull(@ikd_venno,''),	isnull(@ikd_prdven,''),
		@ikd_ucpno,		@ikd_recseq,	
		@ikd_matdsc,		@ikd_curcde,		@ikd_cst,
		@ikd_cstper,		@ikd_wgtper,		@ikd_stage,		
		@ikd_sysmsg,		@ikd_xlsfil,		@ikd_chkdat,	
		@creusr ,		@creusr ,		getdate(),
		@ikd_credat,		@ikd_seqno,		isnull(@ied_cus1no,''),
		isnull(@ied_cus2no,'')
	)

	Delete from IMMBDEXDAT 
	where
		ikd_xlsfil = @ikd_xlsfil and 
		ikd_chkdat = @ikd_chkdat and
		ikd_recseq = @ikd_recseq and
		ikd_stage = @ikd_stage

FETCH NEXT FROM cur_IMMBDEXDAT INTO 
	@ikd_cocde,	@ikd_venno,	@ikd_prdven,
	@ikd_ucpno,	@ikd_recseq,	
	@ikd_matdsc,	@ikd_curcde,	@ikd_cst,
	@ikd_cstper,	@ikd_wgtper,	@ikd_stage,		
	@ikd_sysmsg,	@ikd_xlsfil,	@ikd_chkdat,	
	@ikd_credat	
END -- OPEN cur_IMMBDEXDAT
CLOSE cur_IMMBDEXDAT
DEALLOCATE cur_IMMBDEXDAT

-- delete from IMMBDEXDAT where ikd_stage <> 'W'

--- CLEAR IMMBDEXDAT END ---------------------------------------------------------------------------------------------------------









GO
GRANT EXECUTE ON [dbo].[sp_insert_IMCLREXDAT] TO [ERPUSER] AS [dbo]
GO
