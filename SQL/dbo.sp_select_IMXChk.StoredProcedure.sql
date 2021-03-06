/****** Object:  StoredProcedure [dbo].[sp_select_IMXChk]    Script Date: 09/29/2017 15:29:09 ******/
DROP PROCEDURE [dbo].[sp_select_IMXChk]
GO
/****** Object:  StoredProcedure [dbo].[sp_select_IMXChk]    Script Date: 09/29/2017 15:29:10 ******/
SET ANSI_NULLS OFF
GO
SET QUOTED_IDENTIFIER OFF
GO



/*
=========================================================
Program ID	: sp_select _IMXChk	
Description   	: Check Item - Customer-Vendor-Company Relationship(Item can be quot by comapny ) 
Programmer  		Lewis To	: 
Create Date   	: 	7 Jul 2003
Last Modified  	: 	
Table Read(s) 	:	 imveninf,vnbasinf, cumcoven
Table Write(s) 	:
=========================================================
 Modification History                                    
=========================================================
        
=========================================================     
*/

CREATE PROCEDURE [dbo].[sp_select_IMXChk]

@cocde varchar(6),
@cusno varchar(6),
@colcde varchar(20),
@itmno varchar(20)




AS

begin

select 
ibi_cocde 	as 	'imx_cocde', 
ccv_cocde as 	'imc_quotcocde',
ccv_cusno 	as 	'imx_cusno',
ibi_itmno 	as 	'imx_itmno',
ibi_venno 	as 	'imx_venno',
vbi_vensts	as 	'imx_vensts',
vbi_ventyp as 	'imx_ventyp',
--vbi_moqchg as 	'imx_moqchg',
--isnull(ibi_alsitmno,'') as 'imx_alsitmno',
--isnull(cis_colcde,'') as	'imx_colcde',
--isnull(ibi_alscat,'') as	'imx_alscat',
--isnull(imu_alsbasprc,0) as 'imx_alsbasprc',
--isnull(cis_refdoc,'') as 	'imx_qutno',
ccv_vendef	as 	'imx_vendef',
ccv_effdat 	as 	'imx_effdat'

from imbasinf, imveninf,
--left join imbasinf on ibi_alsitmno = ivi_itmno,
--left join imbasinf on ibi_itmno = ivi_itmno,
--left join immrkup on imu_itmno = ibi_itmno
--left join cuitmsum on cis_cusno = @cusno and cis_itmno = ivi_itmno and cis_colcde = case @colcde when '' then null else @colcde end,
vnbasinf, cumcoven
where  --ibi_venno = vbi_venno and 
ivi_itmno = ibi_itmno and 
ivi_venno = vbi_venno and 
vbi_ventyp = ccv_ventyp and
--ivi_cocde = ccv_cocde and 
ivi_def ='Y' and
vbi_vensts = 'A' 
and (ibi_itmno =  @itmno or ibi_alsitmno =@itmno)
and ccv_cusno = @cusno
and ccv_cocde = @cocde
end




GO
GRANT EXECUTE ON [dbo].[sp_select_IMXChk] TO [ERPUSER] AS [dbo]
GO
