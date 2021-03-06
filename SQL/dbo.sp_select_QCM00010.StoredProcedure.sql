/****** Object:  StoredProcedure [dbo].[sp_select_QCM00010]    Script Date: 09/29/2017 15:29:09 ******/
DROP PROCEDURE [dbo].[sp_select_QCM00010]
GO
/****** Object:  StoredProcedure [dbo].[sp_select_QCM00010]    Script Date: 09/29/2017 15:29:10 ******/
SET ANSI_NULLS OFF
GO
SET QUOTED_IDENTIFIER OFF
GO


/*
=========================================================
Program ID	: 
Description   	: 
Programmer  	: 
Create Date   	: 08-03-2017
Last Modified  	: 
Table Read(s) 	:
Table Write(s) 	:
=========================================================
 Modification History                                    
=========================================================
Date		Author		Description
=========================================================     
*/

CREATE procedure [dbo].[sp_select_QCM00010]

	@cocde nvarchar(10),
	@pricustlist nvarchar(1000),
	@seccustlist nvarchar(1000), 
	--@pvlist nvarchar(1000),
	@cvlist nvarchar(1000),
	--@falist nvarchar(1000),	
	--@scnolist nvarchar(1000),
	--@ponolist nvarchar(1000),
	@custpolist nvarchar(1000),
	--@itemlist nvarchar(1000),
	--@scshipdatefrom datetime,
	--@scshipdateto datetime,
	@poshipdatefrom datetime,
	@poshipdateto datetime,
	@poCanFlag nvarchar(1),

	@usrid nvarchar(12)    
AS

begin
SET NOCOUNT ON
	
	CREATE table #TEMP_INIT(tmp_init nvarchar(1000)) on [PRIMARY]
	CREATE table #TEMP_INIT2(tmp_init nvarchar(50)) on [PRIMARY]

	CREATE table #TEMP_CUS1NO(tmp_cus1no nvarchar(50)) on [PRIMARY]
	CREATE table #TEMP_CUS2NO(tmp_cus2no nvarchar(50)) on [PRIMARY]
