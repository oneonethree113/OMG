/****** Object:  StoredProcedure [dbo].[sp_select_IMR00014]    Script Date: 09/29/2017 15:29:09 ******/
DROP PROCEDURE [dbo].[sp_select_IMR00014]
GO
/****** Object:  StoredProcedure [dbo].[sp_select_IMR00014]    Script Date: 09/29/2017 15:29:10 ******/
SET ANSI_NULLS OFF
GO
SET QUOTED_IDENTIFIER OFF
GO



/*
=========================================================
Program ID	: sp_select_IMR00014
Description   	: 
Programmer  	: Lester Wu
Table Read(s) 	:
Table Write(s) 	:
=========================================================
 Modification History                                    
=========================================================
 Date      		Initial  	Description                          
=========================================================    

*/



CREATE PROCEDURE [dbo].[sp_select_IMR00014] 
@iid_cocde 	nvarchar(6),
@iid_venitmFm	nvarchar(20),
@iid_venitmTo	nvarchar(20),
@userid		nvarchar(30)
AS

select 
@iid_venitmFm,
@iid_venitmTo,
iid_venitm,
iid_untcde + ' / ' +  ltrim(str(iid_inrqty)) + ' / ' + ltrim(str(iid_mtrqty)) as 'Packing',
isnull(ltrim(str(iid_cft_bef,11,4)),'') as 'iid_cft_bef', 
isnull(ltrim(str(iid_cft,11,4)),'') as 'iid_cft',
isnull(ltrim(str(iid_ftycst_bef,13,4)),'') as 'iid_ftycst_bef', 
isnull(ltrim(str(iid_ftycst,13,4)),'') as 'iid_ftycst',
isnull(ltrim(str(iid_ftyprc_bef,13,4)),'') as 'iid_ftyprc_bef', 
isnull(ltrim(str(iid_ftyprc,13,4)),'') as 'iid_ftyprc' 

from imitmdat 

where 
(@iid_venitmFm = '' or iid_venitm between @iid_venitmFm and @iid_venitmTo) and
iid_stage = 'W'

order by iid_venitm





GO
GRANT EXECUTE ON [dbo].[sp_select_IMR00014] TO [ERPUSER] AS [dbo]
GO
