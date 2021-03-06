/****** Object:  StoredProcedure [dbo].[sp_update_IMINDDAT]    Script Date: 09/29/2017 15:29:08 ******/
DROP PROCEDURE [dbo].[sp_update_IMINDDAT]
GO
/****** Object:  StoredProcedure [dbo].[sp_update_IMINDDAT]    Script Date: 09/29/2017 15:29:10 ******/
SET ANSI_NULLS OFF
GO
SET QUOTED_IDENTIFIER OFF
GO











/*
=================================================================
Program ID	: sp_update_IMINDDAT
Description	: update Item Master items
Programmer	: Tomm6y Ho
=================================================================
	MODIFICATION HISTORY
=================================================================
   Date		 Editor			Description
=================================================================
2004-07-29	Allan Yuen		Add Wastage% im BOM Item
2012-06-19	David Yue		Replaced IMMRKUP Table with IMPRCINF
2013-06-05	David Yue		Performance Revision
=================================================================
*/


CREATE PROCEDURE [dbo].[sp_update_IMINDDAT] 
@cocde  nvarchar(6), 
@creusr  nvarchar(30)

AS

set nocount on

DECLARE -- TEMP
@venitm 	nvarchar(20), 	@colseq		int,		@itmno 		nvarchar(20),
@itmsts 	nvarchar(3),	@defven		nvarchar(6),	@ventyp		nvarchar(1),
@imu_curcde	varchar(4),	@imu_ftyprc  	numeric(13,4),	@fml		nvarchar(300),
@end		int,		@temp 		numeric(13,4),	@iba_bombasprc 	numeric(13,4),
@OP		nvarchar(1),	@iba_fmlopt 	varchar(5),	@imu_basprc	numeric(13,4),
@imu_bomprc	numeric(13,4),	@imu_itmprc	numeric(13,4)

DECLARE	--IMCOLDAT
@icd_cocde	nvarchar(6),	@icd_venitm	nvarchar(20),	@icd_colcde	nvarchar(30),
@icd_coldsc	nvarchar(300),	@icd_xlsfil	nvarchar(30),	@icd_chkdat	datetime,
@icd_recseq	int,		@icd_sysmsg	nvarchar(300),	@icd_veneml	nvarchar(50),
@icd_malsts	nvarchar(1),	@icd_stage	nvarchar(3),	@icd_venno	nvarchar(6),
@icd_credat	datetime,	@icd_prdven	nvarchar(6)

DECLARE	--IMCOMDAT
@imd_cocde	nvarchar(6),	@imd_venitm	nvarchar(20),	@imd_itmseq	int,
@imd_recseq	int,		@imd_cosmth	nvarchar(50),	@imd_compon 	nvarchar(200),
@imd_asstive	int,		@imd_stage	nvarchar(3),	@imd_sysmsg	nvarchar(300),	
@imd_xlsfil	nvarchar(30),	@imd_veneml	nvarchar(50),	@imd_malsts	nvarchar(1),	
@imd_chkdat	datetime,	@imd_venno	nvarchar(6),	@imd_credat	datetime,
@imd_prdven	nvarchar(6),	@imd_rmk	nvarchar(200)

DECLARE 	--IMBOMDAT
@ibd_cocde	nvarchar(6),	@ibd_venitm	nvarchar(20),	@ibd_acsno	nvarchar(20),
@ibd_colcde	nvarchar(200),	@ibd_qty	int,		@ibd_xlsfil 	nvarchar(30),	
@ibd_chkdat	datetime,	@ibd_untcde	nvarchar(6),	@ibd_conftr	int,
@ibd_recseq	int,		@ibd_stage	nvarchar(3),	@ibd_sysmsg	nvarchar(300),	
@ibd_veneml	nvarchar(50),	@ibd_malsts	nvarchar(1),	@ibd_venno	nvarchar(6),	
@ibd_credat	datetime,	@ibd_prdven	nvarchar(6),	@ibd_seqno	int

declare @xlsfil nvarchar(30)
declare @chkdat datetime
declare @stage nvarchar(1)
--Frankie Cheung 20110923
declare @itmseq int

