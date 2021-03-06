/****** Object:  StoredProcedure [dbo].[sp_update_SCTPSMRK_JOBNO]    Script Date: 09/29/2017 15:29:08 ******/
DROP PROCEDURE [dbo].[sp_update_SCTPSMRK_JOBNO]
GO
/****** Object:  StoredProcedure [dbo].[sp_update_SCTPSMRK_JOBNO]    Script Date: 09/29/2017 15:29:10 ******/
SET ANSI_NULLS OFF
GO
SET QUOTED_IDENTIFIER OFF
GO



/************************************************************************
Author:		Frankie Cheung
Date:		Jun 18, 2010
Description:	Update SCTPSMRK's Job Number
************************************************************************/

CREATE procedure [dbo].[sp_update_SCTPSMRK_JOBNO]
                                                                                                                                                                                                                                                               
@cocde nvarchar(6) ,
@docnam nvarchar(100)
 
AS

declare @batno as nvarchar(100)
declare @tmpseq as nvarchar(100)
declare @batseq as nvarchar(100)
declare @doc as nvarchar(100)

begin

set @doc = ltrim(rtrim(@docnam))

set @batno = ltrim(left(@doc, charindex('-', @doc)-1))
set @tmpseq = right(@doc, len(@doc) - charindex('-', @doc))
set @batseq = ltrim(left(@tmpseq, charindex('.', @tmpseq)-1))


Update 
	SCTPSMRK
set 
	stm_jobno = pjd_jobord
from 
	POJBBDTL, POORDDTL
where
	stm_cocde = @cocde and
	stm_jobno = '' and
	pjd_jobord = pod_jobord and
	stm_ordno = case when charindex('-', pod_jobord) = 0 then '' else ltrim(left(pod_jobord, charindex('-', pod_jobord) - 1 )) end and
	stm_ordseq = pod_scline and
	pjd_batno = @batno and pjd_batseq = @batseq
end






GO
GRANT EXECUTE ON [dbo].[sp_update_SCTPSMRK_JOBNO] TO [ERPUSER] AS [dbo]
GO
