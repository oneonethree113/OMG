/****** Object:  StoredProcedure [dbo].[sp_select_SCORDHDR]    Script Date: 09/29/2017 15:29:09 ******/
DROP PROCEDURE [dbo].[sp_select_SCORDHDR]
GO
/****** Object:  StoredProcedure [dbo].[sp_select_SCORDHDR]    Script Date: 09/29/2017 15:29:10 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO
Create  PROCEDURE [dbo].[sp_select_SCORDHDR]                                                                                                                                                                                                                                                                
---------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------- 
@soh_cocde nvarchar(6),
@soh_ordno nvarchar(20)                                                
---------------------------------------------- 
 
AS
declare @shipped as int
declare @approve as int

set @shipped = (select count(*) from SCORDDTL (nolock) where sod_cocde = @soh_cocde  and sod_ordno = @soh_ordno  and sod_shpqty > 0)

begin

select	soh_cocde,
	soh_ordno,
	soh_verno,
	soh_smpsc,
	soh_clsout,
	soh_rplmnt,
	soh_issdat,
	soh_rvsdat,
	soh_ordsts,
	soh_cus1no + Case When pri.cbi_cussts <> 'A' Then ' - '+  pri.cbi_cussna + ' (InActive)' When pri.cbi_cussts is null then ' - (Deleted)' else '' end as 'soh_cus1no' ,
	soh_cus2no + Case When sec.cbi_cussts <> 'A' Then ' - '+  sec.cbi_cussna + ' (InActive)' When sec.cbi_cussts is null and soh_cus2no <> '' then ' - (Deleted)' else '' end as 'soh_cus2no',
	soh_biladr,
	soh_bilstt,
	soh_bilcty,
	soh_bilzip,
	soh_zshpcusno,
	soh_shpadr,
	soh_shpstt,
	soh_shpcty,
	soh_shpzip,
	soh_cttper,
	isnull(soh_email,'') as 'soh_email',
	soh_srname,
	--soh_saldivtem,
	soh_saldiv,
	soh_saltem,
	soh_agt,
	soh_prctrm,
	soh_paytrm,
	soh_sfigtrm,
	soh_sprdtrm,
	soh_resppo,
	soh_ttlvol,
	soh_curcde,
	soh_ttlctn,
	soh_ttlamt,
	soh_netamt,
	soh_rmk,
	soh_cuspo,
	case soh_cpodat when '01/01/1900' then '' else soh_cpodat end as 'soh_cpodat',
	case soh_shpstr when '01/01/1900' then '' else soh_shpstr end as 'soh_shpstr',
	case soh_shpend when '01/01/1900' then '' else soh_shpend end as 'soh_shpend',
	isnull(cast(case soh_candat  when '1900-01-01' then null else convert(char(10),soh_candat,101) end as nvarchar(10)),'  /  /    ') as 'soh_candat',
	case soh_lbldue when '01/01/1900' then '' else soh_lbldue end as 'soh_lbldue',
	soh_lblven,
	soh_cusctn,
	soh_dest,
	soh_creusr,
	soh_updusr,
	soh_credat,
	soh_upddat,
	cast(soh_timstp as int) as soh_timstp,
	@shipped as 'shipped',
	soh_cft,
	soh_canflg,
	isnull(pri.cbi_saltem,'') as 'ysr_saltem',
	--soh_salrep + ' - ' + isnull(b.ysr_dsc,'User Not Found') + ' (TEAM '+ Isnull(b.ysr_saltem,'')+')'  as 'soh_salrep_all' ,
	--soh_srname + ' - ' + isnull(usr.yup_usrnam,'User Not Found') + ' (TEAM '+ Isnull(sal.ssr_saltem,'')+')'  as 'soh_srname_all' ,
	soh_srname + ' - ' + isnull(usr.yup_usrnam,'User Not Found') + ' (TEAM '+ Isnull(pri.cbi_saltem,'')+')'  as 'soh_srname_all' ,
	'Division ' + case soh_saldiv when '' then 'N/A' else soh_saldiv end + ' (Team ' + case soh_saltem when '' then 'N/A' else soh_saltem end + ')' as 'soh_saldivtem_all',
	isnull(cbc_rskuse,0) as 'cpi_rskuse',
	isnull(cbc_rsklmt,0) as 'cpi_rsklmt' , 
	case len(soh_moqsc) when 0 then soh_ordno else soh_moqsc end as soh_moqsc,
	soh_curexrat ,
	soh_curexeffdat,
	case isnull(soh_cusctn, 0) when 0 then '' else soh_cusctn end as 'soh_cusctn',
	soh_dest,
	soh_prctrmflg,
	soh_paytrmflg,
	soh_rplflg,
	soh_clsflg,
	soh_lastprctrm,
	soh_lastpaytrm,
	soh_scrmk
from	SCORDHDR (nolock)
	left join CUBASINF pri (nolock) on
		pri.cbi_cusno = soh_cus1no 
	left join CUBASINF sec (nolock) on
		sec.cbi_cusno = soh_cus2no
	left join SYUSRPRF usr (nolock) on
		usr.yup_usrid = pri.cbi_srname
	left join CUBCR (nolock) on
		cbc_cusno = soh_cus1no and
		cbc_cocde = soh_cocde
where	soh_cocde = @soh_cocde and
	soh_ordno = @soh_ordno

end




GO
GRANT EXECUTE ON [dbo].[sp_select_SCORDHDR] TO [ERPUSER] AS [dbo]
GO
