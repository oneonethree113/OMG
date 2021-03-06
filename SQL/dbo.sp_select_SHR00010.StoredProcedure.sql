/****** Object:  StoredProcedure [dbo].[sp_select_SHR00010]    Script Date: 09/29/2017 15:29:09 ******/
DROP PROCEDURE [dbo].[sp_select_SHR00010]
GO
/****** Object:  StoredProcedure [dbo].[sp_select_SHR00010]    Script Date: 09/29/2017 15:29:10 ******/
SET ANSI_NULLS OFF
GO
SET QUOTED_IDENTIFIER OFF
GO












/************************************************************************
Author:		Marco Chan
Date:		15th February, 2011
Description:	insert data into SHR00010
***********************************************************************
*/
--sp_select_SHR00010 '','TR201100004','E'

CREATE    procedure [dbo].[sp_select_SHR00010]


@sch_cocde	nvarchar(6),
@sch_docno	nvarchar(20),
@sch_type char(1)

 
AS

BEGIN

declare @custlist  nvarchar(3000)
declare @cus_name nvarchar(3000)

create TABLE #spt_table
(splitdata NVARCHAR(3000) )

declare @string  nvarchar(10)
declare @delimiter CHAR(1) 

set @string   = (select sch_cuslst 
from SHCHGHDR
where 
sch_docno = @sch_docno)

set @delimiter  = ','

DECLARE @start INT, @end INT 
    SELECT @start = 1, @end = CHARINDEX(@delimiter, @string) 
    WHILE @start < LEN(@string) + 1 BEGIN 
        IF @end = 0  
            SET @end = LEN(@string) + 1
       
        INSERT INTO #spt_table 
        VALUES(SUBSTRING(@string, @start, @end - @start)) 
        SET @start = @end + 1 
        SET @end = CHARINDEX(@delimiter, @string, @start)
        
    END 

set @custlist = ''

DECLARE cus_cursor CURSOR FOR 
select distinct splitdata from #spt_table ;

OPEN cus_cursor

FETCH NEXT FROM cus_cursor 
INTO @cus_name

WHILE @@FETCH_STATUS = 0
BEGIN
if @custlist = ''  
	BEGIN
		set @custlist = @cus_name
	END 
else
	BEGIN
		set @custlist = @custlist  + ',' + @cus_name
	END 

FETCH NEXT FROM cus_cursor 
INTO @cus_name


END 
CLOSE cus_cursor;
DEALLOCATE cus_cursor;






if @sch_type = 'R' 
begin

--------------------------------------------------------------------------------------------------
select
sch_docno,
sch_typ,
sch_sts,
scf_fwdnam as 'sch_fwdnam',
scf_fwdinv as 'sch_fwdinv',
scf_fcrno as 'sch_fcrno',
scf_fcurcde as 'sch_fcurcde',
sch_curcde,
sch_exchrat,
sch_pckdat,
sch_ctrcfs,
sch_ctrsiz,
sch_invlst,
@custlist as 'sch_cuslst',
sch_cusnolst,
sch_etddat,
sch_rmk,
--sch_creusr,
--sch_updusr,
--sch_credat,
--sch_upddat,
--sch_timstp,

--scd_docno,
scd_venno,
vbi_vensna 'scd_vensna',
scd_chgcde,
ysc_chgdsc 'scd_chgdsc',
scd_syscbm,
scd_mancbm,
scd_curcde,
scd_fee
--,
--scd_creusr,
--scd_updusr,
--scd_credat,
--scd_upddat,
--scd_timstp

from SHCHGHDR (nolock)
left join SHCHGFWD (nolock)  on sch_docno = scf_docno
left join SHCHGDTL (nolock) on sch_docno = scd_docno
left join VNBASINF (nolock) on vbi_venno = scd_venno
left join SYMSHC (nolock) on ysc_chgcde = scd_chgcde
where sch_docno = @sch_docno

end
else
begin

