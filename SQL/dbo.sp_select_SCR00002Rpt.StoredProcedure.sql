/****** Object:  StoredProcedure [dbo].[sp_select_SCR00002Rpt]    Script Date: 09/29/2017 15:29:09 ******/
DROP PROCEDURE [dbo].[sp_select_SCR00002Rpt]
GO
/****** Object:  StoredProcedure [dbo].[sp_select_SCR00002Rpt]    Script Date: 09/29/2017 15:29:10 ******/
SET ANSI_NULLS OFF
GO
SET QUOTED_IDENTIFIER OFF
GO







-- Checked by Allan Yuen at 27/07/2003


/************************************************************************
Author:		Kenny Chan
Date:		17th March, 2002
Description:	SCR00002 Report

************************************************************************/
CREATE PROCEDURE [dbo].[sp_select_SCR00002Rpt] 

@cocde 		nvarchar(6),
@CustFrom	nvarchar(6),
@CustTo		nvarchar(6),
@DateFrom	Datetime,
@DateTo		Datetime,
@usrid	nvarchar(30),
@doctyp	nvarchar(2)

AS
SET @DateTo = @DateTo + ' 23:59:59.988'

/*Frankie Cheung 20091007
Declare @CurrencyRate numeric(11,4)
Select @CurrencyRate= ysi_selrat from SYSETINF where ysi_typ = '06' and ysi_cde = 'HKD' and ysi_cocde = @cocde
*/

Select 	@cocde ,		@custFrom, 	@CustTo, 	@DateFrom,	@DateTo,
	a.cbi_cusno , 	a.cbi_cusnam , 	
	Case a.sod_selprc When 0 then 0 else a.sod_selprc/1000 End , 
	Case isnull(b.sod_selprc,0) When 0 then 0 else b.sod_selprc/1000 end  as 'FD',   
	Case isnull(c.sod_selprc,0) When 0 then 0 else c.sod_selprc/1000 end as 'GP' ,
	Case isnull(d.sod_selprc,0) When 0 then 0 else d.sod_selprc/1000 end as 'HD' ,
	Case isnull(e.sod_selprc,0) When 0 then 0 else e.sod_selprc/1000 end as 'OT' from 
