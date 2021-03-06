/****** Object:  StoredProcedure [dbo].[sp_insert_SCTPSMRK]    Script Date: 09/29/2017 15:29:09 ******/
DROP PROCEDURE [dbo].[sp_insert_SCTPSMRK]
GO
/****** Object:  StoredProcedure [dbo].[sp_insert_SCTPSMRK]    Script Date: 09/29/2017 15:29:09 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO









CREATE procedure [dbo].[sp_insert_SCTPSMRK]  
@stm_cocde  nvarchar(6),  
@stm_ordno  nvarchar(20),  
@stm_ordseq  int,  
@stm_jobno nvarchar(20),
@stm_smkno nvarchar(50),  
@stm_updusr  nvarchar(30),  
@act  char(3)   
AS  


declare @seq as int
--set @seq = 0
select 
--	@seq = max(isnull(stm_athseq,0)) from SCTPSMRK 
	@seq = max(stm_athseq) from SCTPSMRK 
where 
--	stm_cocde  = @stm_cocde and
	stm_ordno  = @stm_ordno  and
	stm_ordseq  = @stm_ordseq  and
	stm_smkno = @stm_smkno 

if @seq is null
begin
	set @seq = 1
end

--PRINT 'DEBUG FLAG : ' + CONVERT(nvarchar(2), isnull(@seq,99))

if @act = 'ADD'  
begin  
	update 
		SCTPSMRK
	set 
		stm_act = 'DEL' , stm_upddat = getdate(), stm_updusr = @stm_updusr
	where 
--		stm_cocde  = @stm_cocde and
		stm_ordno  = @stm_ordno  and
		stm_ordseq  = @stm_ordseq  and
		stm_smkno = @stm_smkno and
		stm_act  in ('ADD','UPD')

	 insert into SCTPSMRK 
	(
		stm_athseq, 
		stm_cocde, 
		stm_ordno, 
		stm_ordseq,
		stm_ordnoseq, 
		stm_jobno,
		stm_smkno, 
		stm_act, 
		stm_creusr, 
		stm_updusr, 
		stm_credat, 
		stm_upddat 
	)  
	 values 
	(	@seq + 1, 
		@stm_cocde, 
		@stm_ordno, 
		@stm_ordseq, 
		@stm_ordno + ' - ' + ltrim(rtrim(convert(nvarchar(10), @stm_ordseq))), 
		@stm_jobno,
		@stm_smkno, 
		'ADD', 
		@stm_updusr, 
		@stm_updusr, 
		getdate(), 
		getdate() 
	)  

end  
else if @act = 'DEL'  
begin  
	 update SCTPSMRK   
	 set stm_act = 'DEL', stm_updusr = @stm_updusr , stm_upddat = getdate()  
	 where 
		stm_ordno  = @stm_ordno  and
		stm_ordseq  = @stm_ordseq  
		and stm_smkno = @stm_smkno  
		and stm_athseq = @seq
end  
else if @act = 'UPD'  
begin  
	 update SCTPSMRK   
	 set stm_act = 'UPD', stm_updusr = @stm_updusr , stm_upddat = getdate()  
	 where 
	stm_ordno  = @stm_ordno  and
	stm_ordseq  = @stm_ordseq  
	 and stm_smkno = @stm_smkno  
	and stm_athseq = @seq
end









GO
GRANT EXECUTE ON [dbo].[sp_insert_SCTPSMRK] TO [ERPUSER] AS [dbo]
GO
