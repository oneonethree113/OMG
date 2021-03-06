/****** Object:  StoredProcedure [dbo].[sp_list_POBOMDTL]    Script Date: 09/29/2017 15:29:09 ******/
DROP PROCEDURE [dbo].[sp_list_POBOMDTL]
GO
/****** Object:  StoredProcedure [dbo].[sp_list_POBOMDTL]    Script Date: 09/29/2017 15:29:10 ******/
SET ANSI_NULLS OFF
GO
SET QUOTED_IDENTIFIER OFF
GO







-- Checked by Allan Yuen at 27/07/2003


/************************************************************************
Author:		Wong Hong
Date:		4th Jan, 2002
Description:	Select data From POBOMDTL
Parameter:	1. Company
		2. PO No
************************************************************************
Modification History
************************************************************************
MOdified On		Modified By		Description
************************************************************************
2004/09/17		Lester Wu		Change Position, 
						Show Currency of Negotiated price
************************************************************************/



--sp_list_POBOMDTL 'UCPP','UP0406398-B001'
CREATE   procedure [dbo].[sp_list_POBOMDTL]
                                                                                                                                                                                                                                                               
@pbd_cocde nvarchar(6) ,
@pbd_bompo nvarchar(20) 
AS
begin
declare @EmptyCanDat as char(10)
set @EmptyCanDat = '__/__/____'

select 
	pbd_cocde,				-- 0
	pbd_bompo,			-- 1
	pbd_bomseq,			-- 2
	pbd_itmno,				-- 3
	pbd_venitm,			-- 4
	pbd_regitm,			-- 5
	isnull(pbd_assitm,'') as 'pbd_assitm',	-- 6
	pbd_colcde,			-- 7
	pbd_adjqty,			-- 8
	pbd_rioqty,				-- 9
	isnull(pbh_curcde,'') as 'pbh_curcde',	-- 10
	pbd_negprc,			-- 11
	pbd_bomcst,			-- 12
	convert(nvarchar(10),pbd_shpstr,101) as 'pbd_shpstr',	-- 13
	convert(nvarchar(10),pbd_shpend,101) as 'pbd_shpend',	-- 14
	case pbd_candat 
		when '1900-01-01 00:00:00.000'  then @EmptyCanDat
	else 
		convert(char(10),pbd_candat,101)
	end as 'pbd_candat',	--15

	pbd_rvenitm,
	pbd_engdsc,
	pbd_chndsc,
	pbd_vencol,
	pbd_vcodsc,
	
	pbd_untcde,
	pbd_ordqty,
	pbd_orgordqty,
	pbd_wastage,
	pbd_bomamt,
	
	pbd_imcurcde,
	pbd_imftyprc,
	pbd_bcurcde,
	pbd_ftyprc,
	pbd_engrid,
	pbd_chnrid,
	pbd_coldsc,
	pbd_refpo,
	pbd_pqbom,
	
	pbd_rcvqty,
	pbd_lnecde,
	pbd_creusr,
	pbd_updusr,
	pbd_credat,

	pbd_upddat,
	pbd_timstp
from 
	POBOMDTL(nolock)
left join 	POBOMHDR(nolock) on pbd_cocde = pbh_cocde and pbd_bompo = pbh_bompo
where                                                                                                                                                                                                                                                                 
pbd_cocde = @pbd_cocde and
pbd_bompo = @pbd_bompo


end



GO
GRANT EXECUTE ON [dbo].[sp_list_POBOMDTL] TO [ERPUSER] AS [dbo]
GO
