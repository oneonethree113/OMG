/****** Object:  StoredProcedure [dbo].[sp_select_CUBASINF_PRI]    Script Date: 09/29/2017 15:29:09 ******/
DROP PROCEDURE [dbo].[sp_select_CUBASINF_PRI]
GO
/****** Object:  StoredProcedure [dbo].[sp_select_CUBASINF_PRI]    Script Date: 09/29/2017 15:29:10 ******/
SET ANSI_NULLS OFF
GO
SET QUOTED_IDENTIFIER OFF
GO












/*
=================================================================
Program ID	: sp_select_CUBASINF_PRI
Description	: Select Primary Customer
Programmer	: Joe Yim
=================================================================
	MODIFICATION HISTORY
=================================================================
   Date		 Editor			Description
=================================================================
2010-05-05	Joe Yim			SP Created
2013-02-15 	David Yue		ERP Enhancement Phase 2
=================================================================
*/


CREATE   Procedure [dbo].[sp_select_CUBASINF_PRI]
                                                                                                                                                                                                                                                                 
@cocde 	nvarchar(6),
@usrid	nvarchar(30),
@doctyp	nvarchar(2)
 
AS

begin
	select	distinct cbi_cusno,
		cbi_cussna,	
		isnull(a.cci_cntadr,'') as 'cci_cntadr',
		isnull(a.cci_cntstt,'')as 'cci_cntstt',
		isnull(a.cci_cntcty,'')as 'cci_cntcty',
		isnull(a.cci_cntpst,'')as 'cci_cntpst',
		cbi_salrep,
		cbi_srname,
		cbi_saltem,
		cbi_saldiv,
		cpi_smpprd,
		cpi_smpprd + ' - ' + c.yst_trmdsc as 'smpprd',
		cpi_smpfgt,
		cpi_smpfgt + ' - ' + d.yst_trmdsc as 'smpfgt',
		cpi_paytrm,
		cpi_paytrm + ' - ' + e.ysi_dsc as 'paytrm',
		cpi_prctrm,
		cpi_prctrm + ' - ' + f.ysi_dsc as 'prctrm',
		cpi_curcde,
		cpi_curcde + ' - ' + g.ysi_dsc as 'curcde',	
		cpi_prcfml,
		yfi_fml,
		isnull(b.cci_cntadr,'') as 'ship_cci_cntadr',
		isnull(b.cci_cntstt,'') as 'ship_cci_cntstt',
		isnull(b.cci_cntcty,'') as 'ship_cci_cntcty',
		isnull(b.cci_cntpst,'') as 'ship_cci_cntpst',
		--ysr_saltem,
		cbc_cdtuse as 'cpi_cdtuse',
		cbc_cdtlmt as 'cpi_cdtlmt',
		cbi_advord,
		cbi_cerdoc,
		isnull(cbc_rskuse,0) as 'cpi_rskuse',
	 	isnull(cbc_rsklmt,0) as 'cpi_rsklmt',
		cbi_cugrptyp_int,
		cbi_cugrptyp_ext
	from 	CUMCOVEN (nolock)
		left join CUBASINF (nolock) on
			cbi_cusno = ccv_cusno 
		left join CUCNTINF a (nolock) on
			cbi_cusno = a.cci_cusno and
			a.cci_cnttyp = 'M' and
			a.cci_cntseq = 1 and a.cci_delete = 'N'
		left join CUCNTINF b (nolock) on
			cbi_cusno = b.cci_cusno and
			b.cci_cnttyp = 'S' and
			b.cci_cntdef = 'Y' and b.cci_delete = 'N'
		left join CUPRCINF (nolock) on
			cbi_cusno = cpi_cusno
		left join SYFMLINF (nolock) on
			yfi_cocde = ' ' and
			yfi_fmlopt = cpi_prcfml
		--left join SYSALREP (nolock) on
		--	ysr_cocde = ' ' and
		--	ysr_code1 = cbi_salrep
		left join SYSMPTRM c (nolock) on
			c.yst_cocde = ' ' and
			c.yst_trmcde = cpi_smpprd
		left join SYSMPTRM d (nolock) on
			d.yst_cocde = ' ' and
			d.yst_trmcde = cpi_smpfgt
		left join SYSETINF e (nolock) on
			e.ysi_cocde = ' ' and
			e.ysi_cde = cpi_paytrm and
			e.ysi_typ = '04'
		left join SYSETINF f (nolock) on
			f.ysi_cocde = ' ' and 
			f.ysi_cde = cpi_prctrm and
			f.ysi_typ = '03'
		left join SYSETINF g (nolock) on
			g.ysi_cocde = ' ' and
			g.ysi_cde = cpi_curcde and
			g.ysi_typ = '06'
		--New add on 6 Aug 2003 by Lewis
		left join CUBCR (nolock) on
			cbc_cocde = @cocde and
			cbc_cusno = cpi_cusno
	where	ccv_cocde = @cocde and
		cbi_custyp = 'P' and
		cbi_cussts = 'A' and
		(	exists
			(	select	1
				from	SYUSRRIGHT (nolock)
				where	yur_usrid = @usrid and
					yur_doctyp = @doctyp and
					yur_lvl = 0
			) or
			cbi_saltem in 
			(	select	yur_para
				from	SYUSRRIGHT (nolock)
				where	yur_usrid = @usrid and
					yur_doctyp = @doctyp and
					yur_lvl = 1
			)
			or cbi_cusno in 
			(	select	yur_para
				from	SYUSRRIGHT (nolock)
				where	yur_usrid = @usrid and
					yur_doctyp = @doctyp and
					yur_lvl = 2
			)
		)
	order by cbi_cusno
end





GO
GRANT EXECUTE ON [dbo].[sp_select_CUBASINF_PRI] TO [ERPUSER] AS [dbo]
GO
