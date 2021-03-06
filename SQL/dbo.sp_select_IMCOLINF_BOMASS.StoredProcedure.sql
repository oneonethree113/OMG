/****** Object:  StoredProcedure [dbo].[sp_select_IMCOLINF_BOMASS]    Script Date: 09/29/2017 15:29:09 ******/
DROP PROCEDURE [dbo].[sp_select_IMCOLINF_BOMASS]
GO
/****** Object:  StoredProcedure [dbo].[sp_select_IMCOLINF_BOMASS]    Script Date: 09/29/2017 15:29:10 ******/
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
17 July 2003	Allan Yuen		For Merge Porject
*/

/************************************************************************
Author:		Kenny Chan
Date:		3th Oct, 2001
Description:	Select data From IMCOLINF
Parameter:	1. Company
		2. Item No.	
		3.Item Type
************************************************************************/
------------------------------------------------- 
CREATE procedure [dbo].[sp_select_IMCOLINF_BOMASS]
                                                                                                                                                                                                                                                                 
---------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------- 
@ibi_cocde nvarchar(6) ,
@ibi_itmno nvarchar(20),
@ibi_typ 	nvarchar(4)
---------------------------------------------- 
 
AS


begin
--icf_colcde,


 Select 
icf_cocde,
icf_itmno,
icf_vencol as 'icf_colcde',
ISNULL(ibi_engdsc,'N/A') AS 'ibi_engdsc',
ISNULL(vbi_vensna,'N/A') AS 'vbi_vensna',
icf_colseq,
icf_vencol,
icf_coldsc,
icf_typ,
icf_ucpcde,
icf_eancde,
icf_creusr,
icf_updusr,
icf_credat,
icf_upddat,
ibi_typ,
ibi_itmsts,
icf_timstp 
--------------------------------- 
 from IMBASINF, IMCOLINF,VNBASINF 
-- left join VNBASINF on  vbi_cocde = @ibi_cocde and  vbi_venno =  ibi_venno
 where                                                                                                                                                                                                                                                                 
---------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------- 
-- ibi_cocde = @ibi_cocde and
 ibi_itmno = @ibi_itmno and
-- ibi_typ = @ibi_typ and

-- icf_cocde = @ibi_cocde and 
 icf_itmno = ibi_itmno and

-- vbi_cocde = @ibi_cocde and 
 vbi_venno =  ibi_venno
 
-------------------------- 

order by icf_colseq                                                           
---------------------------------------------------------- 
end






GO
GRANT EXECUTE ON [dbo].[sp_select_IMCOLINF_BOMASS] TO [ERPUSER] AS [dbo]
GO
