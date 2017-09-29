/****** Object:  StoredProcedure [dbo].[sp_insert_POJBBSAP]    Script Date: 09/29/2017 15:29:09 ******/
DROP PROCEDURE [dbo].[sp_insert_POJBBSAP]
GO
/****** Object:  StoredProcedure [dbo].[sp_insert_POJBBSAP]    Script Date: 09/29/2017 15:29:09 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE procedure [dbo].[sp_insert_POJBBSAP]  
@cocde varchar(6),  
@batno varchar(20),  
@seq varchar(4),  
@ediseq varchar(4),  
@jobord varchar(20),  
@Usrid varchar(30)  
as  
begin  

-- select * from POJBBSAP(nolock) where pjs_credat >= '2007-11-08' order by pjs_batno,pjs_batseq
-- delete from POJBBSAP where pjs_credat >= '2007-11-08'
 insert into POJBBSAP (  
  pjs_cocde ,  
  pjs_batno ,  
  pjs_batseq ,  
  pjs_seq ,  
  pjs_jobord ,  
  pjs_creusr ,  
  pjs_credat  
 )  
 values ( @cocde , @batno, @seq, @ediseq, @jobord, @Usrid , getdate() )  
  
   
end  
  




GO
GRANT EXECUTE ON [dbo].[sp_insert_POJBBSAP] TO [ERPUSER] AS [dbo]
GO
