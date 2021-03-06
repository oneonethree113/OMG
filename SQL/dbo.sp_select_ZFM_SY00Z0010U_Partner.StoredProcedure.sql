/****** Object:  StoredProcedure [dbo].[sp_select_ZFM_SY00Z0010U_Partner]    Script Date: 09/29/2017 15:29:08 ******/
DROP PROCEDURE [dbo].[sp_select_ZFM_SY00Z0010U_Partner]
GO
/****** Object:  StoredProcedure [dbo].[sp_select_ZFM_SY00Z0010U_Partner]    Script Date: 09/29/2017 15:29:10 ******/
SET ANSI_NULLS OFF
GO
SET QUOTED_IDENTIFIER OFF
GO





CREATE procedure [dbo].[sp_select_ZFM_SY00Z0010U_Partner]
                                                                                                                                                                                                                                                                 
---------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------- 

@cocde nvarchar(6) 
             

---------------------------------------------- 
 
AS


begin
/*


select top 1 * into #tmp_original from cucntinf_aud where cci_cnttyp not in ('M','S','B') and cci_cusno = '50001' and year(cci_credat) = year(getdate()) and month(cci_credat) = month(getdate()) and day(cci_credat) = day(getdate())
order by cci_credat, cci_actflg_aud asc


select top 1  * into #tmp_new  from cucntinf_aud where cci_cnttyp not in ('M','S','B') and cci_cusno = '50001' and year(cci_credat) = year(getdate()) and month(cci_credat) = month(getdate()) and day(cci_credat) = day(getdate())
order by cci_credat desc , cci_actflg_aud desc

select * from #tmp_original o
 left join #tmp_new n  on n.cci_cusno = o.cci_cusno and n.cci_cnttyp = o.cci_cnttyp and n.cci_cntseq = o.cci_cntseq


drop table #tmp_original
drop table #tmp_new
drop table #tmp_cusno

select  * from cucntinf_aud where cci_cusno = '50001' and cci_actflg_aud = '1'


select * from #tmp_new

select * from #tmp_original

select * from #tmp_cusno

select *  from cucntinf_aud where  year(cci_credat) = year(getdate()) and month(cci_credat) = month(getdate()) and day(cci_credat) = day(getdate()) and  cci_cnttyp not in ('M','S','B')
and  cci_actflg_aud = '1'

select distinct cci_cusno, cci_cnttyp,cci_cntseq  from cucntinf_aud where  year(cci_credat) = year(getdate()) and month(cci_credat) = month(getdate()) and day(cci_credat) = day(getdate())
and  cci_cnttyp not in ('M','S','B')

( cci_actflg_aud = '2' or  cci_actflg_aud = '3') and
select *  from cucntinf_aud where ( cci_actflg_aud = '2' or  cci_actflg_aud = '3') and year(cci_credat) = year(getdate()) and month(cci_credat) = month(getdate()) and day(cci_credat) = day(getdate())
and  cci_cnttyp not in ('M','S','B')

*/

declare @cust nvarchar(10),
 @cnttyp nvarchar(10),
 @cntseq nvarchar(10)
set @cust = ''
set @cnttyp = ''
set @cntseq = ''

CREATE TABLE #tmp_result(
KUNNR nvarchar(100),
PARVW nvarchar(100),
KTONR nvarchar(100),
KNREF nvarchar(100),
ACTFLG nvarchar(100),
	)

/*
CREATE TABLE #tmp_result2(
KUNNR nvarchar(100),
PARVW nvarchar(100),
KTONR nvarchar(100),
KNREF nvarchar(100),
ACTFLG nvarchar(100),
	)
*/
-----------------------
--Get Updated Record
DECLARE Result_cursor CURSOR FOR
select distinct cci_cusno, cci_cnttyp,cci_cntseq  from ucperpdb_AUD..cucntinf_aud where ( cci_actflg_aud = '2' or  cci_actflg_aud = '3') 
--and year(cci_credat) = year(getdate()) and month(cci_credat) = month(getdate()) and day(cci_credat) = day(getdate()) 
and cci_credat > '2014-02-01'
and cci_cnttyp in ('M','S','B') and cci_delete = 'Y' and cci_cusno like '5%'
OPEN Result_cursor

