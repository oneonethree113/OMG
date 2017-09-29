/****** Object:  StoredProcedure [dbo].[sp_select_CUBASINFRIGHT]    Script Date: 09/29/2017 15:29:09 ******/
DROP PROCEDURE [dbo].[sp_select_CUBASINFRIGHT]
GO
/****** Object:  StoredProcedure [dbo].[sp_select_CUBASINFRIGHT]    Script Date: 09/29/2017 15:29:10 ******/
SET ANSI_NULLS OFF
GO
SET QUOTED_IDENTIFIER OFF
GO






CREATE procedure [dbo].[sp_select_CUBASINFRIGHT]
                                                                                                                                                                                                                                                                 

@gsCompany	nvarchar(6),
@Sale		nvarchar(8)
                                               
 
AS

BEGIN

select distinct(ysr_code1)  from SYSALREP 
where ysr_saltem = (select ysr_saltem from SYSALREP where ysr_code = @Sale )
and ysr_cocde = @gsCompany

END





GO
GRANT EXECUTE ON [dbo].[sp_select_CUBASINFRIGHT] TO [ERPUSER] AS [dbo]
GO
