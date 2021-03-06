/****** Object:  StoredProcedure [dbo].[sp_update_PCM00002]    Script Date: 09/29/2017 15:29:08 ******/
DROP PROCEDURE [dbo].[sp_update_PCM00002]
GO
/****** Object:  StoredProcedure [dbo].[sp_update_PCM00002]    Script Date: 09/29/2017 15:29:10 ******/
SET ANSI_NULLS OFF
GO
SET QUOTED_IDENTIFIER ON
GO





/*
=========================================================
Program ID	: sp_insert_PCM00002
Description   	: Add Profit Centre list  for Profit Account Interface table 
Programmer  	: Lester Wu
ALTER  Date   	: 28 Nov, 2003
Last Modified  	: 
Table Read(s) 	: 
Table Write(s) 	: CUMRBT ( Customer Rebate )
=========================================================
 Modification History                                    
=========================================================
Date		Author		Description
               
=========================================================     
*/

CREATE PROCEDURE [dbo].[sp_update_PCM00002]
@COCDE 		VARCHAR(6),
@CMR_CUSNO	VARCHAR(20),
@CMR_FMLOPT 	VARCHAR(10),
@CMR_UPDUSR 	VARCHAR(30)
AS
BEGIN

UPDATE CUMRBT SET 
	CMR_RBTFMLOPT = @CMR_FMLOPT,
	CMR_UPDUSR = @CMR_UPDUSR,
	CMR_UPDDAT = GETDATE()
WHERE
	CMR_CUSNO = @CMR_CUSNO
END





GO
GRANT EXECUTE ON [dbo].[sp_update_PCM00002] TO [ERPUSER] AS [dbo]
GO
