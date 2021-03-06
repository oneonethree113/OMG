/****** Object:  StoredProcedure [dbo].[sp_select_SCORDDTL_QCApp]    Script Date: 09/29/2017 15:29:09 ******/
DROP PROCEDURE [dbo].[sp_select_SCORDDTL_QCApp]
GO
/****** Object:  StoredProcedure [dbo].[sp_select_SCORDDTL_QCApp]    Script Date: 09/29/2017 15:29:10 ******/
SET ANSI_NULLS OFF
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE procedure [dbo].[sp_select_SCORDDTL_QCApp]

AS

BEGIN

/*
declare @TMP_PONO table (
id            int identity(1,1),
PONO nvarchar(20)
)

insert into @TMP_PONO (PONO)
select distinct qpd_purord from QCPORDTL
order by qpd_purord


declare @TMP_SCNO table (
id     int identity(1,1),
SCNO nvarchar(20)
)

insert into @TMP_SCNO (SCNO)
select distinct soh_ordno FROM @TMP_PONO
LEFT JOIN POORDHDR ON poh_purord = PONO
LEFT JOIN SCORDHDR ON poh_ordno = soh_ordno
LEFT JOIN QCREQDTL on poh_purord = qcd_purord
LEFT JOIN QCREQHDR on qcd_qcno = qch_qcno
LEFT JOIN QCPORDTL on qcd_purord = qpd_purord 
and qch_inspweek > DATEPART(wk,GETDATE()) -3 and qch_inspyear = YEAR(GETDATE())
order by soh_ordno

SELECT 
 sod_cocde
,sod_ordno
,sod_ordseq
,sod_updpo
,sod_chgfty
,sod_itmno
,sod_itmsts
,sod_itmtyp
,sod_itmdsc
,sod_colcde
,sod_cuscol
,sod_coldsc
,sod_pckseq
,sod_pckunt
,sod_inrctn
,sod_mtrctn
,sod_cft
,sod_cbm
,sod_qutno
,convert(char, sod_refdat,120) sod_refdat
,sod_cusitm
,sod_cussku
,sod_resppo
,sod_cuspo
,sod_ordqty
,sod_discnt
,sod_orgmoqchg
,sod_moqchg
,sod_oneprc
,sod_curcde
,sod_untprc
,sod_netuntprc
,sod_selprc
,sod_hrmcde
,sod_dtyrat
,sod_dept
,sod_typcode
,sod_code1
,sod_code2
,sod_code3
,sod_cususdcur
,sod_cususd
,sod_cuscadcur
,sod_cuscad
,sod_inrdin
,sod_inrwin
,sod_inrhin
,sod_mtrdin
,sod_mtrwin
,sod_mtrhin
,sod_inrdcm
,sod_inrwcm
,sod_inrhcm
,sod_mtrdcm
,sod_mtrwcm
,sod_mtrhcm
,convert(char, sod_shpstr,120) sod_shpstr
,convert(char, sod_shpend,120) sod_shpend
,convert(char, sod_candat,120) sod_candat
,convert(char, sod_posstr,120) sod_posstr
,convert(char, sod_posend,120) sod_posend
,convert(char, sod_poscan,120) sod_poscan
,sod_ctnstr
,sod_ctnend
,sod_ttlctn
,sod_rmk
,sod_pormk
,sod_invqty
,sod_shpqty
,sod_venno
,sod_oldven
,sod_tradeven
,sod_examven
,sod_purord
,sod_purseq
,sod_oldpurord
,sod_oldpurseq
,sod_ftycst
,sod_ftyprc
,sod_bomcst
,sod_fcurcde
,sod_ftyunt
,sod_venitm
,sod_itmprc
,sod_basprc
,sod_subcde
,sod_tirtyp
,sod_moq
,sod_moa
,sod_apprve
,sod_clmno
,sod_pckitr
,sod_orgvenno
,sod_assitmcount
,sod_cusmoqchg
,sod_venmoqchg
,sod_runno
,sod_fmlopt
,sod_fml
,sod_mubasprc
,sod_cusven
,sod_cussub
,sod_pjobno
,sod_seccusitm
,sod_alsitmno
,sod_alscolcde
,sod_ztnvbeln
,sod_ztnposnr
,sod_zorvbeln
,sod_zorposnr
,sod_conftr
,sod_contopc
,sod_pcprc
,sod_custum
,sod_dv
,sod_dvftycst
,sod_dvftyprc
,sod_dvbomcst
,sod_dvfcurcde
,sod_dvftyunt
,sod_cusstyno
,sod_moqunttyp
,convert(char, sod_qutdat,120) sod_qutdat
,convert(char, sod_imqutdat,120) sod_imqutdat
,sod_itmcstcur
,sod_dvitmcst
,sod_ftycst_org
,sod_bomcst_org
,sod_ftyprc_org
,sod_dvftycst_org
,sod_dvftyprc_org
,sod_dvbomcst_org
,convert(char, sod_imqutdat_org,120) sod_imqutdat_org
,sod_venno_org
,sod_fcurcde_org
,sod_dvfcurcde_org
,sod_imqutdatchg
,sod_prcgrp
,sod_cus1no
,sod_cus2no
,sod_hkprctrm
,sod_ftyprctrm
,sod_trantrm
,sod_effcpo
,convert(char, sod_effdat,120) sod_effdat
,convert(char, sod_expdat,120) sod_expdat
,sod_tordno
,sod_tordseq
,sod_year
,sod_season
,sod_markup
,sod_mumin
,sod_mrkprc
,sod_muminprc
,sod_commsn
,sod_itmcom
,sod_pckcst
,sod_stdprc
,sod_covqty
,sod_name_f1
,sod_dsc_f1
,sod_name_f2
,sod_dsc_f2
,sod_name_f3
,sod_dsc_f3
,sod_creusr
,sod_updusr
,convert(char, sod_credat,120) sod_credat
,convert(char, sod_upddat,120) sod_upddat
,null sod_timstp
FROM SCORDDTL left join @TMP_SCNO tmp
ON tmp.SCNO = sod_ordno
where tmp.SCNO is not null

*/

