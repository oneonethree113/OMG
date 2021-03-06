/****** Object:  StoredProcedure [dbo].[sp_list_CUBASINF_SAM00003_1]    Script Date: 09/29/2017 15:29:09 ******/
DROP PROCEDURE [dbo].[sp_list_CUBASINF_SAM00003_1]
GO
/****** Object:  StoredProcedure [dbo].[sp_list_CUBASINF_SAM00003_1]    Script Date: 09/29/2017 15:29:09 ******/
SET ANSI_NULLS OFF
GO
SET QUOTED_IDENTIFIER OFF
GO






CREATE PROCEDURE [dbo].[sp_list_CUBASINF_SAM00003_1]

@cbi_cocde as nvarchar(6),
@cbi_custyp as nvarchar(1)


as

SELECT  

csc_prmcus as 'cbi_cus1no' , 
cbi_cusno as 'cbi_cus2no' , 
cbi_cussna = Case cbi_cussts when 'A' then cbi_cussna when 'I' then rtrim(cbi_cussna) + '(Inactive)' when 'D' then  rtrim(cbi_cussna) + '(Discontinue)' else cbi_cussna end,
isnull(cci_cntadr,'') as 'cci_cntadr' , 
isnull(cci_cntstt,'') as 'cci_cntstt', 
isnull(cci_cntcty,'') + ' - ' +  isnull(ysi_dsc,'') as 'cci_cntcty' , 
isnull(cci_cntpst,'') as 'cci_cntpst'

FROM      CUBASINF 

inner join  CUSUBCUS on 
	--cbi_cocde = csc_cocde and 
	cbi_cusno = csc_seccus
left join CUCNTINF on 
	--cbi_cocde = cci_cocde and 
	cbi_cusno = cci_cusno and cci_cnttyp = 'S' and cci_cntseq = 1
left join SYSETINF on 
	--cbi_cocde = ysi_cocde and 
	cci_cntcty = ysi_cde and ysi_typ  = '02' 


WHERE 

--cbi_cocde = @cbi_cocde AND 
cbi_custyp = @cbi_custyp  AND 
cbi_cussts  =  'A'

order by csc_prmcus


GO
GRANT EXECUTE ON [dbo].[sp_list_CUBASINF_SAM00003_1] TO [ERPUSER] AS [dbo]
GO
