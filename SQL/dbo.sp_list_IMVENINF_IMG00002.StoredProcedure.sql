/****** Object:  StoredProcedure [dbo].[sp_list_IMVENINF_IMG00002]    Script Date: 09/29/2017 15:29:09 ******/
DROP PROCEDURE [dbo].[sp_list_IMVENINF_IMG00002]
GO
/****** Object:  StoredProcedure [dbo].[sp_list_IMVENINF_IMG00002]    Script Date: 09/29/2017 15:29:09 ******/
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

CREATE PROCEDURE [dbo].[sp_list_IMVENINF_IMG00002] 

@cocde nvarchar(8) = ' ',
@ivi_venitm nvarchar(20),
@usrid nvarchar(30)

AS

select	ibi_itmno, 
	replace(ibi_lnecde, '/', '_') as 'lnecde', 
	right(ibi_lnecde,3) as 'YrSn', 
	ibi_prdtyp,
	isnull(icn_cusno,'') as 'icn_cusno',
	isnull(cbi_cussna,'') as 'cbi_cussna'
from	IMVENINF 
	left join IMBASINF on (ivi_itmno = ibi_itmno) 
	left join IMCUSNO on (ivi_itmno = icn_itmno )
	left join CUBASINF on (cbi_cusno = icn_cusno)
where	ivi_venitm = @ivi_venitm
union
select	ibi_itmno, 
	replace(ibi_lnecde, '/', '_') as 'lnecde', 
	right(ibi_lnecde,3) as 'YrSn', 
	ibi_prdtyp,
	isnull(icn_cusno,'') as 'icn_cusno',
	isnull(cbi_cussna,'') as 'cbi_cussna'
from	IMVENINFH 
	left join IMBASINFH on (ivi_itmno = ibi_itmno) 
	left join IMCUSNO on (ivi_itmno = icn_itmno ) -- Change to IMCUSNOH in future
	left join CUBASINF on (cbi_cusno = icn_cusno)
where	ivi_venitm = @ivi_venitm



GO
GRANT EXECUTE ON [dbo].[sp_list_IMVENINF_IMG00002] TO [ERPUSER] AS [dbo]
GO
