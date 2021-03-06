/****** Object:  StoredProcedure [dbo].[sp_list_QCRPTHDR_shipapprv]    Script Date: 09/29/2017 15:29:09 ******/
DROP PROCEDURE [dbo].[sp_list_QCRPTHDR_shipapprv]
GO
/****** Object:  StoredProcedure [dbo].[sp_list_QCRPTHDR_shipapprv]    Script Date: 09/29/2017 15:29:10 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
------
CREATE PROCEDURE [dbo].[sp_list_QCRPTHDR_shipapprv]
	@qctype nvarchar(15),
	@rptdatefm nvarchar(10),
	@rptdateto nvarchar(10),
	@fano nvarchar(12),
	@custno nvarchar(6)
AS 
BEGIN
	SELECT CONVERT(CHAR(10), qrh_inspdat, 101) date,
	qrh_tmprptno reportNo,
	qrh_shipapprv shipapprv,
	qrh_finalstatus as 'fsts',
	case when qrh_rpttyp = 'F' then 'Final' 
	when qrh_rpttyp =  'I' then 'In-Line' else '-' end qcType,
	qrh_rptstatus qrh_rptstatus, 
 
 qrd_inspresult as  'rst',

	vbi_Vensna factory,
	case when secCust.cbi_cussna IS NULL OR secCust.cbi_cussna = '' then priCust.cbi_cussna else secCust.cbi_cussna end as 'customer',
	qrh_qcno requestNo,
	qrh_postr po,
	qrh_itmno ucpItem,
	qrh_cuspostr custPo,
	qrh_cusitm custItem , 
	qrh_retmsg qrh_retmsg
	from
	QCRPTHDR QCH LEFT JOIN  
	VNBASINF ON qrh_venno = vbi_venno LEFT JOIN 
	CUBASINF priCust on qrh_cus1no = priCust.cbi_cusno LEFT JOIN 
	CUBASINF secCust on qrh_cus2no = secCust.cbi_cusno LEFT JOIN
	qcrptdtl on qrh_tmprptno = qrd_tmprptno
	where (qrh_rpttyp = @qctype OR @qctype = '') AND 
	qrh_credat BETWEEN convert(datetime, @rptdatefm, 103) AND convert(datetime, @rptdateto, 103) AND
	(qrh_venno = @fano OR @fano = 'ALL') AND 
	((qrh_cus1no = @custno OR @custno = 'ALL') OR (qrh_cus2no = @custno OR @custno = 'ALL'))
and qrh_finalstatus like '%PASS%'
and qrh_rpttyp = 'F'
END



GO
GRANT EXECUTE ON [dbo].[sp_list_QCRPTHDR_shipapprv] TO [ERPUSER] AS [dbo]
GO
