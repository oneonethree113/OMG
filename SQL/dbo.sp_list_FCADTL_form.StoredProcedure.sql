/****** Object:  StoredProcedure [dbo].[sp_list_FCADTL_form]    Script Date: 09/29/2017 15:29:09 ******/
DROP PROCEDURE [dbo].[sp_list_FCADTL_form]
GO
/****** Object:  StoredProcedure [dbo].[sp_list_FCADTL_form]    Script Date: 09/29/2017 15:29:09 ******/
SET ANSI_NULLS OFF
GO
SET QUOTED_IDENTIFIER OFF
GO







CREATE  PROCEDURE [dbo].[sp_list_FCADTL_form] 

@cocde	nvarchar(6),
@qutno	nvarchar(20)


AS


select
qud_itmdsc as 'fca_prdnam',
yco_shtnam as 'fca_vennam',
qud_cusstyno as 'fca_venitm',
'' as 'fca_dpci', -- Need to enhance
'' as 'fca_tarcomitm',
'' as 'fca_datbusawd',
'' as 'fca_firstshp',
'' as 'fca_lastshp',
'' as 'fca_prjunt', -- Need to enhance
isnull(qed_percent,0) as 'fca_dutyrat',
qud_mtrqty as 'fca_mtrpck',
qud_mtrdin as 'fca_mtrdin',
qud_mtrwin as 'fca_mtrwin',
qud_mtrhin as 'fca_mtrhin',
case vbi_ventyp when 'I' then 'Grand China' when 'J' then 'Grand China' else vbi_vensna end as 'fca_ftynam',
'' as 'fca_ftyid',
'' as 'fca_llfty',
'' as 'fca_contact',
'' as 'fca_email',
'' as 'fca_phone',
'' as 'fca_fax',
'' as 'fca_ftyaddr',
substring(sys03.ysi_dsc, 5, len(sys03.ysi_dsc)) 'fca_port',
'' as 'fca_csteml',
'' as 'fca_cstphone',
case qud_cus2dp when 0 then qud_cus1dp else qud_cus2dp end as 'fca_fobprc',
isnull(qec_amt, 0) as 'fca_fcaprc',
isnull(((case qud_cus2dp when 0 then qud_cus1dp else qud_cus2dp end) - isnull(qec_amt, 0)), 0) as 'fca_reduct'
from QUOTNDTL (nolock)
left join QUOTNHDR (nolock) on quh_cocde = qud_cocde and quh_qutno = qud_qutno
left join SYCOMINF (nolock) on yco_cocde = qud_cocde
left join VNBASINF (nolock) on vbi_venno = qud_venno
left join SYSETINF sys03 (nolock) on sys03.ysi_cde = qud_prctrm and ysi_typ = '03'
left join QUELCDTL (nolock) on qed_qutno = qud_qutno and qed_qutseq = qud_qutseq and qed_grpcde = '001' and qed_cecde = '09'
left join QUELC (nolock) on qec_qutno = qud_qutno and qec_qutseq = qud_qutseq and qec_grpcde = '002' -- FCA
where qud_cocde = @cocde
and qud_qutno = @qutno
order by qud_qutseq










GO
GRANT EXECUTE ON [dbo].[sp_list_FCADTL_form] TO [ERPUSER] AS [dbo]
GO
