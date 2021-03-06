/****** Object:  StoredProcedure [dbo].[sp_select_MPM00003_DLVHDR]    Script Date: 09/29/2017 15:29:09 ******/
DROP PROCEDURE [dbo].[sp_select_MPM00003_DLVHDR]
GO
/****** Object:  StoredProcedure [dbo].[sp_select_MPM00003_DLVHDR]    Script Date: 09/29/2017 15:29:10 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO





--sp_select_MPM00003_DLVHDR 'UCPP','','372409050C2'

CREATE procedure [dbo].[sp_select_MPM00003_DLVHDR]
@cocde	as varchar(6),
@DOCNO as varchar(20),
@ItemNo	as varchar(20) , 
@opt	as varchar(10)
as
BEGIN
	select 
		'O' as 'STS',
		Mdh_DocNo ,
		Mdh_DocSeq ,
		Mdh_MpoNo ,
		Mdh_ItmNo ,
		Mdh_DQty as 'Ori_DQty' ,
		Mdh_DQty ,
		--0 as 'Adjust Qty' , 
		Mdh_FreeQty ,
		convert(varchar(10),Mdh_DlvDat, 101) as 'Mdh_DlvDat',
		convert(varchar(10),Mdh_CreDat, 101) as '_CreDat',
		Mdh_CreUsr
	from 
 		MPDLVHDR 
	where 
		@opt = 'MODIFY' and 
		(@DOCNO = '' or (@DOCNO <> '' and Mdh_DocNo = @DOCNO )) and
		Mdh_ItmNo = @ItemNo and
		Mdh_DocNo in (
			select distinct mdd_DocNo
			from MPDLVDTL 
			left join MPORDHDR on mdd_MpoNo = Mph_MpoNo 
			where isnull(Mph_MpoSts,'') = 'ACT'
		)
	order by 
		Mdh_CreDat

END





GO
GRANT EXECUTE ON [dbo].[sp_select_MPM00003_DLVHDR] TO [ERPUSER] AS [dbo]
GO
