/****** Object:  StoredProcedure [dbo].[sp_select_TOM00002_tbc]    Script Date: 09/29/2017 15:29:08 ******/
DROP PROCEDURE [dbo].[sp_select_TOM00002_tbc]
GO
/****** Object:  StoredProcedure [dbo].[sp_select_TOM00002_tbc]    Script Date: 09/29/2017 15:29:10 ******/
SET ANSI_NULLS OFF
GO
SET QUOTED_IDENTIFIER OFF
GO








--01/14/2014 fty cost change to fty price BN


CREATE       PROCEDURE [dbo].[sp_select_TOM00002_tbc]   

@cocde nvarchar(6),  
@qutno nvarchar(20),  
@optZeroQty char(1)

AS  
  
declare @gen nvarchar(1), @mode nvarchar(3)  , @saldiv nvarchar(20) , @salmgt nvarchar(20)
  
set @gen = 'N'  
set @saldiv = '' 
set @salmgt = ''

if @optZeroQty=''   
begin  
	SET @optZeroQty='N'  
end  
 
select	@Gen as 'Gen',	qud_qutseq,	qud_itmnoreal,
	qud_itmnotmp , qud_itmnoven , qud_itmnovenno,
	qud_itmdsc,	qud_colcde, qud_toqty	,
	qud_untcde + ' / ' + ltrim(str(qud_inrqty)) + ' / ' + ltrim(str(qud_mtrqty)) + ' / ' + qud_prctrm + ' / ' + qud_ftyprctrm + ' / '+ qud_trantrm   as 'Packing & Terms',
	qud_ftyshpstr,qud_ftyshpend,
	qud_cushpstr,qud_cushpend ,
	qud_cusven,	qud_ftyprc,	
	qud_prctrm,	qud_ftyprctrm,	qud_trantrm ,
	qud_cft,qud_qutno,
	c.cbi_cusno + ' - ' + c.cbi_cussna + (case c.cbi_cussts
									when 'A' then ' (Active)'
									when 'I' then ' (Inactive)'
									when 'D' then ' (Discontinue)' end) as 'cbi_cus1na',
	d.cbi_cusno + ' - ' + d.cbi_cussna + (case d.cbi_cussts
					when 'A' then ' (Active)'
					when 'I' then ' (Inactive)'
					when 'D' then ' (Discontinue)' end) as 'cbi_cus2na'
	
	,qud_cocde,quh_saldivtem,quh_srname,'' as 'quh_saldiv',quh_issdat,quh_rvsdat,''as'quh_custcde'
	,qud_buyer,quh_Year,quh_cus1no,quh_cus2no,quh_season,
	''as'qud_refno',qud_itmsts,getdate() as 'qud_todat',''as'qud_customer',qud_cus1no,qud_cus2no,qud_buyer,''as'qud_category',
	''as'qud_jobno',qud_cusitm as'qud_itmsku',qud_itmdsc,qud_colcde,qud_conftr,qud_cft,qud_cbm,
	qud_ftyprctrm,qud_prctrm,qud_trantrm,qud_qutdat as'qud_period',qud_prctrm as'qud_fobport', qud_cususd as 'qud_retail',
	qud_dv as 'qud_dsgven',qud_venno as 'qud_prdven',qud_cusven as'qud_cusven',qud_imgpth,''as'qud_sapno',''as'qud_cuspono', qud_tormk as 'qud_rmk',
	qud_upc,qud_mtrdcm as'qud_ctnL',qud_mtrwcm as 'qud_ctnW',qud_mtrhcm as 'qud_ctnH',qud_upc as'qud_ctnupc' ,qud_cusstyno as'qud_venstk',qud_fcurcde,
	qud_ftyprc as 'qud_ftycst',qud_curcde ,
	--qud_cus1sp as 'qud_selprc',
	qud_cus1dp as 'qud_selprc',
	'' as 'qud_qtyb_cuspo',''as'qud_qtyb_ordqty',''as'qud_podat',''as'qud_pcktyp',
	qud_untcde,qud_inrqty,qud_mtrqty,qud_cussub,
	qud_basprc,qud_qutitmsts,
qpe_mu,
qpe_muprc,
qpe_mumin,
qpe_muminprc,
qpe_pkgper,
qpe_comper,
qpe_icmper,
qpe_cus1sp,
qpe_cus1dp
	 
from	QUOTNDTL (NOLOCK)  

