/****** Object:  StoredProcedure [dbo].[sp_select_CUCNTINF]    Script Date: 09/29/2017 15:29:09 ******/
DROP PROCEDURE [dbo].[sp_select_CUCNTINF]
GO
/****** Object:  StoredProcedure [dbo].[sp_select_CUCNTINF]    Script Date: 09/29/2017 15:29:10 ******/
SET ANSI_NULLS OFF
GO
SET QUOTED_IDENTIFIER OFF
GO







/************************************************************************
Author:		Kath Ng     
Date:		24th September, 2001
Description:	Select data From CUCNTINF
Parameter:	1. Company Code range    
		2. Customer Code range    
***********************************************************************
11 Jul 2003	Lewis To		Ignor Company code to handle multi company
*/

CREATE procedure [dbo].[sp_select_CUCNTINF]
                                                                                                                                                                                                                                                                 

@cci_cocde	nvarchar(6),
@cci_cusno	nvarchar(6) 
                                               
 
AS

begin

Select	cci_cocde,	cci_cusno,	cci_cnttyp,
	cci_cntseq,	cci_cntadr,	cci_cntstt,
	cci_cntcty,	cci_cntpst,	cci_cntctp,
	cci_cnttil,		cci_cntphn,	cci_cntfax,
	cci_cnteml,	cci_cntrmk,	cci_cntdef,
	cci_creusr,	cci_updusr,	cci_credat,
	cast(cci_timstp as int) as cci_timstp
                                  

from CUCNTINF
 where
                                                                                                                                                                                                                                                                 

 --cci_cocde = @cci_cocde and
cci_cusno = @cci_cusno
                           

end







GO
GRANT EXECUTE ON [dbo].[sp_select_CUCNTINF] TO [ERPUSER] AS [dbo]
GO
