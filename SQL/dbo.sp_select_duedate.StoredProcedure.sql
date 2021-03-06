/****** Object:  StoredProcedure [dbo].[sp_select_duedate]    Script Date: 09/29/2017 15:29:09 ******/
DROP PROCEDURE [dbo].[sp_select_duedate]
GO
/****** Object:  StoredProcedure [dbo].[sp_select_duedate]    Script Date: 09/29/2017 15:29:10 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO




CREATE PROCEDURE [dbo].[sp_select_duedate] 
@JobNo as varchar(10)
AS

if isnumeric( left(@JobNo, 2))=1
	select intcoh43 as duedat
	from intcoh left join intcoc 
	on intcoh01=intcoc00
	where intcoc11 = @jobno

else
begin
	declare @CharPrt as nvarchar(10)
	declare @Numprt as int
	set @CharPrt = left(@JobNo,2)
	set @Numprt = cast(right(@jobno,len(@JobNo)-2) as int)

	select DELIVERY as duedat
	from coph_up left join pnhd_up 
	on coph_up.dtcode = pnhd_up.podtcode and coph_up.no = pnhd_up.pono
	where pnhd_up.dtcode = @CharPrt and pnhd_up.no = @NumPrt
end






GO
GRANT EXECUTE ON [dbo].[sp_select_duedate] TO [ERPUSER] AS [dbo]
GO
