/****** Object:  StoredProcedure [dbo].[sp_insert_IMCOLINF]    Script Date: 09/29/2017 15:29:09 ******/
DROP PROCEDURE [dbo].[sp_insert_IMCOLINF]
GO
/****** Object:  StoredProcedure [dbo].[sp_insert_IMCOLINF]    Script Date: 09/29/2017 15:29:09 ******/
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
15 Sep 2005	Lester Wu		Trim Vendor Item , Vendor Color, Color Code
*/

/************************************************************************
Author:		Kenny Chan
Date:		13th September, 2001
************************************************************************/
------------------------------------------------- 
CREATE procedure [dbo].[sp_insert_IMCOLINF]
                                                                                                                                                                                                                                                                 
---------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------- 
@icf_cocde 	nvarchar(6),
@icf_itmno  	nvarchar(20),
@icf_colcde	varchar(30),
@icf_vencol	varchar(30),

--@icf_colcde	nvarchar(30),
--@icf_vencol	nvarchar(30),

@icf_coldsc	nvarchar(200),
@icf_typ		nvarchar(4),
@icf_ucpcde	nvarchar(12),
@icf_eancde	nvarchar(12),
@icf_asscol	char(1),
@icf_swatchpath varchar(200),
@icf_imgpath	varchar(200),
--@icf_venno	varchar(6),
@icf_lnecde	varchar(10),
@icf_updusr	nvarchar(30)
                                     
------------------------------------ 
AS

declare @icf_colseq		int

Set  @icf_colseq = (Select isnull(max(icf_colseq),0)  + 1 from imcolinf where 
		--icf_cocde = @icf_cocde and 
		icf_itmno = @icf_itmno)




insert into  IMCOLINF
(icf_cocde,
icf_itmno,
icf_colcde,
icf_colseq,	
icf_vencol,	
icf_coldsc,
icf_typ,
icf_ucpcde,
icf_eancde,

icf_creusr,
icf_updusr,

icf_credat,
icf_upddat,
icf_asscol,
icf_swatchpath,
icf_imgpath,
--icf_venno,
icf_lnecde)

values(
--@icf_cocde,
' ',
@icf_itmno, 	
--@icf_colcde,
-- Lester Wu 2005-09-15, trim color code and vendor color code
--REPLACE(REPLACE(@icf_colcde,CHAR(10),''),CHAR(13),'') ,
LTRIM(RTRIM(REPLACE(REPLACE(@icf_colcde,CHAR(10),''),CHAR(13),''))) ,
@icf_colseq,
--@icf_vencol,
-- Lester Wu 2005-09-15, trim color code and vendor color code
--REPLACE(REPLACE(@icf_vencol,CHAR(10),''),CHAR(13),'') ,
LTRIM(RTRIM(REPLACE(REPLACE(@icf_vencol,CHAR(10),''),CHAR(13),''))) ,
@icf_coldsc,
@icf_typ,
@icf_ucpcde,
@icf_eancde,

@icf_updusr,
@icf_updusr,
---------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------- 
getdate(),
getdate(),
@icf_asscol,
@icf_swatchpath,
@icf_imgpath,
--@icf_venno,
@icf_lnecde)      
---------------------------------------------------------------------------------------------------------------------------------------------------------------------






GO
GRANT EXECUTE ON [dbo].[sp_insert_IMCOLINF] TO [ERPUSER] AS [dbo]
GO
