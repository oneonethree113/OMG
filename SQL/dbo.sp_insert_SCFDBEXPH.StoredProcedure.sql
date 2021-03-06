/****** Object:  StoredProcedure [dbo].[sp_insert_SCFDBEXPH]    Script Date: 09/29/2017 15:29:09 ******/
DROP PROCEDURE [dbo].[sp_insert_SCFDBEXPH]
GO
/****** Object:  StoredProcedure [dbo].[sp_insert_SCFDBEXPH]    Script Date: 09/29/2017 15:29:09 ******/
SET ANSI_NULLS OFF
GO
SET QUOTED_IDENTIFIER OFF
GO




CREATE procedure [dbo].[sp_insert_SCFDBEXPH]
                                                                                                                                                                                                                                                                 
@sbe_cocde 	nvarchar(6),
@sbe_lotno nvarchar(255),
@sbe_filename nvarchar(255),
@sbe_jobord nvarchar(30),
@sbe_updusr nvarchar(30)

 
AS

begin

insert into SCFDBEXPH
(
sbe_cocde,
sbe_lotno,
sbe_filename,
sbe_jobord,
sbe_exptyp,
sbe_apprv,
sbe_creusr,
sbe_credat,
sbe_updusr,
sbe_upddat
)
select 
sbe_cocde,
sbe_lotno,
sbe_filename,
sbe_jobord,
sbe_exptyp,
sbe_apprv,
@sbe_updusr,
getdate(),
@sbe_updusr,
getdate()
from 
SCFDBEXP
where
sbe_lotno = @sbe_lotno
and 
sbe_filename = @sbe_filename
and
sbe_jobord = @sbe_jobord
and 
sbe_apprv = 'Y'

if (@@rowcount > 0 )
begin

delete
from 
SCFDBEXP
where
sbe_lotno = @sbe_lotno
and 
sbe_filename = @sbe_filename
and
sbe_jobord = @sbe_jobord
and 
sbe_apprv = 'Y'
end 

end



GO
GRANT EXECUTE ON [dbo].[sp_insert_SCFDBEXPH] TO [ERPUSER] AS [dbo]
GO
