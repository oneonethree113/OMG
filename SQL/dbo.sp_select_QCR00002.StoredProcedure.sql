/****** Object:  StoredProcedure [dbo].[sp_select_QCR00002]    Script Date: 09/29/2017 15:29:09 ******/
DROP PROCEDURE [dbo].[sp_select_QCR00002]
GO
/****** Object:  StoredProcedure [dbo].[sp_select_QCR00002]    Script Date: 09/29/2017 15:29:10 ******/
SET ANSI_NULLS OFF
GO
SET QUOTED_IDENTIFIER ON
GO


--sp_select_QCR00002 '', ''

CREATE PROCEDURE [dbo].[sp_select_QCR00002] 
@cocde as nvarchar(6),
@qcnolist as nvarchar(2000)

AS

BEGIN

set nocount on


declare @RESULT_FULL table (
res_inspyear	nvarchar(50),
res_inspweek	nvarchar(50),
res_qcno	nvarchar(20),
res_qcsts	nvarchar(20),
res_venno	nvarchar(10),
res_vensna	nvarchar(50),
res_stt		nvarchar(50),
res_cty		nvarchar(50),
res_town	nvarchar(50),
res_customer	nvarchar(50),
res_cuspo	nvarchar(500),
res_purord	nvarchar(500),
res_season	nvarchar(500),
res_cussku	nvarchar(500),
res_skucount	int,
res_scsw	nvarchar(500),
res_posw	nvarchar(500),
res_sidat	nvarchar(20),
res_cydat	nvarchar(20),
res_mon		nvarchar(20),
res_tue		nvarchar(20),
res_wed		nvarchar(20),
res_thur	nvarchar(20),
res_fri		nvarchar(20),
res_sat		nvarchar(20),
res_sun		nvarchar(20),
res_ftyadr	nvarchar(300),
res_cnt		nvarchar(200),
res_sample	nvarchar(50),
res_hksale	nvarchar(20),
res_szsale	nvarchar(20),
res_insptyp	nvarchar(20)
)

declare @RESULT_FINAL table (
res_inspyear	nvarchar(50),
res_inspweek	nvarchar(50),
res_mon		nvarchar(50),
res_tue		nvarchar(50),
res_wed		nvarchar(50),
res_thur	nvarchar(50),
res_fri		nvarchar(50),
res_sat		nvarchar(50),
res_sun		nvarchar(50)
)


insert into @RESULT_FULL
select 
qch_inspyear,
qch_inspweek,
qch_qcno,
qch_qcsts,
qch_venno,
vbi_vensna,
adr.vci_stt,
adr.vci_cty,
'',--Town
case isnull(sec.cbi_cussna,'')
when '' then pri.cbi_cussna else sec.cbi_cussna end as 'customer',
soh_cuspo,
qcd_purord,
sod_season,
sod_cussku,
0,
left(convert(varchar(20),sod_shpstr,103),5) + ' - ' + left(convert(varchar(20),sod_shpend,103),5),
left(convert(varchar(20),pod_shpstr,103),5) + ' - ' + left(convert(varchar(20),pod_shpend,103),5),
convert(varchar(20),getdate(),103),
convert(varchar(20),getdate(),103),
qch_mon,
qch_tue,
qch_wed,
qch_thur,
qch_fri,
qch_sat,
qch_sun,
adr.vci_chnadr,
isnull(cnt.vci_cntctp + ' : ' + cnt.vci_cntphn,''),
'',
pri.cbi_srname,
pri.cbi_srname,
qch_insptyp
from QCREQHDR (nolock)
left join QCREQDTL (nolock) on qch_qcno = qcd_qcno
left join POORDDTL (nolock) on pod_purord = qcd_purord and pod_purseq = qcd_purseq
--left join SCORDDTL (nolock) on sod_ordno = pod_scno and sod_ordseq = pod_scline
left join SCORDDTL (nolock) on sod_purord = pod_purord and sod_purseq = pod_purseq
left join SCORDHDR (nolock) on soh_ordno = sod_ordno
left join VNBASINF (nolock) on vbi_venno = qch_venno
left join VNCNTINF adr (nolock) on adr.vci_venno = vbi_venno and adr.vci_cnttyp = 'M'
left join VNCNTINF cnt (nolock) on cnt.vci_venno = vbi_venno and cnt.vci_cnttyp = 'MAGT'
left join CUBASINF (nolock) pri on qch_prmcus = pri.cbi_cusno
left join CUBASINF (nolock) sec on qch_seccus = sec.cbi_cusno
order by qch_qcno






insert into @RESULT_FINAL
select distinct res_inspyear,res_inspweek,res_vensna,'','','','','','' from @RESULT_FULL where res_mon = 'Y'

insert into @RESULT_FINAL
select distinct res_inspyear,res_inspweek,'',res_vensna,'','','','','' from @RESULT_FULL where res_tue = 'Y'

insert into @RESULT_FINAL
select distinct res_inspyear,res_inspweek,'','',res_vensna,'','','','' from @RESULT_FULL where res_wed = 'Y'

insert into @RESULT_FINAL
select distinct res_inspyear,res_inspweek,'','','',res_vensna,'','','' from @RESULT_FULL where res_thur = 'Y'

insert into @RESULT_FINAL
select distinct res_inspyear,res_inspweek,'','','','',res_vensna,'','' from @RESULT_FULL where res_fri = 'Y'

insert into @RESULT_FINAL
select distinct res_inspyear,res_inspweek,'','','','','',res_vensna,'' from @RESULT_FULL where res_sat = 'Y'

insert into @RESULT_FINAL
select distinct res_inspyear,res_inspweek,'','','','','','',res_vensna from @RESULT_FULL where res_sun = 'Y'


select * from @RESULT_FINAL


END



GO
GRANT EXECUTE ON [dbo].[sp_select_QCR00002] TO [ERPUSER] AS [dbo]
GO
