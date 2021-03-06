/****** Object:  StoredProcedure [dbo].[sp_select_qcemlhdr]    Script Date: 09/29/2017 15:29:09 ******/
DROP PROCEDURE [dbo].[sp_select_qcemlhdr]
GO
/****** Object:  StoredProcedure [dbo].[sp_select_qcemlhdr]    Script Date: 09/29/2017 15:29:10 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE  PROCEDURE [dbo].[sp_select_qcemlhdr] 

AS

BEGIN

create table #temp_qcemlseq_max
(
tmp_rptno nvarchar(30),
tmp_maxseq int,
test nvarchar(1)
)
insert into #temp_qcemlseq_max
select qeh_tmprptno,
        max(qeh_seq ),''
	 from QCEMLHDR
		where  qeh_mailflg  =  'Y'
		group by qeh_tmprptno



SELECT 
        qeh_fr,
        Replace(qeh_to,'mis@ucp.com.hk','marco@ucp.com.hk') as 'qeh_to',
        qeh_cc,

        qeh_sub,
        qeh_content,

        qeh_tmprptno,
        qeh_seq,

        qeh_mailflg,
        qeh_validflg,
        qeh_mailtyp

 from QCEMLHDR
		left join #temp_qcemlseq_max
			on tmp_rptno  = qeh_tmprptno
					and tmp_maxseq =  qeh_seq
		where  qeh_mailflg  =  'Y'
						and test is not null
--		where  qeh_tmprptno  =  @TmpRPTNo
					
drop table #temp_qcemlseq_max

END

GO
GRANT EXECUTE ON [dbo].[sp_select_qcemlhdr] TO [ERPUSER] AS [dbo]
GO
