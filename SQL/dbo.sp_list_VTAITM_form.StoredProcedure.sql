/****** Object:  StoredProcedure [dbo].[sp_list_VTAITM_form]    Script Date: 09/29/2017 15:29:09 ******/
DROP PROCEDURE [dbo].[sp_list_VTAITM_form]
GO
/****** Object:  StoredProcedure [dbo].[sp_list_VTAITM_form]    Script Date: 09/29/2017 15:29:10 ******/
SET ANSI_NULLS OFF
GO
SET QUOTED_IDENTIFIER OFF
GO


CREATE  PROCEDURE [dbo].[sp_list_VTAITM_form] 

@cocde	nvarchar(6),
@qutno		nvarchar(20)

AS

declare @custno nvarchar(6)

select @custno = case quh_cus2no when '' then quh_cus1no else quh_cus2no end 
from QUOTNHDR where quh_cocde = @cocde and quh_qutno = @qutno

select

qud_qutno,	-- quotion number
qud_qutseq,	-- quotion sequence
'' as 'vta_dcpino01', --DPCI# L01
'' as 'vta_desc01', --Description L01
'' as 'vta_fob01', --FOB L01
(select qec_amt from QUELC where qec_grpcde = '001' and qec_qutseq = 1 and qec_qutno = qud_qutno) as 'vta_elc01', --ELC L01
'' as 'vta_retail01', --Retail L01
'' as 'vta_dcpino02', --DPCI# L02
'' as 'vta_desc02', --Description L02
'' as 'vta_fob02', --FOB L02
'' as 'vta_elc02', --ELC L02
'' as 'vta_retail02', --Retail L02
'' as 'vta_dcpino03', --DPCI# L03
'' as 'vta_desc03', --Description L03
'' as 'vta_fob03', --FOB L03
'' as 'vta_elc03', --ELC L03
'' as 'vta_retail03', --Retail L03
'' as 'vta_dcpino04', --DPCI# L04
'' as 'vta_desc04', --Description L04
'' as 'vta_fob04', --FOB L04
'' as 'vta_elc04', --ELC L04
'' as 'vta_retail04', --Retail L04
'' as 'vta_dcpino05', --DPCI# L05
'' as 'vta_desc05', --Description L05
'' as 'vta_fob05', --FOB L05
'' as 'vta_elc05', --ELC L05
'' as 'vta_retail05', --Retail L05
'' as 'vta_dcpino06', --DPCI# L06
'' as 'vta_desc06', --Description L06
'' as 'vta_fob06', --FOB L06
'' as 'vta_elc06', --ELC L06
'' as 'vta_retail06', --Retail L06
'' as 'vta_dcpino07', --DPCI# L07
'' as 'vta_desc07', --Description L07
'' as 'vta_fob07', --FOB L07
'' as 'vta_elc07', --ELC L07
'' as 'vta_retail07', --Retail L07
'' as 'vta_dcpino08', --DPCI# L08
'' as 'vta_desc08', --Description L08
'' as 'vta_fob08', --FOB L08
'' as 'vta_elc08', --ELC L08
'' as 'vta_retail08', --Retail L08
'' as 'vta_dcpino09', --DPCI# L09
'' as 'vta_desc09', --Description L09
'' as 'vta_fob09', --FOB L09
'' as 'vta_elc09', --ELC L09
'' as 'vta_retail09', --Retail L09
'' as 'vta_dcpino10', --DPCI# L10
'' as 'vta_desc10', --Description L10
'' as 'vta_fob10', --FOB L10
'' as 'vta_elc10', --ELC L10
'' as 'vta_retail10', --Retail L10
'' as 'vta_dcpino11', --DPCI# L11
'' as 'vta_desc11', --Description L11
'' as 'vta_fob11', --FOB L11
'' as 'vta_elc11', --ELC L11
'' as 'vta_retail11', --Retail L11
'' as 'vta_dcpino12', --DPCI# L12
'' as 'vta_desc12', --Description L12
'' as 'vta_fob12', --FOB L12
'' as 'vta_elc12', --ELC L12
'' as 'vta_retail12', --Retail L12
'' as 'vta_dcpino13', --DPCI# L13
'' as 'vta_desc13', --Description L13
'' as 'vta_fob13', --FOB L13
'' as 'vta_elc13', --ELC L13
'' as 'vta_retail13', --Retail L13
'' as 'vta_dcpino14', --DPCI# L14
'' as 'vta_desc14', --Description L14
'' as 'vta_fob14', --FOB L14
'' as 'vta_elc14', --ELC L14
'' as 'vta_retail14', --Retail L14
'' as 'vta_dcpino15', --DPCI# L15
'' as 'vta_desc15', --Description L15
'' as 'vta_fob15', --FOB L15
'' as 'vta_elc15', --ELC L15
'' as 'vta_retail15', --Retail L15
'' as 'vta_dcpino16', --DPCI# L16
'' as 'vta_desc16', --Description L16
'' as 'vta_fob16', --FOB L16
'' as 'vta_elc16', --ELC L16
'' as 'vta_retail16', --Retail L16
'' as 'vta_dcpino17', --DPCI# L17
'' as 'vta_desc17', --Description L17
'' as 'vta_fob17', --FOB L17
'' as 'vta_elc17', --ELC L17
'' as 'vta_retail17', --Retail L17
'' as 'vta_dcpino18', --DPCI# L18
'' as 'vta_desc18', --Description L18
'' as 'vta_fob18', --FOB L18
'' as 'vta_elc18', --ELC L18
'' as 'vta_retail18', --Retail L18
'' as 'vta_dcpino19', --DPCI# L19
'' as 'vta_desc19', --Description L19
'' as 'vta_fob19', --FOB L19
'' as 'vta_elc19', --ELC L19
'' as 'vta_retail19', --Retail L19
'' as 'vta_dcpino20', --DPCI# L20
'' as 'vta_desc20', --Description L20
'' as 'vta_fob20', --FOB L20
'' as 'vta_elc20', --ELC L20
'' as 'vta_retail20', --Retail L20
'' as 'vta_dcpino21', --DPCI# L21
'' as 'vta_desc21', --Description L21
'' as 'vta_fob21', --FOB L21
'' as 'vta_elc21', --ELC L21
'' as 'vta_retail21', --Retail L21
'' as 'vta_dcpino22', --DPCI# L22
'' as 'vta_desc22', --Description L22
'' as 'vta_fob22', --FOB L22
'' as 'vta_elc22', --ELC L22
'' as 'vta_retail22', --Retail L22
'' as 'vta_dcpino23', --DPCI# L23
'' as 'vta_desc23', --Description L23
'' as 'vta_fob23', --FOB L23
'' as 'vta_elc23', --ELC L23
'' as 'vta_retail23', --Retail L23
'' as 'vta_dcpino24', --DPCI# L24
'' as 'vta_desc24', --Description L24
'' as 'vta_fob24', --FOB L24
'' as 'vta_elc24', --ELC L24
'' as 'vta_retail24', --Retail L24
'' as 'vta_dcpino25', --DPCI# L25
'' as 'vta_desc25', --Description L25
'' as 'vta_fob25', --FOB L25
'' as 'vta_elc25', --ELC L25
'' as 'vta_retail25', --Retail L25
'' as 'vta_dcpino26', --DPCI# L26
'' as 'vta_desc26', --Description L26
'' as 'vta_fob26', --FOB L26
'' as 'vta_elc26', --ELC L26
'' as 'vta_retail26', --Retail L26
'' as 'vta_dcpino27', --DPCI# L27
'' as 'vta_desc27', --Description L27
'' as 'vta_fob27', --FOB L27
'' as 'vta_elc27', --ELC L27
'' as 'vta_retail27', --Retail L27
'' as 'vta_dcpino28', --DPCI# L28
'' as 'vta_desc28', --Description L28
'' as 'vta_fob28', --FOB L28
'' as 'vta_elc28', --ELC L28
'' as 'vta_retail28', --Retail L28
'' as 'vta_dcpino29', --DPCI# L29
'' as 'vta_desc29', --Description L29
'' as 'vta_fob29', --FOB L29
'' as 'vta_elc29', --ELC L29
'' as 'vta_retail29', --Retail L29
'' as 'vta_dcpino30', --DPCI# L30
'' as 'vta_desc30', --Description L30
'' as 'vta_fob30', --FOB L30
'' as 'vta_elc30', --ELC L30
'' as 'vta_retail30' --Retail L30

