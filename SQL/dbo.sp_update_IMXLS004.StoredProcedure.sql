/****** Object:  StoredProcedure [dbo].[sp_update_IMXLS004]    Script Date: 09/29/2017 15:29:08 ******/
DROP PROCEDURE [dbo].[sp_update_IMXLS004]
GO
/****** Object:  StoredProcedure [dbo].[sp_update_IMXLS004]    Script Date: 09/29/2017 15:29:10 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO



create procedure [dbo].[sp_update_IMXLS004]
@cocde	varchar(6) , 
@UsrId	varchar(30)
AS
BEGIN
	Update IMCUSALS
	set ica_flg = 'O'
	where 
	ica_creusr = @UsrId
End




GO
GRANT EXECUTE ON [dbo].[sp_update_IMXLS004] TO [ERPUSER] AS [dbo]
GO
