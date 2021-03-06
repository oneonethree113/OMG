/****** Object:  StoredProcedure [dbo].[sp_select_IMBASINF_Q]    Script Date: 09/29/2017 15:29:09 ******/
DROP PROCEDURE [dbo].[sp_select_IMBASINF_Q]
GO
/****** Object:  StoredProcedure [dbo].[sp_select_IMBASINF_Q]    Script Date: 09/29/2017 15:29:10 ******/
SET ANSI_NULLS OFF
GO
SET QUOTED_IDENTIFIER OFF
GO













/************************************************************************
Author:		Tommy Ho
Date:		28th December, 2001
Description:	Select data From IMBASINF with Complete or Incomplete
Parameter:		1. Company
		2. Item No.	
************************************************************************/
------------------------------------------------- 
/************************************************************************
Modification History
************************************************************************
Modified by	Modified on	Description
************************************************************************
Lester Wu		2005-05-24	Add Customer Vendor and Customer Sub Code
************************************************************************/





CREATE   procedure [dbo].[sp_select_IMBASINF_Q]
                                                                                                                                                                                                                                                                 
@ibi_cocde nvarchar(6) ,
@ibi_itmno nvarchar(20) 
                                               
AS

begin

select 	ibi_cocde,		ibi_itmno,		ibi_orgitm,
	ibi_lnecde,		ibi_curcde,		ibi_catlvl0,
	ibi_catlvl1,	ibi_catlvl2,	ibi_catlvl3,
	ibi_catlvl4,
	case ibi_itmsts 	when 'CMP' then 'CMP - Active Item with complete Info.'
			when 'INC' then 'INC - Active Item with incomplete Info.'
			when 'HLD' then 'HLD - Active Item Hold by the system'
			when 'DIS' then 'DIS - Discontinue Item'
			when 'INA' then 'INA - Inactive Item'
			when 'TBC' then 'TBC - To be confirmed Item'
			when 'OLD' then 'OLD - Old Item'
	end as 'ibi_itmsts',
	ibi_typ,		ibi_engdsc,	ibi_chndsc,
	ibi_venno,	ibi_tradeven,ibi_examven,	isnull(ven.vbi_vensna,' ') as 'ven.vbi_vensna',
	ibi_imgpth,	ibi_hamusa,	ibi_hameur,
	ibi_dtyusa,		ibi_dtyeur,		ibi_cosmth,
	ibi_rmk,		ibi_tirtyp ,
	isnull(ibi_moqctn,0) as ibi_moqctn ,
	isnull(ibi_qty, 0) as ibi_qty ,
	isnull(ibi_moa, 0) as  ibi_moa,
	ibi_creusr,		ibi_updusr,	ibi_credat,
	ibi_upddat,	cast(ibi_timstp as int) as ibi_timstp,
	ysi_dsc,		ivi_venno + ' - ' + isnull(ven.vbi_vensna,'') as 'ivi_venno',
	ivi_venitm,	isnull(ivi_subcde,'') as 'ivi_subcde',	
	ivi_venno as 'venno',
	ven.vbi_ventyp		--Add by Lewis for check ventype
	--Lester Wu 2005-05-23, add customer vendor
	,ibi_cusven + ' - ' + isnull(cusven.vbi_vensna,'') as 'ibi_cusven'

	--Added by Mark Lau
	,isnull(ibi_alsitmno,'') as 'ibi_alsitmno'
	,isnull(ibi_alscolcde,'') as 'ibi_alscolcde',
	--Added by Lester Wu 20081027
	isnull(ibi_ftytmp,'') as 'ibi_ftytmp'

from 	IMBASINF
left join 	SYSETINF
	on 	--ysi_cocde = ibi_cocde and 
	ysi_typ = '07' and ibi_cosmth = ysi_cde
left join 	IMVENINF 
	on 	--ivi_cocde = ibi_cocde and 
	ivi_itmno = ibi_itmno and ivi_def = 'Y'
left join 	VNBASINF ven
	on 	--ven.vbi_cocde = ibi_cocde and 
	ven.vbi_venno = ivi_venno --and ven.vbi_vensts = 'A'
left join	VNBASINF cusven
	on
	ibi_cusven  = cusven.vbi_venno
where	--ibi_cocde = @ibi_cocde 	and
	ibi_itmno = @ibi_itmno	and
	ibi_typ <> 'BOM'		and
	(ibi_itmsts = 'CMP' or ibi_itmsts = 'INC')
and ven.vbi_vensts = 'A'
                           

end





GO
GRANT EXECUTE ON [dbo].[sp_select_IMBASINF_Q] TO [ERPUSER] AS [dbo]
GO
