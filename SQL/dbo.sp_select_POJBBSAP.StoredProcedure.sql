/****** Object:  StoredProcedure [dbo].[sp_select_POJBBSAP]    Script Date: 09/29/2017 15:29:09 ******/
DROP PROCEDURE [dbo].[sp_select_POJBBSAP]
GO
/****** Object:  StoredProcedure [dbo].[sp_select_POJBBSAP]    Script Date: 09/29/2017 15:29:10 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE procedure [dbo].[sp_select_POJBBSAP]  
@cocde varchar(6) ,   
@type char(1) = 'X'  
as  
begin  
  
 declare @seq char(4)  
 declare @intSeq int  
  
 set @intSeq = 0  
  
 if @type = 'S'  
 begin  
  select @intSeq = isnull(max(cast(pjs_seq as int)),0) from POJBBSAP where pjs_cocde = 'UCPP' and  convert(varchar(10),pjs_credat,111)  = convert(varchar(10),getdate(),111)   
  if @intSeq = 0   
  begin  
   set @seq = '0000'  
  end  
  else  
  begin  
   -- set @intSeq = @intSeq + 1  
   set @seq = right('0000' + cast(@intSeq as varchar(4)),4)  
  end  
 end  
 else  
 begin  
  select @intSeq = isnull(max(cast(pjs_seq as int)),0) from POJBBSAP  
  where convert(varchar(10),pjs_credat ,121) = convert(varchar(10),getdate(),121)   
  and pjs_cocde = @cocde  
   
   
  if @intSeq = 0   
  begin  
   set @seq = '0001'  
  end  
  else  
  begin  
   set @intSeq = @intSeq + 1  
   set @seq = right('0000' + cast(@intSeq as varchar(4)),4)  
  end  
    
 end  
  
 select @seq  
end  
  



GO
GRANT EXECUTE ON [dbo].[sp_select_POJBBSAP] TO [ERPUSER] AS [dbo]
GO
