/****** Object:  StoredProcedure [dbo].[sp_update_fyprtfyo]    Script Date: 09/29/2017 15:29:08 ******/
DROP PROCEDURE [dbo].[sp_update_fyprtfyo]
GO
/****** Object:  StoredProcedure [dbo].[sp_update_fyprtfyo]    Script Date: 09/29/2017 15:29:10 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO



-- Checked by Allan Yuen at 28/07/2003

CREATE PROCEDURE [dbo].[sp_update_fyprtfyo] 
@ftycde	as	nvarchar(4),
@usrid	as	nvarchar(30)
AS

update	fyprtfyo
set	fpf_ordsts	= 'PR',
	fpf_upddat = getdate(),
	fpf_usrid = @usrid
where	fpf_ftycde=@ftycde and fpf_ordsts='NW'









GO
GRANT EXECUTE ON [dbo].[sp_update_fyprtfyo] TO [ERPUSER] AS [dbo]
GO