create table #TEMP_REPORT
(
tmp_vensna	nvarchar(200),
tmp_syscbm	numeric(13,4),
tmp_mancbm	numeric(13,4),
tmp_dcol1	numeric(13,4),
tmp_dcol2	numeric(13,4),
tmp_dcol3	numeric(13,4),
tmp_dcol4	numeric(13,4),
tmp_dcol5	numeric(13,4),
tmp_dcol6	numeric(13,4),
tmp_dcol7	numeric(13,4),
tmp_scol1	numeric(13,4),
tmp_scol2	numeric(13,4),
tmp_scol3	numeric(13,4),
tmp_scol4	numeric(13,4),
tmp_scol5	numeric(13,4),
tmp_scol6	numeric(13,4),
tmp_scol7	numeric(13,4),
tmp_scol8	numeric(13,4),
tmp_colttl	numeric(13,4)
)

declare @fcurcde nvarchar(10)
set @fcurcde = ''

declare @exch_rate numeric(20,8)

select @fcurcde = scf_fcurcde, @exch_rate = sch_exchrat from SHCHGHDR
left join SHCHGFWD (nolock)  on sch_docno = scf_docno
 where sch_docno = @sch_docno


declare @bool_CNY char(1)
set @bool_CNY = 'N'

-- 1) CNY TOTAL
if @fcurcde = 'CNY'
begin

set @bool_CNY = 'Y'
	
insert into #TEMP_REPORT
select 
'攤分數(CNY)',
0,0,
isnull(d1.scd_fee,0),
isnull(d2.scd_fee,0),
isnull(d3.scd_fee,0),
isnull(d4.scd_fee,0),
isnull(d5.scd_fee,0),
isnull(d6.scd_fee,0),
isnull(d7.scd_fee,0),
0,0,0,0,0,0,0,0, -- 8 s col
0 -- total
from 
SHCHGHDR h (nolock)
left join SHCHGFWD (nolock)  on sch_docno = scf_docno
left join SHCHGDTL d1 (nolock) on d1.scd_docno = h.sch_docno and d1.scd_chgcde = 'SHDCHG010' and d1.scd_venno = 'TOTAL' and d1.scd_curcde = @fcurcde
left join SHCHGDTL d2 (nolock) on d2.scd_docno = h.sch_docno and d2.scd_chgcde = 'SHDCHG020' and d2.scd_venno = 'TOTAL' and d2.scd_curcde = @fcurcde
left join SHCHGDTL d3 (nolock) on d3.scd_docno = h.sch_docno and d3.scd_chgcde = 'SHDCHG030' and d3.scd_venno = 'TOTAL' and d3.scd_curcde = @fcurcde
left join SHCHGDTL d4 (nolock) on d4.scd_docno = h.sch_docno and d4.scd_chgcde = 'SHDCHG040' and d4.scd_venno = 'TOTAL' and d4.scd_curcde = @fcurcde
left join SHCHGDTL d5 (nolock) on d5.scd_docno = h.sch_docno and d5.scd_chgcde = 'SHDCHG050' and d5.scd_venno = 'TOTAL' and d5.scd_curcde = @fcurcde
left join SHCHGDTL d6 (nolock) on d6.scd_docno = h.sch_docno and d6.scd_chgcde = 'SHDCHG060' and d6.scd_venno = 'TOTAL' and d6.scd_curcde = @fcurcde
left join SHCHGDTL d7 (nolock) on d7.scd_docno = h.sch_docno and d7.scd_chgcde = 'SHDCHG070' and d7.scd_venno = 'TOTAL' and d7.scd_curcde = @fcurcde
where h.sch_docno = @sch_docno

end


-- 2) HKD TOTAL
set @fcurcde = 'HKD'

