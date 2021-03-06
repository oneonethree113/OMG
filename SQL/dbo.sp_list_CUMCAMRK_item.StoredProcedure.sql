/****** Object:  StoredProcedure [dbo].[sp_list_CUMCAMRK_item]    Script Date: 09/29/2017 15:29:09 ******/
DROP PROCEDURE [dbo].[sp_list_CUMCAMRK_item]
GO
/****** Object:  StoredProcedure [dbo].[sp_list_CUMCAMRK_item]    Script Date: 09/29/2017 15:29:09 ******/
SET ANSI_NULLS OFF
GO
SET QUOTED_IDENTIFIER OFF
GO


/*
=========================================================
Program ID	: sp_list_CUMCAMRK_item
Description   	: List all Data form CustomerCategory Markup Table 
Programmer  	: Lewis To
Create Date   	: 17 Jun 2003
Last Modified  	: 
Table Read(s) 	:CUMCAMRK
Table Write(s) 	:
Remark		: There will select more then one record is the category exist, 
		: the standard markup also will come out, you need to check 
		: and kick out the  standard markup record
=========================================================
 Modification History                                    
=========================================================
Date		Author		Description
               
=========================================================     
*/

Create Procedure [dbo].[sp_list_CUMCAMRK_item]
@running_cocde 	varchar(6),
@cusno		varchar(6),
@itmno		varchar(20)
AS
--set @cusno = '10004'
--set @itmno = '031430-00129'

begin
select 	--top 1
	cat.ccm_cusno,
	ibi_itmno,
	cat. ccm_ventyp, --when 'I' then 'Int'  
		          --when  'E' then 'Ext' 
		          --when  'J' then 'JV' end as ccm_ventyp,
	ibi_catlvl3,
	cat.ccm_cat,
	cat.ccm_markup,
	yfi_fml,
	vw.ccm_effdat -- as 'ccm_effdat'

from  (select ccm_cusno, ccm_ventyp, ccm_cat, max(ccm_effdat) as ccm_effdat 
	from CUMCAMRK where  ccm_effdat <= getdate() 
	group by  ccm_cusno,ccm_ventyp, ccm_cat) vw 
left join  CUMCAMRK cat on 
	cat.ccm_cusno = vw.ccm_cusno and 
	cat.ccm_ventyp = vw.ccm_ventyp and 
	cat.ccm_cat = vw. ccm_cat and 
	cat.ccm_effdat = vw.ccm_effdat

left join 	SYFMLINF on 	 yfi_cocde = ' ' and ccm_markup = yfi_fmlopt
left join IMBASINF on  ibi_itmno = @itmno
left join VNBASINF on  ibi_venno = vbi_venno

where  (cat.ccm_cusno = @cusno and   ibi_catlvl3 = cat.ccm_cat  and vbi_ventyp = cat.ccm_ventyp  ) or
 (cat.ccm_cusno = @cusno and   cat.ccm_cat = 'Standard'  and vbi_ventyp = cat.ccm_ventyp) 
--(--cat.ccm_cusno = @cusno and   ibi_catlvl3 = cat.ccm_cat  and vbi_ventyp = cat.ccm_ventyp  )  )


end



GO
GRANT EXECUTE ON [dbo].[sp_list_CUMCAMRK_item] TO [ERPUSER] AS [dbo]
GO
