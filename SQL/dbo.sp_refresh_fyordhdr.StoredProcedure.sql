/****** Object:  StoredProcedure [dbo].[sp_refresh_fyordhdr]    Script Date: 09/29/2017 15:29:09 ******/
DROP PROCEDURE [dbo].[sp_refresh_fyordhdr]
GO
/****** Object:  StoredProcedure [dbo].[sp_refresh_fyordhdr]    Script Date: 09/29/2017 15:29:10 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO



-- Checked by Allan Yuen at 28/07/2003

CREATE PROCEDURE [dbo].[sp_refresh_fyordhdr] AS
update  fyordhdr
set 
foh_ftyitm = (select intcoc01 from intcoc where intcoc11 = foh_fyohdr),
foh_ordqty = (select intcoc07 from intcoc where intcoc11 = foh_fyohdr)
where foh_ftyitm is null






GO
GRANT EXECUTE ON [dbo].[sp_refresh_fyordhdr] TO [ERPUSER] AS [dbo]
GO
