/****** Object:  StoredProcedure [dbo].[sp_Physical_Delete_PKORDREC]    Script Date: 09/29/2017 15:29:09 ******/
DROP PROCEDURE [dbo].[sp_Physical_Delete_PKORDREC]
GO
/****** Object:  StoredProcedure [dbo].[sp_Physical_Delete_PKORDREC]    Script Date: 09/29/2017 15:29:10 ******/
SET ANSI_NULLS OFF
GO
SET QUOTED_IDENTIFIER OFF
GO








CREATE  procedure [dbo].[sp_Physical_Delete_PKORDREC]
                                                                                                                                                                                                                                                                 
@code nvarchar(10),
@ordno nvarchar(20),
@ordseq int , 
@recseq int



---------------------------------------------- 

 
AS
 

begin

	 
delete from PKORDREC
where por_ordno = @ordno
and por_ordseq = @ordseq 
and por_recseq = @recseq



end













GO
GRANT EXECUTE ON [dbo].[sp_Physical_Delete_PKORDREC] TO [ERPUSER] AS [dbo]
GO
