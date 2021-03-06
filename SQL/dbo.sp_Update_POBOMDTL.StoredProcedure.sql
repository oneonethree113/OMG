/****** Object:  StoredProcedure [dbo].[sp_Update_POBOMDTL]    Script Date: 09/29/2017 15:29:08 ******/
DROP PROCEDURE [dbo].[sp_Update_POBOMDTL]
GO
/****** Object:  StoredProcedure [dbo].[sp_Update_POBOMDTL]    Script Date: 09/29/2017 15:29:10 ******/
SET ANSI_NULLS OFF
GO
SET QUOTED_IDENTIFIER OFF
GO




-- Checked by Allan Yuen at 27/07/2003



/************************************************************************
Author:		Wong Hong
Date:		4th dec, 2002
Description:	Update data From POBOMDTL
Parameter:	1. Company
		2. PO No.	
************************************************************************/
------------------------------------------------- 
CREATE procedure [dbo].[sp_Update_POBOMDTL]
                                                                                                                                                                                                                                                                 
---------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------- 
@pbd_cocde  nvarchar(6), 	@pbd_bompo  nvarchar(20),
@pbd_bomseq int, 		@pbd_rvenitm nvarchar(20),
@pbd_adjqty  int, 			@pbd_negprc  numeric(7,4),
@pbd_candat  datetime,		@pbd_shpstr  datetime,		
@pbd_shpend  datetime,		@pbd_updusr nvarchar(30)
---------------------------------------------- 
 
AS
begin
Update POBOMDTL SET
pbd_rvenitm=@pbd_rvenitm,
pbd_adjqty=@pbd_adjqty,
pbd_negprc=@pbd_negprc,
pbd_candat=@pbd_candat,
pbd_shpstr=@pbd_shpstr,
pbd_shpend=@pbd_shpend,
pbd_updusr=@pbd_updusr,
pbd_upddat=GETDATE()
--------------------------------- 
Where                                                                                                                                                                                                                           
---------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------- 
pbd_cocde = @pbd_cocde and
pbd_bompo = @pbd_bompo and
pbd_bomseq = @pbd_bomseq                                                                
---------------------------------------------------------- 


end






GO
GRANT EXECUTE ON [dbo].[sp_Update_POBOMDTL] TO [ERPUSER] AS [dbo]
GO
