/****** Object:  StoredProcedure [dbo].[sp_select_abc_excel]    Script Date: 09/29/2017 15:29:09 ******/
DROP PROCEDURE [dbo].[sp_select_abc_excel]
GO
/****** Object:  StoredProcedure [dbo].[sp_select_abc_excel]    Script Date: 09/29/2017 15:29:10 ******/
SET ANSI_NULLS OFF
GO
SET QUOTED_IDENTIFIER OFF
GO






--sp_select_abc_excel 'UCP', 'KP1400167,KP1400168'

CREATE PROCEDURE [dbo].[sp_select_abc_excel] 
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
			select poh_ordno from PKORDHDR (nolock) where poh_cocde = @cocde and  poh_ordno between @fm and @to
		end
		else if charindex('%', @strPart) <> 0
		begin
			insert into #TEMP_INIT
			select poh_ordno from PKORDHDR (nolock) where poh_cocde = @cocde and   poh_ordno like @strPart
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
			select poh_ordno from PKORDHDR where  poh_cocde = @cocde and  poh_ordno between @fm and @to
		end
		else if charindex('%', @strRemain) <> 0
		begin
			insert into #TEMP_INIT
			select poh_ordno from PKORDHDR where  poh_cocde = @cocde and  poh_ordno like @strRemain
		end
		else
		begin
			insert into #TEMP_INIT --values (@strRemain)
			select poh_ordno from PKORDHDR where  poh_cocde = @cocde and  poh_ordno = @strRemain
		end
	end
	insert into #TEMP_ORDNO
	select distinct tmp_init from #TEMP_INIT
end


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
pk.pod_ordno as 'Pkg No',
pk.pod_seq as 'Pkg Seq',
pk.pod_pkgitm as 'Pkg Item',
pk.pod_engdsc as 'Desc',

isnull(pgs_item,'') as 'Product Item',
isnull(pgs_assitm,'') as 'Assorted Item',
isnull(pgs_tmpitm,'') as 'Product Temp Item',
isnull(pgs_venitm,'') as 'Product Vendor Item',
--isnull(pgs_custitm,'') as 'Customer Item No',
--isnull(pgs_sku,'') as 'SKU',
case isnull(pgs_assitm,'') when '' then isnull(sod_cusitm,'') else isnull(sai_cusitm,'') end as 'Customer Item No',
case isnull(pgs_assitm,'') when '' then isnull(sod_cussku,'') else isnull(sai_cussku,'') end as 'SKU',
case isnull(pgs_assitm,'') when '' then isnull(sod_cusstyno,'') else isnull(sai_cusstyno,'') end as 'Customer Style No',

isnull(sod_seccusitm, '') as 'Sec Cust Item',
isnull(sod_itmdsc, '') as 'Sales Confirmation Item Desc',
isnull(sod_cuscol, '') as 'Cust Color',

isnull(convert(char(30),' ' + sod_code1), '') as 'Barcode(Merchandise)',
isnull(convert(char(30),sod_code2), '') as 'Barcode(Inner)',
isnull(convert(char(30),sod_code3), '') as 'Barcode(Carton)',
isnull(convert(char(30),sai_upcean), '') as 'Assorted Barcode',

isnull(sod_cusven + cv.vbi_vensna,'') as 'CV',
isnull(sod_venno + pv.vbi_vensna,'') as 'PV',

isnull(sod_ordno,'') as 'SC No',
isnull(sod_ordseq,0) as 'SC Seq',
isnull(po.pod_purord,'') as 'PO No',
isnull(po.pod_purseq,0) as 'PO Seq',
isnull(po.pod_jobord,'') as 'Job No',
isnull(tod_toordno, '') as 'TO No',
isnull(tod_toordseq,0) as 'TO Seq',

isnull(sod_cususdcur,'') as 'Retail 1 Curr',
isnull(sod_cususd,0) as 'Retail 1',

isnull(sod_cuscadcur,'') as 'Retail 2 Curr',
isnull(sod_cuscad,0) as 'Retail 2',

isnull(sai_cusrtl,0) as 'Assorted Retail',

isnull(sod_dept,'') as 'Dept',
isnull(soh_cuspo,'') as 'Cust PO (Header)',
isnull(sod_cuspo,'') as 'Cust PO (Detail)',

isnull(soh_resppo,'') as 'Resp PO (Header)',
isnull(sod_resppo,'') as 'Resp PO (Detail)',

isnull(pgs_ordqty,'') as 'Order Qty',
isnull(pgs_wasqty,'') as 'Wastage',
isnull(pgs_ordqty + pgs_wasqty,'') as 'Total Qty'
--isnull(pk.pod_curcde,'') as 'Currency',
--isnull(pk.pod_untprc,0) as 'Unit Price',
--isnull(pgs_ordqty + pgs_wasqty * pk.pod_untprc,0) as 'Total Amount'
from 
#TEMP_ORDNO (nolock)
left join PKORDHDR (nolock) on poh_ordno = tmp_ordno
left join PKORDDTL pk (nolock) on pk.pod_ordno = poh_ordno
left join PKGENST (nolock) on pgs_pkordno = poh_ordno
left join SCORDDTL (nolock) on sod_ordno = pgs_ordno and sod_ordseq = pgs_seq
left join SCASSINF (nolock) on sai_ordno = sod_ordno and sai_ordseq = sod_ordseq and sai_assitm = pgs_assitm
left join SCORDHDR (nolock) on sod_ordno = soh_ordno
left join POORDDTL po (nolock) on sod_purord = po.pod_purord and sod_purseq = po.pod_purseq
left join TOORDDTL (nolock) on tod_toordno = pgs_ordno and tod_toordseq = pgs_seq
left join VNBASINF cv (nolock) on cv.vbi_venno = sod_cusven
left join VNBASINF pv (nolock) on pv.vbi_venno = sod_venno
where poh_status = 'APV'

end
else
begin
	select 'XXX' as 'Pkg No', 'PO not found or Selected PO with different Printer Co. Please check!' as 'message'
end

--select top 10 * from SCASSINF
--select top 10 * from SCORDDTL 
--select top 10 * from TOORDDTL 
--select * from PKGENST
--select * from PKORDDTL


drop table #TEMP_INIT
drop table #TEMP_ORDNO











END

GO
GRANT EXECUTE ON [dbo].[sp_select_abc_excel] TO [ERPUSER] AS [dbo]
GO
