/****** Object:  StoredProcedure [dbo].[sp_select_CUITMSUM_SC]    Script Date: 09/29/2017 15:29:09 ******/
DROP PROCEDURE [dbo].[sp_select_CUITMSUM_SC]
GO
/****** Object:  StoredProcedure [dbo].[sp_select_CUITMSUM_SC]    Script Date: 09/29/2017 15:29:10 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO










-- Checked by Allan Yuen at 28/07/2003


/************************************************************************
Author:		Kenny Chan
Date:		03rd Jan, 2002
Description:	Select data From CUITMSUM
Parameter:		1. Company
		2. Item no
************************************************************************
2005-07-15	Allan Yuen		Change read color code from icf_colcde -> icf_vencol
*/
------------------------------------------------- 
CREATE procedure [dbo].[sp_select_CUITMSUM_SC]
                                                                                                                                                                                                                                                                 
---------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------- 
@cis_cocde nvarchar(6) ,
@cis_itmno nvarchar(20),
@cis_seccus nvarchar(6),
@cis_cusno nvarchar(6)

---------------------------------------------- 
 
AS
begin

Select


cis_cocde,
cis_cusno,
cis_seccus,
cis_itmno,
cis_itmdsc,
cis_cusitm,
cis_colcde,
cis_coldsc,
cis_cuscol,
cis_untcde,
cis_inrqty,
cis_mtrqty,
cis_cft = Case e.ipi_cft when 0 then f.ipi_cft else e.ipi_cft end,
cis_cbm = Case e.ipi_cbm when 0 then f.ipi_cbm else e.ipi_cbm end,
cis_refdoc,
cis_docdat,
cis_cussku,
cis_curcde,
cis_ordqty,
cis_selprc,
cis_hrmcde,
cis_dtyrat,
cis_dept,
cis_typcode,
cis_code1,
cis_code2,
cis_code3,
cis_cususd,
cis_cuscad,
--**********************************
cast(cis_colcde as nvarchar(30)) + ' / ' + 
cast(cis_untcde as nvarchar(6)) + ' / ' + 
cast(cis_inrqty as nvarchar(10)) + ' / ' + 
cast(cis_mtrqty as nvarchar(10)) + ' / ' + 
cast( Case  when e.ipi_cft = 0 or  e.ipi_cft is null then isnull(f.ipi_cft,cis_cft) else e.ipi_cft end as nvarchar(10)) + ' / ' +
cast(Case  when e.ipi_cbm= 0 or e.ipi_cbm is null  then isnull(f.ipi_cbm,cis_cbm) else e.ipi_cbm end as nvarchar(10)) as 'cis_colpck',
--Kenny Add on 10-10-2002
--**********************************
cis_inrdin,
cis_inrwin,
cis_inrhin,
cis_mtrdin,
cis_mtrwin,
cis_mtrhin,
cis_inrdcm,
cis_inrwcm,
cis_inrhcm,
cis_mtrdcm,
cis_mtrwcm,
cis_mtrhcm,
ISNULL(Case a.ibi_itmsts 	when 'CMP' then 'CMP - Active Item with complete Info.'
		when 'INC' then 'INC - Active Item with incomplete Info.'
		when 'HLD' then 'HLD - Active Item Hold by the system'
		when 'DIS' then 'DIS - Discontinue Item'
		when 'INA' then 'INA - Inactive Item'
		when 'CLO' then 'CLO - Closed (UCP Item)'
		when 'TBC' then 'TBC - To be confirmed Item'
		--Lestser Wu 2006-09-17
		when 'OLD' then 'OLD - Old Item'
end,'N/A') as 'ibi_itmsts',
Isnull(a.ibi_typ,'N/A') as 'ibi_typ',
isnull(b.imu_bcurcde,'N/A') as  'imu_bcurcde',
isnull(b.imu_basprc,0) as 'imu_basprc',
cis_creusr,
cis_updusr,
cis_credat,
cis_upddat,
cast(cis_timstp as int ) as 'cis_timstp',
ISNULL(Case c.ibi_itmsts 	
		when 'CMP' then 'CMP - Active Item with complete Info.'
		when 'INC' then 'INC - Active Item with incomplete Info.'
		when 'HLD' then 'HLD - Active Item Hold by the system'
		when 'DIS' then 'DIS - Discontinue Item'
		when 'INA' then 'INA - Inactive Item'
		when 'CLO' then 'CLO - Closed (UCP Item)'
		when 'TBC' then 'TBC - To be confirmed Item'
		--Lestser Wu 2006-09-17
		when 'OLD' then 'OLD - Old Item'
end,'N/A') as 'h_ibi_itmsts',
Isnull(c.ibi_typ,'N/A') as 'h_ibi_typ',
isnull(d.imu_bcurcde,'N/A') as  'h_imu_bcurcde',
isnull(d.imu_basprc,0) as 'h_imu_basprc',
cis_pckitr,
isnull(a.ibi_tirtyp,'0') as 'ibi_tirtyp',
isnull(c.ibi_tirtyp,'2') as 'h_ibi_tirtyp',
isnull(h.icf_colcde , '@#') as 'icf_colcde',
--isnull(h.icf_vencol , '@#') as 'icf_colcde',
a.ibi_venno

