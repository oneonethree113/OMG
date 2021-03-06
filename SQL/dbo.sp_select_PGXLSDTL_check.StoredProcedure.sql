/****** Object:  StoredProcedure [dbo].[sp_select_PGXLSDTL_check]    Script Date: 09/29/2017 15:29:09 ******/
DROP PROCEDURE [dbo].[sp_select_PGXLSDTL_check]
GO
/****** Object:  StoredProcedure [dbo].[sp_select_PGXLSDTL_check]    Script Date: 09/29/2017 15:29:10 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create  PROCEDURE [dbo].[sp_select_PGXLSDTL_check]
	@pxd_xlsfil  nvarchar(50) ,
	@pxd_fildat  nvarchar(30)  


AS
 
 CREATE TABLE #temp_PG(
	[check_one] int,
	[pxd_scno] [nvarchar](20) NULL,
	[pxd_tono] [nvarchar](20) NULL,
	[pxd_itmno] [nvarchar](20) NULL,
	[pxd_assitmno] [nvarchar](20) NULL,
	[pxd_cusitmno] [nvarchar](20) NULL,
	[pxd_um] [nvarchar](10) NULL,
	[pxd_inner] [int] NULL,
	[pxd_master] [int] NULL,
	[pxd_ftytrm] [nvarchar](30) NULL,
	[pxd_hktrm] [nvarchar](30) NULL,
	[pxd_trantrm] [nvarchar](30) NULL,
	[pxd_colcde] [nvarchar](30) NULL,
	pxd_pkgitm [nvarchar](30) NULL,
	pxd_pkgvenno [nvarchar](30) NULL,
	[pxd_unitprice] [decimal](8, 4) NULL
)
 

insert into #temp_PG
  select
		count(1)   as 'check_one',
	pxd_scno  ,
	case (pxd_scno) when  '' then pxd_tono 
			else '' end as 'pxd_tono'  ,
	pxd_itmno  ,
	pxd_assitmno  ,
	pxd_cusitmno  ,
	pxd_um ,
	pxd_inner ,
	pxd_master ,
	pxd_ftytrm,
	pxd_hktrm,	
	pxd_trantrm,
	pxd_colcde,
	pxd_pkgitm,
	pxd_pkgvenno,
	pxd_unitprice
from	PGXLSDTL
where 
	pxd_xlsfil = @pxd_xlsfil 
	and pxd_fildat = @pxd_fildat  
group by 
	pxd_scno  ,
	case (pxd_scno) when  '' then pxd_tono 
			else '' end  ,
	pxd_itmno  ,
	pxd_assitmno  ,
	pxd_cusitmno  ,
	pxd_um ,
	pxd_inner ,
	pxd_master ,
	pxd_ftytrm,
	pxd_hktrm,
	pxd_trantrm,
	pxd_colcde,
	pxd_pkgitm,
	pxd_pkgvenno,
	pxd_unitprice 

  
insert into #temp_PG
select 	count(1)   as 'check_one',
pxd_scno  ,
	case (pxd_scno) when  '' then pxd_tono 
			else '' end   as  'pxd_tono',
	pxd_itmno  ,
	pxd_assitmno  ,
	pxd_cusitmno  ,
	pxd_um ,
	pxd_inner ,
	pxd_master ,
	pxd_ftytrm,
	pxd_hktrm,
	pxd_trantrm,
	pxd_colcde,
	pxd_pkgitm,
	pxd_pkgvenno,
	pxd_unitprice
 from
PKREQDTL
left join 
PGXLSDTL
on ( (pxd_scno = prd_ScToNo and prd_ScToNo <> '' ) or 
		(pxd_tono = prd_ScToNo  and prd_ScToNo  <> '') )
	and pxd_itmno = prd_itemno
and pxd_assitmno = prd_assitm
and pxd_um = prd_pckunt
and pxd_inner = prd_inrqty
and pxd_master = prd_mtrqty
and pxd_ftytrm = prd_ftyprctrm
and pxd_hktrm = prd_hkprctrm
and pxd_trantrm = prd_trantrm
and pxd_pkgitm = prd_pkgitm
and pxd_pkgvenno = prd_pkgven
and pxd_unitprice = prd_untprc

where 
	pxd_xlsfil = @pxd_xlsfil 
	and pxd_fildat = @pxd_fildat  
and pxd_itmno is not null

group by 
	pxd_scno  ,
	case (pxd_scno) when  '' then pxd_tono 
			else '' end  ,
	pxd_itmno  ,
	pxd_assitmno  ,
	pxd_cusitmno  ,
	pxd_um ,
	pxd_inner ,
	pxd_master ,
	pxd_ftytrm,
	pxd_hktrm,
	pxd_trantrm,
	pxd_colcde,
	pxd_pkgitm,
	pxd_pkgvenno,
	pxd_unitprice

 

 select 	sum(check_one)   as 'check',
pxd_scno  ,
	case (pxd_scno) when  '' then pxd_tono 
			else '' end   as  'pxd_tono',
	pxd_itmno  ,
	pxd_assitmno  ,
	pxd_cusitmno  ,
	pxd_um ,
	pxd_inner ,
	pxd_master ,
	pxd_ftytrm,
	pxd_hktrm,
	pxd_trantrm,
	pxd_colcde,
	pxd_pkgitm,
	pxd_pkgvenno,
	pxd_unitprice
 from #temp_PG
 
group by 
	pxd_scno  ,
	case (pxd_scno) when  '' then pxd_tono 
			else '' end  ,
	pxd_itmno  ,
	pxd_assitmno  ,
	pxd_cusitmno  ,
	pxd_um ,
	pxd_inner ,
	pxd_master ,
	pxd_ftytrm,
	pxd_hktrm,
	pxd_trantrm,
	pxd_colcde,
	pxd_pkgitm,
	pxd_pkgvenno,
	pxd_unitprice

drop table #temp_PG

GO
GRANT EXECUTE ON [dbo].[sp_select_PGXLSDTL_check] TO [ERPUSER] AS [dbo]
GO
