/****** Object:  StoredProcedure [dbo].[sp_select_QCM00002]    Script Date: 09/29/2017 15:29:09 ******/
DROP PROCEDURE [dbo].[sp_select_QCM00002]
GO
/****** Object:  StoredProcedure [dbo].[sp_select_QCM00002]    Script Date: 09/29/2017 15:29:10 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO

CREATE  PROCEDURE [dbo].[sp_select_QCM00002]
	@cocde nvarchar(10),
	@flg_empty char(1),
	@QCNo nvarchar(20)
AS
BEGIN

	IF @flg_empty = ""
	BEGIN
		SELECT 
			--QCREQHDR
			qch_cocde, qch_qcno, qch_qcsts, 
			qch_inspyear, qch_inspweek, qch_insptyp,
			--QCREQDTL
			qcd_cocde, qcd_qcno, qcd_qcseq, 
			qcd_dtlsts,  qcd_genby, 
			qcd_genby, qcd_samhdl, qcd_rmk,
			qcd_flgpolink, qcd_qcposeq, qcd_purord, qcd_purseq, 
			qcd_mon, qcd_tue, qcd_wed, qcd_thur, qcd_fri, qcd_sat, qcd_sun,
			qcd_samhdl, 
			--qcd_sidate =case convert(char, qcd_sidate, 101) when '01/01/1900' then '' else convert(char, qcd_sidate, 101) end,
			--qcd_cydate =case convert(char, qcd_cydate, 101) when '01/01/1900' then '' else convert(char, qcd_cydate, 101) end,
			
			qcd_schdat = case convert(char, qcd_schdat, 101) when '01/01/1900' then '' else convert(char, qcd_schdat, 101) end,
			
			qcd_purord, qcd_purseq, 
			
			--QCREQDTL IM part
			qcd_xitmno, qcd_xitmdsc, qcd_xcolor, qcd_xpack, 
			qcd_xmtrdcm, qcd_xmtrwcm, qcd_xmtrhcm, 
			qcd_xinrdcm, qcd_xinrwcm, qcd_xinrhcm, 
			qcd_xgrswgt, qcd_xnetwgt, qcd_ordqty, 
			
			--POORDHDR
			poh_purord, 
			poh_ordno, --SC No
			poh_pursts, 
			poh_credat = convert(char, poh_credat, 101), --poh_credat is Iss Date 
			poh_issdat = convert(char, poh_issdat, 101), --poh_issdat is Rev Date
			poh_venno, 
			poh_cuspno, poh_reppno,
			poh_shpstr = convert(char, poh_shpstr,101),
			poh_shpend = convert(char, poh_shpend,101),	
			poh_rmk,
			--POORDDTL
			pod_purseq,
			pod_itmno, 
			pod_jobord,
			pod_prdven, pod_tradeven, pod_examven,
			pod_venitm, pod_cusitm, pod_seccusitm, pod_cussku,
			pod_engdsc, pod_chndsc, 
			pod_vencol, pod_cuscol, pod_coldsc, pod_pckitr,
			
			pod_untcde, pod_inrctn, pod_mtrctn, pod_cubcft, 
			pod_ordqty, pod_cuspno, pod_respno, 
			pod_candat, 
			pod_shpstr = convert(char, pod_shpstr, 101),
			pod_shpend = convert(char, pod_shpend, 101),
			pod_ctnstr, pod_ctnend, pod_ttlctn, 
			pod_rmk,pod_credat, pod_upddat,pod_updusr,
			
			--Display
			view_itmno = case qcd_flgpolink when 'Y' then pod_itmno else qcd_xitmno end,
			view_cuspno = case IsNull(poh_cuspno,'') when '' then pod_cuspno else poh_cuspno end,
			view_prmcus = '', 
			view_seccus = '',
			view_vensna = '', 
			view_inspweek = '', 
			
			--Control
			qcd_ctrlstate = "",
			"DEL" = ""
			
			
		FROM QCREQHDR
		LEFT JOIN QCREQDTL
			ON qch_qcno = qcd_qcno
		
		LEFT JOIN POORDDTL 
			ON qcd_purord = pod_purord
			AND qcd_purseq = pod_purseq
		LEFT JOIN POORDHDR
			on pod_purord = poh_purord
		WHERE	
			--qch_cocde = @cocde  AND 
			qcd_qcno = @QCNo
		AND qcd_dtlsts <> 'DEL'
	END
	ELSE
	BEGIN
		SELECT 
			--QCREQHDR
			qch_cocde='', qch_qcno='', qch_qcsts='',  
			qch_inspyear=0, qch_inspweek=0, qch_insptyp='', 
			--QCREQDTL
			qcd_cocde='', qcd_qcno='', qcd_qcseq='', 
			qcd_dtlsts='',  qcd_genby='', 
			qcd_genby='', qcd_samhdl='', qcd_rmk='',
			qcd_flgpolink='', qcd_qcposeq=0, qcd_purord='', qcd_purseq=0, 
			qcd_mon='', qcd_tue='', qcd_wed='', qcd_thur='', qcd_fri='', qcd_sat='', qcd_sun='', 
			qcd_samhdl='', 
			--qcd_sidate = '',
			--qcd_cydate = '',
			
			qcd_schdat = '',
			
			qcd_purord='', qcd_purseq=0, 
			
			--QCREQDTL IM part
			qcd_xitmno='', qcd_xitmdsc='', qcd_xcolor='', qcd_xpack='', 
			qcd_xmtrdcm=0, qcd_xmtrwcm=0, qcd_xmtrhcm=0, 
			qcd_xinrdcm=0, qcd_xinrwcm=0, qcd_xinrhcm=0, 
			qcd_xgrswgt=0, qcd_xnetwgt=0, qcd_ordqty=0, 
			
			
			--POORDHDR
			poh_purord='', 
			poh_ordno='', --SC No
			poh_pursts='', 
			poh_credat = '',
			poh_issdat = '',
			poh_venno='', 
			poh_cuspno='', poh_reppno='',
			poh_shpstr = '',
			poh_shpend = '', 
			poh_rmk='',
			--POORDDTL
			pod_purseq =0,
			pod_itmno='', 
			pod_jobord='',
			pod_prdven='', pod_tradeven='', pod_examven='',
			pod_venitm='', pod_cusitm='', pod_seccusitm='', pod_cussku='',
			pod_engdsc='', pod_chndsc='', 
			pod_vencol='', pod_cuscol='', pod_coldsc='', pod_pckitr='',
			
			pod_untcde='', pod_inrctn=0, pod_mtrctn=0, pod_cubcft=0, 
			pod_ordqty=0, pod_cuspno='', pod_respno='', 
			pod_candat='', 
			pod_shpstr = '',
			pod_shpend = '',
			pod_ctnstr=0, pod_ctnend=0, pod_ttlctn=0, 
			pod_rmk='',
			
			--Display
			view_itmno = '',
			view_cuspno = '',
			view_prmcus = '', 
			view_seccus = '',
			view_vensna = '', 
			view_inspweek = '', 
			
			
			--Control
			qcd_ctrlstate = "ADD",
			"DEL" = ""
	
	
	
	END
	



END

GO
GRANT EXECUTE ON [dbo].[sp_select_QCM00002] TO [ERPUSER] AS [dbo]
GO
