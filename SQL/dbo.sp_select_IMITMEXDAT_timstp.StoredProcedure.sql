/****** Object:  StoredProcedure [dbo].[sp_select_IMITMEXDAT_timstp]    Script Date: 09/29/2017 15:29:09 ******/
DROP PROCEDURE [dbo].[sp_select_IMITMEXDAT_timstp]
GO
/****** Object:  StoredProcedure [dbo].[sp_select_IMITMEXDAT_timstp]    Script Date: 09/29/2017 15:29:10 ******/
SET ANSI_NULLS OFF
GO
SET QUOTED_IDENTIFIER OFF
GO




/*	Author : Tommy Ho	*/

CREATE PROCEDURE [dbo].[sp_select_IMITMEXDAT_timstp] 

@ied_cocde nvarchar(6),	@ied_venno nvarchar(6),	
@ied_ucpno nvarchar(20),	@ied_itmseq int,
@ied_recseq int

AS

Select 	cast(ied_timstp as int) as 'ied_timstp'
From  IMITMEXDAT
Where 	
	ied_venno = @ied_venno and
	ied_ucpno = @ied_ucpno and 	
	ied_itmseq = @ied_itmseq and
	ied_recseq = @ied_recseq






GO
GRANT EXECUTE ON [dbo].[sp_select_IMITMEXDAT_timstp] TO [ERPUSER] AS [dbo]
GO
