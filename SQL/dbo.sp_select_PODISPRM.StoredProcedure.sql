/****** Object:  StoredProcedure [dbo].[sp_select_PODISPRM]    Script Date: 09/29/2017 15:29:09 ******/
DROP PROCEDURE [dbo].[sp_select_PODISPRM]
GO
/****** Object:  StoredProcedure [dbo].[sp_select_PODISPRM]    Script Date: 09/29/2017 15:29:10 ******/
SET ANSI_NULLS OFF
GO
SET QUOTED_IDENTIFIER OFF
GO





-- Checked by Allan Yuen at 28/07/2003

/************************************************************************
Author:		Wong Hong
Date:		4th Jan, 2002
Description:	Select data From PODISPRM
Parameter:	1. Company
		2. PO No.	
***********************************************************************
200-10-25	Allan Yuen	Add function to keep description
*/
------------------------------------------------- 
CREATE procedure [dbo].[sp_select_PODISPRM]
                                                                                                                                                                                                                                                                 
---------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------- 
@pdp_cocde nvarchar(6) ,
@pdp_purord nvarchar(20),
@pdp_pdptyp nvarchar(1)                                     
---------------------------------------------- 
 
AS
begin
Select 
' ' as 'pdp_status',
p.pdp_cocde,
p.pdp_purord,
p.pdp_seqno,
p.pdp_dpltyp,
case p.pdp_dsc when '' then s.ydp_dsc else p.pdp_dsc end as 'pdp_dsc',
p.pdp_pctamt,
p.pdp_purpct,
p.pdp_paamt,
p.pdp_creusr,
p.pdp_updusr,
p.pdp_credat,
p.pdp_upddat,
cast(p.pdp_timstp as int) as pdp_timstp
--------------------------------- 
from PODISPRM p, SYDISPRM s
where                                                                                                                                                                                                                                                                 
---------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------- 
p.pdp_cocde = @pdp_cocde and
p.pdp_purord = @pdp_purord and
p.pdp_pdptyp = @pdp_pdptyp and 
--s.ydp_cocde = p.pdp_cocde and
s.ydp_type = p.pdp_pdptyp and
s.ydp_cde = p.pdp_dpltyp
---------------------------------------------------------- 
end






GO
GRANT EXECUTE ON [dbo].[sp_select_PODISPRM] TO [ERPUSER] AS [dbo]
GO
