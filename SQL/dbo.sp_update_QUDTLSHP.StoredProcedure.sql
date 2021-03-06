/****** Object:  StoredProcedure [dbo].[sp_update_QUDTLSHP]    Script Date: 09/29/2017 15:29:08 ******/
DROP PROCEDURE [dbo].[sp_update_QUDTLSHP]
GO
/****** Object:  StoredProcedure [dbo].[sp_update_QUDTLSHP]    Script Date: 09/29/2017 15:29:10 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO



CREATE PROCEDURE [dbo].[sp_update_QUDTLSHP] 
@qds_cocde nvarchar(6),
@qds_qutno nvarchar(10),
@qds_qutseq int,
@qds_shpseq int,
@qds_shpqty int,
@qds_ftyshpstr datetime,
@qds_ftyshpend datetime,
@qds_custshpstr datetime,
@qds_custshpend datetime,
@qds_pckunt nvarchar(6),
@qds_creusr nvarchar(30)

AS

update QUDTLSHP set 
qds_shpqty = @qds_shpqty,
qds_ftyshpstr = @qds_ftyshpstr,
qds_ftyshpend = @qds_ftyshpend,
qds_custshpstr = @qds_custshpstr,
qds_custshpend = @qds_custshpend,
qds_pckunt = @qds_pckunt,
qds_updusr = @qds_creusr,
qds_upddat = getdate()
where 
qds_cocde = @qds_cocde and
qds_qutno = @qds_qutno and
qds_qutseq = @qds_qutseq and
qds_shpseq = @qds_shpseq






GO
GRANT EXECUTE ON [dbo].[sp_update_QUDTLSHP] TO [ERPUSER] AS [dbo]
GO