left join	QUOTNHDR (NOLOCK) on	qud_qutno = quh_qutno  
left join	QUPRCEMT (NOLOCK) on	qud_qutno = qpe_qutno  
left join	CUBASINF c (NOLOCK) on	quh_cus1no = c.cbi_cusno   
left join	CUBASINF d (NOLOCK) on	quh_cus2no = d.cbi_cusno   
where	qud_cocde = @cocde		and   
	qud_qutno = @qutno		and
	(@optZeroQty='Y'	or
	 (@optZeroQty='N' and
	  qud_toqty>0)) and qud_itmnoreal <> '' 

union  
 select	@Gen as 'Gen',	qud_qutseq,	qud_itmnoreal,
	qud_itmnotmp , qud_itmnoven , qud_itmnovenno,
	qud_itmdsc,	qud_colcde, qud_toqty	,
	qud_untcde + ' / ' + ltrim(str(qud_inrqty)) + ' / ' + ltrim(str(qud_mtrqty)) + ' / ' + qud_prctrm + ' / ' + qud_ftyprctrm + ' / '+ qud_trantrm   as 'Packing & Terms',
	qud_ftyshpstr,qud_ftyshpend,
	qud_cushpstr,qud_cushpend ,
	qud_cusven,	qud_ftyprc,	
	qud_prctrm,	qud_ftyprctrm,	qud_trantrm ,
	qud_cft,qud_qutno,
	c.cbi_cusno + ' - ' + c.cbi_cussna + (case c.cbi_cussts
									when 'A' then ' (Active)'
									when 'I' then ' (Inactive)'
									when 'D' then ' (Discontinue)' end) as 'cbi_cus1na',
	d.cbi_cusno + ' - ' + d.cbi_cussna + (case d.cbi_cussts
					when 'A' then ' (Active)'
					when 'I' then ' (Inactive)'
					when 'D' then ' (Discontinue)' end) as 'cbi_cus2na'
	
	,qud_cocde,quh_saldivtem,quh_srname,'' as 'quh_saldiv',quh_issdat,quh_rvsdat,''as'quh_custcde'
	,qud_buyer,quh_Year,quh_cus1no,quh_cus2no,quh_season,
	''as'qud_refno',qud_itmsts,getdate() as 'qud_todat',''as'qud_customer',qud_cus1no,qud_cus2no,qud_buyer,''as'qud_category',
	''as'qud_jobno',qud_cusitm as'qud_itmsku',qud_itmdsc,qud_colcde,qud_conftr,qud_cft,qud_cbm,
	qud_ftyprctrm,qud_prctrm,qud_trantrm,qud_qutdat as'qud_period',qud_prctrm as'qud_fobport', qud_cususd as 'qud_retail',
	qud_dv as 'qud_dsgven',qud_venno as 'qud_prdven',qud_cusven as'qud_cusven',qud_imgpth,''as'qud_sapno',''as'qud_cuspono', qud_tormk as 'qud_rmk',
	qud_upc,qud_mtrdcm as'qud_ctnL',qud_mtrwcm as 'qud_ctnW',qud_mtrhcm as 'qud_ctnH',qud_upc as'qud_ctnupc' ,qud_cusstyno as'qud_venstk',qud_fcurcde,
	qud_ftyprc as 'qud_ftycst',qud_curcde ,
	--qud_cus1sp as 'qud_selprc',
	qud_cus1dp as 'qud_selprc',
	'' as 'qud_qtyb_cuspo',''as'qud_qtyb_ordqty',''as'qud_podat',''as'qud_pcktyp',
	qud_untcde,qud_inrqty,qud_mtrqty,qud_cussub,
	qud_basprc,qud_qutitmsts,
qpe_mu,
qpe_muprc,
qpe_mumin,
qpe_muminprc,
qpe_pkgper,
qpe_comper,
qpe_icmper,
qpe_cus1sp,
qpe_cus1dp
from	QUOTNDTL (NOLOCK)  

left join	QUOTNHDR (NOLOCK) on	qud_qutno = quh_qutno  
left join	QUPRCEMT (NOLOCK) on	qud_qutno = qpe_qutno  
left join	CUBASINF c (NOLOCK) on	quh_cus1no = c.cbi_cusno   
left join	CUBASINF d (NOLOCK) on	quh_cus2no = d.cbi_cusno   
where	qud_cocde = @cocde		and   
	qud_qutno = @qutno		and
	(@optZeroQty='Y'	or
	 (@optZeroQty='N' and
	  qud_toqty>0)) and qud_itmnoreal = '' and qud_itmnotmp <> '' and qud_itmnoven =''