FETCH NEXT FROM Result_cursor
INTO @cust, @cnttyp, @cntseq

WHILE @@FETCH_STATUS = 0
BEGIN

/*
select TOP 1  * into #tmp_original  from cucntinf_aud where cci_cnttyp in ('M','S','B') and  year(cci_credat) = year(getdate()) and month(cci_credat) = month(getdate()) and day(cci_credat) = day(getdate())
and cci_actflg_aud = '2' AND cci_cusno = @cust and cci_cnttyp =  @cnttyp and  cci_cntseq =  @cntseq and cci_delete = 'N'
order by cci_credat, cci_actflg_aud asc
*/
select TOP 1 * into #tmp_new  from ucperpdb_AUD..cucntinf_aud a
--left join  cucntinf_aud b on a.cci_cusno = b.cci_cusno and a.cci_cnttyp = b.cci_cnttyp and a.cci_cntseq = b.cci_cntseq
where a.cci_cnttyp  in ('M','S','B') and a.cci_actflg_aud = '3'   and 
--year(a.cci_credat) = year(getdate()) and month(a.cci_credat) = month(getdate()) and day(a.cci_credat) = day(getdate())
--CONVERT(NVARCHAR(10),A.cCi_credat,111) = CONVERT(NVARCHAR(10),getdate(),111) 
cci_credat > '2014-02-01'
AND a.cci_cusno = @cust and a.cci_cnttyp =  @cnttyp and  a.cci_cntseq =  @cntseq and cci_delete = 'Y' and  cci_sapshcusno is not null and  cci_sapshcusno <> ''
order by a.cci_credat desc , a.cci_actflg_aud desc

insert into #tmp_result
select cci_cusno as 'KUNNR','WE' as 'PARVW', cci_sapshcusno as 'KTONR' ,'' AS 'KNREF' , '4' as 'ACTFLG'  from #tmp_new


/*
drop table #tmp_original
*/
drop table #tmp_new

FETCH NEXT FROM Result_cursor
INTO @cust, @cnttyp, @cntseq

