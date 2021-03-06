/****** Object:  StoredProcedure [dbo].[sp_select_SHR00010_sub]    Script Date: 09/29/2017 15:29:09 ******/
DROP PROCEDURE [dbo].[sp_select_SHR00010_sub]
GO
/****** Object:  StoredProcedure [dbo].[sp_select_SHR00010_sub]    Script Date: 09/29/2017 15:29:10 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE           procedure [dbo].[sp_select_SHR00010_sub]
@sch_cocde	nvarchar(6),
@sch_docno	nvarchar(20)

 
AS

BEGIN

declare @custlist  nvarchar(3000)
declare @cus_name nvarchar(3000)



create TABLE #maintable
(
scf_fwdnam nvarchar(300),
the_order int,
chgcde nvarchar(30), 
chgdsc nvarchar(30), 
Total nvarchar(30), 
ft nvarchar(30),  
rateft nvarchar(30),  
v1 nvarchar(50), 
f1 nvarchar(30), v2 nvarchar(50), 
f2 nvarchar(30), v3 nvarchar(50), 
f3 nvarchar(30), v4 nvarchar(50), 
f4 nvarchar(30), v5 nvarchar(50), 
f5 nvarchar(30), v6 nvarchar(50), 
f6 nvarchar(30), v7 nvarchar(50), 
f7 nvarchar(30),   
sum_total nvarchar(30),
ratetotal nvarchar(30)
)

create TABLE #spt_table
(splitdata NVARCHAR(3000) )

create TABLE #fwder
(
scf_fwdnam  NVARCHAR(200)
 )
insert into #fwder
select scf_fwdnam
from SHCHGFWD
where scf_docno=@sch_docno
	order by scf_credat

create TABLE #tmp_venno
(venno NVARCHAR(10),
scd_credat  datetime
 )

create TABLE #tmp_venno_top
(venno NVARCHAR(10) )

create TABLE #tmp_chgcde
(chgcde NVARCHAR(30) )

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
-------------------
insert  into #tmp_venno
select   distinct  scd_venno,getdate()  from SHCHGHDR 
left join SHCHGFWD (nolock)  on sch_docno = scf_docno
left join SHCHGDTL (nolock) on sch_docno = scd_docno and scf_fwdnam= scd_fwdnam
where 	 sch_docno = @sch_docno
--		and scf_fwdnam = 'fwd1'
		and scd_venno <> 'TOTAL'
		--tempz	
	
--select * from #tmp_venno

--insert  into #tmp_venno_top
--select 'Total'

insert  into #tmp_venno_top
select   top 8  venno  from #tmp_venno 
	--order by scd_credat
				
--select * from #tmp_venno_top


---------------------------------
-------------------
insert  into #tmp_chgcde
select   distinct  scd_chgcde  from SHCHGHDR 
left join SHCHGFWD (nolock)  on sch_docno = scf_docno
left join SHCHGDTL (nolock) on sch_docno = scd_docno and scf_fwdnam= scd_fwdnam
where 	 sch_docno = @sch_docno
--		and scf_fwdnam = 'fwd1'
		and scd_venno <> 'TOTAL'

declare @venno8 nvarchar(10)
declare @venno7 nvarchar(10)
declare @venno6 nvarchar(10)
declare @venno5 nvarchar(10)
declare @venno4 nvarchar(10)
declare @venno3 nvarchar(10)
declare @venno2 nvarchar(10)
declare @venno1 nvarchar(10)

--select * from #tmp_venno_top

--declare chgcde_count integer

--if chgcde_count  >= 1 then
--end





set @venno8 = (select top 1 venno from
		(select top 7 venno   as 'venno'  from #tmp_venno_top
				-- by venno desc
		) a  order by venno desc )


set @venno7 = (select top 1 venno  from
		(select top 6 venno  as 'venno' from #tmp_venno_top
			--	order by venno desc
		) b order by venno desc )
if @venno7= @venno8  
begin
set @venno8= ''
end

set @venno6 = (select top 1 venno  from
		(select top 5 venno  as 'venno' from #tmp_venno_top
			--	order by venno desc
		) c order by venno desc )
if @venno6= @venno7  
begin
set @venno7= ''
end


set @venno5 = (select top 1 venno  from
		(select top 4 venno  as 'venno' from #tmp_venno_top
			--	order by venno desc
		) d order by venno desc )
if @venno5= @venno6  
begin
set @venno6= ''
end

set @venno4 = (select top 1 venno  from
		(select top 3 venno  as 'venno' from #tmp_venno_top
			--	order by venno desc
		) e order by venno desc )
if @venno4= @venno5 
begin
set @venno5= ''
end

set @venno3 = (select top 1 venno  from
		(select top 2 venno  as 'venno' from #tmp_venno_top
			--	order by venno desc
		) f order by venno desc )
if @venno3= @venno4  
begin
set @venno4= ''
end

set @venno2 = (select top 1 venno  from
		(select top 1 venno  as 'venno' from #tmp_venno_top
			--	order by venno desc
		) g order by venno desc )
if @venno2= @venno3  
begin
set @venno3= ''
end

--set @venno1 = (select top 1 venno  from
--		(select top 1 venno as 'venno' from #tmp_venno_top
--				--order by venno desc
--		) h order by venno desc )
--if @venno1= @venno2  
--begin
--set @venno2= ''
--end


set @venno1 = 'Total'
-------------------

--select @venno1,@venno2,@venno3,@venno4,@venno5,@venno6,@venno7,@venno8

--------------------------------
DECLARE @fwdID nvarchar(300)
DECLARE @getfwderid CURSOR
SET @getfwderid = CURSOR FOR

SELECT scf_fwdnam
FROM #fwder

OPEN @getfwderid
FETCH NEXT
FROM @getfwderid INTO @fwdID
WHILE @@FETCH_STATUS = 0
BEGIN
------------------main star-----------------
--PRINT @fwdID

insert into #maintable
select 
@fwdID as 'scf_fwdnam',
'0' as  'the_order',
'' as 'chgcde', '' as 'chgdsc',
'' as 'Total' , 
' 攤分數 (' + scf_fcurcde + ')' as  'ft', 
' 攤分數 (HKD)'  as  'rateft', 
''  as 'v1',  v2.vbi_vensna as 'f1',
'' as 'v2', v3.vbi_vensna as 'f2',
'' as 'v3', v4.vbi_vensna as 'f3',
'' as 'v4',  v5.vbi_vensna as 'f4',
'' as 'v5',  v6.vbi_vensna as 'f5',
'' as 'v6', v7.vbi_vensna as 'f6',
 '' as 'v7', v8.vbi_vensna  as 'f7',
'      總計       (HKD)' as  'sum_total',
'      總計       (' + scf_fcurcde + ')'   as  'ratetotal'
 from #tmp_chgcde
left join SYMSHC	on ysc_chgcde = chgcde 
left  join SHCHGHDR on 1=1
left join SHCHGFWD (nolock)  on sch_docno = scf_docno
left join SHCHGDTL d8 (nolock) on sch_docno = d8.scd_docno and scf_fwdnam= d8.scd_fwdnam
				and chgcde=d8.scd_chgcde
				and  d8.scd_venno = @venno8
left join VNBASINF    v8 (nolock)  on 
					v8.vbi_venno = d8.scd_venno
left join SHCHGDTL d7 (nolock) on sch_docno = d7.scd_docno and scf_fwdnam= d7.scd_fwdnam
				and chgcde=d7.scd_chgcde
				and  d7.scd_venno = @venno7
left join VNBASINF    v7 (nolock)  on 
					v7.vbi_venno = d7.scd_venno
left join SHCHGDTL d6 (nolock) on sch_docno = d6.scd_docno and scf_fwdnam= d6.scd_fwdnam
				and chgcde=d6.scd_chgcde
				and  d6.scd_venno = @venno6
left join VNBASINF    v6 (nolock)  on 
					v6.vbi_venno = d6.scd_venno
 left join SHCHGDTL d5 (nolock) on sch_docno = d5.scd_docno and scf_fwdnam= d5.scd_fwdnam
				and chgcde=d5.scd_chgcde
				and  d5.scd_venno = @venno5
left join VNBASINF    v5 (nolock)  on 
					v5.vbi_venno = d5.scd_venno

left join SHCHGDTL d4 (nolock) on sch_docno = d4.scd_docno and scf_fwdnam= d4.scd_fwdnam
				and chgcde=d4.scd_chgcde
				and  d4.scd_venno = @venno4
left join VNBASINF    v4 (nolock)  on 
					v4.vbi_venno = d4.scd_venno
left join SHCHGDTL d3 (nolock) on sch_docno = d3.scd_docno and scf_fwdnam= d3.scd_fwdnam
				and chgcde=d3.scd_chgcde
				and  d3.scd_venno = @venno3
left join VNBASINF    v3 (nolock)  on 
					v3.vbi_venno = d3.scd_venno
left join SHCHGDTL d2 (nolock) on sch_docno = d2.scd_docno and scf_fwdnam= d2.scd_fwdnam
				and chgcde=d2.scd_chgcde
				and  d2.scd_venno = @venno2
left join VNBASINF    v2 (nolock)  on 
					v2.vbi_venno = d2.scd_venno

left join SHCHGDTL d1 (nolock) on sch_docno = d1.scd_docno and scf_fwdnam= d1.scd_fwdnam
				and chgcde=d1.scd_chgcde
				and  d1.scd_venno = @venno1

where 	 sch_docno = @sch_docno
		and scf_fwdnam = @fwdID
	and chgcde = (
			select top 1 scd_chgcde from SHCHGDTL where scd_docno =@sch_docno	and scd_fwdnam = @fwdID
			)	




insert into #maintable

select 
scf_fwdnam as 'scf_fwdnam',
'1' as 'the_order',
   chgcde as 'chgcde', '系統 CBM' as 'chgdsc',
'' as 'Total' , '' as  'ft', '' as  'rateft', 
d2.scd_venno as 'v1',str(d2.scd_syscbm ,10,2) as 'f1',  
d3.scd_venno as 'v2',str(d3.scd_syscbm ,10,2) as 'f2', 
d4.scd_venno as 'v3',str(d4.scd_syscbm ,10,2) as 'f3', 
d5.scd_venno as 'v4',str(d5.scd_syscbm ,10,2) as 'f4',  
d6.scd_venno as 'v5',str(d6.scd_syscbm ,10,2) as 'f5',  
d7.scd_venno as 'v6',str(d7.scd_syscbm ,10,2) as 'f6', 
d8.scd_venno as 'v7', str(d8.scd_syscbm ,10,2) as 'f7', 
'' as  'sum_total',
--'' as  'ratetotal'
str((isnull(d8.scd_syscbm,0)+isnull(d2.scd_syscbm,0)+isnull(d3.scd_syscbm,0)+isnull(d4.scd_syscbm,0)+isnull(d5.scd_syscbm,0)+isnull(d6.scd_syscbm,0)+isnull(d7.scd_syscbm,0))/1,10,2) as 'ratetotal'

--(d1.scd_syscbm ,10,2)+d2.scd_syscbm ,10,2)+d3.scd_syscbm ,10,2)+d4.scd_syscbm ,10,2)+d5.scd_syscbm ,10,2)+d6.scd_syscbm ,10,2)+d7.scd_syscbm ,10,2)) as 'sum_total',
--d1.scd_syscbm +d2.scd_syscbm +d3.scd_syscbm ,10,2)+d4.scd_syscbm ,10,2)+d5.scd_syscbm ,10,2)+d6.scd_syscbm ,10,2)+d7.scd_syscbm ,10,2))/scf_exrate as 'ratetotal'

 from #tmp_chgcde
left join SYMSHC	on ysc_chgcde = chgcde 
left  join SHCHGHDR on 1=1
left join SHCHGFWD (nolock)  on sch_docno = scf_docno
left join SHCHGDTL d8 (nolock) on sch_docno = d8.scd_docno and scf_fwdnam= d8.scd_fwdnam
				and chgcde=d8.scd_chgcde
				and  d8.scd_venno = @venno8
left join SHCHGDTL d7 (nolock) on sch_docno = d7.scd_docno and scf_fwdnam= d7.scd_fwdnam
				and chgcde=d7.scd_chgcde
				and  d7.scd_venno = @venno7
left join SHCHGDTL d6 (nolock) on sch_docno = d6.scd_docno and scf_fwdnam= d6.scd_fwdnam
				and chgcde=d6.scd_chgcde
				and  d6.scd_venno = @venno6
 left join SHCHGDTL d5 (nolock) on sch_docno = d5.scd_docno and scf_fwdnam= d5.scd_fwdnam
				and chgcde=d5.scd_chgcde
				and  d5.scd_venno = @venno5
left join SHCHGDTL d4 (nolock) on sch_docno = d4.scd_docno and scf_fwdnam= d4.scd_fwdnam
				and chgcde=d4.scd_chgcde
				and  d4.scd_venno = @venno4
left join SHCHGDTL d3 (nolock) on sch_docno = d3.scd_docno and scf_fwdnam= d3.scd_fwdnam
				and chgcde=d3.scd_chgcde
				and  d3.scd_venno = @venno3
left join SHCHGDTL d2 (nolock) on sch_docno = d2.scd_docno and scf_fwdnam= d2.scd_fwdnam
				and chgcde=d2.scd_chgcde
				and  d2.scd_venno = @venno2

left join SHCHGDTL d1 (nolock) on sch_docno = d1.scd_docno and scf_fwdnam= d1.scd_fwdnam
				and chgcde=d1.scd_chgcde
				and  d1.scd_venno = @venno1
where 	 sch_docno = @sch_docno
		and scf_fwdnam = @fwdID
	and chgcde = (
			select top 1 scd_chgcde from SHCHGDTL where scd_docno =@sch_docno	and scd_fwdnam = @fwdID
			)	




insert into #maintable

select  
scf_fwdnam as 'scf_fwdnam',
'2' as 'the_order',
 chgcde as 'chgcde', '實際 CBM' as 'chgdsc',
'' as 'Total' , '' as  'ft', '' as  'rateft', 
d2.scd_venno as 'v1',str(d2.scd_mancbm ,10,2)as 'f1',  
d3.scd_venno as 'v2',str(d3.scd_mancbm ,10,2)as 'f2', 
d4.scd_venno as 'v3',str(d4.scd_mancbm ,10,2)as 'f3', 
d5.scd_venno as 'v4',str(d5.scd_mancbm ,10,2)as 'f4',  
d6.scd_venno as 'v5',str(d6.scd_mancbm ,10,2)as 'f5',  
d7.scd_venno as 'v6',str(d7.scd_mancbm ,10,2)as 'f6', 
d8.scd_venno as 'v7', str(d8.scd_mancbm ,10,2)as 'f7', 
'' as  'sum_total',
--'' as  'ratetotal'
str((isnull(d8.scd_mancbm,0)+isnull(d2.scd_mancbm,0)+isnull(d3.scd_mancbm,0)+isnull(d4.scd_mancbm,0)+isnull(d5.scd_mancbm,0)+isnull(d6.scd_mancbm,0)+isnull(d7.scd_mancbm,0))/1,10,2) as 'ratetotal'

--(d1.scd_mancbm+d2.scd_mancbm+d3.scd_mancbm+d4.scd_mancbm+d5.scd_mancbm+d6.scd_mancbm+d7.scd_mancbm) as 'sum_total',
--(d1.scd_mancbm+d2.scd_mancbm+d3.scd_mancbm+d4.scd_mancbm+d5.scd_mancbm+d6.scd_mancbm+d7.scd_mancbm)/scf_exrate as 'ratetotal'
 from #tmp_chgcde
left join SYMSHC	on ysc_chgcde = chgcde 
left  join SHCHGHDR on 1=1
left join SHCHGFWD (nolock)  on sch_docno = scf_docno
left join SHCHGDTL d8 (nolock) on sch_docno = d8.scd_docno and scf_fwdnam= d8.scd_fwdnam
				and chgcde=d8.scd_chgcde
				and  d8.scd_venno = @venno8
left join SHCHGDTL d7 (nolock) on sch_docno = d7.scd_docno and scf_fwdnam= d7.scd_fwdnam
				and chgcde=d7.scd_chgcde
				and  d7.scd_venno = @venno7
left join SHCHGDTL d6 (nolock) on sch_docno = d6.scd_docno and scf_fwdnam= d6.scd_fwdnam
				and chgcde=d6.scd_chgcde
				and  d6.scd_venno = @venno6
 left join SHCHGDTL d5 (nolock) on sch_docno = d5.scd_docno and scf_fwdnam= d5.scd_fwdnam
				and chgcde=d5.scd_chgcde
				and  d5.scd_venno = @venno5
left join SHCHGDTL d4 (nolock) on sch_docno = d4.scd_docno and scf_fwdnam= d4.scd_fwdnam
				and chgcde=d4.scd_chgcde
				and  d4.scd_venno = @venno4
left join SHCHGDTL d3 (nolock) on sch_docno = d3.scd_docno and scf_fwdnam= d3.scd_fwdnam
				and chgcde=d3.scd_chgcde
				and  d3.scd_venno = @venno3
left join SHCHGDTL d2 (nolock) on sch_docno = d2.scd_docno and scf_fwdnam= d2.scd_fwdnam
				and chgcde=d2.scd_chgcde
				and  d2.scd_venno = @venno2

left join SHCHGDTL d1 (nolock) on sch_docno = d1.scd_docno and scf_fwdnam= d1.scd_fwdnam
				and chgcde=d1.scd_chgcde
				and  d1.scd_venno = @venno1
where 	 sch_docno = @sch_docno
		and scf_fwdnam = @fwdID
	and chgcde = (
			select top 1 scd_chgcde from SHCHGDTL where scd_docno =@sch_docno	and scd_fwdnam = @fwdID
			)	







insert into #maintable

select 
@fwdID as 'scf_fwdnam',
'3' as 'the_order',
'' as 'chgcde', '' as 'chgdsc',
'' as 'Total' ,'' as  'ft', '' as  'rateft', 
'' as 'v1','' as  'f1',  
'' as 'v2','' as  'f2', 
'' as 'v3','' as  'f3', 
'' as 'v4','' as  'f4',  
'' as 'v5','' as  'f5',  
'' as 'v6','' as  'f6', 
'' as 'v7', '' as  'f7', 
'' as  'sum_total',
'' as  'ratetotal'


insert into #maintable

select 
scf_fwdnam as 'scf_fwdnam',
'4' as 'the_order',
chgcde as 'chgcde', ysc_chgdsc as 'chgdsc',
d1.scd_venno as 'Total' ,Str(d1.scd_fee ,10,2) as 'ft', str(d1.scd_fee *scf_exrate,10,2)  as 'rateft', 
d2.scd_venno as 'v1',str(d2.scd_fee ,10,2)  as 'f1',  
d3.scd_venno as 'v2',str(d3.scd_fee ,10,2)  as 'f2', 
d4.scd_venno as 'v3',str(d4.scd_fee ,10,2)  as 'f3', 
d5.scd_venno as 'v4',str(d5.scd_fee ,10,2)  as 'f4',  
d6.scd_venno as 'v5',str(d6.scd_fee ,10,2)  as 'f5',  
d7.scd_venno as 'v6',str(d7.scd_fee ,10,2)  as 'f6', 
d8.scd_venno as 'v7', str(d8.scd_fee ,10,2)  as 'f7', 
str((isnull(d８.scd_fee,0)+isnull(d2.scd_fee,0)+isnull(d3.scd_fee,0)+isnull(d4.scd_fee,0)+isnull(d5.scd_fee,0)+isnull(d6.scd_fee,0)+isnull(d7.scd_fee,0)),10,2) as 'sum_total',
str((isnull(d８.scd_fee,0)+isnull(d2.scd_fee,0)+isnull(d3.scd_fee,0)+isnull(d4.scd_fee,0)+isnull(d5.scd_fee,0)+isnull(d6.scd_fee,0)+isnull(d7.scd_fee,0))/scf_exrate,10,2) as 'ratetotal'
 from #tmp_chgcde
left join SYMSHC	on ysc_chgcde = chgcde 
left  join SHCHGHDR on 1=1
left join SHCHGFWD (nolock)  on sch_docno = scf_docno
left join SHCHGDTL d8 (nolock) on sch_docno = d8.scd_docno and scf_fwdnam= d8.scd_fwdnam
				and chgcde=d8.scd_chgcde
				and  d8.scd_venno = @venno8
left join SHCHGDTL d7 (nolock) on sch_docno = d7.scd_docno and scf_fwdnam= d7.scd_fwdnam
				and chgcde=d7.scd_chgcde
				and  d7.scd_venno = @venno7
left join SHCHGDTL d6 (nolock) on sch_docno = d6.scd_docno and scf_fwdnam= d6.scd_fwdnam
				and chgcde=d6.scd_chgcde
				and  d6.scd_venno = @venno6
 left join SHCHGDTL d5 (nolock) on sch_docno = d5.scd_docno and scf_fwdnam= d5.scd_fwdnam
				and chgcde=d5.scd_chgcde
				and  d5.scd_venno = @venno5
left join SHCHGDTL d4 (nolock) on sch_docno = d4.scd_docno and scf_fwdnam= d4.scd_fwdnam
				and chgcde=d4.scd_chgcde
				and  d4.scd_venno = @venno4
left join SHCHGDTL d3 (nolock) on sch_docno = d3.scd_docno and scf_fwdnam= d3.scd_fwdnam
				and chgcde=d3.scd_chgcde
				and  d3.scd_venno = @venno3
left join SHCHGDTL d2 (nolock) on sch_docno = d2.scd_docno and scf_fwdnam= d2.scd_fwdnam
				and chgcde=d2.scd_chgcde
				and  d2.scd_venno = @venno2

left join SHCHGDTL d1 (nolock) on sch_docno = d1.scd_docno and scf_fwdnam= d1.scd_fwdnam
				and chgcde=d1.scd_chgcde
				and  d1.scd_venno = @venno1
where 	 sch_docno = @sch_docno
		and scf_fwdnam = @fwdID
and (isnull(d８.scd_fee,0)+isnull(d2.scd_fee,0)+isnull(d3.scd_fee,0)+isnull(d4.scd_fee,0)+isnull(d5.scd_fee,0)+isnull(d6.scd_fee,0)+isnull(d7.scd_fee,0))/scf_exrate <> 0

	/*		and not (d1.scd_fee ,10,2) is null 
			and d2.scd_fee ,10,2) is null 
			and d3.scd_fee ,10,2) is null 
			and d4.scd_fee ,10,2) is null 
			and d5.scd_fee ,10,2) is null 
			and d6.scd_fee ,10,2) is null 
			and d7.scd_fee ,10,2) is null 
			and d8.scd_fee ,10,2) is null 
			)   		*/



