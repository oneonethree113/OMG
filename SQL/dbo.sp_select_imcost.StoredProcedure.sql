/****** Object:  StoredProcedure [dbo].[sp_select_imcost]    Script Date: 09/29/2017 15:29:09 ******/
DROP PROCEDURE [dbo].[sp_select_imcost]
GO
/****** Object:  StoredProcedure [dbo].[sp_select_imcost]    Script Date: 09/29/2017 15:29:10 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO




CREATE PROCEDURE [dbo].[sp_select_imcost]

@itmno nvarchar(20)

AS

select * from IMCOST where ics_itmno = @itmno





GO
GRANT EXECUTE ON [dbo].[sp_select_imcost] TO [ERPUSER] AS [dbo]
GO
