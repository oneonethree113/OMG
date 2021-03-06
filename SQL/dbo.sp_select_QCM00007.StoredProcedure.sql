/****** Object:  StoredProcedure [dbo].[sp_select_QCM00007]    Script Date: 09/29/2017 15:29:09 ******/
DROP PROCEDURE [dbo].[sp_select_QCM00007]
GO
/****** Object:  StoredProcedure [dbo].[sp_select_QCM00007]    Script Date: 09/29/2017 15:29:10 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[sp_select_QCM00007]
	@cocde nvarchar(10), 
	@ponolist nvarchar(1000),
	@qcreqnolist nvarchar(1000), 
	@qcrptnolist nvarchar(1000),	
	@usrid nvarchar(30)

AS
BEGIN
	SET NOCOUNT ON
	
	CREATE table #TEMP_INIT(tmp_init nvarchar(1000)) on [PRIMARY]
	CREATE table #TEMP_INIT2(tmp_init nvarchar(50)) on [PRIMARY]

	CREATE table #TEMP_pono(tmp_pono nvarchar(50)) on [PRIMARY]
	CREATE table #TEMP_qcreqno(tmp_reqno nvarchar(50)) on [PRIMARY]
	CREATE table #TEMP_qcrptno(tmp_rptno nvarchar(50)) on [PRIMARY]

	
	DECLARE @token nvarchar(100)
	DECLARE @tmp_fm nvarchar(50)
	DECLARE @tmp_to nvarchar(50)
	
	DECLARE @flg_pono char(1),
	@flg_qcreqno char(1),
	@flg_qcrptno char(1)


	SET @flg_pono = 'N'
	SET @flg_qcreqno = 'N'
	SET @flg_qcrptno = 'N'

	
	--*** Insert Temp Table Start ***--
	--po no Start	
	IF ltrim(rtrim(@ponolist)) <> ''
	BEGIN
		SET @flg_pono = 'Y'
		--INSERT INTO #TEMP_INIT SELECT * FROM dbo.splitstring("10000~10001, 50100, 2% ")
		INSERT INTO #TEMP_INIT SELECT * FROM dbo.splitstring(@ponolist)
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
				INSERT INTO #TEMP_INIT2 SELECT poh_purord from POORDHDR WHERE poh_purord between @tmp_fm and @tmp_to 
			END
			else
			BEGIN
				INSERT INTO #TEMP_INIT2 SELECT poh_purord from POORDHDR WHERE poh_purord like @token  
			END
			FETCH NEXT FROM C into @token
		END
		INSERT INTO #TEMP_pono SELECT distinct tmp_init from #TEMP_INIT2
		--SELECT * FROM #TEMP_pono
		
		CLOSE C
		DEALLOCATE C
		DELETE FROM #TEMP_INIT
		DELETE FROM #TEMP_INIT2
	END
	--po no  End
	
	--req no Start
	IF ltrim(rtrim(@qcreqnolist)) <> ''
	BEGIN
		SET @flg_qcreqno = 'Y'
		--INSERT INTO #TEMP_INIT SELECT * FROM dbo.splitstring("10000~10001, 50100, 2% ")
		INSERT INTO #TEMP_INIT SELECT * FROM dbo.splitstring(@qcreqnolist)
		
		DECLARE c CURSOR FORWARD_ONLY FOR SELECT tmp_init from #TEMP_INIT
		OPEN C
		FETCH NEXT FROM C into @token
		
		WHILE @@FETCH_STATUS = 0 
		BEGIN
			if charindex('~', @token) <> 0
			BEGIN
				SET @tmp_fm = left(@token, charindex('~', @token)-1)
				SET @tmp_to = right(@token, len(@token) - charindex('~', @token))
				INSERT INTO #TEMP_INIT2 SELECT qch_qcno from qcreqhdr WHERE qch_qcno between @tmp_fm and @tmp_to  
			END
			else
			BEGIN
				INSERT INTO #TEMP_INIT2 SELECT qch_qcno from qcreqhdr  WHERE qch_qcno like @token 
			END
			FETCH NEXT FROM C into @token
		END
		INSERT INTO #TEMP_qcreqno SELECT distinct tmp_init from #TEMP_INIT2
		--SELECT * from #TEMP_qcreqno
		
		CLOSE C
		DEALLOCATE C
		DELETE FROM #TEMP_INIT
		DELETE FROM #TEMP_INIT2
		--req End
	END

	--rpt Start
	IF ltrim(rtrim(@qcrptnolist)) <> ''
	BEGIN
		SET @flg_qcrptno = 'Y'
		INSERT INTO #TEMP_INIT SELECT * FROM dbo.splitstring(@qcrptnolist)
		
		DECLARE c CURSOR FORWARD_ONLY FOR SELECT tmp_init from #TEMP_INIT
		OPEN C
		FETCH NEXT FROM C into @token
		
		WHILE @@FETCH_STATUS = 0 
		BEGIN
			if charindex('~', @token) <> 0
			BEGIN
				SET @tmp_fm = left(@token, charindex('~', @token)-1)
				SET @tmp_to = right(@token, len(@token) - charindex('~', @token))
				INSERT INTO #TEMP_INIT2 SELECT qrh_tmprptno from qcrpthdr WHERE qrh_tmprptno between @tmp_fm and @tmp_to
			END
			else
			BEGIN
				INSERT INTO #TEMP_INIT2 SELECT qrh_tmprptno from  qcrpthdr WHERE qrh_tmprptno like @token
			END
			FETCH NEXT FROM C into @token
		END
		INSERT INTO #TEMP_qcrptno SELECT distinct tmp_init from #TEMP_INIT2
		--SELECT * from #TEMP_qcrptno
		
		CLOSE C
		DEALLOCATE C
		DELETE FROM #TEMP_INIT
		DELETE FROM #TEMP_INIT2
	END	
	--rpt End

-- 	 select @flg_qcrptno
	-- select @flg_pono

--select * from #TEMP_qcreqno
--select tmp_reqno from #TEMP_qcreqno 

	CREATE table #TEMP_QC(
	qrh_postr   nvarchar(2000),
	qrh_tmprptno nvarchar(30),
	qrh_qcno nvarchar(30),
qrh_itmno nvarchar(30),
qrh_cusitm nvarchar(30),
qrh_itmdsc nvarchar(1000),
insdat datetime,
type  nvarchar(30),
qrh_rptstatus  nvarchar(50),
qrh_inspresult    nvarchar(50),
qrh_finalstatus  nvarchar(80),
qrh_shipapprv  nvarchar(90),
pdf nvarchar(50),
qrh_credat datetime,
qrh_upddat datetime,
qrh_updusr nvarchar(50),
	) 
	 

if @flg_pono = 'Y'  
begin

DECLARE @tmpponoName as NVARCHAR(50);
 DECLARE @tmpponoCursor as CURSOR;
 
SET @tmpponoCursor = CURSOR FOR
select tmp_pono from #TEMP_pono
 
OPEN @tmpponoCursor;
FETCH NEXT FROM @tmpponoCursor INTO  @tmpponoName;
 
WHILE @@FETCH_STATUS = 0
BEGIN


insert into #TEMP_QC
	
select 
distinct
qrh_postr + case qrh_morepo when '' then '' else ',' + qrh_morepo end as PO, 
qrh_tmprptno as 'rpt',
qrh_qcno as 'qc',
qrh_itmno as itm, 
qrh_cusitm as cuitm, 
qrh_itmdsc as itmdsc, 
convert(varchar(20),qrh_inspdat,101) as 'insdat',
case qrh_rpttyp when 'F' then 'Final' else 'In-Line' end as 'type',

qrh_rptstatus qrh_rptstatus, 
qrh_inspresult   qrd_inspresult,

qrh_finalstatus as 'finalstatus', 

qrh_shipapprv qrh_shipapprv,

qrh_tmprptno + '.pdf' as 'pdf', qrh_credat,
qrh_upddat,
qrh_updusr
from QCRPTHDR (nolock) 
left join QCRPTDTL (nolock) on qrd_tmprptno = qrh_tmprptno
--left join POULFILE (nolock) on puf_ordno = qrh_tmprptno
where 

	 	((@flg_qcrptno = 'N') OR ( @flg_qcrptno = 'Y' and qrh_tmprptno in (select tmp_rptno from #TEMP_qcrptno)) )
	AND	((@flg_pono = 'N') OR (@flg_pono = 'Y' and qrh_postr  like '%'+ @tmpponoName + '%') OR (@flg_pono = 'Y' and qrh_morepo  like '%'+ @tmpponoName + '%'))
	AND ((@flg_qcreqno = 'N') OR (@flg_qcreqno = 'Y' and qrh_qcno in (select tmp_reqno from #TEMP_qcreqno)) )
	and qrh_tmprptno not like 'QCP9%'
union all
select 
distinct
qrh_postr  as PO, 
qrh_tmprptno as 'rpt',
qrh_qcno as 'qc',
qrh_othitmno as itm, 
qrh_othcusitm as cuitm, 
qrh_itmdsc as itmdsc, 
convert(varchar(20),qrh_inspdat,101) as 'insdat',
case qrh_rpttyp when 'F' then 'Final' else 'In-Line' end as 'type',

qrh_rptstatus qrh_rptstatus, 
qrh_inspresult   qrd_inspresult,

qrh_finalstatus as 'finalstatus', 

qrh_shipapprv qrh_shipapprv,

qrh_tmprptno + '.pdf' as 'pdf',  qrh_credat,
qrh_upddat,
qrh_updusr
from QCRPTHDR (nolock) 
left join QCRPTDTL (nolock) on qrd_tmprptno = qrh_tmprptno
--left join POULFILE (nolock) on puf_ordno = qrh_tmprptno
where 
	 	((@flg_qcrptno = 'N') OR ( @flg_qcrptno = 'Y' and qrh_tmprptno in (select tmp_rptno from #TEMP_qcrptno)) )
	AND	((@flg_pono = 'N') OR (@flg_pono = 'Y' and qrh_othpostr  like '%'+ @tmpponoName + '%'))
	AND ((@flg_qcreqno = 'N') OR (@flg_qcreqno = 'Y' and qrh_qcno in (select tmp_reqno from #TEMP_qcreqno)) )
	and qrh_tmprptno not like 'QCP9%'




 FETCH NEXT FROM @tmpponoCursor INTO  @tmpponoName;
END
 
CLOSE @tmpponoCursor;
DEALLOCATE @tmpponoCursor;

end
else
begin

insert into #TEMP_QC
	
select 
distinct
qrh_postr  as 'po', 
qrh_tmprptno as 'rpt',
qrh_qcno as 'qc',
qrh_itmno as 'itm', 
qrh_cusitm as 'cuitm', 
qrh_itmdsc as 'itmdsc', 
convert(varchar(20),qrh_inspdat,101) as 'insdat',
case qrh_rpttyp when 'F' then 'Final' else 'In-Line' end as 'type',

qrh_rptstatus as  'qrh_rptstatus', 
qrh_inspresult as   'qrd_inspresult',

qrh_finalstatus as 'finalstatus', 

qrh_shipapprv as 'qrh_shipapprv',

qrh_tmprptno + '.pdf' as 'pdf',  qrh_credat,
qrh_upddat,
qrh_updusr
from QCRPTHDR (nolock) 
left join QCRPTDTL (nolock) on qrd_tmprptno = qrh_tmprptno
--left join POULFILE (nolock) on puf_ordno = qrh_tmprptno
where 

	 	((@flg_qcrptno = 'N') OR ( @flg_qcrptno = 'Y' and qrh_tmprptno in (select tmp_rptno from #TEMP_qcrptno)) )
	AND ((@flg_qcreqno = 'N') OR (@flg_qcreqno = 'Y' and qrh_qcno in (select tmp_reqno from #TEMP_qcreqno)) )
	and qrh_tmprptno not like 'QCP9%'
end


select 	
qrh_postr,
qrh_tmprptno,
qrh_qcno,
qrh_itmno,
qrh_cusitm,
qrh_itmdsc,
insdat,
[type],
qrh_rptstatus,
qrh_inspresult,
qrh_finalstatus,
qrh_shipapprv,
pdf,
qrh_credat,
qrh_upddat,
qrh_updusr from #TEMP_QC
order by qrh_credat --desc

drop table #TEMP_QC
END



GO
GRANT EXECUTE ON [dbo].[sp_select_QCM00007] TO [ERPUSER] AS [dbo]
GO
