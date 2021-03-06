/****** Object:  StoredProcedure [dbo].[sp_list_CUCNTINF_SAM00003_01]    Script Date: 09/29/2017 15:29:09 ******/
DROP PROCEDURE [dbo].[sp_list_CUCNTINF_SAM00003_01]
GO
/****** Object:  StoredProcedure [dbo].[sp_list_CUCNTINF_SAM00003_01]    Script Date: 09/29/2017 15:29:09 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO






/************************************************************************
Author:		Johnson Lai
Date:		8 Feb, 2002
Description:	Select data From CUCNTINF
Parameter:	1. Company
		2. Customer No.	
		3. BUYR
************************************************************************/

CREATE procedure [dbo].[sp_list_CUCNTINF_SAM00003_01]

@cci_cocde 	nvarchar(6) ,
@cci_cusno	nvarchar(6),
@usrid		nvarchar(30)
                                              
AS

-- Billing ----------------------------------------------------------------------------------------------------------------
begin

SELECT	

distinct

cci_cntadr,
cci_cntstt,
isnull(cci_cntcty,'')  + ' - ' +  isnull(ysi_dsc,'')  as 'cci_cntcty' ,
cci_cntpst

 
FROM CUCNTINF
left join SYSETINF on --cci_cocde = ysi_cocde and 
		cci_cntcty = ysi_cde and ysi_typ  = '02' 

WHERE	--cci_cocde	= @cci_cocde and                                                                                                                                                                                                                         
	cci_cusno = @cci_cusno and
	(cci_cnttyp =  'B' or	cci_cnttyp = 'M')
 
ORDER BY cci_cntadr


END
------------------------------------------------------------------------------------------------------------------------------




GO
GRANT EXECUTE ON [dbo].[sp_list_CUCNTINF_SAM00003_01] TO [ERPUSER] AS [dbo]
GO
