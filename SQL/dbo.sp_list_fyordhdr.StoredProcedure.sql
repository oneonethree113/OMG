/****** Object:  StoredProcedure [dbo].[sp_list_fyordhdr]    Script Date: 09/29/2017 15:29:09 ******/
DROP PROCEDURE [dbo].[sp_list_fyordhdr]
GO
/****** Object:  StoredProcedure [dbo].[sp_list_fyordhdr]    Script Date: 09/29/2017 15:29:09 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO



-- Checked by Allan Yuen at 28/07/2003

CREATE PROCEDURE [dbo].[sp_list_fyordhdr] AS
select * from fyordhdr order by foh_fyohdr desc






GO
GRANT EXECUTE ON [dbo].[sp_list_fyordhdr] TO [ERPUSER] AS [dbo]
GO
