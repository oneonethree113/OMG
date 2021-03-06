/****** Object:  StoredProcedure [dbo].[sp_select_PGM00007_check]    Script Date: 09/29/2017 15:29:09 ******/
DROP PROCEDURE [dbo].[sp_select_PGM00007_check]
GO
/****** Object:  StoredProcedure [dbo].[sp_select_PGM00007_check]    Script Date: 09/29/2017 15:29:10 ******/
SET ANSI_NULLS OFF
GO
SET QUOTED_IDENTIFIER ON
GO






--sp_select_PGM00007_check 'UCP', 'KP1400167,KP1400168'

create PROCEDURE [dbo].[sp_select_PGM00007_check] 
@cocde as nvarchar(6),
@ordnolist as nvarchar(2000)

AS

BEGIN

create table #TEMP_INIT (tmp_init nvarchar(1000)) on [PRIMARY]

create table #TEMP_ORDNO (tmp_ordno nvarchar(20)) on [PRIMARY]

declare	@fm nvarchar(100), @to nvarchar(100)

declare @strPart nvarchar(1000), @strRemain nvarchar(1000)

set @fm = ''
set @to = ''
set @strPart = ''
set @strRemain = ''


--#TEMP_ORDNO
if ltrim(rtrim(@ordnolist)) <> ''
begin
	delete from #TEMP_INIT
	set @strRemain = @ordnolist
	while charindex(',', @strRemain) <> 0
	begin
		set @strPart = ltrim(left(@strRemain, charindex(',', @strRemain)-1))
		set @strRemain = right(@strRemain, len(@strRemain) - charindex(',', @strRemain))
		if charindex('~', @strPart) <> 0 
		begin
			set @fm = ltrim(left(@strPart, charindex('~', @strPart)-1))
			set @to = right(@strPart, len(@strPart) - charindex('~', @strPart))
			insert into #TEMP_INIT
			select poh_ordno from PKORDHDR (nolock) where poh_ordno between @fm and @to
		end
		else if charindex('%', @strPart) <> 0
		begin
			insert into #TEMP_INIT
			select poh_ordno from PKORDHDR (nolock) where poh_ordno like @strPart
		end
		else
		begin
			insert into #TEMP_INIT values (@strPart)
		end
	end
	if charindex(',',@strRemain) = 0
	begin
		set @strRemain = ltrim(@strRemain)
		if charindex('~', @strRemain) <> 0 
		begin
			set @fm = ltrim(left(@strRemain, charindex('~', @strRemain)-1))
			set @to = right(@strRemain, len(@strRemain) - charindex('~', @strRemain))
			insert into #TEMP_INIT
			select poh_ordno from PKORDHDR where poh_ordno between @fm and @to
		end
		else if charindex('%', @strRemain) <> 0
		begin
			insert into #TEMP_INIT
			select poh_ordno from PKORDHDR where poh_ordno like @strRemain
		end
		else
		begin
			insert into #TEMP_INIT values (@strRemain)
		end
	end
	insert into #TEMP_ORDNO
	select distinct tmp_init from #TEMP_INIT
end









declare @delivery nvarchar(500)

create table #TEMP_POSEQ
(
tmp_ordno	nvarchar(20),
tmp_seq		int,
tmp_delivery	nvarchar(500),
tmp_address	nvarchar(2000)
)

insert into #TEMP_POSEQ
select pod_ordno, pod_seq, '  ', '  '
from #TEMP_ORDNO
left join pkorddtl on pod_ordno = tmp_ordno
--where pod_ordno in (@ordno)

select 
pod_ordno, pod_seq, poh_shpstr,poh_fty,poh_dremark, 
pod_shpstr,pod_fty,pod_Conmak, pms_shpstrdat,pms_shpqty, pms_fty,pms_remark
into #TEMP_DELIVERY
from 
#TEMP_POSEQ
left join pkorddtl on pod_ordno = tmp_ordno and pod_seq = tmp_seq
left join pkordhdr  on pod_ordno = poh_ordno
left join pkmtlshp on pms_ordno = pod_ordno and pms_ordseq = pod_seq

create table #TEMP_FTY_LIST
(
	tmp_fty	nvarchar(200)
)

declare 
@pod_ordno nvarchar(20),
@pod_seq int,
@poh_shpstr datetime,
@poh_fty nvarchar(200),
@poh_dremark nvarchar(200),
@pod_shpstr datetime,
@pod_fty nvarchar(200),
@pod_Conmak nvarchar(200),
@pms_shpstrdat datetime,
@pms_shpqty int,
@pms_fty nvarchar(200),
@pms_remark nvarchar(200)

declare @last_ordno nvarchar(20), @last_seq int

set @last_ordno = ''
set @last_seq = 0
set @delivery = ''

