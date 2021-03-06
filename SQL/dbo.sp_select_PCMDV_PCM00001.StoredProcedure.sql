/****** Object:  StoredProcedure [dbo].[sp_select_PCMDV_PCM00001]    Script Date: 09/29/2017 15:29:09 ******/
DROP PROCEDURE [dbo].[sp_select_PCMDV_PCM00001]
GO
/****** Object:  StoredProcedure [dbo].[sp_select_PCMDV_PCM00001]    Script Date: 09/29/2017 15:29:10 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO


/*
=========================================================
Program ID	: sp_select_PCMDV_PCM00001
Description   	: Select Data form Profit Center Associated Design Vendor Table 
Programmer  	: Lester Wu
ALTER  Date   	: 26 Nov 2003
Last Modified  	: 
Table Read(s) 	: PCMDV
Table Write(s) 	:
=========================================================
 Modification History                                    
=========================================================
Date		Author		Description

=========================================================     
            sp_select_PCMDV_PCM00001   '','PC01'
*/
CREATE procedure [dbo].[sp_select_PCMDV_PCM00001]
@cocde varchar(6),
@pdv_pcno varchar(20)
AS
begin

select 	--'' as 'pdv_del',
 	pdv_pcno,
	pdv_vencde
	--vbi_vennam 'pdv_vennam',
	--pdv_creusr,
	--'' as 'pdv_status'
from	PCMDV
where pdv_pcno <> @pdv_pcno
order by pdv_pcno, pdv_vencde
end





GO
GRANT EXECUTE ON [dbo].[sp_select_PCMDV_PCM00001] TO [ERPUSER] AS [dbo]
GO
