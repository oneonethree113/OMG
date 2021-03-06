/****** Object:  StoredProcedure [dbo].[sp_list_VTAHDR_form]    Script Date: 09/29/2017 15:29:09 ******/
DROP PROCEDURE [dbo].[sp_list_VTAHDR_form]
GO
/****** Object:  StoredProcedure [dbo].[sp_list_VTAHDR_form]    Script Date: 09/29/2017 15:29:10 ******/
SET ANSI_NULLS OFF
GO
SET QUOTED_IDENTIFIER OFF
GO



CREATE  PROCEDURE [dbo].[sp_list_VTAHDR_form] 

@cocde	nvarchar(6),
@qutno		nvarchar(20)

AS

declare @custno nvarchar(6)

select @custno = case quh_cus2no when '' then quh_cus1no else quh_cus2no end 
from QUOTNHDR where quh_cocde = @cocde and quh_qutno = @qutno

select

qud_qutno,	-- quotion number
qud_qutseq,	-- quotion sequence
'' as 'isu_class', --Class
'' as 'vta_prdcat', --Product Category
'' as 'vta_buyer', --Buyer
'' as 'vta_mpba', --MP BA
'' as 'vta_prdmgr', --Product Manager
'' as 'vta_tssba', --TSS BA
'' as 'vta_tssrcmgr', --TSS Sourcing Manager
'' as 'vta_tssrep', --TSS Market Rep
'' as 'vta_ftyid01', --Factory 1 BPM 1D
'' as 'vta_ftyscore01', --Factory 1 Score
'' as 'vta_ftycoo01', --Factory 1 COO
'' as 'vta_ftyfobp01', --Factory 1 FOB Port
'' as 'vta_ftyid02', --Factory 2 BPM 1D
'' as 'vta_ftyscore02', --Factory 2 Score
'' as 'vta_ftycoo02', --Factory 2 COO
'' as 'vta_ftyfobp02', --Factory 2 FOB Port
'' as 'vta_ftyid03', --Factory 3 BPM 1D
'' as 'vta_ftyscore03', --Factory 3 Score
'' as 'vta_ftycoo03', --Factory 3 COO
'' as 'vta_ftyfobp03', --Factory 3 FOB Port
quh_Season as  'vta_Season', --Season
'' as 'vta_bpcontact', --BP Contact
'' as 'vta_bpemail', --BP Contact Email
'' as 'vta_awdat', --Program award date
'' as 'vta_credat', --VTA create date
'' as 'vta_lastrev', --Last Revision

qud_dept as 'vta_dept', --Department
'' as 'vta_cms', --CMS#
yco_shtnam as 'vta_shtnam', --Vendor Name
yco_venid as 'vta_venid', --Vendor #
quh_Year + ' ' + quh_Season + ' '+ quh_Desc as 'vta_program', --Program
'' as 'vta_setdat', --Set Date

'' as vta_note01,
'' as vta_note02,
'' as vta_note03,
'' as vta_note04,
'' as vta_note05,
'' as vta_note06,
'' as vta_note07,
'' as vta_note08,
'' as vta_note09,
'' as vta_note10,
'' as vta_note11,
'' as vta_note12


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
GRANT EXECUTE ON [dbo].[sp_list_VTAHDR_form] TO [ERPUSER] AS [dbo]
GO