END
CLOSE Result_cursor
DEALLOCATE Result_cursor
/*
-----------------------------
--Get Deleted Record
DECLARE Result_cursor CURSOR FOR
select distinct cci_cusno, cci_cnttyp,cci_cntseq  from cucntinf_aud where ( cci_actflg_aud = '2' or  cci_actflg_aud = '3') and year(cci_credat) = year(getdate()) and month(cci_credat) = month(getdate()) and day(cci_credat) = day(getdate()) 
and cci_cnttyp not in ('M','S','B') and cci_delete = 'Y'
OPEN Result_cursor

FETCH NEXT FROM Result_cursor
INTO @cust, @cnttyp, @cntseq

WHILE @@FETCH_STATUS = 0
BEGIN


select TOP 1  * into #tmp_original2  from cucntinf_aud where cci_cnttyp not in ('M','S','B') and  year(cci_credat) = year(getdate()) and month(cci_credat) = month(getdate()) and day(cci_credat) = day(getdate())
and cci_actflg_aud = '2' AND cci_cusno = @cust and cci_cnttyp =  @cnttyp and  cci_cntseq =  @cntseq and cci_delete = 'Y'
order by cci_credat, cci_actflg_aud asc

select TOP 1 * into #tmp_new2  from cucntinf_aud a
--left join  cucntinf_aud b on a.cci_cusno = b.cci_cusno and a.cci_cnttyp = b.cci_cnttyp and a.cci_cntseq = b.cci_cntseq
where a.cci_cnttyp not in ('M','S','B') and a.cci_actflg_aud = '3'   and year(a.cci_credat) = year(getdate()) and month(a.cci_credat) = month(getdate()) and day(a.cci_credat) = day(getdate())
AND a.cci_cusno = @cust and a.cci_cnttyp =  @cnttyp and  a.cci_cntseq =  @cntseq and cci_delete = 'Y'
order by a.cci_credat desc , a.cci_actflg_aud desc

insert into #tmp_result2
select n.cci_cusno as 'KUNNR' ,
substring(n.cci_cntctp, 1,35) as 'CNT_NAME1',
case when len(n.cci_cntctp) <= 35 then '' else
substring(n.cci_cntctp, 36, len(n.cci_cntctp) -35)
end as 'NAMEV', 
 '' as 'ABTNR',
case  ysi_cde when 'ACCT' then 'ZA'
when 'ADMN' then 'ZB'
when 'AM' then 'ZC'
when 'BUYR' then 'ZD'
when 'DESG' then 'ZE'
when 'GENL' then 'ZF'
when 'MAGT' then 'ZG'
when 'MAKT' then 'ZH'
when 'MCH' then 'ZI'
when 'SALE' then 'ZJ'
when  'SHIP' then 'ZK'
else '' end as 'PAFKT',
'*' + n.cci_cntphn as 'TEL_NUMBER',
'' AS 'TEL_EXTENS',
'' AS 'MOB_NUMBER',
n.cci_cntfax AS 'FAX_NUMBER',
'' AS 'FAX_EXTENS',
n.cci_cnteml as 'SMTP_ADDR',
substring(o.cci_cntctp, 1,35) as 'O_CNT_NAME1',
case when len(o.cci_cntctp) <= 35 then '' else
substring(o.cci_cntctp, 36, len(o.cci_cntctp) -35)
end as  'O_NAMEV',
'' as 'O_ABTNR',
case  ysi_cde when 'ACCT' then 'ZA'
when 'ADMN' then 'ZB'
when 'AM' then 'ZC'
when 'BUYR' then 'ZD'
when 'DESG' then 'ZE'
when 'GENL' then 'ZF'
when 'MAGT' then 'ZG'
when 'MAKT' then 'ZH'
when 'MCH' then 'ZI'
when 'SALE' then 'ZJ'
when  'SHIP' then 'ZK'
else '' end as 'O_PAFKT',
'4' as 'ACTFLG'

 from #tmp_original2 o

 left join #tmp_new2 n  on n.cci_cusno = o.cci_cusno and n.cci_cnttyp = o.cci_cnttyp and n.cci_cntseq = o.cci_cntseq
left join ucpdev_ML..sysetinf on ysi_cde = n.cci_cnttyp 
where ysi_typ = '13'

drop table #tmp_original2
drop table #tmp_new2

FETCH NEXT FROM Result_cursor
INTO @cust, @cnttyp, @cntseq

END
CLOSE Result_cursor
DEALLOCATE Result_cursor
----------------------------------

*/




--Deleted Record
select KUNNR,PARVW,KTONR ,KNREF ,ACTFLG , '2' as 'ORDER' from #tmp_result

Union

--New Record
select cci_cusno as 'KUNNR','WE' as 'PARVW', cci_sapshcusno as 'KTONR' ,'' AS 'KNREF' , '1' as 'ACTFLG', '1' as 'ORDER'  from ucperpdb_AUD..cucntinf_aud 
where  cci_cusno like '5%' and cci_cnttyp  in ('B','S','M') and  cci_sapshcusno is not null and  cci_sapshcusno <> ''  and cci_actflg_aud = '1'  
 and --year(cci_credat) = year(getdate()) and month(cci_credat) = month(getdate()) and day(cci_credat) = day(getdate()) 
--CONVERT(NVARCHAR(10),cCi_credat,111) = CONVERT(NVARCHAR(10),getdate(),111) 
cci_credat > '2014-02-01'
Union

--New Record in Secondary Customer
select csc_prmcus as 'KUNNR','WE' as 'PARVW', cci_sapshcusno as 'KTONR'  ,'' AS 'KNREF' , '1' as 'ACTFLG' , '1' as 'ORDER'  from  cusubcus
left join ucperpdb_AUD..cucntinf_aud on csc_seccus = cci_cusno
 where  csc_prmcus like '5%' and cci_cnttyp  in ('B','S','M') and  cci_sapshcusno is not null and cci_actflg_aud = '1'
 and --year(cci_credat) = year(getdate()) and month(cci_credat) = month(getdate()) and day(cci_credat) = day(getdate()) 
