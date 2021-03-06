/****** Object:  StoredProcedure [dbo].[sp_insert_QUASSINF_QUOTSD]    Script Date: 09/29/2017 15:29:09 ******/
DROP PROCEDURE [dbo].[sp_insert_QUASSINF_QUOTSD]
GO
/****** Object:  StoredProcedure [dbo].[sp_insert_QUASSINF_QUOTSD]    Script Date: 09/29/2017 15:29:09 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO








/************************************************************************
Author:		Samuel Chan   
Date:		01 - 10 -  2002
Description:	Insert data into Assort Item

************************************************************************/

CREATE PROCEDURE [dbo].[sp_insert_QUASSINF_QUOTSD] 
--------------------------------------------------------------------------------------------------------------------------------------

@qsd_cocde	nvarchar(6),
@qutno		nvarchar(20),
@qsd_itmno	nvarchar(20),
@qsd_qutseq	int,
@qsd_AssItm	nvarchar(20),
@qsd_colcde	nvarchar(30),
--Added by Mark Lau 20060918
@qsd_alsitmno	nvarchar(20),
@qsd_alscolcde		nvarchar(30),
@qsd_inrqty	int,
@qsd_mtrqty	int,
@qsd_untcde	nvarchar(6),
@qsd_creusr	nvarchar(30)

AS 
--Declare @qai_qutseq  int
--Set @qai_qutseq = (Select isnull(max(qai_qutseq),0) + 1 from QUASSINF Where qai_cocde = @qsd_cocde and qai_qutno = @qutno ) 

declare @qsd_Assdsc	nvarchar(800)
set @qsd_Assdsc = isnull((select ibi_engdsc from IMBASINF where --ibi_cocde = @qsd_cocde and 
						ibi_itmno = @qsd_assitm),'')

declare @qsd_cussku nvarchar(20)
set @qsd_cussku = ''
declare @qsd_upcean nvarchar(15)
set @qsd_upcean = ''
declare @qsd_cusrtl nvarchar(20)
set @qsd_cusrtl = ''

--declare @qsd_qutseq	int
--Set  @qsd_qutseq = (Select isnull(max(qai_qutseq),0)  + 1 from QUASSINF where qai_cocde = @qsd_cocde and qai_qutno = @qutno and qai_itmno = @qsd_itmno)

INSERT INTO  QUASSINF
(
qai_cocde,	qai_qutno,	qai_qutseq,	qai_itmno,
qai_assitm,	qai_assdsc,	qai_colcde,
--Added by Mark Lau 20060918
qai_alsitmno,	qai_alscolcde,
qai_cussku,
qai_upcean,	qai_cusrtl,	qai_untcde,	qai_inrqty,
qai_mtrqty,	
qai_creusr,	qai_updusr,	qai_credat,	qai_upddat
)

values

(
@qsd_cocde,	@qutno,	@qsd_qutseq,	@qsd_itmno,
@qsd_assitm,	@qsd_assdsc,	@qsd_colcde,
--Added by Mark Lau 20060918
@qsd_alsitmno,	@qsd_alscolcde,
@qsd_cussku,
@qsd_upcean,	@qsd_cusrtl,	@qsd_untcde,	@qsd_inrqty,
@qsd_mtrqty,	@qsd_creusr,	@qsd_creusr,	
getdate(),	getdate()	
)



GO
GRANT EXECUTE ON [dbo].[sp_insert_QUASSINF_QUOTSD] TO [ERPUSER] AS [dbo]
GO
