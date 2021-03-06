/****** Object:  StoredProcedure [dbo].[sp_select_Shipmark_XML]    Script Date: 09/29/2017 15:29:09 ******/
DROP PROCEDURE [dbo].[sp_select_Shipmark_XML]
GO
/****** Object:  StoredProcedure [dbo].[sp_select_Shipmark_XML]    Script Date: 09/29/2017 15:29:10 ******/
SET ANSI_NULLS OFF
GO
SET QUOTED_IDENTIFIER OFF
GO

CREATE PROCEDURE [dbo].[sp_select_Shipmark_XML] 
as

select 
stm_ordno,
stm_ordseq,
stm_jobno,
stm_smkno,
case stm_act when 'DEL' then 'DEL' else 'ADD' end as 'stm_act',
sod_zorvbeln,
sod_zorposnr,
stm_credat,
stm_upddat
from SCTPSMRK (nolock), SCORDDTL (nolock)
where stm_ordno = sod_ordno and stm_ordseq = sod_ordseq
--and stm_credat > getdate() - 1 and stm_credat <= getdate()
and stm_credat > '2015-10-7'  and stm_credat <= getdate()



GO
GRANT EXECUTE ON [dbo].[sp_select_Shipmark_XML] TO [ERPUSER] AS [dbo]
GO
