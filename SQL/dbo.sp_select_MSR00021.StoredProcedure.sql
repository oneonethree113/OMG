/****** Object:  StoredProcedure [dbo].[sp_select_MSR00021]    Script Date: 09/29/2017 15:29:09 ******/
DROP PROCEDURE [dbo].[sp_select_MSR00021]
GO
/****** Object:  StoredProcedure [dbo].[sp_select_MSR00021]    Script Date: 09/29/2017 15:29:10 ******/
SET ANSI_NULLS OFF
GO
SET QUOTED_IDENTIFIER OFF
GO











--select * from PODTLBOM where pdb_imcurcde='HKD'
--update PODTLBOM 



-- Checked by Allan Yuen at 27/07/2003
--Add Running no and sort by at 05/11/2003
/************************************************************************************************************************************************
-- Modification History
************************************************************************************************************************************************
--Modified on	Modified by	Description
************************************************************************************************************************************************
--May 05 , 2004	Lester Wu		Retrive pdb_imcurcde & pdb_imftyprc from PODTLBOM
--2005-04-02	Lester Wu		replace ALL with UC-G, exclude MS from UC-G, retrieve company name from database
--2005-06-20	Lester Wu		Show Production Vendor(pod_prdven) instead of Custom Vendor(poh_venno)
************************************************************************************************************************************************/

---------------------------------------------------------------------------------------------------------------------------------------------------------------
CREATE      PROCEDURE [dbo].[sp_select_MSR00021]

	@cocde 		nvarchar(6),
	@Venfrom		nvarchar(10),
	@Vento		nvarchar(10),
	@JOBfrom	nvarchar(20),
	@JOBto		nvarchar(20),
	@RUNfrom	nvarchar(20),
	@RUNto		nvarchar(20),
	@DateFrom	nvarchar(30),
	@DateTo		nvarchar(30),
	@ShipFrom	nvarchar(30),
	@ShipTo		nvarchar(30),
	@FTY		nvarchar(1),
	@SORTBY	nvarchar(1),
	@optDTL		nvarchar(1),
	@user		nvarchar(30)
AS

Declare 
	@optJob		nvarchar(1),
	@optVen		nvarchar(1),
	@optIssue		nvarchar(1),
	@optShip		nvarchar(1),
	@optRun		nvarchar(1)	


set @optVen = 'N'
	If @Venfrom = '' and @Vento = ''
	begin
		set @optVen = 'Y'
	end

set @optJob = 'N'
	If @JOBfrom = '' and @JOBto = ''
	begin
		set @optJob = 'Y'
	end

set @optIssue = 'N'
	If @DateFrom = '' and @DateTo = ''
	begin
		set @optIssue = 'Y'
	end

set @optShip = 'N'
	If @ShipFrom = '' and @ShipTo = ''
	begin
		set @optShip = 'Y'
	end
set @optRun = 'N'
	if @RUNfrom ='' and @RUNto = ''
	begin
		set @optRun = 'Y'
	end
------------------------------------------------------------
--Lester Wu 2005-04-02, retrieve company name from database----------------------------------------
declare @compName varchar(100)
set @compName = 'UNITED CHINESE GROUP'
if @cocde<>'UC-G'
begin
	select @compName = yco_conam from sycominf where yco_cocde = @cocde
end
---------------------------------------------------------------------------------------------------------------------


SELECT 
	-- Parameter
	@cocde,	
	@Venfrom,	@Vento,
	@JOBfrom,	@JOBto,
	@RUNfrom,	@RUNto,
	@DateFrom,	@DateTo,
	@ShipFrom,	@ShipTo,
	@FTY,		@SORTBY,
	@optDTL,

	

	-- POORDDTL
	pod_jobord, 	pod_purord,	pod_ftyprc,
	pod_shpstr,	pod_shpend,	pod_venitm,	
	pod_ordqty,	pod_runno,

	-- POORDHDR	
	poh_curcde,	pod_prdven, --poh_venno,  --Lester Wu 2005-06-20
	
	-- SCORDDTL
	sod_subcde,

	-- SYSETINF
	ysi_dsc,

	-- CUBASINF
	isnull(cbi_cusno,'') as 'cbi_cusno',		isnull(cbi_cussna,'') as 'cbi_cussna',
	
	-- VNBASINF
	isnull(vbi_venno,'') as 'vbi_venno',		isnull(vbi_vensna,'') as 'vbi_vensna'

	,isnull(pdb_imcurcde,'') as 'pdb_imcurcde'	,isnull(pdb_imftyprc,0) as 'pdb_imftyprc'
	,isnull(pdb_ordqty,0) as 'pdb_bomqty'

	,isnull(pdb_bomitm,'') as 'pdb_bomitm'
	,isnull(pdb_pckunt,'') as 'pdb_pckunt'
	, case @SORTBY when 'J' then pod_jobord else pod_runno end as 'strGroup'
	,@compName  as 'compName'
	
