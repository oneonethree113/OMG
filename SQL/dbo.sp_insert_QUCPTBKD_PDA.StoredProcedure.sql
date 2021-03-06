/****** Object:  StoredProcedure [dbo].[sp_insert_QUCPTBKD_PDA]    Script Date: 09/29/2017 15:29:09 ******/
DROP PROCEDURE [dbo].[sp_insert_QUCPTBKD_PDA]
GO
/****** Object:  StoredProcedure [dbo].[sp_insert_QUCPTBKD_PDA]    Script Date: 09/29/2017 15:29:09 ******/
SET ANSI_NULLS OFF
GO
SET QUOTED_IDENTIFIER OFF
GO




-- Checked by Allan Yuen at 28/07/2003

/************************************************************************
Author:		Samuel Chan   
Date:		02 - 13 -  2002
Description:	Insert data into QUCPTBKD from PDA

************************************************************************/

CREATE PROCEDURE [dbo].[sp_insert_QUCPTBKD_PDA] 
--------------------------------------------------------------------------------------------------------------------------------------

@cocde	nvarchar(6),
@qutno	nvarchar(20)

as

DECLARE @counter int

SELECT @counter = count(*)
FROM	QUOTNDTL dtl, IMMATBKD imm
WHERE
dtl.qud_cocde = imm.ibm_cocde and 
dtl.qud_itmno = imm.ibm_itmno and	
dtl.qud_cocde = @cocde and 
dtl.qud_qutno = @qutno

IF @counter <> 0 
BEGIN
	 INSERT INTO QUCPTBKD 
	(
	qcb_cocde,	
	qcb_qutno, 
	qcb_qutseq,	
	qcb_itmno, 
	qcb_cptseq, 	
	qcb_cpt,
	qcb_curcde,
	qcb_cst,
	qcb_cstpct,
	qcb_pct,
	qcb_creusr, 
	qcb_updusr, 	
	qcb_credat,
	qcb_upddat
	)
	--VALUES
	
	SELECT
	dtl.qud_cocde, 
	dtl.qud_qutno, 
	dtl.qud_qutseq, 
	dtl.qud_itmno, 
	imm.ibm_matseq, 
	imm.ibm_mat,
	imm.ibm_curcde,
	imm.ibm_cst,
	imm.ibm_cstper,
	imm.ibm_wgtper, 
	dtl.qud_creusr,
	dtl.qud_updusr, 
	GETDATE(),
	GETDATE()
	FROM	QUOTNDTL dtl, IMMATBKD imm
	WHERE dtl.qud_cocde = imm.ibm_cocde and 
	dtl.qud_itmno = imm.ibm_itmno and	
	dtl.qud_cocde = @cocde and 
	dtl.qud_qutno = @qutno
END





GO
GRANT EXECUTE ON [dbo].[sp_insert_QUCPTBKD_PDA] TO [ERPUSER] AS [dbo]
GO
