/****** Object:  StoredProcedure [dbo].[sp_update_IMITMDAT_XLS]    Script Date: 09/29/2017 15:29:08 ******/
DROP PROCEDURE [dbo].[sp_update_IMITMDAT_XLS]
GO
/****** Object:  StoredProcedure [dbo].[sp_update_IMITMDAT_XLS]    Script Date: 09/29/2017 15:29:10 ******/
SET ANSI_NULLS OFF
GO
SET QUOTED_IDENTIFIER OFF
GO











/*
=================================================================
Program ID	: sp_update_IMITMDAT_XLS
Description	: Update IMITMDAT data after Excel Upload
Programmer	: David Yue
=================================================================
	MODIFICATION HISTORY
=================================================================
   Date		 Editor			Description
=================================================================
2014-03-18 	David Yue		SP Created
=================================================================
*/

CREATE PROCEDURE [dbo].[sp_update_IMITMDAT_XLS] 

@cocde		nvarchar(6),
@usrid		nvarchar(30)

AS

declare -- IMITMDAT --
@iid_itmseq	int,
@iid_recseq	int,
@iid_xlsfil	nvarchar(30),
@iid_chkdat	datetime,
@iid_itmtyp	nvarchar(3),
@iid_venitm	nvarchar(20),
@iid_venno	nvarchar(6),
@iid_prdven	nvarchar(6),
@iid_stage	nvarchar(1),
@iid_sysmsg	nvarchar(300),
@iid_bomflg	nvarchar(1),
@iid_refresh	nvarchar(1),
@iid_sapum	nvarchar(6),
@iid_untcde	nvarchar(6),
@iid_curr_bef	nvarchar(6),
@iid_basprc	numeric(13, 4),
@iid_bomprc	numeric(13, 4)

declare -- IMBOMASS --
@iba_itmno	nvarchar(20),
@iba_assitm	nvarchar(20),
@iba_colcde	nvarchar(50),
@iba_pckunt	nvarchar(20),
@iba_inrqty	int,
@iba_mtrqty	int

declare	-- IMPRCINF --
@imu_bcurcde	nvarchar(6),
@imu_bomprc	numeric(13, 4),
@imu_basprc	numeric(13, 4)

declare -- Misc --
@loop		nvarchar(1)

DECLARE cur_IMITMDAT CURSOR
FOR	select	iid_itmseq,	iid_recseq,	iid_xlsfil,
		iid_chkdat,	iid_venitm,	iid_stage,
		iid_sysmsg,	iid_itmtyp,	iid_bomflg,
		iid_refresh,	iid_sapum,	iid_untcde,
		iid_curr_bef,	iid_bomprc,	iid_basprc
	from	IMITMDAT (nolock)
	where	iid_creusr = left('E-'+ @usrid, 30) and
		iid_credat between dateadd(hh, -1, getdate()) and getdate() and
		iid_stage not in ('O')
OPEN cur_IMITMDAT
FETCH NEXT from cur_IMITMDAT INTO 
@iid_itmseq,	@iid_recseq,	@iid_xlsfil,
@iid_chkdat,	@iid_venitm,	@iid_stage,
@iid_sysmsg,	@iid_itmtyp,	@iid_bomflg,
@iid_refresh,	@iid_sapum,	@iid_untcde,
@iid_curr_bef,	@iid_bomprc,	@iid_basprc

