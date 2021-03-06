/****** Object:  StoredProcedure [dbo].[sp_update_BasicPrice]    Script Date: 09/29/2017 15:29:08 ******/
DROP PROCEDURE [dbo].[sp_update_BasicPrice]
GO
/****** Object:  StoredProcedure [dbo].[sp_update_BasicPrice]    Script Date: 09/29/2017 15:29:10 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO






/*
=================================================================
Program ID	: sp_update_BasicPrice   
Description	: Update Basic Price of record in IMITMDAT
Programmer	: Lester Wu  
=================================================================
	MODIFICATION HISTORY
=================================================================
   Date		 Editor			Description
=================================================================
2012-06-12 	David Yue		Replace IMMRKUP with IMPRCINF Table
2012-07-18	David Yue		Revised Basic Price Calculation Paramters
2013-06-05	David Yue		ERP Phase 2 Implementation
=================================================================
*/


CREATE procedure [dbo].[sp_update_BasicPrice]
@cocde	varchar(6)
as

-- Lester Wu 2006-09-13
Declare 
@iid_cocde	varchar(6),	@iid_venitm	nvarchar(30),	@iid_venno	nvarchar(6),
@iid_xlsfil	nvarchar(30),	@iid_chkdat 	datetime,	@iid_prdven	nvarchar(6),
@iid_curcde	nvarchar(6),	@iid_ftyprc	numeric(13,4), 	@iid_lnecde 	nvarchar(10), 
@iid_catlvl4	nvarchar(20), 	@iid_itmseq 	int,		@iid_recseq 	int,
@iid_untcde 	nvarchar(6),	@iid_inrqty 	int,		@iid_mtrqty 	int,
@iid_mode 	nvarchar(6),
-- Added by David Yue 2012/06/13
@iid_alsitmno	nvarchar(30),	@iid_cus1no	nvarchar(6),	@iid_assconftr	int,
@iid_ftyprctrm	nvarchar(10),	@iid_prctrm	nvarchar(10),	@iid_trantrm	nvarchar(10)

DECLARE
@basicPrice_af	numeric(13,4), @basicPrice_b4	numeric(13,4), 	@bomPrice_af	numeric(13,4), 
@bomPrice_b4	numeric(13,4), @curr_b4		varchar(6), 	@curr_af	varchar(6)
	
DECLARE
@ventyp 	char(1), 	@itmno 		nvarchar(30), 	@defven		varchar(12)

DECLARE
@iic_cus1no	nvarchar(6),	@iic_cus2no	nvarchar(6)

Declare cur_BASPRC CURSOR
FOR	select 	iid_cocde, 	iid_venitm, 	iid_venno, 
		iid_xlsfil,	iid_chkdat, 	iid_prdven, 
		iid_curcde , 	iid_ftyprc, 	iid_lnecde, 
		iid_catlvl4, 	iid_itmseq, 	iid_recseq,
		iid_untcde, 	iid_inrqty, 	iid_mtrqty, 
		iid_mode, 	iid_alsitmno, 	iid_cus1no, 
		iid_assconftr,	iid_ftyprctrm,	iid_prctrm,
		iid_trantrm
	from	IMITMDAT (nolock)	
	where 	iid_stage =  'W' and
		iid_updusr <> 'EA-PRC' and
		isnull(iid_curr_bef,'') = ''

open cur_BASPRC
Fetch NEXT FROM cur_BASPRC into
@iid_cocde, 	@iid_venitm, 	@iid_venno, 
@iid_xlsfil, 	@iid_chkdat, 	@iid_prdven, 
@iid_curcde, 	@iid_ftyprc, 	@iid_lnecde, 
@iid_catlvl4, 	@iid_itmseq, 	@iid_recseq,
@iid_untcde, 	@iid_inrqty, 	@iid_mtrqty, 
@iid_mode, 	@iid_alsitmno, 	@iid_cus1no, 
@iid_assconftr,	@iid_ftyprctrm,	@iid_prctrm,
@iid_trantrm
	
