/****** Object:  StoredProcedure [dbo].[sp_select_VNEXCCUS]    Script Date: 09/29/2017 15:29:08 ******/
DROP PROCEDURE [dbo].[sp_select_VNEXCCUS]
GO
/****** Object:  StoredProcedure [dbo].[sp_select_VNEXCCUS]    Script Date: 09/29/2017 15:29:10 ******/
SET ANSI_NULLS OFF
GO
SET QUOTED_IDENTIFIER OFF
GO





CREATE procedure [dbo].[sp_select_VNEXCCUS]
                                                                                                                                                                                                                                                                 

@vec_cocde nvarchar(6) ,
@vec_venno nvarchar(20) 
 
AS

begin

Select	vec_cocde,
vec_venno,
vec_cusno + ' - ' + cbi_cussna as 'vec_cusno' , 
vec_cotry,
vec_valid,
vec_rmark,
vec_creusr,
vec_updusr,
vec_credat,
vec_upddat
from VNEXCCUS
left join cubasinf on vec_cusno   = cbi_cusno
where  vec_venno = @vec_venno


end





GO
GRANT EXECUTE ON [dbo].[sp_select_VNEXCCUS] TO [ERPUSER] AS [dbo]
GO
