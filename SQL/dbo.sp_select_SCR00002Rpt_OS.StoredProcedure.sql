/****** Object:  StoredProcedure [dbo].[sp_select_SCR00002Rpt_OS]    Script Date: 09/29/2017 15:29:09 ******/
DROP PROCEDURE [dbo].[sp_select_SCR00002Rpt_OS]
GO
/****** Object:  StoredProcedure [dbo].[sp_select_SCR00002Rpt_OS]    Script Date: 09/29/2017 15:29:10 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
/************************************************************************
Author:		Kenny Chan
Date:		17th March, 2002
Description:	SCR00002 Report

************************************************************************/
/************************************************************************
Modification History
************************************************************************
Modified On	Modified By	Description
************************************************************************
8th Oct, 2004	Lester Wu		Search Sales Team by Sales Rep. in CUBASINF instead of SCORDHDR
7th Apr, 2005	Lester Wu		Replace ALL with UC-G, exclude MS company data from UC-G, retrieve company name from database
************************************************************************/

CREATE PROCEDURE [dbo].[sp_select_SCR00002Rpt_OS] 

@cocde 		nvarchar(6),
@CustFrom	nvarchar(6),
@CustTo		nvarchar(6),
@VenFm		nvarchar(40),
@VenTo		nvarchar(40),
@SCFm		nvarchar(40),
@SCTo		nvarchar(40),
@STFm		nvarchar(6),
@STTo		nvarchar(6),
@VenTyp 		char(1),
@DateFrom 	Datetime,
@DateTo		Datetime,
@usrid	nvarchar(30),
@doctyp	nvarchar(2)

AS
set nocount on 
--Frankie Cheung 20091006
--Declare @CurrencyRate numeric(15,11)
SET @DateTo = @DateTo + ' 23:59:59.988'
--Select @CurrencyRate= ysi_selrat from SYSETINF where ysi_typ = '06' and ysi_cde = 'HKD' and ysi_cocde = @cocde
--Frankie Cheung 20091006
--Select @CurrencyRate= ysi_selrat from SYSETINF where ysi_typ = '06' and ysi_cde = 'HKD' 

Declare 
@sVenFmC	nvarchar(6),
@sVenToC	nvarchar(6),
@sSCFmC	nvarchar(6),
@sSCToC		nvarchar(6)



If @VenFm <> ''
begin
	Set @sVenFmC = left(@VenFm, charindex('-', @VenFm) -1)
end
If @VenTo <> ''
begin
	Set @sVenToC = left(@VenTo,  charindex('-', @VenTo) -1)
end
If @SCFM <> ''
begin
	Set @sSCFmC = left(@SCFm, charindex('-', @SCFm) -1)
End
If @SCTo <> ''
begin
	Set @sSCToC = left(@SCTo, charindex('-', @SCTo) -1)
end


--Lester Wu 2005-04-06, retrieve company name from database
declare @compName varchar(100)
set @compName = 'UNITED CHINESE GROUP'
if @cocde<>'UC-G'
begin
	select @compName = yco_conam from sycominf where yco_cocde=@cocde
end
------------------------------------------------------------------------------

---cis_cusno in 
---	(select cbi_cusno from cubasinf (nolock)   where (cbi_cusali = @cis_cusno or cbi_cusno = @cis_cusno) and cbi_cusno  <> ''
---	   UNION
---	   SELECT cbi_cusali from cubasinf (nolock) where cbi_cusno = @cis_cusno and cbi_cusali <> '')

