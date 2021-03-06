/****** Object:  StoredProcedure [dbo].[sp_insert_SYCLMTYP]    Script Date: 09/29/2017 15:29:09 ******/
DROP PROCEDURE [dbo].[sp_insert_SYCLMTYP]
GO
/****** Object:  StoredProcedure [dbo].[sp_insert_SYCLMTYP]    Script Date: 09/29/2017 15:29:09 ******/
SET ANSI_NULLS OFF
GO
SET QUOTED_IDENTIFIER ON
GO











/************************************************************************
Author:		Danny Yiu
Date:		26th August, 2011
Description:	insert data into SYCLMTYP
***********************************************************************
*/

CREATE procedure [dbo].[sp_insert_SYCLMTYP]

@yct_cocde	nvarchar(6),
@yct_cde	nvarchar(2),
@yct_dsc	nvarchar(300),
@yct_cus	nvarchar(1),
@yct_ven	nvarchar(1),
@yct_ucp	nvarchar(1),
@yct_updusr	nvarchar(30)
 
AS

BEGIN

--------------------------------------------------------------------------------------------------


insert into  SYCLMTYP
(
yct_cocde,
yct_cde,
yct_dsc,
yct_cus,
yct_ven,
yct_ucp,
yct_creusr,
yct_updusr,
yct_credat,
yct_upddat)
values
(
@yct_cocde,
@yct_cde,
@yct_dsc,
@yct_cus,
@yct_ven,
@yct_ucp,
@yct_updusr,
@yct_updusr,
getdate(),
getdate()
)

END



GO
GRANT EXECUTE ON [dbo].[sp_insert_SYCLMTYP] TO [ERPUSER] AS [dbo]
GO
