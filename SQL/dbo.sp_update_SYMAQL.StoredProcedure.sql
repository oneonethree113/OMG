/****** Object:  StoredProcedure [dbo].[sp_update_SYMAQL]    Script Date: 09/29/2017 15:29:08 ******/
DROP PROCEDURE [dbo].[sp_update_SYMAQL]
GO
/****** Object:  StoredProcedure [dbo].[sp_update_SYMAQL]    Script Date: 09/29/2017 15:29:10 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create PROCEDURE [dbo].[sp_update_SYMAQL]
@yal_cocde	nvarchar(6),
@yal_lotfm int,
@yal_lotto int,
@yal_sample int,
@yal_aql15 int,
@yal_aql25 int,
@yal_updusr	nvarchar(30)

AS
begin
			update SYMAQL
			set 
yal_sample = @yal_sample,
yal_aql15=@yal_aql15,
yal_aql25=@yal_aql25,
yal_updusr =@yal_updusr,
yal_upddat =getdate() 
			where 
			--yct_cocde = @cocde
			--and 
yal_lotfm = @yal_lotfm
and yal_lotto = @yal_lotto 
end









----------



GO
GRANT EXECUTE ON [dbo].[sp_update_SYMAQL] TO [ERPUSER] AS [dbo]
GO
