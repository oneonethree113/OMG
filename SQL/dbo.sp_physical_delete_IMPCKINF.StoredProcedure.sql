/****** Object:  StoredProcedure [dbo].[sp_physical_delete_IMPCKINF]    Script Date: 09/29/2017 15:29:09 ******/
DROP PROCEDURE [dbo].[sp_physical_delete_IMPCKINF]
GO
/****** Object:  StoredProcedure [dbo].[sp_physical_delete_IMPCKINF]    Script Date: 09/29/2017 15:29:10 ******/
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

/************************************************************************
Author:		Kenny Chan
Date:		15th September, 2001
************************************************************************/

CREATE PROCEDURE [dbo].[sp_physical_delete_IMPCKINF] 

@ipi_cocde	 nvarchar(6),
@ipi_itmno 	nvarchar(20),
@ipi_pckseq	int



AS


delete from IMPCKINF
where 
--	ipi_cocde = @ipi_cocde and
 	ipi_itmno = @ipi_itmno
and 	ipi_pckseq = @ipi_pckseq









GO
GRANT EXECUTE ON [dbo].[sp_physical_delete_IMPCKINF] TO [ERPUSER] AS [dbo]
GO
