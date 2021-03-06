/****** Object:  StoredProcedure [dbo].[sp_insert_SYCONFTR]    Script Date: 09/29/2017 15:29:09 ******/
DROP PROCEDURE [dbo].[sp_insert_SYCONFTR]
GO
/****** Object:  StoredProcedure [dbo].[sp_insert_SYCONFTR]    Script Date: 09/29/2017 15:29:09 ******/
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
Last Modified  	: 15 July 2003
Table Read(s) 	:
Table Write(s) 	:
=========================================================
 Modification History                                    
=========================================================
Date		Author		Description
=========================================================     
20030715	Allan Yuen		For Merge Porject
*/

/************************************************************************
Author:		Samuel Chan   
Date:		15th September, 2001
Description:	Insert data into SYCONFTR
Parameter:	1. Company Code range    
		2. Color Code range    
************************************************************************/

CREATE PROCEDURE [dbo].[sp_insert_SYCONFTR] 
--------------------------------------------------------------------------------------------------------------------------------------

@ycf_cocde	nvarchar(6) = ' ',
@ycf_code1	nvarchar(6),
@ycf_dsc1		nvarchar(200),
@ycf_code2	nvarchar(6),
@ycf_dsc2		nvarchar(200),
--@ycf_oper		nvarchar(1),
@ycf_value	numeric(12,4),
@ycf_systyp	nvarchar(1),
@ycf_updusr	nvarchar(30)

--@cbi_updusr	nvarchar(30)


--------------------------------------------------------------------------------------------------------------------------------------
AS

INSERT INTO  SYCONFTR

(
ycf_cocde,
ycf_code1,
ycf_dsc1,
ycf_code2,
ycf_dsc2,
--ycf_oper,
ycf_value,
ycf_systyp,
ycf_creusr,
ycf_updusr,
ycf_credat,
ycf_upddat
)
--------------------------------------------------------------------------------------------------------------------------------------
values
(
--@ycf_cocde,
' ',
@ycf_code1,
@ycf_dsc1,
@ycf_code2,
@ycf_dsc2,
--@ycf_oper,
@ycf_value,
@ycf_systyp,
@ycf_updusr,
@ycf_updusr,
getdate(),
getdate()
)

/*
if @ycf_cocde = 'UCPP' and (select count(*) from SYCONFTR where ycf_cocde = 'UCP' and ycf_code1 = @ycf_code1 and ycf_code2 = @ycf_code2) = 0 
begin

	INSERT INTO  SYCONFTR
	(
	ycf_cocde,
	ycf_code1,
	ycf_dsc1,
	ycf_code2,
	ycf_dsc2,
	--ycf_oper,
	ycf_value,
	ycf_systyp,
	ycf_creusr,
	ycf_updusr,
	ycf_credat,
	ycf_upddat
	)
	values
	(
	'UCP',
	@ycf_code1,
	@ycf_dsc1,
	@ycf_code2,
	@ycf_dsc2,
	--@ycf_oper,
	@ycf_value,
	@ycf_systyp,
	'UCPP',
	'UCPP',
	getdate(),
	getdate()
	)
end
*/







GO
GRANT EXECUTE ON [dbo].[sp_insert_SYCONFTR] TO [ERPUSER] AS [dbo]
GO
