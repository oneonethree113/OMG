/****** Object:  StoredProcedure [dbo].[sp_physical_delete_PKWASGE]    Script Date: 09/29/2017 15:29:09 ******/
DROP PROCEDURE [dbo].[sp_physical_delete_PKWASGE]
GO
/****** Object:  StoredProcedure [dbo].[sp_physical_delete_PKWASGE]    Script Date: 09/29/2017 15:29:10 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO










/************************************************************************
Author:		Kath Ng     
Date:		25th September, 2001
Description:	Insert data into PKWASGE
************************************************************************/

CREATE PROCEDURE [dbo].[sp_physical_delete_PKWASGE] 
--------------------------------------------------------------------------------------------------------------------------------------

@pwa_cocde nvarchar(6),
@pwa_code nvarchar(6),
@seq	int
--------------------------------------------------------------------------------------------------------------------------------------
AS

begin

Delete PKWASGE
where pwa_code = @pwa_code and pwa_seq = @seq

end




GO
GRANT EXECUTE ON [dbo].[sp_physical_delete_PKWASGE] TO [ERPUSER] AS [dbo]
GO
