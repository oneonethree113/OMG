/****** Object:  StoredProcedure [dbo].[sp_select_QUOTNDTL_check_pck_std]    Script Date: 09/29/2017 15:29:09 ******/
DROP PROCEDURE [dbo].[sp_select_QUOTNDTL_check_pck_std]
GO
/****** Object:  StoredProcedure [dbo].[sp_select_QUOTNDTL_check_pck_std]    Script Date: 09/29/2017 15:29:10 ******/
SET ANSI_NULLS OFF
GO
SET QUOTED_IDENTIFIER OFF
GO


/************************************************************************
Author:		Mark Lau
Date:		15th December, 2008
Description:	Check packing
***********************************************************************
*/


CREATE  PROCEDURE [dbo].[sp_select_QUOTNDTL_check_pck_std] 

@imu_cocde 	nvarchar(6),
@imu_itmno	nvarchar(20),
@imu_pckseq	int,
@imu_pckunt	nvarchar(6),
@imu_inrqty	int,
@imu_mtrqty	int,
@imu_conftr	numeric(9),
@creusr		nvarchar(30)

AS

begin

if ( @imu_pckseq = -1 )
begin
select * from immrkup where imu_itmno = @imu_itmno and imu_pckunt = @imu_pckunt	and
		imu_inrqty = @imu_inrqty	and
		imu_mtrqty = @imu_mtrqty 	and
		imu_conftr = @imu_conftr	
		and imu_ventyp = 'D' and imu_std = 'Y'
end
else
begin
select * from immrkup where imu_itmno = @imu_itmno and imu_pckseq  = @imu_pckseq	
		and imu_ventyp = 'D' and imu_std = 'Y'
end 
end



GO
GRANT EXECUTE ON [dbo].[sp_select_QUOTNDTL_check_pck_std] TO [ERPUSER] AS [dbo]
GO
