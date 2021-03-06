/****** Object:  StoredProcedure [dbo].[sp_list_CUBASINF_CUCNTINF]    Script Date: 09/29/2017 15:29:09 ******/
DROP PROCEDURE [dbo].[sp_list_CUBASINF_CUCNTINF]
GO
/****** Object:  StoredProcedure [dbo].[sp_list_CUBASINF_CUCNTINF]    Script Date: 09/29/2017 15:29:09 ******/
SET ANSI_NULLS OFF
GO
SET QUOTED_IDENTIFIER OFF
GO








/************************************************************************
Author:		Kenny Chan
Date:		24th September, 2001
Description:	List data From CUBASINF and join with CUCNTINF
Parameter:	1. Company Code range    
************************************************************************/


CREATE procedure [dbo].[sp_list_CUBASINF_CUCNTINF]
                                                                                                                                                                                                                                                               
@cbi_cocde nvarchar(6) = ' '

 AS  Select 

cbi_cocde,
cbi_cusno,
cbi_custyp,
cbi_cussts,
cbi_cussna,
cbi_cusnam,
cbi_cusweb,
cbi_salrep,
cbi_salmgt,
cbi_refno,
cbi_cusrat,
cbi_mrkreg,
cbi_mrktyp,
cbi_advord,
cbi_rmk,
cbi_cuspod,
cbi_cusfde,
cbi_cuscfs,
cbi_custhc,
cbi_cuspro,
cbi_creusr,
cbi_updusr,
cbi_credat,
cbi_upddat,
cbi_timstp,
cci_cocde,
cci_cusno,
cci_cnttyp,
cci_cntseq,
cci_cntadr,
cci_cntstt,
isnull(cci_cntcty,'N/A' )as 'cci_cntcty',
cci_cntpst,
cci_cntctp,
cci_cnttil,
cci_cntphn,
cci_cntfax,
cci_cnteml,
cci_cntrmk,
cci_cntdef,
cci_creusr,
cci_updusr,
cci_credat,
cci_upddat,
cci_timstp,
Getdate() as 'CurrentDate'

 from CUBASINF
left join CUCNTINF on --cbi_cocde = cci_cocde and 
cbi_cusno = cci_cusno and cci_cnttyp = 'M' 
 where                                                                                                                                                                                                                                                                 
-- cbi_cocde = @cbi_cocde and
 cbi_cussts =  'A'







GO
GRANT EXECUTE ON [dbo].[sp_list_CUBASINF_CUCNTINF] TO [ERPUSER] AS [dbo]
GO
