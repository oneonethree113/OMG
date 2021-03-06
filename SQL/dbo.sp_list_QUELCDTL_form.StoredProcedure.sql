/****** Object:  StoredProcedure [dbo].[sp_list_QUELCDTL_form]    Script Date: 09/29/2017 15:29:09 ******/
DROP PROCEDURE [dbo].[sp_list_QUELCDTL_form]
GO
/****** Object:  StoredProcedure [dbo].[sp_list_QUELCDTL_form]    Script Date: 09/29/2017 15:29:10 ******/
SET ANSI_NULLS OFF
GO
SET QUOTED_IDENTIFIER OFF
GO





CREATE  PROCEDURE [dbo].[sp_list_QUELCDTL_form] 

@cocde	nvarchar(6),
@qutno	nvarchar(20),
@qutseq int

AS

create table #TEMP_QUELCDTL
(
qec_cocde	nvarchar(10),
qec_qutno	nvarchar(20),
qec_qutseq	int,
qec_grpcde	nvarchar(6),
qec_grpdsc	nvarchar(200),
qec_curcde	nvarchar(6),
qec_amt		numeric(13,4),

qed_cecde01	nvarchar(6),
qed_cedsc01	nvarchar(200),
qed_percent01	numeric(13,4),
qed_curcde01	nvarchar(6),
qed_amt01	numeric(13,4),
qed_cecde02	nvarchar(6),
qed_cedsc02	nvarchar(200),
qed_percent02	numeric(13,4),
qed_curcde02	nvarchar(6),
qed_amt02	numeric(13,4),
qed_cecde03	nvarchar(6),
qed_cedsc03	nvarchar(200),
qed_percent03	numeric(13,4),
qed_curcde03	nvarchar(6),
qed_amt03	numeric(13,4),
qed_cecde04	nvarchar(6),
qed_cedsc04	nvarchar(200),
qed_percent04	numeric(13,4),
qed_curcde04	nvarchar(6),
qed_amt04	numeric(13,4),
qed_cecde05	nvarchar(6),
qed_cedsc05	nvarchar(200),
qed_percent05	numeric(13,4),
qed_curcde05	nvarchar(6),
qed_amt05	numeric(13,4),
qed_cecde06	nvarchar(6),
qed_cedsc06	nvarchar(200),
qed_percent06	numeric(13,4),
qed_curcde06	nvarchar(6),
qed_amt06	numeric(13,4),
qed_cecde07	nvarchar(6),
qed_cedsc07	nvarchar(200),
qed_percent07	numeric(13,4),
qed_curcde07	nvarchar(6),
qed_amt07	numeric(13,4),
qed_cecde08	nvarchar(6),
qed_cedsc08	nvarchar(200),
qed_percent08	numeric(13,4),
qed_curcde08	nvarchar(6),
qed_amt08	numeric(13,4),
qed_cecde09	nvarchar(6),
qed_cedsc09	nvarchar(200),
qed_percent09	numeric(13,4),
qed_curcde09	nvarchar(6),
qed_amt09	numeric(13,4),
qed_cecde10	nvarchar(6),
qed_cedsc10	nvarchar(200),
qed_percent10	numeric(13,4),
qed_curcde10	nvarchar(6),
qed_amt10	numeric(13,4)
)

declare @custno nvarchar(6)

select @custno = case quh_cus2no when '' then quh_cus1no else quh_cus2no end 
from QUOTNHDR where quh_cocde = @cocde and quh_qutno = @qutno

insert into #TEMP_QUELCDTL
select 
qec_cocde,
qec_qutno,
qec_qutseq,
qec_grpcde,
cec_grpdsc,
qec_curcde,
qec_amt,
-- QUELCDTL
'01','',0,'',0,
'02','',0,'',0,
'03','',0,'',0,
'04','',0,'',0,
'05','',0,'',0,
'06','',0,'',0,
'07','',0,'',0,
'08','',0,'',0,
'09','',0,'',0,
'10','',0,'',0
from QUELC 
left join CUELC on cec_grpcde = qec_grpcde and cec_cusno = @custno
where qec_qutno = @qutno
and qec_qutseq = @qutseq


update #TEMP_QUELCDTL set qed_cedsc01 = ysi_dsc, qed_percent01 = qed_percent, qed_curcde01 = qed_curcde, qed_amt01 = qed_amt
from #TEMP_QUELCDTL, QUELCDTL, SYSETINF
where qec_cocde = qed_cocde and qec_qutno = qed_qutno and qec_qutseq = qed_qutseq 
and qed_cecde = qed_cecde01 and ysi_cde = qed_cecde01 and ysi_typ = '17'

