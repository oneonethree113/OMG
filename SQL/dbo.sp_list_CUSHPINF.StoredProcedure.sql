/****** Object:  StoredProcedure [dbo].[sp_list_CUSHPINF]    Script Date: 09/29/2017 15:29:09 ******/
DROP PROCEDURE [dbo].[sp_list_CUSHPINF]
GO
/****** Object:  StoredProcedure [dbo].[sp_list_CUSHPINF]    Script Date: 09/29/2017 15:29:09 ******/
SET ANSI_NULLS OFF
GO
SET QUOTED_IDENTIFIER OFF
GO







/************************************************************************
Author:		Kath Ng
Date:		25th September, 2001
Description:	Select data From CUSHPINF
Parameter:	1. Company
		2. Customer No.	
		3. Contact type
***********************************************************************
7 Jul 2003		Lewis To		Ignor Comp Code for handle multi Company
*/

CREATE procedure [dbo].[sp_list_CUSHPINF]

@csi_cocde 	nvarchar(6),
@csi_cusno  	nvarchar(6),
@Type		nvarchar(1)
                                              
AS

BEGIN

-- For Bank / FCR / BL ------------------------------------------------------------------------------------------------------------
IF @Type= 'B'
BEGIN
	SELECT 

	'   ' as 'Status',	

	CASE csi_csetyp
	WHEN 'BK' THEN 'BK - Bank'
	WHEN 'NP' THEN 'NP - Notify Party'
	WHEN 'CN' THEN 'CN - Consignee'
	END AS csi_csetyp,
	csi_csenam,	csi_cseseq,	csi_cseadr,	
	csi_csestt,		csi_csecty + ' - ' + ysi_dsc as 'csi_csecty',
	csi_csepst,	csi_csectp,	csi_csetil,
	csi_csephn,	csi_csefax,	csi_cseeml,
	csi_csedef,	csi_creusr,
	csi_updusr

FROM CUSHPINF

LEFT JOIN SYSETINF
ON ysi_typ = '02'  and csi_csecty = ysi_cde and ysi_cocde = ' ' 	--csi_cocde

WHERE	--csi_cocde = @csi_cocde
--and
	csi_cusno	= @csi_cusno 
and 	(csi_csetyp = 'BK' 	or 	csi_csetyp = 'NP'	or 	csi_csetyp = 'CN')

ORDER BY csi_csetyp

END

-- For Forwarder / Courier Information ------------------------------------------------------------------------------------------------------------------

IF @Type = 'C'
BEGIN


SELECT	'   ' as 'Status',	

	CASE csi_csetyp
	WHEN 'FO' THEN 'FO - Ocean Forwarder'
	WHEN 'FA' THEN 'FA - Air Forwarder'
	WHEN 'FT' THEN 'FT - Other Forwarder'
	WHEN 'CO' THEN 'CO - Courier'
	END  AS csi_csetyp,	
	csi_cseseq,
	csi_csenam,	
	csi_cseacc,	csi_csedsc,	csi_cseadr,
	csi_csestt,		csi_csecty + ' - ' + ysi_dsc as 'csi_csecty',
	csi_csepst,	csi_csectp,	csi_csetil,
	csi_csephn,	csi_csefax,	csi_cseeml,	
	csi_cseinr,	csi_csedef,	csi_creusr,	
	csi_updusr

FROM CUSHPINF

LEFT JOIN SYSETINF
ON ysi_typ = '02'  and csi_csecty = ysi_cde and ysi_cocde = ' '	--csi_cocde

WHERE	--csi_cocde = @csi_cocde
--and
	csi_cusno	= @csi_cusno 
and 	(csi_csetyp = 'FO' 
or 	csi_csetyp = 'FA'
or 	csi_csetyp = 'FT'
or	csi_csetyp = 'CO')

END
----------------------------------------------------------------------------------------------------------------------------------------------------------------

END





GO
GRANT EXECUTE ON [dbo].[sp_list_CUSHPINF] TO [ERPUSER] AS [dbo]
GO