insert into #TEMP_REPORT
select 
'攤分數(HKD)',
0,0,
isnull(d1.scd_fee,0),
isnull(d2.scd_fee,0),
isnull(d3.scd_fee,0),
isnull(d4.scd_fee,0),
isnull(d5.scd_fee,0),
isnull(d6.scd_fee,0),
isnull(d7.scd_fee,0),
0,0,0,0,0,0,0,0, -- 8 s col
0 -- total
from 
SHCHGHDR h (nolock)
left join SHCHGFWD (nolock)  on sch_docno = scf_docno
left join SHCHGDTL d1 (nolock) on d1.scd_docno = h.sch_docno and d1.scd_chgcde = 'SHDCHG010' and d1.scd_venno = 'TOTAL' and d1.scd_curcde = @fcurcde
left join SHCHGDTL d2 (nolock) on d2.scd_docno = h.sch_docno and d2.scd_chgcde = 'SHDCHG020' and d2.scd_venno = 'TOTAL' and d2.scd_curcde = @fcurcde
left join SHCHGDTL d3 (nolock) on d3.scd_docno = h.sch_docno and d3.scd_chgcde = 'SHDCHG030' and d3.scd_venno = 'TOTAL' and d3.scd_curcde = @fcurcde
left join SHCHGDTL d4 (nolock) on d4.scd_docno = h.sch_docno and d4.scd_chgcde = 'SHDCHG040' and d4.scd_venno = 'TOTAL' and d4.scd_curcde = @fcurcde
left join SHCHGDTL d5 (nolock) on d5.scd_docno = h.sch_docno and d5.scd_chgcde = 'SHDCHG050' and d5.scd_venno = 'TOTAL' and d5.scd_curcde = @fcurcde
left join SHCHGDTL d6 (nolock) on d6.scd_docno = h.sch_docno and d6.scd_chgcde = 'SHDCHG060' and d6.scd_venno = 'TOTAL' and d6.scd_curcde = @fcurcde
left join SHCHGDTL d7 (nolock) on d7.scd_docno = h.sch_docno and d7.scd_chgcde = 'SHDCHG070' and d7.scd_venno = 'TOTAL' and d7.scd_curcde = @fcurcde
where h.sch_docno = @sch_docno


-- 3)Space 
insert into #TEMP_REPORT
select
'-',0,0,
0,0,0,0,0,0,0,
0,0,0,0,0,0,0,0,
0 


-- 4)Vendor
declare @venno as nvarchar(10)

declare cursor_venno cursor for
select distinct scd_venno from SHCHGDTL where scd_docno = @sch_docno and scd_venno <> 'TOTAL' order by scd_venno

open cursor_venno
fetch cursor_venno into @venno

while @@fetch_status = 0
begin

insert into #TEMP_REPORT
select 
@venno + ' - ' + vbi_vensna,
isnull(d0.scd_syscbm,0),
isnull(d0.scd_mancbm,0),
isnull(d1.scd_fee,0),
isnull(d2.scd_fee,0),
isnull(d3.scd_fee,0),
isnull(d4.scd_fee,0),
isnull(d5.scd_fee,0),
isnull(d6.scd_fee,0),
isnull(d7.scd_fee,0),
isnull(s1.scd_fee,0),
isnull(s2.scd_fee,0),
isnull(s3.scd_fee,0),
isnull(s4.scd_fee,0),
isnull(s5.scd_fee,0),
isnull(s6.scd_fee,0),
isnull(s7.scd_fee,0),
isnull(s8.scd_fee,0), -- 8 s col
0 -- total
from 
SHCHGDTL d0(nolock)
left join VNBASINF (nolock) on d0.scd_venno = vbi_venno
left join SHCHGDTL d1 (nolock) on d1.scd_docno = d0.scd_docno and d1.scd_chgcde = 'SHDCHG010' and d1.scd_venno = @venno and d1.scd_curcde = @fcurcde
left join SHCHGDTL d2 (nolock) on d2.scd_docno = d0.scd_docno and d2.scd_chgcde = 'SHDCHG020' and d2.scd_venno = @venno and d2.scd_curcde = @fcurcde
left join SHCHGDTL d3 (nolock) on d3.scd_docno = d0.scd_docno and d3.scd_chgcde = 'SHDCHG030' and d3.scd_venno = @venno and d3.scd_curcde = @fcurcde
left join SHCHGDTL d4 (nolock) on d4.scd_docno = d0.scd_docno and d4.scd_chgcde = 'SHDCHG040' and d4.scd_venno = @venno and d4.scd_curcde = @fcurcde
left join SHCHGDTL d5 (nolock) on d5.scd_docno = d0.scd_docno and d5.scd_chgcde = 'SHDCHG050' and d5.scd_venno = @venno and d5.scd_curcde = @fcurcde
left join SHCHGDTL d6 (nolock) on d6.scd_docno = d0.scd_docno and d6.scd_chgcde = 'SHDCHG060' and d6.scd_venno = @venno and d6.scd_curcde = @fcurcde
left join SHCHGDTL d7 (nolock) on d7.scd_docno = d0.scd_docno and d7.scd_chgcde = 'SHDCHG070' and d7.scd_venno = @venno and d7.scd_curcde = @fcurcde
left join SHCHGDTL s1 (nolock) on s1.scd_docno = d0.scd_docno and s1.scd_chgcde = 'SHSCHG010' and s1.scd_venno = @venno and s1.scd_curcde = @fcurcde
left join SHCHGDTL s2 (nolock) on s2.scd_docno = d0.scd_docno and s2.scd_chgcde = 'SHSCHG020' and s2.scd_venno = @venno and s2.scd_curcde = @fcurcde
left join SHCHGDTL s3 (nolock) on s3.scd_docno = d0.scd_docno and s3.scd_chgcde = 'SHSCHG030' and s3.scd_venno = @venno and s3.scd_curcde = @fcurcde
left join SHCHGDTL s4 (nolock) on s4.scd_docno = d0.scd_docno and s4.scd_chgcde = 'SHSCHG040' and s4.scd_venno = @venno and s4.scd_curcde = @fcurcde
left join SHCHGDTL s5 (nolock) on s5.scd_docno = d0.scd_docno and s5.scd_chgcde = 'SHSCHG050' and s5.scd_venno = @venno and s5.scd_curcde = @fcurcde
left join SHCHGDTL s6 (nolock) on s6.scd_docno = d0.scd_docno and s6.scd_chgcde = 'SHSCHG060' and s6.scd_venno = @venno and s6.scd_curcde = @fcurcde
left join SHCHGDTL s7 (nolock) on s7.scd_docno = d0.scd_docno and s7.scd_chgcde = 'SHSCHG070' and s7.scd_venno = @venno and s7.scd_curcde = @fcurcde
left join SHCHGDTL s8 (nolock) on s8.scd_docno = d0.scd_docno and s8.scd_chgcde = 'SHSCHG080' and s8.scd_venno = @venno and s8.scd_curcde = @fcurcde
where d0.scd_docno = @sch_docno and d0.scd_chgcde = 'SHDCHG010' and d0.scd_venno = @venno and d0.scd_curcde = @fcurcde

	fetch next from cursor_venno into @venno
