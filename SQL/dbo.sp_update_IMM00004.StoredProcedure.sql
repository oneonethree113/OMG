/****** Object:  StoredProcedure [dbo].[sp_update_IMM00004]    Script Date: 09/29/2017 15:29:08 ******/
DROP PROCEDURE [dbo].[sp_update_IMM00004]
GO
/****** Object:  StoredProcedure [dbo].[sp_update_IMM00004]    Script Date: 09/29/2017 15:29:10 ******/
SET ANSI_NULLS OFF
GO
SET QUOTED_IDENTIFIER OFF
GO









/*=========================================================
Program ID	: 	sp_update_IMM00004
Description   	: 	update item status from hold --> complete / not hold --> hold
Programmer  	: 	Lester Wu
ALTER  Date   	: 
Last Modified  	: 	2004/06/02
Table Read(s) 	:
Table Write(s) 	:
=========================================================
 Modification History                                    
=========================================================
Date		Author		Description
2005-04-23	Allan Yuen	Add update ibi_prvsts field 
=========================================================
*/


CREATE procedure [dbo].[sp_update_IMM00004]
@cocde nvarchar(6),
@itmno nvarchar(20),
@itmsts nvarchar(3),
@updusr nvarchar(30)

as


UPDATE 
	IMBASINF 
SET
	
	IBI_ITMSTS = @itmsts,
	ibi_prvsts = @itmsts,
	IBI_UPDUSR = @updusr,
	IBI_UPDDAT = getdate()
where ibi_itmno = @itmno






GO
GRANT EXECUTE ON [dbo].[sp_update_IMM00004] TO [ERPUSER] AS [dbo]
GO
