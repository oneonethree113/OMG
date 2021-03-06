/****** Object:  StoredProcedure [dbo].[sp_select_ITEMNO]    Script Date: 09/29/2017 15:29:09 ******/
DROP PROCEDURE [dbo].[sp_select_ITEMNO]
GO
/****** Object:  StoredProcedure [dbo].[sp_select_ITEMNO]    Script Date: 09/29/2017 15:29:10 ******/
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
Date:		13th September, 2001
Description:	Select Max Itmno  From IMBASINF,IMBASINF
Parameter:	1. Company
		2. Item No.	
************************************************************************/
------------------------------------------------- 
CREATE procedure [dbo].[sp_select_ITEMNO]
                                                                                                                                                                                                                                                                 
---------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------- 
@ibi_cocde	nvarchar(6),
@ibi_venno	nvarchar(6),
@ibi_lnecde	nvarchar(10)


---------------------------------------------- 
AS
declare @Year  nvarchar(2)
SET @Year = (Select right(Year(Getdate()),2))


begin
Select
@Year + @ibi_venno + left(@ibi_lnecde,3) + '-' +

Case (Len((case when a.itmno>b.itmno then a.itmno else b.itmno end + 1)))  
when 1 then '0000'
when 2 then '000'	
when 3 then '00'	
when 4 then '0'
else ''
end								
+
ltrim(Str((case when a.itmno>b.itmno then a.itmno 
else b.itmno
end + 1)))

 as 'Max_itmno'
from
(
Select isnull(Max(cast(right(ibi_itmno,5) as int)),0)  as 'itmno' 
from imbasinf 
where 
--	ibi_cocde = @ibi_cocde and
	ibi_venno = @ibi_venno and
	ibi_lnecde = @ibi_lnecde and
	left(ibi_itmno,2) = @Year and
	ibi_credat > '2010-01-01'
)a, 
(Select isnull(Max(cast(right(ibi_itmno,5) as int)),0)  as 'itmno' 
from imbasinfh 
where 
--	ibi_cocde = @ibi_cocde and
	ibi_venno = @ibi_venno and
	ibi_lnecde = @ibi_lnecde and
	left(ibi_itmno,2) = @Year and
	ibi_credat > '2010-01-01'
)b

--------------------------------------------------------
end

GO
GRANT EXECUTE ON [dbo].[sp_select_ITEMNO] TO [ERPUSER] AS [dbo]
GO
