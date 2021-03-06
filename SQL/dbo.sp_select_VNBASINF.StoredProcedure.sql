/****** Object:  StoredProcedure [dbo].[sp_select_VNBASINF]    Script Date: 09/29/2017 15:29:08 ******/
DROP PROCEDURE [dbo].[sp_select_VNBASINF]
GO
/****** Object:  StoredProcedure [dbo].[sp_select_VNBASINF]    Script Date: 09/29/2017 15:29:10 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO








-- Checked by Allan Yuen at 28/07/2003


CREATE procedure [dbo].[sp_select_VNBASINF]
                                                                                                                                                                                                                                                               
@vbi_cocde nvarchar(6) ,
@vbi_venno nvarchar(6) 
AS

Select 
vbi_cocde,
vbi_venno,
vbi_vensts,
vbi_vensna,
vbi_vennam,
vbi_venrat,
vbi_prctrm,
vbi_paytrm,
vbi_curcde,
vbi_discnt,
vbi_orgven,
vbi_rmk,
vbi_ledtim,
vbi_tsttim,
vbi_bufday,
vbi_venweb,
vbi_ventyp,
vbi_moqchg,
vbi_frurcde,
vbi_framt,
-- Added by Mark Lau 20081027
isnull(vbi_venchnnam,'') as 'vbi_venchnnam',
vbi_venfty,
vbi_ventranflg, --added by BN 09122013
vbi_venflag, --added by BN 10092013
vbi_creusr,
vbi_updusr,
vbi_credat,
vbi_upddat,
cast(vbi_timstp as int) as vbi_timstp

from VNBASINF
where                                                                                                                                                                                                                                                                 
-- vbi_cocde = @vbi_cocde and
vbi_cocde = ' ' and
 vbi_venno = @vbi_venno



GO
GRANT EXECUTE ON [dbo].[sp_select_VNBASINF] TO [ERPUSER] AS [dbo]
GO
