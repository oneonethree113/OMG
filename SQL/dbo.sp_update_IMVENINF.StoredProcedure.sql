/****** Object:  StoredProcedure [dbo].[sp_update_IMVENINF]    Script Date: 09/29/2017 15:29:08 ******/
DROP PROCEDURE [dbo].[sp_update_IMVENINF]
GO
/****** Object:  StoredProcedure [dbo].[sp_update_IMVENINF]    Script Date: 09/29/2017 15:29:10 ******/
SET ANSI_NULLS OFF
GO
SET QUOTED_IDENTIFIER OFF
GO







/************************************************************************
Author:		Kenny Chan
Date:		24th September, 2001
************************************************************************/

/*************************************************************************
Modification History
*************************************************************************
Modified on	Modified by	Description
*************************************************************************
2005-09-15	Lester Wu		Trim Vendor Item
*************************************************************************/
CREATE PROCEDURE [dbo].[sp_update_IMVENINF] 

@ivi_cocde	nvarchar(6),
@ivi_itmno  	nvarchar (20),
@ivi_venitm  	nvarchar(20),
@ivi_venno  	nvarchar(6),
@ivi_subcde	nvarchar(10),
@ivi_def  	nvarchar(4),
--@ivi_tirtyp 	nvarchar(1),
--@ivi_moqctn 	int,
--@ivi_qty 		int,
--@ivi_moa 	int,
@ivi_updusr  	nvarchar(30)

AS


update IMVENINF
SET 
--Lester Wu 2005-09-15, trim vendor item no
--ivi_venitm =@ivi_venitm ,
ivi_venitm =LTRIM(RTRIM(REPLACE(REPLACE(@ivi_venitm,char(10),''),char(13),''))) ,
ivi_venno = @ivi_venno ,
ivi_subcde = @ivi_subcde,
ivi_def  =@ivi_def   ,
ivi_updusr=@ivi_updusr,
--ivi_tirtyp = @ivi_tirtyp,
--ivi_moqctn = @ivi_moqctn,
--ivi_qty = @ivi_qty,
--ivi_moa = @ivi_moa,
ivi_upddat=getdate()

Where 
--ivi_cocde = @ivi_cocde and
ivi_itmno = @ivi_itmno and
ivi_venno = @ivi_venno




GO
GRANT EXECUTE ON [dbo].[sp_update_IMVENINF] TO [ERPUSER] AS [dbo]
GO
