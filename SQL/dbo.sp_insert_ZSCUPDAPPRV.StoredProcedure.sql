/****** Object:  StoredProcedure [dbo].[sp_insert_ZSCUPDAPPRV]    Script Date: 09/29/2017 15:29:09 ******/
DROP PROCEDURE [dbo].[sp_insert_ZSCUPDAPPRV]
GO
/****** Object:  StoredProcedure [dbo].[sp_insert_ZSCUPDAPPRV]    Script Date: 09/29/2017 15:29:09 ******/
SET ANSI_NULLS OFF
GO
SET QUOTED_IDENTIFIER OFF
GO




/************************************************************************
Author:		Mark Lau    
Date:		2009-11-19
Description:	Insert data into ZSCUPDAPPRV
************************************************************************/

CREATE PROCEDURE [dbo].[sp_insert_ZSCUPDAPPRV] 
--------------------------------------------------------------------------------------------------------------------------------------


@zsa_cocde	nvarchar(6),
@zsa_vbeln	nvarchar(30),
@zsa_posnr	nvarchar(6),
@zsa_upljobno	nvarchar(30),
@zsa_scno	nvarchar(30),
@zsa_scseq	int,
@zsa_jobord	nvarchar(30),
@zsa_itmno	nvarchar(30),
@zsa_werks	nvarchar(6),
@zsa_flghkupdreq nvarchar(1),
@zsa_hkupdrequsr nvarchar(30) ,
@zsa_hkupdreqdat nvarchar(30) ,
@zsa_hkupdreqtim nvarchar(30) ,
@zsa_hkupdreason nvarchar(255) ,
@zsa_flgywapprv	nvarchar(1),
@zsa_ywapprvusr	nvarchar(30),
@zsa_ywapprvdat	nvarchar(30),
@zsa_ywapprvtim	nvarchar(30),
@zsa_flgscapprv	nvarchar(1),
@zsa_scapprvusr	nvarchar(30),
@zsa_scapprvdat	nvarchar(30),
@zsa_scapprvtim	nvarchar(30),
@usr	nvarchar(30)
--------------------------------------------------------------------------------------------------------------------------------------
AS

--delete from ZSCUPDAPPRV

insert into ZSCUPDAPPRV
(
zsa_cocde,
zsa_vbeln,
zsa_posnr,
zsa_upljobno,
zsa_scno,
zsa_scseq,
zsa_jobord,
zsa_itmno,
zsa_werks,
zsa_flghkupdreq ,
zsa_hkupdrequsr ,
zsa_hkupdreqdat  ,
zsa_hkupdreqtim  ,
zsa_hkupdreason ,
zsa_flgywapprv,
zsa_ywapprvusr,
zsa_ywapprvdat,
zsa_ywapprvtim,
zsa_flgscapprv,
zsa_scapprvusr,
zsa_scapprvdat,
zsa_scapprvtim,
zsa_credat,
zsa_creusr,
zsa_upddat,
zsa_updusr
)
values
(
@zsa_cocde	,
@zsa_vbeln	,
@zsa_posnr	,
@zsa_upljobno	,
@zsa_scno	,
@zsa_scseq	,
@zsa_jobord	,
@zsa_itmno	,
@zsa_werks	,
@zsa_flghkupdreq ,
@zsa_hkupdrequsr ,
@zsa_hkupdreqdat  ,
@zsa_hkupdreqtim  ,
@zsa_hkupdreason ,
@zsa_flgywapprv	,
@zsa_ywapprvusr	,
@zsa_ywapprvdat	,
@zsa_ywapprvtim	,
@zsa_flgscapprv,
@zsa_scapprvusr,
@zsa_scapprvdat,
@zsa_scapprvtim,
getdate(),
@usr,
getdate(),
@usr
)






GO
GRANT EXECUTE ON [dbo].[sp_insert_ZSCUPDAPPRV] TO [ERPUSER] AS [dbo]
GO
