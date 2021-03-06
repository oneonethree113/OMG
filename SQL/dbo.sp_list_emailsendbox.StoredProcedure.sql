/****** Object:  StoredProcedure [dbo].[sp_list_emailsendbox]    Script Date: 09/29/2017 15:29:09 ******/
DROP PROCEDURE [dbo].[sp_list_emailsendbox]
GO
/****** Object:  StoredProcedure [dbo].[sp_list_emailsendbox]    Script Date: 09/29/2017 15:29:09 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO

CREATE  PROCEDURE [dbo].[sp_list_emailsendbox]
AS

BEGIN

DECLARE @TEMP_MAILID table (tmp_mailid nvarchar(20))

insert into @TEMP_MAILID select esh_mailid from EMSYSHDR
where  esh_status = 'R' and esh_mailid not in 
(select epc_mailid from EMPROCESS left join EMSYSHDR on 
epc_mailid = esh_mailid where esh_status = 'R' and epc_procstatus <> 'S')


update EMSYSHDR set esh_status = 'P', esh_udpdat = getdate()
where  esh_mailid in (select tmp_mailid from @TEMP_MAILID)


select 
esh_mailid,
esh_mailseq,
esh_modcde,
esh_docno,
esh_docseq,
esh_actcde,
esh_from,
esh_to,
esh_cc,
esh_bcc,
esh_subject,
esh_content,
esh_status,
esh_credat,
esh_udpdat,
esh_creusr,
esh_udpusr,
esh_timstp 
from EMSYSHDR  where  esh_mailid in (select tmp_mailid from @TEMP_MAILID)

END


GO
GRANT EXECUTE ON [dbo].[sp_list_emailsendbox] TO [ERPUSER] AS [dbo]
GO
