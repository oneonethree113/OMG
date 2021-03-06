/****** Object:  StoredProcedure [dbo].[sp_Spring_COLOR_FULL]    Script Date: 09/29/2017 15:29:08 ******/
DROP PROCEDURE [dbo].[sp_Spring_COLOR_FULL]
GO
/****** Object:  StoredProcedure [dbo].[sp_Spring_COLOR_FULL]    Script Date: 09/29/2017 15:29:10 ******/
SET ANSI_NULLS OFF
GO
SET QUOTED_IDENTIFIER OFF
GO








/*
=========================================================
Description   	: Spring_Color_Full
Programmer  	: PIC
Create Date   	: 2002-07-30
Last Modified  	: 2003-02-07
Table Read(s) 	:
Table Write(s) 	:
=========================================================
 Modification History                                    
=========================================================
 Date      		Initial  		Description                          
=========================================================     
2003-02-07 	VICTOR LEUNG	To find the year for searching data
2003-07-22 	Lewis To		Merge to one file 
2004-02-08 	Allan Yuen		Change select icf_colcde
2006-03-21	Lester Wu		Retrieve data of old items
	
*/

CREATE procedure [dbo].[sp_Spring_COLOR_FULL]

as


DECLARE @TEMPDATE NVARCHAR(30)
DECLARE @START DATETIME
DECLARE @END DATETIME
DECLARE @START1 DATETIME
DECLARE @END1 DATETIME
DECLARE @Year VARCHAR(4)

-- Added by Victor Leung 20030207 -------------------
-- To find the year for searching data --------------

--if substring(convert(varchar(10), getdate(), 111),6,5) between '01/01' and '02/14'
	--SET @Year = LTRIM(STR(YEAR(getdate())-1))
--else
	SET @Year = LTRIM(STR(YEAR(getdate())))

SET @TEMPDATE = @Year + '-01-01'+ ' 00:00:00.000'
-- REM by Mark Lau 20080331
--SET @TEMPDATE = @Year + '-02-15'+ ' 00:00:00.000'
SET @START = @TEMPDATE

SET @TEMPDATE = @Year + '-05-31' + ' 23:59:59.998'
SET @END = @TEMPDATE

-- REM by Mark Lau 20080331
/*
SET @TEMPDATE = @Year + '-08-15'+ ' 00:00:00.000'
SET @START1 = @TEMPDATE

SET @TEMPDATE = @Year + '-12-31' + ' 23:59:59.998'
SET @END1 = @TEMPDATE
*/

-- Elvis
-- 2003/02/07
-- Update Start Date for date range consistancy
-- SET @TEMPDATE = LTRIM(STR(YEAR(getdate())-1)) + '-10-16'+ ' 00:00:00.000'

---------------------------------------------------
--print convert(varchar(10),@start, 121) + ' - ' + convert(varchar(10),@end, 121)	-- for show date range
/*************************************************************************************************************************************
Lester Wu 2006-03-21
Select -- isnull( icf_cocde,'') 
--	ibi_credat, ' 'as 'icf_cocde' , isnull( icf_itmno,'') as 'icf_itmno' , isnull( icf_vencol,'') as 'icf_colcde' ,isnull( icf_colseq,'') as 'icf_colseq'
	ibi_credat, ' 'as 'icf_cocde' , isnull( icf_itmno,'') as 'icf_itmno' , isnull( icf_colcde,'') as 'icf_colcde' ,isnull( icf_colseq,'') as 'icf_colseq'
from imbasinf (NOLOCK)
left join IMCOLINF (NOLOCK) on --ibi_cocde = icf_cocde and 
ibi_itmno = icf_itmno 
where -- icf_cocde = 'UCP' and 
(ibi_credat between @START  and @END) and ibi_itmsts <> 'CLO' and (ibi_venno not in (  '0005','0006','0007','0008','0009')) and icf_itmno is not null
order by ibi_credat desc, icf_itmno,icf_vencol

*************************************************************************************************************************************/

Select 
	ibi_credat, ' 'as 'icf_cocde' , 
	isnull( icf_itmno,'') as 'icf_itmno' , 
	isnull( icf_colcde,'') as 'icf_colcde' ,
	isnull( icf_colseq,'') as 'icf_colseq'
from 
	imbasinf (NOLOCK)
	left join IMCOLINF (NOLOCK) on ibi_itmno = icf_itmno 
where 
	((ibi_credat between @START  and @END)
	or 
	(ibi_credat between @START1  and @END1))
	 and ibi_itmsts <> 'CLO' and (ibi_venno not in (  '0005','0006','0007','0008','0009')) and icf_itmno is not null
UNION

Select 
	ibi_credat, ' 'as 'icf_cocde' , 
	isnull( icf_itmno,'') as 'icf_itmno' , 
	isnull( icf_colcde,'') as 'icf_colcde' ,
	isnull( icf_colseq,'') as 'icf_colseq'
from 
	IMPDAINF (NOLOCK)
	left join imbasinf (NOLOCK) on pda_itmno = ibi_itmno
	left join IMCOLINF (NOLOCK) on ibi_itmno = icf_itmno 
where 
	icf_itmno is not null and 
	ibi_itmsts <> 'CLO' and 
	(ibi_venno not in (  '0005','0006','0007','0008','0009')) 
and (ibi_itmno not like '00A%' and ibi_itmno not like '00B%' and ibi_itmno not like '00U%' and ibi_itmno not like '01A%' and ibi_itmno not like '01B%' and ibi_itmno not like '01U%' and ibi_itmno not like '02A%' and ibi_itmno not like '02B%' and ibi_itmno not like '02U%' and ibi_itmno not like '03A%' and ibi_itmno not like '03B%' and ibi_itmno not like '03U%'and ibi_itmno not like '04A%' and ibi_itmno not like '04B%' and ibi_itmno not like '04U%')

--	and (pda_credat between @START  and @END)

--order by 
--	ibi_credat desc, icf_itmno,icf_vencol

--order by 	1 desc,2,3
order by 
	icf_cocde desc, icf_itmno,icf_colcde



GO
GRANT EXECUTE ON [dbo].[sp_Spring_COLOR_FULL] TO [ERPUSER] AS [dbo]
GO
