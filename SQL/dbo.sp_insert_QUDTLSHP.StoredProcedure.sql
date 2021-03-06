/****** Object:  StoredProcedure [dbo].[sp_insert_QUDTLSHP]    Script Date: 09/29/2017 15:29:09 ******/
DROP PROCEDURE [dbo].[sp_insert_QUDTLSHP]
GO
/****** Object:  StoredProcedure [dbo].[sp_insert_QUDTLSHP]    Script Date: 09/29/2017 15:29:09 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO



CREATE PROCEDURE [dbo].[sp_insert_QUDTLSHP] 
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

insert into [QUDTLSHP] (
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
qds_upddat
)
values (
@qds_cocde,
@qds_qutno,
@qds_qutseq,
@qds_shpseq,
@qds_shpqty,
@qds_ftyshpstr,
@qds_ftyshpend,
@qds_custshpstr,
@qds_custshpend,
@qds_pckunt,
@qds_creusr,
@qds_creusr,
getdate(),
getdate()
)




GO
GRANT EXECUTE ON [dbo].[sp_insert_QUDTLSHP] TO [ERPUSER] AS [dbo]
GO
