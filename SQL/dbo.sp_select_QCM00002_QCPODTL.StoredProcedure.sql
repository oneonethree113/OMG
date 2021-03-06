/****** Object:  StoredProcedure [dbo].[sp_select_QCM00002_QCPODTL]    Script Date: 09/29/2017 15:29:09 ******/
DROP PROCEDURE [dbo].[sp_select_QCM00002_QCPODTL]
GO
/****** Object:  StoredProcedure [dbo].[sp_select_QCM00002_QCPODTL]    Script Date: 09/29/2017 15:29:10 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO

Create  PROCEDURE [dbo].[sp_select_QCM00002_QCPODTL]
	@cocde nvarchar(10),
	@flg_empty char(1),
	@QCNo nvarchar(20)
AS
BEGIN
	IF @flg_empty=''
	BEGIN
		SELECT 
		
			--QCREQHDR
			qch_inspyear, qch_inspweek, qch_insptyp, 
		
			--QCPORDTL
			qpd_cocde, qpd_qcno, qpd_qcposeq, qpd_purord, qpd_del, 
			qpd_mon, qpd_tue, qpd_wed, qpd_thur, qpd_fri, qpd_sat, qpd_sun, qpd_rmk, 
			
			--POORDHDR
			poh_cocde, poh_purord, poh_ordno, 
			poh_credat = convert(char, poh_credat, 101), --poh_credat is Iss Date 
			poh_issdat = convert(char, poh_issdat, 101), --poh_issdat is Rev Date
			poh_venno, poh_cuspno, poh_reppno, 
			poh_shpstr = convert(char, poh_shpstr,101),
			poh_shpend = convert(char, poh_shpend,101),	
			poh_rmk,
			
			--20151023
			poh_prmcus, poh_seccus, 
			view_prmcus = pri.cbi_cussna, 
			view_seccus = sec.cbi_cussna,
			view_vensna = vbi_vensna,
			view_inspweek = "",
			
			qpd_ctrlstate = "",
			qpd_act = ""
			
		FROM QCREQHDR
		LEFT JOIN QCPORDTL
			on qch_qcno = qpd_qcno
		LEFT JOIN POORDHDR
			on qpd_purord = poh_purord
		LEFT JOIN CUBASINF pri
			on qch_prmcus = pri.cbi_cusno
		LEFT JOIN CUBASINF sec
			on qch_seccus = sec.cbi_cusno
		LEFT JOIN VNBASINF
			on qch_venno = vbi_venno
		WHERE	
			--qch_cocde = @cocde  AND 
			qpd_qcno = @QCNo
		AND poh_purord is not NULL
		AND qpd_del <> 'Y'
	END
	ELSE
	BEGIN
		SELECT 
			--QCREQHDR
			qch_inspyear=0, qch_inspweek=0, qch_insptyp='', 
		
			--QCPORDTL
			qpd_cocde='', qpd_qcno='', qpd_qcposeq=0, qpd_purord='', qpd_del='', 
			qpd_mon='', qpd_tue='', qpd_wed='', qpd_thur='', qpd_fri='', qpd_sat='', qpd_sun='', qpd_rmk='', 
			
			--POORDHDR
			poh_cocde='', poh_purord='', poh_ordno='', 
			poh_credat = '',
			poh_issdat = '',
			poh_venno='', poh_cuspno='', poh_reppno='', 
			poh_shpstr = '',
			poh_shpend = '',
			poh_rmk='',
			
			poh_prmcus='', poh_seccus='', 
			view_prmcus = '',
			view_seccus = '',
			view_vensna = '',
			view_inspweek = '', 
			
			
			qpd_ctrlstate = "ADD",
			qpd_act = ""
	
	END



END

GO
GRANT EXECUTE ON [dbo].[sp_select_QCM00002_QCPODTL] TO [ERPUSER] AS [dbo]
GO