INTO #TEMP


From 
	CUITMSUM 

left join imbasinf a on a.ibi_itmno in (select ibi_itmno from imbasinf (nolock) where ibi_itmno = @cis_itmno or ibi_alsitmno = @cis_itmno  and ibi_itmsts <> 'CLO')
left join imbasinfh c  on c.ibi_itmno in (select ibi_itmno from imbasinfh (nolock) where ibi_itmno = @cis_itmno or ibi_alsitmno = @cis_itmno  and ibi_itmsts <> 'CLO')
left join immrkup b on 
		b.imu_itmno = a.ibi_itmno and  
		b.imu_prdven = a.ibi_venno and
		b.imu_pckunt = cis_untcde and 
		b.imu_inrqty = cis_inrqty and 
		b.imu_mtrqty = cis_mtrqty 

left join immrkuph d on 
		d.imu_itmno = c.ibi_itmno and 
		d.imu_prdven = c.ibi_venno and
		d.imu_pckunt = cis_untcde and 
		d.imu_inrqty = cis_inrqty and 
		d.imu_mtrqty = cis_mtrqty 

left join IMCOLINF h (nolock) on 
--		icf_itmno = cis_itmno and 
--		icf_colcde = cis_colcde
		h.icf_itmno = a.ibi_itmno and 
--		h.icf_colcde = cis_colcde
		h.icf_vencol = cis_colcde

/*
left join IMCOLINFH g (nolock) on 
--		icf_itmno = cis_itmno and 
--		icf_colcde = cis_colcde
		g.icf_itmno = c.ibi_itmno and 
		g.icf_colcde = cis_colcde
*/


left join IMPCKINF e (nolock) on 
--		e.ipi_itmno = cis_itmno and
		e.ipi_itmno = a.ibi_itmno and
		e.ipi_pckunt = cis_untcde and 
		e.ipi_inrqty = cis_inrqty and 
		e.ipi_mtrqty = cis_mtrqty

left join IMPCKINFH f (nolock) on 
--		f.ipi_itmno = cis_itmno  and
		f.ipi_itmno = c.ibi_itmno  and
		f.ipi_pckunt = cis_untcde and 
		f.ipi_inrqty = cis_inrqty and 
		f.ipi_mtrqty = cis_mtrqty 

where
cis_cusno in 
		(select cbi_cusno from cubasinf (nolock)   where cbi_cusali = @cis_cusno or cbi_cusno = @cis_cusno
		   UNION
		   SELECT cbi_cusali from cubasinf (nolock) where cbi_cusno = @cis_cusno) 
and

--(select cbi_cusno from cubasinf (nolock) where cbi_cusali = @cis_cusno or cbi_cusno = @cis_cusno) and
cis_seccus = @cis_seccus  

and
cis_itmno in 
(Select ibi_itmno  from imbasinf (nolock) where ibi_itmno = @cis_itmno or ibi_alsitmno = @cis_itmno 
union
select ibi_alsitmno from imbasinf (nolock) where ibi_itmno = @cis_itmno  
union
Select ibi_itmno  from imbasinfh (nolock) where ibi_itmno = @cis_itmno or ibi_alsitmno = @cis_itmno 
union
select ibi_alsitmno from imbasinfh (nolock) where ibi_itmno = @cis_itmno  
) 

--and left(a.ibi_itmsts,3) <> 'CLO'

SELECT distinct * FROM #TEMP WHERE 
LEFT(ibi_itmsts,3) <> 'CLO' AND LEFT(h_ibi_itmsts,3) <> 'CLO'