insert into #maintable

select 
@fwdID as 'scf_fwdnam',
'5' as 'the_order',
'' as 'chgcde', '' as 'chgdsc',
'' as 'Total' ,'' as  'ft', '' as  'rateft', 
'' as 'v1','' as  'f1',  
'' as 'v2','' as  'f2', 
'' as 'v3','' as  'f3', 
'' as 'v4','' as  'f4',  
'' as 'v5','' as  'f5',  
'' as 'v6','' as  'f6', 
'' as 'v7', '' as  'f7', 
'' as  'sum_total',
'' as  'ratetotal'

insert into #maintable

select 
scf_fwdnam as 'scf_fwdnam',
'6' as 'the_order',
'' as 'chgcde', '合計' as 'chgdsc',
'' as 'Total' ,str(sum(d1.scd_fee),10,2) as 'ft', str(sum(d1.scd_fee*scf_exrate),10,2) as 'rateft', 
'' as 'v1',isnull(str(sum(d2.scd_fee),10,2),'') as 'f1',  
'' as 'v2',isnull(str(sum(d3.scd_fee),10,2),'') as 'f2', 
'' as 'v3',isnull(str(sum(d4.scd_fee),10,2),'')  as 'f3', 
'' as 'v4',isnull(str(sum(d5.scd_fee),10,2),'')  as 'f4',  
'' as 'v5',isnull(str(sum(d6.scd_fee),10,2),'')  as 'f5',  
'' as 'v6',isnull(str(sum(d7.scd_fee),10,2),'')  as 'f6', 
'' as 'v7', isnull(str(sum(d8.scd_fee),10,2),'')  as 'f7', 
str(sum((isnull(d８.scd_fee,0)+isnull(d2.scd_fee,0)+isnull(d3.scd_fee,0)+isnull(d4.scd_fee,0)+isnull(d5.scd_fee,0)+isnull(d6.scd_fee,0)+isnull(d7.scd_fee,0))),10,2) as 'sum_total',
str(sum((isnull(d８.scd_fee,0)+isnull(d2.scd_fee,0)+isnull(d3.scd_fee,0)+isnull(d4.scd_fee,0)+isnull(d5.scd_fee,0)+isnull(d6.scd_fee,0)+isnull(d7.scd_fee,0)))/scf_exrate,10,2) as 'ratetotal'
 from #tmp_chgcde
