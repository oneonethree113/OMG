/****** Object:  StoredProcedure [dbo].[sp_select_RIR00001]    Script Date: 09/29/2017 15:29:09 ******/
DROP PROCEDURE [dbo].[sp_select_RIR00001]
GO
/****** Object:  StoredProcedure [dbo].[sp_select_RIR00001]    Script Date: 09/29/2017 15:29:10 ******/
SET ANSI_NULLS OFF
GO
SET QUOTED_IDENTIFIER OFF
GO

CREATE PROCEDURE [dbo].[sp_select_RIR00001]
	@cocde nvarchar(6),
	@pricustlist nvarchar(1000),
	@seccustlist nvarchar(1000), 
	@qutnolist nvarchar(1000),
	@qutcredatefrom datetime, 
	@qutcredateto datetime
	
As 
Begin
	SET NOCOUNT ON
	
	CREATE table #TEMP_INIT(tmp_init nvarchar(1000)) on [PRIMARY]
	CREATE table #TEMP_INIT2(tmp_init nvarchar(50)) on [PRIMARY]
	
	CREATE table #TEMP_CUS1NO(tmp_cus1no nvarchar(50)) on [PRIMARY]
	CREATE table #TEMP_CUS2NO(tmp_cus2no nvarchar(50)) on [PRIMARY]
	Create table #TEMP_QUTNO(tmp_qutno nvarchar(50)) on [PRIMARY]
	
	
	DECLARE @token nvarchar(100)
	DECLARE @tmp_fm nvarchar(50)
	DECLARE @tmp_to nvarchar(50)
	
	DECLARE @flg_pricust char(1),
	@flg_seccust char(1),
	@flg_qutno char(1),
	@flg_qutcredate_from char(1),
	@flg_qutcredate_to char(1)
	
	SET @flg_pricust = 'N'
	SET @flg_seccust = 'N'
	SET @flg_qutno = 'N'
	
	if @qutcredatefrom = '01/01/1900'
		SET @flg_qutcredate_from = 'N'
	else
		SET @flg_qutcredate_from = 'Y'
		
	if @qutcredateto = '01/01/2100'	
		SET @flg_qutcredate_to = 'N'
	else
		SET @flg_qutcredate_to = 'Y'

		
	--*** Insert Temp Table Start ***--
	--Pri Cust Start	
	IF ltrim(rtrim(@pricustlist)) <> ''
	BEGIN
		SET @flg_pricust = 'Y'
		--INSERT INTO #TEMP_INIT SELECT * FROM dbo.splitstring("10000~10001, 50100, 2% ")
		INSERT INTO #TEMP_INIT SELECT * FROM dbo.splitstring(@pricustlist)
		--SELECT * FROM #TEMP_INIT
		
		DECLARE c CURSOR FORWARD_ONLY FOR SELECT tmp_init from #TEMP_INIT
		OPEN C
		FETCH NEXT FROM C into @token
		
		WHILE @@FETCH_STATUS = 0 
		BEGIN
			if charindex('~', @token) <> 0
			BEGIN
				SET @tmp_fm = left(@token, charindex('~', @token)-1)
				SET @tmp_to = right(@token, len(@token) - charindex('~', @token))
				INSERT INTO #TEMP_INIT2 SELECT cbi_cusno from CUBASINF WHERE cbi_cusno between @tmp_fm and @tmp_to and cbi_custyp = 'P'
			END
			else
			BEGIN
				INSERT INTO #TEMP_INIT2 SELECT cbi_cusno from CUBASINF WHERE cbi_cusno like @token and cbi_custyp = 'P'
			END
			FETCH NEXT FROM C into @token
		END
		INSERT INTO #TEMP_CUS1NO SELECT distinct tmp_init from #TEMP_INIT2
		--SELECT * FROM #TEMP_CUS1NO
		
		CLOSE C
		DEALLOCATE C
		DELETE FROM #TEMP_INIT
		DELETE FROM #TEMP_INIT2
	END
	--Pri Cust End
	
	--Sec Cust Start
	IF ltrim(rtrim(@seccustlist)) <> ''
	BEGIN
		SET @flg_seccust = 'Y'
		--INSERT INTO #TEMP_INIT SELECT * FROM dbo.splitstring("10000~10001, 50100, 2% ")
		INSERT INTO #TEMP_INIT SELECT * FROM dbo.splitstring(@seccustlist)
		
		DECLARE c CURSOR FORWARD_ONLY FOR SELECT tmp_init from #TEMP_INIT
		OPEN C
		FETCH NEXT FROM C into @token
		
		WHILE @@FETCH_STATUS = 0 
		BEGIN
			if charindex('~', @token) <> 0
			BEGIN
				SET @tmp_fm = left(@token, charindex('~', @token)-1)
				SET @tmp_to = right(@token, len(@token) - charindex('~', @token))
				INSERT INTO #TEMP_INIT2 SELECT cbi_cusno from CUBASINF WHERE cbi_cusno between @tmp_fm and @tmp_to and cbi_custyp = 'S'
			END
			else
			BEGIN
				INSERT INTO #TEMP_INIT2 SELECT cbi_cusno from CUBASINF WHERE cbi_cusno like @token and cbi_custyp = 'S'
			END
			FETCH NEXT FROM C into @token
		END
		INSERT INTO #TEMP_CUS2NO SELECT distinct tmp_init from #TEMP_INIT2
		--SELECT * from #TEMP_CUS2NO
		
		CLOSE C
		DEALLOCATE C
		DELETE FROM #TEMP_INIT
		DELETE FROM #TEMP_INIT2
		--Sec Cust End
	END
	
	--Qut No Start
	IF ltrim(rtrim(@qutnolist)) <> ''
	BEGIN
		SET @flg_qutno = 'Y'
		--INSERT INTO #TEMP_INIT SELECT * FROM dbo.splitstring("10000~10001, 50100, 2% ")
		INSERT INTO #TEMP_INIT SELECT * FROM dbo.splitstring(@qutnolist)
		
		DECLARE c CURSOR FORWARD_ONLY FOR SELECT tmp_init from #TEMP_INIT
		OPEN C
		FETCH NEXT FROM C into @token
		
		WHILE @@FETCH_STATUS = 0 
		BEGIN
			if charindex('~', @token) <> 0
			BEGIN
				SET @tmp_fm = left(@token, charindex('~', @token)-1)
				SET @tmp_to = right(@token, len(@token) - charindex('~', @token))
				INSERT INTO #TEMP_INIT2 SELECT quh_qutno from QUOTNHDR WHERE quh_qutno between @tmp_fm and @tmp_to and quh_qutsts = 'R'
			END
			else
			BEGIN
				INSERT INTO #TEMP_INIT2 SELECT quh_qutno from QUOTNHDR WHERE quh_qutno like @token and quh_qutsts = 'R'
			END
			FETCH NEXT FROM C into @token
		END
		INSERT INTO #TEMP_QUTNO SELECT distinct tmp_init from #TEMP_INIT2

		CLOSE C
		DEALLOCATE C
		DELETE FROM #TEMP_INIT
		DELETE FROM #TEMP_INIT2
	END	
	--Qut No End
	
	--Get Compnay Name
	Declare @compName as nvarchar(100)
	set @compName = 'UNITED CHINESE GROUP'
	if @cocde <> 'UC-G'
	BEGIN
		select @compName = yco_conam from SYCOMINF where yco_cocde = @cocde
	END
	
	SELECT
		qud_qutno, 
		qud_itmno,
		case qud_untcde --assume if no qud_untcde, other is empty >0<
			when '' then ''
			else qud_untcde + '/' + convert(varchar, qud_inrqty) + '/' + convert(varchar, qud_mtrqty) + '/' + convert(varchar, qud_prctrm) + '/' + convert(varchar, qud_trantrm)
		end as 'Packing'
		
	FROM QUOTNDTL
	LEFT JOIN QUOTNHDR
		ON qud_cocde = quh_cocde 
		AND qud_qutno = quh_qutno
	WHERE 
		((@cocde<>'UC-G' and qud_cocde = @cocde)  or (@cocde = 'UC-G' and qud_cocde<>'MS'))
	AND ((@flg_pricust = 'N') OR (@flg_pricust = 'Y' and quh_cus1no in (select tmp_cus1no from #TEMP_CUS1NO (nolock))))
	AND ((@flg_seccust = 'N') OR (@flg_seccust = 'Y' and quh_cus2no in (select tmp_cus2no from #TEMP_CUS2NO (nolock))))
	AND ((@flg_qutno = 'N') OR (@flg_qutno = 'Y' and qud_qutno in (select tmp_qutno from #TEMP_QUTNO (nolock))))
	AND qud_qutitmsts = 'REQ'
	AND quh_qutsts = 'R'
	
	
	
END	--End Store Procedure

	
	

GO
GRANT EXECUTE ON [dbo].[sp_select_RIR00001] TO [ERPUSER] AS [dbo]
GO
