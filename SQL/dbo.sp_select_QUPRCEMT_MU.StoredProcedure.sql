/****** Object:  StoredProcedure [dbo].[sp_select_QUPRCEMT_MU]    Script Date: 09/29/2017 15:29:09 ******/
DROP PROCEDURE [dbo].[sp_select_QUPRCEMT_MU]
GO
/****** Object:  StoredProcedure [dbo].[sp_select_QUPRCEMT_MU]    Script Date: 09/29/2017 15:29:10 ******/
SET ANSI_NULLS OFF
GO
SET QUOTED_IDENTIFIER ON
GO







CREATE    PROCEDURE [dbo].[sp_select_QUPRCEMT_MU] 
 
@cus1no	nvarchar(10),
@ventyp	nvarchar(10)
--@cus2no	nvarchar(10),--
 

AS

if @ventyp = 'EXT' 
begin

if left(@cus1no, 1) = '6'
begin

select          ccf_cocde,             ccf_cus1no,          ccf_cus2no,
           ccf_cat,                  ccf_venno,   
           ccf_prctrm,            ccf_trantrm,           
           ccf_curcde,
           ccf_cumu*1 as'ccf_cumu',            ccf_pm*1 as 'ccf_pm',                    ccf_cush*1 as 'ccf_cush',
           ccf_thccusper*1 as 'ccf_thccusper',      ccf_upsper*1 as 'ccf_upsper',                ccf_labper*1 as 'ccf_labper',
           ccf_faper*1 as 'ccf_faper',             ccf_cstbufper*1 as 'ccf_cstbufper',        ccf_othper*1 as 'ccf_othper',
           ccf_pliper*1 as 'ccf_pliper',                      ccf_dmdper*1 as 'ccf_dmdper',   ccf_rbtper*1 as 'ccf_rbtper',
           ccf_pkgper*1 as 'ccf_pkgper',      ccf_comper*1 as 'ccf_comper',    ccf_icmper*1 as 'ccf_icmper'
from            CUCALFML (nolock)
where          ccf_cocde = ''                   and
--        ccf_cus1no = @final_cus1no and ccf_cus2no = @final_cus2no
           ccf_cus2no = @cus1no
           and 
           ccf_cat in ('MAGICSILK', 'FLORAL FTY', 'STANDARD') and ccf_venno = 'EXT'
end
else
begin

select          ccf_cocde,             ccf_cus1no,          ccf_cus2no,
           ccf_cat,                  ccf_venno,   
           ccf_prctrm,            ccf_trantrm,           
           ccf_curcde,
           ccf_cumu*1 as'ccf_cumu',            ccf_pm*1 as 'ccf_pm',                    ccf_cush*1 as 'ccf_cush',
           ccf_thccusper*1 as 'ccf_thccusper',      ccf_upsper*1 as 'ccf_upsper',                ccf_labper*1 as 'ccf_labper',
           ccf_faper*1 as 'ccf_faper',             ccf_cstbufper*1 as 'ccf_cstbufper',        ccf_othper*1 as 'ccf_othper',
           ccf_pliper*1 as 'ccf_pliper',                      ccf_dmdper*1 as 'ccf_dmdper',   ccf_rbtper*1 as 'ccf_rbtper',
           ccf_pkgper*1 as 'ccf_pkgper',      ccf_comper*1 as 'ccf_comper',    ccf_icmper*1 as 'ccf_icmper'
from            CUCALFML (nolock)
where          ccf_cocde = ''                   and
--        ccf_cus1no = @final_cus1no and ccf_cus2no = @final_cus2no
           ccf_cus1no = @cus1no and ccf_cus2no = ''
           and 
           ccf_cat in ('MAGICSILK', 'FLORAL FTY', 'STANDARD') and ccf_venno = 'EXT'
end


end
else
begin

if left(@cus1no, 1) = '6'
begin

select          ccf_cocde,             ccf_cus1no,          ccf_cus2no,
           ccf_cat,                  ccf_venno,   
           ccf_prctrm,            ccf_trantrm,           
           ccf_curcde,
           ccf_cumu*1 as'ccf_cumu',            ccf_pm*1 as 'ccf_pm',                    ccf_cush*1 as 'ccf_cush',
           ccf_thccusper*1 as 'ccf_thccusper',      ccf_upsper*1 as 'ccf_upsper',                ccf_labper*1 as 'ccf_labper',
           ccf_faper*1 as 'ccf_faper',             ccf_cstbufper*1 as 'ccf_cstbufper',        ccf_othper*1 as 'ccf_othper',
           ccf_pliper*1 as 'ccf_pliper',                      ccf_dmdper*1 as 'ccf_dmdper',   ccf_rbtper*1 as 'ccf_rbtper',
           ccf_pkgper*1 as 'ccf_pkgper',      ccf_comper*1 as 'ccf_comper',    ccf_icmper*1 as 'ccf_icmper'
from            CUCALFML (nolock)
where          ccf_cocde = ''                   and
--        ccf_cus1no = @final_cus1no and ccf_cus2no = @final_cus2no
           ccf_cus2no = @cus1no
           and 
           ccf_cat in ('XMAS TREE', 'STANDARD') and ccf_venno = 'INT'
end
else
begin

select          ccf_cocde,             ccf_cus1no,          ccf_cus2no,
           ccf_cat,                  ccf_venno,   
           ccf_prctrm,            ccf_trantrm,           
           ccf_curcde,
           ccf_cumu*1 as'ccf_cumu',            ccf_pm*1 as 'ccf_pm',                    ccf_cush*1 as 'ccf_cush',
           ccf_thccusper*1 as 'ccf_thccusper',      ccf_upsper*1 as 'ccf_upsper',                ccf_labper*1 as 'ccf_labper',
           ccf_faper*1 as 'ccf_faper',             ccf_cstbufper*1 as 'ccf_cstbufper',        ccf_othper*1 as 'ccf_othper',
           ccf_pliper*1 as 'ccf_pliper',                      ccf_dmdper*1 as 'ccf_dmdper',   ccf_rbtper*1 as 'ccf_rbtper',
           ccf_pkgper*1 as 'ccf_pkgper',      ccf_comper*1 as 'ccf_comper',    ccf_icmper*1 as 'ccf_icmper'
from            CUCALFML (nolock)
where          ccf_cocde = ''                   and
--        ccf_cus1no = @final_cus1no and ccf_cus2no = @final_cus2no
           ccf_cus1no = @cus1no and ccf_cus2no = ''
           and 
           ccf_cat in ('XMAS TREE', 'STANDARD') and ccf_venno = 'INT'
end

end




GO
GRANT EXECUTE ON [dbo].[sp_select_QUPRCEMT_MU] TO [ERPUSER] AS [dbo]
GO
