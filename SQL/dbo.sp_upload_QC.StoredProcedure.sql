/****** Object:  StoredProcedure [dbo].[sp_upload_QC]    Script Date: 09/29/2017 15:29:08 ******/
DROP PROCEDURE [dbo].[sp_upload_QC]
GO
/****** Object:  StoredProcedure [dbo].[sp_upload_QC]    Script Date: 09/29/2017 15:29:10 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO

Create  PROCEDURE [dbo].[sp_upload_QC]
	@qch_qcno nvarchar(20),
	@cur_time datetime
AS 
BEGIN

	--Insert to #TMP_QC Start
	CREATE table #TMP_QC(
		[tmp_qcno] nvarchar(20), 
		[tmp_qcseq] int, 
		[tmp_qcposeq] int
	)
	
	DECLARE @tmp_qcno nvarchar(20)
	DECLARE @tmp_qcseq int
	DECLARE @tmp_qcposeq int
	
	INSERT INTO #TMP_QC(
	tmp_qcno, tmp_qcseq, tmp_qcposeq
	)
	SELECT DISTINCT
		dtl.qcd_qcno, dtl.qcd_qcseq, dtl.qcd_qcposeq
	FROM dbo.QCREQDTL dtl
	LEFT JOIN dbo.QCREQHDR hdr
	ON dtl.qcd_qcno = hdr.qch_qcno
	WHERE qcd_qcno = @qch_qcno
	--WHERE hdr.qch_qcsts = 'REL'
	--AND hdr.qch_credat > CONVERT(date, GETDATE())
	
	--Insert to #TMP_QC End
	
	--Insert to QCREQHDR Start
	
	IF EXISTS(SELECT qch_qcno FROM [UCPDEV_WEB].[dbo].[QCREQHDR] WHERE qch_qcno = @qch_qcno)
	BEGIN
		UPDATE [UCPDEV_WEB].[dbo].[QCREQHDR]
		SET 
		[qch_cocde] = hdr.qch_cocde,
		[qch_qcno] = hdr.qch_qcno,
		[qch_qcsts] = hdr.qch_qcsts,
		[qch_flgautogen] = hdr.qch_flgautogen,
		[qch_verno] = hdr.qch_verno,
		[qch_venno] = hdr.qch_venno,
		[qch_prmcus] = hdr.qch_prmcus,
		[qch_seccus] = hdr.qch_seccus,
		[qch_inspyear] = hdr.qch_inspyear,
		[qch_inspweek] = hdr.qch_inspweek,
		[qch_insptyp] = hdr.qch_insptyp,
		[qch_cydate] = hdr.qch_cydate,
		[qch_sidate] = hdr.qch_sidate,
		[qch_mon] = hdr.qch_mon,
		[qch_tue] = hdr.qch_tue,
		[qch_wed] = hdr.qch_wed,
		[qch_thur] = hdr.qch_thur,
		[qch_fri] = hdr.qch_fri,
		[qch_sat] = hdr.qch_sat,
		[qch_sun] = hdr.qch_sun,
		[qch_rmk] = hdr.qch_rmk,
		[qch_schmon] = hdr.qch_schmon,
		[qch_schtue] = hdr.qch_schtue,
		[qch_schwed] = hdr.qch_schwed,
		[qch_schthur] = hdr.qch_schthur,
		[qch_schfri] = hdr.qch_schfri,
		[qch_schsat] = hdr.qch_schsat,
		[qch_schsun] = hdr.qch_schsun,
		[qch_person] = hdr.qch_person,
		[qch_flgupload] = hdr.qch_flgupload,
		[qch_uploadat] = @cur_time,
		[qch_creusr] = hdr.qch_creusr,
		[qch_updusr] = hdr.qch_updusr,
		[qch_credat] = hdr.qch_credat,
		[qch_upddat] = hdr.qch_upddat
		FROM dbo.QCREQHDR hdr
		INNER JOIN [UCPDEV_WEB].[dbo].[QCREQHDR] hdr2
		ON 
			hdr.qch_qcno = hdr2.qch_qcno
		WHERE 
			hdr.qch_qcno = @qch_qcno
	END
	Else
	BEGIN
		INSERT INTO [UCPDEV_WEB].[dbo].[QCREQHDR]
           ([qch_cocde]
           ,[qch_qcno]
           ,[qch_qcsts]
           ,[qch_flgautogen]
           ,[qch_verno]
           ,[qch_venno]
           ,[qch_prmcus]
           ,[qch_seccus]
           ,[qch_inspyear]
           ,[qch_inspweek]
           ,[qch_insptyp]
           ,[qch_cydate]
           ,[qch_sidate]
           ,[qch_mon]
           ,[qch_tue]
           ,[qch_wed]
           ,[qch_thur]
           ,[qch_fri]
           ,[qch_sat]
           ,[qch_sun]
           ,[qch_rmk]
           ,[qch_schmon]
           ,[qch_schtue]
           ,[qch_schwed]
           ,[qch_schthur]
           ,[qch_schfri]
           ,[qch_schsat]
           ,[qch_schsun]
           ,[qch_person]
           ,[qch_flgupload]
           ,[qch_uploadat]
           ,[qch_creusr]
           ,[qch_updusr]
           ,[qch_credat]
           ,[qch_upddat])
		SELECT
           hdr.qch_cocde,
           hdr.qch_qcno,
           hdr.qch_qcsts,
           hdr.qch_flgautogen,
           hdr.qch_verno,
           hdr.qch_venno,
           hdr.qch_prmcus,
           hdr.qch_seccus,
           hdr.qch_inspyear,
           hdr.qch_inspweek,
           hdr.qch_insptyp,
           hdr.qch_cydate,
           hdr.qch_sidate,
           hdr.qch_mon,
           hdr.qch_tue,
           hdr.qch_wed,
           hdr.qch_thur,
           hdr.qch_fri,
           hdr.qch_sat,
           hdr.qch_sun,
           hdr.qch_rmk,
           hdr.qch_schmon,
           hdr.qch_schtue,
           hdr.qch_schwed,
           hdr.qch_schthur,
           hdr.qch_schfri,
           hdr.qch_schsat,
           hdr.qch_schsun,
           hdr.qch_person,
           hdr.qch_flgupload,
           @cur_time,
           hdr.qch_creusr,
           hdr.qch_updusr,
           hdr.qch_credat,
           hdr.qch_upddat
		FROM dbo.QCREQHDR as hdr
		WHERE 
		hdr.qch_qcno = @qch_qcno
	END
		
	--Insert to QCREQHDR End
	
	--Insert to QCVENINF Start
	IF EXISTS(SELECT qvi_qcno FROM [UCPDEV_WEB].[dbo].[QCVENINF] WHERE qVI_qcno = @qch_qcno)
	BEGIN
		UPDATE [UCPDEV_WEB].[dbo].[QCVENINF]
		SET [qvi_qcno] = ven.qvi_qcno
		  ,[qvi_venno] = ven.qvi_venno
		  ,[qvi_adr] = ven.qvi_adr
		  ,[qvi_cty] = ven.qvi_cty
		  ,[qvi_stt] = ven.qvi_stt
		  ,[qvi_city] = ven.qvi_city
		  ,[qvi_town] = ven.qvi_town
		  ,[qvi_zip] = ven.qvi_zip
		  ,[qvi_creusr] = ven.qvi_creusr
		  ,[qvi_updusr] = ven.qvi_updusr
		  ,[qvi_credat] = ven.qvi_credat
		  ,[qvi_upddat] = ven.qvi_upddat
		FROM dbo.QCVENINF ven
		INNER JOIN [UCPDEV_WEB].[dbo].[QCVENINF] ven2
		ON 
			ven.qvi_qcno = ven2.qvi_qcno
		WHERE 
			ven.qvi_qcno = @qch_qcno
	
	END
	ELSE
	BEGIN
		INSERT INTO [UCPDEV_WEB].[dbo].[QCVENINF]
			   ([qvi_qcno]
			   ,[qvi_venno]
			   ,[qvi_adr]
			   ,[qvi_cty]
			   ,[qvi_stt]
			   ,[qvi_city]
			   ,[qvi_town]
			   ,[qvi_zip]
			   ,[qvi_creusr]
			   ,[qvi_updusr]
			   ,[qvi_credat]
			   ,[qvi_upddat])
		SELECT
			   ven.qvi_qcno
			   ,ven.qvi_venno
			   ,ven.qvi_adr
			   ,ven.qvi_cty
			   ,ven.qvi_stt
			   ,ven.qvi_city
			   ,ven.qvi_town
			   ,ven.qvi_zip
			   ,ven.qvi_creusr
			   ,ven.qvi_updusr
			   ,ven.qvi_credat
			   ,ven.qvi_upddat
		FROM dbo.QCVENINF ven
		WHERE ven.qvi_qcno = @qch_qcno
	END
	
	--Insert to QCVENINF End
	
	--Insert to QCPORDTL Start
	DECLARE TMP_CURSOR CURSOR FOR
		SELECT DISTINCT tmp_qcno, tmp_qcposeq FROM #TMP_QC
		WHERE tmp_qcposeq <> 0	--when 0, it is IM Detail
	
	OPEN TMP_CURSOR
	FETCH NEXT FROM TMP_CURSOR INTO @tmp_qcno, @tmp_qcposeq
	
	WHILE @@FETCH_STATUS = 0
	BEGIN
		IF EXISTS(SELECT qpd_qcno FROM [UCPDEV_WEB].[dbo].[QCPORDTL] WHERE qpd_qcno = @tmp_qcno AND qpd_qcposeq = @tmp_qcposeq)
		BEGIN
			UPDATE [UCPDEV_WEB].[dbo].[QCPORDTL]
			SET [qpd_cocde] = po.qpd_cocde
			  ,[qpd_qcno] = po.qpd_qcno
			  ,[qpd_qcposeq] = po.qpd_qcposeq
			  ,[qpd_purord] = po.qpd_purord
			  ,[qpd_del] = po.qpd_del
			  ,[qpd_mon] = po.qpd_mon
			  ,[qpd_tue] = po.qpd_tue
			  ,[qpd_wed] = po.qpd_wed
			  ,[qpd_thur] = po.qpd_thur
			  ,[qpd_fri] = po.qpd_fri
			  ,[qpd_sat] = po.qpd_sat
			  ,[qpd_sun] = po.qpd_sun
			  ,[qpd_rmk] = po.qpd_rmk
			  ,[qpd_schmon] = po.qpd_schmon
			  ,[qpd_schtue] = po.qpd_schtue
			  ,[qpd_schwed] = po.qpd_schwed
			  ,[qpd_schthur] = po.qpd_schthur
			  ,[qpd_schfri] = po.qpd_schfri
			  ,[qpd_schsat] = po.qpd_schsat
			  ,[qpd_schsun] = po.qpd_schsun
			  ,[qpd_person] = po.qpd_person
			  ,[qpd_creusr] = po.qpd_creusr
			  ,[qpd_updusr] = po.qpd_updusr
			  ,[qpd_credat] = po.qpd_credat
			  ,[qpd_upddat] = po.qpd_upddat
			FROM dbo.QCPORDTL po
			INNER JOIN [UCPDEV_WEB].[dbo].[QCPORDTL] po2
			ON po.qpd_qcno = po2.qpd_qcno 
			AND po.qpd_qcposeq = po2.qpd_qcposeq
			WHERE
				po.qpd_qcno = @tmp_qcno
			AND po.qpd_qcposeq = @tmp_qcposeq
		END
		ELSE
		BEGIN
			INSERT INTO [UCPDEV_WEB].[dbo].[QCPORDTL]
           ([qpd_cocde]
           ,[qpd_qcno]
           ,[qpd_qcposeq]
           ,[qpd_purord]
           ,[qpd_del]
           ,[qpd_mon]
           ,[qpd_tue]
           ,[qpd_wed]
           ,[qpd_thur]
           ,[qpd_fri]
           ,[qpd_sat]
           ,[qpd_sun]
           ,[qpd_rmk]
           ,[qpd_schmon]
           ,[qpd_schtue]
           ,[qpd_schwed]
           ,[qpd_schthur]
           ,[qpd_schfri]
           ,[qpd_schsat]
           ,[qpd_schsun]
           ,[qpd_person]
           ,[qpd_creusr]
           ,[qpd_updusr]
           ,[qpd_credat]
           ,[qpd_upddat])
			SELECT
           po.qpd_cocde
           ,po.qpd_qcno
           ,po.qpd_qcposeq
           ,po.qpd_purord
           ,po.qpd_del
           ,po.qpd_mon
           ,po.qpd_tue
           ,po.qpd_wed
           ,po.qpd_thur
           ,po.qpd_fri
           ,po.qpd_sat
           ,po.qpd_sun
           ,po.qpd_rmk
           ,po.qpd_schmon
           ,po.qpd_schtue
           ,po.qpd_schwed
           ,po.qpd_schthur
           ,po.qpd_schfri
           ,po.qpd_schsat
           ,po.qpd_schsun
           ,po.qpd_person
           ,po.qpd_creusr
           ,po.qpd_updusr
           ,po.qpd_credat
           ,po.qpd_upddat
		   FROM dbo.QCPORDTL po
		   WHERE po.qpd_qcno = @tmp_qcno
		   AND po.qpd_qcposeq = @tmp_qcposeq
		   

		END
		
		FETCH NEXT FROM TMP_CURSOR INTO @tmp_qcno, @tmp_qcposeq
		
	END
	
	CLOSE TMP_CURSOR
	DEALLOCATE TMP_CURSOR
	
	--Insert to QCPORDTL End
	
	
	--Insert to QCREQDTL Start


	DECLARE TMP_CURSOR CURSOR FOR
		SELECT DISTINCT tmp_qcno, tmp_qcseq FROM #TMP_QC
		
	OPEN TMP_CURSOR
	FETCH NEXT FROM TMP_CURSOR INTO @tmp_qcno, @tmp_qcseq
	
	WHILE @@FETCH_STATUS = 0
	BEGIN
		IF EXISTS(SELECT qcd_qcno FROM [UCPDEV_WEB].[dbo].[QCREQDTL] WHERE qcd_qcno = @tmp_qcno AND qcd_qcseq = @tmp_qcseq)
		BEGIN
			UPDATE [UCPDEV_WEB].[dbo].[QCREQDTL]
			SET 
				[qcd_cocde] = dtl.qcd_cocde,
				[qcd_qcno] = dtl.qcd_qcno,
				[qcd_qcseq] = dtl.qcd_qcseq,
				[qcd_dtlsts] = dtl.qcd_dtlsts,
				[qcd_genby] = dtl.qcd_genby,
				[qcd_flgpolink] = dtl.qcd_flgpolink,
				[qcd_qcposeq] = dtl.qcd_qcposeq,
				[qcd_purord] = dtl.qcd_purord,
				[qcd_purseq] = dtl.qcd_purseq,
				[qcd_mon] = dtl.qcd_mon,
				[qcd_tue] = dtl.qcd_tue,
				[qcd_wed] = dtl.qcd_wed,
				[qcd_thur] = dtl.qcd_thur,
				[qcd_fri] = dtl.qcd_fri,
				[qcd_sat] = dtl.qcd_sat,
				[qcd_sun] = dtl.qcd_sun,
				[qcd_samhdl] = dtl.qcd_samhdl,
				[qcd_sidate] = dtl.qcd_sidate,
				[qcd_cydate] = dtl.qcd_cydate,
				[qcd_rmk] = dtl.qcd_rmk,
				[qcd_xitmno] = dtl.qcd_xitmno,
				[qcd_xitmdsc] = dtl.qcd_xitmdsc,
				[qcd_xcolor] = dtl.qcd_xcolor,
				[qcd_xpack] = dtl.qcd_xpack,
				[qcd_xmtrdcm] = dtl.qcd_xmtrdcm,
				[qcd_xmtrwcm] = dtl.qcd_xmtrwcm,
				[qcd_xmtrhcm] = dtl.qcd_xmtrhcm,
				[qcd_xinrdcm] = dtl.qcd_xinrdcm,
				[qcd_xinrwcm] = dtl.qcd_xinrwcm,
				[qcd_xinrhcm] = dtl.qcd_xinrhcm,
				[qcd_xgrswgt] = dtl.qcd_xgrswgt,
				[qcd_xnetwgt] = dtl.qcd_xnetwgt,
				[qcd_ordqty] = dtl.qcd_ordqty,
				[qcd_schmon] = dtl.qcd_schmon,
				[qcd_schtue] = dtl.qcd_schtue,
				[qcd_schwed] = dtl.qcd_schwed,
				[qcd_schthur] = dtl.qcd_schthur,
				[qcd_schfri] = dtl.qcd_schfri,
				[qcd_schsat] = dtl.qcd_schsat,
				[qcd_schsun] = dtl.qcd_schsun,
				[qcd_person] = dtl.qcd_person,
				[qcd_schdat] = dtl.qcd_schdat,
				[qcd_pid] = dtl.qcd_pid,
				[qcd_creusr] = dtl.qcd_creusr,
				[qcd_updusr] = dtl.qcd_updusr,
				[qcd_credat] = dtl.qcd_credat,
				[qcd_upddat] = dtl.qcd_upddat
			FROM dbo.QCREQDTL dtl
			INNER JOIN [UCPDEV_WEB].[dbo].[QCREQDTL] dtl2
			ON 
				dtl.qcd_qcno = dtl2.qcd_qcno
			AND dtl.qcd_qcseq = dtl2.qcd_qcseq
			WHERE 
				dtl.qcd_qcno = @tmp_qcno
			AND dtl.qcd_qcseq = @tmp_qcseq
		END
		ELSE
		BEGIN
			INSERT INTO [UCPDEV_WEB].[dbo].[QCREQDTL]
			   ([qcd_cocde]
			   ,[qcd_qcno]
			   ,[qcd_qcseq]
			   ,[qcd_dtlsts]
			   ,[qcd_genby]
			   ,[qcd_flgpolink]
			   ,[qcd_qcposeq]
			   ,[qcd_purord]
			   ,[qcd_purseq]
			   ,[qcd_mon]
			   ,[qcd_tue]
			   ,[qcd_wed]
			   ,[qcd_thur]
			   ,[qcd_fri]
			   ,[qcd_sat]
			   ,[qcd_sun]
			   ,[qcd_samhdl]
			   ,[qcd_sidate]
			   ,[qcd_cydate]
			   ,[qcd_rmk]
			   ,[qcd_xitmno]
			   ,[qcd_xitmdsc]
			   ,[qcd_xcolor]
			   ,[qcd_xpack]
			   ,[qcd_xmtrdcm]
			   ,[qcd_xmtrwcm]
			   ,[qcd_xmtrhcm]
			   ,[qcd_xinrdcm]
			   ,[qcd_xinrwcm]
			   ,[qcd_xinrhcm]
			   ,[qcd_xgrswgt]
			   ,[qcd_xnetwgt]
			   ,[qcd_ordqty]
			   ,[qcd_schmon]
			   ,[qcd_schtue]
			   ,[qcd_schwed]
			   ,[qcd_schthur]
			   ,[qcd_schfri]
			   ,[qcd_schsat]
			   ,[qcd_schsun]
			   ,[qcd_person]
			   ,[qcd_schdat]
			   ,[qcd_pid]
			   ,[qcd_creusr]
			   ,[qcd_updusr]
			   ,[qcd_credat]
			   ,[qcd_upddat])
			SELECT
				dtl.qcd_cocde
			   ,dtl.qcd_qcno
			   ,dtl.qcd_qcseq
			   ,dtl.qcd_dtlsts
			   ,dtl.qcd_genby
			   ,dtl.qcd_flgpolink
			   ,dtl.qcd_qcposeq
			   ,dtl.qcd_purord
			   ,dtl.qcd_purseq
			   ,dtl.qcd_mon
			   ,dtl.qcd_tue
			   ,dtl.qcd_wed
			   ,dtl.qcd_thur
			   ,dtl.qcd_fri
			   ,dtl.qcd_sat
			   ,dtl.qcd_sun
			   ,dtl.qcd_samhdl
			   ,dtl.qcd_sidate
			   ,dtl.qcd_cydate
			   ,dtl.qcd_rmk
			   ,dtl.qcd_xitmno
			   ,dtl.qcd_xitmdsc
			   ,dtl.qcd_xcolor
			   ,dtl.qcd_xpack
			   ,dtl.qcd_xmtrdcm
			   ,dtl.qcd_xmtrwcm
			   ,dtl.qcd_xmtrhcm
			   ,dtl.qcd_xinrdcm
			   ,dtl.qcd_xinrwcm
			   ,dtl.qcd_xinrhcm
			   ,dtl.qcd_xgrswgt
			   ,dtl.qcd_xnetwgt
			   ,dtl.qcd_ordqty
			   ,dtl.qcd_schmon
			   ,dtl.qcd_schtue
			   ,dtl.qcd_schwed
			   ,dtl.qcd_schthur
			   ,dtl.qcd_schfri
			   ,dtl.qcd_schsat
			   ,dtl.qcd_schsun
			   ,dtl.qcd_person
			   ,dtl.qcd_schdat
			   ,dtl.qcd_pid
			   ,dtl.qcd_creusr
			   ,dtl.qcd_updusr
			   ,dtl.qcd_credat
			   ,dtl.qcd_upddat
			FROM dbo.QCREQDTL dtl
			WHERE 
				dtl.qcd_qcno = @tmp_qcno 
			AND dtl.qcd_qcseq = @tmp_qcseq	
		END
		
		FETCH NEXT FROM TMP_CURSOR INTO @tmp_qcno, @tmp_qcseq
	END
	
	CLOSE TMP_CURSOR
	DEALLOCATE TMP_CURSOR
	----Insert to QCREQDTL End	
	
	

END

GO
GRANT EXECUTE ON [dbo].[sp_upload_QC] TO [ERPUSER] AS [dbo]
GO
