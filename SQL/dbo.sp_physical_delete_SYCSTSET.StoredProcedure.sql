/****** Object:  StoredProcedure [dbo].[sp_physical_delete_SYCSTSET]    Script Date: 09/29/2017 15:29:09 ******/
DROP PROCEDURE [dbo].[sp_physical_delete_SYCSTSET]
GO
/****** Object:  StoredProcedure [dbo].[sp_physical_delete_SYCSTSET]    Script Date: 09/29/2017 15:29:10 ******/
SET ANSI_NULLS OFF
GO
SET QUOTED_IDENTIFIER OFF
GO


/************************************************************************
Author:		Mark Lau
Date:		8th October, 2008
Description:	Delete data in SYCSTSET
***********************************************************************
*/
CREATE PROCEDURE [dbo].[sp_physical_delete_SYCSTSET]

@ycs_cocde	nvarchar(6),
@ycs_cus1no	nvarchar(20),
@ycs_cus2no	nvarchar(20),
@ycs_itmcat	nvarchar(40),
@ycs_csttyp	nvarchar(255)


AS

begin

delete from sycstset
where
ycs_cus1no = @ycs_cus1no	and
ycs_cus2no = @ycs_cus2no	and
ycs_itmcat = @ycs_itmcat	and
ycs_csttyp = @ycs_csttyp	
end


GO
GRANT EXECUTE ON [dbo].[sp_physical_delete_SYCSTSET] TO [ERPUSER] AS [dbo]
GO
