/****** Object:  StoredProcedure [dbo].[sp_select_VN_IMPORTSAP]    Script Date: 09/29/2017 15:29:08 ******/
DROP PROCEDURE [dbo].[sp_select_VN_IMPORTSAP]
GO
/****** Object:  StoredProcedure [dbo].[sp_select_VN_IMPORTSAP]    Script Date: 09/29/2017 15:29:10 ******/
SET ANSI_NULLS OFF
GO
SET QUOTED_IDENTIFIER ON
GO





CREATE PROCEDURE [dbo].[sp_select_VN_IMPORTSAP]
                                                                                                                                                                                                                                                                 
@cocde nvarchar(6),
@tbltype nvarchar(1),
@initdata nvarchar(1)
 
AS
BEGIN

if @tbltype = 'M'
begin
	select
	(replicate('0', 10-len(vbi_venno)) + rtrim(vbi_venno)) as zlifnr,
	rtrim(vbi_vensna) as zname,
	rtrim(vbi_vennam) as zename,
	rtrim(vbi_venchnnam) as zcname,
	vbi_vensts as zlifsta,
	vbi_venfty as zvenfty,
	convert(nvarchar(8), vbi_credat ,112) as erdat,
	convert(nvarchar(8), vbi_upddat ,112) as laeda
	from vnbasinf (nolock) where vbi_ventyp = 'E' and (vbi_venno >= '1000'  and vbi_venno < '9000') and
	(
	vbi_venno in
		(select distinct vbi_venno from ucperpdb_aud.. vnbasinf_aud (nolock) where 
		convert(nvarchar(10),vbi_credat,111) = convert(nvarchar(10),getdate() ,111) and 
		(vbi_actflg_aud = '1' or vbi_actflg_aud = '3')
	)
	or @initdata = 'X')
end

if @tbltype = 'C'
begin
	select
	(replicate('0', 10-len(vci_venno)) + rtrim(vci_venno)) as zlifnr,
	vci_cnttyp as zcnttyp,
	vci_seq as zseq,
	rtrim(vci_adr) as zeaddress,
	rtrim(vci_chnadr) as zcaddress,
	rtrim(vci_stt) as zstreet,
	rtrim(vci_cty) as zcity,
	rtrim(vci_cntctp) as zcontact,
	rtrim(vci_cnttil) as ztitle,
	vci_cntphn as ztelno,
	vci_cntfax as fax,
	vci_cnteml as email,
	vci_cntdef as zcntdef,
	convert(nvarchar(8), vci_credat ,112) as erdat,
	convert(nvarchar(8), vci_upddat ,112) as laeda
	from vncntinf (nolock)
	inner join vnbasinf (nolock)
	on vbi_venno = vci_venno
	where vbi_ventyp = 'E' and (vbi_venno >= '1000'  and vbi_venno < '9000') and
	(
	vbi_venno in
		(select distinct vbi_venno  from ucperpdb_aud.. vnbasinf_aud (nolock) where 
		convert(nvarchar(10),vbi_credat,111) = convert(nvarchar(10),getdate() ,111) and 
		(vbi_actflg_aud = '1' or vbi_actflg_aud = '3'))
	or 
	@initdata = 'X')
end

if @tbltype = 'R'
begin
	select distinct
	(replicate('0', 10-len(vsv_ven1cde)) + rtrim(vsv_ven1cde)) as zlifnr,
	(replicate('0', 10-len(vsv_ven2cde)) + rtrim(vsv_ven2cde)) as zftynr,
	vsv_venrel as zreltype
	from vnsubvn (nolock)
	inner join vnbasinf (nolock)
	on vbi_venno = vsv_ven1cde or vbi_venno = vsv_ven2cde
	where vbi_ventyp = 'E' and (vbi_venno >= '1000'  and vbi_venno < '9000') and
	(
	vbi_venno in
		(select distinct vbi_venno  from ucperpdb_aud.. vnbasinf_aud (nolock) where 
		convert(nvarchar(10),vbi_credat,111) = convert(nvarchar(10),getdate() ,111) and 
		(vbi_actflg_aud = '1' or vbi_actflg_aud = '3'))
	or 
	@initdata = 'X')
end
END




GO
GRANT EXECUTE ON [dbo].[sp_select_VN_IMPORTSAP] TO [ERPUSER] AS [dbo]
GO
