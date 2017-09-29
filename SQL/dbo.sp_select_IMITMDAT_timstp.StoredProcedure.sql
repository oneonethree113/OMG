/****** Object:  StoredProcedure [dbo].[sp_select_IMITMDAT_timstp]    Script Date: 09/29/2017 15:29:09 ******/
DROP PROCEDURE [dbo].[sp_select_IMITMDAT_timstp]
GO
/****** Object:  StoredProcedure [dbo].[sp_select_IMITMDAT_timstp]    Script Date: 09/29/2017 15:29:10 ******/
SET ANSI_NULLS OFF
GO
SET QUOTED_IDENTIFIER ON
GO






/*	Author : Tommy Ho	*/

CREATE PROCEDURE [dbo].[sp_select_IMITMDAT_timstp] 

@iid_cocde 		nvarchar(6),	@iid_venno	nvarchar(6),	
@iid_venitm		nvarchar(20),	@iid_itmseq	int,
@iid_recseq		int

AS

select 	cast(iid_timstp as int) as 'iid_timstp'
from  IMITMDAT

where 	
--iid_cocde = @iid_cocde and  	
	iid_venno = @iid_venno 	and
	iid_venitm = @iid_venitm	and 	iid_itmseq = @iid_itmseq	and
	iid_recseq = @iid_recseq






GO
GRANT EXECUTE ON [dbo].[sp_select_IMITMDAT_timstp] TO [ERPUSER] AS [dbo]
GO
