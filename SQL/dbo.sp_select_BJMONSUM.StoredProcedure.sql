/****** Object:  StoredProcedure [dbo].[sp_select_BJMONSUM]    Script Date: 09/29/2017 15:29:09 ******/
DROP PROCEDURE [dbo].[sp_select_BJMONSUM]
GO
/****** Object:  StoredProcedure [dbo].[sp_select_BJMONSUM]    Script Date: 09/29/2017 15:29:10 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO

Create  PROCEDURE [dbo].[sp_select_BJMONSUM]
@bms_jobsumid nvarchar(20),
@bms_jobid nvarchar(20)
AS
BEGIN

select bms_jobsumid,
bms_jobid,
bms_pgid,
bms_jobname,
bms_lastflag,
bms_jobstartdate,
bms_jobenddate,
bms_totalpg,
bms_status01,
bms_status02,
bms_status03,
bms_status04,
bms_status05,
bms_status06,
bms_status07,
bms_status08,
bms_status09,
bms_status10,
bms_remarks,
bms_creusr,
bms_updusr,
bms_credat,
bms_upddat,
bms_timstp
from BJMONSUM
where
bms_jobsumid = @bms_jobsumid and
bms_jobid = @bms_jobid
END

GO
GRANT EXECUTE ON [dbo].[sp_select_BJMONSUM] TO [ERPUSER] AS [dbo]
GO
