/****** Object:  StoredProcedure [dbo].[sp_COR00002_N]    Script Date: 09/29/2017 15:29:09 ******/
DROP PROCEDURE [dbo].[sp_COR00002_N]
GO
/****** Object:  StoredProcedure [dbo].[sp_COR00002_N]    Script Date: 09/29/2017 15:29:09 ******/
SET ANSI_NULLS OFF
GO
SET QUOTED_IDENTIFIER OFF
GO




/*	Author : Tommy Ho	*/

CREATE PROCEDURE [dbo].[sp_COR00002_N]

@SQL 	nvarchar(3500)

AS	


exec (@sql)




GO
GRANT EXECUTE ON [dbo].[sp_COR00002_N] TO [ERPUSER] AS [dbo]
GO
