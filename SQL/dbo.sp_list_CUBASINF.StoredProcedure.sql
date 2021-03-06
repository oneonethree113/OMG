/****** Object:  StoredProcedure [dbo].[sp_list_CUBASINF]    Script Date: 09/29/2017 15:29:09 ******/
DROP PROCEDURE [dbo].[sp_list_CUBASINF]
GO
/****** Object:  StoredProcedure [dbo].[sp_list_CUBASINF]    Script Date: 09/29/2017 15:29:09 ******/
SET ANSI_NULLS OFF
GO
SET QUOTED_IDENTIFIER OFF
GO





/************************************************************************
Author:		Kenny Chan
Date:		24th September, 2001
Description:	List data From CUBASINF

Modify History:
Author:		Kath
Date:		28th September, 2001
Purpose:		For Customer Master Maintenance  difference Customer (Primay, Secondary, All and Add Customer)
From		POM00001 - PO Maintenance
************************************************************************
=========================================================
Program ID	: 
Description   	: 
Programmer  	: 
Create Date   	: 
Last Modified  	: 
Table Read(s) 	:
Table Write(s) 	:
=========================================================
 Modification History                                    
=========================================================
Date		Author		Description
17 Jun 2003	Lewis To		Add field alias (cbi_cusali)         
11 Jul 2003	Lewis To		Ignor Company code to handle multi company       
=========================================================     
*/
CREATE procedure [dbo].[sp_list_CUBASINF]
                                                                                                                                                                                                                                                               
@cbi_cocde	nvarchar(6),
@Type		nvarchar(2)
 
AS

------------------------------------------------------------------------------------------------
IF @Type = 'N' 	----- For Add a new customer number (Modified by Kath)

BEGIN


SELECT MAX(RIGHT(cbi_cusno, 4) + 1) as cbi_cusno FROM CUBASINF where left(cbi_cusno,1)>'4' and left(cbi_cusno,1)<'7'
--cbi_cocde = @cbi_cocde

ORDER BY cbi_cusno

END
------------------------------------------------------------------------------------------------
------------------------------------------------------------------------------------------------
IF @Type = 'NM' 	----- For Add a new Elliwell customer number (Modified by Marco)

BEGIN


SELECT isnull(MAX(RIGHT(cbi_cusno, 4)),0)+ 1 as cbi_cusno FROM CUBASINF where left(cbi_cusno,1)>'6' and left(cbi_cusno,1)<'9'
--cbi_cocde = @cbi_cocde

ORDER BY cbi_cusno

END
------------------------------------------------------------------------------------------------
------------------------------------------------------------------------------------------------
IF @Type = 'A' 	----- For all customer, just past the parameter "A", then select all customer information

BEGIN

SELECT cbi_cusno, 
	cbi_cusnam, 
	cbi_cussna = case cbi_cussts when 'A' then cbi_cussna When 'I' then rtrim(cbi_cussna) + '(Inactive)' else rtrim(cbi_cussna) + '(Discontinue)' end, 
	cbi_custyp, 
	cbi_cusali		--Add by Lewis

FROM CUBASINF 

--WHERE cbi_cocde = @cbi_cocde

ORDER BY cbi_cusno

END
------------------------------------------------------------------------------------------------
------------------------------------------------------------------------------------------------
IF @Type = 'P' 	----- For Primary Customer select Secondary Customer

BEGIN

SELECT cbi_cusno, cbi_cusnam, cbi_cussna, cbi_custyp,
               cbi_cusali		--Add by Lewis
 

FROM CUBASINF 

WHERE --cbi_cocde = @cbi_cocde and 
cbi_custyp = 'S'
and cbi_cussts = 'A'

ORDER BY cbi_cusno

END
------------------------------------------------------------------------------------------------
IF @Type = 'PA'	------For All Select Primary Customer

BEGIN

SELECT cbi_cusno, cbi_cusnam, cbi_cussna, cbi_custyp,
                cbi_cusali		--Add by Lewis

FROM CUBASINF

WHERE --cbi_cocde = @cbi_cocde and 
cbi_custyp ='P'

ORDER BY cbi_cusno

END
------------------------------------------------------------------------------------------------
IF @Type = 'S'	------For Secondary Customer Select Primary Customer

BEGIN

SELECT cbi_cusno, cbi_cusnam, cbi_cussna, cbi_custyp,
               cbi_cusali		--Add by Lewis

FROM CUBASINF

WHERE --cbi_cocde = @cbi_cocde and 
cbi_custyp = 'P'
and cbi_cussts = 'A'

ORDER BY cbi_cusno

END
------------------------------------------------------------------------------------------------





GO
GRANT EXECUTE ON [dbo].[sp_list_CUBASINF] TO [ERPUSER] AS [dbo]
GO
