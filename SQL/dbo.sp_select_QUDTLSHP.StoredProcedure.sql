/****** Object:  StoredProcedure [dbo].[sp_select_QUDTLSHP]    Script Date: 09/29/2017 15:29:09 ******/
DROP PROCEDURE [dbo].[sp_select_QUDTLSHP]
GO
/****** Object:  StoredProcedure [dbo].[sp_select_QUDTLSHP]    Script Date: 09/29/2017 15:29:10 ******/
SET ANSI_NULLS OFF
GO
SET QUOTED_IDENTIFIER ON
GO









/*=========================================================
Program ID	: 	sp_select_QUDTLSHP
Description   	: 
Programmer  	: 	
ALTER  Date   	: 	2013-05-14
Last Modified  	: 
Table Read(s) 	:
Table Write(s) 	:
=========================================================
 Modification History                                    
=========================================================
Date		Author		Description

=========================================================
*/


CREATE    PROCEDURE [dbo].[sp_select_QUDTLSHP] 

@cocde	nvarchar(6),
@qutno	nvarchar(20)

AS

select 
' ' as 'Del',
qds_cocde,
qds_qutno,
qds_qutseq,
qds_shpseq,
qds_shpqty,
qds_ftyshpstr,
qds_ftyshpend,
qds_custshpstr,
qds_custshpend,
qds_pckunt,
qds_creusr,
qds_updusr,
qds_credat,
qds_upddat,
qds_timstp
from QUDTLSHP (nolock)
where qds_cocde = @cocde and qds_qutno = @qutno



GO
GRANT EXECUTE ON [dbo].[sp_select_QUDTLSHP] TO [ERPUSER] AS [dbo]
GO
