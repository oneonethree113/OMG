/****** Object:  StoredProcedure [dbo].[sp_list_QUCPTBKD]    Script Date: 09/29/2017 15:29:09 ******/
DROP PROCEDURE [dbo].[sp_list_QUCPTBKD]
GO
/****** Object:  StoredProcedure [dbo].[sp_list_QUCPTBKD]    Script Date: 09/29/2017 15:29:10 ******/
SET ANSI_NULLS OFF
GO
SET QUOTED_IDENTIFIER OFF
GO



CREATE PROCEDURE [dbo].[sp_list_QUCPTBKD] 

@cocde	nvarchar(10),
@qutno		nvarchar(10),
@qutseq	int,
@itmno		nvarchar(20),
@cptseq	int

AS

select * from  QUCPTBKD
where qcb_qutno = @qutno and
	qcb_qutseq = @qutseq and
	qcb_itmno = @itmno and
	qcb_cptseq = @cptseq



GO
GRANT EXECUTE ON [dbo].[sp_list_QUCPTBKD] TO [ERPUSER] AS [dbo]
GO
