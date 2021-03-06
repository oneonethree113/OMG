/****** Object:  StoredProcedure [dbo].[sp_Spring_CUMCOVEN_PDA]    Script Date: 09/29/2017 15:29:08 ******/
DROP PROCEDURE [dbo].[sp_Spring_CUMCOVEN_PDA]
GO
/****** Object:  StoredProcedure [dbo].[sp_Spring_CUMCOVEN_PDA]    Script Date: 09/29/2017 15:29:10 ******/
SET ANSI_NULLS OFF
GO
SET QUOTED_IDENTIFIER OFF
GO




/*
=========================================================
Description   	: sp_Spring_CUMCOVEN_PDA
Programmer  	: PIC
Create Date   	: 2002-07-30
Last Modified  	: 2003-07-22
Table Read(s) 	:
Table Write(s) 	:
=========================================================
 Modification History                                    
=========================================================
 Date      Initial  	Description                          
=========================================================    */ 
CREATE procedure [dbo].[sp_Spring_CUMCOVEN_PDA]

as


select 	
	ccv_cocde,
	ccv_cusno,
	ccv_ventyp,
	ccv_vendef
from 
	CUMCOVEN (nolock)
where 
	left(ccv_cusno,1) >'4'

GO
GRANT EXECUTE ON [dbo].[sp_Spring_CUMCOVEN_PDA] TO [ERPUSER] AS [dbo]
GO