DECLARE cur_IMCOLDAT CURSOR
FOR 	select 	icd_cocde,	icd_venitm,	icd_recseq,
		icd_colcde,	icd_coldsc,	icd_stage,
		icd_sysmsg,	icd_xlsfil,		icd_veneml,
		icd_malsts,	icd_chkdat,	icd_venno,
		icd_credat,	icd_prdven
	from IMCOLDAT (nolock)
	where 	icd_stage = 'W'	and
	(select	count(*) from IMITMDAT (nolock) where iid_venno = icd_venno and iid_venitm = icd_venitm and
		iid_chkdat = icd_chkdat and iid_xlsfil = icd_xlsfil and iid_prdven = icd_prdven) = 0				
	order by icd_venitm

OPEN cur_IMCOLDAT
FETCH NEXT from cur_IMCOLDAT INTO 
@icd_cocde,	@icd_venitm,	@icd_recseq,
@icd_colcde,	@icd_coldsc,	@icd_stage,
@icd_sysmsg,	@icd_xlsfil,	@icd_veneml,
@icd_malsts,	@icd_chkdat,	@icd_venno,
@icd_credat,	@icd_prdven

set @venitm = ''

WHILE @@fetch_status = 0
BEGIN

--IMCOLINF - START-------------------------
--if @venitm <> @icd_venitm
--begin

	set @itmno = ''

	if @icd_cocde = 'UCPP' or @icd_cocde = 'MS'
	begin
		select	@itmno = ibi_itmno,
			@defven = ibi_venno
		from	IMBASINF (nolock)
		where	ibi_itmno = @icd_venitm
	end
	else
	begin
		select 	@itmno = ivi_itmno,
			@defven = ibi_venno
		from 	IMVENINF (nolock)
			left join IMBASINF (nolock) on 
			ibi_itmno = ivi_itmno
		where 	ivi_venitm = @icd_venitm and 
			ivi_venno = @icd_venno
	end

	if @defven is not NULL and @defven <> ''
	begin
		if @defven <> @icd_prdven
		begin
			set @ventyp = 'P'
		end
		else
		begin
			set @ventyp = 'D'
		end
	end
	
	if @itmno is null or @itmno = ''
	begin
		set @icd_stage = 'I'
		set @icd_sysmsg = @icd_venitm + ' - Vendor Item Number not exist'
	end
	else
	begin
		set @icd_stage= 'W'
		set @icd_sysmsg = ''
	end

