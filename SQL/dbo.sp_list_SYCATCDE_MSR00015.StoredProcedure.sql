/****** Object:  StoredProcedure [dbo].[sp_list_SYCATCDE_MSR00015]    Script Date: 09/29/2017 15:29:09 ******/
DROP PROCEDURE [dbo].[sp_list_SYCATCDE_MSR00015]
GO
/****** Object:  StoredProcedure [dbo].[sp_list_SYCATCDE_MSR00015]    Script Date: 09/29/2017 15:29:10 ******/
SET ANSI_NULLS OFF
GO
SET QUOTED_IDENTIFIER ON
GO



-- Checked by Allan Yuen at 28/07/2003

/*
=========================================================
Program ID	: 
Description   	: 
Programmer  	: 
Create Date   	: 
Last Modified  	: 15 July 2003
Table Read(s) 	:
Table Write(s) 	:
=========================================================
 Modification History                                    
=========================================================
Date		Author		Description
=========================================================     
20030715	Allan Yuen		For Merge Porject
*/

CREATE PROCEDURE [dbo].[sp_list_SYCATCDE_MSR00015]

@cocde nvarchar(8) = ' ',
@catlvl nvarchar(20),
@UsrId nvarchar(12)

 AS

SELECT

ycc_catcde + ' - ' + ycc_catdsc as 'ycc_catcde'

FROM

SYCATCDE

WHERE
--ycc_cocde = @cocde and
ycc_cocde = ' ' and
ycc_level =  @catlvl


ORDER by ycc_catcde





GO
GRANT EXECUTE ON [dbo].[sp_list_SYCATCDE_MSR00015] TO [ERPUSER] AS [dbo]
GO
