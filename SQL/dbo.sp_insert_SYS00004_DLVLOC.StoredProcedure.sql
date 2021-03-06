/****** Object:  StoredProcedure [dbo].[sp_insert_SYS00004_DLVLOC]    Script Date: 09/29/2017 15:29:09 ******/
DROP PROCEDURE [dbo].[sp_insert_SYS00004_DLVLOC]
GO
/****** Object:  StoredProcedure [dbo].[sp_insert_SYS00004_DLVLOC]    Script Date: 09/29/2017 15:29:09 ******/
SET ANSI_NULLS OFF
GO
SET QUOTED_IDENTIFIER OFF
GO


CREATE procedure [dbo].[sp_insert_SYS00004_DLVLOC]
@cocde	as nvarchar(6),                                                                                                                                                                                                                                                                 
@LADGR	as nvarchar(4),
@WERKS	as nvarchar(4),
@VSTEL	as nvarchar(4),
@VTEXTE	as nvarchar(255),
@VTEXTM	as nvarchar(255),
@dummy	as char(1)		

AS

begin




if (select count(*) from syshgpt where upper(ysp_ldggrp) = upper(@LADGR) and upper(ysp_fty) = upper(@WERKS) and upper(ysp_shgpt) = upper(@VSTEL)) > 0 
begin


update syshgpt
set ysp_engdsc = isnull(@VTEXTE,'') , ysp_chndsc = isnull(@VTEXTM,''), ysp_updusr = 'SAPUSER', ysp_upddat = getdate()
where upper(ysp_ldggrp) = upper(@LADGR) and upper(ysp_fty) = upper(@WERKS) and upper(ysp_shgpt) = upper(@VSTEL)

end

else

begin


insert into  syshgpt (
ysp_cocde,
ysp_ldggrp,
ysp_fty,
ysp_shgpt,
ysp_engdsc,
ysp_chndsc,
ysp_creusr,
ysp_updusr

)
values
(
'',
isnull(@LADGR,'')	,
isnull(@WERKS,'')	,
isnull(@VSTEL,'')	,
isnull(@VTEXTE,'')	,
isnull(@VTEXTM,'')	,
'SAPUSER',
'SAPUSER'
)



end
end


GO
GRANT EXECUTE ON [dbo].[sp_insert_SYS00004_DLVLOC] TO [ERPUSER] AS [dbo]
GO
