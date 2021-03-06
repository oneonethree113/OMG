/****** Object:  StoredProcedure [dbo].[sp_find_jobnum]    Script Date: 09/29/2017 15:29:09 ******/
DROP PROCEDURE [dbo].[sp_find_jobnum]
GO
/****** Object:  StoredProcedure [dbo].[sp_find_jobnum]    Script Date: 09/29/2017 15:29:09 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO




CREATE PROCEDURE [dbo].[sp_find_jobnum] 
@JobNum as nvarchar(8)
AS

declare @Prefix as  nvarchar(2)
set @Prefix = left(@JobNum, 2)
if  isnumeric(@Prefix) = 1
begin
	select	intcoc01 as ItmCde, 
		intcoc07 as Qty 
	from	intcoc
	where	intcoc11 = left(@JobNum,6)
end
else begin
	declare @Numprt as nvarchar(6)
	declare @pono as int
	declare @ItmCde as nvarchar(20)
	set @Numprt = cast(right(@JobNum,len(@JobNum)-2) as int)
	set @itmCde = (select ircode from pnhd_up where dtcode = @Prefix and no = @NumPrt)

	set @pono = (select pono from pnhd_up where dtcode = @Prefix and no = @NumPrt)
	
	select	@ItmCde		as itmCde, 
		sum(poqty)	as Qty
	 from copd_up 
	where ircode = @itmCde and no = @pono

--	select	ircode		as ItmCde,
--		 sum(poqty)	as Qty
--	from	copd_up
--	where	ircode + str(no) = (select ircode + str(pono) from pnhd_up where no = @NumPrt and dtcode = @Prefix )
--	group by	ircode
end







GO
GRANT EXECUTE ON [dbo].[sp_find_jobnum] TO [ERPUSER] AS [dbo]
GO
