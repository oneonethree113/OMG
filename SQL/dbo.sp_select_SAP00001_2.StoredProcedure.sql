/****** Object:  StoredProcedure [dbo].[sp_select_SAP00001_2]    Script Date: 09/29/2017 15:29:09 ******/
DROP PROCEDURE [dbo].[sp_select_SAP00001_2]
GO
/****** Object:  StoredProcedure [dbo].[sp_select_SAP00001_2]    Script Date: 09/29/2017 15:29:10 ******/
SET ANSI_NULLS OFF
GO
SET QUOTED_IDENTIFIER OFF
GO

CREATE procedure [dbo].[sp_select_SAP00001_2] 
@sapno		varchar(100),
@sapseq		varchar(100)

AS    
BEGIN    

select sod_ordno , sod_ordseq , sod_venno , sod_dv , sod_cusven
from scorddtl (nolock) 
where  sod_zorvbeln = @sapno and sod_zorposnr = @sapseq

 

END





GO
GRANT EXECUTE ON [dbo].[sp_select_SAP00001_2] TO [ERPUSER] AS [dbo]
GO
