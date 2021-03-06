/****** Object:  StoredProcedure [dbo].[sp_select_ZABNTRANSCHK]    Script Date: 09/29/2017 15:29:08 ******/
DROP PROCEDURE [dbo].[sp_select_ZABNTRANSCHK]
GO
/****** Object:  StoredProcedure [dbo].[sp_select_ZABNTRANSCHK]    Script Date: 09/29/2017 15:29:10 ******/
SET ANSI_NULLS OFF
GO
SET QUOTED_IDENTIFIER OFF
GO






/*
=========================================================
Program ID	: 
Description   	:  This sp is to get the Price Change Information for SAP Table ZMMPRCCHG
Programmer  	:  Mark Lau
Create Date   	: 
Last Modified  	: 20 Feb 2008
Table Read(s) 	:
Table Write(s) 	:
=========================================================
 Modification History                                    
=========================================================
Date		Author		Description
=========================================================     
*/


CREATE PROCEDURE [dbo].[sp_select_ZABNTRANSCHK] 
@cocde	nvarchar(4),
--@plant		nvarchar(4),
@typ		nvarchar(4)
AS


begin
select 
soh_ordsts, sod_ordno, sod_ordseq, pod_jobord, sod_itmno, sod_venno,sod_zorvbeln,sod_zorposnr, sod_ordqty, sod_shpqty, pod_shpstr, soh_cus1no,cbi_cussna,
@typ as 'typ'
from scorddtl (nolock)
inner join scordhdr(nolock) on sod_ordno = soh_ordno
inner join poorddtl(nolock) on pod_scno = sod_ordno and pod_scline = sod_ordseq
inner join cubasinf(nolock) on soh_cus1no = cbi_cusno
inner join imbasinf(nolock) on sod_itmno = ibi_itmno
where 
sod_zorvbeln <> '' and sod_zorposnr <> '' and sod_zorposnr <> '999999'  and
--sod_venno in ('B','U','W') and
/*
( 
(sod_venno in ('A')  and @plant = '3043')
or
(sod_venno not in ('A')  and @plant = '3041' and ibi_venno in ('B','U','W'))
)
and
*/
sod_ordqty <> 0 and
(
sod_shpqty - sod_ordqty = 0 and @typ = 'F'
or 
sod_shpqty - sod_ordqty < 0 and @typ = 'P'
)
and
sod_shpqty <> 0
order by sod_upddat, sod_zorvbeln, sod_zorposnr asc

end


GO
GRANT EXECUTE ON [dbo].[sp_select_ZABNTRANSCHK] TO [ERPUSER] AS [dbo]
GO
