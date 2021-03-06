/****** Object:  StoredProcedure [dbo].[SP_Select_MSR00008]    Script Date: 09/29/2017 15:29:09 ******/
DROP PROCEDURE [dbo].[SP_Select_MSR00008]
GO
/****** Object:  StoredProcedure [dbo].[SP_Select_MSR00008]    Script Date: 09/29/2017 15:29:10 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO











/****** Object:  Stored Procedure dbo.SP_Select_MSR00008    Script Date: 04/14/2003 15:20:42 ******/
/************************************************************************
Author:		Solo So
************************************************************************/
/*
=========================================================
Program ID	: 	SP_Select_MSR00008
Description   	: 	Monthly Statment for Sample Charges
Programmer  	: 
ALTER  Date   	: 
Last Modified  	: 	
Table Read(s) 	:
Table Write(s) 	:
=========================================================
 Modification History                                    
=========================================================
14 Apr 2003	Lewis To		Un-remark the Distinct option in select statement
03 Feb 2004	Lester Wu		Change Logic (return Factory Name for UCP with Vendor Code Not Equals '0005')
16 Feb 2004	Lester Wu		ADD "ALL" COMPANY SELECTION
2nd Apr 2005	Lester Wu		replace ALL with UC-G, exclude MS company from UC-G, retrieve company name from database
=========================================================     
*/
CREATE   PROCEDURE [dbo].[SP_Select_MSR00008] 
--Declare
@cocde	nvarchar(6),
--@Co		nvarchar(6),
@VnFm	nvarchar(6),
@VnTo		nvarchar(6),
@CuFm	nvarchar(6),
@CuTo		nvarchar(6),
@Invno_from	nvarchar(20),
@Invno_to	nvarchar(20),
@Month	nvarchar(20),
@Year		nvarchar(4)

AS
--Set @cocde = 'UCP'
/*
Set @Invno_from = ''
Set @Invno_to = ''
Set @Month = '6 - June'
Set @Year = '2002'
*/

Declare @Month_temp nvarchar(2)
Declare 
@opt1	nvarchar(1),
@opt2	nvarchar(1),
@opt3	nvarchar(1)

SET @Month_temp	 =  left(@Month,Charindex(' - ',@Month)-1)
SET @Month  = Right(@Month, Len(@Month) - Charindex(' - ',@Month) - 2)

Set @opt1 = 'N'
If @Invno_from <> '' or @Invno_to <> ''
begin
	Set @opt1 = 'Y'
end

Set @opt2 = 'N'
If @VnFm <> '' or @VnTo <> ''
begin
	Set @opt2 = 'Y'
end

Set @opt3 = 'N'
If @CuFm <> '' or @CuTo <> ''
begin
	Set @opt3 = 'Y'
end

Declare @Currency numeric(11,4)
Select @Currency= ysi_selrat from SYSETINF where ysi_typ = '06' and ysi_cde = 'HKD' and ysi_cocde = @cocde


--Lester Wu 2005-04-02, retrieve company name from database----------------------------------------
declare @compName varchar(100)
set @compName = 'UNITED CHINESE GROUP'
if @cocde<>'UC-G'
begin
	select @compName = yco_conam from sycominf where yco_cocde = @cocde
end
---------------------------------------------------------------------------------------------------------------------



Select 	Distinct
	@Year as '@Year',
	@Month as '@Month',
	Case @Invno_From when '' then 'ALL' else @Invno_From End as '@Invno_From',
	Case @Invno_To when '' then 'ALL' else @Invno_To End as '@Invno_To',
	sih_cus1no as 'sih_cusno',
	sih_cus1no + ' - ' + isnull(cbi_cussna, '') as 'Cust_Short',
	'(Sample Term : ' + isnull(yst_trmdsc, '')+ ')' as 'sih_smpprd',
	sih_invno as 'sih_invno',	sid_itmno  as 'sih_itmno', 	ivi_venitm  as 'ivi_venitm',	ibi_engdsc as 'ibi_engdsc',
	sid_pckunt as 'sid_pckunt',	sid_inrqty as 'sid_inrqty',	sid_mtrqty as 'sid_mtrqry',	sid_colcde as 'sid_colcde',
	sid_smpunt as 'sid_smpunt',	sid_shpqty as 'sid_shpqty',	
