/****** Object:  StoredProcedure [dbo].[sp_insert_QCVENINF_QCM00001]    Script Date: 09/29/2017 15:29:09 ******/
DROP PROCEDURE [dbo].[sp_insert_QCVENINF_QCM00001]
GO
/****** Object:  StoredProcedure [dbo].[sp_insert_QCVENINF_QCM00001]    Script Date: 09/29/2017 15:29:09 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO


Create  PROCEDURE [dbo].[sp_insert_QCVENINF_QCM00001]
	@qvi_cocde nvarchar(6), 
	@qvi_qcno nvarchar(20), @qvi_venno nvarchar(6), 
	
	@usr nvarchar(30)
AS
BEGIN

	-- cnttyp of addr must be 'C'
	--CREATE table #TEMP_VENADDR(adr_venno nvarchar(20), tmp_cnttyp nvarchar(10)) on [PRIMARY]
	
	--cnttyp of contact person maybe empty. Order: [QCFA, GENL, SALE]
	Create table #TEMP_VENCNT(cnt_venno nvarchar(20), cnt_cnttyp nvarchar(10)) on [PRIMARY]
	
	INSERT INTO #TEMP_VENCNT
	select top 1 vci_venno, vci_cnttyp
	FROM VNCNTINF
	WHERE vci_cnttyp = 'QCFA'
	and vci_venno = @qvi_venno
	
	if (SELECT COUNT(*) FROM #TEMP_VENCNT) = 0
	begin
		INSERT into #TEMP_VENCNT
		select top 1 vci_venno, vci_cnttyp
		FROM VNCNTINF
		WHERE vci_cnttyp = 'GENL'
		AND vci_venno = @qvi_venno
		
		if(SELECT count(*) from #TEMP_VENCNT) = 0
		BEGIN
			INSERT INTO #TEMP_VENCNT
			select top 1 vci_venno, vci_cnttyp
			FROM VNCNTINF
			WHERE vci_cnttyp = 'SALE'
			AND vci_venno = @qvi_venno
		END
	end

	Insert into QCVENINF (
		--KEY
		qvi_cocde, qvi_qcno, qvi_venno,
		
		--Vendor Info
		qvi_adr, qvi_cty, qvi_stt, qvi_city, qvi_town, qvi_zip, 
		
		--Contact Info
		qvi_cntctp, qvi_cnttil, qvi_cntphn, qvi_cntfax, qvi_cnteml,
		
		qvi_creusr, qvi_updusr
	)
	SELECT top 1
		@qvi_cocde, @qvi_qcno, @qvi_venno,
		
		isnull(chi.vci_adr, ''), isnull(chi.vci_cty,''), isnull(chi.vci_stt,''), isnull(chi.vci_city,''), isnull(chi.vci_town,''), isnull(chi.vci_zip, ''), 

		isnull(qcfa.vci_cntctp, ''), isnull(qcfa.vci_cnttil, ''), isnull(qcfa.vci_cntphn, ''), isnull(qcfa.vci_cntfax, ''), isnull(qcfa.vci_cnteml, ''), 
		
		@usr, @usr
	FROM VNCNTINF chi
	LEFT JOIN #TEMP_VENCNT 
		ON chi.vci_venno = cnt_venno
	--LEFT JOIN VNCNTINF qcfa
		-- ON chi.vci_venno = qcfa.vci_venno
		-- AND qcfa.vci_cnttyp = 'QCFA'
	LEFT JOIN VNCNTINF qcfa
		ON cnt_venno = qcfa.vci_venno 
		AND cnt_cnttyp = qcfa.vci_cnttyp
	WHERE chi.vci_venno = @qvi_venno
	and chi.vci_cnttyp = 'C'
	
END


GO
GRANT EXECUTE ON [dbo].[sp_insert_QCVENINF_QCM00001] TO [ERPUSER] AS [dbo]
GO
