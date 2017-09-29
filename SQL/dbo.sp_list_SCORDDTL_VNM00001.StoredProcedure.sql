/****** Object:  StoredProcedure [dbo].[sp_list_SCORDDTL_VNM00001]    Script Date: 09/29/2017 15:29:09 ******/
DROP PROCEDURE [dbo].[sp_list_SCORDDTL_VNM00001]
GO
/****** Object:  StoredProcedure [dbo].[sp_list_SCORDDTL_VNM00001]    Script Date: 09/29/2017 15:29:10 ******/
SET ANSI_NULLS OFF
GO
SET QUOTED_IDENTIFIER OFF
GO





/**** Object:  Stored Procedure dbo.sp_list_SCORDDTL_VNM00001    Script Date: 04/07/2003 19:06:49 ******/
/*
=========================================================
Program ID	: 	sp_list_SCORDDTL_VNM00001
Description   	: 	Check Vendor existing in Sales Confirmation
Programmer  	: 	Lewis To
Create Date   	: 	07 APRIL 2003
Last Modified  	: 
Table Read(s) 	:	SCORDDTL
Table Write(s) 	:
=========================================================
 Modification History                                    
=========================================================

               
=========================================================     
*/

-- Checked by Allan Yuen at 27/07/2003


CREATE PROCEDURE [dbo].[sp_list_SCORDDTL_VNM00001]
@cocde as varchar(6),
@venno as varchar(6)



AS

--select sod_venno  from SCORDDTL where sod_venno = @venno and sod_cocde = @cocde
-- changed by Mark Lau 20081027
select sod_venno  from SCORDDTL where sod_venno = @venno


GO
GRANT EXECUTE ON [dbo].[sp_list_SCORDDTL_VNM00001] TO [ERPUSER] AS [dbo]
GO