/***********************************************************************************************/
--Lester Wu 2004/10/08  Search Sales Team by Sales Rep. in CUBASINF instead of SCORDHDR
/*
----------------------------------------------------------------------------------------
select * into #CUBASINF from 
(select cbi_cusno from cubasinf (nolock)   where cbi_cusali between @CustFrom and @CustTo and cbi_cusno  <> ''
union
select cbi_cusno from cubasinf (nolock)   where cbi_cusno between @CustFrom and @CustTo and cbi_cusno  <> ''
UNION
SELECT cbi_cusali from cubasinf (nolock) where cbi_cusno  between @CustFrom and @CustTo and cbi_cusali <> '') as table_aa
----------------------------------------------------------------------------------------
*/
select * into #CUBASINF from 
(select cbi_cusno,case isnull(cbi_cusali,'') when '' then cbi_cusno else cbi_cusali end as 'cbi_cusali'
 from cubasinf (nolock)   where cbi_cusali between @CustFrom and @CustTo and cbi_cusno  <> ''
union
select cbi_cusno,case isnull(cbi_cusali,'') when '' then cbi_cusno else cbi_cusali end as 'cbi_cusali'
from cubasinf (nolock)   where cbi_cusno between @CustFrom and @CustTo and cbi_cusno  <> ''
UNION
SELECT cbi_cusali,cbi_cusali
from cubasinf (nolock) where cbi_cusno  between @CustFrom and @CustTo and cbi_cusali <> '') as table_aa

IF @STFm <> '' 
BEGIN
DELETE FROM #CUBASINF WHERE
cbi_cusno IN (
SELECT pri.cbi_cusno
FROM #CUBASINF  pri
LEFT JOIN CUBASINF ali (NOLOCK) ON pri.cbi_cusali = ali.cbi_cusno
LEFT JOIN SYSALREP(NOLOCK) ON ali.cbi_salrep = ysr_code1
WHERE ysr_saltem NOT BETWEEN @STFm AND @STTo
)
END 
/***********************************************************************************************/

select distinct vbi_ventyp into #vnbasinf  from vnbasinf (nolock) 
delete from #VNBASINF 

if @VenTyp = 'I'
	begin
		insert into #vnbasinf   select distinct vbi_ventyp from vnbasinf (nolock) where vbi_ventyp in ('I','J')
	end
else
	if @VenTyp = 'E'	
		begin
			insert into #vnbasinf   select distinct vbi_ventyp from vnbasinf (nolock) where vbi_ventyp = 'E'
		end
                  else
		begin 
			insert into #vnbasinf   select distinct vbi_ventyp from vnbasinf (nolock) 
		end
--------------------------------------------------------------------------------------------------------------------------------------------------
	Select 
		soh_cocde,
		cbi_cusno = 
	      	CASE cbi_cusali 
		         	WHEN '' then cbi_cusno
	         		else cbi_cusali 
	      	END,
		ibi_catlvl2,
--		Sum((sod_ordqty - sod_shpqty) * (CASE sod_curcde when 'HKD' then sod_untprc * @CurrencyRate else sod_untprc end)) as 'sod_selprc'
		--Frankie Chueng 20091006
		Sum((sod_ordqty - sod_shpqty) * (CASE soh_curexrat when 0 then 0 else (sod_untprc / soh_curexrat) end)) as 'sod_selprc'
	into
		#TmpResult
	From 
		SCORDHDR (nolock),
		--Lester Wu 2004/10/08  Search Sales Team by Sales Rep. in CUBASINF instead of SCORDHDR
		--left join sysalrep (nolock) on soh_salrep = ysr_code1,
		CUBASINF (nolock),
		IMBASINF (nolock) ,
		SCORDDTL (nolock)
		left join vnbasinf (nolock) on sod_venno = vbi_venno
	Where	
--		soh_cocde = @cocde and
		cbi_cusno = soh_cus1no and
		soh_ordno = sod_ordno and
		sod_cocde = soh_cocde and
		ibi_itmno = sod_itmno and
		vbi_ventyp in (
			select vbi_ventyp  from #VNBASINF 
		) and
		cbi_cusno in (
			SELECT cbi_cusno  FROM #CUBASINF 
		) and
		soh_ordsts <> 'CAN' and
		soh_issdat Between @DateFrom and @DateTo and 
		--Lester Wu 2004/10/08  Search Sales Team by Sales Rep. in CUBASINF instead of SCORDHDR
		--((@STFm <> '' and  ysr_saltem Between @STFm and @STTo) or @STFm = '') and
		((@VenFm <> '' and sod_venno Between @sVenFmC and @sVenToC) or @VenFm = '') and
		((@SCFm <> '' and  sod_subcde Between @sSCFmC and @sSCToC) or @SCFm = '') 
	Group by 
		soh_cocde,
		CASE cbi_cusali 
		         	WHEN '' then cbi_cusno
	         		else cbi_cusali 
	      	END,
		ibi_catlvl2

