/****** Object:  StoredProcedure [dbo].[sp_select_QUOTNHDR_search]    Script Date: 09/29/2017 15:29:09 ******/
DROP PROCEDURE [dbo].[sp_select_QUOTNHDR_search]
GO
/****** Object:  StoredProcedure [dbo].[sp_select_QUOTNHDR_search]    Script Date: 09/29/2017 15:29:10 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO






CREATE PROCEDURE [dbo].[sp_select_QUOTNHDR_search]

@quh_cocde	nvarchar(6),
@quh_cus1no	nvarchar(6),
@quh_cus2no	nvarchar(6),
@quh_creusr	nvarchar(30)

AS

select 	quh_qutno, isnull(quh_cus2no + ' - ' + cbi_cussna,'') as 'quh_cus2no' ,
	isnull(ysr_code1+ ' - ' + ysr_dsc + ' (TEAM '+ ysr_saltem + ')','')  as 'quh_salrep',
	quh_updusr, quh_upddat
from quotnhdr 
left join CUBASINF on
	--cbi_cocde = quh_cocde and 
		cbi_cusno = quh_cus2no
left join SYSALREP on
	--ysr_cocde = quh_cocde and 
		ysr_code1 = quh_salrep
where 	quh_cocde = @quh_cocde and quh_cus1no = @quh_cus1no and 
	quh_cus2no between 
	(case @quh_cus2no when '' then '' else @quh_cus2no end)
		and
	(case @quh_cus2no when '' then 'ZZZZZZ' else @quh_cus2no end)





GO
GRANT EXECUTE ON [dbo].[sp_select_QUOTNHDR_search] TO [ERPUSER] AS [dbo]
GO
