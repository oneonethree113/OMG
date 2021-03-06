/****** Object:  StoredProcedure [dbo].[sp_insert_VBAK]    Script Date: 09/29/2017 15:29:09 ******/
DROP PROCEDURE [dbo].[sp_insert_VBAK]
GO
/****** Object:  StoredProcedure [dbo].[sp_insert_VBAK]    Script Date: 09/29/2017 15:29:09 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create procedure [dbo].[sp_insert_VBAK] 
@MANDT	nvarchar(10),
@VBELN	nvarchar(20),
@ERDAT	datetime,
@ERZET	nvarchar(20),
@ERNAM	nvarchar(20),
@AUDAT	datetime,
@VBTYP	char(1),
@AUART	nvarchar(10),
@WAERK	nvarchar(10),
@VKORG	nvarchar(10),
@VTWEG	nvarchar(10),
@SPART	nvarchar(10),
@VKGRP	nvarchar(10),
@VKBUR	nvarchar(10),
@KNUMV	nvarchar(10),
@VDATU	datetime,
@BSTNK	nvarchar(20),
@IHREZ	nvarchar(20),
@KUNNR	nvarchar(10),
@AEDAT	nvarchar(20),
@KVGR1	nvarchar(10),
@BUKRS_VF	nvarchar(10),
@FMBDAT	nvarchar(20),
@usrid nvarchar(30)

as

insert into VBAK
(
MANDT,
VBELN,
ERDAT,
ERZET,
ERNAM,
AUDAT,
VBTYP,
AUART,
WAERK,
VKORG,
VTWEG,
SPART,
VKGRP,
VKBUR,
KNUMV,
VDATU,
BSTNK,
IHREZ,
KUNNR,
AEDAT,
KVGR1,
BUKRS_VF,
FMBDAT,
creusr,
updusr,
credat,
upddat
)
values
(
@MANDT,
@VBELN,
@ERDAT,
@ERZET,
@ERNAM,
@AUDAT,
@VBTYP,
@AUART,
@WAERK,
@VKORG,
@VTWEG,
@SPART,
@VKGRP,
@VKBUR,
@KNUMV,
@VDATU,
@BSTNK,
@IHREZ,
@KUNNR,
@AEDAT,
@KVGR1,
@BUKRS_VF,
@FMBDAT,
@usrid,
@usrid,
getdate(),
getdate()
)



GO
GRANT EXECUTE ON [dbo].[sp_insert_VBAK] TO [ERPUSER] AS [dbo]
GO
