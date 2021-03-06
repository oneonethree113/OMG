/****** Object:  StoredProcedure [dbo].[sp_select_MSR00014]    Script Date: 09/29/2017 15:29:09 ******/
DROP PROCEDURE [dbo].[sp_select_MSR00014]
GO
/****** Object:  StoredProcedure [dbo].[sp_select_MSR00014]    Script Date: 09/29/2017 15:29:10 ******/
SET ANSI_NULLS OFF
GO
SET QUOTED_IDENTIFIER OFF
GO


/*********************************************************************************************************************
Modification History
*********************************************************************************************************************
Modified on		Modified by		Description
*********************************************************************************************************************
17 Mar 2005		Lester Wu		Cater add new company 
						retrieve company name from database
*********************************************************************************************************************
*/


CREATE  PROCEDURE [dbo].[sp_select_MSR00014]

	@cocde 		nvarchar	(6),
	@CF		nvarchar	(20),
	@CT		nvarchar	(20),
	@SF		nvarchar	(20),
	@ST		nvarchar	(20),
	@user		nvarchar 	(30)
AS
-----------------------------------------------------------
Declare		
	@containOpt	nvarchar	(1),
	@shipOpt		nvarchar	(1)

	SET @containOpt = 'N'
		If @CF <> '' or @CT <> ''
		begin
			SET @containOpt = 'Y'
		end

	SET @shipOpt = 'N'
		If @SF <> '' or @ST <> ''
		begin
			SET @shipOpt = 'Y'
		end	
--------------------------------------------------------

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
	DISTINCT

	-- Parameter 
	@cocde,
	@CF,		@CT,
	@SF,		@ST,

	-- SHIPGDTL
	hid_ctrcfs,
	Case isnull(ltrim(hid_pckrmk), '') when '' then hid_ctrsiz else hid_ctrsiz + '  - ' + hid_pckrmk end,
	hid_invno,	
	hid_shpno,

	-- SHIPGHDR
	hih_slnonb,
	@yco_conam as 'compName'


FROM 	SHIPGDTL, SHIPGHDR
where 	hid_cocde = hih_cocde
and	hid_shpno = hih_shpno and hid_cocde = hih_cocde 
and	((@containOpt = 'Y' and hid_ctrcfs between @CF and @CT) or @containOpt = 'N')
and	((@shipOpt = 'Y' and hid_shpno between @SF and @ST) or @shipOpt = 'N')
-- 2004/02/16 Lester Wu
--and 	hid_cocde = @cocde
--Lester Wu 2005-03-17 user replace ALL with UC-G 
--and (@cocde='ALL' or hih_cocde=@cocde)
and ((@cocde='UC-G' and hih_cocde <>'MS') or hih_cocde=@cocde)






GO
GRANT EXECUTE ON [dbo].[sp_select_MSR00014] TO [ERPUSER] AS [dbo]
GO
