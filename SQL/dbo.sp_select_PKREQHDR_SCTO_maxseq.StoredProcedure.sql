/****** Object:  StoredProcedure [dbo].[sp_select_PKREQHDR_SCTO_maxseq]    Script Date: 09/29/2017 15:29:09 ******/
DROP PROCEDURE [dbo].[sp_select_PKREQHDR_SCTO_maxseq]
GO
/****** Object:  StoredProcedure [dbo].[sp_select_PKREQHDR_SCTO_maxseq]    Script Date: 09/29/2017 15:29:10 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create  procedure [dbo].[sp_select_PKREQHDR_SCTO_maxseq]
                                                                                                                                                                                                                                                                 
@code nvarchar(10),
@Req_no nvarchar(20)


---------------------------------------------- 
 
AS


begin
	select isnull(max(isnull(prd_seq,0)),0)  from PKREQDTL (nolock) 
	where prd_reqno = @Req_no
end
















GO
GRANT EXECUTE ON [dbo].[sp_select_PKREQHDR_SCTO_maxseq] TO [ERPUSER] AS [dbo]
GO