end
close cursor_venno
deallocate cursor_venno


-- 5)Space 
insert into #TEMP_REPORT
select
'-',0,0,
0,0,0,0,0,0,0,
0,0,0,0,0,0,0,0,
0 


-- 6)HKD calculate total
insert into #TEMP_REPORT
select
'總計(HKD)',0,0,
0,0,0,0,0,0,0,
0,0,0,0,0,0,0,0,
0 

declare @ttl_syscbm numeric(13,4)
declare @ttl_mancbm numeric(13,4)

declare @ttl_d1 numeric(13,4)
declare @ttl_d2 numeric(13,4)
declare @ttl_d3 numeric(13,4)
declare @ttl_d4 numeric(13,4)
declare @ttl_d5 numeric(13,4)
declare @ttl_d6 numeric(13,4)
declare @ttl_d7 numeric(13,4)

declare @ttl_s1 numeric(13,4)
declare @ttl_s2 numeric(13,4)
declare @ttl_s3 numeric(13,4)
declare @ttl_s4 numeric(13,4)
declare @ttl_s5 numeric(13,4)
declare @ttl_s6 numeric(13,4)
declare @ttl_s7 numeric(13,4)
declare @ttl_s8 numeric(13,4)


select 
@ttl_syscbm = isnull(sum(tmp_syscbm),0), 
@ttl_mancbm = isnull(sum(tmp_mancbm),0),
@ttl_d1 = isnull(sum(tmp_dcol1),0),
@ttl_d2 = isnull(sum(tmp_dcol2),0),
@ttl_d3 = isnull(sum(tmp_dcol3),0),
@ttl_d4 = isnull(sum(tmp_dcol4),0),
@ttl_d5 = isnull(sum(tmp_dcol5),0),
@ttl_d6 = isnull(sum(tmp_dcol6),0),
@ttl_d7 = isnull(sum(tmp_dcol7),0),
@ttl_s1 = isnull(sum(tmp_scol1),0),
@ttl_s2 = isnull(sum(tmp_scol2),0),
@ttl_s3 = isnull(sum(tmp_scol3),0),
@ttl_s4 = isnull(sum(tmp_scol4),0),
@ttl_s5 = isnull(sum(tmp_scol5),0),
@ttl_s6 = isnull(sum(tmp_scol6),0),
@ttl_s7 = isnull(sum(tmp_scol7),0),
@ttl_s8 = isnull(sum(tmp_scol8),0)
from #TEMP_REPORT where tmp_vensna not in ('攤分數(CNY)','攤分數(HKD)')

