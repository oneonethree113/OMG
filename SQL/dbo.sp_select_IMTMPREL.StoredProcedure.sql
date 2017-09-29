/****** Object:  StoredProcedure [dbo].[sp_select_IMTMPREL]    Script Date: 09/29/2017 15:29:09 ******/
DROP PROCEDURE [dbo].[sp_select_IMTMPREL]
GO
/****** Object:  StoredProcedure [dbo].[sp_select_IMTMPREL]    Script Date: 09/29/2017 15:29:10 ******/
SET ANSI_NULLS OFF
GO
SET QUOTED_IDENTIFIER OFF
GO


------------------------------------------------- 
CREATE procedure [dbo].[sp_select_IMTMPREL]
                                                                                                                                                                                                                                                                 
---------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------- 
@ibi_cocde nvarchar(6) ,
@ibi_itmno nvarchar(20) 
                                               
---------------------------------------------- 
 
AS
begin

select 
itr_itmno,
itr_tmpitm
from IMTMPREL (nolock)
where itr_itmno = @ibi_itmno or itr_tmpitm = @ibi_itmno






end



GO
GRANT EXECUTE ON [dbo].[sp_select_IMTMPREL] TO [ERPUSER] AS [dbo]
GO
