/****** Object:  StoredProcedure [dbo].[sp_list_CUBASINF_SHM00001_1]    Script Date: 09/29/2017 15:29:09 ******/
DROP PROCEDURE [dbo].[sp_list_CUBASINF_SHM00001_1]
GO
/****** Object:  StoredProcedure [dbo].[sp_list_CUBASINF_SHM00001_1]    Script Date: 09/29/2017 15:29:09 ******/
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
Last Modified  	: 
Table Read(s) 	:
Table Write(s) 	:
Parameter:	
=========================================================
 Modification History                                    
=========================================================
 Date      	Initial  	Description          
2003-08-20	Allan Yuen	Fix Deadlock error.               
2003-12-29	Marco Chan	Fix for secondary customer problem
=========================================================     
*/

CREATE PROCEDURE [dbo].[sp_list_CUBASINF_SHM00001_1]

@cbi_cocde as nvarchar(6),
@cbi_custyp as nvarchar(1)


as

SELECT         
	*
FROM          
	CUBASINF (nolock)
	inner join CUSUBCUS (nolock) on 
		--cbi_cocde = csc_cocde and 
		cbi_cusno = csc_seccus
WHERE
--	(cbi_cocde = @cbi_cocde) AND 
	(cbi_custyp = @cbi_custyp) AND 
	cbi_cussts  =  'A'
order by 
	cbi_cusno









GO
GRANT EXECUTE ON [dbo].[sp_list_CUBASINF_SHM00001_1] TO [ERPUSER] AS [dbo]
GO
