/****** Object:  StoredProcedure [dbo].[sp_select_QUR00002]    Script Date: 09/29/2017 15:29:09 ******/
DROP PROCEDURE [dbo].[sp_select_QUR00002]
GO
/****** Object:  StoredProcedure [dbo].[sp_select_QUR00002]    Script Date: 09/29/2017 15:29:10 ******/
SET ANSI_NULLS OFF
GO
SET QUOTED_IDENTIFIER OFF
GO


CREATE PROCEDURE [dbo].[sp_select_QUR00002] 

 	@cocde 		nvarchar(6),
	@CustNoFm	nvarchar(6),
	@CustNoTo	nvarchar(6),
	@fromdate	datetime,
	@todate		datetime,
	@status 		nvarchar(3),
	@sort		nvarchar(1)
	
AS

DECLARE
	@CC	nvarchar(1)

set @CC = 'N'
	If @CustNoFm = '' and @CustNoTo = ''
	begin
		set @CC = 'Y'
	end

select 	
	@CustNoFm,	@CustNoTo,
	@fromdate,	@todate,
	@status,
	quh_cocde,
	Cust1_No = quh_cus1no,
	Cust1_ShortName = isnull(a.cbi_cussna, '') ,
	Cust2_No = quh_cus2no, 	
	Cust2_ShortName = isnull(b.cbi_cussna,''), 
	quh_qutno, 	
	quh_qutsts, 
	Status = (case quh_qutsts when 'A' then 'Active' 
	 		when 'E' then 'Expired' 
			else 'Wait for Approve' end),
	quh_issdat	

from 	QUOTNHDR
left join	CUBASINF a on	
	quh_cocde = a.cbi_cocde and quh_cus1no = a.cbi_cusno
left join	CUBASINF b on
	quh_cocde = b.cbi_cocde and quh_cus2no = b.cbi_cusno
where	quh_cocde = @cocde 
	and quh_issdat between @fromdate and @todate
	and ((@CC = 'N' and quh_cus1no between @CustNoFm and @CustNoTo) or @CC = 'Y')
	and quh_qutsts between (case @status when 'ALL' then 'A' else @status end) and (case @status when 'ALL' then 'Z' else @status end)

order by	(case @sort when 'Q' then quh_qutno else quh_cus1no end)


GO
GRANT EXECUTE ON [dbo].[sp_select_QUR00002] TO [ERPUSER] AS [dbo]
GO