(
Select cbi_cusno , cbi_cusnam ,
--	Sum(CASE sod_curcde when 'HKD' then sod_selprc * @CurrencyRate else sod_selprc end) as 'sod_selprc'
	--Frankie Cheung 20091007
	sum(case soh_curexrat when 0 then 0 else isnull(sod_selprc / soh_curexrat,0) end) as 'sod_selprc'
	From SCORDHDR,CUBASINF
	,SCORDDTL
	left join IMBASINF on 
				--ibi_cocde =  sod_cocde and 
				ibi_itmno = sod_itmno 
	Where	
	soh_cocde = @cocde and
	--cbi_cocde = soh_cocde and 
	cbi_cusno = soh_cus1no and
	soh_ordno = sod_ordno and
	soh_ordsts <> 'CAN' and
	sod_cocde = soh_cocde and
	soh_credat Between @DateFrom and @DateTo and 
	cbi_cusno between @CustFrom and @CustTo
	
Group by cbi_cusno , cbi_cusnam
) a 
--Cat FD
left Join
(
Select cbi_cusno , cbi_cusnam ,
--	Sum(CASE sod_curcde when 'HKD' then sod_selprc * @CurrencyRate else sod_selprc end) as 'sod_selprc'
	--Frankie Cheung 20091007
	sum(case soh_curexrat when 0 then 0 else isnull(sod_selprc / soh_curexrat,0) end) as 'sod_selprc'
	From SCORDHDR,CUBASINF
	,SCORDDTL
	left join IMBASINF on 
				--ibi_cocde =  sod_cocde and 
				ibi_itmno = sod_itmno 
	Where	
	soh_cocde = @cocde and
	--cbi_cocde = soh_cocde and 
	cbi_cusno = soh_cus1no and
	soh_ordno = sod_ordno and
	sod_cocde = soh_cocde and
	soh_ordsts <> 'CAN' and
	ibi_catlvl0 ='FD' and
	soh_credat Between @DateFrom and @DateTo and 
	cbi_cusno between @CustFrom and @CustTo
Group by cbi_cusno , cbi_cusnam
) b
on a.cbi_cusno = b.cbi_cusno 
--Cat GP
left Join
(
Select cbi_cusno , cbi_cusnam ,
--	Sum(CASE sod_curcde when 'HKD' then sod_selprc *@CurrencyRate else sod_selprc end) as 'sod_selprc'
	--Frankie Cheung 20091007
	sum(case soh_curexrat when 0 then 0 else isnull(sod_selprc / soh_curexrat,0) end) as 'sod_selprc'
	From SCORDHDR,CUBASINF
	,SCORDDTL
	left join IMBASINF on 
			--ibi_cocde =  sod_cocde and 
			ibi_itmno = sod_itmno 
	Where	
	soh_cocde = @cocde and
	--cbi_cocde = soh_cocde and 
	cbi_cusno = soh_cus1no and
	soh_ordno = sod_ordno and
	soh_ordsts <> 'CAN' and
	sod_cocde = soh_cocde and
	ibi_catlvl0 ='GP' and
	soh_credat Between @DateFrom and @DateTo and 
	cbi_cusno between @CustFrom and @CustTo
Group by cbi_cusno , cbi_cusnam
) c
on (c.cbi_cusno = a.cbi_cusno)
--CAT HD
left Join
(
Select cbi_cusno , cbi_cusnam ,
--	Sum(CASE sod_curcde when 'HKD' then sod_selprc * @CurrencyRate else sod_selprc end) as 'sod_selprc'
	--Frankie Cheung 20091007
	sum(case soh_curexrat when 0 then 0 else isnull(sod_selprc / soh_curexrat,0) end) as 'sod_selprc'
	From SCORDHDR,CUBASINF
	,SCORDDTL
	left join IMBASINF on 
				--ibi_cocde =  sod_cocde and 
				ibi_itmno = sod_itmno 
	Where	
	soh_cocde = @cocde and
	--cbi_cocde = soh_cocde and 
	cbi_cusno = soh_cus1no and
	soh_ordno = sod_ordno and
	soh_ordsts <> 'CAN' and
	sod_cocde = soh_cocde and
	ibi_catlvl0 ='HD' and
	soh_credat Between @DateFrom and @DateTo and 
	cbi_cusno between @CustFrom and @CustTo
Group by cbi_cusno , cbi_cusnam
) d
on (d.cbi_cusno = a.cbi_cusno)
--CAT OT
left Join
(
Select cbi_cusno , cbi_cusnam ,
--	Sum(CASE sod_curcde when 'HKD' then sod_selprc * @CurrencyRate else sod_selprc end) as 'sod_selprc'
	--Frankie Cheung 20091007
	sum(case soh_curexrat when 0 then 0 else isnull(sod_selprc / soh_curexrat,0) end) as 'sod_selprc'
	From SCORDHDR,CUBASINF
	,SCORDDTL
	left join IMBASINF on 
				--ibi_cocde =  sod_cocde and 
				ibi_itmno = sod_itmno 
	Where	
	soh_cocde = 'UCPP' and
	--cbi_cocde = soh_cocde and 
	cbi_cusno = soh_cus1no and
	soh_ordno = sod_ordno and
	soh_ordsts <> 'CAN' and
	sod_cocde = soh_cocde and
	(ibi_catlvl0 ='OT' or ibi_catlvl0 ='' or ibi_catlvl0 is Null) and
	soh_credat Between @DateFrom and @DateTo and 
	cbi_cusno between @CustFrom and @CustTo
Group by cbi_cusno , cbi_cusnam
) e
on (e.cbi_cusno = a.cbi_cusno)

order by a.cbi_cusno








GO
GRANT EXECUTE ON [dbo].[sp_select_SCR00002Rpt] TO [ERPUSER] AS [dbo]
GO
