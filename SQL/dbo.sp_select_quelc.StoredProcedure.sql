/****** Object:  StoredProcedure [dbo].[sp_select_quelc]    Script Date: 09/29/2017 15:29:09 ******/
DROP PROCEDURE [dbo].[sp_select_quelc]
GO
/****** Object:  StoredProcedure [dbo].[sp_select_quelc]    Script Date: 09/29/2017 15:29:10 ******/
SET ANSI_NULLS OFF
GO
SET QUOTED_IDENTIFIER OFF
GO




/************************************************************************
Author:		Lester Wu    
Date:		28th September, 2008
Description:	Select data From QUELC
***********************************************************************
*/

CREATE procedure [dbo].[sp_select_quelc]


@qec_cocde	nvarchar(6),
@qec_qutno	nvarchar(20)

 
AS

BEGIN

declare @custno nvarchar(6)
declare @cus1no nvarchar(6)
declare @cus2no nvarchar(6)

select @cus2no =  quh_cus2no ,  @cus1no =  quh_cus1no
from QUOTNHDR where quh_cocde = @qec_cocde and quh_qutno = @qec_qutno


if (select count(*) from CUELC where cec_cusno = @cus2no ) > 0 
begin
set @custno  = @cus2no
end
else
begin
set @custno  = @cus1no
end



select
qec_cocde,
qec_qutno,
qec_qutseq,
qec_grpcde,
isnull(cec_grpdsc,'') as 'cec_grpdsc',
isnull(qec_curcde,'') as 'qec_curcde',
isnull(qec_amt,0) as 'qec_amt',
'' as 'mode'
from
quelc
left join cuelc on cec_grpcde = qec_grpcde and cec_cusno = @custno
where	
qec_cocde = @qec_cocde and qec_qutno = @qec_qutno
order by qec_cocde, qec_qutno, qec_qutseq asc

END


GO
GRANT EXECUTE ON [dbo].[sp_select_quelc] TO [ERPUSER] AS [dbo]
GO
