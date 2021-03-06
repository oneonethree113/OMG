/****** Object:  StoredProcedure [dbo].[sp_select_SCORDDTL_SHM00001_1]    Script Date: 09/29/2017 15:29:09 ******/
DROP PROCEDURE [dbo].[sp_select_SCORDDTL_SHM00001_1]
GO
/****** Object:  StoredProcedure [dbo].[sp_select_SCORDDTL_SHM00001_1]    Script Date: 09/29/2017 15:29:10 ******/
SET ANSI_NULLS OFF
GO
SET QUOTED_IDENTIFIER OFF
GO



-- Checked by Allan Yuen at 27/07/2003



/************************************************************************
Author:		Johnson Lai
Date:		7th Jan, 2002
Description:	Select data From SCORDDTL
Parameter:	1. Company
		2. SC No.	
************************************************************************/
------------------------------------------------- 
CREATE procedure [dbo].[sp_select_SCORDDTL_SHM00001_1]
                                                                                                                                                                                                                                                                 
---------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------- 
@sod_cocde nvarchar(6) ,
@sod_ordno nvarchar(20),
@soh_cus1no nvarchar(20),
@soh_cus2no nvarchar(20)

                                                
---------------------------------------------- 
 
AS

Select 
sod_ordno, 
sod_ordseq, 
sod_cuspo,
sod_itmno, 
sod_itmdsc,
sod_cusitm,
sod_colcde,
sod_coldsc,
sod_pckunt,
sod_inrctn,
sod_mtrctn,
sod_mtrdcm,
sod_mtrwcm,
sod_mtrhcm,
sod_cbm,
sod_ordqty - sod_shpqty as 'sod_shpqty',
cast(sod_colcde as nvarchar(30)) + ' / ' + 
cast(sod_pckunt as nvarchar(6)) + ' / ' + 
cast(sod_inrctn as nvarchar(10)) + ' / ' + 
cast(sod_mtrctn as nvarchar(10)) + ' / ' + 
cast(sod_cbm as nvarchar(10)) as 'sod_colpck'

from SCORDDTL 

left join SCORDHDR on sod_cocde = soh_cocde and sod_ordno = soh_ordno

where 
sod_cocde = @sod_cocde and
sod_ordno = @sod_ordno and
soh_cus1no = @soh_cus1no and
soh_cus2no = @soh_cus2no 

order by 
sod_cocde, sod_ordno, sod_itmno, sod_colcde ,sod_pckunt,sod_inrctn,sod_mtrctn,sod_cbm

----------------------------------------------------------





GO
GRANT EXECUTE ON [dbo].[sp_select_SCORDDTL_SHM00001_1] TO [ERPUSER] AS [dbo]
GO