--sp_help PODTLBOM
--FROM 	POORDHDR, POORDDTL, SCORDHDR, SCORDDTL, CUBASINF, SYSETINF, VNBASINF
FROM 	POORDHDR (NOLOCK)
	--LEFT JOIN VNBASINF (NOLOCK) ON poh_venno = vbi_venno		--Lester Wu 2005-06-20, show production vendor instead of custom vendor
	, POORDDTL (NOLOCK) 
	LEFT JOIN VNBASINF (NOLOCK) ON pod_prdven = vbi_venno		--Lester Wu 2005-06-20, show production vendor instead of custom vendor
	LEFT JOIN PODTLBOM (NOLOCK) ON pod_purord = pdb_purord and pod_cocde = pdb_cocde and pod_purseq = pdb_seq
	, SCORDHDR (NOLOCK) 
	LEFT JOIN CUBASINF (NOLOCK)  ON soh_cus1no = cbi_cusno
	, SCORDDTL
	--, CUBASINF
	, SYSETINF
	--, VNBASINF

WHERE
	pod_cocde = poh_cocde and pod_purord = poh_purord 
--AND 	soh_ordsts <> 'CLO'
AND	pod_jobord <> ''
AND	pod_cocde = sod_cocde and pod_scno = sod_ordno and pod_scline = sod_ordseq
AND	poh_cocde = soh_cocde and poh_ordno = soh_ordno

--AND	soh_cus1no *= cbi_cusno and soh_cocde *= cbi_cocde 
--AND	soh_cus1no *= cbi_cusno 

--AND	poh_venno *= vbi_venno and poh_cocde *= vbi_cocde 
--AND	poh_venno *= vbi_venno 

--AND 	pod_cocde = ysi_cocde and pod_untcde = ysi_cde and ysi_typ = '05'	
AND 	pod_untcde = ysi_cde and ysi_typ = '05'	
--and 	isnull(pdb_imcurcde,'') <>''

--Lester Wu 2005-06-20, show production vendor instead of custom vendor -------------------------------
-- AND 	((@optVen = 'N' and poh_venno between @Venfrom and @Vento) or @optVen = 'Y')
AND 	((@optVen = 'N' and pod_prdven between @Venfrom and @Vento) or @optVen = 'Y')
----------------------------------------------------------------------------------------------------------------------------
AND 	((@optJob = 'N' and pod_jobord between @JOBfrom and @JOBto) or @optJob = 'Y')
AND 	((@optIssue = 'N' and poh_credat between @DateFrom and @DateTo) or @optIssue = 'Y')
AND	((@optShip = 'N' and pod_shpstr >= @ShipFrom and pod_shpend <= @ShipTo) or @optShip = 'Y')
AND	((@optRun = 'N' and pod_runno between @RUNfrom and @RUNto) or @optRun = 'Y')
-- 2004/02/11 Lester Wu
--AND	pod_cocde = @cocde
--Lester Wu 2005-04-02, replace ALL with UC-G
--AND (@cocde='ALL' or poh_cocde = @cocde)
AND ((@cocde='UC-G' and poh_cocde<>'MS') or poh_cocde = @cocde)
---------------------------------------

order by case @SORTBY when 'J' then pod_jobord else pod_runno end

















GO
GRANT EXECUTE ON [dbo].[sp_select_MSR00021] TO [ERPUSER] AS [dbo]
GO
