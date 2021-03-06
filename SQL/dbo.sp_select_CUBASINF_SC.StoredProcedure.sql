/****** Object:  StoredProcedure [dbo].[sp_select_CUBASINF_SC]    Script Date: 09/29/2017 15:29:09 ******/
DROP PROCEDURE [dbo].[sp_select_CUBASINF_SC]
GO
/****** Object:  StoredProcedure [dbo].[sp_select_CUBASINF_SC]    Script Date: 09/29/2017 15:29:10 ******/
SET ANSI_NULLS OFF
GO
SET QUOTED_IDENTIFIER ON
GO





/*
=================================================================
Program ID	: sp_select_CUITMPRC_SC
Description	: Retrieve Customer Informations
Programmer	: David Yue
=================================================================
	MODIFICATION HISTORY
=================================================================
   Date		 Editor			Description
=================================================================
2013-10-17 	David Yue		SP Created
=================================================================
*/


CREATE procedure [dbo].[sp_select_CUBASINF_SC]
                                                                                                                                                                                                                                                                 
@cocde 	nvarchar(6),
@cusno	nvarchar(6),
@type	nvarchar(30)
 
AS

BEGIN

if @type = 'Contact Person'
begin
	select	cci_cntctp, 
		cci_cntdef, 
		cci_cnttyp, 
		cci_cnttyp + ' - ' + cci_cntdef as 'buyrY', 
		cci_cnteml
	from	CUCNTINF (nolock) 
	where	cci_cusno = @cusno and 
		cci_cnttyp <> 'B' and 
		cci_cnttyp <> 'M' and 
		cci_cnttyp <> 'S' and 
		cci_delete = 'N'
	order by cci_cntctp
end

if @type = 'Agent'
begin
	select	cai_cusagt, 
		yai_stnam, 
		cai_cusdef
	from	CUAGTINF (nolock)
		left join CUBASINF (nolock) on 	
			cai_cusno = cbi_cusno 
	
		left join SYAGTINF (nolock) on 	
			cai_cusagt = yai_agtcde
	where	cai_cusno = @cusno
	order by cai_cusagt
end


if @type = 'Secondary'
begin
	select 	csc_prmcus, 
		csc_seccus, 
		csc_cusrel, 
		isnull(cbi_cussna,'InActive') as 'cbi_cussna', 
		a.cci_cntadr as 'cci_cntadr', 
		a.cci_cntstt as 'cci_cntstt', 
		a.cci_cntcty as 'cci_cntcty',
		a.cci_cntpst as 'cci_cntpst', 
		sec.cpi_prcsec, 
		sec.cpi_grsmgn, 
		isnull(b.cci_cntadr,'N/A') as 'ship_cci_cntadr', 
		isnull(b.cci_cntstt,'') as 'ship_cci_cntstt', 
		isnull(b.cci_cntcty,'') as 'ship_cci_cntcty', 
		isnull(b.cci_cntpst,'') as 'ship_cci_cntpst', 
		cbi_cerdoc, 
		case sec.cpi_paytrm when '' then pri.cpi_paytrm else sec.cpi_paytrm end	as 'cpi_paytrm'
	from 	CUSUBCUS (nolock)
		left join CUCNTINF a (nolock) on csc_seccus = cci_cusno and cci_cnttyp = 'M'
		left join CUCNTINF b (nolock) on csc_seccus = b.cci_cusno and b.cci_cnttyp = 'S' and b.cci_cntdef = 'Y'
		left join CUBASINF (nolock) on csc_seccus = cbi_cusno 
		left join CUPRCINF sec (nolock) on csc_seccus = sec.cpi_cusno 
		left join CUPRCINF pri (nolock) on csc_prmcus = pri.cpi_cusno 
		where	csc_prmcus = @cusno and
		cbi_cussts = 'A' 
	order by csc_seccus
end

if @type = 'Payment Term'
begin
	select	ysi_cde + ' - ' + ysi_dsc as 'dsc'
	from	SYSETINF (nolock) 
	where	ysi_typ = '04' and 
		ysi_cde = @cusno
end

if @type = 'Currency'
begin
	select	ysi_cde + ' - ' + ysi_dsc as 'dsc'
	from	SYSETINF (nolock)
	where	ysi_typ = '06' and 
		ysi_cde = @cusno
end

if @type = 'Conversion1'
begin
	select	ycf_code1, 
		ycf_code2, 
		ycf_value
	from	SYCONFTR (nolock)
	where	ycf_code1 = @cusno
end

if @type = 'Conversion'
begin
	select	ycf_value, 
		ycf_code1, 
		ycf_code2
	from	SYCONFTR (nolock) 
	where	ycf_code1 = @cusno and 
		ycf_code2 = 'PC'
end

END



GO
GRANT EXECUTE ON [dbo].[sp_select_CUBASINF_SC] TO [ERPUSER] AS [dbo]
GO
