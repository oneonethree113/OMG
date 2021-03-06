/****** Object:  StoredProcedure [dbo].[sp_list_MPR00003_rpt_recvdept]    Script Date: 09/29/2017 15:29:09 ******/
DROP PROCEDURE [dbo].[sp_list_MPR00003_rpt_recvdept]
GO
/****** Object:  StoredProcedure [dbo].[sp_list_MPR00003_rpt_recvdept]    Script Date: 09/29/2017 15:29:09 ******/
SET ANSI_NULLS OFF
GO
SET QUOTED_IDENTIFIER OFF
GO












/*
=========================================================
Program ID	: sp_list_MPR00003_rpt_recvdept
Description   	: 6/F Costing Depart -- 出倉報表
Programmer  	: Mark Lau
ALTER  Date   	:2009-06-16
Last Modified  	: 
Table Read(s) 	:
Table Write(s) 	:
=========================================================
 Modification History                                    
=========================================================
Date		Author		Description
=========================================================     

*/

--sp_list_MPR00003_rpt 'UCPP','GT0800026','GT0800026','MIS'

CREATE Procedure [dbo].[sp_list_MPR00003_rpt_recvdept]
@cocde	varchar(6),
@GRNFm	varchar(20),
@GRNTo	varchar(20),
@DP		int,
@HIDDEN	int,
@UserID	varchar(30)
as
BEGIN

	


	select 
		distinct
		Grd_GrnNo,	
		'' as 'RecvDept'
	from 
		GRNTRFHDR 
		Left Join GRNTRFDTL on Grd_GrnNo = Grh_GrnNo
		Left Join GRNVENINF on Grh_ImpFty = Gvi_VenSna and Gvi_Type = 'CUST'
	where 
		-- rem by Mark Lau 20090616
		--Grd_Type in ('AdHoc','Misc')
		( Grd_Type = 'Misc' or ( Grd_Type = 'AdHoc' and isnull(grd_mpono,'') = '' ) )
		 and Grh_GrnNo between @GRNFm and @GRNTo
		and Grh_Sts = 'ACT'
	union 
	
	select 
		distinct
		Grd_GrnNo,
		dbo.mporecvdept(Grl_pono) as 'RecvDept'
		
	from 
		GRNTRFHDR 
		Left Join GRNTRFDTL on Grd_GrnNo = Grh_GrnNo
		Left Join GRNTRFLST on Grd_GrnNo = Grl_GrnNo and Grd_Seq = Grl_GrnSeq and Grl_ShpQty > 0
		Left Join GRNVENINF on Grh_ImpFty = Gvi_VenSna and Gvi_Type = 'CUST'

	where 
		Grd_Type = 'MPO' 
		and Grl_GrnNo is not null
		and Grh_GrnNo between @GRNFm and @GRNTo
		and Grh_Sts = 'ACT'


	union 

	select 
		distinct
		Grd_GrnNo,
		dbo.mporecvdept(Grl_pono) as 'RevDept'
		
	from 
		GRNTRFHDR 
		Left Join GRNTRFDTL on Grd_GrnNo = Grh_GrnNo
		Left Join GRNTRFLST on Grd_GrnNo = Grl_GrnNo and Grd_Seq = Grl_GrnSeq and Grl_ShpQty > 0
		Left Join GRNVENINF on Grh_ImpFty = Gvi_VenSna and Gvi_Type = 'CUST'

	where 
		( Grd_Type = 'AdHoc'   and isnull(grd_mpono,'') <> '' )
		and Grl_GrnNo is not null
		and Grh_GrnNo between @GRNFm and @GRNTo
		and Grh_Sts = 'ACT'
	order by 
		1,2

END





GO
GRANT EXECUTE ON [dbo].[sp_list_MPR00003_rpt_recvdept] TO [ERPUSER] AS [dbo]
GO