--	CREATE table #TEMP_PV(tmp_venno nvarchar(50)) on [PRIMARY]
	CREATE table #TEMP_CV(tmp_venno nvarchar(50)) on [PRIMARY]
	CREATE table #TEMP_FA(tmp_examven nvarchar(50)) on [PRIMARY]	
	CREATE table #TEMP_SCNO(tmp_scno nvarchar(50)) on [PRIMARY]
	CREATE table #TEMP_PONO(tmp_pono nvarchar(50)) on [PRIMARY]
	CREATE table #TEMP_CUSTPO(tmp_custpo nvarchar(50)) on [PRIMARY]
	--CREATE table #TEMP_ITM(tmp_itmno nvarchar(50)) on [PRIMARY]
	
	DECLARE @token nvarchar(100)
	DECLARE @tmp_fm nvarchar(50)
	DECLARE @tmp_to nvarchar(50)
	
	DECLARE @flg_pricust char(1),
	@flg_seccust char(1),
	--@flg_pv char(1),
	@flg_cv char(1),
	--@flg_fa char(1),
	--@flg_scno char(1),
	--@flg_pono char(1),
	@flg_custpo char(1),
	
	--@flg_scshipdate_fm char(1),
	--@flg_scshipdate_to char(1),
	@flg_poshipdate_fm char(1),
	@flg_poshipdate_to char(1)
	

	

	SET @flg_pricust = 'N'
	SET @flg_seccust = 'N'
	--SET @flg_pv = 'N'
	SET @flg_cv = 'N'
	--SET @flg_fa = 'N'
	--SET @flg_scno = 'N'
	--SET @flg_pono = 'N'
	--SET @flg_item = 'N'
	SET @flg_custpo = 'N'

	
	
	--if @scshipdatefrom = '01/01/1900'
	--	set @flg_scshipdate_fm = 'N'
	--else 
	--	set @flg_scshipdate_fm = 'Y'
		
	--if @scshipdateto = '01/01/2100'
	--	set @flg_scshipdate_to = 'N'
	--else 
	--	set @flg_scshipdate_to = 'Y'
	
	if @poshipdatefrom = '01/01/1900'
		set @flg_poshipdate_fm = 'N'
	else 
		set @flg_poshipdate_fm = 'Y'
		
	if @poshipdateto = '01/01/2100'
		set @flg_poshipdate_to = 'N'
	else 
		set @flg_poshipdate_to = 'Y'
		

	
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

   --CV Start
	IF ltrim(rtrim(@cvlist)) <> ''
	BEGIN
		SET @flg_cv = 'Y'
		INSERT INTO #TEMP_INIT SELECT * FROM dbo.splitstring(@cvlist)
		
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
		INSERT INTO #TEMP_CV SELECT distinct tmp_init from #TEMP_INIT2
		
		CLOSE C
		DEALLOCATE C
		DELETE FROM #TEMP_INIT
		DELETE FROM #TEMP_INIT2
	END	
	--CV End	


	
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
				INSERT INTO #TEMP_INIT2 SELECT distinct pod_cuspno from POORDDTL WHERE pod_cuspno between @tmp_fm and @tmp_to
				INSERT INTO #TEMP_INIT2 SELECT distinct poh_cuspno from POORDHDR WHERE poh_cuspno between @tmp_fm and @tmp_to
			END
			else
			BEGIN
				INSERT INTO #TEMP_INIT2 SELECT pod_cuspno from POORDDTL WHERE pod_cuspno like @token
				INSERT INTO #TEMP_INIT2 SELECT poh_cuspno from POORDHDR WHERE poh_cuspno like @token
			END
			FETCH NEXT FROM C into @token
		END
		INSERT INTO #TEMP_CUSTPO SELECT distinct tmp_init from #TEMP_INIT2
		CLOSE C
		DEALLOCATE C
		DELETE FROM #TEMP_INIT
		DELETE FROM #TEMP_INIT2
	END

	--*** Declare Result_ALL Start ***--
	DECLARE @TBL_ALL table(
		--key
		tmp_cussna nvarchar(200),
		tmp_cuspo nvarchar(200),
		tmp_vennam nvarchar(200),
		tmp_candat nvarchar(200),
		tmp_cussku nvarchar(200),
		tmp_engdsc nvarchar(2000),
		tmp_ordqty nvarchar(200),
		tmp_dest nvarchar(200),
		tmp_nowgetdate nvarchar(200),
		tmp_prctrm nvarchar(200),
		tmp_venno nvarchar(200)
		--tmp_venno nvarchar(6),
		
		--tmp_ordno nvarchar(20), --SC No
		--tmp_cuspno nvarchar(20), 
		--tmp_poshpstr datetime, --POHeader Ship Date
		--tmp_poshpend datetime,
		--tmp_scshpstr datetime,  --SCHeader Ship DAte
		--tmp_scshpend datetime		
	
	
	)
	

	INSERT INTO @TBL_ALL
	select c2.cbi_cussna,soh_cuspo, 
	vbi_vennam + ' / ' +yco_conam ,
	convert(varchar,(CONVERT(date,soh_candat,106)),106) ,
	sod_cussku,sod_itmdsc,
	case isnull(sds_ordqty,0) when 0 then sod_ordqty else isnull(sds_ordqty,0)end ,
	case isnull(sds_dest,0) when 0 then soh_dest else isnull(sds_dest,0) end,
	convert(varchar,(CONVERT(date,getdate(),106)),106), 
	case soh_prctrm when 'FOB HK' then 'AIR' else '' end,
	vbi_venno as vbi_venno
	from SCORDHDR
	left join SCORDDTL on soh_ordno = sod_ordno
	left join SCDTLSHP on sod_ordno = sds_ordno and sod_purseq = sds_seq
	left join VNBASINF on sod_venno = vbi_venno
	left join CUBASINF c1 on c1.cbi_cusno = soh_cus1no
	left join CUBASINF c2 on c2.cbi_cusno = soh_cus2no
	left join SYCOMINF on yco_cocde = soh_cocde
	WHERE 
	soh_cocde = @cocde
	--AND poh_pursts = 'REL'
	AND ((@flg_pricust = 'N') OR (@flg_pricust = 'Y' and soh_cus1no in (select tmp_cus1no from #TEMP_CUS1NO)))
	AND ((@flg_seccust = 'N') OR (@flg_seccust = 'Y' and soh_cus2no in (select tmp_cus2no from #TEMP_CUS2NO)))
	AND ((@flg_cv = 'N') OR ( @flg_cv = 'Y' and sod_venno in (select tmp_venno from #TEMP_CV)))	
	--AND ((@flg_fa = 'N') OR ( @flg_fa = 'Y' and qch_venno in (select tmp_examven from #TEMP_FA)))
	--AND ((@flg_scno = 'N') OR (@flg_scno = 'Y' and poh_ordno in (select tmp_scno from #TEMP_SCNO)))
	--AND ((@flg_pono = 'N') OR (@flg_pono = 'Y' and poh_purord in (select tmp_pono from #TEMP_PONO)))
	AND ((@flg_custpo = 'N') OR (@flg_custpo = 'Y' and (	soh_cuspo in (select tmp_custpo from #TEMP_CUSTPO))))
	--AND ((@flg_scshipdate_fm = 'N' OR (@flg_scshipdate_fm = 'Y' and (soh_shpstr >= @scshipdatefrom))))
	--AND ((@flg_scshipdate_to = 'N' OR (@flg_scshipdate_to = 'Y' and (soh_shpstr <= @scshipdateto))))
	AND ((@flg_poshipdate_fm = 'N' OR (@flg_poshipdate_fm = 'Y' and (soh_shpstr >= @poshipdatefrom))))
	AND ((@flg_poshipdate_to = 'N' OR (@flg_poshipdate_to = 'Y' and (soh_shpend <= @poshipdateto))))
	ORDER BY
		sod_cussku

if @poCanFlag = 'T'
BEGIN
   select 		
   *
	from @TBL_ALL
	order by tmp_cussna,tmp_cuspo , tmp_vennam
END

else
BEGIN
   select 		
   *
	from @TBL_ALL
	where tmp_ordqty <> '0'
	order by tmp_cussna,tmp_cuspo , tmp_vennam
END


end



GO
GRANT EXECUTE ON [dbo].[sp_select_QCM00010] TO [ERPUSER] AS [dbo]
GO
