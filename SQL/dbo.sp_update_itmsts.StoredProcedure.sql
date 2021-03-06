/****** Object:  StoredProcedure [dbo].[sp_update_itmsts]    Script Date: 09/29/2017 15:29:08 ******/
DROP PROCEDURE [dbo].[sp_update_itmsts]
GO
/****** Object:  StoredProcedure [dbo].[sp_update_itmsts]    Script Date: 09/29/2017 15:29:10 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO



-- Checked by Allan Yuen at 28/07/2003


CREATE PROCEDURE [dbo].[sp_update_itmsts] AS

Update IMBASINF Set ibi_itmsts = 'CMP' , ibi_updusr = 'Batch_STS'
--Select ibi_itmno
From IMBASINF y,
(
Select ibi_itmno --, a.imu_venno, b.imu_venno
From 
IMBASINF 
--left join IMCOLINF on icf_cocde = ibi_cocde and icf_itmno  = ibi_itmno 
--left join IMMRKUP a on 	a.imu_cocde = ibi_cocde and a.imu_itmno = ibi_itmno and 
--			a.imu_venno = ibi_venno and a.imu_ventyp = 'D' and a.imu_basprc > 0 and rtrim(ltrim(a.imu_venno)) <> ''
--left join IMMRKUP b on 	b.imu_cocde = ibi_cocde and b.imu_itmno = ibi_itmno and 
--			b.imu_venno = ibi_venno and b.imu_ventyp = 'D'  and b.imu_basprc = 0 and rtrim(ltrim(b.imu_venno)) <> ''

left join IMCOLINF on icf_itmno  = ibi_itmno 
left join IMMRKUP a on 	a.imu_itmno = ibi_itmno and 
			a.imu_venno = ibi_venno and a.imu_ventyp = 'D' and a.imu_basprc > 0 and rtrim(ltrim(a.imu_venno)) <> ''
left join IMMRKUP b on 	b.imu_itmno = ibi_itmno and 
			b.imu_venno = ibi_venno and b.imu_ventyp = 'D'  and b.imu_basprc = 0 and rtrim(ltrim(b.imu_venno)) <> ''


Where 
	ibi_itmsts = 'INC'
Group by 
	ibi_itmno  ,	a.imu_venno ,	b.imu_venno,
	a.imu_itmno,	b.imu_itmno,	icf_itmno
having (icf_itmno is not null and a.imu_itmno  is not null and b.imu_itmno is null and b.imu_venno <> '' and a.imu_venno <> '') 
) x
Where y.ibi_itmno = x.ibi_itmno


--/*select ibi_itmno, ipi_pckseq, icf_colcde, ipi_pckunt, ipi_inrqty, ipi_mtrqty, 
--imu_curcde, imu_ftyprc, imu_bcurcde, imu_basprc,
--imu_creusr, imu_updusr, imu_credat, imu_upddat, icf_creusr, icf_updusr, icf_credat, icf_upddat
--*/
--/* update I set ibi_itmsts = 'CMP' , ibi_updusr = 'Batch'
--from imbasinf I
--left join impckinf on ibi_cocde=ipi_cocde and ibi_itmno=IPI_itmno
--left join imcolinf on ibi_cocde = icf_cocde and ibi_itmno=icf_itmno
--left join immrkup on ipi_cocde =imu_cocde and ipi_itmno=imu_itmno and ipi_pckseq=imu_pckseq
--where isnull(ipi_mtrqty,0) > 0 
--and isnull(ipi_pckunt, '') <> ''
--and isnull(imu_ftyprc, 0) > 0
--and isnull(imu_basprc, 0) > 0
--and isnull(icf_colcde, '') <> ''
--and imu_ventyp = 'D'
--and ibi_itmsts = 'INC'
----and ibi_cocde = 'ucp'
----and ibi_itmno = '50199957'
--and ibi_itmno not in	(select imu_itmno
--			from immrkup 
--			where (isnull(imu_ftyprc, 0) = 0 or isnull(imu_basprc, 0) = 0) 
--			and imu_ventyp = 'D')*/
----and ibi_itmno in ('FGR/AS2CT4244P/2','FGR/AS2CT4243P/2','FGR/AS2CT4237P/2','FGR/AS2CT4236P/2')
----order by ibi_itmno, ipi_pckseq, icf_colcde






GO
GRANT EXECUTE ON [dbo].[sp_update_itmsts] TO [ERPUSER] AS [dbo]
GO
