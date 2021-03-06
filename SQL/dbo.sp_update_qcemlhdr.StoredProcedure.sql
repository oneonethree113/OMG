/****** Object:  StoredProcedure [dbo].[sp_update_qcemlhdr]    Script Date: 09/29/2017 15:29:08 ******/
DROP PROCEDURE [dbo].[sp_update_qcemlhdr]
GO
/****** Object:  StoredProcedure [dbo].[sp_update_qcemlhdr]    Script Date: 09/29/2017 15:29:10 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE    PROCEDURE [dbo].[sp_update_qcemlhdr] 
@rptno nvarchar(30),
@seq int

AS

BEGIN
	update QCEMLHDR
	set qeh_mailflg  ='N',
		qeh_upddat = getdate()
		where  qeh_mailflg  =  'Y'
			and qeh_tmprptno = @rptno 
		--	and qeh_seq =@seq 

END



GO
GRANT EXECUTE ON [dbo].[sp_update_qcemlhdr] TO [ERPUSER] AS [dbo]
GO
