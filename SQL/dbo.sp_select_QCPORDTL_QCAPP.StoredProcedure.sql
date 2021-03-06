/****** Object:  StoredProcedure [dbo].[sp_select_QCPORDTL_QCAPP]    Script Date: 09/29/2017 15:29:09 ******/
DROP PROCEDURE [dbo].[sp_select_QCPORDTL_QCAPP]
GO
/****** Object:  StoredProcedure [dbo].[sp_select_QCPORDTL_QCAPP]    Script Date: 09/29/2017 15:29:10 ******/
SET ANSI_NULLS OFF
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[sp_select_QCPORDTL_QCAPP]
	
AS
BEGIN


declare @TMP_PONO table (
id     int identity(1,1),
PONO nvarchar(20)
)

insert into @TMP_PONO (PONO)
select distinct qpd_purord from QCREQDTL LEFT JOIN QCREQHDR on qcd_qcno = qch_qcno
LEFT JOIN QCPORDTL on qcd_purord = qpd_purord 
where 

qch_inspweek > DATEPART(wk,GETDATE()) -3 and qch_inspyear = YEAR(GETDATE())



SELECT
	qpd_cocde
	,qpd_qcno
	,qpd_qcposeq
	,qpd_purord
	,qpd_del
	,qpd_verdoc
	,qpd_mon
	,qpd_tue
	,qpd_wed
	,qpd_thur
	,qpd_fri
	,qpd_sat
	,qpd_sun
	,qpd_rmk
	,qpd_schmon
	,qpd_schtue
	,qpd_schwed
	,qpd_schthur
	,qpd_schfri
	,qpd_schsat
	,qpd_schsun
	,qpd_person
	,qpd_creusr
	,qpd_updusr
	,convert(char, qpd_credat,120) qpd_credat
	,convert(char, qpd_upddat,120) qpd_upddat
FROM QCPORDTL
LEFT JOIN QCREQHDR 
	ON qch_cocde = qpd_cocde
	AND qch_qcno = qpd_qcno
left join @TMP_PONO tmp
ON tmp.PONO = qpd_purord

WHERE qch_qcsts = 'REL' and tmp.PONO is not null

	
	
END






SET QUOTED_IDENTIFIER OFF 

GO
GRANT EXECUTE ON [dbo].[sp_select_QCPORDTL_QCAPP] TO [ERPUSER] AS [dbo]
GO
