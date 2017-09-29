/****** Object:  StoredProcedure [dbo].[sp_select_SHIPGDTL_co_consol]    Script Date: 09/29/2017 15:29:09 ******/
DROP PROCEDURE [dbo].[sp_select_SHIPGDTL_co_consol]
GO
/****** Object:  StoredProcedure [dbo].[sp_select_SHIPGDTL_co_consol]    Script Date: 09/29/2017 15:29:10 ******/
SET ANSI_NULLS OFF
GO
SET QUOTED_IDENTIFIER OFF
GO














/************************************************************************
Author:		Marco Chan
Date:		15th February, 2011
Description:	insert data into SHCHGDTL
***********************************************************************
*/

CREATE     procedure [dbo].[sp_select_SHIPGDTL_co_consol]


@hid_cocde	nvarchar(6),
@hid_consolno	nvarchar(30)
 
AS

BEGIN

select distinct hid_cocde as 'company'
 from shipgdtl 
			where 
				 hid_consolno = @hid_consolno


--------------------------------------------------------------------------------------------------
END












GO
GRANT EXECUTE ON [dbo].[sp_select_SHIPGDTL_co_consol] TO [ERPUSER] AS [dbo]
GO
