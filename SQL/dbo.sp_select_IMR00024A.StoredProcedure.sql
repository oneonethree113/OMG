/****** Object:  StoredProcedure [dbo].[sp_select_IMR00024A]    Script Date: 09/29/2017 15:29:09 ******/
DROP PROCEDURE [dbo].[sp_select_IMR00024A]
GO
/****** Object:  StoredProcedure [dbo].[sp_select_IMR00024A]    Script Date: 09/29/2017 15:29:10 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO






CREATE procedure [dbo].[sp_select_IMR00024A]
@cocde varchar(6),
@SCFm varchar(20), 
@SCTo varchar(20), 
@JobFm varchar(20), 
@JobTo varchar(20), 
@pricustlist nvarchar(1000),
@seccustlist nvarchar(1000), 
@Act char(1),
@gsUsrID varchar(30)
as
begin
	declare 
		@optSC char(1), 
		@optJob char(1),
		@flg_pricust char(1),
		@flg_seccust char(1)
		
	SET NOCOUNT ON
		
	CREATE table #TEMP_CUS1NO(tmp_cus1no nvarchar(50)) on [PRIMARY]
	CREATE table #TEMP_CUS2NO(tmp_cus2no nvarchar(50)) on [PRIMARY]
	
	
	CREATE table #TEMP_INIT(tmp_init nvarchar(1000)) on [PRIMARY]
	CREATE table #TEMP_INIT2(tmp_init nvarchar(50)) on [PRIMARY]

		
	DECLARE @token nvarchar(100)
	DECLARE @tmp_fm nvarchar(50)
	DECLARE @tmp_to nvarchar(50)

	set @optSC = 'N'
	if @SCFm <> ''
	begin
		set @optSC = 'Y'
	end

	set @optJob = 'N'
	if @JobFm <> ''
	begin
		set @optJob = 'Y'
	end
--Pri Cust Start	
	SET @flg_pricust = 'N'
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

	SET @flg_seccust = 'N'
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
	END
--Sec Cust End

	if @ACT = 'U'
	begin
		select 
			stm_ordno as 'SC #',
			stm_ordseq as 'SC seq.',
			stm_jobno as 'Job #', 
			stm_smkno as 'Ship Mark', 
			stm_act as 'Action', 
			stm_updusr as 'Update User', 
			stm_upddat as 'Update Date',
			soh_cus1no as 'Primary Cust Code',
			pri.cbi_cussna as 'Primary Cust Name',
			soh_cus2no as 'Secordary Cust Code',
			sec.cbi_cussna as 'Secordary Cust Name'
		 from 
			UCPERPDB_AUD.dbo.SCTPSMRK_AUD(nolock)
				left join SCORDHDR (nolock) on stm_ordno=soh_ordno
				left join CUBASINF pri (nolock) on pri.cbi_cusno = soh_cus1no 
				LEFT JOIN CUBASINF sec (nolock)	ON sec.cbi_cusno = soh_cus2no
		where
--			(@optSC = 'N' or (@optSC = 'Y' and left(stm_jobno,9) between @SCFm and @SCTo)) and
--			Frankie Cheung 20100609
			(@optSC = 'N' or (@optSC = 'Y' and stm_ordno between @SCFm and @SCTo))
			and (@optJob = 'N' or (@optJob = 'Y' and stm_jobno between @JobFm and @JobTo)) 
			and ((@flg_pricust = 'N') OR (@flg_pricust = 'Y' and soh_cus1no in (select tmp_cus1no from #TEMP_CUS1NO)))
			AND ((@flg_seccust = 'N') OR (@flg_seccust = 'Y' and soh_cus2no in (select tmp_cus2no from #TEMP_CUS2NO)))
			 and stm_actflg_aud <> 2
		order by 
--			stm_jobno , 
--			stm_upddat 
			stm_ordno,
			stm_ordseq,
			stm_smkno, 
			stm_credat
	end
	else
	begin
		select 
			stm_ordno as 'SC #',
			stm_ordseq as 'SC seq.',
			stm_jobno as 'Job #', 
			stm_smkno as 'Ship Mark', 
			--stm_act as 'Action', 
			stm_updusr as 'Update User', 
			stm_upddat as 'Update Date',
			soh_cus1no as 'Primary Cust Code',
			pri.cbi_cussna as 'Primary Cust Name',
			soh_cus2no as 'Secordary Cust Code',
			sec.cbi_cussna as 'Secordary Cust Name'
		 from 
			 SCTPSMRK(nolock) 
				left join SCORDHDR (nolock) on stm_ordno=soh_ordno
				left join CUBASINF pri (nolock) on pri.cbi_cusno = soh_cus1no 
				LEFT JOIN CUBASINF sec (nolock)	ON sec.cbi_cusno = soh_cus2no
		where
--			(@optSC = 'N' or (@optSC = 'Y' and left(stm_jobno,9) between @SCFm and @SCTo)) and
--			Frankie Cheung 20100609
			(@optSC = 'N' or (@optSC = 'Y' and stm_ordno between @SCFm and @SCTo)) and
			(@optJob = 'N' or (@optJob = 'Y' and stm_jobno between @JobFm and @JobTo)) 
			and ((@flg_pricust = 'N') OR (@flg_pricust = 'Y' and soh_cus1no in (select tmp_cus1no from #TEMP_CUS1NO)))
			AND ((@flg_seccust = 'N') OR (@flg_seccust = 'Y' and soh_cus2no in (select tmp_cus2no from #TEMP_CUS2NO)))
			AND  stm_act <> 'DEL'
		order by 
--			stm_jobno , 
--			stm_smkno 
			stm_ordno,
			stm_ordseq,
			stm_smkno, 
			stm_upddat

	end
end



GO
GRANT EXECUTE ON [dbo].[sp_select_IMR00024A] TO [ERPUSER] AS [dbo]
GO