--Lester Wu 2005-04-06, replace ALL with UC-G and exclude MS company data from UC-G
--if @cocde <> 'ALL' 
if @cocde <> 'UC-G' 
begin
	delete from #TmpResult where soh_cocde <> @cocde
end
else
begin
	delete from #TmpResult where soh_cocde ='MS'
end
-------------------------------------------------------------------------------------------------------------------------------------------

			Select 	
				@cocde   As 'cocde',		
				@custFrom  As 'CustFrom', 	@CustTo  As 'CustTo', 
				@VenFm  As 'VenFm',		@VenTo  As 'VenTo',
				@SCFm  As 'SCFm',		@SCTo  As 'SCTo',
				@STFm  As 'STFm',		@STTo  As 'sTTo',
				@Ventyp  As 'Ventyp',
				CONVERT(VARCHAR(10),@DateFrom ,101) as 'DateFrom',	CONVERT(VARCHAR(10),@DateTo ,101) as 'DateTo',
				cc.cbi_cusno  As 'cbi_cusno', 	
				cc.cbi_cussna  As 'cbi_cussna',
				--a.cbi_cussna , 	
				Case a.sod_selprc When 0 then 0 else a.sod_selprc end  as 'Sod_total', 
				Case isnull(b.sod_selprc,0) When 0 then 0 else b.sod_selprc  end as 'Sod_FDXM1',   	--1
				Case isnull(c.sod_selprc,0) When 0 then 0 else c.sod_selprc end as 'Sod_FDXM2' ,	--2
				Case isnull(d.sod_selprc,0) When 0 then 0 else d.sod_selprc end as 'Sod_FDGP',	--3
				Case isnull(e.sod_selprc,0) When 0 then 0 else e.sod_selprc end as 'Sod_HDAB1',	--4
				Case isnull(f.sod_selprc,0) When 0 then 0 else f.sod_selprc end as 'Sod_HDAB2',	--5
				Case isnull(g.sod_selprc,0) When 0 then 0 else g.sod_selprc end as 'Sod_HDAB3',	--6
				Case isnull(h.sod_selprc,0) When 0 then 0 else h.sod_selprc end as 'Sod_HDSC1',	--7
				Case isnull(i.sod_selprc,0) When 0 then 0 else i.sod_selprc end as 'Sod_HDIF1',	--8
				Case isnull(j.sod_selprc,0) When 0 then 0 else j.sod_selprc end as 'Sod_OTOT'	--9
				,@compName as 'compName'
			
			from 
			(
				Select 
					cbi_cusno,
					Sum(sod_selprc) as 'sod_selprc'
				from
					#TmpResult
				Group by 
					cbi_cusno 
			) a 
			--Cat FD/XM1
			left Join
			(
				Select 
					cbi_cusno,
					Sum(sod_selprc) as 'sod_selprc'
				from
					#TmpResult
				where
					ibi_catlvl2 ='FD/XM1' 
				Group by 
					cbi_cusno 
			) b
			on a.cbi_cusno = b.cbi_cusno 
			--Cat FD/XM2
			left Join
			(
				Select 
					cbi_cusno,
					Sum(sod_selprc) as 'sod_selprc'
				from
					#TmpResult
				where
					ibi_catlvl2 ='FD/XM2' 
				Group by 
					cbi_cusno 
			) c
			on (c.cbi_cusno = a.cbi_cusno)
			--CAT FD AND GP
			left Join
			(
				Select 
					cbi_cusno,
					Sum(sod_selprc) as 'sod_selprc'
				from
					#TmpResult
				where
					--ibi_catlvl2 in ('FD/XM3','FD/XM4','FD/XM5', 'FD/XM6')
					--ibi_catlvl2 in ('HD/AB3', 'HD/AB4') 
					ibi_catlvl2 in ('FD/XM3', 'FD/XM4')
				Group by 
					cbi_cusno 
			) d
			on (d.cbi_cusno = a.cbi_cusno)
			--CAT HD/AB1
			left Join
			(
				Select 
					cbi_cusno,
					Sum(sod_selprc) as 'sod_selprc'
				from
					#TmpResult
				where
					--ibi_catlvl2  IN ('HD/AB1' , 'HD/AB2') 
					ibi_catlvl2 in ('HD/AB1')
				Group by 
					cbi_cusno 
			) e
			on (e.cbi_cusno = a.cbi_cusno)
			--CAT HD/AB2
			left Join
			(
				Select 
					cbi_cusno,
					Sum(sod_selprc) as 'sod_selprc'
				from
					#TmpResult
				where
					--ibi_catlvl2 IN ('HD/AB3', 'HD/AB4') 
					ibi_catlvl2 in ('HD/AB2') 
				Group by 
					cbi_cusno 
			) f
			on (f.cbi_cusno = a.cbi_cusno)
			--CAT HD/AB3
			left Join
			(
				Select 
					cbi_cusno,
					Sum(sod_selprc) as 'sod_selprc'
				from
					#TmpResult
				where
					--ibi_catlvl2 IN ('HD/AB5', 'HD/AB6' , 'HD/AB7') 
					ibi_catlvl2 in ('HD/AB3', 'HD/AB4')
				Group by 
					cbi_cusno 
			) g
			on (g.cbi_cusno = a.cbi_cusno)
			--CAT HD/SC1
			left Join
			(
				Select 
					cbi_cusno,
					Sum(sod_selprc) as 'sod_selprc'
				from
					#TmpResult
				where
					--ibi_catlvl2 IN ('HD/SC1' , 'HD/SC2' )
					--ibi_catlvl2 in ('HD/AB5') 
					ibi_catlvl2 in ('HD/SC1')
				Group by 
					cbi_cusno 
			) h
			on (h.cbi_cusno = a.cbi_cusno)
			--CAT HD/IF1
			left Join
			(
				Select 
					cbi_cusno,
					Sum(sod_selprc) as 'sod_selprc'
				from
					#TmpResult
				where
					--ibi_catlvl2 ='HD/AB8' 
					--ibi_catlvl2 in ('HD/SC1')
					ibi_catlvl2 in ('HD/AB5') 
				Group by 
					cbi_cusno 
			) i
			on (i.cbi_cusno = a.cbi_cusno)
			--CAT OTHER
			left Join
			(
				Select 
					cbi_cusno,
					Sum(sod_selprc) as 'sod_selprc'
				from
					#TmpResult
				where
					--(ibi_catlvl2  in ('HD/CA1','HD/CA2', 'HD/IA1', 'HD/IF1', 'HD/IF2', 'FD/ET1', 'FD/HW1', 'FD/VT1', 'OT/OT0', 'GP/GP0') or
					--(ibi_catlvl2 in ('FD/ET1', 'FD/HW1', 'FD/VT1', 'OT/OT1') or
					--(ibi_catlvl2 = '' or ibi_catlvl2 is Null )) 
					ibi_catlvl2 not in ('HD/AB1','HD/AB2','HD/AB3','HD/AB4','HD/AB5','HD/SC1','FD/XM1','FD/XM2','FD/XM3','FD/XM4')
				Group by 
					cbi_cusno 
			) j
			on (j.cbi_cusno = a.cbi_cusno)
			left join (select cbi_cusno, cbi_cussna from cubasinf (nolock)) cc
			on (a.cbi_cusno = cc.cbi_cusno)
			where
			 	a.sod_selprc <> 0
			order by cc.cbi_cussna
-------------------------------------------------------------------------------------------------------------------------------------------------------------------------



GO
GRANT EXECUTE ON [dbo].[sp_select_SCR00002Rpt_OS] TO [ERPUSER] AS [dbo]
GO
