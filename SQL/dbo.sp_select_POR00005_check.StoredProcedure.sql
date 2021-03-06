/****** Object:  StoredProcedure [dbo].[sp_select_POR00005_check]    Script Date: 09/29/2017 15:29:09 ******/
DROP PROCEDURE [dbo].[sp_select_POR00005_check]
GO
/****** Object:  StoredProcedure [dbo].[sp_select_POR00005_check]    Script Date: 09/29/2017 15:29:10 ******/
SET ANSI_NULLS OFF
GO
SET QUOTED_IDENTIFIER OFF
GO




-- Checked by Allan Yuen at 28/07/2003


CREATE PROCEDURE [dbo].[sp_select_POR00005_check]
@cocde		nvarchar(6),
@JP		nvarchar(1),	
@POfrom		nvarchar(20),
@POto		nvarchar(20)

AS

set nocount on

declare @invalid_count int

set @invalid_count = 0


select @invalid_count = count(*)
From	
POORDHDR (nolock)
left join POORDDTL (nolock) on poh_cocde = pod_cocde and poh_purord = pod_purord
left join SCORDDTL on pod_cocde = sod_cocde and	pod_scno = sod_ordno and pod_scline = sod_ordseq
left join SCORDHDR on soh_cocde = sod_cocde and sod_ordno = soh_ordno
WHERE
poh_cocde = @cocde and
( (@JP = 'J' and pod_jobord >= @POfrom and pod_jobord <= @POto)	or
  (@JP = 'P' and pod_purord >= @POfrom and pod_purord <= @POto)	or
  (@JP = 'R' and pod_RUNNO >= @POfrom and pod_RUNNO <= @POto) )
and (case poh_pursts
when 'ACT' then 'N'
when 'REL' then case soh_verno 
		when 1 then case poh_signappflg 
			    when 'Y' then 'Y' 
			    else 'N' end
		else 'Y' end
when 'CLO' then 'Y' end) = 'N'


select @invalid_count 'invalid_count'





GO
GRANT EXECUTE ON [dbo].[sp_select_POR00005_check] TO [ERPUSER] AS [dbo]
GO
