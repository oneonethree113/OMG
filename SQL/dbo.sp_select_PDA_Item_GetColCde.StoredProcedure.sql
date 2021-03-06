/****** Object:  StoredProcedure [dbo].[sp_select_PDA_Item_GetColCde]    Script Date: 09/29/2017 15:29:09 ******/
DROP PROCEDURE [dbo].[sp_select_PDA_Item_GetColCde]
GO
/****** Object:  StoredProcedure [dbo].[sp_select_PDA_Item_GetColCde]    Script Date: 09/29/2017 15:29:10 ******/
SET ANSI_NULLS OFF
GO
SET QUOTED_IDENTIFIER OFF
GO






/*
=========================================================
Description   	: sp_select_PDA_Item_GetColCde
Programmer  	: Mark LAu
Create Date   	: 2008-06-10
Last Modified  	: 
Table Read(s) 	:
Table Write(s) 	:
=========================================================
 Modification History                                    
=========================================================
 Date      		Initial  		Description                          
=========================================================     
2008-06-10 		Mark Lau	Get Color Code For An Item
	
*/

CREATE procedure [dbo].[sp_select_PDA_Item_GetColCde]
@itmno nvarchar(20)
as

Select 
	ibi_credat, ' 'as 'icf_cocde' , 
	isnull( icf_itmno,'') as 'icf_itmno' , 
	isnull( icf_colcde,'') as 'icf_colcde' ,
	isnull( icf_colseq,'') as 'icf_colseq'
from 
	imbasinf (NOLOCK)
	left join IMCOLINF (NOLOCK) on ibi_itmno = icf_itmno 
where 
	ibi_itmno = @itmno and ibi_itmsts <> 'CLO' and (ibi_venno not in (  '0005','0006','0007','0008','0009')) and icf_itmno is not null
UNION

Select 
	ibi_credat, ' 'as 'icf_cocde' , 
	isnull( icf_itmno,'') as 'icf_itmno' , 
	isnull( icf_colcde,'') as 'icf_colcde' ,
	isnull( icf_colseq,'') as 'icf_colseq'
from 
	IMPDAINF (NOLOCK)
	left join imbasinf (NOLOCK) on pda_itmno = ibi_itmno
	left join IMCOLINF (NOLOCK) on ibi_itmno = icf_itmno 
where 
	icf_itmno is not null and 
	ibi_itmsts <> 'CLO' and 
	(ibi_venno not in (  '0005','0006','0007','0008','0009')) 
--and (ibi_itmno not like '00A%' and ibi_itmno not like '00B%' and ibi_itmno not like '00U%' and ibi_itmno not like '01A%' and ibi_itmno not like '01B%' and ibi_itmno not like '01U%' and ibi_itmno not like '02A%' and ibi_itmno not like '02B%' and ibi_itmno not like '02U%' and ibi_itmno not like '03A%' and ibi_itmno not like '03B%' and ibi_itmno not like '03U%'and ibi_itmno not like '04A%' and ibi_itmno not like '04B%' and ibi_itmno not like '04U%')
	and pda_itmno = @itmno 
--	and (pda_credat between @START  and @END)

--order by 
--	ibi_credat desc, icf_itmno,icf_vencol

--order by 	1 desc,2,3
order by 
	icf_cocde desc, icf_itmno,icf_colcde






GO
GRANT EXECUTE ON [dbo].[sp_select_PDA_Item_GetColCde] TO [ERPUSER] AS [dbo]
GO
