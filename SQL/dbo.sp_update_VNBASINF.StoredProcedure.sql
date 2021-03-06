/****** Object:  StoredProcedure [dbo].[sp_update_VNBASINF]    Script Date: 09/29/2017 15:29:08 ******/
DROP PROCEDURE [dbo].[sp_update_VNBASINF]
GO
/****** Object:  StoredProcedure [dbo].[sp_update_VNBASINF]    Script Date: 09/29/2017 15:29:10 ******/
SET ANSI_NULLS OFF
GO
SET QUOTED_IDENTIFIER ON
GO










-- Checked by Allan Yuen at 28/07/2003



CREATE PROCEDURE [dbo].[sp_update_VNBASINF] 
--------------------------------------------------------------------------------------------------------------------------------------
@vbi_cocde 	nvarchar(6),
@vbi_venno	nvarchar(6),
@vbi_vensts	nvarchar(1),
@vbi_vensna	nvarchar(40),
@vbi_vennam	nvarchar(100),
@vbi_venrat	nvarchar(1),
@vbi_prctrm	nvarchar(20),
@vbi_paytrm	nvarchar(20),
@vbi_curcde	nvarchar(4),
@vbi_discnt	numeric(6,3),
@vbi_orgven	nvarchar(6),
@vbi_rmk	nvarchar(800),
@vbi_ledtim	int,
@vbi_tsttim	int,
@vbi_bufday	int,
@vbi_venweb	nvarchar(100),
@vbi_ventyp	char(1),
@vbi_moqchg	char(1),
@vbi_frurcde   nvarchar(10),
@vbi_framt	int,
-- Added by Mark Lau 20081027
@vbi_venchnnam	nvarchar(255),
@vbi_venfty	char(1),
@vbi_ventranflg char(1),
@vbi_venflag	nvarchar(10),
@vbi_updusr	nvarchar(30)
--------------------------------------------------------------------------------------------------------------------------------------
AS

update VNBASINF set

vbi_vensts 	= @vbi_vensts,
vbi_vensna 	= @vbi_vensna,
vbi_vennam 	= @vbi_vennam,
vbi_venrat 	= @vbi_venrat,
vbi_prctrm 	= @vbi_prctrm,
vbi_paytrm 	= @vbi_paytrm,
vbi_curcde 	= @vbi_curcde,
vbi_discnt 	= @vbi_discnt,
vbi_orgven 	= @vbi_orgven,
vbi_rmk 		= @vbi_rmk,
vbi_ledtim	= @vbi_ledtim,
vbi_tsttim 	= @vbi_tsttim,
vbi_bufday 	= @vbi_bufday,
vbi_venweb	= @vbi_venweb,
vbi_updusr	= @vbi_updusr,
vbi_ventyp = @vbi_ventyp,
vbi_moqchg = @vbi_moqchg,
vbi_frurcde    = @vbi_frurcde,
vbi_framt	= @vbi_framt	,
-- Added by Mark Lau 20081027
vbi_venchnnam = @vbi_venchnnam,
vbi_venfty = @vbi_venfty,
vbi_ventranflg = @vbi_ventranflg,
vbi_venflag = @vbi_venflag,
vbi_upddat	= getdate()
--------------------------------------------------------------------------------------------------------------------------------------
where 

--vbi_cocde	= @vbi_cocde and 
--vbi_cocde	= ' ' and 
vbi_venno 	= @vbi_venno
--------------------------------------------------------------------------------------------------------------------------------------

GO
GRANT EXECUTE ON [dbo].[sp_update_VNBASINF] TO [ERPUSER] AS [dbo]
GO
