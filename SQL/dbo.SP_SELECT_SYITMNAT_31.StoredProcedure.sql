/****** Object:  StoredProcedure [dbo].[SP_SELECT_SYITMNAT_31]    Script Date: 09/29/2017 15:29:08 ******/
DROP PROCEDURE [dbo].[SP_SELECT_SYITMNAT_31]
GO
/****** Object:  StoredProcedure [dbo].[SP_SELECT_SYITMNAT_31]    Script Date: 09/29/2017 15:29:10 ******/
SET ANSI_NULLS OFF
GO
SET QUOTED_IDENTIFIER OFF
GO








CREATE PROCEDURE [dbo].[SP_SELECT_SYITMNAT_31] 
@cocde as nvarchar(6)

AS

BEGIN

select ysi_cde + ' - ' + ysi_dsc as 'itmnat' from sysetinf where ysi_typ = '31'
order by ysi_cde asc
END






GO
GRANT EXECUTE ON [dbo].[SP_SELECT_SYITMNAT_31] TO [ERPUSER] AS [dbo]
GO