--CONVERT(NVARCHAR(10),cCi_credat,111) = CONVERT(NVARCHAR(10),getdate(),111) 
cci_credat > '2014-02-01'
Union

--New Secondary Customer
select csc_prmcus as 'KUNNR','Z1' as 'PARVW', csc_seccus as 'KTONR'  ,'' AS 'KNREF' , '1' as 'ACTFLG' , '1' as 'ORDER'  from  ucperpdb_AUD..cusubcus_aud
--where CONVERT(NVARCHAR(10),csc_credat,111) = CONVERT(NVARCHAR(10),getdate(),111) 
where csc_credat > '2014-02-01'
 and csc_actflg_aud = '1'

union

--Deleted Record in Secondary Customer
select csc_prmcus as 'KUNNR','WE' as 'PARVW', cci_sapshcusno as 'KTONR'  ,'' AS 'KNREF' , '4' as 'ACTFLG' , '2' as 'ORDER'   from  cusubcus
left join ucperpdb_AUD..cucntinf_aud on csc_seccus = cci_cusno
 where  csc_prmcus like '5%' and cci_cnttyp  in ('B','S','M') and  cci_sapshcusno is not null and cci_actflg_aud = '3' and cci_delete = 'Y'
 and --year(cci_credat) = year(getdate()) and month(cci_credat) = month(getdate()) and day(cci_credat) = day(getdate()) 
--CONVERT(NVARCHAR(10),cSC_credat,111) = CONVERT(NVARCHAR(10),getdate(),111) 
csc_credat > '2014-02-01'
union

--New Relationship
select csc_prmcus as 'KUNNR','WE' as 'PARVW', cci_sapshcusno as 'KTONR'  ,'' AS 'KNREF' , '1' as 'ACTFLG' , '1' as 'ORDER'  from  ucperpdb_AUD..cusubcus_aud
left join cucntinf on csc_seccus = cci_cusno
 where  csc_prmcus like '5%' and cci_cnttyp  in ('B','S','M') and  cci_sapshcusno is not null and csc_actflg_aud = '1'
 and --year(csc_credat) = year(getdate()) and month(csc_credat) = month(getdate()) and day(csc_credat) = day(getdate()) 
--CONVERT(NVARCHAR(10),cSC_credat,111) = CONVERT(NVARCHAR(10),getdate(),111) 
csc_credat > '2014-02-01'
union

--Delete Existing Relationship
select csc_prmcus as 'KUNNR','WE' as 'PARVW', cci_sapshcusno as 'KTONR'  ,'' AS 'KNREF' , '4' as 'ACTFLG' , '2' as 'ORDER'  from  ucperpdb_AUD..cusubcus_aud
left join cucntinf on csc_seccus = cci_cusno
 where  csc_prmcus like '5%' and cci_cnttyp  in ('B','S','M') and  cci_sapshcusno is not null and csc_actflg_aud = '4'
 and --year(csc_credat) = year(getdate()) and month(csc_credat) = month(getdate()) and day(csc_credat) = day(getdate()) 
--CONVERT(NVARCHAR(10),cSC_credat,111) = CONVERT(NVARCHAR(10),getdate(),111) 
csc_credat >'2014-02-01'
--Delete Secondary Customer
select csc_prmcus as 'KUNNR','Z1' as 'PARVW', csc_seccus as 'KTONR'  ,'' AS 'KNREF' , '4' as 'ACTFLG' , '2' as 'ORDER'  from  ucperpdb_AUD..cusubcus_aud
--where CONVERT(NVARCHAR(10),csc_credat,111) = CONVERT(NVARCHAR(10),getdate(),111) 
where csc_credat > '2014-02-01'
 and csc_actflg_aud = '4'

order by [ORDER], actflg

drop table #tmp_result


end
GO
GRANT EXECUTE ON [dbo].[sp_select_ZFM_SY00Z0010U_Partner] TO [ERPUSER] AS [dbo]
GO
