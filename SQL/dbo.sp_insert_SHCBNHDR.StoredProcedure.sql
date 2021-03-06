/****** Object:  StoredProcedure [dbo].[sp_insert_SHCBNHDR]    Script Date: 09/29/2017 15:29:09 ******/
DROP PROCEDURE [dbo].[sp_insert_SHCBNHDR]
GO
/****** Object:  StoredProcedure [dbo].[sp_insert_SHCBNHDR]    Script Date: 09/29/2017 15:29:09 ******/
SET ANSI_NULLS OFF
GO
SET QUOTED_IDENTIFIER OFF
GO




-- Checked by Allan Yuen at 27/07/2003


------------------------------------------------- 
CREATE procedure [dbo].[sp_insert_SHCBNHDR]
                                                                                                                                                                                                                                                                 
---------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------- 
@hnh_cocde	nvarchar(6),
@hnh_noteno	nvarchar(20),
@hnh_nottyp	nvarchar(1),
@hnh_refno	nvarchar(20),
@hnh_pricus	nvarchar(6),
@hnh_seccus	nvarchar(6),
@hnh_cusrel	nvarchar(1),
@hnh_biladr	nvarchar(200),
@hnh_bilstt	nvarchar(20),
@hnh_bilcty	nvarchar(20),
@hnh_bilzip	nvarchar(20),
@hnh_shpadr	nvarchar(200),
@hnh_shpstt	nvarchar(20),
@hnh_shpcty	nvarchar(20),
@hnh_shpzip	nvarchar(20),
@hnh_shpinr	nvarchar(200),
@hnh_prctrm	nvarchar(20),
@hnh_paytrm	nvarchar(20),
@hnh_ttlunt	nvarchar(4),
@hnh_ttlamt	numeric(9,4),
@hnh_smpshp	nvarchar(1),
@hnh_rmk	nvarchar(200),
@hnh_updusr nvarchar(30)
AS
insert into  SHCBNHDR
(
hnh_cocde,	
hnh_noteno,
hnh_nottyp,
hnh_notsts,
hnh_issdat,
hnh_refno,
hnh_pricus,
hnh_seccus,
hnh_cusrel,
hnh_biladr,
hnh_bilstt,
hnh_bilcty,
hnh_bilzip,
hnh_shpadr,
hnh_shpstt,
hnh_shpcty,
hnh_shpzip,
hnh_shpinr,
hnh_prctrm,
hnh_paytrm,
hnh_ttlunt,
hnh_ttlamt,
hnh_rmk,	
hnh_smpshp,
hnh_creusr,
hnh_updusr,
hnh_credat,
hnh_upddat
) VALUES (
@hnh_cocde,	
@hnh_noteno,
@hnh_nottyp,
'OPE',
GETDATE(),
@hnh_refno,
@hnh_pricus,
@hnh_seccus,
@hnh_cusrel,
@hnh_biladr,
@hnh_bilstt,
@hnh_bilcty,
@hnh_bilzip,
@hnh_shpadr,
@hnh_shpstt,
@hnh_shpcty,
@hnh_shpzip,
@hnh_shpinr,
@hnh_prctrm,
@hnh_paytrm,
@hnh_ttlunt,
@hnh_ttlamt,
@hnh_rmk,	
@hnh_smpshp,
@hnh_updusr,
@hnh_updusr,
getdate(),
getdate()
)     
---------------------------------------------------------------------------------------------------------------------------------------------------------------------





GO
GRANT EXECUTE ON [dbo].[sp_insert_SHCBNHDR] TO [ERPUSER] AS [dbo]
GO
