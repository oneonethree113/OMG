/****** Object:  StoredProcedure [dbo].[sp_select_IMFMLHDR]    Script Date: 09/29/2017 15:29:09 ******/
DROP PROCEDURE [dbo].[sp_select_IMFMLHDR]
GO
/****** Object:  StoredProcedure [dbo].[sp_select_IMFMLHDR]    Script Date: 09/29/2017 15:29:10 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO


/*
=========================================================
Program ID	: sp_select_IMFMLHDR
Description   	: 
Programmer  	: Marco Chan	
Create Date   	:
Last Modified  	: 
Table Read(s) 	:
Table Write(s) 	:
=========================================================
 Modification History                                    
=========================================================
 Date      	Initial  		Description                          
=========================================================    
*/
--sp_select_IMFMLHDR '', 'IMMRKUP', 'imu_ftybomcst', 'B', 'x', '04U21V-T075Q4'
create procedure [dbo].[sp_select_IMFMLHDR] 
	@cocde  	nvarchar(6), 
	@ifh_table	varchar(50),
	@ifh_field	varchar(50),
	@ifh_dv		varchar(10),
	@ifh_pv		varchar(10)
AS
set nocount on

declare @flag char(1)

select @flag = isnull(count(*), 0) from IMFMLHDR where ifh_table = @ifh_table and ifh_field = @ifh_field and ifh_dv = @ifh_dv and ifh_pv = @ifh_pv 

select @flag 'res_value'


GO
GRANT EXECUTE ON [dbo].[sp_select_IMFMLHDR] TO [ERPUSER] AS [dbo]
GO
