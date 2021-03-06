/****** Object:  StoredProcedure [dbo].[sp_physical_delete_PCM00002]    Script Date: 09/29/2017 15:29:09 ******/
DROP PROCEDURE [dbo].[sp_physical_delete_PCM00002]
GO
/****** Object:  StoredProcedure [dbo].[sp_physical_delete_PCM00002]    Script Date: 09/29/2017 15:29:10 ******/
SET ANSI_NULLS OFF
GO
SET QUOTED_IDENTIFIER ON
GO






/*
=========================================================
Program ID	: sp_physical_delete_PCM00002
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
CREATE  PROCEDURE [dbo].[sp_physical_delete_PCM00002]
@COCDE 		VARCHAR(6),
@CMR_CUSNO	VARCHAR(20),
@CMR_FMLOPT 	VARCHAR(10)
AS
BEGIN

DELETE FROM CUMRBT 
WHERE 
	CMR_CUSNO = @CMR_CUSNO AND
	CMR_RBTFMLOPT = @CMR_FMLOPT
	
END





GO
GRANT EXECUTE ON [dbo].[sp_physical_delete_PCM00002] TO [ERPUSER] AS [dbo]
GO