left join SYMSHC	on ysc_chgcde = chgcde 
left  join SHCHGHDR on 1=1
left join SHCHGFWD (nolock)  on sch_docno = scf_docno
left join SHCHGDTL d8 (nolock) on sch_docno = d8.scd_docno and scf_fwdnam= d8.scd_fwdnam
				and chgcde=d8.scd_chgcde
				and  d8.scd_venno = @venno8
left join SHCHGDTL d7 (nolock) on sch_docno = d7.scd_docno and scf_fwdnam= d7.scd_fwdnam
				and chgcde=d7.scd_chgcde
				and  d7.scd_venno = @venno7
left join SHCHGDTL d6 (nolock) on sch_docno = d6.scd_docno and scf_fwdnam= d6.scd_fwdnam
				and chgcde=d6.scd_chgcde
				and  d6.scd_venno = @venno6
 left join SHCHGDTL d5 (nolock) on sch_docno = d5.scd_docno and scf_fwdnam= d5.scd_fwdnam
				and chgcde=d5.scd_chgcde
				and  d5.scd_venno = @venno5
left join SHCHGDTL d4 (nolock) on sch_docno = d4.scd_docno and scf_fwdnam= d4.scd_fwdnam
				and chgcde=d4.scd_chgcde
				and  d4.scd_venno = @venno4