declare @ftyname nvarchar(200)
set @ftyname = ''
/*
select 
pod_ordno, pod_seq, poh_shpstr,poh_fty, pod_shpstr,pod_fty, pms_shpstrdat,pms_shpqty, pms_fty
from #TEMP_DELIVERY
*/
declare cur_delivery cursor
for
select 
pod_ordno, pod_seq, poh_shpstr,poh_fty,poh_dremark, pod_shpstr,pod_fty,pod_Conmak, pms_shpstrdat,pms_shpqty, pms_fty,pms_remark
from #TEMP_DELIVERY

open cur_delivery
fetch next from cur_delivery into
@pod_ordno,
@pod_seq,
@poh_shpstr,
@poh_fty,
@poh_dremark,
@pod_shpstr,
@pod_fty,
@pod_Conmak,
@pms_shpstrdat,
@pms_shpqty,
@pms_fty,
@pms_remark

while @@fetch_status = 0
begin
	if @last_ordno <> @pod_ordno or @last_seq <> @pod_seq
	begin
		update #TEMP_POSEQ set tmp_delivery = @delivery where tmp_ordno = @last_ordno and tmp_seq = @last_seq
		set @delivery = ''
	end




--	if @pms_fty <> '' and @pms_fty is not null
	if @pms_fty <> '' and @pms_fty is not null and @pms_shpstrdat <>'1900-01-01'
	begin
		select @ftyname = vbi_vensna from VNBASINF where vbi_venno = @pms_fty

		set @delivery = @delivery + '
'
+ '
'
+ convert(varchar(2),month(@pms_shpstrdat)) + '月' + right(convert(varchar(10),@pms_shpstrdat,111),2) + '日' + ' ( '  + convert(varchar(10),@pms_shpqty) + ' PCS ) ' + '
'
+ @ftyname + '
'
+@pms_remark

		insert into #TEMP_FTY_LIST
		select @pms_fty
	end
	else if @pod_fty <> '' and @pod_shpstr <> '1900-01-01'
	begin

		select @ftyname = vbi_vensna from VNBASINF where vbi_venno = @pod_fty

		set @delivery = @delivery + '
'
+ '
'
+ convert(varchar(2),month(@pod_shpstr)) + '月' + right(convert(varchar(10),@pod_shpstr,111),2) + '日'+ '
'
+ @ftyname + '
'
+@pod_Conmak

		insert into #TEMP_FTY_LIST
		select @pod_fty
	end
	else
	begin
	if @poh_shpstr <> '1900-01-01'
	begin
		select @ftyname = vbi_vensna from VNBASINF where vbi_venno = @poh_fty

		set @delivery = @delivery + '
'
+ '
'
+ convert(varchar(2),month(@poh_shpstr)) + '月' + right(convert(varchar(10),@poh_shpstr,111),2) + '日'+ '
'
+ @ftyname + '
'
--+
--@poh_dremark

		insert into #TEMP_FTY_LIST
		select @poh_fty
	end
	end

	set @last_ordno = @pod_ordno
	set @last_seq = @pod_seq

fetch next from cur_delivery into
@pod_ordno,
@pod_seq,
@poh_shpstr,
@poh_fty,
@poh_dremark,
@pod_shpstr,
@pod_fty,
@pod_Conmak,
@pms_shpstrdat,
@pms_shpqty,
@pms_fty,
@pms_remark

end

close cur_delivery
deallocate cur_delivery



update #TEMP_POSEQ set tmp_delivery = @delivery where tmp_ordno = @last_ordno and tmp_seq = @last_seq



declare 
@vci_cntctp nvarchar(50),
@vci_cntphn nvarchar(50),
@vci_adr nvarchar(500),
@ftycde nvarchar(20),
@address nvarchar(2000)

set @vci_cntctp = ''
set @vci_cntphn = ''
set @vci_adr = ''
set @ftycde = ''
set @address = ''
set @ftyname = ''

--select * from #TEMP_FTY_LIST
declare cur_adr cursor
for
select distinct tmp_fty from #TEMP_FTY_LIST

open cur_adr
fetch next from cur_adr into @ftycde

while @@fetch_status = 0
begin

select @ftyname = vbi_vensna from VNBASINF where vbi_venno = @ftycde

select @vci_adr = vci_chnadr from VNCNTINF where vci_cnttyp = 'M' and vci_venno = @ftycde
select @vci_cntctp = vci_cntctp, @vci_cntphn = vci_cntphn from VNCNTINF where vci_cntdef = 'Y' and vci_venno = @ftycde


set @address = @address + '
'
+ @ftyname + '
'
+ @vci_adr + '
'
+ @vci_cntctp + '
'
+ @vci_cntphn + '
'

fetch next from cur_adr into @ftycde
end

close cur_adr
deallocate cur_adr



declare @po_remark nvarchar(2000)
declare @tmp_ordno nvarchar(20)
declare @tmp_remark nvarchar(2000)
set @po_remark = ''
set @tmp_ordno = ''
set @tmp_remark = ''

