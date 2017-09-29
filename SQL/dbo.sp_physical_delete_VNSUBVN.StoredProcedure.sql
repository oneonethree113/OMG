/****** Object:  StoredProcedure [dbo].[sp_physical_delete_VNSUBVN]    Script Date: 09/29/2017 15:29:09 ******/
DROP PROCEDURE [dbo].[sp_physical_delete_VNSUBVN]
GO
/****** Object:  StoredProcedure [dbo].[sp_physical_delete_VNSUBVN]    Script Date: 09/29/2017 15:29:10 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO









CREATE procedure [dbo].[sp_physical_delete_VNSUBVN]
                                                                                                                                                                                                                                                               
@vsv_cocde nvarchar(6),
@vsv_ven1cde nvarchar(6),
@vsv_ven2cde nvarchar(6),
@usrid nvarchar(30)
AS


if (select count(*) from VNSUBVN where vsv_ven1cde = @vsv_ven1cde and vsv_ven2cde = @vsv_ven2cde) >= 1
begin
delete from VNSUBVN where vsv_ven1cde = @vsv_ven1cde and vsv_ven2cde = @vsv_ven2cde

update VNBASINF set vbi_updusr = 'L-' + @usrid, vbi_upddat = getdate() where vbi_venno = @vsv_ven1cde

end






GO
GRANT EXECUTE ON [dbo].[sp_physical_delete_VNSUBVN] TO [ERPUSER] AS [dbo]
GO
