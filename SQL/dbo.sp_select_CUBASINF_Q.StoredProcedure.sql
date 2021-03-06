/****** Object:  StoredProcedure [dbo].[sp_select_CUBASINF_Q]    Script Date: 09/29/2017 15:29:09 ******/
DROP PROCEDURE [dbo].[sp_select_CUBASINF_Q]
GO
/****** Object:  StoredProcedure [dbo].[sp_select_CUBASINF_Q]    Script Date: 09/29/2017 15:29:10 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO


-- Checked by Allan Yuen at 28/08/2003

/************************************************************************
Author:		Tommy
Date:		18 Dec, 2001
Description:	Select Contact Person of the Customer (Use in QUM00001)
************************************************************************/

CREATE procedure [dbo].[sp_select_CUBASINF_Q]
                                                                                                                                                                                                                                                               
  
@cocde 	nvarchar(6),
@cusno	nvarchar(6),
@type	nvarchar(30)
 
AS

begin

if @type = 'Contact Person'
begin
	select 	cci_cntctp, 	cci_cntdef,		cci_cnttyp,
		cci_cnttyp + ' - ' + cci_cntdef as 'buyrY'
		-- Added by Mark Lau 20080620
		,cci_cnteml
	from cucntinf 
	where
	cci_cusno = @cusno		and 
	cci_cnttyp <> 'B'		and 
	cci_cnttyp <> 'M' 		and 
	cci_cnttyp <> 'S' 	and cci_delete = 'N'
	order by cci_cntctp
end

if @type = 'Agent'
begin
	select	cai_cusagt,	 	yai_stnam,		cai_cusdef
	from CUAGTINF

	left join CUBASINF on 	
			--cai_cocde = cbi_cocde and 
			cai_cusno = cbi_cusno 

	left join SYAGTINF on 	
			--cai_cocde = yai_cocde and 
			cai_cusagt = yai_agtcde

	where 
		--cai_cocde = @cocde and 
		cai_cusno = @cusno
	order by cai_cusagt
end


if @type = 'Secondary'
begin
	select 	csc_prmcus,	csc_seccus,		
		csc_cusrel,
		isnull(cbi_cussna,'InActive')as 'cbi_cussna',	
		a.cci_cntadr as 'cci_cntadr',		
		a.cci_cntstt as 'cci_cntstt',		
		a.cci_cntcty as 'cci_cntcty',
		a.cci_cntpst as 'cci_cntpst',		
		secpri.cpi_prcsec,
		secpri.cpi_grsmgn,
		isnull(b.cci_cntadr,'N/A') as 'ship_cci_cntadr' ,	
		isnull(b.cci_cntstt,'') as 'ship_cci_cntstt',
		isnull(b.cci_cntcty,'') as 'ship_cci_cntcty',	
		isnull(b.cci_cntpst,'') as 'ship_cci_cntpst',
		cbi_cerdoc,
		isnull(secpri.cpi_paytrm + ' - ' + secysi.ysi_dsc,isnull(pripri.cpi_paytrm + ' - ' + priysi.ysi_dsc,'NULL'))as 'paytrm'--If the payterm of the secord customer is NULL, return the payterm of primary customer.
	from 	CUSUBCUS
	left join 	CUCNTINF a on 	
			csc_seccus = cci_cusno and 
			--csc_cocde = cci_cocde and 
			cci_cnttyp = 'M'

	left join 	CUCNTINF b on 	
			csc_seccus = b.cci_cusno and 
			--csc_cocde = b.cci_cocde and 
			b.cci_cnttyp = 'S' and 
			b.cci_cntdef = 'Y' and b.cci_delete <> 'Y'

	left join 	CUBASINF on	
			csc_seccus = cbi_cusno 
			--and csc_cocde = cbi_cocde 
			--and cbi_cussts = 'A'
	left join 	CUPRCINF secpri on
			csc_seccus = secpri.cpi_cusno 
			--and csc_cocde = cpi_cocde
	left join SYSETINF secysi on 
		secpri.cpi_paytrm=secysi.ysi_cde
	left join 	CUPRCINF pripri on 
		csc_prmcus = pripri.cpi_cusno 
			--and csc_cocde = cpi_cocde
	left join SYSETINF priysi on 
		pripri.cpi_paytrm=priysi.ysi_cde
	where
		--csc_cocde = @cocde	and
		(@cusno = 'ALL' or (@cusno <> 'ALL' and csc_prmcus = @cusno))	and
		cbi_cussts = 'A'
	order by csc_seccus
end

if @type = 'Payment Term'
begin
	select	ysi_cde + ' - ' + ysi_dsc as 'dsc'
	from SYSETINF
	where 
	--ysi_cocde = @cocde 	and
	ysi_typ = '04'		and
	ysi_cde = @cusno	--@cusno = Payment Term
end

if @type = 'Currency'
begin
	select	ysi_cde + ' - ' + ysi_dsc as 'dsc'
	from SYSETINF
	where 
	--ysi_cocde = @cocde 	and
	ysi_typ = '06'	and
	ysi_cde = @cusno	--@cusno = Currecy 
end

if @type = 'Conversion1'
begin
	select 	ycf_code1, 	ycf_code2, 	ycf_value
	from SYCONFTR 
	where 	
		--ycf_cocde = @cocde 	and 
		ycf_code1 = @cusno 	--@cusno = UM
		--ycf_code2 = 'PC'
end

if @type = 'Conversion'
begin
	select 	ycf_value,		ycf_code1, 	ycf_code2
	from SYCONFTR 
	where 	
		--ycf_cocde = @cocde 	and 
		ycf_code1 = @cusno 	and --@cusno = UM
		ycf_code2 = 'PC'
end

end





GO
GRANT EXECUTE ON [dbo].[sp_select_CUBASINF_Q] TO [ERPUSER] AS [dbo]
GO
