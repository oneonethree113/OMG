/****** Object:  StoredProcedure [dbo].[sp_list_pkwasge_02]    Script Date: 09/29/2017 15:29:09 ******/
DROP PROCEDURE [dbo].[sp_list_pkwasge_02]
GO
/****** Object:  StoredProcedure [dbo].[sp_list_pkwasge_02]    Script Date: 09/29/2017 15:29:10 ******/
SET ANSI_NULLS OFF
GO
SET QUOTED_IDENTIFIER OFF
GO






CREATE  procedure [dbo].[sp_list_pkwasge_02]
                                                                                                                                                                                                                                                                 
@code nvarchar(10)


---------------------------------------------- 

 
AS
 

begin

	 
select pwa_code,pwa_seq,pwa_qtyfrm,pwa_qtyto,pwa_wasage,pwa_um
from pkwasge(nolock)
order by pwa_code , pwa_seq

end











GO
GRANT EXECUTE ON [dbo].[sp_list_pkwasge_02] TO [ERPUSER] AS [dbo]
GO
