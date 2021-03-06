/****** Object:  StoredProcedure [dbo].[sp_select_PCMAC_PCNO]    Script Date: 09/29/2017 15:29:09 ******/
DROP PROCEDURE [dbo].[sp_select_PCMAC_PCNO]
GO
/****** Object:  StoredProcedure [dbo].[sp_select_PCMAC_PCNO]    Script Date: 09/29/2017 15:29:10 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO

/*
=========================================================
Program ID	: sp_select_PCMAC_PCNO
Description   	: select Profit Center Account No 
Programmer  	: Marco Chan
Create Date   	: 19 Sept 2003
Last Modified  	: 
Table Read(s) 	: PCMAC
Table Write(s) 	:
=========================================================
 Modification History                                    
=========================================================
Date		Author		Description
               
=========================================================     
*/
CREATE PROCEDURE [dbo].[sp_select_PCMAC_PCNO] 
@cocde 		varchar(6),
@type 		varchar(20)
AS
begin

declare @pcno integer
select @pcno = substring(max(pma_pcno), 3, 8) from PCMAC  where pma_pcno like 'PC%'
if @pcno is null 
begin
	select @pcno = '0'
end
select @pcno + 1 'pma_pcno'

end


GO
GRANT EXECUTE ON [dbo].[sp_select_PCMAC_PCNO] TO [ERPUSER] AS [dbo]
GO
