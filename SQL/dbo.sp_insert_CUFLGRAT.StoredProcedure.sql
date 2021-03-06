/****** Object:  StoredProcedure [dbo].[sp_insert_CUFLGRAT]    Script Date: 09/29/2017 15:29:09 ******/
DROP PROCEDURE [dbo].[sp_insert_CUFLGRAT]
GO
/****** Object:  StoredProcedure [dbo].[sp_insert_CUFLGRAT]    Script Date: 09/29/2017 15:29:09 ******/
SET ANSI_NULLS OFF
GO
SET QUOTED_IDENTIFIER OFF
GO



/************************************************************************
Author:		Frankie Cheung
Date:		10th December, 2008
Description:	insert data into CUFLGRAT
***********************************************************************
*/

CREATE procedure [dbo].[sp_insert_CUFLGRAT]

@cfr_cocde	nvarchar(6),
@cfr_cusno	nvarchar(6),
@cfr_prctrm	nvarchar(100),
@cfr_flgrat	numeric(13,4),
@cfr_creusr	nvarchar(30)

AS

BEGIN

--------------------------------------------------------------------------------------------------


insert into CUFLGRAT
(
	cfr_cocde,
	cfr_cusno,
	cfr_prctrm,
	cfr_flgrat,
	cfr_creusr,
	cfr_updusr,
	cfr_credat,
	cfr_upddat
)
values
(
	'',
	@cfr_cusno,
	ltrim(rtrim(@cfr_prctrm)),
	@cfr_flgrat,
	@cfr_creusr,
	@cfr_creusr,
	getdate(),
	getdate()
)

END



GO
GRANT EXECUTE ON [dbo].[sp_insert_CUFLGRAT] TO [ERPUSER] AS [dbo]
GO
