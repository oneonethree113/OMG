/****** Object:  StoredProcedure [dbo].[SP_SELECT_SYM00024]    Script Date: 09/29/2017 15:29:08 ******/
DROP PROCEDURE [dbo].[SP_SELECT_SYM00024]
GO
/****** Object:  StoredProcedure [dbo].[SP_SELECT_SYM00024]    Script Date: 09/29/2017 15:29:10 ******/
SET ANSI_NULLS OFF
GO
SET QUOTED_IDENTIFIER OFF
GO





CREATE  PROCEDURE [dbo].[SP_SELECT_SYM00024]
@ibi_cocde NVARCHAR(6),
@itmno1	nvarchar(20),
@itmno2	nvarchar(20)
AS

begin

declare @ibi_rmk as nvarchar(4000)
set @ibi_rmk = ''
select @ibi_rmk = isnull(ibi_rmk,'') from imbasinf(nolock) where ibi_itmno = @itmno2

select icf_itmno as 'Upd',ibi_itmsts, icf_itmno,icf_colcde, ibi_rmk as 'CurRmk', @ibi_rmk as 'NewRmk', cast(icf_timstp as int) as 'icf_timstp' from IMCOLINF 
left join imbasinf on icf_itmno = ibi_itmno
Where left(icf_itmno,11) = @itmno1  and icf_itmno <> @itmno2
order by icf_itmno asc
END



GO
GRANT EXECUTE ON [dbo].[SP_SELECT_SYM00024] TO [ERPUSER] AS [dbo]
GO
