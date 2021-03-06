/****** Object:  StoredProcedure [dbo].[sp_insert_syntsmk]    Script Date: 09/29/2017 15:29:09 ******/
DROP PROCEDURE [dbo].[sp_insert_syntsmk]
GO
/****** Object:  StoredProcedure [dbo].[sp_insert_syntsmk]    Script Date: 09/29/2017 15:29:09 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO









CREATE procedure [dbo].[sp_insert_syntsmk]  
@stm_cocde  nvarchar(6),  
@docnam  nvarchar(20),  
@stm_smkno nvarchar(50),
@act  nvarchar(3),
@stm_updusr  nvarchar(30)

AS  

declare @batno as nvarchar(20)
declare @tmpseq as nvarchar(10)
declare @batseq as nvarchar(10)
declare @doc as nvarchar(20)
declare @stm_ordno as nvarchar(20)
declare @stm_ordseq as int
declare @seq as int
declare @stm_jobno as nvarchar(20)


begin

set @doc = ltrim(rtrim(@docnam))

set @batno = ltrim(left(@doc, charindex('-', @doc)-1))
set @tmpseq = right(@doc, len(@doc) - charindex('-', @doc))
set @batseq = ltrim(left(@tmpseq, charindex('.', @tmpseq)-1))


set @stm_ordno = ''
set @stm_ordseq  = 0



select	distinct 
	@stm_ordno = case when charindex('-', pod_jobord) = 0 then '' else ltrim(left(pod_jobord, charindex('-', pod_jobord) - 1 )) end , 
	@stm_ordseq = isnull(pod_scline, 0),
	@stm_jobno = isnull(pjd_jobord,'')
from 
	POJBBDTL, POORDDTL
where
	pjd_jobord = pod_jobord and
	pjd_batno = @batno and pjd_batseq = @batseq


if ltrim(rtrim(@stm_ordno)) <> '' and @stm_ordseq <> 0 and @stm_smkno <> ''
begin

	set @seq = 0
	select 
		@seq = max(stm_athseq) from SCTPSMRK 
	where 
		stm_ordno  = @stm_ordno  and
		stm_ordseq  = @stm_ordseq  and
		stm_smkno = @stm_smkno 
	
	if @seq is null
	begin
		set @seq = 1
	end


	if @act = 'ADD'  
	begin  

--		PRINT 'DEBUG FLAG : ' + CONVERT( CHAR(3), 'ADD' )
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
--		PRINT 'DEBUG FLAG : ' + CONVERT( CHAR(3), 'DEL' )
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
 	--	 PRINT 'DEBUG FLAG : ' + CONVERT( CHAR(3), 'UPD' )
		 update SCTPSMRK   
		 set stm_act = 'UPD', stm_updusr = @stm_updusr , stm_upddat = getdate()  
		 where 
		stm_ordno  = @stm_ordno  and
		stm_ordseq  = @stm_ordseq  
		 and stm_smkno = @stm_smkno  
		and stm_athseq = @seq
	end

end

end









GO
GRANT EXECUTE ON [dbo].[sp_insert_syntsmk] TO [ERPUSER] AS [dbo]
GO
