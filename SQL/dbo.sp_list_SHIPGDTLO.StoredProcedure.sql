/****** Object:  StoredProcedure [dbo].[sp_list_SHIPGDTLO]    Script Date: 09/29/2017 15:29:09 ******/
DROP PROCEDURE [dbo].[sp_list_SHIPGDTLO]
GO
/****** Object:  StoredProcedure [dbo].[sp_list_SHIPGDTLO]    Script Date: 09/29/2017 15:29:10 ******/
SET ANSI_NULLS OFF
GO
SET QUOTED_IDENTIFIER OFF
GO







-- Checked by Allan Yuen at 27/07/2003


/************************************************************************
Author:		Wong Hong
Date:		Jan 4, 2002
Description:	Select data From SHIPGDTLO
Parameter:	1. Company
		2. Inv no
***************************************************************************
Modification History
***************************************************************************
Modified on		Modified by		Description
***************************************************************************
26th Aug, 2004		Lester Wu		retrieve PO No from SHIPGDTL
23rd Sep, 2004		Lester Wu		Missing Logic of joing SHIPGDTL and SHINVHDR
*****************************************************************************/
--

--sp_list_SHIPGDTLO 'UCP','I0400812'

CREATE   procedure [dbo].[sp_list_SHIPGDTLO]
                                                                                                                                                                                                                                                               
@hid_cocde nvarchar(6) ,
@hid_invno nvarchar(20) 
AS
begin

select 
distinct
hid_invno,
hid_itmno,
max(hid_itmdsc) as hid_itmdsc,
hid_colcde,
max(hid_coldsc) as hid_coldsc,
max(isnull(hid_cusitm, '')) as hid_cusitm,
max(isnull(hid_mannam, '')) as hid_mannam,
max(isnull(hid_manadr, '')) as hid_manadr,
sum(hid_shpqty) as hid_shpqty,
max(hid_untamt) as hid_untamt,
max(hid_untsel) as hid_untsel,
sum(hid_selprc) as hid_selprc,
sum(hid_ttlamt) as hid_ttlamt,
hid_ordno,
hid_ordseq,
hid_untcde,
hid_inrctn,
hid_mtrctn,
hid_vol,
max(isnull(sod_cussku,'')) as sod_cussku,
max(sod_ordqty) as sod_ordqty,
max(sod_shpqty) as sod_shpqty
--Lester Wu 2004/08/26 retrieve PO No
,hid_purord
------------------------------------

from SHIPGDTL s, SHINVHDR i, SCORDDTL c
where                                                                                                                                                                                                                                                             
s.hid_cocde = @hid_cocde and
i.hiv_shpno = s.hid_shpno and
i.hiv_cocde = s.hid_cocde and
s.hid_cocde = c.sod_cocde and
s.hid_ordno = c.sod_ordno and
s.hid_ordseq = c.sod_ordseq and
--Lester Wu 2004/09/23 Add Condition to Join SHIPGDTL and SHINVHDR
s.hid_invno = i.hiv_invno and 
----------------------------------------------------------------------------------------------
i.hiv_invno = @hid_invno  
group by hid_invno, hid_itmno, hid_colcde, hid_untcde, hid_inrctn, hid_mtrctn, hid_vol, hid_ordno, hid_ordseq
--Lester Wu 2004/08/26 group the resulting data by PO No
,hid_purord
--------------------------------------------------------
end







GO
GRANT EXECUTE ON [dbo].[sp_list_SHIPGDTLO] TO [ERPUSER] AS [dbo]
GO
