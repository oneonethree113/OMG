/****** Object:  StoredProcedure [dbo].[sp_select_IMSALBKG]    Script Date: 09/29/2017 15:29:09 ******/
DROP PROCEDURE [dbo].[sp_select_IMSALBKG]
GO
/****** Object:  StoredProcedure [dbo].[sp_select_IMSALBKG]    Script Date: 09/29/2017 15:29:10 ******/
SET ANSI_NULLS OFF
GO
SET QUOTED_IDENTIFIER OFF
GO





/*
=========================================================
Program ID	: 
Description   	: 
Programmer  	: 
Create Date   	: 
Last Modified  	: 17 July 2003
Table Read(s) 	:
Table Write(s) 	:
=========================================================
 Modification History                                    
=========================================================
Date		Author		Description
=========================================================     
17 July 2003	Allan Yuen		For Merge Porject, disable company code
*/



/************************************************************************
Author:		Kenny Chan
Date:		28th September, 2001
************************************************************************/
------------------------------------------------- 
CREATE PROCEDURE [dbo].[sp_select_IMSALBKG] 

@isb_cocde  nvarchar(6),
@isb_itmno  nvarchar( 20)


AS

SELECT 
'' as isb_cocde,
isb_itmno,
isb_yymm = Case left(isb_yymm,2) when '99' then '19' + isb_yymm else '20' + isb_yymm end,
isb_mtdbok = round(sum(isb_mtdbok),0),
isb_mtdsal = round(sum(isb_mtdsal),0),
isb_mtdpur = round(sum(isb_mtdpur),0),
'' as isb_creusr,
'' as isb_updusr,
'' as isb_credat,
'' as isb_upddat,
'' as 'is_timstp'
from IMSALBKG
where 
--isb_cocde = @isb_cocde and
isb_itmno = @isb_itmno
group by isb_itmno, isb_yymm
order by Case left(isb_yymm,2) when '99' then '19' + isb_yymm else '20' + isb_yymm end desc





GO
GRANT EXECUTE ON [dbo].[sp_select_IMSALBKG] TO [ERPUSER] AS [dbo]
GO
