/****** Object:  StoredProcedure [dbo].[sp_select_QUM00003]    Script Date: 09/29/2017 15:29:09 ******/
DROP PROCEDURE [dbo].[sp_select_QUM00003]
GO
/****** Object:  StoredProcedure [dbo].[sp_select_QUM00003]    Script Date: 09/29/2017 15:29:10 ******/
SET ANSI_NULLS OFF
GO
SET QUOTED_IDENTIFIER OFF
GO




--Samuel Chan 
--Description : For Upload information to PDA
------------------------------------------------- 

CREATE procedure [dbo].[sp_select_QUM00003]
                                                                                                                                                                                                                                                                 
---------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------- 
@qud_cocde nvarchar(6) 

---------------------------------------------- 
 
AS


begin
Select  *  from QUOTD
where 
qud_cocde = @qud_cocde
end




GO
GRANT EXECUTE ON [dbo].[sp_select_QUM00003] TO [ERPUSER] AS [dbo]
GO