left join SHCHGDTL d3 (nolock) on sch_docno = d3.scd_docno and scf_fwdnam= d3.scd_fwdnam
				and chgcde=d3.scd_chgcde
				and  d3.scd_venno = @venno3
left join SHCHGDTL d2 (nolock) on sch_docno = d2.scd_docno and scf_fwdnam= d2.scd_fwdnam
				and chgcde=d2.scd_chgcde
				and  d2.scd_venno = @venno2

left join SHCHGDTL d1 (nolock) on sch_docno = d1.scd_docno and scf_fwdnam= d1.scd_fwdnam
				and chgcde=d1.scd_chgcde
				and  d1.scd_venno = @venno1
where 	 sch_docno = @sch_docno
		and scf_fwdnam = @fwdID
		group by scf_fwdnam,scf_exrate
/*		and not (d1.scd_fee is null 
			and d2.scd_fee is null 
			and d3.scd_fee is null 
			and d4.scd_fee is null 
			and d5.scd_fee is null 
			and d6.scd_fee is null 
			and d7.scd_fee is null 
			and d8.scd_fee is null 
			) 
  		*/


------------------main-----------------
FETCH NEXT
FROM @getfwderid INTO @fwdID
END
CLOSE @getfwderid
DEALLOCATE @getfwderid
--------------------------------

-------------------

select 
scf_fwdnam as 'scf_fwdnam', 
the_order  as 'the_order', 
chgcde as 'chgcde',  
chgdsc as 'chgdsc',  
Total  as 'Total',  
ft  as 'ft',   
rateft  as 'rateft',   
v1  as 'v1',  
f1 as 'f1',
v2 as 'v2',
f2 as 'f2', 
v3  as 'v3', 
f3  as 'f3', 
v4  as 'v4', 
f4  as 'f4', 
v5  as 'v5', 
f5  as 'f5', 
v6  as 'v6', 
f6  as 'f6', 
v7  as 'v7', 
f7  as 'f7', 
ratetotal as 'sum_total',
sum_total as 'ratetotal'

--sum_total ,
--ratetotal


 from #maintable
 order by scf_fwdnam,the_order

drop table #spt_table
drop table #tmp_venno
drop table #tmp_venno_top
drop table #tmp_chgcde
drop table #fwder
END











GO
GRANT EXECUTE ON [dbo].[sp_select_SHR00010_sub] TO [ERPUSER] AS [dbo]
GO
