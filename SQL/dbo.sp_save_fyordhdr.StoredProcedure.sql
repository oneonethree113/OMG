/****** Object:  StoredProcedure [dbo].[sp_save_fyordhdr]    Script Date: 09/29/2017 15:29:09 ******/
DROP PROCEDURE [dbo].[sp_save_fyordhdr]
GO
/****** Object:  StoredProcedure [dbo].[sp_save_fyordhdr]    Script Date: 09/29/2017 15:29:10 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO



-- Checked by Allan Yuen at 28/07/2003


CREATE PROCEDURE [dbo].[sp_save_fyordhdr]
@foh_fyohdr		nvarchar(10),
@foh_ftysts		nvarchar(2),
@foh_expcmp		datetime,
@foh_cmpdat		datetime,
@foh_cmpper		int,
@foh_warqty		int,
@foh_shpqty		int,
@foh_rptqty		int,
@foh_qtydtl		nvarchar(500),
@foh_ftycde		nvarchar(4)
 AS

--BEGIN TRAN
if exists(select * from fyordhdr where foh_fyohdr = @foh_fyohdr)
begin
	-- *** create transaction
	if len(@foh_ftysts) > 0  or @foh_expcmp <> '' or @foh_cmpdat <> '' or @foh_cmpper >  -1 
		or @foh_warqty > -1 or @foh_shpqty > -1 or @foh_rptqty > -1
	begin
		declare @seq as int
		set @seq = (select max(foi_ordseq) from fyordtxn where foi_fyohdr = @foh_fyohdr)
		if @seq is null
			set @seq = 1
		else
			set @seq = @seq + 1

		insert into fyordtxn (
			foi_fyohdr,
			foi_ordseq,
			foi_actdat,
			foi_ftysts,
			foi_expcmp,
			foi_cmpdat,
			foi_cmpper,
			foi_warqty,
			foi_shpqty,
			foi_rptqty,
			foi_qtydtl,
			foi_usrid,
			foi_credat)
			select 	foh_fyohdr, 
				@seq,
				foh_upddat,
				foh_ftysts,
				foh_expcmp,
				foh_cmpdat,
				foh_cmpper,
				foh_warqty,
				foh_shpqty,
				foh_rptqty,
				foh_qtydtl,
				foh_ftycde,
				getdate()
			from fyordhdr
			where foh_fyohdr = @foh_fyohdr
			
	end

	if len(@foh_ftysts) > 0
		update fyordhdr set foh_ftysts = @foh_ftysts,
				foh_usrid = @foh_ftycde,
				foh_upddat = getdate()
		 where foh_fyohdr = @foh_fyohdr
	if @foh_expcmp <> ''
		update fyordhdr set foh_expcmp = @foh_expcmp,
				foh_usrid = @foh_ftycde,
				foh_upddat = getdate()
		where foh_fyohdr = @foh_fyohdr
	if @foh_cmpdat <> ''
		update fyordhdr set foh_cmpdat = @foh_cmpdat,
				foh_usrid = @foh_ftycde,
				foh_upddat = getdate()
		where foh_fyohdr = @foh_fyohdr
	if @foh_cmpper >  -1
		update fyordhdr set foh_cmpper = @foh_cmpper,
				foh_usrid = @foh_ftycde,
				foh_upddat = getdate()
		where foh_fyohdr = @foh_fyohdr

	if @foh_warqty >  0
		update fyordhdr set foh_warqty = @foh_warqty + foh_warqty,
				foh_usrid = @foh_ftycde,
				foh_upddat = getdate()
		where foh_fyohdr = @foh_fyohdr
	if @foh_shpqty >  0
		update fyordhdr set foh_shpqty = @foh_shpqty + foh_shpqty, 
				foh_warqty = foh_warqty - @foh_shpqty,
				foh_usrid = @foh_ftycde,
				foh_upddat = getdate()
		where foh_fyohdr = @foh_fyohdr
	if @foh_rptqty >  0
		update fyordhdr set foh_rptqty = @foh_rptqty + foh_rptqty,
				foh_usrid = @foh_ftycde,
				foh_upddat = getdate()
		where foh_fyohdr = @foh_fyohdr
	if @foh_qtydtl <> ''
		update fyordhdr set foh_qtydtl = @foh_qtydtl,
				foh_usrid = @foh_ftycde,
				foh_upddat = getdate()
		where foh_fyohdr = @foh_fyohdr


end
else
begin

	declare @Prefix as  nvarchar(2)
	declare @itmCde as nvarchar(20)
	declare @OrdQty as int

	set @Prefix = left(@foh_fyohdr, 2)
	if  isnumeric(@Prefix) = 1
	begin
		set @itmcde = (select intcoc01 from intcoc where intcoc11 = @foh_fyohdr)
		set @OrdQty = (select intcoc07 from intcoc where intcoc11 = @foh_fyohdr)
	end else	
	begin
		declare @Numprt as nvarchar(6)
		declare @pono as int
		set @Numprt = cast(right(@foh_fyohdr,len(@foh_fyohdr)-2) as int)

		set @itmCde = (select ircode from pnhd_up where dtcode = @Prefix and no = @NumPrt)
		set @pono = (select pono from pnhd_up where dtcode = @Prefix and no = @NumPrt)
		set @OrdQty = (	select sum(poqty) from copd_up 
				where ircode = @itmCde and no = @pono)
	end

	if @foh_cmpper = -1 set @foh_cmpper = 0
	if @foh_warqty = -1 set @foh_warqty = 0
	if @foh_shpqty = -1 set @foh_shpqty = 0
	if @foh_rptqty = -1 set @foh_rptqty = 0

	insert into fyordhdr (
		foh_fyohdr,
		foh_ftyitm,
		foh_ftysts,
		foh_expcmp,
		foh_cmpdat,
		foh_cmpper,
		foh_ordqty,
		foh_warqty,
		foh_shpqty,
		foh_rptqty,
		foh_qtydtl,
		foh_ftycde,
		foh_usrid,
		foh_credat,
		foh_upddat)
		values (
		@foh_fyohdr,
		@itmcde,
		@foh_ftysts,
		@foh_expcmp,
		@foh_cmpdat,
		@foh_cmpper,
		@OrdQty,
		@foh_warqty,
		@foh_shpqty,
		@foh_rptqty,
		@foh_qtydtl,
		@foh_ftycde,
		@foh_ftycde,
		getdate(),
		getdate())
end

--if @@error <> 0
--ROLLBACK TRAN





GO
GRANT EXECUTE ON [dbo].[sp_save_fyordhdr] TO [ERPUSER] AS [dbo]
GO
