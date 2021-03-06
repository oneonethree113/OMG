/****** Object:  StoredProcedure [dbo].[sp_select_qcrptdft2]    Script Date: 09/29/2017 15:29:09 ******/
DROP PROCEDURE [dbo].[sp_select_qcrptdft2]
GO
/****** Object:  StoredProcedure [dbo].[sp_select_qcrptdft2]    Script Date: 09/29/2017 15:29:10 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE  PROCEDURE [dbo].[sp_select_qcrptdft2] 
	@TmpRPTNo as nvarchar(30)

	AS

	BEGIN
	
  declare @ttlcnt  as int
set @ttlcnt = (
select count(*)
from QCRPTDFT  
WHERE qdt_tmprptno=@TmpRPTNo  )
   
declare @ttl_half  as int
if @ttlcnt/2 <> @ttlcnt/2.0 
begin
	set @ttl_half = @ttlcnt/2+1
end
else
begin
	set @ttl_half = @ttlcnt/2
end

	select   qdt_dfttyp as 'qdt_dfttyp'  ,
	case
when isnull(qdt_dftdsc ,'')='' then
''
else
qdt_dftdsc 
end
as 'qdt_dftdsc' ,

	qdt_dftcrt as 'qdt_dftcrt' ,qdt_dftmaj as 'qdt_dftmaj', qdt_dftmin as 'qdt_dftmin'  
	from QCRPTDFT  
	WHERE qdt_tmprptno=@TmpRPTNo 
					and qdt_dftseq >= @ttl_half 
	order by qdt_dfttyp,qdt_dftdsc,qdt_dftcrt,qdt_dftmaj, qdt_dftmin  desc

	/********
	select top 5 qdt_dfttyp,qdt_dftdsc,qdt_dftcrt,qdt_dftmaj, qdt_dftmin  
	from
	(
	select top 5 qdt_dfttyp,qdt_dftdsc,qdt_dftcrt,qdt_dftmaj, qdt_dftmin  
	from 
	(
	select top 10 qdt_dfttyp as 'qdt_dfttyp'  ,qdt_dftdsc as 'qdt_dftdsc' ,qdt_dftcrt as 'qdt_dftcrt' ,qdt_dftmaj as 'qdt_dftmaj', qdt_dftmin as 'qdt_dftmin'  
	from QCRPTDFT  
	WHERE qdt_tmprptno=@TmpRPTNo 
	order by qdt_dfttyp,qdt_dftdsc,qdt_dftcrt,qdt_dftmaj, qdt_dftmin  desc
	)  h
	order by qdt_dfttyp,qdt_dftdsc,qdt_dftcrt,qdt_dftmaj, qdt_dftmin   
	) h2 order by qdt_dfttyp,qdt_dftdsc,qdt_dftcrt,qdt_dftmaj, qdt_dftmin  
	**************/
	END

	
	--
	

GO
GRANT EXECUTE ON [dbo].[sp_select_qcrptdft2] TO [ERPUSER] AS [dbo]
GO
