/****** Object:  StoredProcedure [dbo].[sp_physical_delete_IMBASINF]    Script Date: 09/29/2017 15:29:09 ******/
DROP PROCEDURE [dbo].[sp_physical_delete_IMBASINF]
GO
/****** Object:  StoredProcedure [dbo].[sp_physical_delete_IMBASINF]    Script Date: 09/29/2017 15:29:10 ******/
SET ANSI_NULLS OFF
GO
SET QUOTED_IDENTIFIER OFF
GO






-- Checked by Allan Yuen at 28/07/2003

/*
=========================================================
Program ID	: 
Description   	: 
Programmer  	: 
Create Date   	: 
Last Modified  	: 17 July 2003
Table Read(s) 	:
Table Write(s) 	:
=========================================================
 Modification History                                    
=========================================================
Date		Author		Description
=========================================================     
17 July 2003	Allan Yuen		For Merge Porject
03 Jan 2006	Allan Yuen		Add delete IMCSTINF Table
*/

/************************************************************************
Author:		Kenny Chan
Date:		13th September, 2001
************************************************************************/
CREATE PROCEDURE [dbo].[sp_physical_delete_IMBASINF] 

@ibi_cocde nvarchar(6),
@ibi_itmno nvarchar(4000)


AS

/*
--IMBASINF
Exec ('Delete from IMBASINF
	where 	ibi_cocde = ' + '''' + @ibi_cocde + '''' + ' and
	ibi_itmno in ' + @ibi_itmno
     )

--IMPCKINF
exec ('Delete from IMPCKINF
where 	ipi_cocde = ' + '''' + @ibi_cocde + '''' +
' and 	ipi_itmno in ' +  @ibi_itmno
)

--IMMRKUP
exec ('Delete from IMMRKUP
where 	imu_cocde = ' + '''' + @ibi_cocde + '''' +
' and 	imu_itmno in ' + @ibi_itmno
)

--IMVENINF
exec ('Delete from IMVENINF
where 	ivi_cocde = ' + '''' + @ibi_cocde + '''' +
' and 	ivi_itmno in ' + @ibi_itmno
)

--IMVENPCK
exec('Delete from IMVENPCK
where 	ivp_cocde = ' + '''' + @ibi_cocde + '''' +
' and 	ivp_itmno in ' + @ibi_itmno
)

--IMCOLINF
exec ('Delete from IMCOLINF
where 	icf_cocde = ' + '''' + @ibi_cocde + '''' +
' and 	icf_itmno in ' + @ibi_itmno
)

--IMBOMASS
exec ('Delete from IMBOMASS
where 	iba_cocde = ' + '''' + @ibi_cocde + '''' +
' and 	iba_itmno in ' +  @ibi_itmno
)

--IMCTYINF
exec ('Delete from IMCTYINF
where 	ici_cocde = ' + '''' + @ibi_cocde + '''' +
' and 	ici_itmno in ' + @ibi_itmno
)

--IMMATBKD
exec ('Delete from IMMATBKD
where 	ibm_cocde = ' + '''' + @ibi_cocde + '''' +
' and 	ibm_itmno in ' + @ibi_itmno
)

--IMSALBKG
exec ('Delete from IMSALBKG
where 	isb_cocde = ' + '''' + @ibi_cocde + '''' +
' and 	isb_itmno in ' +  @ibi_itmno
)
*/



--IMBASINF
Exec ('Delete from IMBASINF
	where ibi_itmno in ' + @ibi_itmno
     )

--IMPCKINF
exec ('Delete from IMPCKINF
where ipi_itmno in ' +  @ibi_itmno
)

--IMMRKUP
exec ('Delete from IMMRKUP
where imu_itmno in ' + @ibi_itmno
)

--IMVENINF
exec ('Delete from IMVENINF
where ivi_itmno in ' + @ibi_itmno
)

--IMVENPCK
exec('Delete from IMVENPCK
where ivp_itmno in ' + @ibi_itmno
)

--IMCOLINF
exec ('Delete from IMCOLINF
where icf_itmno in ' + @ibi_itmno
)

--IMBOMASS
exec ('Delete from IMBOMASS
where iba_itmno in ' +  @ibi_itmno
)

--IMCTYINF
exec ('Delete from IMCTYINF
where ici_itmno in ' + @ibi_itmno
)

--IMMATBKD
exec ('Delete from IMMATBKD
where ibm_itmno in ' + @ibi_itmno
)

--IMSALBKG
exec ('Delete from IMSALBKG
where isb_itmno in ' +  @ibi_itmno
)


--IMCSTINF
exec ('Delete from IMCSTINF
where iCi_itmno in ' +  @ibi_itmno
)

--IMCSTDTL
exec ('Delete from IMCSTDTL
where itd_itmno in ' +  @ibi_itmno
)


--IMMRKUPDTL
exec ('Delete from IMMRKUPDTL
where imd_itmno in ' + @ibi_itmno
)

--IMPRCINF
exec ('Delete from IMPRCINF
where imu_itmno in ' + @ibi_itmno
)

--IMMOQMOA
exec ('Delete from IMMOQMOA
where imm_itmno in ' + @ibi_itmno
)



GO
GRANT EXECUTE ON [dbo].[sp_physical_delete_IMBASINF] TO [ERPUSER] AS [dbo]
GO
