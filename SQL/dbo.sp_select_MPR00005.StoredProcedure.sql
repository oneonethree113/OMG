/****** Object:  StoredProcedure [dbo].[sp_select_MPR00005]    Script Date: 09/29/2017 15:29:09 ******/
DROP PROCEDURE [dbo].[sp_select_MPR00005]
GO
/****** Object:  StoredProcedure [dbo].[sp_select_MPR00005]    Script Date: 09/29/2017 15:29:10 ******/
SET ANSI_NULLS OFF
GO
SET QUOTED_IDENTIFIER OFF
GO








/*
=========================================================
Program ID	: 
Description   	: 
Programmer  	: 
Create Date   	: 2005/10/21
Last Modified  	: 
Table Read(s) 	:
Table Write(s) 	:
=========================================================
 Modification History                                    
=========================================================
Date		Author		Description
=========================================================

*/

CREATE PROCEDURE [dbo].[sp_select_MPR00005]

@cocde		varchar(6),
@itmnoopt		char(1),
@itmnofm		varchar(20),
@itmnoto		varchar(20),
@custcatopt	char(1),
@custcatfm	varchar(20),
@custcatto	varchar(20),
@issdateopt	char(1),
@issdatefm	datetime,
@issdateto		datetime,
@sortoption	char(1)

AS
if @sortoption = '1' 
begin
	select 
		Grh_GrnNo as 'GRN #',
		Grh_CreDat as 'Issue Date',
		Grd_Itmno as 'Item No.',
		Grd_ItmNam as 'Item Name',
		Grd_CustCat as 'Custom Category',
		isnull(ymc_catdsc,'') as 'Custom Category Name',
		--Grl_RevDept as 'Receive Department',
		--Grl_Curr as 'Currency',
		--Grl_UntPrc as 'Unit Price',
		--Grl_ShpQty  as 'Ship Qty',
		--Grl_UntPrc *  Grl_ShpQty  as 'Sub-Total'
		Grd_RevDept as 'Receive Department',
		Grd_Curr as 'Currency',
		Grd_UntPrc as 'Unit Price',
		Grd_TtlShpQty as 'Ship Qty',
		Grd_UntPrc * Grd_TtlShpQty as 'Sub-Total'
	from 
		GRNTRFDTL
		LEFT JOIN GRNTRFHDR ON GRD_GRNNO = GRH_GRNNO 
		--LEFT JOIN GRNTRFLST ON GRD_GRNNO = GRL_GRNNO and grd_seq = grl_grnseq
		LEFT JOIN SYMCATCDE ON YMC_TYPE = '1' AND YMC_CATCDE = Grd_CustCat
	where
		--(Grd_Type in ( 'AdHoc', 'Misc' )  and Grl_ShpQty > 0)  and
		(Grd_Type in ( 'AdHoc', 'Misc' )  and Grd_TtlShpQty > 0)  and
		((Grd_ItmNo between @itmnofm  and @itmnoto  and @itmnoopt = 'Y' ) or @itmnoopt = 'N') and 
		((Grd_CustCat between @Custcatfm and @Custcatto and @Custcatopt  = 'Y' ) or @Custcatopt  = 'N')  and
		((Grh_CreDat between @issdatefm and @issdateto +  ' 23:59:59.000'  and @issdateopt  = 'Y' ) or @issdateopt  = 'N') 
	order by 
		Grd_Itmno, Grh_GrnNo
end
else
begin
	select 
		Grh_GrnNo as 'GRN #',
		Grh_CreDat as 'Issue Date',
		Grd_Itmno as 'Item No.',
		Grd_ItmNam as 'Item Name',
		Grd_CustCat as 'Custom Category',
		isnull(ymc_catdsc,'') as 'Custom Category Name',
		--Grl_RevDept as 'Receive Department',
		--Grl_Curr as 'Currency',
		--Grl_UntPrc as 'Unit Price',
		--Grl_ShpQty  as 'Ship Qty',
		--Grl_UntPrc *  Grl_ShpQty  as 'Sub-Total'
		Grd_RevDept as 'Receive Department',
		Grd_Curr as 'Currency',
		Grd_UntPrc as 'Unit Price',
		Grd_TtlShpQty as 'Ship Qty',
		Grd_UntPrc * Grd_TtlShpQty as 'Sub-Total'
	from 
		GRNTRFDTL
		LEFT JOIN GRNTRFHDR ON GRD_GRNNO = GRH_GRNNO 
		LEFT JOIN GRNTRFLST ON GRD_GRNNO = GRL_GRNNO and grd_seq = grl_grnseq
		LEFT JOIN SYMCATCDE ON YMC_TYPE = '1' AND YMC_CATCDE = Grd_CustCat
	where
		--(Grd_Type in ( 'AdHoc', 'Misc' )  and Grl_ShpQty > 0)  and
		(Grd_Type in ( 'AdHoc', 'Misc' )  and Grd_TtlShpQty > 0)  and
		((Grd_ItmNo between @itmnofm  and @itmnoto  and @itmnoopt = 'Y' ) or @itmnoopt = 'N') and 
		((Grd_CustCat between @Custcatfm and @Custcatto and @Custcatopt  = 'Y' ) or @Custcatopt  = 'N')  and
		((Grh_CreDat between @issdatefm and @issdateto +  ' 23:59:59.000'  and @issdateopt  = 'Y' ) or @issdateopt  = 'N') 
	order by 
		Grd_CustCat , Grd_Itmno, Grh_GrnNo
end


GO
GRANT EXECUTE ON [dbo].[sp_select_MPR00005] TO [ERPUSER] AS [dbo]
GO
