/****** Object:  StoredProcedure [dbo].[sp_select_QCRPTDTL]    Script Date: 09/29/2017 15:29:09 ******/
DROP PROCEDURE [dbo].[sp_select_QCRPTDTL]
GO
/****** Object:  StoredProcedure [dbo].[sp_select_QCRPTDTL]    Script Date: 09/29/2017 15:29:10 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[sp_select_QCRPTDTL]
	@rptno nvarchar(20)

AS 
BEGIN
	SELECT qrd_tmprptno qrd_tmprptno,
		CONVERT(CHAR(10), qrh_inspdat, 101) date,
		'<a href=file/QCRpt/' + qrh_tmprptno+ '.pdf > ' + qrh_tmprptno  + '</a>'
	as 'qrd_tmprptno_h',

		case when qrh_rpttyp = 'F' then 'Final' 
	when qrh_rpttyp =  'I' then 'In-Line' else '-' end 'type',

	qrh_rptstatus 'sts', 
		qrh_finalstatus as 'fsts',

	qrd_scqty qrd_scqty,
	qrd_scctn qrd_scctn,
	qrd_scunt 	qrd_scunt, 
	qrd_shpqty qrd_shpqty,
	qrd_shpctn qrd_shpctn,
	qrd_shpunt qrd_shpunt,
	qrd_prdqty qrd_prdqty,
	qrd_prdctn qrd_prdctn,
	qrd_prdunt qrd_prdunt,
			case (DATEDIFF(year, qrd_reinspdat, '1970')  ) 
			  WHEN 0 THEN ''
			  else CONVERT(VARCHAR(10), qrd_reinspdat,101)
			  END as 'qrd_reinspdat',
	qrd_resultrmk qrd_resultrmk,
	qrh_shipapprv qrh_shipapprv,
	qrh_cusitm custItem, 
		vbi_Vensna factory 
	 from
	QCRPTDTL 
	left join QCRPThdr
	on qrh_tmprptno = qrd_tmprptno
LEFT JOIN  
	VNBASINF ON qrh_venno = vbi_venno 
		where qrd_tmprptno=@rptno
END




GO
GRANT EXECUTE ON [dbo].[sp_select_QCRPTDTL] TO [ERPUSER] AS [dbo]
GO