SELECT 
 sod_cocde
,sod_ordno
,sod_ordseq
,sod_updpo
,sod_chgfty
,sod_itmno
,sod_itmsts
,sod_itmtyp
,sod_itmdsc
,sod_colcde
,sod_cuscol
,sod_coldsc
,sod_pckseq
,sod_pckunt
,sod_inrctn
,sod_mtrctn
,sod_cft
,sod_cbm
,sod_qutno
,convert(char, sod_refdat,120) sod_refdat
,sod_cusitm
,sod_cussku
,sod_resppo
,sod_cuspo
,sod_ordqty
,sod_discnt
,sod_orgmoqchg
,sod_moqchg
,sod_oneprc
,sod_curcde
,sod_untprc
,sod_netuntprc
,sod_selprc
,sod_hrmcde
,sod_dtyrat
,sod_dept
,sod_typcode
,sod_code1
,sod_code2
,sod_code3
,sod_cususdcur
,sod_cususd
,sod_cuscadcur
,sod_cuscad
,sod_inrdin
,sod_inrwin
,sod_inrhin
,sod_mtrdin
,sod_mtrwin
,sod_mtrhin
,sod_inrdcm
,sod_inrwcm
,sod_inrhcm
,sod_mtrdcm
,sod_mtrwcm
,sod_mtrhcm
,convert(char, sod_shpstr,120) sod_shpstr
,convert(char, sod_shpend,120) sod_shpend
,convert(char, sod_candat,120) sod_candat
,convert(char, sod_posstr,120) sod_posstr
,convert(char, sod_posend,120) sod_posend
,convert(char, sod_poscan,120) sod_poscan
,sod_ctnstr
,sod_ctnend
,sod_ttlctn
,sod_rmk
,sod_pormk
,sod_invqty
,sod_shpqty
,sod_venno
,sod_oldven
,sod_tradeven
,sod_examven
,sod_purord
,sod_purseq
,sod_oldpurord
,sod_oldpurseq
,sod_ftycst
,sod_ftyprc
,sod_bomcst
,sod_fcurcde
,sod_ftyunt
,sod_venitm
,sod_itmprc
,sod_basprc
,sod_subcde
,sod_tirtyp
,sod_moq
,sod_moa
,sod_apprve
,sod_clmno
,sod_pckitr
,sod_orgvenno
,sod_assitmcount
,sod_cusmoqchg
,sod_venmoqchg
,sod_runno
,sod_fmlopt
,sod_fml
,sod_mubasprc
,sod_cusven
,sod_cussub
,sod_pjobno
,sod_seccusitm
,sod_alsitmno
,sod_alscolcde
,sod_ztnvbeln
,sod_ztnposnr
,sod_zorvbeln
,sod_zorposnr
,sod_conftr
,sod_contopc
,sod_pcprc
,sod_custum
,sod_dv
,sod_dvftycst
,sod_dvftyprc
,sod_dvbomcst
,sod_dvfcurcde
,sod_dvftyunt
,sod_cusstyno
,sod_moqunttyp
,convert(char, sod_qutdat,120) sod_qutdat
,convert(char, sod_imqutdat,120) sod_imqutdat
,sod_itmcstcur
,sod_dvitmcst
,sod_ftycst_org
,sod_bomcst_org
,sod_ftyprc_org
,sod_dvftycst_org
	,sod_dvftyprc_org
,sod_dvbomcst_org
,convert(char, sod_imqutdat_org,120) sod_imqutdat_org
,sod_venno_org
,sod_fcurcde_org
,sod_dvfcurcde_org
,sod_imqutdatchg
,sod_prcgrp
,sod_cus1no
,sod_cus2no
,sod_hkprctrm
,sod_ftyprctrm
,sod_trantrm
,sod_effcpo
,convert(char, sod_effdat,120) sod_effdat
,convert(char, sod_expdat,120) sod_expdat
,sod_tordno
,sod_tordseq
,sod_year
,sod_season
,sod_markup
,sod_mumin
,sod_mrkprc
,sod_muminprc
,sod_commsn
,sod_itmcom
,sod_pckcst
,sod_stdprc
,sod_covqty
,sod_name_f1
,sod_dsc_f1
,sod_name_f2
,sod_dsc_f2
,sod_name_f3
,sod_dsc_f3
,sod_creusr
,sod_updusr
,convert(char, sod_credat,120) sod_credat
,convert(char, sod_upddat,120) sod_upddat
,null sod_timstp
from QCREQHDR (nolock)
LEFT JOIN QCREQDTL (nolock) on qch_qcno = qcd_qcno
left join POORDDTL (nolock) on pod_purord = qcd_purord and pod_purseq = qcd_purseq
left join SCORDDTL (nolock) on sod_ordno = pod_scno and sod_ordseq = pod_scline
where qch_inspweek > DATEPART(wk,GETDATE()) -3 and qch_inspyear = YEAR(GETDATE())
and sod_cocde is not null









END





SET QUOTED_IDENTIFIER OFF 

GO
GRANT EXECUTE ON [dbo].[sp_select_SCORDDTL_QCApp] TO [ERPUSER] AS [dbo]
GO