union  
  select	@Gen as 'Gen',	qud_qutseq,	qud_itmnoreal,
	qud_itmnotmp , qud_itmnoven , qud_itmnovenno,
	qud_itmdsc,	qud_colcde, qud_toqty	,
	qud_untcde + ' / ' + ltrim(str(qud_inrqty)) + ' / ' + ltrim(str(qud_mtrqty)) + ' / ' + qud_prctrm + ' / ' + qud_ftyprctrm + ' / '+ qud_trantrm   as 'Packing & Terms',
	qud_ftyshpstr,qud_ftyshpend,
	qud_cushpstr,qud_cushpend ,
	qud_cusven,	qud_ftyprc,	
	qud_prctrm,	qud_ftyprctrm,	qud_trantrm ,
	qud_cft,qud_qutno,
	c.cbi_cusno + ' - ' + c.cbi_cussna + (case c.cbi_cussts
									when 'A' then ' (Active)'
									when 'I' then ' (Inactive)'
									when 'D' then ' (Discontinue)' end) as 'cbi_cus1na',
	d.cbi_cusno + ' - ' + d.cbi_cussna + (case d.cbi_cussts
					when 'A' then ' (Active)'
					when 'I' then ' (Inactive)'
					when 'D' then ' (Discontinue)' end) as 'cbi_cus2na'
	
	,qud_cocde,quh_saldivtem,quh_srname,'' as 'quh_saldiv',quh_issdat,quh_rvsdat,''as'quh_custcde'
	,qud_buyer,quh_Year,quh_cus1no,quh_cus2no,quh_season,
	''as'qud_refno',qud_itmsts,getdate() as 'qud_todat',''as'qud_customer',qud_cus1no,qud_cus2no,qud_buyer,''as'qud_category',
	''as'qud_jobno',qud_cusitm as'qud_itmsku',qud_itmdsc,qud_colcde,qud_conftr,qud_cft,qud_cbm,
	qud_ftyprctrm,qud_prctrm,qud_trantrm,qud_qutdat as'qud_period',qud_prctrm as'qud_fobport', qud_cususd as 'qud_retail',
	qud_dv as 'qud_dsgven',qud_venno as 'qud_prdven',qud_cusven as'qud_cusven',qud_imgpth,''as'qud_sapno',''as'qud_cuspono', qud_tormk as 'qud_rmk',
	qud_upc,qud_mtrdcm as'qud_ctnL',qud_mtrwcm as 'qud_ctnW',qud_mtrhcm as 'qud_ctnH',qud_upc as'qud_ctnupc' ,qud_cusstyno as'qud_venstk',qud_fcurcde,
	qud_ftyprc as 'qud_ftycst',qud_curcde ,
	qud_cus1dp as 'qud_selprc',
	'' as 'qud_qtyb_cuspo',''as'qud_qtyb_ordqty',''as'qud_podat',''as'qud_pcktyp',
	qud_untcde,qud_inrqty,qud_mtrqty,qud_cussub,
	qud_basprc,qud_qutitmsts,
qpe_mu,
qpe_muprc,
qpe_mumin,
qpe_muminprc,
qpe_pkgper,
qpe_comper,
qpe_icmper,
qpe_cus1sp,
qpe_cus1dp
	 
from	QUOTNDTL (NOLOCK)  

left join	QUOTNHDR (NOLOCK) on	qud_qutno = quh_qutno  
left join	QUPRCEMT (NOLOCK) on	qud_qutno = qpe_qutno  
left join	CUBASINF c (NOLOCK) on	quh_cus1no = c.cbi_cusno   
left join	CUBASINF d (NOLOCK) on	quh_cus2no = d.cbi_cusno   
where	qud_cocde = @cocde		and   
	qud_qutno = @qutno		and
	(@optZeroQty='Y'	or
	 (@optZeroQty='N' and
	  qud_toqty>0)) and qud_itmnoreal = '' and qud_itmnotmp = '' and qud_itmnoven <> ''
 














GO
GRANT EXECUTE ON [dbo].[sp_select_TOM00002_tbc] TO [ERPUSER] AS [dbo]
GO
