/****** Object:  StoredProcedure [dbo].[sp_list_SHCI_SHIPGDTL]    Script Date: 09/29/2017 15:29:09 ******/
DROP PROCEDURE [dbo].[sp_list_SHCI_SHIPGDTL]
GO
/****** Object:  StoredProcedure [dbo].[sp_list_SHCI_SHIPGDTL]    Script Date: 09/29/2017 15:29:10 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO











-- Checked by Allan Yuen at 27/07/2003

/************************************************************************
Author:		Kenny Chan 
Date:		OCT 8, 2002
Description:	Turning
************************************************************************/

/************************************************************************
Author:		Johnson Lai 
Date:		Jan 4, 2002
Description:	Select data From SHIPGDTL
Parameter:	1. Company
		2. Ship no
************************************************************************/

/************************************************************************
Modification History
************************************************************************
Modify Date	Modified by	Description
************************************************************************
2005-09-12	Lester Wu		Show Venodr Short Name of CV and PV

************************************************************************/

CREATE  procedure [dbo].[sp_list_SHCI_SHIPGDTL]
                                                                                                                                                                                                                                                               

@hid_cocde nvarchar(6) ,
@hid_shpno nvarchar(20) 
 
AS
begin
select 

'   '  as 'DEL',
hid_cocde,
hid_shpno,
hid_shpseq,
hid_ctrcfs,
hid_invno,
hid_ttlamt,

hid_ordno,
hid_ordseq,
hid_jobno,
hid_cuspo,
hid_itmno,
isnull(cast(hid_colcde as nvarchar(30)) + ' / ' + 
cast(hid_untcde as nvarchar(6)) + ' / ' + 
cast(hid_inrctn as nvarchar(10)) + ' / ' + 
cast(hid_mtrctn as nvarchar(10)) + ' / ' + 
cast(hid_vol as nvarchar(10)) , '') as 'hid_colpck',
hid_shpqty,
hid_untcde,

hid_ctnstr,
hid_ctnend,
hid_ttlctn,


hid_shpqty as 'hid_orgqty',

hid_mtrdcm,
hid_mtrwcm,
hid_mtrhcm,
hid_ttlvol,

hid_actvol,
hid_sealno,
hid_ctrsiz,
hid_pckrmk,
hid_cusitm,
hid_itmtyp,
hid_itmdsc,
hid_colcde,
hid_cuscol,
hid_coldsc,

hid_inrctn,
hid_mtrctn,
hid_vol,

hid_grswgt,
hid_ttlgrs,

hid_netwgt,
hid_ttlnet,

hid_itmshm,
hid_cmprmk,
hid_mannam,
hid_manadr,

hid_untsel,
hid_selprc,
hid_untamt,
hid_prctrm,
hid_paytrm,
hid_purord,
hid_purseq,
-- Lester Wu 2005-09-12, show vendor short name of CV and PV
--hid_venno,
--hid_cusven,
hid_venno + case isnull(pv.vbi_vensna,'') when '' then '' else ' - ' + pv.vbi_vensna end as 'hid_venno',
hid_cusven + case isnull(cv.vbi_vensna,'') when '' then '' else ' - ' + cv.vbi_vensna end as 'hid_cusven',
------------------------------------------------------------------------------
isnull(sod_ordqty,0) - isnull(sod_shpqty ,0) as 'sod_outqty',
isnull(sod_venno,'') as  'sod_venno',
isnull(pod_jobord,'') as 'pod_jobord',
isnull(pod_purord,'') as 'pod_purord',
isnull(pod_purseq,'') as 'pod_purseq',
hid_creusr,
--added by Mark Lau 20060929
hid_alsitmno,
hid_alscolcde,
--Lester Wu 2007-06-25
hid_conftr , 
hid_contopc , 
hid_pcprc,
--Added by Mark Lau 20080611
hid_custum,
hid_cusstyno

from SHCI_SHIPGDTL

left join SCORDDTL on hid_ordno = sod_ordno and hid_ordseq = sod_ordseq and sod_cocde = @hid_cocde
left join POORDDTL on sod_ordno = pod_scno and sod_ordseq = pod_scline and pod_cocde = @hid_cocde

-- Lester Wu 2005-09-12, show vendor short name of CV and PV
left join vnbasinf pv (nolock) on hid_venno = pv.vbi_venno 
left join vnbasinf cv (nolock) on hid_cusven = cv.vbi_venno
------------------------------------------------------------------------------


where                                                                                                                                                                                                                                                          
       
hid_cocde = @hid_cocde and
hid_shpno = @hid_shpno

order by hid_shpno, hid_shpseq
end








GO
GRANT EXECUTE ON [dbo].[sp_list_SHCI_SHIPGDTL] TO [ERPUSER] AS [dbo]
GO
