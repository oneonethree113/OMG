/****** Object:  StoredProcedure [dbo].[sp_insert_SYS00004_SALOFF]    Script Date: 09/29/2017 15:29:09 ******/
DROP PROCEDURE [dbo].[sp_insert_SYS00004_SALOFF]
GO
/****** Object:  StoredProcedure [dbo].[sp_insert_SYS00004_SALOFF]    Script Date: 09/29/2017 15:29:09 ******/
SET ANSI_NULLS OFF
GO
SET QUOTED_IDENTIFIER OFF
GO


CREATE procedure [dbo].[sp_insert_SYS00004_SALOFF]
          @cocde	as nvarchar(6),                                                                                                                                                                                                                                                       
@VKBUR	as nvarchar(3),
@BEZEIE	as nvarchar(20),
@BEZEIM     	as nvarchar(20),
@dummy		char(1)
AS

begin




if (select count(*) from sysaloff where upper(yso_code) = upper(@VKBUR) ) > 0 
begin


update sysaloff
set yso_engdsc = isnull(@BEZEIE,'') , yso_chndsc = isnull(@BEZEIM,''), yso_updusr = 'SAPUSER', yso_upddat = getdate()
where upper(yso_code) = upper(@VKBUR)

end

else

begin


insert into sysaloff (
yso_cocde,
yso_code,
yso_engdsc,
yso_chndsc,
yso_creusr,
yso_updusr

)
values
(
'',
isnull(@VKBUR,'')	,
isnull(@BEZEIE,'')	,
isnull(@BEZEIM,'')	,
'SAPUSER',
'SAPUSER'
)



end
end


GO
GRANT EXECUTE ON [dbo].[sp_insert_SYS00004_SALOFF] TO [ERPUSER] AS [dbo]
GO
