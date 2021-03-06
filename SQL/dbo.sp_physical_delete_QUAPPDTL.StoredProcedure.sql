/****** Object:  StoredProcedure [dbo].[sp_physical_delete_QUAPPDTL]    Script Date: 09/29/2017 15:29:09 ******/
DROP PROCEDURE [dbo].[sp_physical_delete_QUAPPDTL]
GO
/****** Object:  StoredProcedure [dbo].[sp_physical_delete_QUAPPDTL]    Script Date: 09/29/2017 15:29:10 ******/
SET ANSI_NULLS OFF
GO
SET QUOTED_IDENTIFIER OFF
GO










/*
=========================================================
Description   	: [sp_physical_delete_QUAPPDTL]
Table Write(s) 	: QUAPPDTL
=========================================================
 Modification History                                    
=========================================================
 Date      Initial  	Description          
=========================================================     
*/

CREATE      PROCEDURE [dbo].[sp_physical_delete_QUAPPDTL] 
@qxd_cocde nvarchar(10),
@qxd_tmpqutno nvarchar(50) ,
@qxd_tmpqutseq INT,
@qxd_type nvarchar(10)

as

if @qxd_type = 'ALL'
begin

delete from QUAPPDTL
where qxd_tmpqutno = @qxd_tmpqutno 

end
else
begin

delete from QUAPPDTL
where qxd_tmpqutno = @qxd_tmpqutno and qxd_tmpqutseq = @qxd_tmpqutseq

end







GO
GRANT EXECUTE ON [dbo].[sp_physical_delete_QUAPPDTL] TO [ERPUSER] AS [dbo]
GO