from QUOTNDTL (nolock)
left join QUOTNHDR (nolock) on quh_cocde = qud_cocde and quh_qutno = qud_qutno
left join SYCOMINF (nolock) on yco_cocde = qud_cocde
left join VNBASINF (nolock) on vbi_venno = qud_venno
left join SYSETINF sys03 (nolock) on sys03.ysi_cde = qud_prctrm and ysi_typ = '03'
left join QUCSTEMT ce04 (nolock) on ce04.qce_cocde = qud_cocde and ce04.qce_qutno = qud_qutno and ce04.qce_qutseq = qud_qutseq and ce04.qce_cecde = '04'
left join QUCSTEMT ce06 (nolock) on ce06.qce_cocde = qud_cocde and ce06.qce_qutno = qud_qutno and ce06.qce_qutseq = qud_qutseq and ce06.qce_cecde = '06'
left join QUCSTEMT ce07 (nolock) on ce07.qce_cocde = qud_cocde and ce07.qce_qutno = qud_qutno and ce07.qce_qutseq = qud_qutseq and ce07.qce_cecde = '07'
left join QUELCDTL elc09 (nolock) on elc09.qed_qutno = qud_qutno and elc09.qed_qutseq = qud_qutseq and elc09.qed_grpcde = '001' and elc09.qed_cecde = '09' -- ELC Duty
left join QUELC elc (nolock) on elc.qec_cocde = qud_cocde and elc.qec_qutno = qud_qutno and elc.qec_qutseq = qud_qutseq and elc.qec_grpcde = '001' -- ELC
left join QUELC fcc (nolock) on fcc.qec_cocde = qud_cocde and fcc.qec_qutno = qud_qutno and fcc.qec_qutseq = qud_qutseq and fcc.qec_grpcde = '002' -- FCC
left join CUFLGRAT (nolock) on cfr_cusno = @custno and cfr_prctrm = qud_prctrm
left join QUCPTBKD qcb1 (nolock) on qcb1.qcb_cocde = qud_cocde and qcb1.qcb_qutno = qud_qutno and qcb1.qcb_qutseq = qud_qutseq and qcb1.qcb_cptseq = 1
left join QUCPTBKD qcb2 (nolock) on qcb2.qcb_cocde = qud_cocde and qcb2.qcb_qutno = qud_qutno and qcb2.qcb_qutseq = qud_qutseq and qcb2.qcb_cptseq = 2
left join QUCPTBKD qcb3 (nolock) on qcb3.qcb_cocde = qud_cocde and qcb3.qcb_qutno = qud_qutno and qcb3.qcb_qutseq = qud_qutseq and qcb3.qcb_cptseq = 3
left join QUCPTBKD qcb4 (nolock) on qcb4.qcb_cocde = qud_cocde and qcb4.qcb_qutno = qud_qutno and qcb4.qcb_qutseq = qud_qutseq and qcb4.qcb_cptseq = 4
left join QUCPTBKD qcb5 (nolock) on qcb5.qcb_cocde = qud_cocde and qcb5.qcb_qutno = qud_qutno and qcb5.qcb_qutseq = qud_qutseq and qcb5.qcb_cptseq = 5
left join QUCPTBKD qcb6 (nolock) on qcb6.qcb_cocde = qud_cocde and qcb6.qcb_qutno = qud_qutno and qcb6.qcb_qutseq = qud_qutseq and qcb6.qcb_cptseq = 6
where qud_cocde = @cocde
and qud_qutno = @qutno
order by 	qud_qutseq


GO
GRANT EXECUTE ON [dbo].[sp_list_VTAITM_form] TO [ERPUSER] AS [dbo]
GO
