/****** Object:  StoredProcedure [dbo].[sp_insert_VNITMNAT]    Script Date: 09/29/2017 15:29:09 ******/
DROP PROCEDURE [dbo].[sp_insert_VNITMNAT]
GO
/****** Object:  StoredProcedure [dbo].[sp_insert_VNITMNAT]    Script Date: 09/29/2017 15:29:09 ******/
SET ANSI_NULLS OFF
GO
SET QUOTED_IDENTIFIER OFF
GO




CREATE procedure [dbo].[sp_insert_VNITMNAT]
                                                                                                                                                                                                                                                                 
---------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------- 
@vin_cocde 	nvarchar(6),
@vin_venno  	nvarchar(6),
@vin_natcde	nvarchar(6),
@vin_natdsc	nvarchar(200),
@vin_creusr	nvarchar(30)
                                 
----------------------------------- 
AS

BEGIN

declare @vin_natseq as int

Select @vin_natseq =  (select  isnull(max(vin_natseq),0) + 1  from VNITMNAT where vin_venno = @vin_venno)

Insert into VNITMNAT
(
	vin_cocde,
	vin_venno,
	vin_natseq,
	vin_natcde,
	vin_creusr,
	vin_updusr,
	vin_credat,
	vin_upddat
)
values
(
	' ',
	@vin_venno,
	@vin_natseq,
	@vin_natcde,
	@vin_creusr,
	@vin_creusr,
	getdate(),
	getdate()
)

END





GO
GRANT EXECUTE ON [dbo].[sp_insert_VNITMNAT] TO [ERPUSER] AS [dbo]
GO
