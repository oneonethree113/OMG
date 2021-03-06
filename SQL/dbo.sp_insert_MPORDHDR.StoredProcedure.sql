/****** Object:  StoredProcedure [dbo].[sp_insert_MPORDHDR]    Script Date: 09/29/2017 15:29:09 ******/
DROP PROCEDURE [dbo].[sp_insert_MPORDHDR]
GO
/****** Object:  StoredProcedure [dbo].[sp_insert_MPORDHDR]    Script Date: 09/29/2017 15:29:09 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO




/*
=========================================================
Program ID	: sp_insert_MPORDHDR
Description   	: 
Programmer  	: Lester Wu
Create Date   	:2005-08-04
Last Modified  	: 
Table Read(s) 	:
Table Write(s) 	:
=========================================================
 Modification History                                    
=========================================================
Date		Author		Description
=========================================================     

*/



----sp_insert_MPORDHDR 'UCPP','Tmp_00001','10179','','¤¤¤sµØ®õ','HKD','MP0500033','mis'

CREATE Procedure [dbo].[sp_insert_MPORDHDR]
@cocde		as varchar(6),
@Mph_MPONO	as varchar(20),
@Mph_VenNo	as varchar(10),
@Mph_ImpFty	as nvarchar(10),
@Mph_ShpPlc	as nvarchar(20),
@Mph_Curr	as nvarchar(10),
@docNo		as varchar(20),
@UserID		as varchar(30)
as
BEGIN

declare
	@vci_adr		nvarchar(400),
	@vci_stt		nvarchar(60),
	@vci_cty		nvarchar(12),
	@vci_zip		nvarchar(40),
	@vbi_prctrm	nvarchar(12),
	@vbi_paytrm	nvarchar(12),
	@vci_cntctp	nvarchar(60)

	set  @vci_adr = ''
	set  @vci_stt = ''
	set  @vci_cty = ''
	set  @vci_zip = ''
	set  @vbi_prctrm = ''
	set  @vbi_paytrm = ''
	set  @vci_cntctp = ''
	

select 
	@vci_adr = case when isnull(addr.vci_chnadr,'') <> '' then isnull(addr.vci_chnadr,'') else isnull(addr.vci_adr,'') end,
	@vci_stt  = isnull(addr.vci_stt,''),
	@vci_cty = isnull(addr.vci_cty,''),
	@vci_zip = isnull(addr.vci_zip,''),
	@vbi_prctrm = isnull(vbi_prctrm,''),
	@vbi_paytrm = isnull(vbi_paytrm,''),
	@vci_cntctp = isnull(cnt.vci_cntctp,'')
--	select * 
	from
			VNBASINF
	left join		VNCNTINF cnt on vbi_venno = cnt.vci_venno and cnt.vci_cntdef = 'Y'
	left join		VNCNTINF addr on vbi_venno = addr.vci_venno and addr.vci_cnttyp = 'M'

	where
			vbi_venno = @Mph_Venno


insert into 
	MPORDHDR (
			Mph_MPONO,
			Mph_VenNo,
			Mph_ImpFty,
			Mph_Curr,
			Mph_ShpPlc,
			Mph_ShpDat,
			Mph_CreDat,
			Mph_CreUsr,
			Mph_UpdDat,
			Mph_UpdUsr,
			Mph_MpoSts,
			-- 2005-08-16
			Mph_VenAdr,
			Mph_VenStt,
			Mph_VenCty,
			Mph_VenPst,
			Mph_PrcTrm,
			Mph_PayTrm,
			Mph_MporCtp,
			Mph_ShpAdr
		)

values		(
			@docNo,
			@Mph_VenNo,
			@Mph_ImpFty,
			@Mph_Curr,
			@Mph_ShpPlc,
			NULL,
			getdate(),
			@UserID + 'Gen',
			getdate(),
			@UserID + 'Gen',
			'ACT',
			-- 2005-08-16
			@vci_adr ,
			@vci_stt ,
			@vci_cty,
			@vci_zip,
			@vbi_prctrm ,
			@vbi_paytrm,
			@vci_cntctp ,
			''
		)
END



GO
GRANT EXECUTE ON [dbo].[sp_insert_MPORDHDR] TO [ERPUSER] AS [dbo]
GO
