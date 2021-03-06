/****** Object:  StoredProcedure [dbo].[sp_select_CUCSEINF]    Script Date: 09/29/2017 15:29:09 ******/
DROP PROCEDURE [dbo].[sp_select_CUCSEINF]
GO
/****** Object:  StoredProcedure [dbo].[sp_select_CUCSEINF]    Script Date: 09/29/2017 15:29:10 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO






/************************************************************************
Author:		Kath Ng     
Date:		4th October, 2001
Description:	Select data From CUCSEINF
Parameter:	1. Company Code range    
		2. Customer Code range    
************************************************************************/

CREATE procedure [dbo].[sp_select_CUCSEINF]
                                                                                                                                                                                                                                                                 

@csi_cocde	nvarchar(6),
@csi_cusno	nvarchar(6) 
                                               
 
AS

begin

Select	csi_cocde,	csi_cusno,	csi_csetyp,
	csi_csenam,	csi_cseacc,	csi_cseadr,
	csi_csestt,		csi_csecty,	csi_csepst,
	csi_csectp,	csi_csetil,		csi_csephn,
	csi_csefax,	csi_cseeml,	csi_csermk,
	csi_csedef,	csi_cseinr,	csi_creusr,
	csi_updusr,	csi_credat,
	cast(csi_timstp as int) as csi_timstp
                                  

from CUCSEINF
 where
                                                                                                                                                                                                                                                                 

--csi_cocde = @csi_cocde and
csi_cusno = @csi_cusno
                           

end







GO
GRANT EXECUTE ON [dbo].[sp_select_CUCSEINF] TO [ERPUSER] AS [dbo]
GO
