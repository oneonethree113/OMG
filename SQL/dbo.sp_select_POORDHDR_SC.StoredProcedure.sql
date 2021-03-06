/****** Object:  StoredProcedure [dbo].[sp_select_POORDHDR_SC]    Script Date: 09/29/2017 15:29:09 ******/
DROP PROCEDURE [dbo].[sp_select_POORDHDR_SC]
GO
/****** Object:  StoredProcedure [dbo].[sp_select_POORDHDR_SC]    Script Date: 09/29/2017 15:29:10 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO

Create  PROCEDURE [dbo].[sp_select_POORDHDR_SC]
                                                                                                                                                                                                                                                                 
---------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------- 
@cocde as nvarchar(6),
@ordno as nvarchar(20)
                                               
---------------------------------------------- 
 
AS
begin

select	distinct
	pod_scno,
	poh_purord,
	poh_pursts,
	poh_venno,
	vbi_vensna,
	poh_porctp,
	poh_prctrm,
	poh_paytrm,
	poh_discnt,
	--poh_shpstr,
	--poh_shpend,
	poh_rmk,
	poh_shpstr,
	poh_shpend,
	isnull(cast(Case poh_pocdat  when '1900-01-01' then null else convert(char(10),poh_pocdat,101) end as nvarchar(10)),'  /  /') as 'poh_pocdat',
	isnull(cast(Case poh_pocdatend  when '1900-01-01' then null else convert(char(10),poh_pocdatend,101) end as nvarchar(10)),'  /  /') as 'poh_pocdatend',
	--poh_pocdat,
	--poh_pocdatend,
	cast(poh_timstp as int) as poh_timstp,
	poh_ttlamt
from	POORDHDR
	left join POORDDTL on pod_purord = poh_purord
	left join VNBASINF on vbi_venno = poh_venno
where	pod_scno = @ordno
order by pod_scno, poh_purord, poh_venno

END


GO
GRANT EXECUTE ON [dbo].[sp_select_POORDHDR_SC] TO [ERPUSER] AS [dbo]
GO
