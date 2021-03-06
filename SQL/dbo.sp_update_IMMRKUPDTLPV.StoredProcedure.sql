/****** Object:  StoredProcedure [dbo].[sp_update_IMMRKUPDTLPV]    Script Date: 09/29/2017 15:29:08 ******/
DROP PROCEDURE [dbo].[sp_update_IMMRKUPDTLPV]
GO
/****** Object:  StoredProcedure [dbo].[sp_update_IMMRKUPDTLPV]    Script Date: 09/29/2017 15:29:10 ******/
SET ANSI_NULLS OFF
GO
SET QUOTED_IDENTIFIER OFF
GO





/*  
=========================================================  
Program ID :   sp_update_IMMRKUPDTLPV
Description    :   
Programmer   :   Mark Lau
Create Date    :   
Last Modified   : 
Table Read(s)  :  
Table Write(s)  :  
=========================================================  
 Modification History                                      
=========================================================  
Date  Author  Description  
=========================================================       
*/  
   

CREATE procedure [dbo].[sp_update_IMMRKUPDTLPV]  
@imp_cocde	nvarchar(6),
@imp_itmno	nvarchar(20),
@imp_venno	nvarchar(6),
@imp_pckseq	int,
@imp_untcde	nvarchar(6),
@imp_inrqty	int,
@imp_mtrqty	int,
@imp_cus1no	nvarchar(10),
@imp_cus2no	nvarchar(10),
@imp_conftr	int,
@imp_prdven	nvarchar(6),
@imp_ventyp	nvarchar(4),
@imp_curcde	nvarchar(6),
@imp_calftyprc	numeric(13,4),
@imp_negprc	numeric(13,4),
@imp_ftybomcst	numeric(13,4),
@imp_updusr	nvarchar(50)


 
AS  
  
begin  
  
update IMMRKUPDTLPV
set

imp_curcde = @imp_curcde,
imp_calftyprc = @imp_calftyprc,
imp_negprc = @imp_negprc,
imp_ftybomcst = @imp_ftybomcst,
imp_updusr = @imp_updusr,
imp_upddat = getdate()

where
imp_cocde = @imp_cocde and 
imp_itmno = @imp_itmno and
imp_venno = @imp_venno and
--imp_pckseq = @imp_pckseq and
imp_untcde = @imp_untcde and
imp_inrqty = @imp_inrqty and
imp_mtrqty = @imp_mtrqty and
imp_cus1no = @imp_cus1no and
imp_cus2no = @imp_cus2no and
imp_conftr = @imp_conftr and
imp_prdven = @imp_prdven


end



GO
GRANT EXECUTE ON [dbo].[sp_update_IMMRKUPDTLPV] TO [ERPUSER] AS [dbo]
GO
