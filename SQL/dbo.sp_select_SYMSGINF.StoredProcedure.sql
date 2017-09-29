/****** Object:  StoredProcedure [dbo].[sp_select_SYMSGINF]    Script Date: 09/29/2017 15:29:08 ******/
DROP PROCEDURE [dbo].[sp_select_SYMSGINF]
GO
/****** Object:  StoredProcedure [dbo].[sp_select_SYMSGINF]    Script Date: 09/29/2017 15:29:10 ******/
SET ANSI_NULLS OFF
GO
SET QUOTED_IDENTIFIER OFF
GO







------------------------------------------------- 
CREATE procedure [dbo].[sp_select_SYMSGINF]
                                                                                                                                                                                                                                                                 
---------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------- 
@ymi_mcode nvarchar(6) ,
                                               
---------------------------------------------- 
@lock int
 
AS
 
if @lock = 0
begin
 Select *
                                  
--------------------------------- 
 from SYMSGINF
 where
                                                                                                                                                                                                                                                                 
---------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------- 
 ymi_mcode = @ymi_mcode  --and
                           
-------------------------- 
-- ymc_lckflg <> 9
                                                           
---------------------------------------------------------- 
end
else
begin
 Select *
 from SYMSGINF
 where
                                                                                                                                                                                                                                                                 
---------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------- 
 ymi_mcode = @ymi_mcode 

-- and
                           
-------------------------- 
-- ymc_lckflg <> 9
                                                                                         
---------------------------------------------------------------------------------------- 
-- if @@rowcount <> 0
--  update SYMSGINF
--  set ymc_lckflg = 1
--  where
                                                                                                                                                                                                                                                                 
---------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------- 
--  ymc_msgevt = @ymc_msgevt and
                                
------------------------------- 
--  ymc_lckflg = 0
end
     
----






GO
GRANT EXECUTE ON [dbo].[sp_select_SYMSGINF] TO [ERPUSER] AS [dbo]
GO
