/****** Object:  StoredProcedure [dbo].[sp_test_test]    Script Date: 09/29/2017 15:29:08 ******/
DROP PROCEDURE [dbo].[sp_test_test]
GO
/****** Object:  StoredProcedure [dbo].[sp_test_test]    Script Date: 09/29/2017 15:29:10 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE procedure [dbo].[sp_test_test] 
@abc int
as
begin

declare @sql varchar(100)

set @sql = 'select count(*) from CUBASINF'

--exec(@sql)
select count(*) from CUBASINF

end



GO
