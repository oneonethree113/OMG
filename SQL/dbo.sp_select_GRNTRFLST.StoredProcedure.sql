/****** Object:  StoredProcedure [dbo].[sp_select_GRNTRFLST]    Script Date: 09/29/2017 15:29:09 ******/
DROP PROCEDURE [dbo].[sp_select_GRNTRFLST]
GO
/****** Object:  StoredProcedure [dbo].[sp_select_GRNTRFLST]    Script Date: 09/29/2017 15:29:10 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO





/*
=========================================================
Program ID	: sp_select_GRNTRFLST
Description   	: GRN Transfer Maintenance
Programmer  	: Lester Wu
Create Date   	:
Last Modified  	: 
Table Read(s) 	:
Table Write(s) 	:
=========================================================
 Modification History                                    
=========================================================
Date			Author		Description
=========================================================     
2005-10-14	Lester Wu		Show Detail Remak
*/





CREATE procedure [dbo].[sp_select_GRNTRFLST]
@cocde		varchar(6),
@Grl_GrnNo	varchar(20)
as
begin
--sp_help GRNTRFLST
	
	-- Lester Wu 2005-10-18, Calculate Total OS Qty
	
	


	select 
		Grl_CreUsr as 'CreUsr',
		Grl_PONo,
		Grl_POSeq,
		convert(numeric(9,2),isnull(Mpd_Qty,0)) as 'OrdQty', 
		-----------------------------------------------------
		-- Lester Wu 2005-10-17
		convert(numeric(9,2),isnull(Mpd_DQty,0)) as 'DlvQty', 		
		convert(numeric(9,2),isnull(Mpd_DQty - Mpd_ShpQty,0)) as 'OSQty',
--		isnull(Mpd_Qty - Mpd_ShpQty,0) as 'OSQty',
		-----------------------------------------------------
		-- Lester Wu, 2005-10-17
		Cul_ShpQty = convert(numeric(9,2),Mpd_ShpQty) , 			-- Data is not accurate, coz not sum up with same PO
		Cul_OSQty = convert(numeric(9,2),isnull(Mpd_DQty - Mpd_ShpQty,0)) , 	-- it will be recalculate at client side
		Prv_ShpQty = convert(numeric(9,2),Grl_ShpQty) , 
		-------------------------------
		Grl_ShpQty as 'ShpQty',
		Grl_ShpQty as 'OriShpQty',
		--GRN DTL
		Grl_Curr,
		Grl_UntPrc,
		Grl_OrgPrc,
		isnull(Mpd_ItmNam,'') as 'Mpd_ItmNam',
		isnull(Mpd_ItmDsc,'') as 'Mpd_ItmDsc',
		--
		Grl_MpoNo as 'MPONo',
		Grl_MpoSeq as 'MPOSeq',
		Grl_RevDept as 'Dept',
		--
		isnull(Mpd_PODat,'') as 'Mpd_PODat',
		isnull(Mpd_ShpDat,'') as 'Mpd_ShpDat',
		isnull(Mpd_OrgShpDat,'') as 'Mpd_OrgShpDat',
		isnull(Mpd_ReqNo,'') as 'Mpd_ReqNo',
		isnull(Mpd_PrdNo,'') as 'Mpd_PrdNo',
		isnull(Mpd_PckMth,'') as 'Mpd_PckMth',
		isnull(Mpd_HdrRmk,'') as 'Mpd_HdrRmk',
		isnull(Mpd_Rmk,'') as 'Mpd_Rmk',
		--
		Grl_GrnNo,
		Grl_GrnSeq,
		-- Lester Wu 2005-10-14
		Grl_DtlRmk, 
		------------------------------
		Grl_CreUsr,
		Grl_CreDat,
		Grl_UpdUsr,
		Grl_UpdDat,
		cast(Grl_TimStp as int) as 'TimStp',
		'N' as 'Del', 
		-- Lester Wu 2006-04-24
		isnull(Mpd_ItmNo,'') as 'Mpd_ItmNo' , 
		isnull(Grl_DtlRmk,'') as '_DtlRmk'

	 from 
		GRNTRFLST
		Left Join MPORDDTL on Mpd_MPONo = Grl_MpoNo and Mpd_MPOSeq = Grl_MpoSeq
	where
		Grl_GrnNo = @Grl_GrnNo
	order by 
		Grl_GrnSeq,
		Grl_PONo,
		Grl_POSeq

end







GO
GRANT EXECUTE ON [dbo].[sp_select_GRNTRFLST] TO [ERPUSER] AS [dbo]
GO
