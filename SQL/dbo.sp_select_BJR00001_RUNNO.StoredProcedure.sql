/****** Object:  StoredProcedure [dbo].[sp_select_BJR00001_RUNNO]    Script Date: 09/29/2017 15:29:09 ******/
DROP PROCEDURE [dbo].[sp_select_BJR00001_RUNNO]
GO
/****** Object:  StoredProcedure [dbo].[sp_select_BJR00001_RUNNO]    Script Date: 09/29/2017 15:29:10 ******/
SET ANSI_NULLS OFF
GO
SET QUOTED_IDENTIFIER OFF
GO







-- Checked by Allan Yuen at 27/03/2003

/************************************************************************
Author:		Kenny Chan
Date:		28th September, 2001
************************************************************************
2005-04-11 Allan Yuen	Fix UCP company select error.
*/
------------------------------------------------- 
CREATE PROCEDURE [dbo].[sp_select_BJR00001_RUNNO] 

@cocde  	nvarchar(6),
@from	  	nvarchar(20),
@to		nvarchar(20)

AS


SELECT 
	pod_scno,
	pod_jobord,
	pod_runno,
	pod_itmno,
	vbi_vensna,
	'Y' as 'pjd_confrm',
	' ' as 'pjd_batseq',
	'new' as 'pjd_recsts',
	vbi_venno as vencde
FROM 
	POORDDTL, POORDHDR, VNBASINF
WHERE 
	pod_cocde = @cocde AND
	pod_RUNNO >= @from AND
	pod_RUNNO <= @to AND
	pod_purord = poh_purord AND
	poh_cocde = pod_cocde AND
	poh_venno = vbi_venno 
	--AND vbi_cocde = pod_cocde 
order by    
	POD_RUNNO




GO
GRANT EXECUTE ON [dbo].[sp_select_BJR00001_RUNNO] TO [ERPUSER] AS [dbo]
GO
