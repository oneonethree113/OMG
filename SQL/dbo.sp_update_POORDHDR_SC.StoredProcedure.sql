/****** Object:  StoredProcedure [dbo].[sp_update_POORDHDR_SC]    Script Date: 09/29/2017 15:29:08 ******/
DROP PROCEDURE [dbo].[sp_update_POORDHDR_SC]
GO
/****** Object:  StoredProcedure [dbo].[sp_update_POORDHDR_SC]    Script Date: 09/29/2017 15:29:10 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO







/*
=================================================================
Program ID	: sp_update_POORDHDR_SC
Description	: Update Entry for POORDHDR
Programmer	: David Yue
=================================================================
	MODIFICATION HISTORY
=================================================================
   Date		 Editor			Description
=================================================================
2013-08-02 	David Yue		SP Created
=================================================================
*/

CREATE procedure [dbo].[sp_update_POORDHDR_SC]
@poh_cocde	nvarchar(6),
@poh_purord	nvarchar(30),
@poh_porctp	nvarchar(50),
@poh_prctrm	nvarchar(6),
@poh_paytrm	nvarchar(6),
@poh_rmk	nvarchar(400),
@poh_discnt	numeric(10, 3),
@poh_pocdat	datetime,
@poh_pocdatend	datetime,
@creusr		nvarchar(30)

AS

update	POORDHDR
set	poh_porctp = @poh_porctp,
	poh_prctrm = @poh_prctrm,
	poh_paytrm = substring(@poh_paytrm,1,3),
	poh_rmk = @poh_rmk,
	poh_discnt = @poh_discnt,
	poh_pocdat = @poh_pocdat,
	poh_pocdatend = @poh_pocdatend,
	poh_updusr = left('S-'+ @creusr, 30),
	poh_upddat = getdate()
where	poh_cocde = @poh_cocde and
	poh_purord = @poh_purord


GO
GRANT EXECUTE ON [dbo].[sp_update_POORDHDR_SC] TO [ERPUSER] AS [dbo]
GO
