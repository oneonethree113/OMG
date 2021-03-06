/****** Object:  StoredProcedure [dbo].[sp_select_cpyqutitmlst]    Script Date: 09/29/2017 15:29:09 ******/
DROP PROCEDURE [dbo].[sp_select_cpyqutitmlst]
GO
/****** Object:  StoredProcedure [dbo].[sp_select_cpyqutitmlst]    Script Date: 09/29/2017 15:29:10 ******/
SET ANSI_NULLS OFF
GO
SET QUOTED_IDENTIFIER OFF
GO








/*
=========================================================
Program ID	: 
Description   	: 
Programmer  	: 
Create Date   	: 
Last Modified  	: 17 July 2003
Table Read(s) 	:
Table Write(s) 	:
=========================================================
 Modification History                                    
=========================================================
Date		Author		Description
=========================================================     
17 July 2003	Allan Yuen		For Merge Porject
15 July 2005	Allan Yuen		Change read color code from icf_colcde -> icf_vencol.
08 Feb., 2006	Allan Yuen		Change read color code from icf_vencol -> icf_colcde.
*/
                                                                                                                                                                                                                                                               
CREATE procedure [dbo].[sp_select_cpyqutitmlst]                                                                                                                                                                                                                            
@cocde nvarchar(6),                                                                                                                                                                                                                                         
@qutno nvarchar(20)                                                                                                                                                                                                                                          
                                                                                                                                                                                                                                                                 
                                                                                                                                                                                                                                                                 
AS                                                                                                                                                                                                                                                               
                                                                                                                                                                                                                                                                 
BEGIN                                                                                                                                                                                                                                                            
-----------------------------------------------------------------------------------------------------------------------                                                                                                                                          
SELECT	                       
distinct                                                                                                                                                                                 
qud_itmno,       
isnull(ipi_pckunt,'') as ipi_pckunt,
isnull(ipi_inrqty,0) as ipi_inrqty,
isnull(ipi_mtrqty,0) as ipi_mtrqty,
ipi_pckunt+'/'+ltrim(str(ipi_inrqty))+'/'+ltrim(str(ipi_mtrqty)),
isnull(icf_colcde,'') as icf_colcde,
--isnull(icf_vencol,'') as icf_colcde,
qud_itmdsc,
qud_tbm,
qud_cuscol,
qud_cusitm,
qud_coldsc,
qud_note,
qud_stkqty,
qud_cusqty,
qud_smpqty,
qud_hrmcde,
qud_dtyrat,
qud_cususd,
qud_dept,
qud_cuscad,
qud_pckitr,
(case isnull(icf_colcde,'')+isnull(ipi_pckunt,'') when '' then 'Packing / Color not in Item Master' 
--(case isnull(icf_vencol,'')+isnull(ipi_pckunt,'') when '' then 'Packing / Color not in Item Master' 
	else (case icf_cocde when NULL then 'Color not in Item Master' else 
		(case ipi_pckunt when NULL then 'Packing not in Item Master' else '' end)
	 end)
 end) as 'message'
FROM QUOTNDTL
left join IMBASINF on ibi_itmno = qud_itmno
left join IMPCKINF on ipi_itmno = qud_itmno AND ipi_pckunt = qud_untcde AND ipi_inrqty = qud_inrqty AND ipi_mtrqty = qud_mtrqty
left join IMCOLINF on icf_itmno = qud_itmno AND icf_colcde = qud_colcde
left join IMVENINF on ivi_itmno = ibi_itmno 
left join VNBASINF on vbi_venno = ivi_venno
WHERE 
qud_qutno = @qutno and
vbi_vensts = 'A' and
(ibi_itmsts = 'CMP' OR ibi_itmsts = 'INC') AND
ivi_def = 'Y'

order by qud_itmno                                                                                                                                                                                                                                        
-----------------------------------------------------------------------------------------------------------------------                                                                                                                                          
end








GO
GRANT EXECUTE ON [dbo].[sp_select_cpyqutitmlst] TO [ERPUSER] AS [dbo]
GO
