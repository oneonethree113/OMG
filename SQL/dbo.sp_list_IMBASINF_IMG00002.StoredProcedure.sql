/****** Object:  StoredProcedure [dbo].[sp_list_IMBASINF_IMG00002]    Script Date: 09/29/2017 15:29:09 ******/
DROP PROCEDURE [dbo].[sp_list_IMBASINF_IMG00002]
GO
/****** Object:  StoredProcedure [dbo].[sp_list_IMBASINF_IMG00002]    Script Date: 09/29/2017 15:29:09 ******/
SET ANSI_NULLS OFF
GO
SET QUOTED_IDENTIFIER OFF
GO



/*
=========================================================
Program ID	: 
Description   	: 
Programmer  	:  Frankie Cheung
Create Date   	: 
Last Modified  	: 
Table Read(s) 	:
Table Write(s) 	:
=========================================================
 Modification History                                    
=========================================================
Date		Author		Description
=========================================================     
*/

CREATE PROCEDURE [dbo].[sp_list_IMBASINF_IMG00002] 

@cocde nvarchar(8) = ' ',
@ibi_itmno nvarchar(20),
@usrid nvarchar(30)

AS

select	ibi_itmno, 
	replace(ibi_lnecde, '/', '_') as 'lnecde', 
	right(ibi_lnecde,3) as 'YrSn', 
	ibi_prdtyp,
	isnull(icn_cusno,'') as 'icn_cusno',
	isnull(cbi_cussna,'') as 'cbi_cussna'
from	IMBASINF 
	left join IMCUSNO on (icn_itmno = ibi_itmno)
	left join CUBASINF on (cbi_cusno = icn_cusno)
where	ibi_itmno = @ibi_itmno
union
select	ibi_itmno, 
	replace(ibi_lnecde, '/', '_') as 'lnecde', 
	right(ibi_lnecde,3) as 'YrSn', 
	ibi_prdtyp,
	isnull(icn_cusno,'') as 'icn_cusno',
	isnull(cbi_cussna,'') as 'cbi_cussna'
from	IMBASINFH 
	left join IMCUSNO on (icn_itmno = ibi_itmno) -- Change to IMCUSNOH in future
	left join CUBASINF on (cbi_cusno = icn_cusno)
where	ibi_itmno = @ibi_itmno



GO
GRANT EXECUTE ON [dbo].[sp_list_IMBASINF_IMG00002] TO [ERPUSER] AS [dbo]
GO
