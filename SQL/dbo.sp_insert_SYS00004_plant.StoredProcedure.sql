/****** Object:  StoredProcedure [dbo].[sp_insert_SYS00004_plant]    Script Date: 09/29/2017 15:29:09 ******/
DROP PROCEDURE [dbo].[sp_insert_SYS00004_plant]
GO
/****** Object:  StoredProcedure [dbo].[sp_insert_SYS00004_plant]    Script Date: 09/29/2017 15:29:09 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO


CREATE procedure [dbo].[sp_insert_SYS00004_plant]
@cocde	varchar(6),
@sapPlantCde	varchar(20),
@sapChnNam	varchar(40),
@sapEngNam	varchar(40),
--@sapUpdUsr	varchar(30),
--@sapUpdDat	datetime,
@dummy		char(1)
as


if (select count(1) from SYSETINF where ysi_cde = @sapPlantCde and ysi_typ = '23' ) > 0 
begin
	-- Update Existing Data

	update 
		SYSETINF
	set
		ysi_dsc = @sapEngNam,
		ysi_sapChndsc = @sapChnNam,
		ysi_sapEngdsc = @sapEngNam,
		--ysi_ = @sapUpdUsr , 
		--ysi_ = @sapUpdDat , 
		ysi_updusr = 'SAPUSR',
		ysi_upddat = getdate()
	where
		ysi_cde = @sapPlantCde and 
		ysi_typ = '23'

end
else
begin
	
	-- Insert New Record(s)
--	insert into SYSETINF (ysi_cocde,	ysi_typ, ysi_cde, ysi_dsc, ysi_value, ysi_def, ysi_sys, ysi_buyrat, ysi_selrat, ysi_sapcde, ysi_sapChndsc, ysi_sapcvtftr, ysi_creusr,ysi_updusr,ysi_credat,ysi_upddat, ysi_sapupdusr , ysi_sapupddat , ysi_sapengdsc)
--	values ('','23',@sapPlantCde, @sapEngNam,'','N','Y',0,0,@sapPlantCde,@sapChnNam,0,'SAPUSR','SAPUSR',getdate(),getdate() ,@sapUpdUsr,@sapUpd , @sapEngNam)

	insert into SYSETINF (ysi_cocde,	ysi_typ, ysi_cde, ysi_dsc, ysi_value, ysi_def, ysi_sys, ysi_buyrat, ysi_selrat, ysi_sapcde, ysi_sapChndsc,  ysi_creusr,ysi_updusr,ysi_credat,ysi_upddat , ysi_sapengdsc)
	values ('','23',@sapPlantCde, @sapEngNam,'','N','Y',0,0,@sapPlantCde,@sapChnNam,'SAPUSR','SAPUSR',getdate(),getdate() , @sapEngNam)

end




GO
GRANT EXECUTE ON [dbo].[sp_insert_SYS00004_plant] TO [ERPUSER] AS [dbo]
GO
