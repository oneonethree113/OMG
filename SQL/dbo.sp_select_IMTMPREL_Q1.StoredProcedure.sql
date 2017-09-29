/****** Object:  StoredProcedure [dbo].[sp_select_IMTMPREL_Q1]    Script Date: 09/29/2017 15:29:09 ******/
DROP PROCEDURE [dbo].[sp_select_IMTMPREL_Q1]
GO
/****** Object:  StoredProcedure [dbo].[sp_select_IMTMPREL_Q1]    Script Date: 09/29/2017 15:29:10 ******/
SET ANSI_NULLS OFF
GO
SET QUOTED_IDENTIFIER ON
GO





CREATE    PROCEDURE [dbo].[sp_select_IMTMPREL_Q1] 
                                                                                                                                                                                                                                                                 
@itr_itmno		nvarchar(20)
 
 
AS
begin



select * from IMBASINF (nolock)
left join IMTMPREL (nolock) on itr_itmno = ibi_itmno
where   itr_itmno is not null
and ibi_itmno= @itr_itmno	



end






GO
GRANT EXECUTE ON [dbo].[sp_select_IMTMPREL_Q1] TO [ERPUSER] AS [dbo]
GO
