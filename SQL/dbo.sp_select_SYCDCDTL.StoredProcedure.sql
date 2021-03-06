/****** Object:  StoredProcedure [dbo].[sp_select_SYCDCDTL]    Script Date: 09/29/2017 15:29:08 ******/
DROP PROCEDURE [dbo].[sp_select_SYCDCDTL]
GO
/****** Object:  StoredProcedure [dbo].[sp_select_SYCDCDTL]    Script Date: 09/29/2017 15:29:10 ******/
SET ANSI_NULLS OFF
GO
SET QUOTED_IDENTIFIER OFF
GO



/************************************************************************
Author:		Frankie Cheung
Date:		28th November, 2008
Description:	Select data From SYCDCDTL

************************************************************************/

CREATE procedure [dbo].[sp_select_SYCDCDTL]                                                                                                                                                                                                                                                              

@idd_cocde	nvarchar(6),
@idd_year	nvarchar(4),
@idd_cdcde	nvarchar(6),
@idd_seq	nvarchar(6)                                               
 
AS

BEGIN

Select	idd_year,
	idd_cdcde,
 	idd_seq,
	idd_trmcde,	
	idd_cbm,	
	idd_nsteril,	
	idd_osteril,
	idd_hsteril,	
	idd_creusr,
	idd_updusr,	
	idd_credat,
	idd_upddat,
	cast(idd_timstp as int) as idd_timstp

 from	SYCDCDTL
 where	idd_year = @idd_year and
	idd_cdcde = @idd_cdcde and 
	idd_seq = @idd_seq        
                                                                                                                                                                                                                                                     	                          
END


GO
GRANT EXECUTE ON [dbo].[sp_select_SYCDCDTL] TO [ERPUSER] AS [dbo]
GO
