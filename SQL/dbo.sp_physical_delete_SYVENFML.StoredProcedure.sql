/****** Object:  StoredProcedure [dbo].[sp_physical_delete_SYVENFML]    Script Date: 09/29/2017 15:29:09 ******/
DROP PROCEDURE [dbo].[sp_physical_delete_SYVENFML]
GO
/****** Object:  StoredProcedure [dbo].[sp_physical_delete_SYVENFML]    Script Date: 09/29/2017 15:29:10 ******/
SET ANSI_NULLS OFF
GO
SET QUOTED_IDENTIFIER ON
GO






-- Checked by Allan Yuen at 28/07/2003



/*
'***  Author : Samuel Chan
'***  Creation Date : 18-10-2000
'***  Description : Delete SYVENFML
'***  Logic : 1.  
'***              2. 
*/

------------------------------------------------- 
CREATE procedure [dbo].[sp_physical_delete_SYVENFML]
                                                                                                                                                                                                                                                                 
---------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------- 
@yvf_cocde	nvarchar(6) = ' ' ,
@yvf_venno	nvarchar(6),
@yvf_fmlopt             nvarchar(5),
-- Added by Mark Lau 20090204
@yvf_catcde	nvarchar(20),
@yvf_matcde	nvarchar(6),
@yvf_effdat	datetime


                    
-------------------------------- 
AS
 
delete SYVENFML
       
------ 
where
                                                                                                                                                                                                                                                                 
---------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------- 
--yvf_cocde = @yvf_cocde and
yvf_cocde = ' ' and
yvf_venno = @yvf_venno and
yvf_fmlopt = @yvf_fmlopt and
yvf_effdat = @yvf_effdat and 
-- Added by Mark Lau 20090204
--yvf_catcde = @yvf_catcde and 
yvf_matcde = @yvf_matcde	

----


GO
GRANT EXECUTE ON [dbo].[sp_physical_delete_SYVENFML] TO [ERPUSER] AS [dbo]
GO
