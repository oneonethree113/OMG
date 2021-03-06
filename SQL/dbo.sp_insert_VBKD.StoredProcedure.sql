/****** Object:  StoredProcedure [dbo].[sp_insert_VBKD]    Script Date: 09/29/2017 15:29:09 ******/
DROP PROCEDURE [dbo].[sp_insert_VBKD]
GO
/****** Object:  StoredProcedure [dbo].[sp_insert_VBKD]    Script Date: 09/29/2017 15:29:09 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create procedure [dbo].[sp_insert_VBKD] 
@MANDT	nvarchar(10),
@VBELN	nvarchar(20),
@POSNR	nvarchar(6),
@BSTKD_E	nvarchar(35),
@usrid	nvarchar(30)--,
--@updusr	nvarchar(30),
--@credat	datetime,
--@upddat	datetime

as

insert into VBKD
(
MANDT,
VBELN,
POSNR,
BSTKD_E,
creusr,
updusr,
credat,
upddat
)
values
(
@MANDT,
@VBELN,
@POSNR,
@BSTKD_E,
@usrid,
@usrid,
getdate(),
getdate()
)



GO
GRANT EXECUTE ON [dbo].[sp_insert_VBKD] TO [ERPUSER] AS [dbo]
GO
