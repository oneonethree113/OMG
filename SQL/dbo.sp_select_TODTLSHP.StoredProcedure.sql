/****** Object:  StoredProcedure [dbo].[sp_select_TODTLSHP]    Script Date: 09/29/2017 15:29:08 ******/
DROP PROCEDURE [dbo].[sp_select_TODTLSHP]
GO
/****** Object:  StoredProcedure [dbo].[sp_select_TODTLSHP]    Script Date: 09/29/2017 15:29:10 ******/
SET ANSI_NULLS OFF
GO
SET QUOTED_IDENTIFIER OFF
GO




CREATE   PROCEDURE [dbo].[sp_select_TODTLSHP]
@tds_cocde		nvarchar(6),
@tds_toordno		nvarchar(20)

AS

declare @Gen nvarchar(1)

set @Gen = ''

select 
@Gen as 'Gen',
tds_cocde,
tds_toordno,
tds_toordseq,
tds_verno,
tds_shpseq,
tds_ftyshpstr,
tds_ftyshpend,
tds_cushpstr,
tds_cushpend,
tds_shpqty,
tds_podat,
tds_pckunt,
tds_creusr,
tds_updusr,
tds_credat,
tds_upddat,
cast(tds_timstp as int) as 'tds_timstp'
from 
TODTLSHP (nolock)
where tds_toordno = @tds_toordno
order by tds_toordseq, tds_verno, tds_shpseq



GO
GRANT EXECUTE ON [dbo].[sp_select_TODTLSHP] TO [ERPUSER] AS [dbo]
GO
