/****** Object:  StoredProcedure [dbo].[sp_select_PDA_Item_GetMrkFml]    Script Date: 09/29/2017 15:29:09 ******/
DROP PROCEDURE [dbo].[sp_select_PDA_Item_GetMrkFml]
GO
/****** Object:  StoredProcedure [dbo].[sp_select_PDA_Item_GetMrkFml]    Script Date: 09/29/2017 15:29:10 ******/
SET ANSI_NULLS OFF
GO
SET QUOTED_IDENTIFIER OFF
GO







/*
=========================================================
Description   	: sp_select_PDA_Item_GetMrkFml
Programmer  	: Mark Lau
ALTER  Date   	: 2008-06-04
Last Modified  	: 2008-06-04
Table Read(s) 	:
Table Write(s) 	:
=========================================================
 Modification History                                    
=========================================================
 Date      		Initial  		Description                          
=========================================================     
2008-06-04 		Mark Lau	Get formula for customer

*/

CREATE procedure [dbo].[sp_select_PDA_Item_GetMrkFml]
@cusno NVARCHAR(10),
@ventyp	nvarchar(1),
@cat	nvarchar(20)

as


if ( select count(*) from CUMCOVEN (nolock) where left(ccv_cusno,1) >'4' and ccv_cusno = @cusno and ccv_ventyp = @ventyp) > 0
begin

if (select count(*)
from  
	CUMCAMRK  (nolock)
	left join SYFMLINF (nolock) on yfi_fmlopt = ccm_markup
where 
	left(ccm_cusno,1) >'4' and ccm_cusno = @cusno and ccm_ventyp = @ventyp and ccm_cat = @cat ) > 0

begin

select 	
	distinct
	 'Y' as 'CUMCOVEN', 'Y' as 'CUMCAMRK',
	ccv_cocde,
	ccv_cusno,
	ccv_ventyp,
	ccv_vendef,
	ccm_cat,
	ccm_markup,
	yfi_fml
from 
	CUMCOVEN (nolock)
	left join CUMCAMRK (nolock) on ccv_cusno = ccm_cusno and ccv_ventyp = ccm_ventyp
	left join SYFMLINF (nolock) on yfi_fmlopt = ccm_markup
where 
	left(ccv_cusno,1) >'4' and left(ccm_cusno,1) >'4'
	and ccv_cusno = @cusno and ccv_ventyp = @ventyp  and ccm_cat = @cat

order by ccv_cusno asc

end
else

begin

if (select count(*)
from  
	CUMCAMRK  (nolock)
	left join SYFMLINF (nolock) on yfi_fmlopt = ccm_markup
where 
	left(ccm_cusno,1) >'4' and ccm_cusno = @cusno and ccm_ventyp = @ventyp and ccm_cat =  'STANDARD' ) > 0
begin


select 	
	distinct
	 'Y' as 'CUMCOVEN', 'S' as 'CUMCAMRK',
	ccv_cocde,
	ccv_cusno,
	ccv_ventyp,
	ccv_vendef,
	ccm_cat,
	ccm_markup,
	yfi_fml
from 
	CUMCOVEN (nolock)
	left join CUMCAMRK (nolock) on ccv_cusno = ccm_cusno and ccv_ventyp = ccm_ventyp
	left join SYFMLINF (nolock) on yfi_fmlopt = ccm_markup
where 
	left(ccv_cusno,1) >'4' and left(ccm_cusno,1) >'4'
	and ccv_cusno = @cusno and ccv_ventyp = @ventyp  and ccm_cat = 'STANDARD'

order by ccv_cusno asc
end

else

begin

select 'N' as 'CUMCOVEN', 'N' as 'CUMCAMRK'
end

end


end

else
begin
select 'N' as 'CUMCOVEN', '' as 'CUMCAMRK'
end






GO
GRANT EXECUTE ON [dbo].[sp_select_PDA_Item_GetMrkFml] TO [ERPUSER] AS [dbo]
GO
