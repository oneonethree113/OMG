/****** Object:  StoredProcedure [dbo].[sp_list_IMBOMASS_ASS]    Script Date: 09/29/2017 15:29:09 ******/
DROP PROCEDURE [dbo].[sp_list_IMBOMASS_ASS]
GO
/****** Object:  StoredProcedure [dbo].[sp_list_IMBOMASS_ASS]    Script Date: 09/29/2017 15:29:09 ******/
SET ANSI_NULLS OFF
GO
SET QUOTED_IDENTIFIER OFF
GO





-- Checked by Allan Yuen at 28/07/2003

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
17 July 2003	Allan Yuen		For Merge Porject
*/


CREATE PROCEDURE [dbo].[sp_list_IMBOMASS_ASS] 

@iba_cocde	nvarchar(6),
@iba_itmno 	nvarchar(20),
@iba_usrid	nvarchar(30),
@typ		nvarchar(10)

AS

Select 
distinct iba_itmno	,	iba_assitm
from IMBOMASS
left join IMBASINF on 
	ibi_itmno = iba_assitm and 
	--ibi_cocde = iba_cocde and 
	-- Lester Wu 2006-09-17
	--(@typ = 'ACT' and ibi_itmsts <> 'CMP' and ibi_itmsts  <> 'INC' and ibi_itmsts <> 'HLD')
	(@typ = 'ACT' and ibi_itmsts <> 'CMP' and ibi_itmsts  <> 'INC' and ibi_itmsts <> 'HLD' and ibi_itmsts <> 'OLD')
where 	
	--iba_cocde = @iba_cocde and
	iba_itmno = @iba_itmno and
	ibi_itmno is not null








GO
GRANT EXECUTE ON [dbo].[sp_list_IMBOMASS_ASS] TO [ERPUSER] AS [dbo]
GO
