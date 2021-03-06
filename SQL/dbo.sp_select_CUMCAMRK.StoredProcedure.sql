/****** Object:  StoredProcedure [dbo].[sp_select_CUMCAMRK]    Script Date: 09/29/2017 15:29:09 ******/
DROP PROCEDURE [dbo].[sp_select_CUMCAMRK]
GO
/****** Object:  StoredProcedure [dbo].[sp_select_CUMCAMRK]    Script Date: 09/29/2017 15:29:10 ******/
SET ANSI_NULLS OFF
GO
SET QUOTED_IDENTIFIER OFF
GO




/*
=========================================================
Program ID	: sp_select_CUMCAMRK
Description   	: Select Data form CustomerCategory Markup Table 
Programmer  	: Lewis To
Create Date   	: 17 Jun 2003
Last Modified  	: 
Table Read(s) 	:CUMCAMRK
Table Write(s) 	:
=========================================================
 Modification History                                    
=========================================================
Date		Author		Description
               
=========================================================     
*/

Create Procedure [dbo].[sp_select_CUMCAMRK]

@running_cocde varchar(6),
@ccm_cusno varchar(6)

AS
begin
select 	'' as 'ccm_del',
	ccm_cusno,
	case  ccm_ventyp when 'I' then 'INT'  
		          when  'E' then 'EXT' 
		          when  'J' then 'JV' end as 'ccm_ventyp',
	ccm_cat,
	ccm_markup,
 	ccm_markup + ' - ' + yfi_fml as 'ccm_markupfml',
	ccm_effdat,
	ccm_creusr
from CUMCAMRK
left join 	SYFMLINF on yfi_cocde = ' ' and ccm_markup = yfi_fmlopt
where ccm_cusno = @ccm_cusno
order by ccm_ventyp, ccm_cat
end





GO
GRANT EXECUTE ON [dbo].[sp_select_CUMCAMRK] TO [ERPUSER] AS [dbo]
GO
