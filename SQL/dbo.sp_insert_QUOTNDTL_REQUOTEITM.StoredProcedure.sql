/****** Object:  StoredProcedure [dbo].[sp_insert_QUOTNDTL_REQUOTEITM]    Script Date: 09/29/2017 15:29:09 ******/
DROP PROCEDURE [dbo].[sp_insert_QUOTNDTL_REQUOTEITM]
GO
/****** Object:  StoredProcedure [dbo].[sp_insert_QUOTNDTL_REQUOTEITM]    Script Date: 09/29/2017 15:29:09 ******/
SET ANSI_NULLS OFF
GO
SET QUOTED_IDENTIFIER OFF
GO

Create PROCEDURE [dbo].[sp_insert_QUOTNDTL_REQUOTEITM] 

@qud_cocde	nvarchar(6) ,	@qud_qutno 	nvarchar(20),	@qud_qutseq int,
@qud_itmno 	nvarchar(20),
@qud_untcde 	nvarchar(6), @qud_inrqty int, @qud_mtrqty 	int,
@qud_prctrm	nvarchar(10), @qud_ftyprctrm nvarchar(20), @qud_trantrm	nvarchar(10),
@qud_creusr	nvarchar(30)

AS

Declare @quh_qutsts as nvarchar(10)

insert into [QUOTNDTL]
(
	qud_cocde, qud_qutno, qud_qutseq, 
	qud_itmno, qud_itmsts, qud_qutitmsts,
	
	qud_untcde, qud_inrqty, qud_mtrqty, 
	qud_prctrm, qud_ftyprctrm, qud_trantrm,
	
	qud_credat, qud_upddat, qud_creusr, qud_updusr, 
	
	--not necessary column but col in QUOTNDL cannot be null
	qud_itmdsc, qud_colcde, qud_coldsc,
	qud_cft, qud_curcde, qud_pckseq,	
	qud_cusven, qud_cussub, qud_TOshipport,
	
	qud_inrdin, qud_inrwin, qud_inrhin, qud_mtrdin, qud_mtrwin, qud_mtrhin, 
	qud_inrdcm, qud_inrwcm, qud_inrhcm, qud_mtrdcm, qud_mtrwcm, qud_mtrhcm
)
values(
	@qud_cocde, @qud_qutno, @qud_qutseq, 
	@qud_itmno, 'REQ', 'REQ',
	
	@qud_untcde, @qud_inrqty, @qud_mtrqty, 
	@qud_prctrm, @qud_ftyprctrm, @qud_trantrm,
	
	getdate(), getdate(), @qud_creusr, @qud_creusr, 
	
	--not necessary column but col in QUOTNDL cannot be null
	'', '', '',
	0, '', 0,
	'', '', '',
	
	0, 0, 0, 0, 0, 0,
	0, 0, 0, 0, 0, 0
)


--Update QUOTNDR STAT to 'R - Requote'
select @quh_qutsts = quh_qutsts
from QUOTNHDR
WHERE 
	quh_cocde = @qud_cocde and
	quh_qutno = @qud_qutno

if @quh_qutsts <> 'R'
BEGIN
	UPDATE [QUOTNHDR]
	SET quh_qutsts = 'R'
	where 	
		quh_cocde=@qud_cocde and 
		quh_qutno=@qud_qutno
END



GO
GRANT EXECUTE ON [dbo].[sp_insert_QUOTNDTL_REQUOTEITM] TO [ERPUSER] AS [dbo]
GO
