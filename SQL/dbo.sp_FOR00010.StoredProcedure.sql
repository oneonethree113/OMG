/****** Object:  StoredProcedure [dbo].[sp_FOR00010]    Script Date: 09/29/2017 15:29:09 ******/
DROP PROCEDURE [dbo].[sp_FOR00010]
GO
/****** Object:  StoredProcedure [dbo].[sp_FOR00010]    Script Date: 09/29/2017 15:29:09 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO



-- Checked by Allan Yuen at 28/07/2003

CREATE PROCEDURE [dbo].[sp_FOR00010]
as
select * from 	fyordhdr
order by foh_fyohdr







GO
GRANT EXECUTE ON [dbo].[sp_FOR00010] TO [ERPUSER] AS [dbo]
GO
