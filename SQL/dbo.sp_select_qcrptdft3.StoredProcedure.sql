/****** Object:  StoredProcedure [dbo].[sp_select_qcrptdft3]    Script Date: 09/29/2017 15:29:09 ******/
DROP PROCEDURE [dbo].[sp_select_qcrptdft3]
GO
/****** Object:  StoredProcedure [dbo].[sp_select_qcrptdft3]    Script Date: 09/29/2017 15:29:10 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

--The function of this stored procedure is returning a table about defect problem of the QC form QCRPTDF with other construction and reorder the seq of problems
--
--  QCRPTDF:		  reorder the table and change the constuction            	Result Table:
--[first half]
--             --------------------------------------------------------->[first half] [last  half]
--[last  half]
CREATE  PROCEDURE [dbo].[sp_select_qcrptdft3] 
@TmpRPTNo as nvarchar(30)

AS

BEGIN
   
--reorder the table
SELECT ROW_NUMBER()  OVER (ORDER BY qdt_dfttyp,qdt_dftdsc,qdt_dftcrt,qdt_dftmaj, qdt_dftmin) as 'qdt_dftseq'
      ,[qdt_dfttyp]
      ,[qdt_dftdsc]
      ,[qdt_dftcrt]
      ,[qdt_dftmaj]
      ,[qdt_dftmin]
      into #TempTable
  FROM [dbo].[QCRPTDFT]
  where qdt_tmprptno=@TmpRPTNo
  order by qdt_dfttyp,qdt_dftdsc,qdt_dftcrt,qdt_dftmaj, qdt_dftmin  desc

--Avoid null or empty column. Null or empty column can cause format problem in pdf of report
update #TempTable
set [qdt_dftdsc]='N\A'
where isnull(qdt_dftdsc ,'')=''
  
--get the positon for cutting off the orginal table into 2 table
declare @ttl_half   as int
set @ttl_half  = (select (count(*)+1)/2 from QCRPTDFT  WHERE qdt_tmprptno=@TmpRPTNo)

--set the first half table as left table
select * into #leftTable from #TempTable where qdt_dftseq <= @ttl_half 

--set the last half table as right table. Rename the colunm to avoid confusing the coulumn name of two table
select qdt_dftseq as qdt_dftseqR
      ,[qdt_dfttyp] as qdt_dfttypR
      ,[qdt_dftdsc] as qdt_dftdscR
      ,[qdt_dftcrt] as qdt_dftcrtR
      ,[qdt_dftmaj] as qdt_dftmajR
      ,[qdt_dftmin] as qdt_dftminR
 into #rightTable from #TempTable where qdt_dftseq > @ttl_half 

--join the left and right into 1 table
select * into #resultTable from #leftTable left join #rightTable on #leftTable.qdt_dftseq+@ttl_half=#rightTable.qdt_dftseqR

--return the result(return all columns except the columns of seq number)
select  [qdt_dfttyp]
      ,[qdt_dftdsc]
      ,[qdt_dftcrt]
      ,[qdt_dftmaj]
      ,[qdt_dftmin]
      ,[qdt_dfttypR] 
      ,[qdt_dftdscR] 
      ,[qdt_dftcrtR] 
      ,[qdt_dftmajR] 
      ,[qdt_dftminR]
 FROM #resultTable

--delete the temp tables
drop table #leftTable,#rightTable,#resultTable,#TempTable

END


--


GO
GRANT EXECUTE ON [dbo].[sp_select_qcrptdft3] TO [ERPUSER] AS [dbo]
GO
