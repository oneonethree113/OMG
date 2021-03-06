/****** Object:  StoredProcedure [dbo].[sp_update_BJEXELOG]    Script Date: 09/29/2017 15:29:08 ******/
DROP PROCEDURE [dbo].[sp_update_BJEXELOG]
GO
/****** Object:  StoredProcedure [dbo].[sp_update_BJEXELOG]    Script Date: 09/29/2017 15:29:10 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

------------------------------------------------------------------------------------- 
Create  procedure [dbo].[sp_update_BJEXELOG]                                                                                                                                                                                                                                                                
---------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------- 
     @bel_jobsumid nvarchar(20) ,
     @bel_pgid nvarchar(20),
     @bel_pgname varchar(100),
     @bel_pglog varchar(MAX),
     @bel_remarks nvarchar(300),
      @gsusr   nvarchar (30) 
------------------------------------ 
AS

update  BJEXELOG
set
     bel_pgname =  @bel_pgname ,
     bel_pglog =@bel_pglog,
     bel_remarks=@bel_remarks,
        bel_creusr =   'misbj',
        bel_updusr =  'misbj' ,
        bel_upddat =getdate()
where 		     bel_jobsumid  =@bel_jobsumid  
				and bel_pgid  =@bel_pgid 
---------------------------------------------------------------------------------------------------------------------------------------------------------------------
---------- 


GO
GRANT EXECUTE ON [dbo].[sp_update_BJEXELOG] TO [ERPUSER] AS [dbo]
GO
