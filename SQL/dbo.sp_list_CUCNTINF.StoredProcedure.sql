/****** Object:  StoredProcedure [dbo].[sp_list_CUCNTINF]    Script Date: 09/29/2017 15:29:09 ******/
DROP PROCEDURE [dbo].[sp_list_CUCNTINF]
GO
/****** Object:  StoredProcedure [dbo].[sp_list_CUCNTINF]    Script Date: 09/29/2017 15:29:09 ******/
SET ANSI_NULLS OFF
GO
SET QUOTED_IDENTIFIER OFF
GO












/************************************************************************
Author:		Kath Ng
Date:		25th September, 2001
Description:	Select data From CUCNTINF
Parameter:	1. Company
		2. Customer No.	
		3. Contact type
***********************************************************************
7  Jul 2003		Lewis To		Ignor Comp Code for handle multi Company
20 Aug 2003		Allan Yuen		Fix Dead Lock Error
20061228		Mark Lau		Filter the "Delete" contact
*/

CREATE  procedure [dbo].[sp_list_CUCNTINF]

@cci_cocde 	nvarchar(6) ,
@cci_cusno  	nvarchar(6) ,
@cci_cnttyp	nvarchar(6)
--@Type		nvarchar(2)
                                              
AS

begin

-- Billing ----------------------------------------------------------------------------------------------------------------
if @cci_cnttyp = 'B'
begin

SELECT	'   ' as 'Status',	cci_cntadr,	cci_cntstt,		
	cci_cntcty + ' - ' + ysi_dsc as 'cci_cntcty',
	cci_cntpst,	cci_cntdef,	cci_cntseq,
	cci_creusr,	cci_updusr,	cci_sapshcusno
 
FROM 
	CUCNTINF (nolock)
	LEFT JOIN SYSETINF (nolock) on 
		ysi_typ = '02' and 
		cci_cntcty = ysi_cde and 
		ysi_cocde = ' '		
		--cci_cocde


WHERE	--cci_cocde	= @cci_cocde and                                                                                                                                                                                                                         
	cci_cusno	= @cci_cusno and
	cci_cnttyp= @cci_cnttyp and cci_delete = 'N' and
	cci_cntadr <> '' 

ORDER BY cci_cntseq


END
------------------------------------------------------------------------------------------------------------------------------

-- Shipping -----------------------------------------------------------------------------------------------------------------
IF @cci_cnttyp = 'S'

BEGIN

SELECT	'   ' as 'Status',	cci_cntadr,	cci_cntstt,		
	cci_cntcty + ' - ' + ysi_dsc as 'cci_cntcty',
	cci_cntpst,	cci_cntdef,	cci_cntseq,
	cci_creusr,	cci_updusr,	cci_sapshcusno
 
FROM	 CUCNTINF
LEFT JOIN SYSETINF
on ysi_typ = '02'  and cci_cntcty = ysi_cde and ysi_cocde = ' '		--cci_cocde

WHERE	--cci_cocde	= @cci_cocde and
	cci_cusno	= @cci_cusno 
	and	cci_delete = 'N' and cci_cnttyp= @cci_cnttyp
	and	cci_cntadr <> '' 

ORDER BY cci_cntseq

END
------------------------------------------------------------------------------------------------------------------------------


-- Mailing ------------------------------------------------------------------------------------------------------------------
IF @cci_cnttyp = 'M'
BEGIN

SELECT	'   ' as 'Status',	cci_cntadr,	cci_cntstt,
	cci_cntcty,	cci_cntpst,	
	cci_cntseq,	cci_creusr,	cci_updusr,	cci_sapshcusno
 
FROM	CUCNTINF

WHERE	--cci_cocde	= @cci_cocde                                                                                                                                                                                                                
--and	
	cci_cusno	= @cci_cusno 
and	cci_cnttyp= @cci_cnttyp


END
------------------------------------------------------------------------------------------------------------------------------

--Contact-------------------------------------------------------------------------------------------------------------------
IF @cci_cnttyp = 'C'

BEGIN

SELECT	'   ' as 'Status',	
	 cci_cnttyp,
	cci_cntseq,	cci_cntctp,	cci_cnttil,		
	cci_cntphn,	cci_cntfax,	cci_cnteml,	
	cci_cntdef,	cci_creusr,	cci_updusr


FROM CUCNTINF

WHERE 	--cci_cocde	= @cci_cocde 
--and
	cci_cusno	= @cci_cusno and cci_delete = 'N' 
and	cci_cntctp <> ''

ORDER BY cci_cnttyp , cci_cntseq

END
------------------------------------------------------------------------------------------------------------------------------


END





GO
GRANT EXECUTE ON [dbo].[sp_list_CUCNTINF] TO [ERPUSER] AS [dbo]
GO
