/****** Object:  StoredProcedure [dbo].[sp_list_CUTOCUB]    Script Date: 09/29/2017 15:29:09 ******/
DROP PROCEDURE [dbo].[sp_list_CUTOCUB]
GO
/****** Object:  StoredProcedure [dbo].[sp_list_CUTOCUB]    Script Date: 09/29/2017 15:29:09 ******/
SET ANSI_NULLS OFF
GO
SET QUOTED_IDENTIFIER OFF
GO



CREATE   PROCEDURE [dbo].[sp_list_CUTOCUB]
@ctc_cus1no		nvarchar(10),
@ctc_cus2no		nvarchar(10)

AS


select 
ctc_cocde,
ctc_cus1no,
ctc_cus2no,
ctc_custcde,
ctc_buycde,
ctc_custnam,
ctc_buynam,
ctc_catreg,
ctc_creusr,
ctc_updusr,
ctc_credat,
ctc_upddat,
cast(ctc_timstp as int) as 'ctc_timstp'
from 
CUTOCUB (nolock)
where ctc_cus1no = @ctc_cus1no and
	ctc_cus2no = @ctc_cus2no


GO
GRANT EXECUTE ON [dbo].[sp_list_CUTOCUB] TO [ERPUSER] AS [dbo]
GO
