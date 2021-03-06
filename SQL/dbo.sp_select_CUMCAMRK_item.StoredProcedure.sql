/****** Object:  StoredProcedure [dbo].[sp_select_CUMCAMRK_item]    Script Date: 09/29/2017 15:29:09 ******/
DROP PROCEDURE [dbo].[sp_select_CUMCAMRK_item]
GO
/****** Object:  StoredProcedure [dbo].[sp_select_CUMCAMRK_item]    Script Date: 09/29/2017 15:29:10 ******/
SET ANSI_NULLS OFF
GO
SET QUOTED_IDENTIFIER OFF
GO




/*
=========================================================
Program ID	: sp_select_CUMCAMRK_item
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

Create Procedure [dbo].[sp_select_CUMCAMRK_item]

@running_cocde varchar(6),
@ccm_cusno varchar(6),
@ccm_itmno varchar(20)

AS
begin
select 	ccm_cusno,
	ccm_ventyp, 
	ccm_cat,
	ccm_markup,
	yfi_fml,
	ccm_effdat,
	ccm_creusr
from CUMCAMRK
left join syfmlinf on ccm_markup = yfi_fmlopt
, imbasinf, vnbasinf

where ccm_cusno = @ccm_cusno and 
	 (ibi_itmno = @ccm_itmno or ibi_alsitmno = @ccm_itmno) and
	ibi_catlvl3 = ccm_cat and
	 ibi_venno = vbi_venno and
	vbi_ventyp = ccm_ventyp --and
	--ccm_effdat < getdate()
union
select 	ccm_cusno,
	ccm_ventyp, 
	ccm_cat,
	ccm_markup,
	yfi_fml,
	ccm_effdat,
	ccm_creusr
from CUMCAMRK
left join syfmlinf on ccm_markup = yfi_fmlopt
, imbasinf, vnbasinf

where ccm_cusno = @ccm_cusno and 
	 (ibi_itmno = @ccm_itmno or ibi_alsitmno = @ccm_itmno) and
	ccm_cat = 'STANDARD' and
	 ibi_venno = vbi_venno and
	vbi_ventyp = ccm_ventyp --and
	--ccm_effdat < getdate()
	

end





GO
GRANT EXECUTE ON [dbo].[sp_select_CUMCAMRK_item] TO [ERPUSER] AS [dbo]
GO
