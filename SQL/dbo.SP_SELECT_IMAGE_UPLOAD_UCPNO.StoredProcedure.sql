/****** Object:  StoredProcedure [dbo].[SP_SELECT_IMAGE_UPLOAD_UCPNO]    Script Date: 09/29/2017 15:29:09 ******/
DROP PROCEDURE [dbo].[SP_SELECT_IMAGE_UPLOAD_UCPNO]
GO
/****** Object:  StoredProcedure [dbo].[SP_SELECT_IMAGE_UPLOAD_UCPNO]    Script Date: 09/29/2017 15:29:10 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO




CREATE  PROCEDURE [dbo].[SP_SELECT_IMAGE_UPLOAD_UCPNO]
	@COCDE NVARCHAR(6),
	@ITMNO NVARCHAR(30),
	@VENTYP NVARCHAR(1)
AS
IF @VENTYP='I'
BEGIN
	Select ibi_itmno, '', ibi_lnecde, ibi_venno 
              	from IMBASINF (nolock)
	where
 	ibi_itmno like @ITMNO
END
ELSE
BEGIN
	Select ivi_venitm + '_' + ivi_venno ,ibi_itmno, ivi_venitm, ibi_lnecde, ivi_venno as 'ibi_venno' ,ibi_imgpth
	from IMBASINF (nolock), IMVENINF (nolock) 
	where ibi_itmno = ivi_itmno 
--	and ibi_venno = ivi_venno  
	and ibi_itmno = @ITMNO
	and ivi_def = 'Y'


END

GO
GRANT EXECUTE ON [dbo].[SP_SELECT_IMAGE_UPLOAD_UCPNO] TO [ERPUSER] AS [dbo]
GO
