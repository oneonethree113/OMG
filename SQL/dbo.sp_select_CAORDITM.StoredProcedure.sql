/****** Object:  StoredProcedure [dbo].[sp_select_CAORDITM]    Script Date: 09/29/2017 15:29:09 ******/
DROP PROCEDURE [dbo].[sp_select_CAORDITM]
GO
/****** Object:  StoredProcedure [dbo].[sp_select_CAORDITM]    Script Date: 09/29/2017 15:29:10 ******/
SET ANSI_NULLS OFF
GO
SET QUOTED_IDENTIFIER OFF
GO










CREATE      procedure [dbo].[sp_select_CAORDITM]

@cad_cocde nvarchar(6),
@cad_caordno nvarchar(20)

AS

BEGIN

--------------------------------------------------------------------------------------------------


select
isnull(CAI_DEL ,'') as 'CAI_DEL',
CAI_COCDE,
CAI_CAORDNO,
CAI_CAORDSEQ,
CAI_CLATYP,
CAI_TXCOCDE,
CAI_ITMNO,
CAI_ITMDSC,
CAI_RMK,
CAI_SALCUR,
CAI_SALAMT,
CAI_GRSPFTAMT,
CAI_CALMTAMT,
CAI_CALMTPER,
CAI_CAREMAMT,
CAI_CACUR,
CAI_CAQTYAMT_ORG,
CAI_CAQTYAMT_FINAL,
CAI_CAAMT_ORG,
CAI_CAAMT_FINAL,
CAI_TTLCAAMT_ORG,
CAI_TTLCAAMT_FINAL,
CAI_APP1FLG,
CAI_APP1FLGBY,
CAI_APP1FLGDAT,
CAI_CATOINSCUR,
CAI_CATOINSAMT,
CAI_CATOVNCUR,
CAI_CATOVNAMT,
CAI_CATOHKOCUR,
CAI_CATOHKOAMT,
CAI_APP2FLG,
CAI_APP2FLGBY,
CAI_APP2FLGDAT,
cai_cusitm,
cai_cusstyno,
cai_venitm,
cai_prdven,
CAI_creusr,
CAI_updusr,
CAI_credat,
CAI_upddat,
CAI_timstp

from CAORDITM (nolock)
where CAI_caordno =@cad_caordno
order by 
CAI_CAORDSEQ

END












GO
GRANT EXECUTE ON [dbo].[sp_select_CAORDITM] TO [ERPUSER] AS [dbo]
GO
