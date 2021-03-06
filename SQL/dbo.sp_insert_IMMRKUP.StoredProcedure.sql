/****** Object:  StoredProcedure [dbo].[sp_insert_IMMRKUP]    Script Date: 09/29/2017 15:29:09 ******/
DROP PROCEDURE [dbo].[sp_insert_IMMRKUP]
GO
/****** Object:  StoredProcedure [dbo].[sp_insert_IMMRKUP]    Script Date: 09/29/2017 15:29:09 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO






-- Checked by Allan Yuen at 28/07/2003    
    
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
17 July 2003 Allan Yuen  For Merge Porject    
20 Jan 2006 Allan Yuen  Add Fty Price Term    
21 Jun 2006 Marco Chan  Add FtyBOMCst Field Storage    
*/    
    
/************************************************************************    
Author:  Kenny Chan    
Date:  13th September, 2001    
Description: Insert data From IMMRKUP    
Parameter: 1. Company    
  2. Item No.     
************************************************************************/    
-------------------------------------------------     
CREATE procedure [dbo].[sp_insert_IMMRKUP]    
  
@imu_cocde   nvarchar(6) = ' ',    
@imu_itmno   nvarchar(20),    
@imu_typ   nvarchar(4),    
@imu_ventyp   nvarchar(4),    
@imu_venno   nvarchar(6),    
@imu_prdven   nvarchar(6),    
@imu_pckseq   int,    
/*    
--Modified by Victor Leung 20030120    
--@imu_pckunt   nvarchar(4),    
*/    
@imu_pckunt   nvarchar(6),    
/**/    
@imu_inrqty   int,      
@imu_mtrqty   int,      
@imu_cft   numeric(11,4)   ,    
@imu_curcde   nvarchar(6),    
@imu_prctrm   nvarchar(10),    
@imu_relatn   nvarchar(4),    
@imu_fmlopt   nvarchar(5),           
@imu_ftycst   numeric( 13,   4),    
@imu_ftyprc   numeric( 13,   4),    
@imu_calftyprc   numeric( 13,   4),    
@imu_bcurcde nvarchar(6),    
@imu_basprc   numeric( 13,   4),    
@imu_negprc   numeric( 13,   4),    
@imu_alsbasprc  numeric( 13,   4) = 0,    
@imu_bomcst  numeric( 13,   4),    
@imu_ttlcst  numeric( 13,   4),    
@imu_itmprc numeric( 13,   4),    
@imu_bomprc numeric( 13,   4),    
@imu_ftybomcst numeric( 13,   4),    
@imu_ftyprctrm   nvarchar(10),    
@imu_conftr int ,   
@imu_std	char(1),
@imu_cstchgdat datetime,
@imu_updusr   nvarchar(30)    
    
    
     
                                                   
----------------------------------------------     
     
AS    
    
begin    

--Lester Wu 2007-07-27
if @imu_conftr <= 0
begin
	set @imu_conftr = 1
end

Insert into IMMRKUP    
(imu_cocde,    
imu_itmno,    
imu_typ,    
imu_ventyp,    
imu_venno,    
imu_prdven,    
imu_pckseq,    
imu_pckunt,    
imu_inrqty,    
imu_mtrqty,    
imu_cft,    
imu_curcde,    
imu_prctrm,    
imu_relatn,    
imu_fmlopt,    
imu_ftycst,    
imu_ftyprc,    
imu_calftyprc,    
imu_bcurcde,    
imu_basprc,    
imu_negprc,    
imu_alsbasprc,      
imu_bomcst,    
imu_ttlcst,    
imu_itmprc,    
imu_bomprc,    
imu_ftybomcst,    
imu_ftyprctrm,    
imu_conftr,
imu_std,
imu_cstchgdat,
imu_creusr,    
imu_updusr,    
imu_credat,    
imu_upddat
)    
values    
(    
--@imu_cocde,    
' ',    
@imu_itmno,    
@imu_typ,    
@imu_ventyp,    
@imu_venno,    
@imu_prdven,    
@imu_pckseq,    
@imu_pckunt,    
@imu_inrqty,    
@imu_mtrqty,    
@imu_cft,    
@imu_curcde,    
@imu_prctrm,    
@imu_relatn,    
@imu_fmlopt,    
@imu_ftycst,    
@imu_ftyprc,    
@imu_calftyprc,    
@imu_bcurcde,    
@imu_basprc,    
@imu_negprc,    
@imu_alsbasprc,     
@imu_bomcst,    
@imu_ttlcst,    
@imu_itmprc,    
@imu_bomprc,    
@imu_ftybomcst,    
@imu_ftyprctrm,    
@imu_conftr,
@imu_std,
@imu_cstchgdat,
@imu_updusr,    
@imu_updusr,    
getdate(),    
getdate()  

)    
end    
    
    
    
    
    
    
    
  
  









GO
GRANT EXECUTE ON [dbo].[sp_insert_IMMRKUP] TO [ERPUSER] AS [dbo]
GO
