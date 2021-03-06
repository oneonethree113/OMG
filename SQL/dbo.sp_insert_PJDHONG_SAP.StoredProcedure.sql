/****** Object:  StoredProcedure [dbo].[sp_insert_PJDHONG_SAP]    Script Date: 09/29/2017 15:29:09 ******/
DROP PROCEDURE [dbo].[sp_insert_PJDHONG_SAP]
GO
/****** Object:  StoredProcedure [dbo].[sp_insert_PJDHONG_SAP]    Script Date: 09/29/2017 15:29:09 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO



CREATE procedure [dbo].[sp_insert_PJDHONG_SAP]    
@pjd_cocde nvarchar(6),    
@pjd_batno nvarchar(20),    
@pjd_jobord nvarchar(20),    
@pjd_confrm nvarchar(1),    
@pjd_updusr  nvarchar(30)  ,   
--Lestesr Wu 2007-07-12
--@pjd_zutyp char(1) = 'X'  
@pjd_zutyp varchar(20),
-- Added by Mark Lau 20091125
@pjd_upd_rea	nvarchar(255)  = 'X'  
AS    
  
INSERT INTO POJBBDTL    
(    
pjd_cocde,     
pjd_batno,     
pjd_jobord,    
pjd_confrm,    
pjd_updusr,    
pjd_creusr  ,   
pjd_zutyp   ,
-- Added by Mark Lau 20091125
pjd_upd_rea
) VALUES (    
@pjd_cocde,     
@pjd_batno,     
@pjd_jobord,    
@pjd_confrm,    
@pjd_updusr,    
@pjd_updusr  ,  
case @pjd_zutyp when 'X' then '' else @pjd_zutyp  end  ,
-- Added by Mark Lau 20091125
case @pjd_upd_rea when 'X' then '' else @pjd_upd_rea  end  
)         
    
    
  
  






GO
GRANT EXECUTE ON [dbo].[sp_insert_PJDHONG_SAP] TO [ERPUSER] AS [dbo]
GO
