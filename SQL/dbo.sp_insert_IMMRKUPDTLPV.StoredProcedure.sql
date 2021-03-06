/****** Object:  StoredProcedure [dbo].[sp_insert_IMMRKUPDTLPV]    Script Date: 09/29/2017 15:29:09 ******/
DROP PROCEDURE [dbo].[sp_insert_IMMRKUPDTLPV]
GO
/****** Object:  StoredProcedure [dbo].[sp_insert_IMMRKUPDTLPV]    Script Date: 09/29/2017 15:29:09 ******/
SET ANSI_NULLS OFF
GO
SET QUOTED_IDENTIFIER OFF
GO





/*  
=========================================================  
Program ID :   sp_insert_IMMRKUPDTLPV
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
   

CREATE procedure [dbo].[sp_insert_IMMRKUPDTLPV]  
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
@imp_creusr	nvarchar(50)


 
AS  
  
begin  
  
insert into IMMRKUPDTLPV
(
imp_cocde,
imp_itmno,
imp_venno,
imp_pckseq,
imp_untcde,
imp_inrqty,
imp_mtrqty,
imp_cus1no,
imp_cus2no,
imp_conftr,
imp_prdven,
imp_ventyp,
imp_curcde,
imp_calftyprc,
imp_negprc,
imp_ftybomcst,
imp_creusr,
imp_updusr,
imp_credat,
imp_upddat
)
values
(
@imp_cocde,
@imp_itmno,
@imp_venno,
@imp_pckseq,
@imp_untcde,
@imp_inrqty,
@imp_mtrqty,
@imp_cus1no,
@imp_cus2no,
@imp_conftr,
@imp_prdven,
@imp_ventyp,
@imp_curcde,
@imp_calftyprc,
@imp_negprc,
@imp_ftybomcst,
@imp_creusr,
@imp_creusr,
getdate(),
getdate()
)
end



GO
GRANT EXECUTE ON [dbo].[sp_insert_IMMRKUPDTLPV] TO [ERPUSER] AS [dbo]
GO