WHILE @@fetch_status = 0
BEGIN
	-- Determine Item Type --
	if @iid_bomflg = 'Y'
		set @iid_itmtyp = 'BOM'
	else if (select count(*) from IMASSDAT (nolock) where iad_itmseq = @iid_itmseq and iad_venitm = @iid_venitm) > 0
		set @iid_itmtyp = 'ASS'
	else
		set @iid_itmtyp = 'REG'

	-- Check Item Item for Color in IMCOLDAT --
	if (select count(*) from IMCOLDAT (nolock) where icd_itmseq = @iid_itmseq and icd_venitm = @iid_venitm) = 0
	begin
		set @iid_stage = 'I'
		set @iid_sysmsg = left(@iid_sysmsg + case @iid_sysmsg when '' then '' else '. ' end + @iid_venitm + ' - Color not found in Excel', 300)
		set @iid_refresh = 'N'
	end

	-- Check Item in IM for same Item Type --
	if (select count(*) from IMBASINF (nolock) where ibi_itmno = @iid_venitm and ibi_typ <> @iid_itmtyp) > 0
	begin
		set @iid_stage = 'I'
		set @iid_sysmsg = left(@iid_sysmsg + case @iid_sysmsg when '' then '' else '. ' end + @iid_itmtyp + ' - Item Type not match with IM', 300)
		set @iid_refresh = 'N'
	end
	else
	begin
		-- Check Assorted Item Matching with IM --
		if @iid_itmtyp = 'ASS'
		begin
			set @loop = 'Y'

			DECLARE cur_IMBOMASS CURSOR
			FOR	select	iba_itmno,	iba_assitm,	iba_colcde,
					iba_pckunt,	iba_inrqty,	iba_mtrqty
				from	IMBOMASS (nolock)
				where	iba_itmno = @iid_venitm and
					iba_typ = 'ASS'
			
			OPEN cur_IMBOMASS
			FETCH NEXT from cur_IMBOMASS INTO
			@iba_itmno,	@iba_assitm,	@iba_colcde,
			@iba_pckunt,	@iba_inrqty,	@iba_mtrqty
			
			WHILE (@@fetch_status = 0 and @loop = 'Y')
			BEGIN
				if (select count(*) from IMASSDAT (nolock) where iad_venitm = @iba_itmno and iad_acsno = @iba_assitm and
					iad_colcde = @iba_colcde and iad_untcde = @iba_pckunt and iad_inrqty = @iba_inrqty and
					iad_mtrqty = @iba_mtrqty and iad_itmseq = @iid_itmseq and iad_xlsfil = @iid_xlsfil and
					iad_chkdat = @iid_chkdat) = 0
				begin
					set @iid_stage = 'I'
					set @iid_sysmsg = left(@iid_sysmsg + case @iid_sysmsg when '' then '' else '. ' end + 'Assorted Item not matched with Item Master', 300)
					set @iid_refresh = 'N'
					-- Break Loop --
					set @loop = 'N'
				end
				
				FETCH NEXT from cur_IMBOMASS INTO
				@iba_itmno,	@iba_assitm,	@iba_colcde,
				@iba_pckunt,	@iba_inrqty,	@iba_mtrqty
			END
			CLOSE cur_IMBOMASS
			DEALLOCATE cur_IMBOMASS

			if @loop = 'N'
			begin
				-- Update IMASSDAT on matching error --
				update	IMASSDAT
				set	iad_stage = 'I',
					iad_sysmsg = left(iad_sysmsg + case iad_sysmsg when '' then '' else '. ' end + 'Assorted item not matched with Item Master', 300),
					iad_updusr = left('E-'+ @usrid, 30),
					iad_upddat = getdate()
				where	iad_itmseq = @iid_itmseq and
					iad_xlsfil = @iid_xlsfil and
					iad_chkdat = @iid_chkdat and
					iad_venitm = @iid_venitm
			end

			-- Check SET UM --
			if charindex('ST',@iid_untcde) > 0
			begin
				set @iid_untcde = 'ST'
			end
		end
	end

	-- Check SAP UM --
	if @iid_sapum = 'S00'
	begin
		if @iid_itmtyp <> 'ASS'
		begin
			set @iid_stage = 'I'
			set @iid_sysmsg = left(@iid_sysmsg + case @iid_sysmsg when '' then '' else '. ' end + @iid_sapum + ' - SAP UM must be used with Assortment', 300)
			set @iid_refresh = 'N'
		end
	end
	else
	begin
		if @iid_itmtyp = 'ASS'
		begin
			set @iid_stage = 'I'
			set @iid_sysmsg = left(@iid_sysmsg + case @iid_sysmsg when '' then '' else '. ' end + @iid_sapum + ' - SAP UM cannot be used with Assortment', 300)
			set @iid_refresh = 'N'
		end
	end

	-- Calculate Basic Price --
	exec sp_select_IMPRCINF_BasPrc @iid_itmseq, @iid_recseq, @iid_venitm, @iid_itmtyp, @iid_xlsfil, @iid_chkdat, null, null, @iid_curr_bef output, null, @iid_bomprc output, @iid_basprc output

	-- Update IMITMDAT --
	update	IMITMDAT
	set	iid_itmtyp = @iid_itmtyp,
		iid_stage = @iid_stage,
		iid_sysmsg = @iid_sysmsg,
		iid_refresh = @iid_refresh,
		iid_curr_bef = @iid_curr_bef,
		iid_bomprc = @iid_bomprc,
		iid_basprc = @iid_basprc,
		iid_updusr = left('E-'+ @usrid, 30),
		iid_upddat = getdate()
	where	iid_itmseq = @iid_itmseq and
		iid_recseq = @iid_recseq and
		iid_xlsfil = @iid_xlsfil and
		iid_chkdat = @iid_chkdat and
		iid_venitm = @iid_venitm

	FETCH NEXT from cur_IMITMDAT INTO 
	@iid_itmseq,	@iid_recseq,	@iid_xlsfil,
	@iid_chkdat,	@iid_venitm,	@iid_stage,
	@iid_sysmsg,	@iid_itmtyp,	@iid_bomflg,
	@iid_refresh,	@iid_sapum,	@iid_untcde,
	@iid_curr_bef,	@iid_bomprc,	@iid_basprc
END
CLOSE cur_IMITMDAT
DEALLOCATE cur_IMITMDAT

