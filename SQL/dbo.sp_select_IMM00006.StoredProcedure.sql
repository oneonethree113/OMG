/****** Object:  StoredProcedure [dbo].[sp_select_IMM00006]    Script Date: 09/29/2017 15:29:09 ******/
DROP PROCEDURE [dbo].[sp_select_IMM00006]
GO
/****** Object:  StoredProcedure [dbo].[sp_select_IMM00006]    Script Date: 09/29/2017 15:29:10 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO







/*********************************************************
===========================================
Program ID	: sp_select_IMM00006
Description		: Retrieve information of the input item no
Programmer	: Lester Wu
ALTER  Date		:
Table Read(s)	: IMBASINF, IMMRKUP, SYCATCDE, VNBASINF
Table Write(s)	:
===========================================
Modification History
===========================================
Date		Initial		Description
===========================================
2005-05-23	Allan Yuen		Add Custom Vendor
***********************************************************/

--sp_select_IMM00006 'UCPP','031434-00862'

Create procedure [dbo].[sp_select_IMM00006]
@cocde	nvarchar(6),
@ibi_itmno	nvarchar(20)

as
begin


--retrieve timestamp from 
DECLARE @tim_IMVENPCK as int,
	@tim_IMVENINF as int,
	@tim_IMBASINF as int,
	@tim_IMMRKUP as int
 		

set @tim_IMBASINF =0
set @tim_IMMRKUP = 0
set @tim_IMVENPCK =0
set @tim_IMVENINF = 0
		
select @tim_IMBASINF =cast(ibi_timstp as int) from IMBASINF where ibi_itmno = @ibi_itmno  order by ibi_upddat desc
select @tim_IMMRKUP =cast(imu_timstp as int) from IMMRKUP where imu_itmno = @ibi_itmno  order by imu_upddat desc
select @tim_IMVENPCK = cast(ivp_timstp as int) from IMVENPCK where ivp_itmno=@ibi_itmno order by ivp_upddat desc
select @tim_IMVENINF =cast(ivi_timstp as int) from IMVENINF where ivi_itmno = @ibi_itmno  order by ivi_upddat desc

--select @tim_IMVENPCK,@tim_IMVENINF 

select 
	ibi_itmno,
	ibi_typ,
	case ibi_itmsts 
		when 'CMP' then 'CMP - Active Item with complete Info.' 
		when 'HLD' then 'HLD - Active Item Hold by the system'
		when 'DIS' then 'DIS - Discontinue Item'
		when 'INA' then 'INA - Inactive Item'
		when 'CLO' then 'CLO - Closed (UCP Item)'
		when 'INC' then 'INC - Active Item with incomplete Info.' 
		when 'TBC' then 'TBC - To be confirmed Item'
		-- Lester Wu  2006-09-17
		when 'OLD' then 'OLD - Old Item'
	                   else '' end as 'ibi_itmsts',
	ibi_venno + ' - ' + isnull(aa.vbi_vensna,'') as 'ibi_venno',
	ibi_cusven + ' - ' + isnull(bb.vbi_vensna,'') as 'ibi_cusven',
	isnull(ibi_lnecde,'') as 'ibi_lnecde',
	case ltrim(rtrim(isnull(ibi_catlvl4,''))) when '' then '' else  isnull(ibi_catlvl4,'') + ' - ' + isnull(ycc_catdsc,'') end  as 'ibi_catlvl4',
	ibi_engdsc,
	ibi_chndsc,
	@tim_IMBASINF as 'ibi_timstp',
	@tim_IMMRKUP as 'imu_timstp',
	@tim_IMVENPCK as 'ivp_timstp',
	@tim_IMVENINF as 'ivi_timstp'
from 
	IMBASINF (NOLOCK)
	left join VNBASINF aa  (NOLOCK) ON ibi_venno = aa.vbi_venno
	left join VNBASINF bb  (NOLOCK) ON ibi_cusven = bb.vbi_venno
	left join SYCATCDE (NOLOCK) ON ycc_level = '4'  and   ibi_catlvl4 = ycc_catcde
where ibi_itmno=@ibi_itmno
and ibi_venno between 'A' and 'Z'

end








GO
GRANT EXECUTE ON [dbo].[sp_select_IMM00006] TO [ERPUSER] AS [dbo]
GO
