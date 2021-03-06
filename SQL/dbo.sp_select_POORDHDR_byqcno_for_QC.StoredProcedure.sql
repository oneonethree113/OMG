/****** Object:  StoredProcedure [dbo].[sp_select_POORDHDR_byqcno_for_QC]    Script Date: 09/29/2017 15:29:09 ******/
DROP PROCEDURE [dbo].[sp_select_POORDHDR_byqcno_for_QC]
GO
/****** Object:  StoredProcedure [dbo].[sp_select_POORDHDR_byqcno_for_QC]    Script Date: 09/29/2017 15:29:10 ******/
SET ANSI_NULLS OFF
GO
SET QUOTED_IDENTIFIER OFF
GO


Create   procedure [dbo].[sp_select_POORDHDR_byqcno_for_QC]


@qch_cocde nvarchar(6)                                                


AS

BEGIN

select       distinct
        qpd_cocde,
		qpd_qcno, 
        isnull(qpd_purord,'') as 'qpd_purord'
from        QCREQHDR (nolock)
        left join QCPORDTL (nolock)
        on qpd_qcno=qch_qcno
where      qch_qcsts = 'REL'
		AND qpd_verdoc < qch_verno
        --AND DATEDIFF(DAY,qch_upddat ,GETDATE()) =0
        and qpd_purord <> 'NULL'
		and qpd_qcno in (select qca_qcno from QCREQACT where qca_qcno = qpd_qcno and qca_actyp = 'R')
        order by qpd_purord

END






GO
GRANT EXECUTE ON [dbo].[sp_select_POORDHDR_byqcno_for_QC] TO [ERPUSER] AS [dbo]
GO
