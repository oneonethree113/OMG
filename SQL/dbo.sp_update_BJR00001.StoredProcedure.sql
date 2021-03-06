/****** Object:  StoredProcedure [dbo].[sp_update_BJR00001]    Script Date: 09/29/2017 15:29:08 ******/
DROP PROCEDURE [dbo].[sp_update_BJR00001]
GO
/****** Object:  StoredProcedure [dbo].[sp_update_BJR00001]    Script Date: 09/29/2017 15:29:10 ******/
SET ANSI_NULLS OFF
GO
SET QUOTED_IDENTIFIER OFF
GO






-- Checked by Allan Yuen at 28/07/2003


CREATE PROCEDURE [dbo].[sp_update_BJR00001]

@cocde		nvarchar(6),	
@batno		nvarchar(20)

AS
BEGIN

DECLARE
@pod_purord	nvarchar(20),
@pod_itmno	nvarchar(20),
@pod_engdsc	nvarchar(800),
@pod_untcde	nvarchar(6),
@pod_inrctn	nvarchar(20),
@pod_mtrctn	nvarchar(20),
@pod_cubcft	numeric(11,4),
@pod_prdven	varchar(6)

DECLARE cur_batno CURSOR
FOR 
SELECT 	DISTINCT
	dtl.pod_purord, dtl.pod_prdven,  dtl.pod_itmno, ltrim(dtl.pod_engdsc), dtl.pod_untcde, dtl.pod_inrctn, dtl.pod_mtrctn, dtl.pod_cubcft 
FROM 	POJBBDTL bat, POORDDTL dtl
WHERE	bat.pjd_cocde = dtl.pod_cocde
AND	bat.pjd_jobord = dtl.pod_jobord
AND	bat.pjd_batno = @batno
AND	bat.pjd_cocde = @cocde
ORDER BY
	dtl.pod_purord, dtl.pod_prdven, dtl.pod_itmno, ltrim(dtl.pod_engdsc), dtl.pod_untcde, dtl.pod_inrctn, dtl.pod_mtrctn, dtl.pod_cubcft 



OPEN cur_batno
FETCH NEXT FROM cur_batno INTO 
@pod_purord, @pod_prdven, @pod_itmno, @pod_engdsc, @pod_untcde, @pod_inrctn, @pod_mtrctn, @pod_cubcft
		
IF @@fetch_status <> 0
BEGIN
	PRINT 'Batch No Not Found'
	RETURN(99)
END

DECLARE 
@seqno	int,
@pjd_batseq	nvarchar(4)

SET @seqno = 1
WHILE @@fetch_status = 0
BEGIN
	SET @pjd_batseq = right('000' + ltrim(str(@seqno,4)),4)


	UPDATE bat SET pjd_batseq = @pjd_batseq
	FROM POJBBDTL bat, POORDDTL dtl
	WHERE	bat.pjd_cocde = dtl.pod_cocde
	AND	bat.pjd_jobord = dtl.pod_jobord
	AND	dtl.pod_purord = @pod_purord
	AND	dtl.pod_prdven = @pod_prdven
	AND	dtl.pod_itmno = @pod_itmno
	AND	dtl.pod_engdsc = @pod_engdsc
	AND	dtl.pod_untcde = @pod_untcde
	AND	dtl.pod_inrctn = @pod_inrctn
	AND	dtl.pod_mtrctn = @pod_mtrctn
	AND	dtl.pod_cubcft = @pod_cubcft
	AND	bat.pjd_batno = @batno
	AND	bat.pjd_cocde = @cocde

	SET @seqno = @seqno + 1

	Declare @nCount int
	Set @nCount = 0
	While @nCount < 10000
	begin		
		Set @nCount = @nCount + 1
	end

	FETCH NEXT FROM cur_batno INTO 
	@pod_purord, @pod_prdven, @pod_itmno, @pod_engdsc, @pod_untcde, @pod_inrctn, @pod_mtrctn, @pod_cubcft
END
CLOSE cur_batno
DEALLOCATE cur_batno

END




GO
GRANT EXECUTE ON [dbo].[sp_update_BJR00001] TO [ERPUSER] AS [dbo]
GO
