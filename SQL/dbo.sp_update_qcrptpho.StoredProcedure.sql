/****** Object:  StoredProcedure [dbo].[sp_update_qcrptpho]    Script Date: 09/29/2017 15:29:08 ******/
DROP PROCEDURE [dbo].[sp_update_qcrptpho]
GO
/****** Object:  StoredProcedure [dbo].[sp_update_qcrptpho]    Script Date: 09/29/2017 15:29:10 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO



create  PROCEDURE [dbo].[sp_update_qcrptpho] 
@TmpRPTNo as nvarchar(30)
AS BEGIN
	
	update  qcrptpho 
	set qrp_flg = 'Y'
	where  qrp_tmprptno = @TmpRPTNo 


END




GO
GRANT EXECUTE ON [dbo].[sp_update_qcrptpho] TO [ERPUSER] AS [dbo]
GO
