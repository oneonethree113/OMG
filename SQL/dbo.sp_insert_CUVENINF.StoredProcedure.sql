/****** Object:  StoredProcedure [dbo].[sp_insert_CUVENINF]    Script Date: 09/29/2017 15:29:09 ******/
DROP PROCEDURE [dbo].[sp_insert_CUVENINF]
GO
/****** Object:  StoredProcedure [dbo].[sp_insert_CUVENINF]    Script Date: 09/29/2017 15:29:09 ******/
SET ANSI_NULLS OFF
GO
SET QUOTED_IDENTIFIER OFF
GO







/************************************************************************
Author:		Kath Ng     
Date:		14th September, 2001
Description:	Insert data into CUVENINF
Parameter:	1. Company Code range    
		2. Customer Code range    
************************************************************************/

CREATE PROCEDURE [dbo].[sp_insert_CUVENINF] 
--------------------------------------------------------------------------------------------------------------------------------------

@cvi_cocde	nvarchar(6),
@cvi_cusno	nvarchar(6),
@cvi_assvid	nvarchar(20),
@cvi_assdsc	nvarchar(200),
@cvi_creusr	nvarchar(30)
--@cvi_updusr	nvarchar(30)



--------------------------------------------------------------------------------------------------------------------------------------
AS

INSERT INTO  CUVENINF

(
cvi_cocde,
cvi_cusno,
cvi_assvid,
cvi_assdsc,
cvi_creusr,
cvi_updusr,
cvi_credat,
cvi_upddat

 )
--------------------------------------------------------------------------------------------------------------------------------------
values
(
--@cvi_cocde,
' ',
@cvi_cusno,
@cvi_assvid,
@cvi_assdsc,
@cvi_creusr,
@cvi_creusr,
getdate(),
getdate()

)




GO
GRANT EXECUTE ON [dbo].[sp_insert_CUVENINF] TO [ERPUSER] AS [dbo]
GO
