/****** Object:  StoredProcedure [dbo].[sp_select_SYHRMCDE]    Script Date: 09/29/2017 15:29:08 ******/
DROP PROCEDURE [dbo].[sp_select_SYHRMCDE]
GO
/****** Object:  StoredProcedure [dbo].[sp_select_SYHRMCDE]    Script Date: 09/29/2017 15:29:10 ******/
SET ANSI_NULLS OFF
GO
SET QUOTED_IDENTIFIER OFF
GO




/*
=========================================================
Program ID	: 
Description   	: 
Programmer  	: 
Create Date   	: 
Last Modified  	: 15 July 2003
Table Read(s) 	:
Table Write(s) 	:
=========================================================
 Modification History                                    
=========================================================
Date		Author		Description
=========================================================     
20030715	Allan Yuen		For Merge Porject
*/


/*
   Samuel Chan
   Date : 28/9/2001

   yhc_cocde 	
*/
------------------------------------------------- 
CREATE procedure [dbo].[sp_select_SYHRMCDE]

                                                                                                                                                                                                                                                                 
---------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------- 
@yhc_cocde nvarchar(6)  = ' '

---------------------------------------------- 
 
AS
declare @yhc_timstp int

--Set  @yhc_timstp = (Select max(cast(yhc_timstp as int)) from syhrmcde where yhc_cocde = @yhc_cocde)
Set  @yhc_timstp = (Select max(cast(yhc_timstp as int)) from syhrmcde where yhc_cocde = ' ')

begin
 Select 
yhc_creusr as 'yhc_status',
yhc_cocde,
Case yhc_tarzon when 'U' then 'USA'  
when 'E'then'EUROPE'
end as 'yhc_tarzon',
yhc_hrmcde,
yhc_hrmdsc,
yhc_dtyrat,
yhc_creusr,
yhc_updusr,
yhc_credat,
yhc_upddat,
@yhc_timstp as yhc_timstp 

/*
yci_creusr as 'yci_status'
*/
                                  
--------------------------------- 
 from SYHRMCDE
 where
                                                                                                                                                                                                                                                                 
---------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------- 
-- yhc_cocde = @yhc_cocde
 yhc_cocde = ' '

order by 

yhc_tarzon,
yhc_hrmcde

-------------------------- 

                                                           
---------------------------------------------------------- 
end








GO
GRANT EXECUTE ON [dbo].[sp_select_SYHRMCDE] TO [ERPUSER] AS [dbo]
GO
