/****** Object:  StoredProcedure [dbo].[sp_CUR00002]    Script Date: 09/29/2017 15:29:09 ******/
DROP PROCEDURE [dbo].[sp_CUR00002]
GO
/****** Object:  StoredProcedure [dbo].[sp_CUR00002]    Script Date: 09/29/2017 15:29:09 ******/
SET ANSI_NULLS OFF
GO
SET QUOTED_IDENTIFIER OFF
GO






/************************************************************************
Author:		Kath Ng     
Date:		11th November, 2001
Report ID:	CUR00002
Description:	Customer to Customer Relation
************************************************************************/

CREATE PROCEDURE [dbo].[sp_CUR00002] 
                                                                                                                                                                                                                                                                 
@gsCompany	nvarchar(8),
@FromCustNo	nvarchar(6),
@ToCustNo	nvarchar(6),
@CusType	nvarchar(1)

 
AS

BEGIN
----------------------------------------------------------------------------------------------------------------------------------------------------------------------------
IF @CusType = 'P' 
BEGIN
SELECT	@gsCompany,	@FromCustNo,	@ToCustNo,	
	@CusType,	csc_cocde,	csc_prmcus,	
	pri.cbi_cussna,	csc_seccus,	sec.cbi_cussna,
	CASE csc_cusrel WHEN 'A' THEN 'Active'	WHEN 'P' THEN 'Passive'	END AS csc_cusrel
FROM CUSUBCUS
LEFT JOIN CUBASINF pri  ON pri.cbi_cusno = csc_prmcus
AND	pri.cbi_cocde = @gsCompany
AND	csc_prmcus BETWEEN @FromCustNo AND @ToCustNo

LEFT JOIN CUBASINF sec ON sec.cbi_cusno = csc_seccus
AND	sec.cbi_cocde = @gsCompany


WHERE	csc_cocde = @gsCompany


order by csc_prmcus

END
----------------------------------------------------------------------------------------------------------------------------------------------------------------------------

IF @CusType = 'S'
BEGIN
SELECT @gsCompany,	@FromCustNo,	@ToCustNo,	
	@CusType,	csc_cocde,	csc_seccus,	
	sec.cbi_cussna,	csc_prmcus,	pri.cbi_cussna,
	CASE csc_cusrel WHEN 'A' THEN 'Active'	WHEN 'P' THEN 'Passive'	END AS csc_cusrel
FROM CUSUBCUS
LEFT JOIN CUBASINF pri  ON pri.cbi_cusno = csc_prmcus
and pri.cbi_cocde = @gsCompany

LEFT JOIN CUBASINF sec ON sec.cbi_cusno = csc_seccus
and sec.cbi_cocde = @gsCompany


WHERE csc_cocde = @gsCompany
AND	csc_seccus BETWEEN @FromCustNo AND @ToCustNo


order by csc_seccus

END
--------------------------------------------------------------------------------------
END


GO
GRANT EXECUTE ON [dbo].[sp_CUR00002] TO [ERPUSER] AS [dbo]
GO
