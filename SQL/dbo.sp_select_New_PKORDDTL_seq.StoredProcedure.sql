/****** Object:  StoredProcedure [dbo].[sp_select_New_PKORDDTL_seq]    Script Date: 09/29/2017 15:29:09 ******/
DROP PROCEDURE [dbo].[sp_select_New_PKORDDTL_seq]
GO
/****** Object:  StoredProcedure [dbo].[sp_select_New_PKORDDTL_seq]    Script Date: 09/29/2017 15:29:10 ******/
SET ANSI_NULLS OFF
GO
SET QUOTED_IDENTIFIER OFF
GO



Create  procedure [dbo].[sp_select_New_PKORDDTL_seq]
@cocde nvarchar(10),
@ordno nvarchar(20)

AS
 

begin

declare @seq as int

set @seq = (select  count(*) + 1  from PKORDDTL(NOLOCK)
where pod_cocde = @cocde and pod_ordno = @ordno)

select @seq

end


GO
GRANT EXECUTE ON [dbo].[sp_select_New_PKORDDTL_seq] TO [ERPUSER] AS [dbo]
GO
