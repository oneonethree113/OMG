/****** Object:  StoredProcedure [dbo].[sp_insert_PKREPORD]    Script Date: 09/29/2017 15:29:09 ******/
DROP PROCEDURE [dbo].[sp_insert_PKREPORD]
GO
/****** Object:  StoredProcedure [dbo].[sp_insert_PKREPORD]    Script Date: 09/29/2017 15:29:09 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO



CREATE PROCEDURE [dbo].[sp_insert_PKREPORD] 
--------------------------------------------------------------------------------------------------------------------------------------

@pro_cocde nvarchar(20),
@pro_ordno nvarchar(20),
@pro_repord nvarchar(20),
@user nvarchar(30)
--------------------------------------------------------------------------------------------------------------------------------------
AS

begin

insert into  PKREPORD values 
(@pro_cocde,
@pro_ordno,
@pro_repord,
@user,
@user,
getdate(),
getdate(),
null)

end




GO
GRANT EXECUTE ON [dbo].[sp_insert_PKREPORD] TO [ERPUSER] AS [dbo]
GO
