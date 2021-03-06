/****** Object:  StoredProcedure [dbo].[sp_select_MSR00016]    Script Date: 09/29/2017 15:29:09 ******/
DROP PROCEDURE [dbo].[sp_select_MSR00016]
GO
/****** Object:  StoredProcedure [dbo].[sp_select_MSR00016]    Script Date: 09/29/2017 15:29:10 ******/
SET ANSI_NULLS OFF
GO
SET QUOTED_IDENTIFIER OFF
GO






-- Checked by Allan Yuen at 27/07/2003


/*********************************************************************************************************************
Modification History
*********************************************************************************************************************
Modified on		Modified by		Description
*********************************************************************************************************************
17 Mar 2005		Lester Wu		Cater add new company 
						retrieve company name from database
*********************************************************************************************************************
*/


CREATE  PROCEDURE [dbo].[sp_select_MSR00016] 

@cocde		nvarchar(6),
@itemFm		nvarchar(20),	-- Item No.
@itemTo		nvarchar(20),
@venFm		nvarchar(6),	-- Vendor Code
@venTo		nvarchar(6),
@custFm		nvarchar(6),	-- Customer Code
@custTo		nvarchar(6),
@lotFm		nvarchar(10),	-- Lot #
@lotTo		nvarchar(10),
@sort		nvarchar(1),
@creusr 		nvarchar(30)

AS

------------------------------------------------------------------------------------------------------------------------------------------------------
--Lester Wu 2005/03/03 -- Retrieve Company Name, Short Name, Address, Phone No, Fax No, Email Address, Logo Path
------------------------------------------------------------------------------------------------------------------------------------------------------
DECLARE
@yco_conam	varchar(100)

set @yco_conam = 'UNITED CHINESE GROUP'

if @cocde <> 'UC-G' 
BEGIN
	select @yco_conam=yco_conam from SYCOMINF(NOLOCK) where yco_cocde = @cocde
END

------------------------------------------------------------------------------------------------------------------------------------------------------
------------------------------------------------------------------------------------------------------------------------------------------------------



Select 
Soh_cus1no + ' - ' + cbi_cussna as 'cust',
Ivt_itmno,
ibi_engdsc,
Ivt_jobno = upper(Ivt_jobno),
Ivt_colcde,
ltrim(Ivt_untcde) + ' / ' + ltrim(str(ivt_inrqty,10,0)) + ' / ' + ltrim(str(ivt_mtrqty,10,0)) + ' / ' + ltrim(str(ivt_cft,10,2)) as 'packing',
Irt_qty,
irt_txntyp,
Ivt_qty / ivt_mtrqty as 'ctn',
Irt_curcde, irt_ftyprc,
Ivt_lotno,
poh_venno,
Ivt_purord,
ivt_qty,
irt_txndat,
pod_cusitm,
@cocde,
@itemFm,
@itemTo,
@venFm,
@venTo,
@custFm,
@custTo,
@lotFm,
@lotTo,
@sort,
@creusr,
@yco_conam as 'compName'	--Lester Wu 2005-03-17 retrieve company information from database instead of hardcode

From IMVTLITY, IMRECTXN, SCORDHDR, CUBASINF, POORDHDR, POORDDTL, IMBASINF 
Where 	-- 2004/02/16 Lester Wu
	--ivt_cocde = @cocde 
	--Lester Wu 2005-03-17 Replace "ALL" with "UC-G"
	--(@cocde='ALL' or ivt_cocde=@cocde)
	((@cocde<>'UC-G'  and ivt_cocde=@cocde) or (@cocde='UC-G' and ivt_cocde<>'MS') )
	--------------------------------------------------

--And ivt_cocde = poh_cocde and ivt_purord = poh_purord
and ivt_purord = poh_purord
And ivt_purord = pod_purord and ivt_purseq = pod_purseq

And poh_cocde = soh_cocde and poh_ordno = soh_ordno

--And soh_cocde = cbi_cocde and soh_cus1no = cbi_cusno
and  soh_cus1no = cbi_cusno

--And ivt_cocde = ibi_cocde and ivt_itmno = ibi_itmno
and ivt_itmno = ibi_itmno


--And ivt_cocde = irt_cocde and ivt_lotno = irt_lotno
and ivt_lotno = irt_lotno
and irt_qty <> 0
And ivt_itmno between 
	(case ltrim(@itemFm) when '' then '' else @itemFm end)
		and
	(case ltrim(@itemTo) when '' then 'ZZZZZZZZZZZZZZZZZZZZ' else @itemTo end)
And soh_cus1no between
	(case ltrim(@custFm) when '' then '' else @custFm end)
		and
	(case ltrim(@custTo) when '' then 'ZZZZZZ' else @custTo end)
And poh_venno between
	(case ltrim(@venFm) when '' then '' else @venFm end)	
		and
	(case ltrim(@venTo) when '' then 'ZZZZZZ' else @venTo end)
And ivt_lotno between --'V0200002' and 'V0200002'
	(case ltrim(@lotFm) when '' then '' else @lotFm end)
		and
	(case ltrim(@lotTo) when '' then 'ZZZZZZZZZZ' else @lotTo end)
order by (case @sort 	when 'I' then ivt_itmno 
		else '' end),
	Ivt_lotno, irt_txndat







GO
GRANT EXECUTE ON [dbo].[sp_select_MSR00016] TO [ERPUSER] AS [dbo]
GO
