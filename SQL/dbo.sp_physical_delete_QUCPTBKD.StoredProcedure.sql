/****** Object:  StoredProcedure [dbo].[sp_physical_delete_QUCPTBKD]    Script Date: 09/29/2017 15:29:09 ******/
DROP PROCEDURE [dbo].[sp_physical_delete_QUCPTBKD]
GO
/****** Object:  StoredProcedure [dbo].[sp_physical_delete_QUCPTBKD]    Script Date: 09/29/2017 15:29:10 ******/
SET ANSI_NULLS OFF
GO
SET QUOTED_IDENTIFIER OFF
GO



-- Checked by Allan Yuen at 28/07/2003

CREATE PROCEDURE [dbo].[sp_physical_delete_QUCPTBKD] 

@qcb_cocde 	nvarchar(6),
@qcb_qutno 	nvarchar(20),
@qcb_qutseq 	int


AS

delete from QUCPTBKD
where 	qcb_cocde = @qcb_cocde
and 	qcb_qutno = @qcb_qutno
and 	qcb_qutseq = @qcb_qutseq





GO
GRANT EXECUTE ON [dbo].[sp_physical_delete_QUCPTBKD] TO [ERPUSER] AS [dbo]
GO
