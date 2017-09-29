/****** Object:  StoredProcedure [dbo].[sp_Physical_Delete_SHSMPINV]    Script Date: 09/29/2017 15:29:09 ******/
DROP PROCEDURE [dbo].[sp_Physical_Delete_SHSMPINV]
GO
/****** Object:  StoredProcedure [dbo].[sp_Physical_Delete_SHSMPINV]    Script Date: 09/29/2017 15:29:10 ******/
SET ANSI_NULLS OFF
GO
SET QUOTED_IDENTIFIER OFF
GO






------------------------------------------------- 
CREATE    procedure [dbo].[sp_Physical_Delete_SHSMPINV]
                                                                                                                                                                                                                                                                 
---------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------- 
@hsi_cocde  nvarchar(6),
@hsi_shpno nvarchar(20) ,
@hsi_sminvno nvarchar(20) 

----------------------------------------------  
AS

begin

Delete SHSMPINV
Where 
hsi_cocde =  @hsi_cocde and
hsi_shpno = @hsi_shpno  and 
hsi_sminvno =@hsi_sminvno 
---------------------------------------------------------- 
end











GO
GRANT EXECUTE ON [dbo].[sp_Physical_Delete_SHSMPINV] TO [ERPUSER] AS [dbo]
GO
