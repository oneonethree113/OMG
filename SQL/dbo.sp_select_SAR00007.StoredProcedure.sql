/****** Object:  StoredProcedure [dbo].[sp_select_SAR00007]    Script Date: 09/29/2017 15:29:09 ******/
DROP PROCEDURE [dbo].[sp_select_SAR00007]
GO
/****** Object:  StoredProcedure [dbo].[sp_select_SAR00007]    Script Date: 09/29/2017 15:29:10 ******/
SET ANSI_NULLS OFF
GO
SET QUOTED_IDENTIFIER OFF
GO




--3rd March 2005	Lester Wu		Retrieve Company Name, Short Name, Address, Phone , Fax, Email




CREATE PROCEDURE [dbo].[sp_select_SAR00007] 

@cocde		nvarchar(6),	
@SARfm		nvarchar(20),	@SARto		nvarchar(20)

AS
------------------------------------------------------------------------------------------------------------------------------------------------------
--Lester Wu 2005/03/03 -- Retrieve Company Name, Short Name, Address, Phone No, Fax No,  Logo Path
------------------------------------------------------------------------------------------------------------------------------------------------------
DECLARE
@yco_conam	varchar(100),
@yco_shtnam	varchar(25),
@yco_addr		varchar(200),

@yco_conamc	nvarchar(100),
@yco_shtnamc	nvarchar(25),
@yco_addrc	nvarchar(200),

@yco_phoneno	varchar(50),
@yco_faxno	varchar(50),
@yco_logoimgpth	varchar(100)

set @yco_conam = ''
set @yco_shtnam = ''
set @yco_addr = ''

set @yco_conamc = ''
set @yco_shtnamc = ''
set @yco_addrc = ''

set @yco_phoneno = ''
set @yco_faxno = ''

set @yco_logoimgpth = ''

select
@yco_conam=yco_conam,
@yco_shtnam=yco_shtnam,
@yco_addr=yco_addr,

@yco_conamc = yco_conamc,
@yco_shtnamc = yco_shtnamc,
@yco_addrc = yco_addrc,

@yco_phoneno= yco_phoneno,
@yco_faxno = yco_faxno,
@yco_logoimgpth = yco_logoimgpth
from 
SYCOMINF(NOLOCK)
where
yco_cocde = @cocde
------------------------------------------------------------------------------------------------------------------------------------------------------
------------------------------------------------------------------------------------------------------------------------------------------------------
 select
	-- SAINVHDR 
	sih_invno,		sih_cocde,		
	sih_cus1no,	sih_cus1ad,	sih_cus1st,		
	sih_cus1cy,	sih_cus1zp,	sih_cus1cp,	
	sih_rvsdat,		sih_shprmk,	sih_rmk,			
	
	-- SAINVDTL
	sid_itmno,		sid_smpunt,	sid_colcde,
	sid_shpqty,	sid_shpqtyStr = str(sid_shpqty),
	
		
	-- CUBASINF	
	cbi_cussna,	cbi_cusnam,

	-- SYSETINF
	ysi_dsc,
	--Lester Wu 2005-03-14 Return Company Name, Address, Phone No, Fax
	@yco_conam	as 'CompName',
	@yco_addr	as 'CompAddr',
	@yco_addrc 	as 'CompAddrC',
	@yco_phoneno	as 'CompPhone',
	@yco_faxno	as 'CompFAX',
	@yco_logoimgpth	as 'CompLogo'
	----------------------------------------------------------------------------------------------------------------------
from 	SAINVHDR
left join SAINVDTL on sih_cocde = sid_cocde and sih_invno = sid_invno 
left join CUBASINF on sih_cus1no = cbi_cusno
left join SYSETINF on ysi_typ = '05' and sid_smpunt = ysi_cde
where sih_cocde = @cocde 
and 	sih_invno >= @SARfm and sih_invno <= @SARto
and cbi_cusno is not null
order by sih_invno, sid_itmno



GO
GRANT EXECUTE ON [dbo].[sp_select_SAR00007] TO [ERPUSER] AS [dbo]
GO
