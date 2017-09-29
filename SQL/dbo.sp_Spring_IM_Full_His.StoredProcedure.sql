/****** Object:  StoredProcedure [dbo].[sp_Spring_IM_Full_His]    Script Date: 09/29/2017 15:29:08 ******/
DROP PROCEDURE [dbo].[sp_Spring_IM_Full_His]
GO
/****** Object:  StoredProcedure [dbo].[sp_Spring_IM_Full_His]    Script Date: 09/29/2017 15:29:10 ******/
SET ANSI_NULLS OFF
GO
SET QUOTED_IDENTIFIER OFF
GO












/*
=========================================================
Description   	: sp_Spring_IM_Full_His
Programmer  	: PIC
ALTER  Date   	: 2002-07-30
Last Modified  	: 2003-02-07
Table Read(s) 	:
Table Write(s) 	:
=========================================================
 Modification History                                    
=========================================================
 Date      		Initial  		Description                          
=========================================================     
2003-02-07 	VICTOR LEUNG	To find the year for searching data
2003-07-23	Lewis To		Change to use single file
2006-03-21	Lester Wu		Retrieve data of old items
*/


CREATE procedure [dbo].[sp_Spring_IM_Full_His]

as

DECLARE @TEMPDATE NVARCHAR(30)
DECLARE @START DATETIME
DECLARE @END DATETIME
DECLARE @Year VARCHAR(4)

-- Added by Victor Leung 20030207 -------------------
-- To find the year for searching data --------------

--if substring(convert(varchar(10), getdate(), 111),6,5) between '01/01' and '02/14'
--	SET @Year = LTRIM(STR(YEAR(getdate())-1))
--else
	SET @Year = LTRIM(STR(YEAR(getdate())))

SET @TEMPDATE = STR(@Year) + '-01-01'+ ' 00:00:00.000'
-- REM by Mark Lau 20080331
--SET @TEMPDATE = STR(@Year) + '-08-15'+ ' 00:00:00.000'
SET @START = @TEMPDATE

SET @TEMPDATE = STR(@Year) + '-03-15' + ' 23:59:59.998'
-- REM by Mark Lau 20080331
--SET @TEMPDATE = STR(@Year) + '-12-31' + ' 23:59:59.998'
SET @END = @TEMPDATE
------------------------------------------------------
--print convert(varchar(10),@start,121) + ' - ' + convert(varchar(10),@end,121) 	--For show Date Range 

Select 
ibi_credat,
' ' as 'ibi_cocde',
ibi_itmno,
ivi_venitm,
ibi_engdsc,
ibi_venno,
case rtrim(ltrim(ibi_imgpth)) when '' then 'N' else 'Y' end as ibi_img,
Isnull(pck.ipi_pckseq,1)as  'pck.ipi_pckseq', 
isnull(pck.ipi_inrqty,0) as 'pck.ipi_inrqty', 
isnull(pck.ipi_mtrqty,0) as 'pck.ipi_mtrqty',
isnull(pck.ipi_cft,0) as 'pck.ipi_cft', 
isnull(pck.ipi_pckunt,'N/A') as 'pck.ipi_pckunt', 
ibi_tirtyp, 
isnull(yts_moq,0) as 'ibi_moqctn',
isnull(yts_moa,0) as 'ibi_moa',
isnull(imu_bcurcde,'') as'imu_bcurcde', 
isnull(imu_basprc,0) as 'imu_basprc', 
isnull(case ycf_oper when'*'  then 'PC'  when '/' then 'PC' else ipi_pckunt end,'N/A') as 'ipi_smpunt',
--added by Mark Lau 20060919
isnull(ibi_alsitmno,' ') as  'ibi_alsitmno',			
isnull(ibi_alscolcde,' ') as  'ibi_alscolcde',	
--imu_alsbasprc,
vbi_ventyp,		--Add by Lewis
ibi_catlvl3			--Add by Lewis

From IMBASINF (NOLOCK) 
left join VNBASINF (NOLOCK) on vbi_venno = ibi_venno
left join  IMPCKINF pck (NOLOCK) on --pck.ipi_cocde = ibi_cocde and 
			pck.ipi_itmno = ibi_itmno and 
			pck.ipi_pckseq = (select min(spk.ipi_pckseq) from 
						impckinf spk (NOLOCK) where --spk.ipi_cocde = ibi_cocde and 
								spk.ipi_itmno = ibi_itmno)
