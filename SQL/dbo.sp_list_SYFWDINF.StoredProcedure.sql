/****** Object:  StoredProcedure [dbo].[sp_list_SYFWDINF]    Script Date: 09/29/2017 15:29:09 ******/
DROP PROCEDURE [dbo].[sp_list_SYFWDINF]
GO
/****** Object:  StoredProcedure [dbo].[sp_list_SYFWDINF]    Script Date: 09/29/2017 15:29:10 ******/
SET ANSI_NULLS OFF
GO
SET QUOTED_IDENTIFIER ON
GO






-- Checked by Allan Yuen at 28/07/2003

/*
=========================================================
Program ID	: 
Description   	: 
Programmer  	: 
ALTER  Date   	: 
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

--Samuel

CREATE PROCEDURE [dbo].[sp_list_SYFWDINF] 

@yfi_cocde 	nvarchar(6) = ' '
AS

Select * from SYFWDINF
--where yfi_cocde = @yfi_cocde
where yfi_cocde = ' '
order by yfi_FWDcde










GO
GRANT EXECUTE ON [dbo].[sp_list_SYFWDINF] TO [ERPUSER] AS [dbo]
GO
