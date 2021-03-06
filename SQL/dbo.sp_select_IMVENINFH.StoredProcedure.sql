/****** Object:  StoredProcedure [dbo].[sp_select_IMVENINFH]    Script Date: 09/29/2017 15:29:09 ******/
DROP PROCEDURE [dbo].[sp_select_IMVENINFH]
GO
/****** Object:  StoredProcedure [dbo].[sp_select_IMVENINFH]    Script Date: 09/29/2017 15:29:10 ******/
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
ate:		24th September, 2001
Description:	Select data From IMVENINFH
Parameter:	1. Company
		2. Item No.	
************************************************************************/

CREATE PROCEDURE [dbo].[sp_select_IMVENINFH] 


@ivi_cocde	nvarchar(6),
@ivi_itmno  	nvarchar (20)

AS


Select 
' '  as 'ivi_status',
'' as 'ivi_cocde',
ivi_itmno,
ivi_venitm  ,
ivi_venno  ,
isnull(vbi_vensna,' ') as 'vbi_vensna',
ivi_subcde,
ivi_def  ,
--ivi_tirtyp,
--ivi_moqctn,
--ivi_qty,
--ivi_moa,
ivi_creusr  ,
ivi_updusr,
ivi_credat,
ivi_upddat,
cast(ivi_timstp as int) as 'ivi_timstp',
vbi_ventyp


from IMVENINFH
left join VNBASINF on ivi_venno = vbi_venno --and  vbi_cocde = @ivi_cocde
Where 
--ivi_cocde = @ivi_cocde and
ivi_itmno = @ivi_itmno
ORDER BY ivi_def desc

GO
GRANT EXECUTE ON [dbo].[sp_select_IMVENINFH] TO [ERPUSER] AS [dbo]
GO