left join  IMMRKUP (NOLOCK) on --imu_cocde = ibi_cocde and 
			imu_ventyp = case vbi_ventyp when 'E' then 'D' else 'P' end and 
			imu_venno = ibi_venno and 
			imu_itmno = ibi_itmno and 
			pck.ipi_pckunt = imu_pckunt and
			pck.ipi_inrqty = imu_inrqty and
			pck.ipi_mtrqty = imu_mtrqty 
left join SYCONFTR (NOLOCK) on  --ycf_cocde=ibi_cocde and 
			pck.ipi_pckunt = ycf_code1 and ycf_code2 = 'PC' 
left join SYTIESTR (NOLOCK) on ibi_tirtyp = '1' 	and 
			pck.ipi_mtrqty >= yts_qtyfr and 
			pck.ipi_mtrqty <= yts_qtyto and 
			--ibi_cocde = yts_cocde and 
			ibi_venno = yts_venno and 
			yts_tirtyp = 'M' and 
			yts_itmtyp = 'R'
 and
			yts_effdat = (select top 1 yts_effdat from SYTIESTR where yts_venno = ibi_venno order by yts_effdat desc)


,IMVENINF (NOLOCK) 
where 
ibi_itmno = ivi_itmno and 
ibi_venno = ivi_venno and 
--ivi_cocde = ibi_cocde and
ibi_typ = 'reg' and 
 ibi_tirtyp = '1'  and
--ibi_cocde = 'UCP' and ibi_typ = 'reg' and 
(ibi_itmsts = 'CMP' or ibi_itmsts = 'INC') and 
ivi_venitm <> '' and 
ibi_credat between @START  and @END
and ibi_itmno
not in
(
select  ivi_itmno from imveninf(nolock)
inner join vnbasinf(nolock) on ivi_venno = vbi_venno
inner join imbasinf(nolock) on ivi_itmno = ibi_itmno
where
vbi_ventyp = 'E'
--and ibi_itmsts = 'CMP'
--and ibi_credat > '2008-06-01'
group by ivi_itmno
having count(*) > 1)
--and (ibi_itmno not like '00A%' and ibi_itmno not like '00B%' and ibi_itmno not like '00U%' and ibi_itmno not like '01A%' and ibi_itmno not like '01B%' and ibi_itmno not like '01U%' and ibi_itmno not like '02A%' and ibi_itmno not like '02B%' and ibi_itmno not like '02U%' and ibi_itmno not like '03A%' and ibi_itmno not like '03B%' and ibi_itmno not like '03U%'and ibi_itmno not like '04A%' and ibi_itmno not like '04B%' and ibi_itmno not like '04U%')
-- Added by Mark Lau 20090318
and imu_std = 'Y'


UNION

Select 
ibi_credat,
' ' as 'ibi_cocde',
ibi_itmno,
ivi_venitm,
ibi_engdsc,
ibi_venno,
case rtrim(ltrim(ibi_imgpth)) when '' then 'N' else 'Y' end as ibi_img,
Isnull(pck.ipi_pckseq,1)as  'pck.ipi_pckseq', 
isnull(pck.ipi_inrqty,0) as 'pck.ipi_inrqty', 
isnull(pck.ipi_mtrqty,0) as 'pck.ipi_mtrqty',
isnull(pck.ipi_cft,0) as 'pck.ipi_cft', 
isnull(pck.ipi_pckunt,'N/A') as 'pck.ipi_pckunt', 
ibi_tirtyp, 
ibi_moqctn,
ibi_moa,
isnull(imu_bcurcde,'') as'imu_bcurcde', 
isnull(imu_basprc,0) as 'imu_basprc', 
isnull(case ycf_oper when'*'  then 'PC'  when '/' then 'PC' else ipi_pckunt end,'N/A') as 'ipi_smpunt',
--added by Mark Lau 20060919
isnull(ibi_alsitmno,' ') as  'ibi_alsitmno',			
isnull(ibi_alscolcde,' ') as  'ibi_alscolcde',	
--imu_alsbasprc,
vbi_ventyp,		--Add by Lewis
ibi_catlvl3			-- Add by Lewis

From IMBASINF (NOLOCK) 
left join VNBASINF (NOLOCK) on vbi_venno = ibi_venno
left join  IMPCKINF pck (NOLOCK) on --pck.ipi_cocde = ibi_cocde and 
			pck.ipi_itmno = ibi_itmno and 
			pck.ipi_pckseq = (select min(spk.ipi_pckseq) from 
						impckinf spk (NOLOCK) where --spk.ipi_cocde = ibi_cocde and 
								spk.ipi_itmno = ibi_itmno)
