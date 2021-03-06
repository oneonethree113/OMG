/****** Object:  StoredProcedure [dbo].[sp_insert_IMVENINF]    Script Date: 09/29/2017 15:29:09 ******/
DROP PROCEDURE [dbo].[sp_insert_IMVENINF]
GO
/****** Object:  StoredProcedure [dbo].[sp_insert_IMVENINF]    Script Date: 09/29/2017 15:29:09 ******/
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
15 Sep 2005	Lester Wu		Trim Vendor Item No
*/

/************************************************************************
Author:		Kenny Chan
Date:		24th September, 2001
************************************************************************/

CREATE PROCEDURE [dbo].[sp_insert_IMVENINF] 

@ivi_cocde	nvarchar(6) = ' ',
@ivi_itmno  	nvarchar (20),
@ivi_venitm  	nvarchar(20),
@ivi_venno  	nvarchar(6),
@ivi_subcde	nvarchar(10),
@ivi_def  	nvarchar(4),
--@ivi_tirtyp 	nvarchar(1),
--@ivi_moqctn 	int,
--@ivi_qty 	int,
--@ivi_moa	int,
@ivi_updusr  	nvarchar(30)

AS


insert into IMVENINF
(
ivi_cocde,
ivi_itmno,
ivi_venitm ,
ivi_venno ,
ivi_subcde,
ivi_def  ,
--ivi_tirtyp ,
--ivi_moqctn ,
--ivi_qty ,
--ivi_moa ,
ivi_creusr,
ivi_updusr,
ivi_credat,
ivi_upddat)
values
(
--@ivi_cocde,
' ',
-- Lester Wu 2005-09-15, trim vendor item #
--@ivi_itmno,
--@ivi_venitm ,
ltrim(rtrim(replace(replace(@ivi_itmno,CHAR(10),''),CHAR(13),''))),
ltrim(rtrim(replace(replace(@ivi_venitm ,CHAR(10),''),CHAR(13),''))),
------
@ivi_venno ,
@ivi_subcde,
@ivi_def  ,
--@ivi_tirtyp ,
--@ivi_moqctn ,
--@ivi_qty ,
--@ivi_moa ,
@ivi_updusr,
@ivi_updusr,
getdate(),
getdate())











GO
GRANT EXECUTE ON [dbo].[sp_insert_IMVENINF] TO [ERPUSER] AS [dbo]
GO
