/****** Object:  StoredProcedure [dbo].[sp_update_SYVENFML]    Script Date: 09/29/2017 15:29:08 ******/
DROP PROCEDURE [dbo].[sp_update_SYVENFML]
GO
/****** Object:  StoredProcedure [dbo].[sp_update_SYVENFML]    Script Date: 09/29/2017 15:29:10 ******/
SET ANSI_NULLS OFF
GO
SET QUOTED_IDENTIFIER ON
GO







-- Checked by Allan Yuen at 28/07/2003


/* Samuel 
*/

------------------------------------------------- 
CREATE procedure [dbo].[sp_update_SYVENFML]

                                                                                                                                                                                                                                                                 
---------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------- 
@yvf_cocde	nvarchar(6) = ' ',
@yvf_venno	nvarchar(6),
@yvf_fmlopt	nvarchar(5),
@yvf_def		nvarchar(2),
@yvf_updusr	 nvarchar(30),
-- Added by Mark Lau 20090204
@yvf_catcde	nvarchar(20),
@yvf_matcde	nvarchar(6),
@yvf_effdat	datetime

---------------------------------------------- 
 
AS

begin
update syvenfml
set 
---yvf_cocde= @yvf_cocde,
yvf_venno	= @yvf_venno,
yvf_fmlopt = @yvf_fmlopt,
yvf_def = @yvf_def,
yvf_effdat = @yvf_effdat,
yvf_updusr = @yvf_updusr,
yvf_creusr = @yvf_updusr,
yvf_upddat=getdate()

-- rem by Mark Lau 20090204, yvf_credat=getdate()                                  
--------------------------------- 

 where
                                                                                                                                                                                                                                                                 
---------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------- 
--yvf_cocde = @yvf_cocde and 
--yvf_cocde = ' ' and 
yvf_venno = @yvf_venno and 
yvf_fmlopt = @yvf_fmlopt and
yvf_effdat = @yvf_effdat and
-- Added by Mark Lau 20090204
yvf_catcde = @yvf_catcde	and
yvf_matcde = @yvf_matcde	
                                                           
---------------------------------------------------------- 
end



GO
GRANT EXECUTE ON [dbo].[sp_update_SYVENFML] TO [ERPUSER] AS [dbo]
GO