declare cur_po_remark cursor
for
select distinct poh_ordno, poh_dremark
from #TEMP_ORDNO
left join pkordhdr on tmp_ordno = poh_ordno

open cur_po_remark 
fetch next from cur_po_remark into @tmp_ordno, @tmp_remark

while @@fetch_status = 0
begin

if @tmp_remark <> ''
begin
set @po_remark = @po_remark + '[' + @tmp_ordno + ']' + '
' + @tmp_remark + '
'
end

fetch next from cur_po_remark into @tmp_ordno, @tmp_remark
end

close cur_po_remark
deallocate cur_po_remark


declare @counter int
set @counter = 0

select distinct poh_pkgven  
into #TEMP_PKGVEN
from #TEMP_ORDNO ord
left join pkordhdr on ord.tmp_ordno = poh_ordno

select @counter = count(*) from #TEMP_PKGVEN



if @counter = 1
begin


select 
distinct
yco_conam,
yco_addr, 
yco_logoimgpth ,
'Tel:' + yco_phoneno + 'Fax ' + yco_faxno as 'Tel',
--Company Logo
poh_Pkgven, 
hdr.vbi_vensna as 'headerVen' , 
poh_address , 
poh_ctnper , 
poh_tel , 
poh_ordno , 
poh_issdat , 
poh_revdat ,  			--Header
pod_seq , 
pod_pkgitm , 
pod_chndsc,
pod_engdsc,
pod_clrfot,
pod_clrbck,
pod_matral,
pod_matDsc,
pod_prtmtd,
pod_finish,
pod_tiknes,
pod_prtDsc,
--convert(varchar(20),convert(int,pib_FInchL)) + '"x' + convert(varchar(20),convert(int,pib_FInchW)) + '"x' + convert(varchar(20),convert(int,pib_FInchH)) + '"' as 'pib_FinchL'  , 
--convert(varchar(20),convert(int,pib_EInchL)) + '"x' + convert(varchar(20),convert(int,pib_EInchW)) + '"x' + convert(varchar(20),convert(int,pib_EInchH)) + '"' as 'pib_EinchL' , 
convert(varchar(20),pib_FInchL) + '"x' + convert(varchar(20),pib_FInchW) + '"x' + convert(varchar(20),pib_FInchH) + '"' as 'pib_FinchL'  , 
convert(varchar(20),pib_EInchL) + '"x' + convert(varchar(20),pib_EInchW) + '"x' + convert(varchar(20),pib_EInchH) + '"' as 'pib_EinchL' , 
pod_ttlordqty , 
case poh_GenFlag when 'TA' then 0 else  pod_untprc end as 'pod_untprc' , 
pod_ttlamtqty ,
pib_img, 
pod_shpstr , 
pod_fty , 
isnull(dtl.vbi_vensna,'')as'DetailVen' ,
@po_remark as 'poh_dremark' ,
isnull(yup_usrnam,'') as 'pod_creusr',
'('+ pod_curcde + ')' as 'pod_curcde',
isnull(cbi_cussna,'') as 'pod_customer',
tmp_delivery as 'pod_delivery',
@address as 'pod_address',
poh_ttlamt,
poh_Delamt,
poh_TtlDelamt,
poh_ver,
'' as 'REVISED'

from 
#TEMP_ORDNO ord
left join pkordhdr on ord.tmp_ordno = poh_ordno
left join pkorddtl on pod_ordno = poh_ordno
--left join cubasinf on poh_cus1no = cbi_cusno
--left join SYPAKCAT on pod_cate = ypc_code
left join vnbasinf  hdr on hdr.vbi_venno = poh_Pkgven
left join sycominf on @cocde = yco_cocde
left join vnbasinf dtl on dtl.vbi_venno = pod_fty
left join pkimbaif on pib_pgitmno = pod_pkgitm
left join #TEMP_POSEQ poseq on poseq.tmp_ordno = pod_ordno and poseq.tmp_seq = pod_seq
left join pkreqdtl on prd_ordno = pod_ordno and prd_ordseq = pod_seq
left join pkreqhdr on prh_reqno = prd_reqno
left join cubasinf on prh_cus1no = cbi_cusno
left join syusrprf on pod_creusr = yup_usrid
where poh_pkgven is not null

--where poh_ordno = @ordno and poh_cocde = @cocde 
--where poh_status = 'APV'

--order by pod_ordno,pod_seq

end
else
begin
	select 'XXX' as 'yco_conam', 'Selected PO with different Printer Co. Please check!' as 'message'
end


drop table #TEMP_POSEQ
drop table #TEMP_DELIVERY
drop table #TEMP_FTY_LIST
drop table #TEMP_INIT
drop table #TEMP_ORDNO
drop table #TEMP_PKGVEN


END


GRANT EXECUTE ON [dbo].[sp_select_PGM00007_check]    TO [ERPUSER] AS [dbo]

GO
