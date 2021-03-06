/****** Object:  StoredProcedure [dbo].[sp_select_SCFTYDAT]    Script Date: 09/29/2017 15:29:09 ******/
DROP PROCEDURE [dbo].[sp_select_SCFTYDAT]
GO
/****** Object:  StoredProcedure [dbo].[sp_select_SCFTYDAT]    Script Date: 09/29/2017 15:29:10 ******/
SET ANSI_NULLS OFF
GO
SET QUOTED_IDENTIFIER OFF
GO










/*
=========================================================
Program ID	: sp_select_SCFTYDAT
Description   	: 
Programmer  	: Frankie Cheung
Create Date   	:
Last Modified  	: 
Table Read(s) 	:
Table Write(s) 	:
=========================================================
 Modification History                                    
=========================================================
Date		Author		Description
=========================================================     
*/

CREATE   procedure [dbo].[sp_select_SCFTYDAT]

@cocde	nvarchar(6)

AS

BEGIN

select 

	sfd_sapno,
	sfd_sapln,
	sfd_jobord,
	sfd_itmno,
	sfd_um,
	sfd_inrqty,
	sfd_mtrqty,
	sfd_pckitr,
	-- Added by Mark Lau 20090119
	sfd_apprvflg,
	sfd_apprvdt,
	sfd_apprvtim,
	sfd_apprvpv,
	-- Added by Mark Lau 20090325
	sfd_wtpv ,
	sfd_zi01,
	-- Added by Mark Lau 20090423
	sfd_zi01_cur,
	sfd_zi02,
	-- Added by Mark Lau 20090423
	sfd_zi02_cur,	
	sfd_zi03,
	sfd_zi03_cur,
	-- Added by Mark Lau 20090317
	sfd_zi04,
	sfd_zi05,
	sfd_zi04_cur,
	sfd_zi05_cur,
	-- Added by Mark Lau 20090320
	sfd_pv,
	sfd_cv,
	sfd_dv,
	-- Added by Mark Lau 20090325
	sfd_flgzpp19 ,
	sfd_cstchg ,
	sfd_cstchgdat ,
	sfd_cstchgtim ,
	-- Added by Mark Lau 20090904
	sfd_zapcstuf,
	sfd_zapcstud,
	sfd_zapcstut,
	sfd_zapcstuc,
	sfd_zapcstcf,
	sfd_zapcstcd,
	sfd_zapcstct,
	sfd_zapcstcc,
	sfd_zapprwtcv,
	sfd_zflgapprcv,
	sfd_zapprcvdat,
	sfd_zapprcvtim



 from 
	SCFTYDAT

END


GO
GRANT EXECUTE ON [dbo].[sp_select_SCFTYDAT] TO [ERPUSER] AS [dbo]
GO
