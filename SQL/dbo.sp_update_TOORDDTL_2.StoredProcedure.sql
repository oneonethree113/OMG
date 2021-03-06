/****** Object:  StoredProcedure [dbo].[sp_update_TOORDDTL_2]    Script Date: 09/29/2017 15:29:08 ******/
DROP PROCEDURE [dbo].[sp_update_TOORDDTL_2]
GO
/****** Object:  StoredProcedure [dbo].[sp_update_TOORDDTL_2]    Script Date: 09/29/2017 15:29:10 ******/
SET ANSI_NULLS OFF
GO
SET QUOTED_IDENTIFIER OFF
GO








CREATE   PROCEDURE [dbo].[sp_update_TOORDDTL_2] 


@tod_cocde		nvarchar(6),
@tod_toordno		nvarchar(20),
@tod_verno		int,
@tod_toordseq 		int,
@tod_projqty		int,
@tod_ftyshpdatstr	datetime,
@tod_ftyshpdatend	datetime,
@tod_cushpdatstr	datetime,
@tod_cushpdatend	datetime,
@tod_rmk		nvarchar(800),
@tod_dsgven		nvarchar(20),
@tod_prdven		nvarchar(20),
@tod_cusven		nvarchar(20),
@tod_ftycst decimal(13,4),
@tod_selprc decimal(13,4),
@tod_basprc decimal(13,4),
@tod_qutitmsts  nvarchar(20),
@tod_itmdsc  nvarchar(800),
@user			nvarchar(30)
AS

declare @tod_cntctp as nvarchar(100)

select @tod_cntctp =  vci_cntctp from vncntinf(nolock) where vci_venno = @tod_prdven and vci_cntdef ='Y'

UPDATE	TOORDDTL
SET		tod_projqty=@tod_projqty,
		 tod_ftyshpdatstr=@tod_ftyshpdatstr,
		tod_ftyshpdatend =@tod_ftyshpdatend,
		 tod_cushpdatstr= @tod_cushpdatstr	,
		tod_cushpdatend = @tod_cushpdatend, 
		tod_rmk  	= @tod_rmk,
		tod_dsgven =	@tod_dsgven,
		tod_prdven = @tod_prdven,
		tod_cusven = @tod_cusven,
		tod_ftycst=@tod_ftycst ,
		tod_selprc=@tod_selprc,
		tod_basprc=@tod_basprc,
		tod_qutitmsts=@tod_qutitmsts,
		tod_itmdsc=@tod_itmdsc,
		tod_updusr =@user,
		tod_upddat = getdate(),
		tod_cntctp = @tod_cntctp
		where
		tod_cocde = @tod_cocde and
		tod_toordno= @tod_toordno	 and 
		 tod_toordseq  = @tod_toordseq  and 
 		tod_latest = 'Y'









GO
GRANT EXECUTE ON [dbo].[sp_update_TOORDDTL_2] TO [ERPUSER] AS [dbo]
GO
