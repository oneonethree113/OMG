/****** Object:  StoredProcedure [dbo].[sp_select_DER00006]    Script Date: 09/29/2017 15:29:09 ******/
DROP PROCEDURE [dbo].[sp_select_DER00006]
GO
/****** Object:  StoredProcedure [dbo].[sp_select_DER00006]    Script Date: 09/29/2017 15:29:10 ******/
SET ANSI_NULLS OFF
GO
SET QUOTED_IDENTIFIER OFF
GO


CREATE procedure [dbo].[sp_select_DER00006]
@cocde	 nvarchar(6)

AS

Begin
	Select
	--'P' as CodeP,
                @cocde,
                 hdr.quh_qutno,
                 hdr.quh_issdat,
                 hdr.quh_rvsdat,
                 cus.cbi_cussna,
                 cut.cbi_cussna,
                 hdr.quh_qutsts
From 	QUOTNHDR hdr,  CUBASINF cus, CUBASINF cut
	WHERE 	hdr.quh_cocde = cus.cbi_cocde
	and	hdr.quh_cocde = cus.cbi_cocde and hdr.quh_cus1no = cus.cbi_cusno
                and	hdr.quh_cocde = cut.cbi_cocde and hdr.quh_cus2no = cut.cbi_cusno
                and          hdr.quh_qutsts = 'W'
	and          hdr.quh_cocde = @cocde
	order by  hdr.quh_qutno
End


GO
GRANT EXECUTE ON [dbo].[sp_select_DER00006] TO [ERPUSER] AS [dbo]
GO
