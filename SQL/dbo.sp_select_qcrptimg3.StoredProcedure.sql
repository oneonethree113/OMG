/****** Object:  StoredProcedure [dbo].[sp_select_qcrptimg3]    Script Date: 09/29/2017 15:29:09 ******/
DROP PROCEDURE [dbo].[sp_select_qcrptimg3]
GO
/****** Object:  StoredProcedure [dbo].[sp_select_qcrptimg3]    Script Date: 09/29/2017 15:29:10 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create PROCEDURE [dbo].[sp_select_qcrptimg3] 
@TmpRPTNo as nvarchar(30)

AS
begin

SELECT 
qrc_rptimgdis_group,qrc_rptimgdis_order,qri_file , '' as 'rmk'
from qcrptimg   
		LEFT JOIN QCRPTCDE 
		ON qri_inspcde =qrc_inspcde
where  qri_tmprptno = @TmpRPTNo 
		and qrc_rptimgdis_group > 50
		order by qrc_rptimgdis_group,qrc_rptimgdis_order
		
END



GO
GRANT EXECUTE ON [dbo].[sp_select_qcrptimg3] TO [ERPUSER] AS [dbo]
GO
