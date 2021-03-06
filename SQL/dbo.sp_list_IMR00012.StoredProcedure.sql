/****** Object:  StoredProcedure [dbo].[sp_list_IMR00012]    Script Date: 09/29/2017 15:29:09 ******/
DROP PROCEDURE [dbo].[sp_list_IMR00012]
GO
/****** Object:  StoredProcedure [dbo].[sp_list_IMR00012]    Script Date: 09/29/2017 15:29:09 ******/
SET ANSI_NULLS OFF
GO
SET QUOTED_IDENTIFIER OFF
GO






/*
=========================================================
Program ID	: sp_list_IMR00012
Description   	: To retrive item no and the corresponding production vendor
Programmer  	: Lester Wu
ALTER   Date	: 2004/07/13
Table Read(s) 	:IMBASINF,IMVENINF,VNBASINF
Table Write(s) 	:
=========================================================
 Modification History                                    
=========================================================
Date		Author		Description
27th Jul, 2004	Lester Wu		return item description
18th Aug, 2004	Lester Wu		set @fromcatlvl4 and/or @tocatlvl4 be 'Empty' if they are empty
9th Sep, 2004	Lester Wu		Cater Category Level with Null Value
=========================================================     

*/


--sp_list_IMR00012 '','FD/ET1.0.1 - EASTER DECORATION (GENERAL)','OT/OT0.0.0 - OTHERS','','','A','A'
--sp_list_IMR00012 'ALL','HD/SC1.8.0 - WOOD CONTAINER / VASE','HD/SC1.8.0 - WOOD CONTAINER / VASE','','','A','A'

CREATE  PROCEDURE [dbo].[sp_list_IMR00012]

@ibi_cocde as nvarchar(6) = ' ',
@fromcatlvl4 as nvarchar(20),
@tocatlvl4 as nvarchar(20),
@fromitmno as nvarchar(20),
@toitmno as nvarchar(20),
@prdVenNoFm as nvarchar(6),
@prdVenNoTo as nvarchar(6)

as

declare @catFm as nvarchar(20)
declare @catTo as nvarchar(20)

set @catFm = @fromcatlvl4
set @catTo = @tocatlvl4

if charindex('-',@fromcatlvl4) > 0 
begin
	set @catFm = rtrim(left(@fromcatlvl4,charindex('-',@fromcatlvl4) -1))
	--select @catFm
end

if charindex('-',@tocatlvl4) > 0 
begin
	set @catTo = rtrim(left(@tocatlvl4,charindex('-',@tocatlvl4) -1))
	--select @catTo
end


select 
	--XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX
	--Lester Wu 2004/08/18
	--set @fromcatlvl4 and/or @tocatlvl4 be 'Empty' if they are empty
	case @catFm when '' then 'Empty' else @catFm end as 'catlvl4_fm',
	case @catTo when '' then 'Empty' else @catTo end as 'catlvl4_to',
	--@catFm  as 'catlvl4_fm',
	--@catTo  as 'catlvl4_to',
	--XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX
	@fromitmno as 'itmno_fm',
	@toitmno as 'itmno_to',	
	@prdVenNoFm as 'prdVenNoFm',
	@prdVenNoTo as 'prdVenNoFm',

	ibi_itmno, 
	isnull(ivi_venno,'') as 'venno',
	isnull(vbi_vensna,'') as 'vensna',
	--Lester WU 2004/07/27
	--Return Item Description
 	isnull(ibi_engdsc,'') as 'ibi_engdsc'
	------------------------------

	
from 
	imbasinf(nolock) 
	left join imveninf (nolock) on ibi_itmno= ivi_itmno
	left join vnbasinf (nolock) on ivi_venno = vbi_venno

where 	(@toitmno='' or (@toitmno<>'' and ibi_itmno between @fromitmno and @toitmno))
and	(isnull(ibi_catlvl4,'')>= @catFm and isnull( ibi_catlvl4,'') <=@catTo )
and	(isnull(ivi_venno,'')>= @prdVenNoFm and isnull(ivi_venno,'')<=@prdVenNoTo)
and	isnull(ivi_def,'') = 'Y'

order by 
	 ibi_itmno








GO
GRANT EXECUTE ON [dbo].[sp_list_IMR00012] TO [ERPUSER] AS [dbo]
GO
