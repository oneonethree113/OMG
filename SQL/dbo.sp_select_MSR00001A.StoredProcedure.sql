/****** Object:  StoredProcedure [dbo].[sp_select_MSR00001A]    Script Date: 09/29/2017 15:29:09 ******/
DROP PROCEDURE [dbo].[sp_select_MSR00001A]
GO
/****** Object:  StoredProcedure [dbo].[sp_select_MSR00001A]    Script Date: 09/29/2017 15:29:10 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
---------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------

CREATE PROCEDURE [dbo].[sp_select_MSR00001A]
	@cocde nvarchar(6),
	@pricustlist nvarchar(1000),
	@seccustlist nvarchar(1000), 
	@custpolist nvarchar(1000),
	@scnolist nvarchar(1000),
	@custitmlist nvarchar(1000),
	@itemlist nvarchar(1000),
	@pvlist nvarchar(1000),
	@falist nvarchar(1000),
	@pricetermlist nvarchar(1000),
	@shipdatefrom datetime, 
	@shipdateto datetime,
	@shipdateendfrom datetime,
	@shipdateendto datetime,
	
	@opt_unitprice nvarchar(1),		-- 'Y' => Show Unit Price 'N' => Not showing 
	@opt_sort nvarchar(2),			-- 'C' => Customeer PO 'SS' => Ship Start Date 'SE' => Ship End DAte
	@opt_group nvarchar(2),			-- 'E1' => Excel Mode 'CB' => Crystal Report(Base) 'CD' => Crystal Report(Detail)
	@creusr nvarchar(30),
	@SalTem nvarchar(7)
	
AS
BEGIN
	SET NOCOUNT ON
	
	CREATE table #TEMP_INIT(tmp_init nvarchar(1000)) on [PRIMARY]
	CREATE table #TEMP_INIT2(tmp_init nvarchar(50)) on [PRIMARY]
	-- CREATE table #TEMP_CUS1NO(tmp_cus1no nvarchar(10)) on [PRIMARY]
	-- CREATE table #TEMP_CUS2NO(tmp_cus2no nvarchar(10)) on [PRIMARY]
	-- CREATE table #TEMP_CUSTPO(tmp_custpo nvarchar(20)) on [PRIMARY]
	-- CREATE table #TEMP_SCNO(tmp_scno nvarchar(20)) on [PRIMARY]
	-- CREATE table #TEMP_CUSITM(tmp_cusitm nvarchar(20)) on [PRIMARY]
	-- CREATE table #TEMP_ITM(tmp_itmno nvarchar(20)) on [PRIMARY]
	-- CREATE table #TEMP_PV(tmp_venno nvarchar(6)) on [PRIMARY]
	-- CREATE table #TEMP_FA(tmp_examven nvarchar(6)) on [PRIMARY]
	
	CREATE table #TEMP_CUS1NO(tmp_cus1no nvarchar(50)) on [PRIMARY]
	CREATE table #TEMP_CUS2NO(tmp_cus2no nvarchar(50)) on [PRIMARY]
	CREATE table #TEMP_CUSTPO(tmp_custpo nvarchar(50)) on [PRIMARY]
	CREATE table #TEMP_SCNO(tmp_scno nvarchar(50)) on [PRIMARY]
	CREATE table #TEMP_CUSITM(tmp_cusitm nvarchar(50)) on [PRIMARY]
	CREATE table #TEMP_ITM(tmp_itmno nvarchar(50)) on [PRIMARY]
	CREATE table #TEMP_PV(tmp_venno nvarchar(50)) on [PRIMARY]
	CREATE table #TEMP_FA(tmp_examven nvarchar(50)) on [PRIMARY]
	CREATE table #TEMP_PRICETERM(tmp_priceterm nvarchar(50)) on [PRIMARY]
	
	DECLARE @token nvarchar(100)
	DECLARE @tmp_fm nvarchar(50)
	DECLARE @tmp_to nvarchar(50)
	
	DECLARE @flg_pricust char(1),
	@flg_seccust char(1),
	@flg_custpo char(1),
	@flg_scno char(1),
	@flg_custitm char(1),
	@flg_item char(1),
	@flg_pv char(1),
	@flg_fa char(1),
	@flg_priceterm char(1),
	
	@flg_shipstartdate_from char(1),
	@flg_shipstartdate_to char(1),
	@flg_shipenddate_from char(1),
	@flg_shipenddate_to char(1)
	
	SET @flg_pricust = 'N'
	SET @flg_seccust = 'N'
	SET @flg_custpo = 'N'
	SET @flg_scno = 'N'
	SET @flg_custitm = 'N'
	SET @flg_item = 'N'
	SET @flg_pv = 'N'
	SET @flg_fa = 'N'
	SET @flg_priceterm = 'N'
	
	
	if @shipdatefrom = '01/01/1900'
		set @flg_shipstartdate_from = 'N'
	else 
		set @flg_shipstartdate_from = 'Y'
		
	if @shipdateto = '01/01/2100'
		set @flg_shipstartdate_to = 'N'
	else 
		set @flg_shipstartdate_to = 'Y'
	if @shipdateendfrom = '01/01/1900'
		set @flg_shipenddate_from = 'N'
	else
		set @flg_shipenddate_from = 'Y'
	if @shipdateendto = '01/01/2100'
		set @flg_shipenddate_to = 'N'
	else
		set @flg_shipenddate_to = 'Y'
	
	-- print @flg_shipstartdate_from
	-- print @flg_shipstartdate_to
	-- print @flg_shipenddate_from
	-- print @flg_shipenddate_to
	
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
	
	--Customer PO Start
	if ltrim(rtrim(@custpolist)) <> ''
	BEGIN
		SET @flg_custpo = 'Y'
		INSERT INTO #TEMP_INIT SELECT * FROM dbo.splitstring(@custpolist)
		
		DECLARE c CURSOR FORWARD_ONLY FOR SELECT tmp_init from #TEMP_INIT
		OPEN C
		FETCH NEXT FROM C into @token
		
		WHILE @@FETCH_STATUS = 0 
		BEGIN
			if charindex('~', @token) <> 0
			BEGIN
				SET @tmp_fm = left(@token, charindex('~', @token)-1)
				SET @tmp_to = right(@token, len(@token) - charindex('~', @token))
				INSERT INTO #TEMP_INIT2 SELECT distinct sod_cuspo from SCORDDTL WHERE sod_cuspo between @tmp_fm and @tmp_to
				INSERT INTO #TEMP_INIT2 SELECT distinct soh_cuspo from SCORDHDR WHERE soh_cuspo between @tmp_fm and @tmp_to
			END
			else
			BEGIN
				INSERT INTO #TEMP_INIT2 SELECT sod_cuspo from SCORDDTL WHERE sod_cuspo like @token
				INSERT INTO #TEMP_INIT2 SELECT soh_cuspo from SCORDHDR WHERE soh_cuspo like @token
			END
			FETCH NEXT FROM C into @token
		END
		INSERT INTO #TEMP_CUSTPO SELECT distinct tmp_init from #TEMP_INIT2
		--SELECT * from #TEMP_CUSTPO
		CLOSE C
		DEALLOCATE C
		DELETE FROM #TEMP_INIT
		DELETE FROM #TEMP_INIT2
	END
	--Customer PO End
	
	--SC No Start
	IF ltrim(rtrim(@scnolist)) <> ''
	BEGIN
		SET @flg_scno = 'Y'
		INSERT INTO #TEMP_INIT SELECT * FROM dbo.splitstring(@scnolist)
		
		DECLARE c CURSOR FORWARD_ONLY FOR SELECT tmp_init from #TEMP_INIT
		OPEN C
		FETCH NEXT FROM C into @token
		
		WHILE @@FETCH_STATUS = 0 
		BEGIN
			if charindex('~', @token) <> 0
			BEGIN
				SET @tmp_fm = left(@token, charindex('~', @token)-1)
				SET @tmp_to = right(@token, len(@token) - charindex('~', @token))
				INSERT INTO #TEMP_INIT2 SELECT sod_ordno from SCORDDTL WHERE sod_ordno between @tmp_fm and @tmp_to
			END
			else
			BEGIN
				INSERT INTO #TEMP_INIT2 SELECT sod_ordno from SCORDDTL WHERE sod_ordno like @token
			END
			FETCH NEXT FROM C into @token
		END
		INSERT INTO #TEMP_SCNO SELECT distinct tmp_init from #TEMP_INIT2
		--SELECT * from #TEMP_SCNO
		
		CLOSE C
		DEALLOCATE C
		DELETE FROM #TEMP_INIT
		DELETE FROM #TEMP_INIT2
	END	
	--SC No End
	
	--Customer Item Start
	IF ltrim(rtrim(@custitmlist)) <> ''
	BEGIN
		SET @flg_custitm = 'Y'
		INSERT INTO #TEMP_INIT SELECT * FROM dbo.splitstring(@custitmlist)
		
		DECLARE c CURSOR FORWARD_ONLY FOR SELECT tmp_init from #TEMP_INIT
		OPEN C
		FETCH NEXT FROM C into @token
		
		WHILE @@FETCH_STATUS = 0 
		BEGIN
			if charindex('~', @token) <> 0
			BEGIN
				SET @tmp_fm = left(@token, charindex('~', @token)-1)
				SET @tmp_to = right(@token, len(@token) - charindex('~', @token))
				INSERT INTO #TEMP_INIT2 SELECT sod_cusitm from SCORDDTL WHERE sod_cusitm between @tmp_fm and @tmp_to
			END
			else
			BEGIN
				INSERT INTO #TEMP_INIT2 SELECT sod_cusitm from SCORDDTL WHERE sod_cusitm like @token
			END
			FETCH NEXT FROM C into @token
		END
		INSERT INTO #TEMP_CUSITM SELECT distinct tmp_init from #TEMP_INIT2
		--SELECT * from #TEMP_CUSITM
		
		CLOSE C
		DEALLOCATE C
		DELETE FROM #TEMP_INIT
		DELETE FROM #TEMP_INIT2
	END	
	--Customer Item End
	
	--Item Start
	IF ltrim(rtrim(@itemlist)) <> ''
	BEGIN
		SET @flg_item = 'Y'
		INSERT INTO #TEMP_INIT SELECT * FROM dbo.splitstring(@itemlist)
		
		DECLARE c CURSOR FORWARD_ONLY FOR SELECT tmp_init from #TEMP_INIT
		OPEN C
		FETCH NEXT FROM C into @token
		
		WHILE @@FETCH_STATUS = 0 
		BEGIN
			if charindex('~', @token) <> 0
			BEGIN
				SET @tmp_fm = left(@token, charindex('~', @token)-1)
				SET @tmp_to = right(@token, len(@token) - charindex('~', @token))
				INSERT INTO #TEMP_INIT2 SELECT sod_itmno from SCORDDTL WHERE sod_itmno between @tmp_fm and @tmp_to
			END
			else
			BEGIN
				INSERT INTO #TEMP_INIT2 SELECT sod_itmno from SCORDDTL WHERE sod_itmno like @token
			END
			FETCH NEXT FROM C into @token
		END
		INSERT INTO #TEMP_ITM SELECT distinct tmp_init from #TEMP_INIT2
		--SELECT * from #TEMP_ITM
		
		CLOSE C
		DEALLOCATE C
		DELETE FROM #TEMP_INIT
		DELETE FROM #TEMP_INIT2
	END	
	--Item End

	--PV Start
	IF ltrim(rtrim(@pvlist)) <> ''
	BEGIN
		SET @flg_pv = 'Y'
		INSERT INTO #TEMP_INIT SELECT * FROM dbo.splitstring(@pvlist)
		
		DECLARE c CURSOR FORWARD_ONLY FOR SELECT tmp_init from #TEMP_INIT
		OPEN C
		FETCH NEXT FROM C into @token
		
		WHILE @@FETCH_STATUS = 0 
		BEGIN
			if charindex('~', @token) <> 0
			BEGIN
				SET @tmp_fm = left(@token, charindex('~', @token)-1)
				SET @tmp_to = right(@token, len(@token) - charindex('~', @token))
				INSERT INTO #TEMP_INIT2 SELECT vbi_venno from VNBASINF WHERE vbi_venno between @tmp_fm and @tmp_to
			END
			else
			BEGIN
				INSERT INTO #TEMP_INIT2 SELECT vbi_venno from VNBASINF WHERE vbi_venno like @token
			END
			FETCH NEXT FROM C into @token
		END
		INSERT INTO #TEMP_PV SELECT distinct tmp_init from #TEMP_INIT2
		--SELECT * from #TEMP_PV
		
		CLOSE C
		DEALLOCATE C
		DELETE FROM #TEMP_INIT
		DELETE FROM #TEMP_INIT2
	END	
	--PV End

	--FA Start
	IF ltrim(rtrim(@falist)) <> ''
	BEGIN
		SET @flg_fa = 'Y'
		INSERT INTO #TEMP_INIT SELECT * FROM dbo.splitstring(@falist)
		
		DECLARE c CURSOR FORWARD_ONLY FOR SELECT tmp_init from #TEMP_INIT
		OPEN C
		FETCH NEXT FROM C into @token
		
		WHILE @@FETCH_STATUS = 0 
		BEGIN
			if charindex('~', @token) <> 0
			BEGIN
				SET @tmp_fm = left(@token, charindex('~', @token)-1)
				SET @tmp_to = right(@token, len(@token) - charindex('~', @token))
				INSERT INTO #TEMP_INIT2 SELECT vbi_venno from VNBASINF WHERE vbi_venno between @tmp_fm and @tmp_to
			END
			else
			BEGIN
				INSERT INTO #TEMP_INIT2 SELECT vbi_venno from VNBASINF WHERE vbi_venno like @token
			END
			FETCH NEXT FROM C into @token
		END
		INSERT INTO #TEMP_FA SELECT distinct tmp_init from #TEMP_INIT2
		--SELECT * from #TEMP_FA
		
		CLOSE C
		DEALLOCATE C
		DELETE FROM #TEMP_INIT
		DELETE FROM #TEMP_INIT2
	END	
	--FA End
	
	--Price Term Start
	IF ltrim(rtrim(@pricetermlist)) <> ''
	BEGIN
		SET @flg_priceterm = 'Y'
		INSERT INTO #TEMP_INIT SELECT * FROM dbo.splitstring(@pricetermlist)
		
		DECLARE c CURSOR FORWARD_ONLY FOR SELECT tmp_init from #TEMP_INIT
		OPEN C
		FETCH NEXT FROM C into @token
		
		WHILE @@FETCH_STATUS = 0 
		BEGIN
			if charindex('~', @token) <> 0
			BEGIN
				SET @tmp_fm = left(@token, charindex('~', @token)-1)
				SET @tmp_to = right(@token, len(@token) - charindex('~', @token))
				INSERT INTO #TEMP_INIT2 SELECT ysi_cde from SYSETINF WHERE ysi_cde between @tmp_fm and @tmp_to and ysi_typ = '03'
			END
			else
			BEGIN
				INSERT INTO #TEMP_INIT2 SELECT ysi_cde from SYSETINF WHERE ysi_cde like @token and ysi_typ = '03'
			END
			FETCH NEXT FROM C into @token
		END
		INSERT INTO #TEMP_PRICETERM SELECT distinct tmp_init from #TEMP_INIT2
		--SELECT * from #TEMP_PRICETERM
		
		CLOSE C
		DEALLOCATE C
		DELETE FROM #TEMP_INIT
		DELETE FROM #TEMP_INIT2
	END	
	--Price Term End
	
	
	
	--*** Insert Temp Table Start ***--
	
	--Get Compnay Name
	Declare @compName as nvarchar(100)
	set @compName = 'UNITED CHINESE GROUP'
	if @cocde <> 'UC-G'
	BEGIN
		select @compName = yco_conam from SYCOMINF where yco_cocde = @cocde
	END

	--Temp table for storing SC That have discount/premium Start
	select distinct sdp_ordno INTO #tmp_dp from SCDISPRM
	--Temp table for storing SC That have discount/premium Start
	
	--Main Query Start
		
	SELECT
--		distinct
		-- sod_ordno as 'SC',
		-- pod_jobord AS 'po',
		-- SOD_ordqty as 'soq',
		-- sod_selprc AS 'TTL AMOUNT',
		
		--Search Criteria
		@cocde as 's_cocde',
		@pricustlist as 's_pricust',
		@seccustlist as 's_seccust',
		@custpolist as 's_custpo',
		@scnolist as 's_scno',
		@custitmlist as 's_custitm',
		@itemlist as 's_item',
		@pvlist as 's_pv', 
		@falist as 's_fa',
		@pricetermlist as 's_priceterm',
		@shipdatefrom as 's_shipdatefrom',
		@shipdateto as 's_shipdateto',
		@shipdateendfrom as 's_shipdateendfrom',
		@shipdateendto as 's_shipdateendto',
		@opt_unitprice as 'opt_unitprice',
		@opt_sort as 'opt_sort',
		@opt_group as 'opt_group',
		@creusr as 'creusr',
		@SalTem AS 'SalTem',

		--CUBASINF
		pri.cbi_cusno as 'pricusno', pri.cbi_cussna as 'pricussna',
		ISNULL(sec.cbi_cusno, '') as 'seccusno', isnull(sec.cbi_cussna, '') as 'seccussna',
		
		--SCORDHDR
		soh_curcde as 'soh_curcde',
		soh_prctrm,
		soh_dest,
		
		--SCORDDTL
		sod_ordno as 'sod_ordno',
		sod_ordseq as 'sod_ordseq',
		sod_purord,
		'sod_cuspo' = Case IsNull(sod_cuspo,'') when '' then soh_cuspo else sod_cuspo end,
		'sod_resppo' = Case isNULL(sod_resppo, '') when '' then soh_resppo else sod_resppo end,
		sod_cusitm,
		sod_itmno as 'sod_itmno', 
		sod_itmdsc as 'sod_itmdsc',
		--sod_ordqty,
		'sod_ordqty'  = sod_ordqty - sod_shpqty  ,
		sod_shpqty, 
		sod_pckunt as 'sod_pckunt',
		--sod_ttlctn,
		'sod_ttlctn' = sod_ttlctn * (sod_ordqty - sod_shpqty) / sod_ordqty ,
		sod_untprc as 'sod_untprc',
		'sod_untprcStr' =  ltrim(str(sod_untprc,10,4)),	
		'sod_selprc' = sod_selprc * (sod_ordqty - sod_shpqty) / sod_ordqty,		--20/11/2015 Original is sod_selprc only 
		--'sod_osselprc' = sod_selprc * (sod_ordqty - sod_shpqty) / sod_ordqty ,
		--'sod_osselprcStr' = ltrim(str(sod_selprc * (sod_ordqty - sod_shpqty) / sod_ordqty,10,4)) ,		
		convert(varchar,sod_shpstr,101) as 'sod_shpstr', --change from 103 to 101 BN
		convert(varchar,sod_shpend,101) as 'sod_shpend',--change from 103 to 101 BN
		convert(varchar, sod_candat, 101) as 'sod_candat',
		sod_subcde,	
		sod_venno,
		'sod_balcbm' = round( round((sod_cft / 35.3356),4) * (sod_ordqty - sod_shpqty ) / sod_mtrctn,4),
		'sod_cbm' = round( round((sod_cft / 35.3356),4) * (sod_ordqty - sod_shpqty ) / sod_mtrctn,4),
--		sod_cbm, 
		sod_cussku,
		
		--#tmp_dp
		case isnull(sdp_ordno, '') when '' then 'N' else 'Y' end AS 'DIS/PRE',

		--POORDDTL
		isnull(pod_jobord,'') as 'pod_jobord',
		isnull(pod_venitm, '') as 'pod_venitm',
		
		--SCDTLSHP
		sds_ordqty,
		sds_ttlctn,
		sds_ordno,
		sds_seq,
		sds_shpseq,
		sds_scfrom,
		sds_scto,
		sds_dest,
		'sds_selprc' = case isnull(sds_ordno, '') when '' then 0 else sod_selprc * sds_ordqty/sod_ordqty end,
		'sds_cbm' = case isnull(sds_ordno, '') when '' then 0 else sod_cbm * sds_ttlctn/sod_ttlctn end, 
		
		-- VNBASINF
		isnull(pv.vbi_vensna, '') as 'pvna',
		isnull(fa.vbi_vensna, '') as 'fana',
		
		-- SYSETINF
		isnull(sys_unit.ysi_dsc,'') as 'unit',
		isnull(sys_payterm.ysi_dsc, '') as 'paytrm_desc',
		
		-- For Excel Start
		case @opt_group when 'E1' then isnull(sds_ordqty, sod_ordqty) else NULL end as 'e1_ordqty', 
		case @opt_group when 'E1' then isnull(sds_ttlctn, sod_ttlctn) else NULL end as 'e1_ttlctn',
		case @opt_group when 'E1' then 
			case isnull(sds_ordno, '') when '' then sod_cbm else sod_cbm*sod_ttlctn/sds_ttlctn end 
		end as 'e1_cbm',
		case @opt_group when 'E1' then
			case isnull(sds_ordno, '') when '' then sod_selprc else sod_selprc*sod_ttlctn/sds_ttlctn end 
		end as 'e1_selprc',
		case @opt_group when 'E1' then
			case isnull(sds_dest, '') when '' then soh_dest else sds_dest end
		end as 'e1_dest',
		case @opt_group when 'E1' then 
			convert(varchar,sod_shpstr,101) + '-' + convert(varchar,sod_shpend,101) 
		end as 'e1_shipwin1',
		case @opt_group when 'E1' then
			case isnull(sds_ordno, '') when '' then 
				convert(varchar, sod_shpstr, 101) + '-' + convert(varchar, sod_shpend, 101) else 
				convert(varchar, sds_scfrom, 101) + '-' + convert(varchar, sds_scto, 101)
			end 
		end as 'e1_shipwin2',
		case @opt_group when 'E1' then
			case convert(varchar, sod_candat, 101) when '01/01/1900' then '' else convert(varchar, sod_candat, 101) end
		end as 'e1_candat',
		--20160105 Add
		sod_dsc_f1 as 'e1_sod_dsc_f1', 
		sod_pckunt as 'e1_sod_pckunt', 
		sod_inrctn as 'e1_sod_inrctn', 
		sod_mtrctn as 'e1_sod_mtrctn', 
		sod_hrmcde as 'e1_sod_hrmcde', 
			
		
		
		--For Excel End
		@compName as 'compName',

		
		case when sod_candat <> cast('1900-01-01 00:00:00.000' as datetime) then  CONVERT(char(10),sod_candat,101)  else ''  end as 'sod_candat',
		--case sod_resppo when '' then soh_resppo else sod_resppo end as 'soh_resppo',
		
		'rpt2_dest' = CASE isNull(sds_dest,'') when '' then soh_dest else sds_dest end
		--'rpt2_shipwindow' = 
		--case when @opt_group = 'DM' then left(convert(varchar,sod_shpstr,112),6) else '' end as 'shpperiod'
		
	FROM SCORDHDR
	LEFT JOIN SCORDDTL 
		ON soh_cocde = sod_cocde
		AND soh_ordno = sod_ordno
	LEFT JOIN SCDTLSHP
		ON sod_cocde = sds_cocde
		AND sod_ordno = sds_ordno
		AND sod_ordseq = sds_seq
	LEFT JOIN #tmp_dp
		ON sod_ordno = sdp_ordno
	LEFT JOIN POORDDTL
		ON sod_cocde = pod_cocde
		AND sod_purord = pod_purord
		AND sod_purseq = pod_purseq
	LEFT JOIN IMBASINF
		ON sod_itmno = ibi_itmno
	LEFT JOIN VNBASINF pv
		ON sod_venno = pv.vbi_venno
	LEFT JOIN VNBASINF fa
		ON sod_examven = fa.vbi_venno
	LEFT JOIN CUBASINF pri
		ON soh_cus1no = pri.cbi_cusno
	LEFT JOIN CUBASINF sec
		ON soh_cus2no = sec.cbi_cusno
	LEFT JOIN SYSETINF sys_unit
		ON sod_pckunt = sys_unit.ysi_cde
		AND sys_unit.ysi_typ = '05'
	LEFT JOIN SYSETINF sys_payterm
		ON soh_paytrm = sys_payterm.ysi_cde
		AND sys_payterm.ysi_typ = '04'
	WHERE 
		sod_ordqty - sod_shpqty > 0 
	AND soh_ordsts <> 'CLO'
	AND ((@cocde<>'UC-G' and  soh_cocde = @cocde)  or (@cocde = 'UC-G' and soh_cocde<>'MS'))
	AND	(
		@SalTem='' or @SalTem='S' or pri.cbi_saltem = @SalTem 
		or pri.cbi_saltem in (select distinct yur_para from syusrright where yur_usrid = @creusr and yur_doctyp = 'SC' and yur_lvl = 1) 
		)
	AND ((@flg_pricust = 'N') OR (@flg_pricust = 'Y' and soh_cus1no in (select tmp_cus1no from #TEMP_CUS1NO (nolock))))
	AND ((@flg_seccust = 'N') OR (@flg_seccust = 'Y' and soh_cus2no in (select tmp_cus2no from #TEMP_CUS2NO (nolock))))
	AND (
			(@flg_custpo = 'N') OR 
			(@flg_custpo = 'Y' and 
				(	
					sod_cuspo in (select tmp_custpo from #TEMP_CUSTPO (nolock)) 
					OR soh_cuspo in (select tmp_custpo from #TEMP_CUSTPO (nolock))
				)
			)
		)
	AND ((@flg_scno = 'N') OR (@flg_scno = 'Y' and sod_ordno in (select tmp_scno from #TEMP_SCNO (nolock))))
	AND ((@flg_custitm = 'N') OR (@flg_custitm = 'Y' and sod_cusitm in (select tmp_cusitm from #TEMP_CUSITM (nolock))))
	AND ((@flg_item = 'N') OR ( @flg_item = 'Y' and sod_itmno in (select tmp_itmno from #TEMP_ITM (nolock))))
	AND ((@flg_pv = 'N') OR ( @flg_pv = 'Y' and sod_venno in (select tmp_venno from #TEMP_PV (nolock))))
	AND ((@flg_fa = 'N') OR ( @flg_fa = 'Y' and sod_examven in (select tmp_examven from #TEMP_FA (nolock))))
	AND ((@flg_priceterm = 'N') OR ( @flg_priceterm = 'Y' and soh_prctrm in (select tmp_priceterm from #TEMP_PRICETERM (nolock))))
	AND ((@flg_shipstartdate_from = 'N' OR (@flg_shipstartdate_from = 'Y' and (sod_shpstr >= @shipdatefrom or sds_scfrom >= @shipdatefrom))))
	AND ((@flg_shipstartdate_to = 'N' OR (@flg_shipstartdate_to = 'Y' and (sod_shpstr <= @shipdateto or sds_scfrom <= @shipdateto))))
	AND ((@flg_shipenddate_from = 'N' OR (@flg_shipenddate_from = 'Y' and (sod_shpend >= @shipdateendfrom or sds_scto >= @shipdateendfrom))))
	AND ((@flg_shipenddate_to = 'N' OR (@flg_shipenddate_to = 'Y' and (sod_shpend <= @shipdateendto or sds_scto <= @shipdateendto))))
	
	ORDER BY
		pri.cbi_cusno,
		isnull(sec.cbi_cusno, ''),
		case @opt_group
			when 'E1' then sod_ordno
			else '' end, 
		case @opt_sort
			when 'C' then Case isNull(sod_cuspo, '') when '' then soh_cuspo else sod_cuspo end
			when 'SS' then isnull(convert(char(10), sod_shpstr, 111), '')
			when 'SE' then isnull(convert(char(10), sod_shpend, 111), '')
			else '' end,
		case @opt_sort
			when 'C' then sod_itmno
			when 'SS' then Case IsNull(sod_cuspo,'') when '' then soh_cuspo else sod_cuspo end
			when 'SE' then Case isNull(sod_cuspo, '') when '' then soh_cuspo else sod_cuspo end
			else '' end,
		case @opt_sort
			when 'C' then isnull(convert(char(10),sod_shpstr,111),'')
			when 'SS' then sod_itmno
			when 'SE' then sod_itmno
			else '' end	
	
	--Main Query End
	
	drop table #tmp_dp
	
	
END






GO
GRANT EXECUTE ON [dbo].[sp_select_MSR00001A] TO [ERPUSER] AS [dbo]
GO
