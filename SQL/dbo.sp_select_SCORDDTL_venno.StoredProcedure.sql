/****** Object:  StoredProcedure [dbo].[sp_select_SCORDDTL_venno]    Script Date: 09/29/2017 15:29:09 ******/
DROP PROCEDURE [dbo].[sp_select_SCORDDTL_venno]
GO
/****** Object:  StoredProcedure [dbo].[sp_select_SCORDDTL_venno]    Script Date: 09/29/2017 15:29:10 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO




create procedure [dbo].[sp_select_SCORDDTL_venno]
@cocde	varchar(6),
@itmno	varchar(30)
as
Begin

	select isnull(imu_venno,'') as 'venno' , ibi_itmsts as 'itmsts'
	from IMBASINF
	left join IMMRKUP on ibi_itmno = imu_itmno 
	where ibi_itmno = @itmno
	and isnull(imu_ventyp,'') = 'D'
End




GO
GRANT EXECUTE ON [dbo].[sp_select_SCORDDTL_venno] TO [ERPUSER] AS [dbo]
GO
