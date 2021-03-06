/****** Object:  StoredProcedure [dbo].[sp_insert_SYS00004_cty]    Script Date: 09/29/2017 15:29:09 ******/
DROP PROCEDURE [dbo].[sp_insert_SYS00004_cty]
GO
/****** Object:  StoredProcedure [dbo].[sp_insert_SYS00004_cty]    Script Date: 09/29/2017 15:29:09 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO


CREATE procedure [dbo].[sp_insert_SYS00004_cty]
@cocde	varchar(6),
@sapCtyCde	varchar(20),
@sapSubCde	varchar(20),
@sapShtNamC	varchar(40),
@sapLngNamC	varchar(255),
@sapShtNamE	varchar(40),
@sapLngNamE	varchar(255),
--@sapUpdUsr	varchar(30),
--@sapUpdDat	datetime,
@dummy		char(1)
as



if (select count(1) from SYSETINF where ysi_cde = @sapCtyCde and ysi_typ = '02' ) > 0 
begin
	-- Update Existing Data
	update 
		SYSETINF
	set
		ysi_dsc = @sapShtNamE, 
		ysi_sapengdsc = @sapLngNamE,
		ysi_sapchndsc = @sapLngNamC,
		ysi_value = @sapSubCde, 
		ysi_sapcde = @sapCtyCde,
		--ysi_sapupdusr = @sapUpdUsr , 
		--ysi_sapupddat = @sapUpdDat , 
		ysi_updusr = 'SAPUSR',
		ysi_upddat = getdate()
	where
		ysi_cde = @sapCtyCde and 
		ysi_typ = '02' 
end
else
begin
	
	-- Insert New Record(s)
--	insert into SYSETINF (ysi_cocde,	ysi_typ, ysi_cde, ysi_dsc, ysi_value, ysi_def, ysi_sys, ysi_buyrat, ysi_selrat, ysi_sapcde, ysi_sapengdsc, ysi_sapcvtftr, ysi_creusr,ysi_updusr,ysi_credat,ysi_upddat , ysi_sapupdusr , ysi_sapupddat,ysi_sapchndsc )
--	values ('','02',@sapCtyCde, @sapShtNamE,'','N','Y',0,0,@sapCtyCde,@sapLngNamE,0,'SAPUSR','SAPUSR',getdate(),getdate() ,@sapUpdUsr,@sapUpdDat, @sapLngNamC )

	insert into SYSETINF (ysi_cocde,	ysi_typ, ysi_cde, ysi_dsc, ysi_value, ysi_def, ysi_sys, ysi_buyrat, ysi_selrat, ysi_sapcde, ysi_sapengdsc,  ysi_creusr,ysi_updusr,ysi_credat,ysi_upddat ,ysi_sapchndsc)
	values ('','02',@sapCtyCde, @sapShtNamE,@sapSubCde ,'N','Y',0,0,@sapCtyCde,@sapLngNamE,'SAPUSR','SAPUSR',getdate(),getdate(), @sapLngNamC )

end




GO
GRANT EXECUTE ON [dbo].[sp_insert_SYS00004_cty] TO [ERPUSER] AS [dbo]
GO
