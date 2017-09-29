/****** Object:  StoredProcedure [dbo].[sp_select_IMVENINF_SC]    Script Date: 09/29/2017 15:29:09 ******/
DROP PROCEDURE [dbo].[sp_select_IMVENINF_SC]
GO
/****** Object:  StoredProcedure [dbo].[sp_select_IMVENINF_SC]    Script Date: 09/29/2017 15:29:10 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO

Create  PROCEDURE [dbo].[sp_select_IMVENINF_SC]
                                                                                                                                                                                                                                                               
  

@cocde nvarchar(6) ,
@itmno nvarchar(20) 
                                               

AS
BEGIN

select	ivi_venno,
	isnull(vbi_vensna,'') as 'vbi_vensna',
	isnull(vbi_vensts,'') as 'vbi_vensts',
	vbi_ventyp
from	IMVENINF (nolock)
	left join VNBASINF (nolock) on
		vbi_venno = ivi_venno
where	ivi_itmno = @itmno


END


GO
GRANT EXECUTE ON [dbo].[sp_select_IMVENINF_SC] TO [ERPUSER] AS [dbo]
GO
