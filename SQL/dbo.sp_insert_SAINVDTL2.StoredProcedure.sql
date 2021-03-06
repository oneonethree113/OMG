/****** Object:  StoredProcedure [dbo].[sp_insert_SAINVDTL2]    Script Date: 09/29/2017 15:29:09 ******/
DROP PROCEDURE [dbo].[sp_insert_SAINVDTL2]
GO
/****** Object:  StoredProcedure [dbo].[sp_insert_SAINVDTL2]    Script Date: 09/29/2017 15:29:09 ******/
SET ANSI_NULLS OFF
GO
SET QUOTED_IDENTIFIER OFF
GO





-- Checked by Allan Yuen at 28/07/2003

------------------------------------------------- 
CREATE procedure [dbo].[sp_insert_SAINVDTL2]
                                                                                                                                                                                                                                                                 
---------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------- 
@sid_cocde	nvarchar(6),
@sid_invno	nvarchar(20),
@sid_invseq	int,
@sid_itmno	nvarchar(20),
@sid_cusitm	nvarchar(20),
@sid_itmdsc	nvarchar(800),
@sid_colcde	nvarchar(30),
@sid_alsitmno	nvarchar(20),
@sid_alscolcde	nvarchar(30),
@sid_pckunt	nvarchar(6),
@sid_inrqty	int,
@sid_mtrqty	int,
@sid_cft	numeric(11,4),
@sid_cuscol	nvarchar(30),
@sid_cussmppo nvarchar(50),
@sid_coldsc	nvarchar(300),
@sid_curcde	nvarchar(6),
@sid_selprc	numeric(13,4),
@sid_untcde	nvarchar(6),
@sid_ttlamt	numeric(13,4),
@sid_smpunt	nvarchar(6),
@sid_shpqty	int,
@sid_balfreqty	int,
@sid_chgqty	int,
@sid_rmk		nvarchar(800),
@sid_itmtyp	nvarchar(4),
@sid_reqno	nvarchar(20),
@sid_reqseq	int,
@sid_qutno	nvarchar(20),
@sid_qutseq	int,
@sid_venno	nvarchar(6),
@sid_subcde	nvarchar(10),
@sid_cusven	nvarchar(6),
@sid_cussub	nvarchar(10),
@sid_fcurcde	nvarchar(6),
@sid_ftyprc	numeric(13,4),
@sid_cus1no	nvarchar(6),
@sid_cus2no	nvarchar(6),
@sid_hkprctrm	nvarchar(10),
@sid_ftyprctrm	nvarchar(10),
@sid_trantrm	nvarchar(10),
@sid_effdat	datetime,
@sid_expdat	datetime,
@sid_itmnotmp nvarchar(20),
@sid_itmnoven nvarchar(20),
@sid_itmnovenno nvarchar(20),
@sid_updusr	nvarchar(30)
                                     
------------------------------------ 
AS
 
insert into	SAINVDTL
	(sid_cocde,		sid_invno,		sid_invseq,
	 sid_itmno,		sid_cusitm,		sid_itmdsc,
	 sid_colcde,	sid_alsitmno,	sid_alscolcde,
	 sid_pckunt,	sid_inrqty,		sid_mtrqty,
	 sid_cft,		sid_cuscol,		sid_cussmppo,
	 sid_coldsc,	sid_curcde,		sid_selprc,
	 sid_untcde,	sid_ttlamt,		sid_smpunt,
	 sid_shpqty,	sid_balfreqty,	sid_chgqty,
	 sid_rmk,		sid_itmtyp,		sid_reqno,
	 sid_reqseq,	sid_qutno,		sid_qutseq,
	 sid_venno,		sid_subcde,	sid_cusven,
	 sid_cussub,	sid_fcurcde,	sid_ftyprc,
	 sid_cus1no,	sid_cus2no,	sid_hkprctrm,
	 sid_ftyprctrm,	sid_trantrm,	sid_effdat,
	 sid_expdat,	
	sid_itmnotmp , sid_itmnoven , sid_itmnovenno,
	sid_creusr,		sid_updusr,
	 sid_credat,		sid_upddat)
values	(@sid_cocde,	@sid_invno,	@sid_invseq,
	 @sid_itmno,	@sid_cusitm,	@sid_itmdsc,
	 @sid_colcde,	@sid_alsitmno,	@sid_alscolcde,
	 @sid_pckunt,	@sid_inrqty,	@sid_mtrqty,
	 @sid_cft,		@sid_cuscol,	@sid_cussmppo,
	 @sid_coldsc,	@sid_curcde,	@sid_selprc,
	 @sid_untcde,	@sid_ttlamt,	@sid_smpunt,
	 @sid_shpqty,	@sid_balfreqty,	@sid_chgqty,
	 @sid_rmk,	@sid_itmtyp,	@sid_reqno,
	 @sid_reqseq,	@sid_qutno,	@sid_qutseq,
	 @sid_venno,	@sid_subcde,	@sid_cusven,
 	 @sid_cussub,	@sid_fcurcde,	@sid_ftyprc,
	 @sid_cus1no,	@sid_cus2no,	@sid_hkprctrm,
	 @sid_ftyprctrm,	@sid_trantrm,	@sid_effdat,
	 @sid_expdat,	
	@sid_itmnotmp , @sid_itmnoven , @sid_itmnovenno,
	@sid_updusr,	@sid_updusr,
	 getdate(),		getdate())     







GO
GRANT EXECUTE ON [dbo].[sp_insert_SAINVDTL2] TO [ERPUSER] AS [dbo]
GO
