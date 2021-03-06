/****** Object:  StoredProcedure [dbo].[sp_list_MPM00002_All_MPO]    Script Date: 09/29/2017 15:29:09 ******/
DROP PROCEDURE [dbo].[sp_list_MPM00002_All_MPO]
GO
/****** Object:  StoredProcedure [dbo].[sp_list_MPM00002_All_MPO]    Script Date: 09/29/2017 15:29:09 ******/
SET ANSI_NULLS OFF
GO
SET QUOTED_IDENTIFIER OFF
GO


/*        
=========================================================        
Program ID : sp_list_MPM00002_All_MPO        
Description    :         
Programmer   : Mark Lau     
ALTER  Date    :         
Last Modified   : 2009-06-17        
Table Read(s)  :        
Table Write(s)  :        
==================================================================================        
 Modification History                                            
==================================================================================        
 Date        Initial    Description                  
==================================================================================        

==================================================================================             
        
        
     
*/        
        
        
        
CREATE procedure [dbo].[sp_list_MPM00002_All_MPO]  
@cocde varchar(6),        
@type varchar(10),        
@Fty varchar(50) = ''        
as        
Begin        
        
   
    
  select         
   distinct Mph_MPONo as 'Mph_MPONo' ,        
   Mph_Curr    
 
  from         
   MPORDHDR        
   Left Join MPORDDTL on Mph_MPONo = Mpd_MPONo        
  where         
   Mph_MpoSts = 'ACT' and                  
   isnull(Mpd_DQty,0) - isnull(Mpd_ShpQty,0) > 0         
          
  order by        
   Mph_MpoNo        
 
        
end


GO
GRANT EXECUTE ON [dbo].[sp_list_MPM00002_All_MPO] TO [ERPUSER] AS [dbo]
GO
