/****** Object:  StoredProcedure [dbo].[sp_select_SYCUREX_transaction_sp]    Script Date: 09/29/2017 15:29:08 ******/
DROP PROCEDURE [dbo].[sp_select_SYCUREX_transaction_sp]
GO
/****** Object:  StoredProcedure [dbo].[sp_select_SYCUREX_transaction_sp]    Script Date: 09/29/2017 15:29:10 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO


CREATE PROCEDURE [dbo].[sp_select_SYCUREX_transaction_sp]
	@cocde NVARCHAR(6),
	@frmcur NVARCHAR(6),
	@tocur NVARCHAR(6),
	@effdat datetime,
	@dummy nvarchar(1),
	@buyrat numeric(16,11) output,
	@selrat numeric(16,11) output
AS

Begin

select 
	@buyrat = yce_buyrat ,
	@selrat = yce_selrat
from SYCUREX
where
yce_frmcur = @frmcur and
yce_tocur = @tocur and
(
( @effdat = '1900-01-01' and yce_iseff = 'Y' ) or ( yce_effdat = @effdat + ' 00:00:00' )
)

END

GRANT  EXECUTE  ON [dbo].[sp_select_SYCUREX_transaction_sp]  TO [ERPUSER]



GO
