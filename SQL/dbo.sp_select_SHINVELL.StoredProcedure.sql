/****** Object:  StoredProcedure [dbo].[sp_select_SHINVELL]    Script Date: 09/29/2017 15:29:09 ******/
DROP PROCEDURE [dbo].[sp_select_SHINVELL]
GO
/****** Object:  StoredProcedure [dbo].[sp_select_SHINVELL]    Script Date: 09/29/2017 15:29:10 ******/
SET ANSI_NULLS OFF
GO
SET QUOTED_IDENTIFIER ON
GO


CREATE PROCEDURE [dbo].[sp_select_SHINVELL]

@cocde as nvarchar(10),
@invno as nvarchar(30)

 AS

select 

hie_oriinv

from shinvell

where 
hie_cocde = @cocde and
hie_invno = @invno


GO
GRANT EXECUTE ON [dbo].[sp_select_SHINVELL] TO [ERPUSER] AS [dbo]
GO
