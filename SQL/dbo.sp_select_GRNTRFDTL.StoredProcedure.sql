/****** Object:  StoredProcedure [dbo].[sp_select_GRNTRFDTL]    Script Date: 09/29/2017 15:29:09 ******/
DROP PROCEDURE [dbo].[sp_select_GRNTRFDTL]
GO
/****** Object:  StoredProcedure [dbo].[sp_select_GRNTRFDTL]    Script Date: 09/29/2017 15:29:10 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO





/*
=========================================================
Program ID	: sp_select_GRNTRFDTL
Description   	: GRN Transfer Maintenance
Programmer  	: Lester Wu
Create Date   	:
Last Modified  	: 
Table Read(s) 	:
Table Write(s) 	:
=========================================================
 Modification History                                    
=========================================================
Date		Author		Description
=========================================================     
2005-10-18	Lester Wu		Show Detail Remak and Custom UM field
*/




CREATE procedure [dbo].[sp_select_GRNTRFDTL]
@cocde	varchar(6),
@Grd_GrnNo	varchar(20)
as
begin
--sp_help GRNTRFDTL
	select
		'N' as 'Del',
		Grd_CreUsr as 'CreUsr',
		Grd_GrnNo,
		Grd_Seq,
		Grd_PrtGrp, -- Frankie Cheung 20091015, GRN Print Group
		Grd_Type,
		Grd_Grp,
		Grd_ItmNo,
		Grd_ItmNam,
		Grd_ItmDsc,
		Grd_Curr,
		Grd_UntPrc,
		Grd_Color,
		case isnull(Grd_CustCat ,'') when '' then '' else case isnull(ymc_catdsc,'') when '' then '' else Grd_CustCat + ' - ' +  ymc_catdsc end end as 'Grd_CustCat',
		Grd_Cty,
		Grd_CTNFm,
		Grd_CTNTo,
		Grd_TtlCTN,
		Grd_CtnUM,
		Grd_GW,
		Grd_NW,
		Grd_TtlGW,
		Grd_TtlNW,
		Grd_PckWgt,
		Grd_PckUM,
		Grd_TtlShpQty,
		Grd_TtlShpQty as 'OriShpQty',
		Grd_ShpUM,
		Grd_RevDept,
		Grd_RefNo,
		Grd_MpoNo,
		-- Lester Wu 2005-10-14, GRN Transfer Maintenence
		Grd_CustQty,
		Grd_CustUM,
		Grd_DtlRmk , 
		
		Grd_CreUsr,
		Grd_CreDat,
		Grd_UpdUsr,
		Grd_UpdDat,
		cast(Grd_TimStp as int) as 'TimStp'

	from 
		GRNTRFDTL
		left join SYMCATCDE on Grd_CustCat = ymc_catcde and ymc_type = 1
	where
		Grd_GrnNo = @Grd_GrnNo
	order by
		Grd_Seq
end










GO
GRANT EXECUTE ON [dbo].[sp_select_GRNTRFDTL] TO [ERPUSER] AS [dbo]
GO
