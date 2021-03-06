/****** Object:  StoredProcedure [dbo].[sp_select_qcrpthdr]    Script Date: 09/29/2017 15:29:09 ******/
DROP PROCEDURE [dbo].[sp_select_qcrpthdr]
GO
/****** Object:  StoredProcedure [dbo].[sp_select_qcrpthdr]    Script Date: 09/29/2017 15:29:10 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

Create  PROCEDURE [dbo].[sp_select_qcrpthdr] 
@TmpRPTNo as nvarchar(30)

AS

BEGIN
SELECT 
/***
	REPLACE(CONVERT(CHAR(15), qrh_inspdat, 6),' ','-') date,
	qrh_tmprptno reportNo,
	qrh_rpttyp,
	vbi_Vensna factory,
		case when secCust.cbi_cussna IS NULL OR secCust.cbi_cussna = '' then priCust.cbi_cussna else secCust.cbi_cussna end customer,qrh_qcno requestNo,qrh_postr po,
		qrh_itmno ucpItem,
		qrh_cuspostr custPo,
		qrh_cusitm custItem, 
***/
		qrg_inspcde,
		qrg_result,
		qrg_detail
		
		from QCRPTHDR QCH 
		LEFT JOIN qcrptgnl
			ON qrh_tmprptno = qrg_tmprptno
		
		LEFT JOIN VNBASINF 
			ON qrh_venno = vbi_venno 
		LEFT JOIN CUBASINF priCust 
			on qrh_cus1no = priCust.cbi_cusno 
		LEFT JOIN CUBASINF secCust on qrh_cus2no = secCust.cbi_cusno 
		LEFT JOIN qcrptdtl on qrh_tmprptno = qrd_tmprptno 
		where  qrh_tmprptno  =  @TmpRPTNo

END

GO
GRANT EXECUTE ON [dbo].[sp_select_qcrpthdr] TO [ERPUSER] AS [dbo]
GO