/*
-- Update all Assortment Set to UM ST --
update	IMITMDAT
set	iid_untcde = 'ST'
where	iid_itmseq = @iid_itmseq and
	iid_untcde like 'ST%' and
	iid_itmtyp = 'ASS'

update	IMITMDATCST
set	iic_untcde = 'ST'
from	IMITMDAT
	join IMITMDATCST on
		iic_itmseq = iid_itmseq and
		iic_recseq = iid_recseq and
		iic_venitm = iid_venitm and
		iic_xlsfil = iid_xlsfil and
		iic_chkdat = iid_chkdat
where	iic_itmseq = @iid_itmseq and
	iid_itmtyp = 'ASS' and
	iic_untcde like 'ST%'
*/

-- Invalid all IMITMDATCST if IMITMDAT is invalid --
update	IMITMDATCST
set	iic_stage = 'I',
	iic_updusr = left('E-'+ @usrid, 30),
	iic_upddat = getdate()
from	IMITMDAT
	join IMITMDATCST on
		iic_itmseq = iid_itmseq and
		iic_recseq = iid_recseq and
		iic_venitm = iid_venitm and
		iic_xlsfil = iid_xlsfil and
		iic_chkdat = iid_chkdat
where	iid_stage = 'I' and
	iic_stage not in ('I','O') and
	iic_itmseq = @iid_itmseq
	
-- Invalid all IMCOLDAT if IMITMDAT is invalid --
update	IMCOLDAT
set	icd_stage = 'I',
	icd_updusr = left('E-'+ @usrid, 30),
	icd_upddat = getdate()
from	IMCOLDAT
	join IMITMDAT a on
		iid_itmseq = icd_itmseq and
		iid_venitm = icd_venitm and
		iid_xlsfil = icd_xlsfil and
		iid_chkdat = icd_chkdat and
		iid_stage = 'I'
where	icd_stage not in ('I','O') and
	iid_itmseq = @iid_itmseq and
	(select count(*) from IMITMDAT b (nolock) where a.iid_itmseq = b.iid_itmseq and a.iid_recseq <> b.iid_recseq and a.iid_venitm = b.iid_venitm and b.iid_stage = 'W') = 0

-- Invalid all IMCOMDAT if IMITMDAT is invalid --
update	IMCOMDAT
set	imd_stage = 'I',
	imd_updusr = left('E-'+ @usrid, 30),
	imd_upddat = getdate()
from	IMCOMDAT
	join IMITMDAT a on
		iid_itmseq = imd_itmseq and
		iid_venitm = imd_venitm and
		iid_xlsfil = imd_xlsfil and
		iid_chkdat = imd_chkdat and
		iid_stage = 'I'
where	imd_stage not in ('I','O') and
	iid_itmseq = @iid_itmseq and
	(select count(*) from IMITMDAT b (nolock) where a.iid_itmseq = b.iid_itmseq and a.iid_recseq <> b.iid_recseq and a.iid_venitm = b.iid_venitm and b.iid_stage = 'W') = 0

-- Invalid all IMBOMDAT if IMITMDAT is invalid --
update	IMBOMDAT
set	ibd_stage = 'I',
	ibd_updusr = left('E-'+ @usrid, 30),
	ibd_upddat = getdate()
from	IMBOMDAT
	join IMITMDAT a on
		iid_itmseq = ibd_itmseq and
		iid_venitm = ibd_venitm and
		iid_xlsfil = ibd_xlsfil and
		iid_chkdat = ibd_chkdat and
		iid_stage = 'I'
where	ibd_stage not in ('I','O') and
	iid_itmseq = @iid_itmseq and
	(select count(*) from IMITMDAT b (nolock) where a.iid_itmseq = b.iid_itmseq and a.iid_recseq <> b.iid_recseq and a.iid_venitm = b.iid_venitm and b.iid_stage = 'W') = 0

-- Invalid all IMASSDAT if IMITMDAT is invalid --
update	IMASSDAT
set	iad_stage = 'I',
	iad_updusr = left('E-'+ @usrid, 30),
	iad_upddat = getdate()
from	IMASSDAT
	join IMITMDAT a on
		iid_itmseq = iad_itmseq and
		iid_venitm = iad_venitm and
		iid_xlsfil = iad_xlsfil and
		iid_chkdat = iad_chkdat and
		iid_stage = 'I'
where	iad_stage not in ('I','O') and
	iid_itmseq = @iid_itmseq and
	(select count(*) from IMITMDAT b (nolock) where a.iid_itmseq = b.iid_itmseq and a.iid_recseq <> b.iid_recseq and a.iid_venitm = b.iid_venitm and b.iid_stage = 'W') = 0
	



GO
GRANT EXECUTE ON [dbo].[sp_update_IMITMDAT_XLS] TO [ERPUSER] AS [dbo]
GO
