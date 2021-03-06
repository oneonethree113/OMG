/****** Object:  StoredProcedure [dbo].[sp_insert_CODYNSQL]    Script Date: 09/29/2017 15:29:09 ******/
DROP PROCEDURE [dbo].[sp_insert_CODYNSQL]
GO
/****** Object:  StoredProcedure [dbo].[sp_insert_CODYNSQL]    Script Date: 09/29/2017 15:29:09 ******/
SET ANSI_NULLS OFF
GO
SET QUOTED_IDENTIFIER OFF
GO






CREATE procedure [dbo].[sp_insert_CODYNSQL]
                                                                                                                                                                                                                                                                 
---------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------- 
@cds_cocde 	nvarchar(6),
@cds_usrid	nvarchar(30),
@cds_sqldsc	nvarchar(200),
@cds_sqlsta	nvarchar(3500)
                                   
AS

declare @cds_sqlseq int

Set  @cds_sqlseq = (Select isnull(max(cds_sqlseq),0)  + 1 from CODYNSQL 
	 	where cds_cocde = @cds_cocde and cds_usrid = @cds_usrid)

insert into  CODYNSQL
(	
	cds_cocde,	cds_usrid,	cds_sqlseq,
	cds_sqldsc,	cds_sqlsta,	cds_creusr,
	cds_updusr,	cds_credat,	cds_upddat
)
values
(
	@cds_cocde,	@cds_usrid,	@cds_sqlseq,
	@cds_sqldsc,	@cds_sqlsta,	@cds_usrid,
	@cds_usrid,	getdate(),		getdate()
)      
---------------------------------------------------------------------------------------------------------------------------------------------------------------------







GO
GRANT EXECUTE ON [dbo].[sp_insert_CODYNSQL] TO [ERPUSER] AS [dbo]
GO
