/****** Object:  StoredProcedure [dbo].[sp_select_IMXLS002_data]    Script Date: 09/29/2017 15:29:09 ******/
DROP PROCEDURE [dbo].[sp_select_IMXLS002_data]
GO
/****** Object:  StoredProcedure [dbo].[sp_select_IMXLS002_data]    Script Date: 09/29/2017 15:29:10 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO



CREATE  Procedure [dbo].[sp_select_IMXLS002_data]
@cocde varchar(6)
as
BEGIN

Declare
	@tmp_VenNo	varchar(6),
	@tmp_VenNam	varchar(100),
	@tmp_DateTime		Datetime,
	@tmp_VenItm	varchar(20),
	@tmp_ItmNo	varchar(20),
	@tmp_VenCol	varchar(20),
	@tmp_OurCol	varchar(20),
	@tmp_ItmDesc	nvarchar(800),
	@tmp_UM	varchar(20),
	@tmp_Inner	int,
	@tmp_Middle	int,
	@tmp_Master	int,
	@tmp_InnerL	numeric(13,4),
	@tmp_InnerW	numeric(13,4),
	@tmp_InnerH	numeric(13,4),
	@tmp_MasterL	numeric(13,4),
	@tmp_MasterW	numeric(13,4),
	@tmp_MasterH	numeric(13,4),
	@tmp_CFT	numeric(13,4),
--	@tmp_CBM	numeric(13,4),
	@tmp_CurrCst	varchar(3),
	@tmp_ItmCst	numeric(13,4),
	@tmp_MOQUM	varchar(20),
	@tmp_MOQ	int,
	@tmp_Exception	varchar(100)

set 	@tmp_VenNo = ''
set	@tmp_VenNam = ''
set	@tmp_DateTime = getdate()
set	@tmp_VenItm = ''
set	@tmp_ItmNo = ''
set	@tmp_VenCol = ''	
set	@tmp_OurCol = ''
set	@tmp_ItmDesc = ''	
set	@tmp_UM = ''	
set	@tmp_Inner = 0
set	@tmp_Middle = 0
set	@tmp_Master = 0
set	@tmp_InnerL = 0
set	@tmp_InnerW = 0
set	@tmp_InnerH = 0
set	@tmp_MasterL = 0
set	@tmp_MasterW = 0 
set	@tmp_MasterH = 0
set	@tmp_CFT = 0
--set	@tmp_CBM = 0
set	@tmp_CurrCst =''
set	@tmp_ItmCst = 0 
set	@tmp_MOQUM = ''
set	@tmp_MOQ = 0 
set	@tmp_Exception = ''


select 
	@tmp_VenNo 	as 'tmp_VenNo',
	@tmp_VenNam 	as 'tmp_VenNam',
	@tmp_DateTime 	as 'tmp_DateTime',
	@tmp_VenItm 	as 'tmp_VenItm',
	@tmp_ItmNo 	as 'tmp_ItmNo',
	@tmp_VenCol	as 'tmp_VenCol',
	@tmp_OurCol 	as 'tmp_OurCol',
	@tmp_ItmDesc 	as 'tmp_ItmDesc',
	@tmp_UM 	as 'tmp_UM',
	@tmp_Inner 	as 'tmp_Inner',
	@tmp_Middle 	as 'tmp_Middle',
	@tmp_Master 	as 'tmp_Master',
	@tmp_InnerL 	as 'tmp_InnerL',
	@tmp_InnerW 	as 'tmp_InnerW',
	@tmp_InnerH 	as 'tmp_InnerH',
	@tmp_MasterL 	as 'tmp_MasterL',
	@tmp_MasterW 	as 'tmp_MasterW',
	@tmp_MasterH 	as 'tmp_MasterH',
	@tmp_CFT 	as 'tmp_CFT',
--	@tmp_CBM 	as 'tmp_CBM',
	@tmp_CurrCst 	as 'tmp_CurrCst',
	@tmp_ItmCst 	as 'tmp_ItmCst',
	@tmp_MOQUM 	as 'tmp_MOQUM',
	@tmp_MOQ 	as 'tmp_MOQ',
	@tmp_Exception	as 'tmp_Exception'
END





GO
GRANT EXECUTE ON [dbo].[sp_select_IMXLS002_data] TO [ERPUSER] AS [dbo]
GO
