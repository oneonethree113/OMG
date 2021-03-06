/****** Object:  StoredProcedure [dbo].[sp_insert_FYJOBSMK]    Script Date: 09/29/2017 15:29:09 ******/
DROP PROCEDURE [dbo].[sp_insert_FYJOBSMK]
GO
/****** Object:  StoredProcedure [dbo].[sp_insert_FYJOBSMK]    Script Date: 09/29/2017 15:29:09 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO





-- select * from FYJOBSMK
 -- Checked by Allan Yuen at 28/07/2003    
  -- Select * from FYJOBATH  
  
  
CREATE procedure [dbo].[sp_insert_FYJOBSMK]    
@fsm_cocde  nvarchar(6),    
@fsm_jobno  nvarchar(20),    
@fsm_smkno nvarchar(50),    
@fsm_updusr  nvarchar(30)  
AS    
  
insert into FYJOBSMK    
(    
fsm_cocde,    
fsm_jobno,    
fsm_smkno,    
fsm_creusr,    
fsm_updusr,    
fsm_credat,    
fsm_upddat    
)    
    
values(    
@fsm_cocde,    
@fsm_jobno,    
@fsm_smkno,    
@fsm_updusr,    
@fsm_updusr,    
getdate(),    
getdate()    
)         
    
    
insert into FYJOBSMKH    
(    
fsm_cocde,    
fsm_jobno,    
fsm_smkno,    
fsm_creusr,    
fsm_updusr,    
fsm_credat,    
fsm_upddat    
)    
    
values(    
@fsm_cocde,    
@fsm_jobno,    
@fsm_smkno,    
@fsm_updusr,    
@fsm_updusr,    
getdate(),    
getdate()    
)    
  
  
insert into FYJOBATH(  
fsa_cocde ,   
fsa_jobno ,   
fsa_smkno ,  
fsa_act ,   
fsa_creusr ,  
fsa_updusr ,  
fsa_credat ,  
fsa_upddat  
)  
select distinct 
@fsm_cocde,  
pjd_jobord,  
@fsm_smkno,  
'' ,   
@fsm_updusr,  
@fsm_updusr,  
getdate(),  
getdate()  
from POJBBDTL   
where pjd_batno = left(@fsm_jobno,len(pjd_batno)) and   
pjd_batseq = substring(@fsm_jobno,11,4) and  
pjd_cocde = @fsm_cocde  
    





declare @seq as int
set @seq = 0

if @seq is null
begin
	set @seq = 1
end



select stm_ordno, stm_ordseq, stm_smkno, max(isnull(stm_athseq,0)) as 'curseq' 
into #result1 
from POJBBDTL left join SCTPSMRK on (pjd_jobord = stm_jobno)
where 
pjd_batno = left(@fsm_jobno,len(pjd_batno)) and   
pjd_batseq = substring(@fsm_jobno,11,4) and  
pjd_cocde = @fsm_cocde  
group by stm_ordno, stm_ordseq, stm_smkno

/*
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
select distinct 
	isnull(curseq, 0) + 1,
	@fsm_cocde,  
	pod_scno,
	pod_scline,
	pod_scno + ' - ' + ltrim(rtrim(convert(nvarchar(10), pod_scline))), 
	pjd_jobord,  
	@fsm_smkno,  
	'' ,   
	@fsm_updusr,  
	@fsm_updusr,  
	getdate(),  
	getdate()  
from POJBBDTL left join POORDDTL on (pjd_jobord = pod_jobord)
       	          left join #result1 on (stm_ordno = pod_scno and stm_ordseq = pod_scline and stm_smkno = @fsm_smkno)
where pjd_batno = left(@fsm_jobno,len(pjd_batno)) and   
pjd_batseq = substring(@fsm_jobno,11,4) and  
pjd_cocde = @fsm_cocde  
*/

drop table #result1








GO
GRANT EXECUTE ON [dbo].[sp_insert_FYJOBSMK] TO [ERPUSER] AS [dbo]
GO
