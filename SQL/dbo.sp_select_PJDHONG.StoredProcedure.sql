/****** Object:  StoredProcedure [dbo].[sp_select_PJDHONG]    Script Date: 09/29/2017 15:29:09 ******/
DROP PROCEDURE [dbo].[sp_select_PJDHONG]
GO
/****** Object:  StoredProcedure [dbo].[sp_select_PJDHONG]    Script Date: 09/29/2017 15:29:10 ******/
SET ANSI_NULLS OFF
GO
SET QUOTED_IDENTIFIER OFF
GO






-- Checked by Allan Yuen at 27/07/2003



/************************************************************************
Author:		Kenny Chan
Date:		28th September, 2001
************************************************************************
2005-04-11 	Allan Yuen		Fix UCP Company select error.
*/
------------------------------------------------- 
CREATE PROCEDURE [dbo].[sp_select_PJDHONG] 

@cocde  	nvarchar(6),
@batno	nvarchar(20),
@gsUsrID	nvarchar(30)

AS

IF @cocde <> 'UCP' 
BEGIN

	SELECT 
		pod_scno,
		pod_jobord,
		pod_runno,
		pod_itmno,
		vbi_vensna,
		pjd_confrm,
		pjd_batseq,
		'old' as pjd_recsts,
		vbi_venno as vencde
	FROM 
		POJBBDTL, POORDDTL, POORDHDR, VNBASINF
	WHERE 
		pjd_cocde = @cocde AND
		pjd_batno = @batno AND
		pjd_jobord = pod_jobord AND
		pod_purord = poh_purord AND
		poh_cocde = pjd_cocde AND
		poh_venno = vbi_venno 
	order by 
		pjd_batseq
END

ELSE
BEGIN
	select 
		* 
	into 
		#Temp1
	FROM
		(
		SELECT
			pod_scno, 
			pod_jobord,
			pod_runno,
			pod_itmno,
			isnull(sod_subcde, '') as vbi_vensna,
			pjd_confrm,
			pjd_batseq,
			'old' as pjd_recsts,
			isnull(sod_subcde, '') as vencde
		FROM 
			POJBBDTL, POORDDTL
			left join SCORDDTL on sod_cocde = pod_cocde and	sod_ordno = pod_scno and sod_ordseq = pod_scline
			, POORDHDR, VNBASINF
		WHERE 
			pjd_cocde = @cocde AND
			pjd_batno = @batno AND
			pjd_jobord = pod_jobord AND
			pod_purord = poh_purord AND
			poh_cocde = pjd_cocde AND
			poh_venno = vbi_venno
		union
		SELECT 
			pod_scno,
			pod_jobord,
			pod_runno,
			pod_itmno,
			vbi_vensna,
			pjd_confrm,
			pjd_batseq,
			'old' as pjd_recsts,
			vbi_venno as vencde
		FROM 
			POJBBDTL, POORDDTL, POORDHDR, VNBASINF
		WHERE 
			pjd_cocde = @cocde AND
			pjd_batno = @batno AND
			pjd_jobord = pod_jobord AND
			pod_purord = poh_purord AND
			poh_cocde = pjd_cocde AND
			poh_venno = vbi_venno 
		) as table_AA

	SELECT 
		*
	FROM 
		#TEMP1 
	WHERE
		LTRIM(RTRIM(VENCDE)) <> ''
	ORDER BY 
		pjd_batseq

END




GO
GRANT EXECUTE ON [dbo].[sp_select_PJDHONG] TO [ERPUSER] AS [dbo]
GO
