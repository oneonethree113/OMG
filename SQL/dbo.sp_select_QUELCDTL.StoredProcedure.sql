/****** Object:  StoredProcedure [dbo].[sp_select_QUELCDTL]    Script Date: 09/29/2017 15:29:09 ******/
DROP PROCEDURE [dbo].[sp_select_QUELCDTL]
GO
/****** Object:  StoredProcedure [dbo].[sp_select_QUELCDTL]    Script Date: 09/29/2017 15:29:10 ******/
SET ANSI_NULLS OFF
GO
SET QUOTED_IDENTIFIER OFF
GO










/************************************************************************
Author:		Lester Wu    
Date:		28th September, 2008
Description:	Select data From QUELCDTL
***********************************************************************
*/

CREATE procedure [dbo].[sp_select_QUELCDTL]


@qed_cocde	nvarchar(6),
@qed_qutno	nvarchar(20)

 
AS

BEGIN

--------------------------------------------------------------------------------------------------

declare @custno nvarchar(6)
declare @cus1no nvarchar(6)
declare @cus2no nvarchar(6)

select @cus2no =  quh_cus2no ,  @cus1no =  quh_cus1no
from QUOTNHDR where quh_cocde = @qed_cocde and quh_qutno = @qed_qutno


if (select count(*) from cuelcdtl where ced_cusno = @custno ) > 0 
begin
set @custno  = @cus2no
end
else
begin
set @custno  = @cus1no
end

SELECT	
qed_cocde,
qed_qutno,
qed_qutseq,

qed_grpcde,
cec_grpdsc as 'ced_grpdsc',
qed_seq,
qed_cecde,
ysi_dsc as 'ced_cedsc',
qed_percent,
qed_curcde,
qed_amt,
ced_chg,
'' as 'mode'
from QUELCDTL
left join cuelcdtl on ced_seq = qed_seq and  ced_grpcde = qed_grpcde and ced_cusno = @custno
left join CUELC on cec_grpcde = ced_grpcde and cec_cusno = @custno
left join SYSETINF on ysi_cde = ced_cecde and ysi_typ = '17'
where	
qed_cocde = @qed_cocde and qed_qutno = @qed_qutno
order by  qed_cocde,qed_grpcde, qed_seq asc

END


GO
GRANT EXECUTE ON [dbo].[sp_select_QUELCDTL] TO [ERPUSER] AS [dbo]
GO
