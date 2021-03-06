/****** Object:  StoredProcedure [dbo].[sp_physical_delete_IMMOQMOA]    Script Date: 09/29/2017 15:29:09 ******/
DROP PROCEDURE [dbo].[sp_physical_delete_IMMOQMOA]
GO
/****** Object:  StoredProcedure [dbo].[sp_physical_delete_IMMOQMOA]    Script Date: 09/29/2017 15:29:10 ******/
SET ANSI_NULLS OFF
GO
SET QUOTED_IDENTIFIER OFF
GO


/*
=========================================================
Program ID	: 	sp_physical_delete_IMMOQMOA
Description   	: 	Delete Entry from MOQ/MOA
Programmer  	: 	David Yue
Date Created	:	2013-01-09
=========================================================
 Modification History                                   
=========================================================
2013-01-09	David Yue	SP Created
=========================================================     
*/

CREATE PROCEDURE [dbo].[sp_physical_delete_IMMOQMOA]   
  
@cocde		nvarchar(6),
@itmno		nvarchar(20),
@cus1no		nvarchar(10),
@cus2no		nvarchar(10),
@creusr		nvarchar(30)
  
AS  
  
delete from IMMOQMOA
where	imm_itmno = @itmno and
	imm_cus1no = @cus1no and
	imm_cus2no = @cus2no




GO
GRANT EXECUTE ON [dbo].[sp_physical_delete_IMMOQMOA] TO [ERPUSER] AS [dbo]
GO
