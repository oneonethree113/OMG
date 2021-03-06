/****** Object:  StoredProcedure [dbo].[sp_select_CAORDDTL]    Script Date: 09/29/2017 15:29:09 ******/
DROP PROCEDURE [dbo].[sp_select_CAORDDTL]
GO
/****** Object:  StoredProcedure [dbo].[sp_select_CAORDDTL]    Script Date: 09/29/2017 15:29:10 ******/
SET ANSI_NULLS OFF
GO
SET QUOTED_IDENTIFIER OFF
GO















/************************************************************************
 Description:	Select data From CAORDDTL
***********************************************************************
*/

CREATE       procedure [dbo].[sp_select_CAORDDTL]

@cad_cocde nvarchar(6),
@cad_caordno nvarchar(20)

AS

BEGIN

--------------------------------------------------------------------------------------------------

if @cad_caordno = 'ALL' 
begin

select
distinct
cad_caordno,
cad_scordno,
cad_scordseq
from CAORDDTL (nolock)
order by cad_caordno, cad_scordno, cad_scordseq

end
else
begin

SELECT	
isnull(cad_del,'') as 'cad_del',
cad_cocde,
cad_caordno,
cad_caordseq,
cad_txcocde,
cad_scordno,
cad_scordseq,
cad_popurord,
cad_popurseq,
cad_pojobord,
cad_shinvno,
cad_sccuspono,
cad_shissdat,
cad_shetddat,
cad_shetadat,
cad_itmno,
cad_cusitm,
cad_cusstyno,
cad_venitm,
cad_itmdsc,
isnull(cad_prdven + ' - ' + vbi_vensna,'') as 'cad_prdven',
cad_ventyp,
cad_sccurcde,
cad_scnetuntprc,
cad_scfcurcde,
cad_scftyprc,
cad_scpckunt,
cad_scordqty,
cad_scshpqty,
cad_caqty,
cad_caqty_final,
cad_rmk,
cad_salcur,
cad_salamt,
cad_grspftamt,
cad_calmtamt,
cad_calmtper,
cad_cacur,
cad_caqtyamt_org,
cad_caqtyamt_final,
cad_caamt_org,
cad_caamt_final,
cad_ttlcaamt_org,
cad_ttlcaamt_final,
'' as cad_cavsgrspft,
'' as cad_app1flg,
'' as cad_app1flgby,
'01/01/1900' as cad_app1flgdat,
cad_catoinscur,
cad_catoinsamt,
cad_catovncur,
cad_catovnamt,
cad_catohkocur,
cad_catohkoamt,
'' as cad_app2flg,
'' as cad_app2flgby,
'01/01/1900' as cad_app2flgdat,
CAD_SCUNTCDE,
cad_creusr,
cad_updusr,
cad_credat,
cad_upddat,
cast(cad_timstp as int) as cad_timstp,
cad_clatyp,
CAD_itmnoven,
CAD_alscolcde,
CAD_untcde,
cad_calmtper,
CAD_SHPNO,
CAD_SHPSEQ,
CAD_CAREMAMT,
'' as 'EXCE'
from CAORDDTL (nolock)
left join VNBASINF (nolock) on vbi_venno = cad_prdven
where	
cad_cocde = @cad_cocde and cad_caordno = @cad_caordno
order by cad_cocde, cad_caordno,cad_caordseq

end

END













GO
GRANT EXECUTE ON [dbo].[sp_select_CAORDDTL] TO [ERPUSER] AS [dbo]
GO
