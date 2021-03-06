/****** Object:  StoredProcedure [dbo].[sp_list_SYCATFML]    Script Date: 09/29/2017 15:29:09 ******/
DROP PROCEDURE [dbo].[sp_list_SYCATFML]
GO
/****** Object:  StoredProcedure [dbo].[sp_list_SYCATFML]    Script Date: 09/29/2017 15:29:10 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

-- Checked by Allan Yuen at 28/07/2003

/*
=========================================================
Program ID	: 
Description   	: 
Programmer  	: 
Create Date   	: 
Last Modified  	: 15 July 2003
Table Read(s) 	:
Table Write(s) 	:
=========================================================
 Modification History                                    
=========================================================
Date		Author		Description
=========================================================     
20030715		Allan Yuen		For Merge Porject
2005-09-14	Lester Wu		Cater External Items' Category Code
*/


-- sp_list_SYCATFML 'UCPP','I','MIS'
-- sp_list_SYCATFML 'UCPP','E','MIS'

CREATE PROCEDURE [dbo].[sp_list_SYCATFML] 
@cocde 	nvarchar(6) = ' ', 
@VenTyp	char(1), 
@gsUsrID	varchar(30)
AS
BEGIN

	--Lester Wu 2005-09-14, cater external items' category code
	if @VenTyp = 'E' 
	Begin
		select 
			null as 'yaf_lnecde',
			ycc_catcde as 'yaf_catcde',
			'' as 'yfi_fmlopt',
			'' as 'yfi_fml'
			
		from 
			SYCATCDE 
		where 
			ycc_level = '4'
	
		UNION
	
		select 
			yli_lnecde,
			null,
			null,
			null
		from 
			sylneinf
		where 
			yli_cocde = ' '
	END
	
	Else

	BEGIN

		Select 
			yaf_lnecde,
			yaf_catcde,
			yfi_fmlopt,
			yfi_fml
		from 
			SYCATFML, SYFMLINF
		where
		--	yaf_cocde = @cocde AND
			yaf_cocde = ' ' AND
			yaf_cocde = yfi_cocde AND
			yaf_fmlopt = yfi_fmlopt
		UNION
		select 
			yli_lnecde,
			null,
			null,
			null
		from 
			sylneinf
		where 
		--	yli_cocde = @cocde and 
			yli_cocde = ' ' and 
		--	yli_lnecde not in (select yaf_lnecde from sycatfml where yaf_cocde = @cocde  )
			yli_lnecde not in (select yaf_lnecde from sycatfml where yaf_cocde = ' '  )
	
	End
	
END

/*
if @cocde = 'UCPP' 
BEGIN
	Select 
	yaf_lnecde,
	yaf_catcde,
	yfi_fmlopt,
	yfi_fml
	from SYCATFML, SYFMLINF
	where
	yaf_cocde = @cocde AND
	yaf_cocde = yfi_cocde AND
	yaf_fmlopt = yfi_fmlopt
	UNION
	select yli_lnecde,
	null,
	null,
	null
	from sylneinf
	where 
	yli_cocde = @cocde and 
	yli_lnecde not in (select yaf_lnecde from sycatfml where yaf_cocde = @cocde  )
END
ELSE
BEGIN
	Select  
	yli_lnecde as yaf_lnecde,
	null as yaf_catcde,
	null as yfi_fmlopt,
	null as yfi_fml
	from sylneinf
	UNION
	Select  null,
	ycc_catcde,
	null,
	null
	from  sycatcde
	where
	ycc_level = '4'
END
*/









GO
GRANT EXECUTE ON [dbo].[sp_list_SYCATFML] TO [ERPUSER] AS [dbo]
GO