--end

	if @icd_stage = 'W' and @ventyp = 'D'
	begin
		--Frankie Cheung 20110802----- 
		set @xlsfil = ''
		set @chkdat = 0
		set @itmseq = 0
		set @stage = ''

		if exists (select count(*) from IMITMDATH (nolock) where iid_venitm = @itmno and iid_stage = 'R')
		begin			

			select top 1
				@xlsfil = iid_xlsfil,
				@chkdat = iid_chkdat,
				@itmseq = iid_itmseq  
			from	IMITMDATH (nolock)
			where	iid_venitm = @itmno
			order by iid_credat desc

			select distinct iid_stage into #tmp
			from	IMITMDATH (nolock) 
			where	iid_xlsfil = @xlsfil and
				iid_chkdat = @chkdat and
				iid_itmseq = @itmseq and
				iid_venitm = @itmno
			
			if (select count(*) from #tmp) = 1 
			begin
				select	@stage = iid_stage
				from	#tmp
				if @stage <> 'R'
				begin
					set @stage = ''
				end	
			end
			else
			begin
				if exists (select * from #tmp where iid_stage = 'R')
				begin
					if  exists (select * from #tmp where iid_stage = 'A')
					begin
						set @stage = ''				
					end
					else
					begin
						set @stage = 'R'
					end 		
				end
				else
				begin
					set @stage = ''
				end 
			end
		
			drop table #tmp	
		end
		------------------------------

		if (select count(*) from IMCOLINF (nolock) where icf_itmno = @itmno and icf_vencol = @icd_colcde) = 0
		begin
			set @colseq = (select isnull(max(icf_colseq),0) + 1 from IMCOLINF where icf_itmno = @itmno)

			if (select count(*) from IMPCKINF (nolock) where ipi_itmno = @itmno) = 0 or
			   (select count(*) from IMPRCINF (nolock) where imu_itmno = @itmno and imu_ventyp = 'D' and imu_ftyprc = 0) > 0
			begin
				set @itmsts = 'INC'
			end
			else
			begin
				set @itmsts = 'CMP'
			end					

			update 	IMBASINF
			set 	ibi_prvsts = (case ibi_itmsts when 'HLD' then @itmsts else ibi_itmsts end),
				ibi_itmsts = @itmsts,
				ibi_updusr = 'E-' + @creusr ,
				ibi_upddat = getdate()
			where 	ibi_itmno = @itmno and
				ibi_itmsts <> @itmsts and
				-- Frankie Cheung 20110901	
				@stage <> 'R' and
				ibi_itmsts <> 'DIS' and
				(select count(*) from IMITMDAT (nolock) where iid_venitm = @icd_venitm and iid_stage = 'W') = 0

			insert into IMCOLINF
			(	icf_cocde,	icf_itmno,	icf_colcde,	
				icf_colseq,	icf_vencol,	icf_coldsc,	
				icf_typ,	icf_ucpcde,	icf_eancde,	
				icf_creusr,	icf_updusr,	icf_credat,	
				icf_upddat
			)	
			VALUES
			(	' ', 		@itmno,		@icd_colcde,	
				@colseq,	@icd_colcde,	@icd_coldsc,	
				'',		'',		'',		
				'E-' + @creusr,	'E-' + @creusr,	getdate(),	
				getdate()
			)
		end
		else
		begin
			if (select count(*) from IMPCKINF (nolock) where ipi_itmno = @itmno) = 0
			begin
				set @itmsts = 'INC'
			end
			else
			begin
				set @itmsts = 'CMP'
			end



			update 	IMBASINF 
			set 	ibi_prvsts = (case ibi_itmsts when 'HLD' then @itmsts else ibi_itmsts end),
				ibi_itmsts = @itmsts,
				ibi_updusr = 'E-' + @creusr,
				ibi_upddat = getdate()
			where 	ibi_itmno = @itmno and
				-- Frankie Cheung 20110901	
				@stage <> 'R' and
				ibi_itmsts <> 'DIS' and
				(select count(*) from IMITMDAT (nolock) where iid_venitm = @icd_venitm and 
				(iid_stage = 'A' or iid_stage = 'R' or iid_stage = 'W')) = 0



			update IMCOLINF 
			set 	icf_coldsc = @icd_coldsc,
				icf_updusr = 'E-' + @creusr,
				icf_upddat = getdate()
			where	icf_itmno = @itmno and
				icf_vencol = @icd_colcde
		end		
	end

	insert into IMCOLDATH
	(	icd_cocde,	icd_venitm,	icd_recseq,
		icd_colcde,	icd_coldsc,	icd_sysmsg,	
		icd_xlsfil,	icd_veneml,	icd_malsts,	
		icd_chkdat,	icd_creusr,	icd_updusr,	
		icd_credat,	icd_upddat,	icd_stage, 
		icd_venno,	icd_prdven
	)
	VALUES
	(	@icd_cocde,	@icd_venitm,	@icd_recseq,
		@icd_colcde,	@icd_coldsc,	@icd_sysmsg,	
		@icd_xlsfil,	@icd_veneml,	@icd_malsts,	
		@icd_chkdat,	'E-' + @creusr,	'E-' + @creusr,
		getdate(),	@icd_credat,	@icd_stage,
		@icd_venno, 	@icd_prdven
	)
	
	delete from IMCOLDAT
	where 	icd_cocde = @icd_cocde and
		icd_venitm = @icd_venitm and
		icd_venno = @icd_venno and
		icd_recseq = @icd_recseq and
		icd_colcde = @icd_colcde and
		icd_prdven = @icd_prdven

set @venitm = @icd_venitm

FETCH NEXT from cur_IMCOLDAT INTO 
@icd_cocde,	@icd_venitm,	@icd_recseq,
@icd_colcde,	@icd_coldsc,	@icd_stage,
@icd_sysmsg,	@icd_xlsfil,	@icd_veneml,
@icd_malsts,	@icd_chkdat,	@icd_venno,
@icd_credat,	@icd_prdven

END
CLOSE cur_IMCOLDAT
DEALLOCATE cur_IMCOLDAT
--IMCOLINF - END-------------------------



--IMMATBKD - START-------------------------
DECLARE cur_IMCOMDAT CURSOR
FOR 	select 	imd_cocde,	imd_venitm,	imd_itmseq,
		imd_recseq,	imd_cosmth,	imd_compon,
		imd_asstive,	imd_stage,	imd_sysmsg,	
		imd_xlsfil,	imd_veneml,	imd_malsts,	
		imd_chkdat,	imd_venno,	imd_credat,
		imd_prdven,	imd_rmk
	from 	IMCOMDAT (nolock)
	where 	imd_stage = 'W' and
		(select count(*) from IMITMDAT (nolock) where iid_venno = imd_venno and iid_venitm = imd_venitm and
			iid_chkdat = imd_chkdat and iid_xlsfil = imd_xlsfil and iid_prdven = imd_prdven) = 0
	order by imd_venitm

OPEN cur_IMCOMDAT
FETCH NEXT from cur_IMCOMDAT INTO 
@imd_cocde,	@imd_venitm,	@imd_itmseq,
@imd_recseq,	@imd_cosmth,	@imd_compon,
@imd_asstive,	@imd_stage,	@imd_sysmsg,	
@imd_xlsfil,	@imd_veneml,	@imd_malsts,	
@imd_chkdat,	@imd_venno,	@imd_credat,
@imd_prdven,	@imd_rmk

set @venitm = ''

WHILE @@fetch_status = 0
BEGIN

	if (select count(*) from IMITMDAT (nolock) where iid_venno = @imd_venno and iid_venitm = @imd_venitm and 
		iid_chkdat = @imd_chkdat and iid_xlsfil = @imd_xlsfil and iid_prdven = @imd_prdven) = 0
	begin
		set @itmno = ''
		if @imd_cocde = 'UCPP' OR  @imd_cocde = 'MS' 
		begin
			select	@itmno = ibi_itmno,
				@defven = ibi_venno
			from	IMBASINF (nolock)
			where	ibi_itmno = @imd_venitm
		end
		else
		begin
			select 	@itmno = ivi_itmno , @defven = ibi_venno
			from 	IMVENINF (nolock)
				left join IMBASINF (nolock) on ibi_itmno = ivi_itmno
			where 	ivi_venitm = @imd_venitm and 
				ivi_venno = @imd_venno
		end

		if @defven is not NULL and @defven <> ''
		begin
			if @defven <> @imd_prdven
			begin
				set @ventyp = 'P'
			end
			else
			begin
				set @ventyp = 'D'
			end
		end
		
		if @itmno is null or @itmno = ''
		begin
			set @imd_stage = 'I'
			set @imd_sysmsg = @imd_venitm + ' - Vendor Item Number not exist'
		end
		else
		begin
			set @imd_stage = 'W'
			set @imd_sysmsg = ''
		end				

		if @venitm <> @imd_venitm and @imd_stage = 'W' and @ventyp = 'D'
		begin	
			if @imd_cosmth <> (select ibi_cosmth from IMBASINF (nolock) where ibi_cocde = @imd_cocde and ibi_itmno = @itmno)
			begin
				update	IMBASINF
				set 	ibi_cosmth = @imd_cosmth,
					ibi_updusr = 'E-' + @creusr ,
					ibi_upddat = getdate(),
					ibi_rmk = left(ibi_rmk + (case ltrim(@imd_rmk) when '' then '' else
							@imd_rmk + char(13) + char(10)  end),2000)
				where	ibi_itmno = @itmno
			end
			else
			begin
				update	IMBASINF
				set	ibi_rmk = left(ibi_rmk + (case ltrim(@imd_rmk) when '' then '' else
						@imd_rmk + char(13) + char(10)  end),2000)
				where	ibi_itmno = @itmno			
			end

			if @imd_compon <> '' 
			begin	
				delete from IMMATBKD
				where	ibm_cocde = @imd_cocde and
					ibm_itmno = @itmno and
					@imd_compon <> '' and
					@imd_compon is not NULL
			end
		end
		else
		begin
			update	IMBASINF
			set 	ibi_rmk = left(ibi_rmk + (case ltrim(@imd_rmk) when '' then '' else
						@imd_rmk + char(13) + char(10)  end),200)
			where	ibi_itmno = @itmno			
		end

		if @imd_stage = 'W' and @ventyp = 'D'
		begin
			insert into IMMATBKD 
			(	ibm_cocde,	ibm_itmno,	ibm_matseq,
				ibm_mat,	ibm_curcde,	ibm_cst,
				ibm_cstper,	ibm_wgtper,	ibm_creusr,
				ibm_updusr,	ibm_credat,	ibm_upddat
			)
			select  imd_cocde,	@itmno,		imd_recseq,
				imd_compon,	@imu_curcde,	0,
				imd_asstive,	0,		'E-' + @creusr,
				'E-' + @creusr,	getdate(),	getdate() 
			from IMCOMDAT (nolock)
			where	imd_cocde = @imd_cocde and
				imd_venitm = @imd_venitm and
				imd_venno = @imd_venno and
				imd_itmseq = @imd_itmseq and
				imd_recseq = @imd_recseq and
				imd_xlsfil = @imd_xlsfil and 
				imd_chkdat = @imd_chkdat and
				imd_prdven = @imd_prdven and
				@imd_compon <> '' and 
				@imd_compon is not NULL
			order by imd_recseq
		end

		insert into IMCOMDATH
		(	imd_cocde,	imd_venitm,	imd_itmseq,
			imd_recseq,	imd_cosmth,	imd_compon,
			imd_asstive,	imd_stage,	imd_sysmsg,
			imd_xlsfil,	imd_veneml,	imd_malsts,
			imd_chkdat,	imd_creusr,	imd_updusr,
			imd_credat,	imd_upddat,	imd_venno,
			imd_prdven,	imd_rmk
		)
		select  imd_cocde, 	imd_venitm, 	imd_itmseq,
			imd_recseq, 	imd_cosmth,	imd_compon,	
			imd_asstive,	@imd_stage,	@imd_sysmsg,
			imd_xlsfil,	imd_veneml,	imd_malsts,
			imd_chkdat,	'E-' + @creusr,	'E-' + @creusr,
			getdate(),	imd_credat,	imd_venno,
			imd_prdven,	@imd_rmk
		from 	IMCOMDAT (nolock)
		where	imd_cocde = @imd_cocde and
			imd_venitm = @imd_venitm and
			imd_venno = @imd_venno and
			imd_itmseq = @imd_itmseq and
			imd_recseq = @imd_recseq and
			imd_xlsfil = @imd_xlsfil and 
			imd_chkdat = @imd_chkdat and
			imd_prdven = @imd_prdven
		order by imd_recseq

		delete from IMCOMDAT
		where	imd_cocde = @imd_cocde and
			imd_venitm = @imd_venitm and
			imd_venno = @imd_venno and
			imd_itmseq = @imd_itmseq and
			imd_recseq = @imd_recseq and
			imd_xlsfil = @imd_xlsfil and 
			imd_chkdat = @imd_chkdat and
			imd_prdven = @imd_prdven

		set @venitm = @imd_venitm
	end
FETCH NEXT from cur_IMCOMDAT INTO 
@imd_cocde,	@imd_venitm,	@imd_itmseq,
@imd_recseq,	@imd_cosmth,	@imd_compon,
@imd_asstive,	@imd_stage,	@imd_sysmsg,	
@imd_xlsfil,	@imd_veneml,	@imd_malsts,	
@imd_chkdat,	@imd_venno,	@imd_credat,
@imd_prdven,	@imd_rmk

END
CLOSE cur_IMCOMDAT
DEALLOCATE cur_IMCOMDAT

-- delete all rejected item's assorted item information.
delete from IMASSDAT where  iad_venitm not in (select iid_venitm from IMITMDAT (nolock))

-- delete all rejected item's BOM item information.
delete from IMBOMDAT where  ibd_venitm not in (select iid_venitm from IMITMDAT (nolock))




set nocount off

























GO
GRANT EXECUTE ON [dbo].[sp_update_IMINDDAT] TO [ERPUSER] AS [dbo]
GO
