/****** Object:  StoredProcedure [dbo].[sp_select_TOITMDTL_SC]    Script Date: 09/29/2017 15:29:08 ******/
DROP PROCEDURE [dbo].[sp_select_TOITMDTL_SC]
GO
/****** Object:  StoredProcedure [dbo].[sp_select_TOITMDTL_SC]    Script Date: 09/29/2017 15:29:10 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO








/*
=================================================================
Program ID	: sp_select_TOITMDTL_SC
Description	: Retrieve Tentative Order Items for SC
Programmer	: David Yue
=================================================================
	MODIFICATION HISTORY
=================================================================
   Date		 Editor			Description
=================================================================
2013-09-17 	David Yue		SP Created
=================================================================
*/


CREATE procedure [dbo].[sp_select_TOITMDTL_SC]
@cocde		varchar(6),
@toordno	varchar(20),
@itmno		varchar(30),
@cus1no		varchar(6),
@cus2no		varchar(6),
@usrid		varchar(30)

as


declare @tmpitm as varchar(30)

select @tmpitm = isnull(itr_tmpitm,'') from IMTMPREL where itr_itmno = @itmno

select	'' as 'tid_status',
	tid_toordno,
	tid_toordseq,
	tid_pckunt,
	tid_toqty,
	tid_soqty,
	--tid_toqty - tid_soqty as 'tid_osqty'
	tid_osqty
from	TOITMDTL (nolock)
	join TOORDHDR (nolock) on
		toh_cocde = tid_cocde and
		toh_toordno = tid_toordno
where	tid_cocde = @cocde and
	tid_toordno = @toordno and
	(tid_itmno = @itmno or tid_tmpitmno = @tmpitm)
	and
	tid_cus1no = @cus1no and
	tid_cus2no = @cus2no and
	toh_ordsts <> 'CLO'






GO
GRANT EXECUTE ON [dbo].[sp_select_TOITMDTL_SC] TO [ERPUSER] AS [dbo]
GO
