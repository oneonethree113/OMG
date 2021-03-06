/****** Object:  StoredProcedure [dbo].[sp_select_IMCUSNO]    Script Date: 09/29/2017 15:29:09 ******/
DROP PROCEDURE [dbo].[sp_select_IMCUSNO]
GO
/****** Object:  StoredProcedure [dbo].[sp_select_IMCUSNO]    Script Date: 09/29/2017 15:29:10 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO



CREATE procedure [dbo].[sp_select_IMCUSNO]
@cocde varchar(6),
@itmno varchar(30)
as
begin

	select 
		' ' as 'icn_status',
		icn_itmno,
		isnull(icn_cusno + ' - ' + cbi_cusnam,'') as 'icn_cusno',
		isnull(cbi_cusnam,'') as 'cbi_cussna',
		icn_rmk,
		icn_credat,
		icn_upddat,
		icn_creusr,
		icn_updusr,
		icn_timstp
	 from IMCUSNO
	left join CUBASINF on icn_cusno = cbi_cusno
	where icn_itmno = @itmno

end





GO
GRANT EXECUTE ON [dbo].[sp_select_IMCUSNO] TO [ERPUSER] AS [dbo]
GO
