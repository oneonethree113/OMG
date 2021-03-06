/****** Object:  StoredProcedure [dbo].[sp_insert_SHCBNDTL]    Script Date: 09/29/2017 15:29:09 ******/
DROP PROCEDURE [dbo].[sp_insert_SHCBNDTL]
GO
/****** Object:  StoredProcedure [dbo].[sp_insert_SHCBNDTL]    Script Date: 09/29/2017 15:29:09 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO




-- Checked by Allan Yuen at 27/07/2003
-- 2004-08-12 Fix color code length error.

------------------------------------------------- 
CREATE procedure [dbo].[sp_insert_SHCBNDTL]
                                                                                                                                                                                                                                                                 
---------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------- 
@hnd_cocde	nvarchar(6),
@hnd_noteno	nvarchar(20),
@hnd_seq	int,
@hnd_lnetyp	nvarchar(1),
@hnd_invlne	int,
@hnd_itmno	nvarchar(20),
@hnd_itmdsc	nvarchar(200),
@hnd_colcde	nvarchar(30),
@hnd_coldsc	nvarchar(200),
@hnd_cusitm	nvarchar(20),
@hnd_cussku	nvarchar(20),
@hnd_mannam	nvarchar(20),
@hnd_manadr	nvarchar(200),
@hnd_pckunt	nvarchar(4),
@hnd_inrctn	nvarchar(20),
@hnd_mtrctn	nvarchar(20),
@hnd_cft	numeric(7,4),
@hnd_curcde	nvarchar(6),
@hnd_adjprc	numeric(7,4),
@hnd_adjqty	int,
@hnd_upd	nvarchar(1),
@hnd_rmk	nvarchar(200),
@hnd_ordno	nvarchar(20),
@hnd_updusr nvarchar(30)
AS
insert into  SHCBNDTL
(
hnd_cocde,	
hnd_noteno,
hnd_seq,
hnd_lnetyp,
hnd_invlne,
hnd_itmno,
hnd_itmdsc,
hnd_colcde,
hnd_coldsc,
hnd_cusitm,
hnd_cussku,
hnd_mannam,
hnd_manadr,
hnd_pckunt,
hnd_inrctn,
hnd_mtrctn,
hnd_cft,	
hnd_curcde,
hnd_adjprc,
hnd_adjqty,
hnd_upd,	
hnd_rmk,
hnd_ordno,
hnd_creusr,
hnd_updusr,
hnd_credat,
hnd_upddat
) VALUES (
@hnd_cocde,	
@hnd_noteno,
@hnd_seq,
@hnd_lnetyp,
@hnd_invlne,
@hnd_itmno,
@hnd_itmdsc,
@hnd_colcde,
@hnd_coldsc,
@hnd_cusitm,
@hnd_cussku,
@hnd_mannam,
@hnd_manadr,
@hnd_pckunt,
@hnd_inrctn,
@hnd_mtrctn,
@hnd_cft,	
@hnd_curcde,
@hnd_adjprc,
@hnd_adjqty,
@hnd_upd,	
@hnd_rmk,
@hnd_ordno,
@hnd_updusr,
@hnd_updusr,
getdate(),
getdate()
)     
---------------------------------------------------------------------------------------------------------------------------------------------------------------------







GO
GRANT EXECUTE ON [dbo].[sp_insert_SHCBNDTL] TO [ERPUSER] AS [dbo]
GO