/*
union

Select
cis_cocde,
cis_cusno,
cis_seccus,
cis_itmno,
cis_itmdsc,
cis_cusitm,
cis_colcde,
cis_coldsc,
cis_cuscol,
cis_untcde,
cis_inrqty,
cis_mtrqty,
cis_cft = Case e.ipi_cft when 0 then f.ipi_cft else e.ipi_cft end,
cis_cbm = Case e.ipi_cbm when 0 then f.ipi_cbm else e.ipi_cbm end,
cis_refdoc,
cis_docdat,
cis_cussku,
cis_curcde,
cis_ordqty,
cis_selprc,
cis_hrmcde,
cis_dtyrat,
cis_dept,
cis_typcode,
cis_code1,
cis_code2,
cis_code3,
cis_cususd,
cis_cuscad,
--**********************************
cast(cis_colcde as nvarchar(30)) + ' / ' + 
cast(cis_untcde as nvarchar(6)) + ' / ' + 
cast(cis_inrqty as nvarchar(10)) + ' / ' + 
cast(cis_mtrqty as nvarchar(10)) + ' / ' + 
cast( Case  when e.ipi_cft = 0 or  e.ipi_cft is null then isnull(f.ipi_cft,cis_cft) else e.ipi_cft end as nvarchar(10)) + ' / ' +
cast(Case  when e.ipi_cbm= 0 or e.ipi_cbm is null  then isnull(f.ipi_cbm,cis_cbm) else e.ipi_cbm end as nvarchar(10)) as 'cis_colpck',
--Kenny Add on 10-10-2002
--**********************************
cis_inrdin,
cis_inrwin,
cis_inrhin,
cis_mtrdin,
cis_mtrwin,
cis_mtrhin,
cis_inrdcm,
cis_inrwcm,
cis_inrhcm,
cis_mtrdcm,
cis_mtrwcm,
cis_mtrhcm,
ISNULL(Case a.ibi_itmsts 	when 'CMP' then 'CMP - Active Item with complete Info.'
		when 'INC' then 'INC - Active Item with incomplete Info.'
		when 'HLD' then 'HLD - Active Item Hold by the system'
		when 'DIS' then 'DIS - Discontinue Item'
		when 'INA' then 'INA - Inactive Item'
		when 'CLO' then 'CLO - Closed (UCP Item)'
end,'N/A') as 'ibi_itmsts',
Isnull(a.ibi_typ,'N/A') as 'ibi_typ',
isnull(b.imu_bcurcde,'N/A') as  'imu_bcurcde',
isnull(b.imu_basprc,0) as 'imu_basprc',
cis_creusr,
cis_updusr,
cis_credat,
cis_upddat,
cast(cis_timstp as int ) as 'cis_timstp',
ISNULL(Case c.ibi_itmsts 	when 'CMP' then 'CMP - Active Item with complete Info.'
		when 'INC' then 'INC - Active Item with incomplete Info.'
		when 'HLD' then 'HLD - Active Item Hold by the system'
		when 'DIS' then 'DIS - Discontinue Item'
		when 'INA' then 'INA - Inactive Item'
end,'N/A') as 'h_ibi_itmsts',
Isnull(c.ibi_typ,'N/A') as 'h_ibi_typ',
isnull(d.imu_bcurcde,'N/A') as  'h_imu_bcurcde',
isnull(d.imu_basprc,0) as 'h_imu_basprc',
cis_pckitr,
isnull(a.ibi_tirtyp,'0') as 'ibi_tirtyp',
isnull(c.ibi_tirtyp,'2') as 'h_ibi_tirtyp',
isnull(icf_colcde , '@#') as 'icf_colcde'

From CUITMSUM 

--left join imbasinf a on a.ibi_cocde = @cis_cocde and a.ibi_itmno = @cis_itmno 
left join imbasinf a on a.ibi_alsitmno = @cis_itmno 

left join immrkup b on 
		--b.imu_cocde = @cis_cocde and 
--		b.imu_itmno = cis_itmno and
		b.imu_itmno = a.ibi_itmno and
		b.imu_ventyp = 'D' and 
		a.ibi_venno = b.imu_venno
		b.imu_pckunt = cis_untcde and 
		b.imu_inrqty = cis_inrqty and 
		b.imu_mtrqty = cis_mtrqty and 

left join imbasinfh c on 
		--c.ibi_cocde = @cis_cocde and 
--		c.ibi_itmno = @cis_itmno 
		c.ibi_itmno = a.ibi_itmno

left join immrkuph d on 
		--d.imu_cocde = @cis_cocde and 
		d.imu_pckunt = cis_untcde and 
		d.imu_inrqty = cis_inrqty and 
		d.imu_mtrqty = cis_mtrqty and 
--		d.imu_itmno = cis_itmno and
		d.imu_itmno = a.ibi_itmno and
		d.imu_ventyp = 'D' and c.ibi_venno = d.imu_venno

left join IMCOLINF on 
		--icf_cocde = @cis_cocde and 
--		icf_itmno = @cis_itmno and 
		icf_itmno = a.ibi_itmno and 
		icf_colcde = cis_colcde

left join IMPCKINF e on 
		--e.ipi_cocde = @cis_cocde and 
		e.ipi_pckunt = cis_untcde and 
		e.ipi_inrqty = cis_inrqty and 
		e.ipi_mtrqty = cis_mtrqty and 
--		e.ipi_itmno = cis_itmno
		e.ipi_itmno = a.ibi_itmno

left join IMPCKINFH f on 
		--f.ipi_cocde = @cis_cocde and 
		f.ipi_pckunt = cis_untcde and 
		f.ipi_inrqty = cis_inrqty and 
		f.ipi_mtrqty = cis_mtrqty and 
--		f.ipi_itmno = cis_itmno
		f.ipi_itmno = a.ibi_itmno

Where 
--cis_cocde = @cis_cocde and
cis_itmno = @cis_itmno and 
cis_cusno in (select cbi_cusno from cubasinf where cbi_cusali = @cis_cusno or cbi_cusno = @cis_cusno) and
cis_seccus = @cis_seccus and
a.ibi_itmsts <> 'CLO'

*/


                                                           
---------------------------------------------------------- 
end





GO
GRANT EXECUTE ON [dbo].[sp_select_CUITMSUM_SC] TO [ERPUSER] AS [dbo]
GO
