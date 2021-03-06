/****** Object:  StoredProcedure [dbo].[sp_physical_delete_IMMRKUP]    Script Date: 09/29/2017 15:29:09 ******/
DROP PROCEDURE [dbo].[sp_physical_delete_IMMRKUP]
GO
/****** Object:  StoredProcedure [dbo].[sp_physical_delete_IMMRKUP]    Script Date: 09/29/2017 15:29:10 ******/
SET ANSI_NULLS OFF
GO
SET QUOTED_IDENTIFIER OFF
GO



-- Checked by Allan Yuen at 28/07/2003

/*
=========================================================
Program ID	: 
Description   	: 
Programmer  	: 
Create Date   	: 
Last Modified  	: 17 July 2003
Table Read(s) 	:
Table Write(s) 	:
=========================================================
 Modification History                                    
=========================================================
Date		Author		Description
=========================================================     
17 July 2003	Allan Yuen		For Merge Porject
*/

/************************************************************************
Author:		Kenny Chan
Date:		15th September, 2001
************************************************************************/

CREATE PROCEDURE [dbo].[sp_physical_delete_IMMRKUP] 

@imu_cocde	nvarchar(6),
@imu_itmno 	nvarchar(20),
@imu_typ	nvarchar(4),
@imu_ventyp	nvarchar(4),
@imu_venno	nvarchar(6),
@imu_prdven	nvarchar(6),
@imu_pckseq	int



AS


delete from IMMRKUP
where 	
--imu_cocde = @imu_cocde and
 	imu_itmno = @imu_itmno
and	imu_typ = @imu_typ 
and	imu_ventyp = @imu_ventyp
and	imu_venno = @imu_venno
and	imu_prdven = @imu_prdven
and 	imu_pckseq = @imu_pckseq





GO
GRANT EXECUTE ON [dbo].[sp_physical_delete_IMMRKUP] TO [ERPUSER] AS [dbo]
GO
