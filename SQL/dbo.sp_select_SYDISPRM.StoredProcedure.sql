/****** Object:  StoredProcedure [dbo].[sp_select_SYDISPRM]    Script Date: 09/29/2017 15:29:08 ******/
DROP PROCEDURE [dbo].[sp_select_SYDISPRM]
GO
/****** Object:  StoredProcedure [dbo].[sp_select_SYDISPRM]    Script Date: 09/29/2017 15:29:10 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO

---------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------


/*
=========================================================
Program ID	: 
Description   	: 
Programmer  	: 
Create Date   	: 
Last Modified  	: 
Table Read(s) 	:
Table Write(s) 	:
Parameter:	
=========================================================
 Modification History                                    
=========================================================
 Date      	Initial  	Description          
2003-08-20	Allan Yuen	Fix Deadlock error.               
=========================================================     
*/


------------------------------------------------- 
CREATE procedure [dbo].[sp_select_SYDISPRM]

                                                                                                                                                                                                                                                               
  
---------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
--
@ydp_cocde nvarchar(6) = ' ',
@ydp_type  nvarchar(1)
---------------------------------------------- 
 
AS
declare @ydp_timstp int

Set  @ydp_timstp = (Select max(cast(ydp_timstp as int)) from sydisprm (nolock) where ydp_cocde = ' ')

begin
 Select 
ydp_creusr as 'ydp_status',
ydp_cocde,
ydp_type,
ydp_cde,
ydp_sts,
ydp_dsc,
ydp_account_new as 'ydp_account',
ydp_pca,
ydp_pcb,
ydp_creusr,
ydp_updusr,
ydp_credat,
ydp_upddat,
@ydp_timstp as ydp_timstp 

/*
yci_creusr as 'yci_status'
*/
                                  
--------------------------------- 
 from SYDISPRM (nolock)
 where
                                                                                                                                                                                                                                                               
  
---------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
--
-- ydp_cocde = @ydp_cocde and
ydp_cocde = ' ' and
 ydp_type = @ydp_type


order by 
ydp_cocde,
ydp_type,
ydp_cde
-------------------------- 

                                                           
---------------------------------------------------------- 
end



GO
GRANT EXECUTE ON [dbo].[sp_select_SYDISPRM] TO [ERPUSER] AS [dbo]
GO