left join  IMMRKUP (NOLOCK) on --imu_cocde = ibi_cocde and 
			imu_ventyp = case vbi_ventyp when 'E' then 'D' else 'P' end and 
			imu_venno = ibi_venno and 
			imu_itmno = ibi_itmno and 
			pck.ipi_pckunt = imu_pckunt and
			pck.ipi_inrqty = imu_inrqty and
			pck.ipi_mtrqty = imu_mtrqty 
left join SYCONFTR (NOLOCK) on  --ycf_cocde=ibi_cocde and 
			pck.ipi_pckunt = ycf_code1 and ycf_code2 = 'PC' 

,IMVENINF (NOLOCK) 
where 
ibi_itmno= ivi_itmno and
ibi_venno = ivi_venno and 
--ibi_cocde = ivi_cocde and
--ibi_cocde = 'UCP' and 
ibi_typ = 'reg' and 
ibi_tirtyp = '2' and 
(ibi_itmsts = 'CMP' or ibi_itmsts = 'INC') and 
ivi_venitm <> '' and 
ibi_credat between @START  and @END
and ibi_itmno
not in
(
select  ivi_itmno from imveninf(nolock)
inner join vnbasinf(nolock) on ivi_venno = vbi_venno
inner join imbasinf(nolock) on ivi_itmno = ibi_itmno
where
vbi_ventyp = 'E'
--and ibi_itmsts = 'CMP'
--and ibi_credat > '2008-06-01'
group by ivi_itmno
having count(*) > 1)
--and (ibi_itmno not like '00A%' and ibi_itmno not like '00B%' and ibi_itmno not like '00U%' and ibi_itmno not like '01A%' and ibi_itmno not like '01B%' and ibi_itmno not like '01U%' and ibi_itmno not like '02A%' and ibi_itmno not like '02B%' and ibi_itmno not like '02U%' and ibi_itmno not like '03A%' and ibi_itmno not like '03B%' and ibi_itmno not like '03U%'and ibi_itmno not like '04A%' and ibi_itmno not like '04B%' and ibi_itmno not like '04U%')
-- Added by Mark Lau 20090318
and imu_std = 'Y'


