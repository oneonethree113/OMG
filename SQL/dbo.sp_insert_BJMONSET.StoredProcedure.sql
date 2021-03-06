/****** Object:  StoredProcedure [dbo].[sp_insert_BJMONSET]    Script Date: 09/29/2017 15:29:09 ******/
DROP PROCEDURE [dbo].[sp_insert_BJMONSET]
GO
/****** Object:  StoredProcedure [dbo].[sp_insert_BJMONSET]    Script Date: 09/29/2017 15:29:09 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO


------------------------------------------------------------------------------------- 
Create           procedure [dbo].[sp_insert_BJMONSET]                                                                                                                                                                                                                                                                
---------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------- 
         @cocde   nvarchar(6),   
		 @bst_jobid nvarchar(20) ,
     @bst_jobname nvarchar(100),
     @bst_pgid nvarchar(20) ,
     @bst_pgname nvarchar(100),
     @bst_pgstepid nvarchar(20) ,
     @bst_pgstepname nvarchar(100),
        @gsusr   nvarchar (30) 

------------------------------------ 
AS

insert into  BJMONSET
(
        bst_jobid ,
     bst_jobname ,
     bst_pgid ,
     bst_pgname ,
     bst_pgstepid ,
     bst_pgstepname,
        bst_creusr ,
        bst_updusr,
        bst_credat ,
        bst_upddat,
        bst_timstp  
          
)

values(
                                                                                                                                                                                                                                                                 
---------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------- 

        @bst_jobid ,
     @bst_jobname ,
     @bst_pgid ,
     @bst_pgname ,
     @bst_pgstepid ,
     @bst_pgstepname, 
        'misbj',
        'misbj',
        getdate(),
        getdate(),
        NULL
) 
    


GO
GRANT EXECUTE ON [dbo].[sp_insert_BJMONSET] TO [ERPUSER] AS [dbo]
GO
