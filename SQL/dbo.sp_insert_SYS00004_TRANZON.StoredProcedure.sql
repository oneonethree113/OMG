/****** Object:  StoredProcedure [dbo].[sp_insert_SYS00004_TRANZON]    Script Date: 09/29/2017 15:29:09 ******/
DROP PROCEDURE [dbo].[sp_insert_SYS00004_TRANZON]
GO
/****** Object:  StoredProcedure [dbo].[sp_insert_SYS00004_TRANZON]    Script Date: 09/29/2017 15:29:09 ******/
SET ANSI_NULLS OFF
GO
SET QUOTED_IDENTIFIER OFF
GO


CREATE procedure [dbo].[sp_insert_SYS00004_TRANZON]

@cocde	as nvarchar(6),                                                                                                                                                                                                                                                   
@LAND1	as nvarchar(3),
@ZONE1	as nvarchar(10),
@VTEXTE	as nvarchar(255),
@VTEXTM	as nvarchar(255),
@dummy		char(1)
			

AS

begin




if (select count(*) from sytzone where upper(ytz_land) = upper(@LAND1) and upper(ytz_zONE) = upper(@ZONE1)) > 0 
begin


update sytzone
set ytz_engdsc = isnull(@VTEXTE,'') , ytz_chndsc = isnull(@VTEXTM,''), ytz_updusr = 'SAPUSER', ytz_upddat = getdate()
where upper(ytz_land) = upper(@LAND1) and upper(ytz_zONE) = upper(@ZONE1) 

end

else

begin


insert into sytzone (
ytz_cocde,
ytz_land,
ytz_zone,
ytz_engdsc,
ytz_chndsc,
ytz_creusr,
ytz_updusr

)
values
(
'',
isnull(@LAND1,'')	,
isnull(@ZONE1,'')	,
isnull(@VTEXTE,'')	,
isnull(@VTEXTM,'')	,
'SAPUSER',
'SAPUSER'
)



end
end


GO
GRANT EXECUTE ON [dbo].[sp_insert_SYS00004_TRANZON] TO [ERPUSER] AS [dbo]
GO
