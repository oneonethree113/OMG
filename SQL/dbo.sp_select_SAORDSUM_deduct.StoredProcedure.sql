/****** Object:  StoredProcedure [dbo].[sp_select_SAORDSUM_deduct]    Script Date: 09/29/2017 15:29:09 ******/
DROP PROCEDURE [dbo].[sp_select_SAORDSUM_deduct]
GO
/****** Object:  StoredProcedure [dbo].[sp_select_SAORDSUM_deduct]    Script Date: 09/29/2017 15:29:10 ******/
SET ANSI_NULLS OFF
GO
SET QUOTED_IDENTIFIER OFF
GO



CREATE PROCEDURE [dbo].[sp_select_SAORDSUM_deduct] 

@sas_cocde 	nvarchar(6),	@sas_cus1no	nvarchar(6),
@sas_itmno	nvarchar(20),	@sas_colcde	nvarchar(30),
@sas_creusr	nvarchar(30)

AS

select 	sas_smpqty,	sas_stkqty,		sas_cusqty,
	cast(sas_cusqty as int) - cast(sas_shpqty as int) as 'sas_osqty'
from 	SAORDSUM
where 
--sas_cocde = @sas_cocde and  
--sas_cus1no = @sas_cus1no and 
--sas_itmno = @sas_itmno and 
sas_cus1no  in (select cbi_cusno from cubasinf where cbi_cusno = @sas_cus1no or cbi_cusali =  @sas_cus1no) and
sas_itmno in
	(Select ibi_itmno  from imbasinf where ibi_itmno = @sas_itmno or ibi_alsitmno = @sas_itmno
		union
	select bas.ibi_alsitmno from imbasinf bas left join imbasinf als on bas.ibi_alsitmno = als.ibi_itmno where bas.ibi_itmno = @sas_itmno and als.ibi_itmsts <> 'OLD') and
sas_colcde = @sas_colcde



GO
GRANT EXECUTE ON [dbo].[sp_select_SAORDSUM_deduct] TO [ERPUSER] AS [dbo]
GO
