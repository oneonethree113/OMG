/****** Object:  StoredProcedure [dbo].[sp_select_SAREQDTL_created]    Script Date: 09/29/2017 15:29:09 ******/
DROP PROCEDURE [dbo].[sp_select_SAREQDTL_created]
GO
/****** Object:  StoredProcedure [dbo].[sp_select_SAREQDTL_created]    Script Date: 09/29/2017 15:29:10 ******/
SET ANSI_NULLS OFF
GO
SET QUOTED_IDENTIFIER ON
GO



-- Checked by Allan Yuen at 30/07/2003

CREATE PROCEDURE [dbo].[sp_select_SAREQDTL_created] 

@srd_cocde 	nvarchar(6),
@srd_qutno 	nvarchar(20)

AS

select distinct srd_reqno, srh_credat 
from SAREQDTL, SAREQHDR 
where
srd_cocde = @srd_cocde and
srd_cocde = srh_cocde and 
srd_reqno = srh_reqno and
srd_qutno = @srd_qutno



GO
GRANT EXECUTE ON [dbo].[sp_select_SAREQDTL_created] TO [ERPUSER] AS [dbo]
GO
