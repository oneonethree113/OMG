/****** Object:  StoredProcedure [dbo].[sp_list_VNBASINF_ventyp]    Script Date: 09/29/2017 15:29:09 ******/
DROP PROCEDURE [dbo].[sp_list_VNBASINF_ventyp]
GO
/****** Object:  StoredProcedure [dbo].[sp_list_VNBASINF_ventyp]    Script Date: 09/29/2017 15:29:10 ******/
SET ANSI_NULLS OFF
GO
SET QUOTED_IDENTIFIER OFF
GO


--Frankie Cheung 20090813 - Add Vendor type parameter

CREATE procedure [dbo].[sp_list_VNBASINF_ventyp]
	@vbi_cocde nvarchar(6), 
	@ventyp nvarchar(1)
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
vbi_creusr,
vbi_updusr,
vbi_credat,
vbi_upddat,
cast(vbi_timstp as int) as vbi_timstp,
vbi_ventyp

from 
	VNBASINF
where
 vbi_cocde = ' ' and
 vbi_vensts <> 'D' and
 vbi_ventyp = @ventyp
order by vbi_venno


GO
GRANT EXECUTE ON [dbo].[sp_list_VNBASINF_ventyp] TO [ERPUSER] AS [dbo]
GO
