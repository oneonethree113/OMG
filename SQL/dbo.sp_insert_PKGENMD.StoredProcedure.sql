/****** Object:  StoredProcedure [dbo].[sp_insert_PKGENMD]    Script Date: 09/29/2017 15:29:09 ******/
DROP PROCEDURE [dbo].[sp_insert_PKGENMD]
GO
/****** Object:  StoredProcedure [dbo].[sp_insert_PKGENMD]    Script Date: 09/29/2017 15:29:09 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO


create procedure [dbo].[sp_insert_PKGENMD]

@pgm_cocde nvarchar(40),
@pgm_pkordno nvarchar(40),
@pgm_Del nvarchar(20),
@pgm_seq int,
@pgm_shpstrdat datetime,
@pgm_qty int,
@pgm_fty nvarchar(40),
@pgm_remark nvarchar(600),
@pgm_usrid nvarchar(40)

as

begin

insert into PKGENMD
(
pgm_cocde,
pgm_pkordno,
pgm_Del,
pgm_seq,
pgm_shpstrdat,
pgm_qty,
pgm_fty,
pgm_remark,
pgm_creusr,
pgm_updusr,
pgm_credat,
pgm_upddat
)
values
(
@pgm_cocde,
@pgm_pkordno,
@pgm_Del,
@pgm_seq,
@pgm_shpstrdat,
@pgm_qty,
@pgm_fty,
@pgm_remark,
@pgm_usrid,
@pgm_usrid,
getdate(),
getdate()

)



end





GO
GRANT EXECUTE ON [dbo].[sp_insert_PKGENMD] TO [ERPUSER] AS [dbo]
GO