update #TEMP_QUELCDTL set qed_cedsc02 = ysi_dsc, qed_percent02 = qed_percent, qed_curcde02 = qed_curcde, qed_amt02 = qed_amt
from #TEMP_QUELCDTL, QUELCDTL, SYSETINF
where qec_cocde = qed_cocde and qec_qutno = qed_qutno and qec_qutseq = qed_qutseq 
and qed_cecde = qed_cecde02 and ysi_cde = qed_cecde02 and ysi_typ = '17'

update #TEMP_QUELCDTL set qed_cedsc03 = ysi_dsc, qed_percent03 = qed_percent, qed_curcde03 = qed_curcde, qed_amt03 = qed_amt
from #TEMP_QUELCDTL, QUELCDTL, SYSETINF
where qec_cocde = qed_cocde and qec_qutno = qed_qutno and qec_qutseq = qed_qutseq 
and qed_cecde = qed_cecde03 and ysi_cde = qed_cecde03 and ysi_typ = '17'

update #TEMP_QUELCDTL set qed_cedsc04 = ysi_dsc, qed_percent04 = qed_percent, qed_curcde04 = qed_curcde, qed_amt04 = qed_amt
from #TEMP_QUELCDTL, QUELCDTL, SYSETINF
where qec_cocde = qed_cocde and qec_qutno = qed_qutno and qec_qutseq = qed_qutseq 
and qed_cecde = qed_cecde04 and ysi_cde = qed_cecde04 and ysi_typ = '17'

update #TEMP_QUELCDTL set qed_cedsc05 = ysi_dsc, qed_percent05 = qed_percent, qed_curcde05 = qed_curcde, qed_amt05 = qed_amt
from #TEMP_QUELCDTL, QUELCDTL, SYSETINF
where qec_cocde = qed_cocde and qec_qutno = qed_qutno and qec_qutseq = qed_qutseq 
and qed_cecde = qed_cecde05 and ysi_cde = qed_cecde05 and ysi_typ = '17'

update #TEMP_QUELCDTL set qed_cedsc06 = ysi_dsc, qed_percent06 = qed_percent, qed_curcde06 = qed_curcde, qed_amt06 = qed_amt
from #TEMP_QUELCDTL, QUELCDTL, SYSETINF
where qec_cocde = qed_cocde and qec_qutno = qed_qutno and qec_qutseq = qed_qutseq 
and qed_cecde = qed_cecde06 and ysi_cde = qed_cecde06 and ysi_typ = '17'

update #TEMP_QUELCDTL set qed_cedsc07 = ysi_dsc, qed_percent07 = qed_percent, qed_curcde07 = qed_curcde, qed_amt07 = qed_amt
from #TEMP_QUELCDTL, QUELCDTL, SYSETINF
where qec_cocde = qed_cocde and qec_qutno = qed_qutno and qec_qutseq = qed_qutseq 
and qed_cecde = qed_cecde07 and ysi_cde = qed_cecde07 and ysi_typ = '17'

update #TEMP_QUELCDTL set qed_cedsc08 = ysi_dsc, qed_percent08 = qed_percent, qed_curcde08 = qed_curcde, qed_amt08 = qed_amt
from #TEMP_QUELCDTL, QUELCDTL, SYSETINF
where qec_cocde = qed_cocde and qec_qutno = qed_qutno and qec_qutseq = qed_qutseq 
and qed_cecde = qed_cecde08 and ysi_cde = qed_cecde08 and ysi_typ = '17'

update #TEMP_QUELCDTL set qed_cedsc09 = ysi_dsc, qed_percent09 = qed_percent, qed_curcde09 = qed_curcde, qed_amt09 = qed_amt
from #TEMP_QUELCDTL, QUELCDTL, SYSETINF
where qec_cocde = qed_cocde and qec_qutno = qed_qutno and qec_qutseq = qed_qutseq 
and qed_cecde = qed_cecde09 and ysi_cde = qed_cecde09 and ysi_typ = '17'

update #TEMP_QUELCDTL set qed_cedsc10 = ysi_dsc, qed_percent10 = qed_percent, qed_curcde10 = qed_curcde, qed_amt10 = qed_amt
from #TEMP_QUELCDTL, QUELCDTL, SYSETINF
where qec_cocde = qed_cocde and qec_qutno = qed_qutno and qec_qutseq = qed_qutseq 
and qed_cecde = qed_cecde10 and ysi_cde = qed_cecde10 and ysi_typ = '17'



select * from #TEMP_QUELCDTL






GO
GRANT EXECUTE ON [dbo].[sp_list_QUELCDTL_form] TO [ERPUSER] AS [dbo]
GO
