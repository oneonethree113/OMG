/****** Object:  StoredProcedure [dbo].[sp_list_emailprocess_ready]    Script Date: 09/29/2017 15:29:09 ******/
DROP PROCEDURE [dbo].[sp_list_emailprocess_ready]
GO
/****** Object:  StoredProcedure [dbo].[sp_list_emailprocess_ready]    Script Date: 09/29/2017 15:29:09 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO

CREATE  PROCEDURE [dbo].[sp_list_emailprocess_ready]
@module 	nvarchar(20),
@proccde 	nvarchar(20)
AS
BEGIN

select
epc_procid,
epc_mailid,
epc_proccde,
epc_procstatus,
epc_procoutput,
epc_module,
epc_docno,
epc_docseq,
epc_filetype,
epc_credat,
epc_udpdat,
epc_creusr,
epc_udpusr,
epc_timstp,
esh_actcde
into #temp
from EMPROCESS left join EMSYSHDR on epc_mailid = esh_mailid where epc_module = @module and epc_proccde = @proccde
and esh_status = 'R' and epc_procstatus = 'R'

select * from #temp
--If the report is on_site final, the system will gen 2 report. One with image, one without that
drop table #temp
END


GO
GRANT EXECUTE ON [dbo].[sp_list_emailprocess_ready] TO [ERPUSER] AS [dbo]
GO
