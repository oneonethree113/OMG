/****** Object:  StoredProcedure [dbo].[sp_insert_SYUSRGRPDESC]    Script Date: 09/29/2017 15:29:09 ******/
DROP PROCEDURE [dbo].[sp_insert_SYUSRGRPDESC]
GO
/****** Object:  StoredProcedure [dbo].[sp_insert_SYUSRGRPDESC]    Script Date: 09/29/2017 15:29:09 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO




/************************************************************************
Author:		Louis Siu
Date:		20th Dev, 2001
Description:	Insert data into SYUSRGRP
Parameter:
************************************************************************/


------------------------------------------------- 
CREATE PROCEDURE [dbo].[sp_insert_SYUSRGRPDESC] 
                                                                                                                                                                                                                                                                 
---------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------- 
@yug_cocde 	nvarchar(6),
@yug_usrgrp  	nvarchar(6),
@yug_usrfun	nvarchar(10),
@yug_fundsc	nvarchar(50),
@yug_assrig	nvarchar(4),
@yug_creusr	nvarchar(30),
@yug_grpdsc	nvarchar(100)

AS

declare @yug_funseq	int

Set  @yug_funseq = (Select isnull(max(yug_funseq),0)  + 1 from SYUSRGRP where --yug_cocde = @yug_cocde and 
								yug_usrgrp = @yug_usrgrp)

insert into  SYUSRGRP
(	
	yug_cocde,	yug_usrgrp,	yug_usrfun,
	yug_fundsc,	yug_assrig,	yug_creusr,
	yug_updusr,	yug_credat,	yug_upddat,
	yug_funseq, 	yug_grpdsc
)
values
(
	@yug_cocde,	@yug_usrgrp, 	@yug_usrfun,
	@yug_fundsc,	@yug_assrig,	@yug_creusr,
	@yug_creusr,	getdate(),		getdate(),
	@yug_funseq,	@yug_grpdsc
)      
---------------------------------------------------------------------------------------------------------------------------------------------------------------------






GO
GRANT EXECUTE ON [dbo].[sp_insert_SYUSRGRPDESC] TO [ERPUSER] AS [dbo]
GO
