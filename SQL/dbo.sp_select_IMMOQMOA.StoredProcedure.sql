/****** Object:  StoredProcedure [dbo].[sp_select_IMMOQMOA]    Script Date: 09/29/2017 15:29:09 ******/
DROP PROCEDURE [dbo].[sp_select_IMMOQMOA]
GO
/****** Object:  StoredProcedure [dbo].[sp_select_IMMOQMOA]    Script Date: 09/29/2017 15:29:10 ******/
SET ANSI_NULLS OFF
GO
SET QUOTED_IDENTIFIER OFF
GO


/*
=========================================================
Program ID	: 	sp_select_IMMOQMOA
Description   	: 	Display MOQ/MOA
Programmer  	: 	David Yue
Date Created	:	2012-12-28
=========================================================
 Modification History                                   
=========================================================
2012-12-28	David Yue	SP Created
=========================================================     
*/

CREATE PROCEDURE [dbo].[sp_select_IMMOQMOA]   
  
@cocde nvarchar(6),
@itmno nvarchar(20)
  
AS  
  
select	' ' as 'imm_status',
	imm_itmno,
	imm_cus1no,
	imm_cus2no,
	case imm_tirtyp when 1 then 'Standard Tier' when 2 then 'Company Defined' end as 'imm_tirtyp',
	case imm_tirtyp when 1 then '' else case len(imm_moqunttyp) when 0 then 'MOA' else 'MOQ' end end as 'imm_moqmoa',
	imm_moqunttyp,
	imm_moqctn,
	imm_curcde,
	imm_moa,
	imm_creusr
from	IMMOQMOA
where	imm_itmno = @itmno




GO
GRANT EXECUTE ON [dbo].[sp_select_IMMOQMOA] TO [ERPUSER] AS [dbo]
GO