/*************************Lester Wu 2006-03-21, retrieve data of old item*********************************************/
/*UNION
Select 
ibi_credat,
' ' as 'ibi_cocde',
ibi_itmno,
ivi_venitm,
ibi_engdsc,
ibi_venno,
case rtrim(ltrim(ibi_imgpth)) when '' then 'N' else 'Y' end as ibi_img,
Isnull(pck.ipi_pckseq,1)as  'pck.ipi_pckseq', 
isnull(pck.ipi_inrqty,0) as 'pck.ipi_inrqty', 
isnull(pck.ipi_mtrqty,0) as 'pck.ipi_mtrqty',
isnull(pck.ipi_cft,0) as 'pck.ipi_cft', 
isnull(pck.ipi_pckunt,'N/A') as 'pck.ipi_pckunt', 
ibi_tirtyp, 
isnull(yts_moq,0) as 'ibi_moqctn',
isnull(yts_moa,0) as 'ibi_moa',
isnull(imu_bcurcde,'') as'imu_bcurcde', 
isnull(imu_basprc,0) as 'imu_basprc', 
isnull(case ycf_oper when'*'  then 'PC'  when '/' then 'PC' else ipi_pckunt end,'N/A') as 'ipi_smpunt',
' ' as 'ibi_alsitmno',		--Add by Lewis 
--imu_alsbasprc,
vbi_ventyp,		--Add by Lewis
ibi_catlvl3			--Add by Lewis

From 
IMPDAINF (NOLOCK)
left join IMBASINF (NOLOCK) on pda_itmno = ibi_itmno
left join VNBASINF (NOLOCK) on vbi_venno = ibi_venno
left join  IMPCKINF pck (NOLOCK) on --pck.ipi_cocde = ibi_cocde and 
			pck.ipi_itmno = ibi_itmno and 
			pck.ipi_pckseq = (select min(spk.ipi_pckseq) from 
						impckinf spk (NOLOCK) where --spk.ipi_cocde = ibi_cocde and 
								spk.ipi_itmno = ibi_itmno)
left join  IMMRKUP (NOLOCK) on --imu_cocde = ibi_cocde and 
			imu_ventyp = case vbi_ventyp when 'E' then 'D' else 'P' end and 
			imu_venno = ibi_venno and 
			imu_itmno = ibi_itmno and 
			pck.ipi_pckunt = imu_pckunt and
			pck.ipi_inrqty = imu_inrqty and
			pck.ipi_mtrqty = imu_mtrqty 
left join SYCONFTR (NOLOCK) on  --ycf_cocde=ibi_cocde and 
			pck.ipi_pckunt = ycf_code1 and ycf_code2 = 'PC' 
left join SYTIESTR (NOLOCK) on ibi_tirtyp = '1' 	and 
			pck.ipi_mtrqty >= yts_qtyfr and 
			pck.ipi_mtrqty <= yts_qtyto and 
			--ibi_cocde = yts_cocde and 
			ibi_venno = yts_venno and 
			yts_tirtyp = 'M' and 
			yts_itmtyp = 'R'


,IMVENINF (NOLOCK) 
where 
ibi_itmno = ivi_itmno and 
ibi_venno = ivi_venno and 
--ivi_cocde = ibi_cocde and
ibi_typ = 'reg' and 
 ibi_tirtyp = '1'  and
--ibi_cocde = 'UCP' and ibi_typ = 'reg' and 
(ibi_itmsts = 'CMP' or ibi_itmsts = 'INC') and 
ivi_venitm <> '' and 
--ibi_credat between @START  and @END
--pda_credat between @START  and @END and
ibi_itmno is not null

UNION

Select 
ibi_credat,
' ' as 'ibi_cocde',
ibi_itmno,
ivi_venitm,
ibi_engdsc,
ibi_venno,
case rtrim(ltrim(ibi_imgpth)) when '' then 'N' else 'Y' end as ibi_img,
Isnull(pck.ipi_pckseq,1)as  'pck.ipi_pckseq', 
isnull(pck.ipi_inrqty,0) as 'pck.ipi_inrqty', 
isnull(pck.ipi_mtrqty,0) as 'pck.ipi_mtrqty',
isnull(pck.ipi_cft,0) as 'pck.ipi_cft', 
isnull(pck.ipi_pckunt,'N/A') as 'pck.ipi_pckunt', 
ibi_tirtyp, 
ibi_moqctn,
ibi_moa,
isnull(imu_bcurcde,'') as'imu_bcurcde', 
isnull(imu_basprc,0) as 'imu_basprc', 
isnull(case ycf_oper when'*'  then 'PC'  when '/' then 'PC' else ipi_pckunt end,'N/A') as 'ipi_smpunt',
' ' as 'ibi_alsitmno',		--Add by Lewis
--imu_alsbasprc,
vbi_ventyp,		--Add by Lewis
ibi_catlvl3			-- Add by Lewis

From 
IMPDAINF (NOLOCK)
left join IMBASINF (NOLOCK) on pda_itmno = ibi_itmno
left join VNBASINF (NOLOCK) on vbi_venno = ibi_venno
left join  IMPCKINF pck (NOLOCK) on --pck.ipi_cocde = ibi_cocde and 
			pck.ipi_itmno = ibi_itmno and 
			pck.ipi_pckseq = (select min(spk.ipi_pckseq) from 
						impckinf spk (NOLOCK) where --spk.ipi_cocde = ibi_cocde and 
								spk.ipi_itmno = ibi_itmno)
left join  IMMRKUP (NOLOCK) on --imu_cocde = ibi_cocde and 
			imu_ventyp = case vbi_ventyp when 'E' then 'D' else 'P' end and 
			imu_venno = ibi_venno and 
			imu_itmno = ibi_itmno and 
			pck.ipi_pckunt = imu_pckunt and
			pck.ipi_inrqty = imu_inrqty and
			pck.ipi_mtrqty = imu_mtrqty 
left join SYCONFTR (NOLOCK) on  --ycf_cocde=ibi_cocde and 
			pck.ipi_pckunt = ycf_code1 and ycf_code2 = 'PC' 

,IMVENINF (NOLOCK) 
where 
ibi_itmno= ivi_itmno and
ibi_venno = ivi_venno and 
--ibi_cocde = ivi_cocde and
--ibi_cocde = 'UCP' and 
ibi_typ = 'reg' and 
ibi_tirtyp = '2' and 
(ibi_itmsts = 'CMP' or ibi_itmsts = 'INC') and 
ivi_venitm <> '' and 
--ibi_credat between @START  and @END
--pda_credat between @START  and @END and 
ibi_itmno is not null
*/

/*************************Lester Wu 2006-03-21, retrieve data of old item*********************************************/
--Mark Lau 20060919, change sorting from 1, 3 to ibi_itmno
order by ibi_itmno



GO
GRANT EXECUTE ON [dbo].[sp_Spring_IM_Full_His] TO [ERPUSER] AS [dbo]
GO
