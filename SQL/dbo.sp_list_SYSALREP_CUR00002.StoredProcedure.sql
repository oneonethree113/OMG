/****** Object:  StoredProcedure [dbo].[sp_list_SYSALREP_CUR00002]    Script Date: 09/29/2017 15:29:09 ******/
DROP PROCEDURE [dbo].[sp_list_SYSALREP_CUR00002]
GO
/****** Object:  StoredProcedure [dbo].[sp_list_SYSALREP_CUR00002]    Script Date: 09/29/2017 15:29:10 ******/
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
Last Modified  	: 15 July 2003
Table Read(s) 	:
Table Write(s) 	:
=========================================================
 Modification History                                    
=========================================================
Date		Author		Description
=========================================================     
20030715	Allan Yuen		For Merge Porject
*/

CREATE PROCEDURE [dbo].[sp_list_SYSALREP_CUR00002] 

@cocde nvarchar(8) = ' ',
@usrid nvarchar(30)

AS

select distinct ysr_saltem

from sysalrep

--where ysr_cocde = @cocde
where ysr_cocde = ' '

order by ysr_saltem






GO
GRANT EXECUTE ON [dbo].[sp_list_SYSALREP_CUR00002] TO [ERPUSER] AS [dbo]
GO
