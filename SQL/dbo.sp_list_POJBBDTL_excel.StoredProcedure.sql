/****** Object:  StoredProcedure [dbo].[sp_list_POJBBDTL_excel]    Script Date: 09/29/2017 15:29:09 ******/
DROP PROCEDURE [dbo].[sp_list_POJBBDTL_excel]
GO
/****** Object:  StoredProcedure [dbo].[sp_list_POJBBDTL_excel]    Script Date: 09/29/2017 15:29:10 ******/
SET ANSI_NULLS OFF
GO
SET QUOTED_IDENTIFIER OFF
GO



/************************************************************************
Author:		Lester Wu
Date:		24th March, 2005
Description:	Select data From POORDDTL and PORODHDR
***********************************************************************
*/

CREATE  procedure [dbo].[sp_list_POJBBDTL_excel]
                                                                                                                                                                                                                                                               
@pjd_cocde nvarchar(6) ,
@pjd_batno nvarchar(20) 

AS
begin


declare 
	@yco_conam varchar(100)


SELECT 
	@yco_conam = yco_conam
FROM
	SYCOMINF
WHERE
	YCO_COCDE = @pjd_cocde

---------------------------------------------


select 
@yco_conam as 'compName',
pjd_batno as 'Batch No',
pjd_batseq as 'Batch Seq #',

pod_venitm as 'Vendor Item #',
pod_jobord as 'Job No',
ibi_engdsc as 'IM English Description',
ibi_chndsc as 'IM Chinese Description',
ibi_catlvl4 as 'Category (Lvl 4)',
vbi_vensna as 'Vendor',
(	select case when count(1) > 0 then 'Y' else 'N' end 
	from IMBOMASS(NOLOCK) 
	where iba_itmno = pod_venitm and iba_typ='BOM'
) as 'BOM Flag'

from POJBBDTL
left join POORDDTL on pjd_cocde = pod_cocde and pjd_jobord = pod_jobord
left join POORDHDR on pod_cocde = poh_cocde and pod_purord = poh_purord
left join VNBASINF on vbi_venno = poh_venno
left join IMBASINF on pod_venitm = ibi_itmno 
where                                                                                                                                                                                                                                                                 
pjd_cocde = @pjd_cocde and
pjd_batno = @pjd_batno and
pjd_confrm = 'Y'

order by pjd_batno,pjd_batseq


end








GO
GRANT EXECUTE ON [dbo].[sp_list_POJBBDTL_excel] TO [ERPUSER] AS [dbo]
GO
