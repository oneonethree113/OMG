/****** Object:  StoredProcedure [dbo].[sp_select_QCM00002Dtl]    Script Date: 09/29/2017 15:29:09 ******/
DROP PROCEDURE [dbo].[sp_select_QCM00002Dtl]
GO
/****** Object:  StoredProcedure [dbo].[sp_select_QCM00002Dtl]    Script Date: 09/29/2017 15:29:10 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO

Create  PROCEDURE [dbo].[sp_select_QCM00002Dtl]
	@QCNo nvarchar(20)
AS
BEGIN

select distinct qch_qcno,qcd_purord 
FROM QCREQHDR
		left join QCREQDTL (nolock) on qch_cocde = qcd_cocde and qch_qcno = qcd_qcno
		left join POORDDTL (nolock) on pod_cocde = qcd_cocde and pod_purord = qcd_purord and pod_purseq = qcd_purseq
		left join SCORDDTL (nolock) on sod_cocde = pod_cocde and sod_purord = pod_purord and sod_purseq = pod_purseq
where qch_qcno = @QCNo
order by qcd_purord

END


GO
GRANT EXECUTE ON [dbo].[sp_select_QCM00002Dtl] TO [ERPUSER] AS [dbo]
GO
