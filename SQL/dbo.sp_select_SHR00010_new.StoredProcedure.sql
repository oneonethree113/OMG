/****** Object:  StoredProcedure [dbo].[sp_select_SHR00010_new]    Script Date: 09/29/2017 15:29:09 ******/
DROP PROCEDURE [dbo].[sp_select_SHR00010_new]
GO
/****** Object:  StoredProcedure [dbo].[sp_select_SHR00010_new]    Script Date: 09/29/2017 15:29:10 ******/
SET ANSI_NULLS OFF
GO
SET QUOTED_IDENTIFIER OFF
GO





Create        procedure [dbo].[sp_select_SHR00010_new]
@sch_cocde	nvarchar(6),
@sch_docno	nvarchar(20)

 
AS

BEGIN

declare @custlist  nvarchar(3000)
declare @cus_name nvarchar(3000)

create TABLE #spt_table
(splitdata NVARCHAR(3000) )

create TABLE #tmp_venno
(venno NVARCHAR(10),
scd_credat  datetime
 )

create TABLE #tmp_venno_top
(venno NVARCHAR(10) )

create TABLE #tmp_chgcde
(chgcde NVARCHAR(30) )

declare @string  nvarchar(1000)
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




select
sch_docno as 'sch_docno',
sch_typ as 'sch_typ',
scf_fwdnam as 'sch_fwdnam',
scf_fcrno as 'sch_fcrno',
scf_fwdinv as 'sch_fwdinv',
scf_fcurcde as 'sch_fcurcde',
sch_curcde as 'sch_curcde',
scf_exrate as 'sch_exchrat',
@custlist as 'sch_cuslst',
sch_invlst as 'sch_invlst',
sch_ctrcfs as 'sch_ctrcfs',
sch_ctrsiz as 'sch_ctrsiz',
sch_etddat as 'sch_etddat',
sch_pckdat as 'sch_pckdat',
rtrim(ltrim(scf_rmk)) as 'sch_rmk',
sch_creusr as 'sch_creusr',
sch_updusr as 'sch_updusr',
sch_credat as 'sch_credat',
sch_upddat as 'sch_upddat'
from SHCHGHDR 
left join SHCHGFWD (nolock)  on sch_docno = scf_docno
where 	 sch_docno = @sch_docno
--		and scf_fwdnam = 'FWD2'
		
	/*		and not (d1.scd_fee is null 
			and d2.scd_fee is null 
			and d3.scd_fee is null 
			and d4.scd_fee is null 
			and d5.scd_fee is null 
			and d6.scd_fee is null 
			and d7.scd_fee is null 
			and d8.scd_fee is null 
			)   		*/





-------------------
drop table #spt_table
drop table #tmp_venno
drop table #tmp_venno_top
drop table #tmp_chgcde
END







GO
GRANT EXECUTE ON [dbo].[sp_select_SHR00010_new] TO [ERPUSER] AS [dbo]
GO