update #TEMP_REPORT set 
tmp_syscbm = @ttl_syscbm, 
tmp_mancbm = @ttl_mancbm,
tmp_dcol1 = @ttl_d1,
tmp_dcol2 = @ttl_d2,
tmp_dcol3 = @ttl_d3,
tmp_dcol4 = @ttl_d4,
tmp_dcol5 = @ttl_d5,
tmp_dcol6 = @ttl_d6,
tmp_dcol7 = @ttl_d7,
tmp_scol1 = @ttl_s1,
tmp_scol2 = @ttl_s2,
tmp_scol3 = @ttl_s3,
tmp_scol4 = @ttl_s4,
tmp_scol5 = @ttl_s5,
tmp_scol6 = @ttl_s6,
tmp_scol7 = @ttl_s7,
tmp_scol8 = @ttl_s8
where tmp_vensna = '總計(HKD)'



-- 7)CNY calculate total

if @bool_CNY = 'Y'
begin

insert into #TEMP_REPORT
select
'總計(CNY)',0,0,
0,0,0,0,0,0,0,
0,0,0,0,0,0,0,0,
0 

update #TEMP_REPORT set 
tmp_dcol1 = @ttl_d1/@exch_rate,
tmp_dcol2 = @ttl_d2/@exch_rate,
tmp_dcol3 = @ttl_d3/@exch_rate,
tmp_dcol4 = @ttl_d4/@exch_rate,
tmp_dcol5 = @ttl_d5/@exch_rate,
tmp_dcol6 = @ttl_d6/@exch_rate,
tmp_dcol7 = @ttl_d7/@exch_rate,
tmp_scol1 = @ttl_s1/@exch_rate,
tmp_scol2 = @ttl_s2/@exch_rate,
tmp_scol3 = @ttl_s3/@exch_rate,
tmp_scol4 = @ttl_s4/@exch_rate,
tmp_scol5 = @ttl_s5/@exch_rate,
tmp_scol6 = @ttl_s6/@exch_rate,
tmp_scol7 = @ttl_s7/@exch_rate,
tmp_scol8 = @ttl_s8/@exch_rate
where tmp_vensna = '總計(CNY)'


end


update #TEMP_REPORT set tmp_colttl = tmp_dcol1 + tmp_dcol2 + tmp_dcol3 + tmp_dcol4 + tmp_dcol5 + tmp_dcol6 + tmp_dcol7 + tmp_scol1 + tmp_scol2 + tmp_scol3 + tmp_scol4 + tmp_scol5 + tmp_scol6 + tmp_scol7 + tmp_scol8  



select
sch_docno,
sch_typ,
sch_sts,
scf_fwdnam as 'sch_fwdnam',
scf_fwdinv as 'sch_fwdinv',
scf_fcrno as 'sch_fcrno',
scf_fcurcde as 'sch_fcurcde',
sch_curcde,
sch_exchrat,
sch_pckdat,
sch_ctrcfs,
sch_ctrsiz,
sch_invlst,
@custlist as 'sch_cuslst',
sch_cusnolst,
sch_etddat,
sch_rmk,
sch_credat,
sch_upddat,
sch_creusr,
sch_updusr,
tmp_vensna,
tmp_syscbm,
tmp_mancbm,
tmp_dcol1,
tmp_dcol2,
tmp_dcol3,
tmp_dcol4,
tmp_dcol5,
tmp_dcol6,
tmp_dcol7,
tmp_scol1,
tmp_scol2,
tmp_scol3,
tmp_scol4,
tmp_scol5,
tmp_scol6,
tmp_scol7,
tmp_scol8,
tmp_colttl

from SHCHGHDR (nolock)
left join SHCHGFWD (nolock)  on sch_docno = scf_docno
left join #TEMP_REPORT on 'A' = 'A'
where sch_docno = @sch_docno



drop table #TEMP_REPORT

end









END




drop table #spt_table
GO
GRANT EXECUTE ON [dbo].[sp_select_SHR00010] TO [ERPUSER] AS [dbo]
GO