while @@fetch_status = 0
Begin
	set @itmno = ''
	set @defven = ''
	set @ventyp = ''
	
	if @iid_cocde = 'UCPP' or @iid_cocde = 'MS'
	begin
		select	@itmno = ibi_itmno,
			@defven = ibi_venno
		from	IMBASINF (nolock)
		where	ibi_itmno = @iid_venitm
	end
	else
	begin
		select 	@itmno = ivi_itmno,
			@defven = ibi_venno
		from 	IMVENINF (nolock)
			left join IMBASINF (nolock) 
				on ibi_itmno = ivi_itmno
		where 	ivi_venitm = @iid_venitm and 
			ivi_venno = @iid_venno
	end

	if @itmno is not NULL and @itmno <> ''
	begin
		if @defven is not NULL and @defven <> ''
		begin
			if @defven <> @iid_prdven
			begin
				set @ventyp = 'P'
			end
			else
			begin
				set @ventyp = 'D'
			end
		end
		else
		begin
			set @ventyp = 'D'
		end
	end
	else
	begin
		set @ventyp = 'D'
	end
	
	set @basicPrice_af = 0 
	set @bomPrice_af = 0 
	set @curr_af = ''
	set @basicPrice_b4 = 0 
	set @bomPrice_b4 = 0 
	set @curr_b4 = ''
	
	if @ventyp = 'D'
	begin
		
		set @itmno = case when @iid_mode = 'NEW' and len(@iid_alsitmno) > 0 then @iid_alsitmno else @iid_venitm end
		
		--David Yue 06/13/2012 Use negprc to calculate basic price if negprc exists
		declare @negprc numeric(13,4)
		set @negprc = 0

		select top 1
			@negprc = round( isnull(iic_negprc,0),4),
			@iic_cus1no = isnull(iic_cus1no,''),
			@iic_cus2no = isnull(iic_cus2no,'')
		from 	IMITMDATCST (nolock)
		where	iic_cocde = @iid_cocde and 
			iic_venno = @iid_venno and  
			iic_prdven = @iid_prdven and
	   		iic_venitm = @iid_venitm and 
			iic_untcde = @iid_untcde and  
			iic_inrqty = @iid_inrqty and 
			iic_mtrqty = @iid_mtrqty and
			iic_itmseq = @iid_itmseq and
			iic_recseq = @iid_recseq and 
			iic_xlsfil = @iid_xlsfil and
			iic_chkdat = @iid_chkdat and
			iic_stage = 'W'	
			and iic_conftr = @iid_assconftr
		order by iic_credat desc
		
		select	@basicPrice_b4 = imu_basprc, 
			@bomPrice_b4 = imu_bomprc, 
			@curr_b4 = imu_bcurcde
		from	IMPRCINF (nolock)
		where	imu_itmno =  @itmno and
			imu_pckunt = @iid_untcde and
			imu_inrqty = @iid_inrqty and
			imu_mtrqty = @iid_mtrqty and
			imu_venno = @iid_venno and
			imu_prdven = @iid_prdven and
			imu_cus1no = @iic_cus1no and
			imu_cus2no = @iic_cus2no and
			imu_ftyprctrm = @iid_ftyprctrm and
			imu_hkprctrm = @iid_prctrm and
			imu_trantrm = @iid_trantrm

		if @curr_b4 is null
		begin
			set @curr_b4 = 'USD'
		end
		if @curr_b4 = ''
		begin
			set @curr_b4 = 'USD'
		end

		if @negprc <> 0
		begin
			exec sp_calBasicPrice_excel @iid_cocde, @iid_venitm , @iid_venno , @iid_xlsfil	, @iid_chkdat , @iid_prdven , @iid_curcde , @negprc , @iid_lnecde , @iid_catlvl4,@ventyp ,@basicPrice_af   = @basicPrice_af     output, @bomPrice_af   = @bomPrice_af     output
		end
		else
		begin
			exec sp_calBasicPrice_excel @iid_cocde, @iid_venitm , @iid_venno , @iid_xlsfil	, @iid_chkdat , @iid_prdven , @iid_curcde , @iid_ftyprc , @iid_lnecde , @iid_catlvl4,@ventyp ,@basicPrice_af   = @basicPrice_af     output, @bomPrice_af   = @bomPrice_af     output
		end
		

		update	IMITMDAT 
		set 	iid_basprc = @basicPrice_af , 
			iid_basprc_bef = @basicPrice_b4 , 
			iid_bomprc = @bomPrice_af , 
			iid_bomprc_bef = @bomPrice_b4 ,
			iid_curr_bef = @curr_b4, 
			iid_upddat = getdate(),
			iid_updusr = 'EA-PRC'
		where	iid_cocde = @iid_cocde and 
			iid_venno = @iid_venno and
			iid_venitm = @iid_venitm and 
			iid_itmseq = @iid_itmseq and
			iid_recseq = @iid_recseq and
			iid_xlsfil = @iid_xlsfil and
			iid_chkdat = @iid_chkdat				
	end

	Fetch NEXT FROM cur_BASPRC into
	@iid_cocde, 	@iid_venitm, 	@iid_venno, 
	@iid_xlsfil,	@iid_chkdat, 	@iid_prdven, 
	@iid_curcde , 	@iid_ftyprc, 	@iid_lnecde, 
	@iid_catlvl4, 	@iid_itmseq, 	@iid_recseq,
	@iid_untcde, 	@iid_inrqty, 	@iid_mtrqty, 
	@iid_mode, 	@iid_alsitmno, 	@iid_mode, 
	@iid_alsitmno,	@iid_ftyprctrm,	@iid_prctrm,
	@iid_trantrm
End
close cur_BASPRC
deallocate cur_BASPRC







GO
GRANT EXECUTE ON [dbo].[sp_update_BasicPrice] TO [ERPUSER] AS [dbo]
GO
