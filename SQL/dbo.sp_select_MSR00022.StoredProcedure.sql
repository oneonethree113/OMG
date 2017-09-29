/****** Object:  StoredProcedure [dbo].[sp_select_MSR00022]    Script Date: 09/29/2017 15:29:09 ******/
DROP PROCEDURE [dbo].[sp_select_MSR00022]
GO
/****** Object:  StoredProcedure [dbo].[sp_select_MSR00022]    Script Date: 09/29/2017 15:29:10 ******/
SET ANSI_NULLS OFF
GO
SET QUOTED_IDENTIFIER OFF
GO




/***********************************************************************************************************************************************
Modification History
************************************************************************************************************************************************
Modified by		Modified on		Description
************************************************************************************************************************************************
Lester Wu			2005-04-02		replace ALL with UC-G, exclude MS from UC-G, retrieve company name from database
************************************************************************************************************************************************/




-- Checked by Allan Yuen at 27/07/2003


CREATE  PROCEDURE [dbo].[sp_select_MSR00022]

@cocde		nvarchar(6),
@venFm		nvarchar(6),
@venTo		nvarchar(6),
@bomPOFm	nvarchar(20),
@bomPOTo	nvarchar(20),
@dateFm		nvarchar(10),
@dateTo		nvarchar(10),
@sort		nvarchar(1),
@creusr		nvarchar(30)

AS

--Lester Wu 2005-04-02, retrieve company name from database----------------------------------------
declare @compName varchar(100)
set @compName = 'UNITED CHINESE GROUP'
if @cocde<>'UC-G'
begin
	select @compName = yco_conam from sycominf where yco_cocde = @cocde
end
---------------------------------------------------------------------------------------------------------------------



select 	pbh_bompo,
	pbh_bvenno + ' - ' + a.vbi_vensna as 'vendor',
	pbh_purord, 
	pbh_oriven + ' - ' + b.vbi_vensna as 'Ovendor',
	poh_prmcus + ' - ' + cbi_cussna as 'customer',
	pbh_issdat,
 	pbh_shpstr, 	pbh_shpend,	
	pbh_curcde,	pbh_disamt,
	@cocde,		@venFm,
	@venTo,		@bomPOFm,
	@bomPOTo,	@dateFm,
	@dateTo,		@sort,
	@creusr
	,@compName as 'compName',
	poh_shpstr,
	poh_shpend

from POBOMHDR
/*
--left join POBOMDTL on
--pbh_cocde = pbd_cocde and pbh_bompo = pbd_bompo
*/

left join VNBASINF a on
--pbh_cocde = a.vbi_cocde and pbh_bvenno = a.vbi_venno
pbh_bvenno = a.vbi_venno

left join VNBASINF b on
--pbh_cocde = b.vbi_cocde and pbh_oriven = b.vbi_venno
pbh_oriven = b.vbi_venno

left join POORDHDR on
--pbh_cocde = poh_cocde and pbh_purord = poh_purord
pbh_purord = poh_purord

left join CUBASINF on
--pbh_cocde = cbi_cocde and poh_prmcus = cbi_cusno
poh_prmcus = cbi_cusno

where 
-- 2004/02/11 Lester Wu
--pbh_cocde = @cocde and
--Lester Wu 2005-04-02, replace ALL with UC-G
--(@cocde='ALL' or pbh_cocde = @cocde) and
((@cocde='UC-G' and pbh_cocde<>'MS') or pbh_cocde = @cocde) and
--------------------------------
pbh_bvenno between
	(case ltrim(@venFm) when '' then '' else @venFm end)	
		and
	(case ltrim(@venTo) when '' then 'ZZZZZZ' else @venTo end)
and
pbh_bompo between
	(case ltrim(@bomPOFm) when '' then '' else @bomPOFm end)	
		and
	(case ltrim(@bomPOTo) when '' then 'ZZZZZZZZZZZZZZZZZZZZ' else @bomPOTo end)
and
pbh_issdat between
	(case ltrim(@dateFm) when '' then '1900-01-01' else @dateFm + ' 0:00' end)	
		and
	(case ltrim(@dateTo) when '' then getdate() else @dateTo + ' 23:59:59' end)

order by (case @sort when 'V' then pbh_bvenno else pbh_purord end)










GO
GRANT EXECUTE ON [dbo].[sp_select_MSR00022] TO [ERPUSER] AS [dbo]
GO
