/****** Object:  StoredProcedure [dbo].[sp_list_SCDTLCTN_SHM00001_2]    Script Date: 09/29/2017 15:29:09 ******/
DROP PROCEDURE [dbo].[sp_list_SCDTLCTN_SHM00001_2]
GO
/****** Object:  StoredProcedure [dbo].[sp_list_SCDTLCTN_SHM00001_2]    Script Date: 09/29/2017 15:29:10 ******/
SET ANSI_NULLS OFF
GO
SET QUOTED_IDENTIFIER OFF
GO






-- Checked by Allan Yuen at 27/07/2003



/*
=========================================================
Program ID	: sp_list_SCDTLCTN_SHM00001_2
Description   	: 
Programmer  	: Allan Yuen
Create Date   	: 
Last Modified  	: 
Table Read(s) 	:
Table Write(s) 	:
=========================================================
 Modification History                                    
=========================================================
 Date      	Initial  	Description          
2003-06-17	Allan Yuen	Fix Deadlock error.               
=========================================================     
*/


CREATE PROCEDURE [dbo].[sp_list_SCDTLCTN_SHM00001_2]

@cocde as nvarchar(6),
@ordno as nvarchar(20),
@ordseq as int

AS

SELECT sod_ctnstr as 'sdc_from', sod_ctnend as 'sdc_to'

FROM SCORDDTL  (nolock)

WHERE  sod_cocde = @cocde and
	sod_ordno = @ordno and
	sod_ordseq = @ordseq

ORDER BY sdc_from








GO
GRANT EXECUTE ON [dbo].[sp_list_SCDTLCTN_SHM00001_2] TO [ERPUSER] AS [dbo]
GO
