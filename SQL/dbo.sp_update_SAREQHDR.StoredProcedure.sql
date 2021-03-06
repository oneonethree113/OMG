/****** Object:  StoredProcedure [dbo].[sp_update_SAREQHDR]    Script Date: 09/29/2017 15:29:08 ******/
DROP PROCEDURE [dbo].[sp_update_SAREQHDR]
GO
/****** Object:  StoredProcedure [dbo].[sp_update_SAREQHDR]    Script Date: 09/29/2017 15:29:10 ******/
SET ANSI_NULLS OFF
GO
SET QUOTED_IDENTIFIER OFF
GO




-- Checked by Allan Yuen at 28/07/2003

/*	Author : Tommy Ho	*/

CREATE PROCEDURE [dbo].[sp_update_SAREQHDR] 


@srh_cocde		nvarchar(6),	
@srh_reqno		nvarchar(20),	
@srh_venctp		nvarchar(50),
@srh_salrep		nvarchar(30),	
@srh_cussmppo	nvarchar(50),	
@srh_cusdeldat	datetime,
@srh_vendeldat	datetime,		
@srh_rmk		nvarchar(300),	
@cancel_flag		nvarchar(1),
@srh_saltem		nvarchar(20),
@srh_saldiv		nvarchar(20),
@srh_salmgt		nvarchar(20),
@srh_srname		nvarchar(30),
@srh_creusr		nvarchar(30)


AS

UPDATE	SAREQHDR
SET		srh_venctp = @srh_venctp,	
		--srh_salrep = @srh_salrep,
		srh_cussmppo = @srh_cussmppo,
		srh_cusdeldat = @srh_cusdeldat,
		srh_vendeldat = @srh_vendeldat,
		srh_rmk = @srh_rmk,
		srh_upddat = getdate(), 
		srh_updusr = @srh_creusr, 
		--srh_saltem = @srh_saltem,
		srh_saldiv = @srh_saldiv,
		srh_salmgt = @srh_salmgt,
		srh_srname = @srh_srname,
		srh_reqsts = (case @cancel_flag when 'Y' then 'C' else 'A' end) WHERE	srh_cocde = @srh_cocde 	and 
		srh_reqno = @srh_reqno







GO
GRANT EXECUTE ON [dbo].[sp_update_SAREQHDR] TO [ERPUSER] AS [dbo]
GO