--	'USD',
--	Case sid_fcurcde When 'HKD' then sid_ftyprc *@Currency else sid_ftyprc End,
--	Round(Case sid_fcurcde When 'HKD' then sid_shpqty * sid_ftyprc * @Currency else sid_shpqty *sid_ftyprc End ,2) as 'sid_ttlamt',
	sid_fcurcde as 'sid_curcde',
	sid_ftyprc as 'sid_selprc',
	Round(sid_shpqty *sid_ftyprc,2) as 'sid_ttlamt',
--	@Co,
	@cocde as '@Co',
--Lester Wu (03 Feb 2004) Change Logic -----------
--	Case @Co when 'UCPP' then sid_venno + ' - ' + vbi_vensna else sid_venno end,
--	Case  when @Co = 'UCP' and sid_venno='0005' then sid_venno else  sid_venno + ' - ' + vbi_vensna end,
	Case  when sih_cocde = 'UCP' and sid_venno='0005' then sid_venno else  sid_venno + ' - ' + vbi_vensna end as 'sid_venno',
--------------Change Logic End-----------------------------
	--Kenny Add on 26-11-2002
-- Lester Wu (03 Feb 2004) Change Logic ------------
--	Case @Co when 'UCP'  then 'UNITED CHINESE PLASTICS PRODUCTS CO., LTD.' else vbi_vennam end
--	Case  when @Co = 'UCP' and sid_venno='0005' then 'UNITED CHINESE PLASTICS PRODUCTS CO., LTD.' else vbi_vennam end
	Case  when sih_cocde = 'UCP' and sid_venno='0005' then 'UNITED CHINESE PLASTICS PRODUCTS CO., LTD.' else vbi_vennam end as 'vbi_vennam',
-------------Change Logic End-----------------------------
	case isnull(vbi_bvennam,'') when 'NO' then '' else isnull(vbi_bvennam,'') end as 'vbi_bvennam'
	,@compName as 'compName'

From	SAINVHDR
--	left join CUBASINF on cbi_cocde = sih_cocde and cbi_cusno = sih_cus1no
--	left join SYSMPTRM on yst_cocde = sih_cocde and yst_trmcde  = sih_smpprd
	left join CUBASINF on cbi_cusno = sih_cus1no
	left join SYSMPTRM on yst_trmcde  = sih_smpprd
	,IMBASINF,SAINVDTL
--	Left join IMVENINF on ivi_cocde = sid_cocde and ivi_itmno = sid_itmno
--	Left join VNBASINF on vbi_cocde = sid_cocde and vbi_venno = sid_venno
	Left join IMVENINF on ivi_itmno = sid_itmno
	Left join VNBASINF on vbi_venno = sid_venno
Where 	
	--2004/02/16 Lester Wu
	--sih_cocde = @Co

--Lester Wu 2005-04-02, replace ALL with UC-G
--	(@cocde='ALL' or sih_cocde=@cocde)
	((@cocde='UC-G' and sih_cocde<>'MS') or sih_cocde=@cocde)
	-------------------------------------------------
and	sid_cocde = sih_cocde 
and 	sid_invno = sih_invno
--and 	ibi_cocde = sih_cocde 
and ibi_itmno = sid_itmno
and	((@opt1 = 'Y' and sih_invno between @Invno_from and @Invno_to) or @opt1 = 'N' )
and	((@opt2 = 'Y' and  sid_venno between @VnFm and @VnTo) or @opt2 = 'N' )
and	((@opt3 = 'Y' and  sih_cus1no between @CuFm and @CuTo) or @opt3 = 'N' )
and	year(sih_credat) =@Year and month(sih_credat) = @Month_temp
order by	sih_cus1no ,sih_invno, ivi_venitm , sid_colcde , sid_pckunt












GO
GRANT EXECUTE ON [dbo].[SP_Select_MSR00008] TO [ERPUSER] AS [dbo]
GO
