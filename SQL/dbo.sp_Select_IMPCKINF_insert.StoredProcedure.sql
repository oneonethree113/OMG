/****** Object:  StoredProcedure [dbo].[sp_Select_IMPCKINF_insert]    Script Date: 09/29/2017 15:29:09 ******/
DROP PROCEDURE [dbo].[sp_Select_IMPCKINF_insert]
GO
/****** Object:  StoredProcedure [dbo].[sp_Select_IMPCKINF_insert]    Script Date: 09/29/2017 15:29:10 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO




/*    
=========================================================    
Program ID :     
Description    :     
Programmer   :     
Create Date    :     
Last Modified   : 17 July 2003    
Table Read(s)  :    
Table Write(s)  :    
=========================================================    
 Modification History                                        
=========================================================    
Date  Author  Description    
=========================================================         
17 July 2003 Allan Yuen  For Merge Porject, disable company code    
*/    
    
    
/************************************************************************    
Author:  Kenny Chan    
Date:  15th September, 2001    
************************************************************************/    
-------------------------------------------------     
CREATE procedure [dbo].[sp_Select_IMPCKINF_insert]    
                                                                                                                                                                                                                                                               
  
@ipi_cocde   nvarchar  (6),    
@ipi_itmno   nvarchar  ( 20),    
/*    
--Modified by Victor Leung 20030120    
--@ipi_pckunt   nvarchar(4),    
*/    
@ipi_pckunt   nvarchar(6),    
/**/    
@ipi_mtrqty   int,    
@ipi_inrqty   int,    
@ipi_inrhin   numeric(11,4) ,    
@ipi_inrwin   numeric(11,4),    
@ipi_inrdin   numeric(11,4),    
@ipi_inrhcm   numeric(11,4),    
@ipi_inrwcm   numeric(11,4),    
@ipi_inrdcm   numeric(11,4),    
@ipi_mtrhin   numeric(11,4),    
@ipi_mtrwin   numeric(11,4),    
@ipi_mtrdin   numeric(11,4),    
@ipi_mtrhcm   numeric(11,4),    
@ipi_mtrwcm   numeric(11,4),    
@ipi_mtrdcm   numeric(11,4),    
@ipi_cft    numeric(11,4),    
@ipi_cbm   numeric(11,4),    
@ipi_grswgt   numeric(6,3),    
@ipi_netwgt   numeric(6,3),    
@ipi_pckitr   nvarchar(300),    
@ipi_conftr int,  
@ipi_cusno	nvarchar(6),
-- Added by Mark Lau 20090211
@ipi_qutdat	datetime,
@ipi_updusr   nvarchar(30)                                         
------------------------------------     
AS    
   
--Lester Wu 2007-07-27
if @ipi_conftr <= 0
begin
	set @ipi_conftr = 1
end
 
declare @ipi_pckseq  int    
    
--Set  @ipi_pckseq = (Select isnull(max(ipi_pckseq),0)  + 1 from impckinf where ipi_cocde = @ipi_cocde and ipi_itmno = @ipi_itmno)    
Set  @ipi_pckseq = (Select isnull(max(ipi_pckseq),0)  + 1 from impckinf where ipi_itmno = @ipi_itmno)    
Select @ipi_pckseq    
insert into  IMPCKINF    
(ipi_cocde,    
ipi_itmno,    
ipi_pckseq,    
ipi_pckunt,    
ipi_mtrqty,    
ipi_inrqty,    
ipi_inrhin,    
ipi_inrwin,    
ipi_inrdin,    
ipi_inrhcm,    
ipi_inrwcm,    
ipi_inrdcm,    
ipi_mtrhin,    
ipi_mtrwin,    
ipi_mtrdin,    
ipi_mtrhcm,    
ipi_mtrwcm,    
ipi_mtrdcm,    
ipi_cft,    
ipi_cbm,    
ipi_grswgt,    
ipi_netwgt,    
ipi_pckitr,    
ipi_conftr , 
ipi_cusno,  
-- Added by Mark Lau 20090211
ipi_qutdat,
ipi_creusr,    
ipi_updusr,    
ipi_credat,    
ipi_upddat)    
    
values(    
    
--@ipi_cocde,    
' ',    
@ipi_itmno,    
@ipi_pckseq,    
@ipi_pckunt,    
@ipi_mtrqty,    
@ipi_inrqty,    
@ipi_inrhin,    
@ipi_inrwin,    
@ipi_inrdin,    
@ipi_inrhcm,    
@ipi_inrwcm,    
@ipi_inrdcm,    
@ipi_mtrhin,    
@ipi_mtrwin,    
@ipi_mtrdin,    
@ipi_mtrhcm,    
@ipi_mtrwcm,    
@ipi_mtrdcm,    
@ipi_cft,    
@ipi_cbm,    
@ipi_grswgt,    
@ipi_netwgt,    
@ipi_pckitr,    
@ipi_conftr ,   
@ipi_cusno,
-- Added by Mark Lau 20090211
@ipi_qutdat,
@ipi_updusr,    
@ipi_updusr,    
  
getdate(),    
getdate()    
)



GO
GRANT EXECUTE ON [dbo].[sp_Select_IMPCKINF_insert] TO [ERPUSER] AS [dbo]
GO
