/****** Object:  StoredProcedure [dbo].[sp_select_ZMMPRCCHG]    Script Date: 09/29/2017 15:29:08 ******/
DROP PROCEDURE [dbo].[sp_select_ZMMPRCCHG]
GO
/****** Object:  StoredProcedure [dbo].[sp_select_ZMMPRCCHG]    Script Date: 09/29/2017 15:29:10 ******/
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


CREATE PROCEDURE [dbo].[sp_select_ZMMPRCCHG] 
@cocde	nvarchar(4),
@ventyp	nvarchar(4)
AS

begin
select 
--distinct
ibi_itmno as 'ITMNO',
D.imu_pckunt as 'UM_HKERP',
D.imu_inrqty as 'INR',
D.imu_mtrqty as 'MTR',
isnull(D.imu_venno,'') as 'DV',
isnull(DV.vbi_vensna,'') as 'DV_NAME',
isnull(P.imu_prdven,'') as 'PV',
isnull(PV.vbi_vensna,'') as 'PV_NAME',
D.imu_curcde as 'CURR',
D.imu_ftycst as 'FTYCST',
isnull(P.imu_ftybomcst,0) as 'FTYBOMCST',
--D.imu_ftyprc as 'FTYPRC',
case when isnull(P.imu_negprc,0) > 0 then isnull(P.imu_negprc,0) else isnull(P.imu_calftyprc,0) end as 'PRC',
--isnull(P.imu_negprc,0) as 'NEGPRC',
--isnull(P.imu_calftyprc,0) as 'CALFTYPRC'
'' as 'ORDER'

from IMBASINF(nolock)
left join IMMRKUP as D (nolock) on ibi_itmno = D.imu_itmno and D.imu_ventyp = 'D'
left join IMMRKUP as P (nolock) on D.imu_itmno = P.imu_itmno and P.imu_ventyp = 'P' --and D.imu_venno = P.imu_prdven 
and D.imu_pckunt = P.imu_pckunt and P.imu_prdven in  ('A','B','U','W')
and D.imu_inrqty = P.imu_inrqty and D.imu_mtrqty = P.imu_mtrqty
left join VNBASINF as DV (nolock) on D.imu_venno = DV.vbi_venno 
left join VNBASINF as PV (nolock) on P.imu_prdven = PV.vbi_venno 

where
(
--Internal
--(@ventyp = 'I' and DV.vbi_ventyp = 'I'  and DV.vbi_venno not in ('A','B','U','W')) or
--Joint Venture
--Only Handle Vendor G for Type J
(@ventyp = 'J' and DV.vbi_ventyp = 'J'  and DV.vbi_venno not in ('A','B','U','W') and DV.vbi_venno = 'G' ) or
--A, B, U, W
(@ventyp = 'ABUW' and DV.vbi_venno in ('A','B','U','W')) 
--External
--(@ventyp = 'E' and DV.vbi_ventyp = 'E'  )
)

and ibi_itmsts = 'CMP'
/*
and len(ibi_itmno) = 13
and charindex('-',ibi_itmno) <= 0
and charindex('/',ibi_itmno) <= 0
and charindex('\',ibi_itmno) <= 0
*/
and P.imu_prdven <> ''


/*
group by
ibi_itmno ,
D.imu_pckunt ,
D.imu_inrqty,
D.imu_mtrqty,
D.imu_venno ,
P.imu_venno ,
D.imu_curcde ,
D.imu_ftycst ,
D.imu_ftyprc ,
P.imu_negprc
having count(*) > 1
*/
order by ibi_itmno, D.imu_pckunt, D.imu_inrqty,D.imu_mtrqty,D.imu_venno,P.imu_prdven asc

end


GO
GRANT EXECUTE ON [dbo].[sp_select_ZMMPRCCHG] TO [ERPUSER] AS [dbo]
GO
