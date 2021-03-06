/****** Object:  StoredProcedure [dbo].[sp_select_qutitmlst]    Script Date: 09/29/2017 15:29:09 ******/
DROP PROCEDURE [dbo].[sp_select_qutitmlst]
GO
/****** Object:  StoredProcedure [dbo].[sp_select_qutitmlst]    Script Date: 09/29/2017 15:29:10 ******/
SET ANSI_NULLS OFF
GO
SET QUOTED_IDENTIFIER OFF
GO






CREATE procedure [dbo].[sp_select_qutitmlst]                                                                                                                                                                                                                            
@cocde nvarchar(6),                                                                                                                                                                                                                                         
@qutno nvarchar(20)                                                                                                                                                                                                                                          
                                                                                                                                                                                                                                                                 
                                                                                                                                                                                                                                                                 
AS                                                                                                                                                                                                                                                               
                                                                                                                                                                                                                                                                 
BEGIN                                                                                                                                                                                                                                                            
-----------------------------------------------------------------------------------------------------------------------                                                                                                                                          
SELECT	                                                                                                                                                                                                        
qud_itmno, qud_untcde+'/'+ltrim(str(qud_mtrqty))+'/'+ltrim(str(qud_inrqty)),qud_colcde, 'Item not in Active status' 
FROM QUOTNDTL, IMBASINF
WHERE 
qud_cocde = @cocde AND
qud_qutno = @qutno AND
qud_itmno =  ibi_itmno AND
--ibi_cocde = qud_cocde AND
--Item status 'OLD' added by Mark Lau ,20060917
(ibi_itmsts = 'INA' or ibi_itmsts = 'DIS' or ibi_itmsts = 'TBC' or ibi_itmsts = 'HLD' or ibi_itmsts = 'OLD') 

UNION

SELECT	                                                                                                                                                                                                        
qud_itmno, qud_untcde+'/'+ltrim(str(qud_mtrqty))+'/'+ltrim(str(qud_inrqty)),qud_colcde,  'Default Vendor not in Active status'
FROM QUOTNDTL, IMVENINF, VNBASINF, IMBASINF
WHERE 
qud_cocde = @cocde AND
qud_qutno = @qutno AND
--ivi_cocde = qud_cocde AND
ivi_itmno = qud_itmno AND
ivi_def = 'Y' AND
vbi_cocde = ivi_cocde AND
vbi_venno = ivi_venno AND
vbi_vensts <> 'A' AND
--ibi_cocde = qud_cocde AND
--Item status 'OLD' added by Mark Lau ,20060917
ibi_itmno = qud_itmno AND (ibi_itmsts <> 'INA' and ibi_itmsts <> 'DIS' and ibi_itmsts <> 'TBC' and ibi_itmsts <> 'HLD' and ibi_itmsts <> 'DIS')  


UNION

SELECT	                                                                                                                                                                                                        
qud_itmno, qud_untcde+'/'+ltrim(str(qud_mtrqty))+'/'+ltrim(str(qud_inrqty)),qud_colcde,  'Item in History or not in Item Master'
FROM QUOTNDTL, IMBASINF
WHERE 
--qud_cocde = @cocde AND
qud_qutno = @qutno AND
qud_itmno not in (select ibi_itmno from IMBASINF) --where ibi_cocde = @cocde)
--not exists  (select * from imbasinf where ibi_cocde = qud_cocde and ibi_itmno = qud_itmno)

order by qud_itmno                                                                                                                                                                                                                                             
                                                                                                                                       
END


GO
GRANT EXECUTE ON [dbo].[sp_select_qutitmlst] TO [ERPUSER] AS [dbo]
GO
