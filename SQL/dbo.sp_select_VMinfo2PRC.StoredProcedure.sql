/****** Object:  StoredProcedure [dbo].[sp_select_VMinfo2PRC]    Script Date: 09/29/2017 15:29:08 ******/
DROP PROCEDURE [dbo].[sp_select_VMinfo2PRC]
GO
/****** Object:  StoredProcedure [dbo].[sp_select_VMinfo2PRC]    Script Date: 09/29/2017 15:29:10 ******/
SET ANSI_NULLS OFF
GO
SET QUOTED_IDENTIFIER ON
GO


/*
==================================================================================
Program ID	: 	sp_select_VMinfo2PRC
DePOription   	: 	Select released po information to PRC
Programmer  	: 	Allan Yuen
Create Date   	: 	1 March 2006
Last Modified  	: 
Table Read(s) 	:	
Table Write(s) 	:	
==================================================================================
 Modification History                                    
==================================================================================
Modification Date	Modified by	Description
==================================================================================
==================================================================================     
*/



CREATE PROCEDURE [dbo].[sp_select_VMinfo2PRC]  

@sod_cocde nvarchar(6) = '',
@opt char(1)

AS

--sp_select_vminfo2prc 'ucpp','4'


if @opt = '1' 
	--- Basic Info
	select 
		vbi_venno as 'Vendor No.',
		vbi_vensna as 'Vendor Short Name',
		vbi_vennam as 'Vendor Name' 
	from 
		vnbasinf
	where
		vbi_vensts = 'A' and vbi_ventyp = 'E'
	order by 
		vbi_venno 	

else 
if @opt = '2' 
	--- Address
	select 
		vbi_venno as 'Vendor No.',
		vbi_vensna as 'Vendor Short Name',
		vci_adr as 'Company Address',
		vci_stt as 'State / Privince',
		vci_cty + ' - ' + ysi_dsc as 'Country',
		vci_zip as 'ZIP / Postal'
	from 
		vnbasinf
		left join VNCNTINF on vbi_venno = vci_venno
		left join SYSETINF on ysi_typ = '02'  and vci_cty = ysi_cde
	where                                
		vbi_vensts = 'A' and 
		vbi_ventyp = 'E'  and
		vci_cnttyp	= 'M' AND
		vci_cty <> ''
	order by 
		vbi_venno 	

else
if @opt = '3'

	--- Other Address
	select 
		vbi_venno as 'Vendor No.',
		vbi_vensna as 'Vendor Short Name',
		vci_adr as 'Company Address',
		vci_stt as 'State / Privince',
		vci_cty + ' - ' + ysi_dsc as 'Country',
		vci_zip as 'ZIP / Postal'
	from 
		vnbasinf
		left join VNCNTINF on vbi_venno = vci_venno
		left join SYSETINF on ysi_typ = '02'  and vci_cty = ysi_cde
	where                                
		vbi_vensts = 'A' and 
		vbi_ventyp = 'E'  and
		vci_cnttyp	= 'U' AND
		vci_cty <> ''
	order by 
		vbi_venno 	

else
if @opt = '4'
	-- Conract
	select 
		vbi_venno as 'Vendor No.',
		vbi_vensna as 'Vendor Short Name',
		vci_cnttyp + ' - ' + ysi_dsc  as 'Nature',
		vci_cntctp as 'Contact Person',
		vci_cnttil as 'Title',
		vci_cntphn as 'Phone No.',
		vci_cntfax as 'Fax No.',
		vci_cnteml as 'E-mail'
	from 
		vnbasinf
		left join VNCNTINF  on vbi_venno = vci_venno
		left join SYSETINF on ysi_typ = '13'  and vci_cnttyp  = ysi_cde
	where                                  
		vbi_vensts = 'A' and 
		vbi_ventyp = 'E'  and
		vci_cntctp	<> ''
	order by 
		vbi_venno,
		vci_cnttyp, 
		vci_cntdef desc, 
		vci_cntctp





GO
GRANT EXECUTE ON [dbo].[sp_select_VMinfo2PRC] TO [ERPUSER] AS [dbo]
GO
