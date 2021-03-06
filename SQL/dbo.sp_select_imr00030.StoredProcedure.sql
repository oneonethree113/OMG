/****** Object:  StoredProcedure [dbo].[sp_select_imr00030]    Script Date: 09/29/2017 15:29:09 ******/
DROP PROCEDURE [dbo].[sp_select_imr00030]
GO
/****** Object:  StoredProcedure [dbo].[sp_select_imr00030]    Script Date: 09/29/2017 15:29:10 ******/
SET ANSI_NULLS OFF
GO
SET QUOTED_IDENTIFIER OFF
GO







CREATE procedure [dbo].[sp_select_imr00030]
                                                                                                                                                                                                                                                                 
@cocde 	nvarchar(6),
@ProcDatFm	datetime,
@ProcDatTo	datetime,
@IsDistinct	nvarchar(1)

 
AS

begin

select 
soh_cocde,
soh_cus1no,
isnull(p.cbi_cussna,'') as 'pricussna',
soh_cus2no,
isnull(s.cbi_cussna,'') as 'seccussna',
soh_ordsts,
sod_ordno,
sod_ordseq , 
poh_pursts,
pod_purord,
pod_purseq, 
sod_itmno,
sod_pckunt,
sod_inrctn,
sod_mtrctn,
sod_conftr,
sbd_cocde,
sbd_lotno,
sbd_filename,
sbd_jobord,
isnull(yct_desc ,sbd_rmk ) as 'yct_desc',
isnull(yct_rptseq,999) as 'yct_rptseq' ,
case when isnull(vb.vbi_vensna,'') = '' then sbd_before  else sbd_before +  ' - ' + vb.vbi_vensna end as 'sbd_before' ,
case when isnull(va.vbi_vensna,'') = '' then sbd_after  else sbd_after +  ' - ' + va.vbi_vensna end as 'sbd_after' ,
sbd_flg,
sbd_rmk,

-- Added by Mark Lau 20091008
case when isnull(vc.vbi_vensna,'') = '' then ''  else sod_dv +  ' - ' + vc.vbi_vensna end as 'sod_dv' ,
isnull(sod_dvftycst,0) as 'sod_dvftycst',
isnull(sod_dvbomcst,0) as 'sod_dvbomcst',
isnull(sod_dvftyprc,0) as 'sod_dvftyprc',
isnull(sod_dvfcurcde,'') as 'sod_dvfcurcde',

sbd_creusr,
sbd_credat,
sbd_updusr,
sbd_upddat,
isnull(sod_zorvbeln,'') as 'sod_zorvbeln',
isnull(sod_zorposnr,'') as 'sod_zorposnr',
isnull(sbd_chgtyp,'') as 'sbd_chgtyp',
cast(round(isnull(sod_bomcst,0)  ,2,1) as numeric(11,2)) as 'sod_bomcst',
sod_fcurcde
into #tmp_imr00030
from scfdbdtl (nolock)
left join poorddtl  (nolock) on sbd_jobord = pod_jobord
left join poordhdr (nolock) on poh_purord = pod_purord
left join scorddtl  (nolock) on pod_scno = sod_ordno and pod_scline = sod_ordseq
left join vnbasinf as vc (nolock) on sod_dv = vc.vbi_venno  
left join scordhdr (nolock) on soh_ordno = sod_ordno
left join sychgtyp on sbd_chgtyp = yct_cde
left join cubasinf as p (nolock) on soh_cus1no = p.cbi_cusno
left join cubasinf as s (nolock) on soh_cus2no = s.cbi_cusno
left join vnbasinf as vb (nolock) on sbd_before = vb.vbi_venno and ( sbd_chgtyp = '05' or sbd_chgtyp = '06' )
left join vnbasinf as va (nolock) on sbd_after = va.vbi_venno  and ( sbd_chgtyp = '05' or sbd_chgtyp = '06' )

where
sbd_credat >= @ProcDatFm + ' 00:00:00' and sbd_credat <= @ProcDatTo + ' 23:59:59'
--sbd_credat >=  '2009-07-11 00:00:00' and sbd_credat <= '2009-07-11 23:59:59'
and isnull(yct_show,'Y') <> 'N'
order by sbd_lotno,sbd_jobord, yct_rptseq asc


if @IsDistinct = 'N'
begin
select * from #tmp_imr00030
order by
/*
sbd_lotno,
--sbd_credat,
soh_cocde,
sbd_jobord,
sod_ordno,
sod_ordseq ,
soh_cus1no,
[pricussna],
soh_cus2no,
[seccussna],
pod_purord,
pod_purseq, 
sod_itmno,
sod_pckunt,
sod_inrctn,
sod_mtrctn,
sod_conftr,
yct_rptseq
*/
soh_cocde,
sbd_jobord
end
else if @IsDistinct = 'Y'
begin

select distinct 
soh_cocde,
soh_cus1no,
[pricussna],
soh_cus2no,
[seccussna],
soh_ordsts,
sod_ordno,
sod_ordseq , 
poh_pursts,
pod_purord,
pod_purseq, 
sod_itmno,
sod_pckunt,
sod_inrctn,
sod_mtrctn,
-- Added by Mark Lau 20091008
sod_dv ,
sod_dvftycst,
sod_dvbomcst,
sod_dvftyprc,
sod_dvfcurcde,
sod_conftr,
sbd_cocde,
sbd_lotno,
sbd_filename,
sbd_jobord
from #tmp_imr00030
order by
sbd_lotno,
soh_cocde,
sbd_jobord,
sod_ordno,
sod_ordseq ,
soh_cus1no,
[pricussna],
soh_cus2no,
[seccussna],
pod_purord,
pod_purseq, 
sod_itmno,
sod_pckunt,
sod_inrctn,
sod_mtrctn,
-- Added by Mark Lau 20091008
sod_dv ,
sod_dvftycst,
sod_dvbomcst,
sod_dvftyprc,
sod_dvfcurcde,
sod_conftr



end

end



GO
GRANT EXECUTE ON [dbo].[sp_select_imr00030] TO [ERPUSER] AS [dbo]
GO
