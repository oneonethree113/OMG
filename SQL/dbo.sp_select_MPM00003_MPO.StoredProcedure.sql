/****** Object:  StoredProcedure [dbo].[sp_select_MPM00003_MPO]    Script Date: 09/29/2017 15:29:09 ******/
DROP PROCEDURE [dbo].[sp_select_MPM00003_MPO]
GO
/****** Object:  StoredProcedure [dbo].[sp_select_MPM00003_MPO]    Script Date: 09/29/2017 15:29:10 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO



--sp_select_MPM00003_MPO 'UCPP','','372409050C2','ADD'
--sp_select_MPM00003_DLVHDR 'UCPP','','372409050C2'
--sp_select_MPM00003_DLVDTL ''
--select * from MPORDDTL 
--sp_select_MPM00003_MPO 'UCPP','MD0500020','372409100B4','MODIFY'

/*
select * from MPORDHDR 
select * from MPORDDTL
select * from MPDLVDTL
select * from MPDLVHDR
*/
CREATE procedure [dbo].[sp_select_MPM00003_MPO]
@cocde	as varchar(6),
@DlvNo	as varchar(20),
@ItemNo	as varchar(20), 
@opt	as varchar(10)
as
BEGIN


	if rtrim(@opt) = 'ADD' 
	Begin
		select 
			0 as 'Seq',
			--'N' as 'Sel' , 
			Mph_MpoSts ,  
			Mph_MpoNo ,
			Mpd_MPOseq ,
			Mpd_PONo ,
			Mpd_POSeq ,
			Mpd_ItmNo ,
			Mpd_UM ,
			Mpd_Qty ,
			Mpd_ShpQty ,
			Mpd_Qty - Mpd_DQty as 'OS_Qty' ,
			--Mpd_DQty as 'Ori_DQty' ,
			Mpd_Qty as 'Ori_DQty' ,
			Mpd_Qty as 'Mpd_DQty' ,	-- Deliveried Qty			
			Mpd_Qty as 'Mdd_DQty' , 	-- Distributed Qty
			Mpd_Qty as 'Adjust Qty' ,
			Mpd_Qty as 'Prv_DQty' , 
			Mpd_ItmNam ,
			Mph_VenNo ,
			Mph_ImpFty ,
			Mph_ShpPlc, 
			upper(Mpd_UpdUsr) as 'Mpd_UpdUsr',
			convert(varchar(10),Mpd_UpdDat,101) as 'Mpd_UpdDat',
			convert(varchar(10),Mpd_CreDat, 101) as 'Mpd_CreDat' , 
			'' as 'DocNo', 
			0 as 'DocSeq' 

		from 
			MPORDHDR (nolock)
			LEFT JOIN MPORDDTL (nolock) on mph_mpono = mpd_mpono
		where
			(Mpd_Qty - Mpd_DQty) > 0 and 
			mpd_itmno is not null and mpd_itmno = @ItemNo and 
			Mph_MpoSts = 'ACT'
		
	End
	else
	Begin
		

		select 
			0 as 'Seq',
			--'N' as 'Sel' , 
			Mph_MpoSts , 
			Mph_MpoNo ,
			Mpd_MPOseq ,
			Mpd_PONo ,
			Mpd_POSeq ,
			Mpd_ItmNo ,
			Mpd_UM ,
			Mpd_Qty ,
			Mpd_ShpQty ,
			Mpd_Qty - Mpd_DQty as 'OS_Qty' ,
			Mdd_DQty as 'Ori_DQty' ,
			Mdd_DQty as 'Mpd_DQty',	-- Delivery Qty
			Mdd_DQty, 	-- Distributed Qty
			Mpd_Qty as 'Adjust Qty' ,
			Mdd_DQty as 'Prv_DQty',
			Mpd_ItmNam ,
			Mph_VenNo ,
			Mph_ImpFty ,
			Mph_ShpPlc, 
			upper(Mpd_UpdUsr) as 'Mpd_UpdUsr',
			convert(varchar(10),Mpd_UpdDat,101) as 'Mpd_UpdDat',
			convert(varchar(10),Mpd_CreDat, 101) as 'Mpd_CreDat' , 
			Mdd_DocNo, -- DocNo
			Mdd_DocSeq-- DocSeq
			
		from 
			MPORDHDR (nolock)
			LEFT JOIN MPORDDTL (nolock) on Mph_mpono = Mpd_mpono
			LEFT JOIN MPDLVDTL (nolock) on Mpd_MpoNo = Mdd_MpoNo and Mpd_MpoSeq = Mdd_MpoSeq
			LEFT JOIN MPDLVHDR (nolock) on  Mdh_DocNo = Mdd_DocNo and Mdh_DocSeq = Mdd_DocSeq
		where
			(@DlvNo = '' or (@DlvNo <> '' and Mdh_DocNo = @DlvNo )) and
			mpd_itmno is Not Null and 
			mpd_itmno = @ItemNo and 
			Mdh_DocNo is Not Null
	End

END





GO
GRANT EXECUTE ON [dbo].[sp_select_MPM00003_MPO] TO [ERPUSER] AS [dbo]
GO
