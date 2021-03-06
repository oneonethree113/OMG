/****** Object:  StoredProcedure [dbo].[sp_Physical_Delete_syntsmk]    Script Date: 09/29/2017 15:29:09 ******/
DROP PROCEDURE [dbo].[sp_Physical_Delete_syntsmk]
GO
/****** Object:  StoredProcedure [dbo].[sp_Physical_Delete_syntsmk]    Script Date: 09/29/2017 15:29:10 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO







CREATE procedure [dbo].[sp_Physical_Delete_syntsmk]  
@stm_cocde  nvarchar(6),  
@docnam  nvarchar(20),  
@updusr  nvarchar(30)

AS  

declare @batno as nvarchar(20)
declare @tmpseq as nvarchar(10)
declare @batseq as nvarchar(10)
declare @doc as nvarchar(20)
declare @stm_ordno as nvarchar(20)
declare @stm_ordseq as int


begin

set @doc = ltrim(rtrim(@docnam))

set @batno = ltrim(left(@doc, charindex('-', @doc)-1))
set @tmpseq = right(@doc, len(@doc) - charindex('-', @doc))
set @batseq = ltrim(left(@tmpseq, charindex('.', @tmpseq)-1))


set @stm_ordno = ''
set @stm_ordseq  = 0

select	distinct @stm_ordno = isnull(stm_ordno, ''), @stm_ordseq = isnull(stm_ordseq, 0)
from 
	POJBBDTL, POORDDTL, SCTPSMRK
where
	pjd_jobord = pod_jobord and
	stm_ordno = case when charindex('-', pod_jobord) = 0 then '' else ltrim(left(pod_jobord, charindex('-', pod_jobord) - 1 )) end and
	stm_ordseq = pod_scline and
	stm_act <> 'DEL' and
	pjd_batno = @batno and pjd_batseq = @batseq


if ltrim(rtrim(@stm_ordno)) <> '' and @stm_ordseq <> 0 
begin
	Delete from 
		SCTPSMRK
	where
		stm_ordno = @stm_ordno and stm_ordseq = @stm_ordseq
end

end








GO
GRANT EXECUTE ON [dbo].[sp_Physical_Delete_syntsmk] TO [ERPUSER] AS [dbo]
GO
