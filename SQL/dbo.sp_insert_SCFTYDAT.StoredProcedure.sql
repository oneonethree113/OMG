/****** Object:  StoredProcedure [dbo].[sp_insert_SCFTYDAT]    Script Date: 09/29/2017 15:29:09 ******/
DROP PROCEDURE [dbo].[sp_insert_SCFTYDAT]
GO
/****** Object:  StoredProcedure [dbo].[sp_insert_SCFTYDAT]    Script Date: 09/29/2017 15:29:09 ******/
SET ANSI_NULLS OFF
GO
SET QUOTED_IDENTIFIER OFF
GO












/*
=========================================================
Program ID	: sp_insert_SCFTYDAT
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

CREATE   procedure [dbo].[sp_insert_SCFTYDAT]

	@sfd_sapno	nvarchar(10),
	@sfd_sapln	nvarchar(6),
	@sfd_jobord	nvarchar(20),
	@sfd_itmno	nvarchar(20),
	@sfd_um	nvarchar(6),
	@sfd_inrqty	int,
	@sfd_mtrqty	int,
	@sfd_pckitr	nvarchar(20),
	-- Added by Mark Lau 20090119
	@sfd_apprvflg	nvarchar(1),
	@sfd_apprvdt	nvarchar(10),
	@sfd_apprvtim	nvarchar(8),
	@sfd_apprvpv	nvarchar(4),	

	-- Added by Mark Lau 20090325
	@sfd_wtpv	nvarchar(6),	
	
	@sfd_zi01	numeric(13,4),
	-- Added by Mark Lau 20090423
	@sfd_zi01_cur	nvarchar(3),
	@sfd_zi02	numeric(13,4),
	-- Added by Mark Lau 20090423
	@sfd_zi02_cur	nvarchar(3),
	@sfd_zi03	numeric(13,4),
	@sfd_zi03_cur	nvarchar(3),
	-- Added by Mark Lau 20090317
	@sfd_zi04	numeric(13,4),
	@sfd_zi05	numeric(13,4),
	@sfd_zi04_cur	nvarchar(3),
	@sfd_zi05_cur	nvarchar(3),
	-- Added by Mark Lau 20090320
	@sfd_pv	nvarchar(6),
	@sfd_cv	nvarchar(6),
	@sfd_dv	nvarchar(6),
	-- Added by Mark Lau 20090325
	@sfd_flgzpp19 nvarchar(1),
	@sfd_cstchg nvarchar(1),
	@sfd_cstchgdat nvarchar(10),
	@sfd_cstchgtim nvarchar(8),

	-- Added by Mark Lau 20090904
	@sfd_zapcstuf nvarchar(1) ,
	@sfd_zapcstud nvarchar(10) ,
	@sfd_zapcstut nvarchar(8) ,
	@sfd_zapcstuc nvarchar(50) ,
	@sfd_zapcstcf nvarchar(1) ,
	@sfd_zapcstcd nvarchar(10)  ,
	@sfd_zapcstct nvarchar(8)  ,
	@sfd_zapcstcc nvarchar(50)  ,
	@sfd_zapprwtcv nvarchar(6)  ,
	@sfd_zflgapprcv nvarchar(1)  ,
	@sfd_zapprcvdat nvarchar(10)  ,
	@sfd_zapprcvtim nvarchar(8)  ,


	@sfd_filename	nvarchar(50)

As

BEGIN

if (select count(*) from SCFTYDAT where upper(sfd_jobord) = upper(@sfd_jobord)  and upper(sfd_itmno) = upper(@sfd_itmno) ) > 0 
begin

	update SCFTYDAT 
	set 
		sfd_latest = 'N', sfd_upddat = getdate() , sfd_updusr = 'SAPUSER'
	where 
		upper(sfd_jobord) = upper(@sfd_jobord)  and upper(sfd_itmno) = upper(@sfd_itmno)


	insert into SCFTYDAT
	(
		sfd_filename,
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
		sfd_wtpv,

		sfd_zi01,
		sfd_zi02,
		sfd_zi03,
		sfd_zi01_cur,
		sfd_zi02_cur,
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
		sfd_zflgapprcv,
		sfd_zapprcvdat,
		sfd_zapprcvtim,
		sfd_zapprwtcv,

		sfd_latest,
		sfd_creusr,
		sfd_updusr,
		sfd_credat,
		sfd_upddat
	)
	values
	(
		@sfd_filename,
		@sfd_sapno,
		@sfd_sapln,
		@sfd_jobord,
		@sfd_itmno,
		@sfd_um,
		@sfd_inrqty,
		@sfd_mtrqty,
		-- Added by Mark Lau 20090119
		@sfd_pckitr,
		@sfd_apprvflg,
		@sfd_apprvdt,
		@sfd_apprvtim,
		@sfd_apprvpv,
		-- Added by Mark Lau 20090325
		@sfd_wtpv,
		@sfd_zi01,
		@sfd_zi02,
		@sfd_zi03,
		-- Added by Mark Lau 20090423
		@sfd_zi01_cur,
		-- Added by Mark Lau 20090423
		@sfd_zi02_cur,
		@sfd_zi03_cur,
		-- Added by Mark Lau 20090317
		@sfd_zi04,
		@sfd_zi05,
		@sfd_zi04_cur,
		@sfd_zi05_cur,
		-- Added by Mark Lau 20090320
		@sfd_pv,
		@sfd_cv,
		@sfd_dv,
		-- Added by Mark Lau 20090325
		@sfd_flgzpp19 ,
		@sfd_cstchg ,
		@sfd_cstchgdat ,
		@sfd_cstchgtim ,


		-- Added by Mark Lau 20090904
		@sfd_zapcstuf,
		@sfd_zapcstud,
		@sfd_zapcstut,
		@sfd_zapcstuc,
		@sfd_zapcstcf,
		@sfd_zapcstcd,
		@sfd_zapcstct,
		@sfd_zapcstcc,
		@sfd_zflgapprcv,
		@sfd_zapprcvdat,
		@sfd_zapprcvtim,
		@sfd_zapprwtcv ,

		'Y', 
		'SAPUSER',
		'SAPUSER',
		getdate(),
		getdate()
	)
end

else

begin


	insert into SCFTYDAT
	(
		sfd_filename,
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
		sfd_wtpv,
		sfd_zi01,
		sfd_zi02,
		sfd_zi03,
		sfd_zi01_cur,
		sfd_zi02_cur,
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
		sfd_zflgapprcv,
		sfd_zapprcvdat,
		sfd_zapprcvtim,
		sfd_zapprwtcv,

		sfd_latest,
		sfd_creusr,
		sfd_updusr,
		sfd_credat,
		sfd_upddat
	)
	values
	(
		@sfd_filename,
		@sfd_sapno,
		@sfd_sapln,
		@sfd_jobord,
		@sfd_itmno,
		@sfd_um,
		@sfd_inrqty,
		@sfd_mtrqty,
		@sfd_pckitr,
		-- Added by Mark Lau 20090119
		@sfd_apprvflg,
		@sfd_apprvdt,
		@sfd_apprvtim,
		@sfd_apprvpv,
		-- Added by Mark Lau 20090325
		@sfd_wtpv,
		@sfd_zi01,
		@sfd_zi02,
		@sfd_zi03,
		-- Added by Mark Lau 20090423
		@sfd_zi01_cur,
		-- Added by Mark Lau 20090423
		@sfd_zi02_cur,
		@sfd_zi03_cur,
		-- Added by Mark Lau 20090317
		@sfd_zi04,
		@sfd_zi05,
		@sfd_zi04_cur,
		@sfd_zi05_cur,
		-- Added by Mark Lau 20090320
		@sfd_pv,
		@sfd_cv,
		@sfd_dv,
		-- Added by Mark Lau 20090325
		@sfd_flgzpp19 ,
		@sfd_cstchg ,
		@sfd_cstchgdat ,
		@sfd_cstchgtim ,

		-- Added by Mark Lau 20090904
		@sfd_zapcstuf,
		@sfd_zapcstud,
		@sfd_zapcstut,
		@sfd_zapcstuc,
		@sfd_zapcstcf,
		@sfd_zapcstcd,
		@sfd_zapcstct,
		@sfd_zapcstcc,
		@sfd_zflgapprcv,
		@sfd_zapprcvdat,
		@sfd_zapprcvtim,
		@sfd_zapprwtcv ,

		'Y', 
		'SAPUSER',
		'SAPUSER',
		getdate(),
		getdate()
	)

end	

END


GO
GRANT EXECUTE ON [dbo].[sp_insert_SCFTYDAT] TO [ERPUSER] AS [dbo]
GO
