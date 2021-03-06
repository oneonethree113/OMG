/****** Object:  StoredProcedure [dbo].[sp_select_IMBASINF_TBM]    Script Date: 09/29/2017 15:29:09 ******/
DROP PROCEDURE [dbo].[sp_select_IMBASINF_TBM]
GO
/****** Object:  StoredProcedure [dbo].[sp_select_IMBASINF_TBM]    Script Date: 09/29/2017 15:29:10 ******/
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
CREATE procedure [dbo].[sp_select_IMBASINF_TBM]
                                                                                                                                                                                                                                                                 
@ibi_cocde nvarchar(6) ,
@ibi_itmno nvarchar(20), 
@org_itmno nvarchar(20)                                               
 
AS

begin

select 	
		ibi_cocde,		case when ibi_itmno = @ibi_itmno then ibi_itmno 
				else ibi_alsitmno end as 'ibi_itmno' ,		ibi_orgitm,
		ibi_lnecde,		ibi_curcde,		ibi_catlvl0,
		ibi_catlvl1,		ibi_catlvl2,		ibi_catlvl3,
		ibi_catlvl4,		ibi_imgpth,		
		case ibi_itmsts 	
			when 'CMP' then 'CMP - Active Item with complete Info.'
			when 'INC' then 'INC - Active Item with incomplete Info.'
			when 'HLD' then 'HLD - Active Item Hold by the system'
			when 'DIS' then 'DIS - Discontinue Item'
			when 'INA' then 'INA - Inactive Item'
			when 'CLO' then 'CLO - Closed (UCP)'
			when 'TBC' then 'TBC - To be confirmed Item'
			--Added by Mark Lau 20060917
			when 'OLD' then 'OLD - Old Item'
		end as 'ibi_itmsts',
		ibi_typ,   	ibi_engdsc,		ibi_chndsc,
		ibi_venno, 	isnull(ven.vbi_vensna,' ') as 'ven.vbi_vensna',
		ibi_imgpth,	ibi_hamusa,		ibi_hameur,
		ibi_dtyusa,	ibi_dtyeur,		ibi_cosmth,
		ibi_rmk,	ibi_tirtyp ,
		isnull(ibi_moqctn,0) as ibi_moqctn ,
		isnull(ibi_qty, 0) as ibi_qty ,
		isnull(ibi_moa, 0) as  ibi_moa,
		ibi_creusr,	ibi_updusr,	ibi_credat,
		ibi_upddat,	cast(ibi_timstp as int) as ibi_timstp,
		ysi_dsc,	ivi_venno + ' - ' + isnull(ven.vbi_vensna,' ') as 'ivi_venno',
		ivi_venitm,	isnull(ivi_subcde,'') as 'ivi_subcde',
		ivi_venno as 'venno', ven.vbi_ventyp,
		--Lester Wu 2005-05-24, add custom vendor
		ibi_cusven + ' - ' + isnull(cusven.vbi_vensna,' ') as 'ibi_cusven'
from 	
		IMBASINF
left join SYSETINF on 
		--ysi_cocde = ibi_cocde and
		--ysi_cocde = ' ' and
		ysi_typ = '07' 
		and ibi_cosmth = ysi_cde
left join IMVENINF on 	
		--ivi_cocde = ibi_cocde and
		ivi_itmno = ibi_itmno 
		and ivi_def = 'Y'
left join VNBASINF ven on 
	--ven.vbi_cocde = ibi_cocde and
	ven.vbi_venno = ivi_venno 
	and ven.vbi_vensts = 'A'

--Lester Wu 2005-05-24, add custom vendor
left join VNBASINF cusven on 
	cusven.vbi_venno = ibi_cusven
	and cusven.vbi_vensts = 'A'
where	
	--ibi_cocde = @ibi_cocde and
	( ibi_alsitmno  = @ibi_itmno or    
	ibi_itmno  = @ibi_itmno) 	and
	ibi_typ <> 'BOM' and
	(ibi_itmsts = 'CMP' or ibi_itmsts = 'INC')
and         ibi_typ = (select 
				ibi_typ 
		    from 
				imbasinf 
		    where 
				--ibi_cocde = @ibi_cocde and
				ibi_itmno = @org_itmno or ibi_alsitmno = @org_itmno
		    )                           

end


GO
GRANT EXECUTE ON [dbo].[sp_select_IMBASINF_TBM] TO [ERPUSER] AS [dbo]
GO
