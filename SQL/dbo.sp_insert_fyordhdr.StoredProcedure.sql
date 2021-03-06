/****** Object:  StoredProcedure [dbo].[sp_insert_fyordhdr]    Script Date: 09/29/2017 15:29:09 ******/
DROP PROCEDURE [dbo].[sp_insert_fyordhdr]
GO
/****** Object:  StoredProcedure [dbo].[sp_insert_fyordhdr]    Script Date: 09/29/2017 15:29:09 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO



-- Checked by Allan Yuen at 28/07/2003

CREATE PROCEDURE [dbo].[sp_insert_fyordhdr]
@foh_fyohdr		nvarchar(10),
@foh_ftycde		nvarchar(4)
 AS

--BEGIN TRAN
if not exists(select * from fyordhdr where foh_fyohdr = @foh_fyohdr)
begin

	declare @Prefix as  nvarchar(2)
	declare @itmCde as nvarchar(20)
	declare @OrdQty as int

	set @Prefix = left(@foh_fyohdr, 2)
	if  isnumeric(@Prefix) = 1
	begin
		set @itmcde = (select intcoc01 from intcoc where intcoc11 = @foh_fyohdr)
		set @OrdQty = (select intcoc07 from intcoc where intcoc11 = @foh_fyohdr)
		insert into fyordhdr (
			foh_fyohdr,
			foh_ftyitm,
			foh_ordqty,
			foh_ftysts,
			foh_ftycde,
			foh_usrid,
			foh_credat,
			foh_upddat)
		values (
			@foh_fyohdr,
			@itmcde,
			@OrdQty,
			'M1',
			@foh_ftycde,
			@foh_ftycde,
			getdate(),
			getdate())
	end else	
	begin
		declare @Numprt as nvarchar(6)
		declare @pono as int
		set @Numprt = cast(right(@foh_fyohdr,len(@foh_fyohdr)-2) as int)

		set @itmCde = (select ircode from pnhd_up where dtcode = @Prefix and no = @NumPrt)
		set @pono = (select pono from pnhd_up where dtcode = @Prefix and no = @NumPrt)
		set @OrdQty = (	select sum(poqty) from copd_up 
				where ircode = @itmCde and no = @pono)
		insert into fyordhdr (
			foh_fyohdr,
			foh_ftyitm,
			foh_ordqty,
			foh_ftysts,
			foh_ftycde,
			foh_usrid,
			foh_credat,
			foh_upddat)
		values (
			@foh_fyohdr,
			@itmcde,
			@OrdQty,
			'M1',
			@foh_ftycde,
			@foh_ftycde,
			getdate(),
			getdate())
	end

	--insert into fyordhdr (
		--foh_fyohdr,
		--foh_ftyitm,
		--foh_ordqty,
		--foh_ftysts,
		--foh_ftycde,
		--foh_usrid,
		--foh_credat,
		--foh_upddat)
		--values (
		--@foh_fyohdr,
		--@itmcde,
		--@OrdQty,
		--'M1',
		--@foh_ftycde,
		--@foh_ftycde,
		--getdate(),
		--getdate())
	--insert into fyprtfyo (
		--fpf_fyohdr,
		--fpf_ftycde)
		--values (
		--@foh_fyohdr,
		--@foh_ftycde)

end

--if @@error <> 0
--ROLLBACK TRAN











GO
GRANT EXECUTE ON [dbo].[sp_insert_fyordhdr] TO [ERPUSER] AS [dbo]
GO
