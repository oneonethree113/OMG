/****** Object:  StoredProcedure [dbo].[sp_insert_IMCUSSTY]    Script Date: 09/29/2017 15:29:09 ******/
DROP PROCEDURE [dbo].[sp_insert_IMCUSSTY]
GO
/****** Object:  StoredProcedure [dbo].[sp_insert_IMCUSSTY]    Script Date: 09/29/2017 15:29:09 ******/
SET ANSI_NULLS OFF
GO
SET QUOTED_IDENTIFIER OFF
GO




/************************************************************************
Author:		Frankie Cheung
Date:		27 Oct, 2008
Description:	Insert data into IMCUSSTY
***********************************************************************
*/

CREATE procedure [dbo].[sp_insert_IMCUSSTY]

@ics_cocde	nvarchar(6),
@ics_cusno	nvarchar(12),
@ics_cusstyno	nvarchar(60),
@ics_itmno	nvarchar(40),
@userid		nvarchar(30)

AS

BEGIN
--------------------------------------------------------------------------------------------------

	If ( 	select count(*) 
		from IMCUSSTY 
		where ics_cusno = @ics_cusno and ics_cusstyno = @ics_cusstyno
	) = 0
	begin
	
		insert into IMCUSSTY
		(
			ics_cusno,
			ics_cusstyno,
			ics_itmno,
			ics_creusr,
			ics_updusr,
			ics_credat,
			ics_upddat
			)
		values
		(
			@ics_cusno,
			@ics_cusstyno,
			@ics_itmno,
			@userid,
			@userid,
			getdate(),
			getdate()
			)	
	end
END





GO
GRANT EXECUTE ON [dbo].[sp_insert_IMCUSSTY] TO [ERPUSER] AS [dbo]
GO
