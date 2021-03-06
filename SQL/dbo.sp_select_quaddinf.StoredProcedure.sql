/****** Object:  StoredProcedure [dbo].[sp_select_quaddinf]    Script Date: 09/29/2017 15:29:09 ******/
DROP PROCEDURE [dbo].[sp_select_quaddinf]
GO
/****** Object:  StoredProcedure [dbo].[sp_select_quaddinf]    Script Date: 09/29/2017 15:29:10 ******/
SET ANSI_NULLS OFF
GO
SET QUOTED_IDENTIFIER OFF
GO


/************************************************************************
Author:		Lester Wu
Date:		12th September, 2008
Description:	select data from QUADDINF
***********************************************************************
*/

CREATE procedure [dbo].[sp_select_quaddinf]

@qdi_cocde	nvarchar(6),
@qdi_qutno	nvarchar(20)
--@qdi_qutseq	int

 
AS

BEGIN

select distinct 
qdi_cocde,
qdi_qutno,
qdi_qutseq,
qdi_fldid,
yqa_flddesc,
qdi_value,
qdi_creusr,
qdi_credat,
qdi_updusr,
qdi_upddat,
yqa_display,
'' as 'mode' 
from quaddinf (nolock)
left join quotndtl (nolock) on qdi_qutseq = qud_qutseq and qdi_qutno = qud_qutno
left join quotnhdr (nolock) on qud_qutno = quh_qutno
left join syquaddinf (nolock) on yqa_cus1no = quh_cus1no and yqa_cus2no = quh_cus2no and yqa_fldid = qdi_fldid
where 
qdi_cocde = @qdi_cocde
and qdi_qutno = '' --@qdi_qutno
--and qdi_qutseq = @qdi_qutseq
order by qdi_fldid asc

END

GO
GRANT EXECUTE ON [dbo].[sp_select_quaddinf] TO [ERPUSER] AS [dbo]
GO
