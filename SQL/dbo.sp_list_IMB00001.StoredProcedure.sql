/****** Object:  StoredProcedure [dbo].[sp_list_IMB00001]    Script Date: 09/29/2017 15:29:09 ******/
DROP PROCEDURE [dbo].[sp_list_IMB00001]
GO
/****** Object:  StoredProcedure [dbo].[sp_list_IMB00001]    Script Date: 09/29/2017 15:29:09 ******/
SET ANSI_NULLS OFF
GO
SET QUOTED_IDENTIFIER OFF
GO




CREATE procedure [dbo].[sp_list_IMB00001]
                                                                                                                                                                                                                                                               
@cocde	nvarchar(6)

AS

IF @cocde = 'UCP'
BEGIN

	SELECT ibi_itmno,
	(CASE ibi_venno WHEN '0005' THEN 
	REPLACE(REPLACE(ibi_lnecde, '/', '_'), '-', '_') 
	ELSE 
	ibi_venno END) AS subfolder,
	(CASE ibi_venno WHEN '0005' THEN 
	REPLACE(REPLACE(ivi_venitm, '/', '_'), '-', '_') 
	ELSE 
	REPLACE(REPLACE(ibi_itmno, '/', '_'), '-', '_') + '_' + ibi_venno END) as imgname
	FROM IMBASINF, IMVENINF
	WHERE ibi_cocde = @cocde AND
	ivi_cocde = ibi_cocde AND
	ivi_itmno = ibi_itmno AND
	ivi_venno = ibi_venno 
	order by ibi_itmno

END
ELSE
BEGIN
	SELECT ibi_itmno,
	REPLACE(REPLACE(ibi_lnecde, '/', '_'), '-', '_') as subfolder, 
	REPLACE(REPLACE(ibi_itmno, '/', '_'), '-', '_') as imgname
	FROM IMBASINF
	WHERE ibi_cocde = @cocde
	order by ibi_itmno
END



GO
GRANT EXECUTE ON [dbo].[sp_list_IMB00001] TO [ERPUSER] AS [dbo]
GO
