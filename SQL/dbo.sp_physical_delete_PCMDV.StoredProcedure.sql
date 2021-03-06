/****** Object:  StoredProcedure [dbo].[sp_physical_delete_PCMDV]    Script Date: 09/29/2017 15:29:09 ******/
DROP PROCEDURE [dbo].[sp_physical_delete_PCMDV]
GO
/****** Object:  StoredProcedure [dbo].[sp_physical_delete_PCMDV]    Script Date: 09/29/2017 15:29:10 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO

/*
=========================================================
Program ID	: sp_physical_delete_PCMDV
Description   	: Delete Data for Profit Center Associated Design Vendor table 
Programmer  	: Marco Chan
Create Date   	: 19 Sept 2003
Last Modified  	: 
Table Read(s) 	: PCMDV
Table Write(s) 	:
=========================================================
 Modification History                                    
=========================================================
Date		Author		Description
               
=========================================================     
*/
CREATE PROCEDURE [dbo].[sp_physical_delete_PCMDV] 
@cocde 		varchar(6),
@pdv_pcno 	varchar(20),
@pdv_vencde 	varchar(10)
AS
begin

delete from PCMDV 
where
	pdv_pcno = @pdv_pcno and
	pdv_vencde = @pdv_vencde
end



GO
GRANT EXECUTE ON [dbo].[sp_physical_delete_PCMDV] TO [ERPUSER] AS [dbo]
GO
