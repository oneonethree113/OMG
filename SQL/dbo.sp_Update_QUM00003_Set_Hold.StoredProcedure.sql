/****** Object:  StoredProcedure [dbo].[sp_Update_QUM00003_Set_Hold]    Script Date: 09/29/2017 15:29:08 ******/
DROP PROCEDURE [dbo].[sp_Update_QUM00003_Set_Hold]
GO
/****** Object:  StoredProcedure [dbo].[sp_Update_QUM00003_Set_Hold]    Script Date: 09/29/2017 15:29:10 ******/
SET ANSI_NULLS OFF
GO
SET QUOTED_IDENTIFIER OFF
GO


CREATE procedure [dbo].[sp_Update_QUM00003_Set_Hold]
                                                                                                                                                                                                                                                                 
---------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------- 
@quh_cocde nvarchar(6) ,
@quh_qutno nvarchar(20) 
---------------------------------------------- 
 
AS


begin
update quotnhdr
set quh_qutsts = 'H' where quh_qutno = @quh_qutno
end


GO
GRANT EXECUTE ON [dbo].[sp_Update_QUM00003_Set_Hold] TO [ERPUSER] AS [dbo]
GO
