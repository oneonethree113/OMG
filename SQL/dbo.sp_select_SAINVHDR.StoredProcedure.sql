/****** Object:  StoredProcedure [dbo].[sp_select_SAINVHDR]    Script Date: 09/29/2017 15:29:09 ******/
DROP PROCEDURE [dbo].[sp_select_SAINVHDR]
GO
/****** Object:  StoredProcedure [dbo].[sp_select_SAINVHDR]    Script Date: 09/29/2017 15:29:10 ******/
SET ANSI_NULLS OFF
GO
SET QUOTED_IDENTIFIER OFF
GO





CREATE procedure [dbo].[sp_select_SAINVHDR]
                                                                                                                                                                                                                                                               
@sih_cocde nvarchar(6) ,
@sih_invno nvarchar(20) 
 
AS
 
Select 

sih_cocde,
sih_invno,
convert(char(10),sih_issdat,101) as sih_issdat,
convert(char(10),sih_rvsdat,101) as sih_rvsdat,
sih_invsts,
sih_cus1no,
sih_cus2no,
sih_cus1ad,
sih_cus2ad,
sih_cus1st,
isnull(sih_cus1cy + ' - ' + a.ysi_dsc,'') as 'sih_cus1cy',
sih_cus1zp,
sih_cus2st,
isnull(sih_cus2cy + ' - ' +b.ysi_dsc,'') as 'sih_cus2cy',
sih_cus2zp,
sih_cus1cp,
sih_cus2cp,
sih_salrep,
isnull(sih_saltem,'') as 'sih_saltem',
isnull(sih_saldiv + ' - Division ' + sih_saldiv ,'') as 'sih_saldiv' ,
sih_salmgt,
isnull(sih_srname + ' - ' + yup_usrnam,'') as 'sih_srname', 
sih_cusagt,
sih_courier,
sih_doctyp,
sih_docno,
isnull(sih_smpprd + ' - ' + d.yst_trmdsc,'') as 'sih_smpprd',
isnull(sih_smpfgt + ' - ' + e.yst_trmdsc,'') as 'sih_smpfgt',
isnull(sih_prctrm + ' - ' + c.ysi_dsc,'') as 'sih_prctrm',
sih_curcde,
sih_ttlamt,
sih_ttlctn,
sih_shprmk,
sih_rmk,
sih_creusr,
sih_updusr,
sih_credat,
sih_upddat,
cast(sih_timstp as int) as sih_timstp,
sih_hdrrmk,
--isnull(ysr_saltem,'') 
isnull(cbi_saltem,'') as 'ysr_saltem',
cbi_salrep,
d.yst_charge,
--case d.yst_charge when 'Q' then 100 else  100-isnull(d.yst_chgval,0) end as 'yst_chgval',
sih_discnt,
sih_netamt,	cbc_cdtlmt as 'cpi_cdtlmt',	cbc_cdtuse as 'cpi_cdtuse',

-- Added by Mark Lau 20090814
isnull(sih_curexrat ,0) as 'sih_curexrat',
sih_curexeffdat 


from SAINVHDR

left join SYSETINF a on --sih_cocde = a.ysi_cocde and 
		sih_cus1cy = a.ysi_cde and a.ysi_typ  = '02' 
left join SYSETINF b on --sih_cocde = b.ysi_cocde and 
		sih_cus2cy = b.ysi_cde and b.ysi_typ  = '02' 

left join SYSETINF c on --sih_cocde = c.ysi_cocde and 
		sih_prctrm = c.ysi_cde and c.ysi_typ = '03'

left join sysmptrm d on --sih_cocde = d.yst_cocde and 
		sih_smpprd = d.yst_trmcde
left join sysmptrm e on --sih_cocde = e.yst_cocde and 
		sih_smpfgt = e.yst_trmcde

left join CUBASINF on --cbi_cocde = sih_cocde and 
		sih_cus1no = cbi_cusno
left join CUPRCINF on --cpi_cocde = sih_cocde and 
		cpi_cusno = cbi_cusno
left join 	SYSALREP on --ysr_cocde = sih_cocde and 
		ysr_code1 = cbi_salrep
left join CUBCR on cbc_cocde = sih_cocde and cbc_cusno = cbi_cusno
left join SYUSRPRF on sih_srname = yup_usrid
where                                                                                                                                                                                                                                                                 
sih_cocde = @sih_cocde and
sih_invno = @sih_invno





GO
GRANT EXECUTE ON [dbo].[sp_select_SAINVHDR] TO [ERPUSER] AS [dbo]
GO
