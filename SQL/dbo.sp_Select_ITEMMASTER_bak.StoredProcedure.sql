/****** Object:  StoredProcedure [dbo].[sp_Select_ITEMMASTER_bak]    Script Date: 09/29/2017 15:29:09 ******/
DROP PROCEDURE [dbo].[sp_Select_ITEMMASTER_bak]
GO
/****** Object:  StoredProcedure [dbo].[sp_Select_ITEMMASTER_bak]    Script Date: 09/29/2017 15:29:10 ******/
SET ANSI_NULLS OFF
GO
SET QUOTED_IDENTIFIER OFF
GO





/************************************************************************
Author:		Louis Siu
Date:		27th Dec, 2001
Description:	Data extraction from (6/F to 3/F)

************************************************************************/
CREATE PROCEDURE [dbo].[sp_Select_ITEMMASTER_bak] 

@cocde		nvarchar(6)
AS
Declare 	@daterangeStart	datetime,
	@daterangeEnd	datetime

set nocount on

--SET @daterangeStart = '2002-03-08'
--SET @daterangeEnd = '2002-03-28'

SET @daterangeEnd = 	LTRIM(STR(YEAR(getdate()-1))) + '-' +
			LTRIM(STR(MONTH(getdate()-1))) + '-' +
			LTRIM(STR(DAY(getdate()-1)))  + ' 23:59:59.998'

SET @daterangeStart =  	LTRIM(STR(YEAR(getdate()-1))) + '-' +
			LTRIM(STR(MONTH(getdate()-1))) + '-' +
			LTRIM(STR(DAY(getdate()-1)))  +  ' 00:00:00.000'

IF (Select count(*) 	FROM IMBASINF 
		WHERE 	ibi_cocde = 'UCPP'  and 
			ibi_venno <> 'D' and 
			ibi_upddat Between @daterangeStart and @daterangeEnd and 
			(ibi_itmsts = 'CMP' or ibi_itmsts = 'INC') and
			ibi_credat >='2002-03-08') > 0 
BEGIN


/*Select (SELECT COUNT(*)	FROM IMBASINF 
			WHERE 	ibi_cocde = 'UCPP'  and 
				ibi_venno <> 'D' and 
				ibi_upddat < @daterangeEnd and 
				ibi_upddat > @daterangeStart and 
				(ibi_itmsts = 'CMP' or ibi_itmsts = 'INC')and
				ibi_credat >='2002-03-08')*/

DECLARE	-- IMBASINF
@itmnoGen 	nvarchar(20),
@ibi_cocde 	nvarchar(6),	@ibi_itmno 	nvarchar(20),	@ibi_orgitm 	nvarchar(20),
@ibi_lnecde	nvarchar(10),	@ibi_curcde 	nvarchar(6),	@ibi_catlvl0	nvarchar(20),
@ibi_catlvl1	nvarchar(20),	@ibi_catlvl2 	nvarchar(20),	@ibi_catlvl3 	nvarchar(20),
@ibi_catlvl4 	nvarchar(20),	@ibi_itmsts	nvarchar(4), 	@ibi_typ		nvarchar(4),
@ibi_engdsc	nvarchar(300), 	@ibi_chndsc	nvarchar(600), 	@ibi_venno	nvarchar(6),  
@ibi_imgpth	nvarchar(50), 	@ibi_hamusa	nvarchar(20), 	@ibi_hameur	nvarchar(20),
@ibi_dtyusa	numeric(6,3),	@ibi_dtyeur	numeric(6,3),	@ibi_cosmth	nvarchar(50),
@ibi_rmk		nvarchar(200),	@ibi_tirtyp	nvarchar(1),	@ibi_moqctn	int,
@ibi_qty		int,		@ibi_moa		numeric(11,4),	@ibi_prvsts	nvarchar(4),
@ibi_latrdat	nvarchar(8),	@ibi_creusr	nvarchar(30),	@ibi_updusr	nvarchar(30),
@ibi_credat 	datetime,		@ibi_upddat	datetime,
@iba_assitm	nvarchar(20),	@iba_typ		nvarchar(4),	@iba_colcde	nvarchar(30),
@iba_pckunt	nvarchar(4),	@iba_bomqty	int,		@iba_inrqty	int,
@iba_mtrqty	int


DECLARE 	--IMVENINF
@ivi_itmno	nvarchar(20),	@ivi_venitm	nvarchar(20),	@ivi_venno	nvarchar(6),
@ivi_def		nvarchar(4),	@ivi_subcde	nvarchar(10),	@ivi_creusr	nvarchar(30),
@ivi_updusr	nvarchar(30),	@ivi_credat	datetime,		@ivi_upddat	datetime


DECLARE 	--IMBOMASS
@assitm		nvarchar(20),
@ibasitmno	nvarchar(20),	@ibasitmnoNew	nvarchar(20),	@ibas_itmno	nvarchar(20),
@ibas_assitm 	nvarchar(20),	@ibas_typ		nvarchar(4),	@ibas_colcde	nvarchar(30),
@ibas_pckunt 	nvarchar(4),	@ibas_bomqty	int,		@ibas_inrqty	int,
@ibas_mtrqty	int,		@ibas_creusr 	nvarchar(30),	@ibas_updusr	nvarchar(30),
@ibas_credat	datetime,		@ibas_upddat	datetime



DECLARE 	--IMPCKINF
@ipi_itmno 	nvarchar(20),	@ipi_pckseq	int,
@ipi_pckunt 	nvarchar(6),	@ipi_mtrqty	numeric(11,4),	@ipi_inrqty 	numeric(11,4),
@ipi_inrhin 	numeric(11,4),	@ipi_inrwin 	numeric(11,4),	@ipi_inrdin 	numeric(11,4),			
@ipi_inrhcm 	numeric(11,4),	@ipi_inrwcm	numeric(11,4),	@ipi_inrdcm	numeric(11,4),
@ipi_mtrhin 	numeric(11,4),	@ipi_mtrwin	numeric(11,4),	@ipi_mtrdin	numeric(11,4),	
@ipi_mtrhcm	numeric(11,4),	@ipi_mtrwcm	numeric(11,4),	@ipi_mtrdcm	numeric(11,4),
@ipi_cft		numeric(11,4),	@ipi_cbm		numeric(11,4),	@ipi_grswgt	numeric(6,3),
@ipi_netwgt	numeric(6,3),	@ipi_pckitr 	nvarchar(300),	@ipi_creusr	nvarchar(30),
@ipi_updusr	nvarchar(30),	@ipi_credat	datetime,		@ipi_upddat	datetime,
@ipi_seqGen	int,
@pckunt 		nvarchar(6),	@mtrqty	numeric(11,4),	@inrqty 	numeric(11,4),

@delpckseq	int,		@delpckunt 	nvarchar(6),	 @delinrqty 	numeric(11,4),	
@delmtrqty 	numeric(11,4)
	
DECLARE 	--IMVENPCK
@ivp_creusr	nvarchar(30),
@ivp_updusr	nvarchar(30),	@ivp_credat	datetime,		@ivp_upddat	datetime


DECLARE 	--IMMRKUP

@imu_pckunt 	nvarchar(6),	@imu_inrqty 	int,		@imu_mtrqty 	int,
@imu_cft 		numeric(11,4),	@imu_curcde	nvarchar(6),	@imu_prctrm	nvarchar(10),
@imu_relatn 	nvarchar(4),	@imu_fmlopt 	nvarchar(5),	@imu_ftycst	numeric(13,4),
@imu_ftyprc	numeric(13,4),	@imu_calftyprc	numeric(13,4),	@imu_bcurcde	nvarchar(6),
@imu_basprc	numeric(13,4),	@imu_negprc	numeric(13,4),	@imu_creusr	nvarchar(30),
@imu_updusr	nvarchar(30),	@imu_credat	datetime,		@imu_upddat	datetime,
@yvf_fmlopt	nvarchar(4),	@yfi_fml		nvarchar(300),	
@i		int,		@OP		nvarchar(1),	@end		int,
@temp 		numeric(13,4),	@imu_selrat	numeric(8,3),	@3Fftycst		numeric(13,4),
@3FftycstMarkup	numeric(13,4),
@3Fbascst		numeric(13,4),	@3Fcurcde	nvarchar(6)


DECLARE 	--IMCOLINF
@icf_colcde	nvarchar(30),	@icf_vencol	nvarchar(30),	@icf_coldsc	nvarchar(200),
@icf_typ		nvarchar(4),	@icf_ucpcde	nvarchar(14),	@icf_eancde	nvarchar(14),
@icf_creusr	nvarchar(30),	@icf_updusr	nvarchar(30),	@icf_credat	datetime,
@icf_upddat	datetime,		@icf_seqGen int


DECLARE 	--Global variable 
@itmno		nvarchar(20),
@itmnoCond	nvarchar(20),
@itmno3F		nvarchar(20),
@itmno6F		nvarchar(20),
@pckseqGlobal	int


--Get record from DB------------------------------------------------------------------------------------


DECLARE cur_IMBASINF CURSOR
FOR 	SELECT 		
			ibi_cocde ,		ibi_itmno,		ibi_orgitm,
			ibi_lnecde ,	
			ibi_curcde ,	ibi_catlvl0, 	ibi_catlvl1 ,	
			ibi_catlvl2, 	ibi_catlvl3, 	ibi_catlvl4,
			ibi_itmsts ,		ibi_typ ,		ibi_engdsc ,	
			ibi_chndsc ,	ibi_venno ,	ibi_imgpth,		
			ibi_hamusa,	ibi_hameur,	ibi_dtyusa,		
			ibi_dtyeur,		ibi_cosmth ,	ibi_rmk,
			ibi_tirtyp,		ibi_moqctn,	ibi_qty,	
			ibi_moa,		ibi_prvsts,		ibi_creusr ,	
			ibi_updusr,	ibi_credat ,	ibi_upddat

FROM IMBASINF WHERE 	ibi_cocde = 'UCPP'  and 
				ibi_venno <> 'D' and 
				ibi_upddat Between @daterangeStart and @daterangeEnd and 
				--ibi_upddat < @daterangeEnd and ibi_upddat > @daterangeStart and 
				(ibi_itmsts = 'CMP' or ibi_itmsts = 'INC') and
				ibi_credat >='2002-03-08'
OPEN cur_IMBASINF
FETCH NEXT FROM cur_IMBASINF INTO 

			@ibi_cocde,	@ibi_itmno,	@ibi_orgitm,
			@ibi_lnecde,
			@ibi_curcde ,	@ibi_catlvl0, 	@ibi_catlvl1 ,	
			@ibi_catlvl2, 	@ibi_catlvl3, 	@ibi_catlvl4,
			@ibi_itmsts ,	@ibi_typ ,		@ibi_engdsc ,	
			@ibi_chndsc ,	@ibi_venno ,	@ibi_imgpth,		
			@ibi_hamusa,	@ibi_hameur,	@ibi_dtyusa,		
			@ibi_dtyeur,	@ibi_cosmth ,	@ibi_rmk,
			@ibi_tirtyp,	@ibi_moqctn,	@ibi_qty,	
			@ibi_moa,		@ibi_prvsts,	@ibi_creusr ,	
			@ibi_updusr,	@ibi_credat ,	@ibi_upddat

WHILE @@fetch_status = 0
BEGIN		
		--Define Global
		SET @itmno = @ibi_itmno



--Auto Gen itemno Function ----------------------------------------------------------------------------------------------------------------------------------------

declare @Year  nvarchar(2)
SET @Year = (Select right(Year(Getdate()),2))

	begin
		Set @itmnoGen = (Select @Year + '0005' + '-' +
			Case (Len((case when a.itmno>b.itmno then a.itmno else b.itmno end + 1)))  
				when 1 then '0000'
				when 2 then '000'	
				when 3 then '00'	
				when 4 then '0'
			else ''
			end						
		+
		ltrim(Str((case when a.itmno>b.itmno then a.itmno 
			else b.itmno
			end + 1))) as 'Max_itmno'
			from
		(Select isnull(Max(cast(right(ibi_itmno,5) as int)),0)  as 'itmno' 
		from imbasinf 
		where 	ibi_cocde = 'UCP' and
			ibi_venno = '0005' and
			right(left(ibi_itmno,7),1)  = '-' and 
			left(ibi_itmno,2) = @Year
		)a, 
		(Select isnull(Max(cast(right(ibi_itmno,5) as int)),0)  as 'itmno' 
		from imbasinfh 
		where 	ibi_cocde = 'UCP' and
			ibi_venno = '0005' and
			right(left(ibi_itmno,7),1)  = '-' and 
			left(ibi_itmno,2) = @Year
		)b)
	end



--print '=============================================================='

--print '6/F' + ' : ' + @itmno 
--exist 3/F and 6/F

set @itmno3F= (select ibi_itmno from IMBASINF,IMVENINF where 	ibi_cocde = 'UCP' and 
								ivi_cocde = 'UCP' and 	
								ibi_itmno = ivi_itmno and
								ibi_venno = ivi_venno and
								ivi_venitm = @itmno)
--print '3/F' + ' : ' + @itmno3F


if(select count(ibi_itmno) from IMBASINF,IMVENINF	 Where 	ibi_cocde = 'UCP' and 
							ivi_cocde = 'UCP' and 	
							ibi_itmno = ivi_itmno and
							ibi_venno = ivi_venno and
							ivi_venitm = @itmno) > 0
	
	begin
	set @itmnoCond = @itmno3F
	end
else
	
	begin
	set @itmnoCond = @itmnoGen
	end


--set @itmnoGen = 'test001'
--select '* Auto Gen / 3F itm', @itmnoGen, @itmno3F,'--', 'itmnoCond', @itmnoCond


--IMBASINF START---------------------------------------------------------------------------------------------------------------------------------------------

			if (select count(*) from IMBASINF,IMVENINF where 	ibi_cocde = 'UCP' and 
									ivi_venitm = @itmno and 
									ivi_cocde = 'UCP' and 
									ivi_venno = ibi_venno and 
									ibi_itmno = ivi_itmno) = 0 
			begin
			
			insert into IMBASINF				(	ibi_cocde ,		ibi_itmno,		ibi_orgitm,
					ibi_lnecde ,	
					ibi_curcde ,	ibi_catlvl0, 	ibi_catlvl1 ,	
					ibi_catlvl2, 	ibi_catlvl3, 	ibi_catlvl4,
					ibi_itmsts ,		ibi_typ ,		ibi_engdsc ,	
					ibi_chndsc ,	ibi_venno ,	ibi_imgpth,		
					ibi_hamusa,	ibi_hameur,	ibi_dtyusa,		
					ibi_dtyeur,		ibi_cosmth ,	ibi_rmk,
					ibi_tirtyp,		ibi_moqctn,	ibi_qty,	
					ibi_moa,		ibi_prvsts,		ibi_creusr ,	
					ibi_updusr,	ibi_credat ,	ibi_upddat)
					
					
				values
				(	'UCP',		@itmnoCond,	'',
					@ibi_lnecde,
					@ibi_curcde,	@ibi_catlvl0, 	@ibi_catlvl1 ,	
					@ibi_catlvl2, 	@ibi_catlvl3, 	@ibi_catlvl4,
					@ibi_itmsts ,	@ibi_typ ,		@ibi_engdsc ,	
					@ibi_chndsc ,	'0005'	 ,	@ibi_imgpth,		
					@ibi_hamusa,	@ibi_hameur,	@ibi_dtyusa,		
					@ibi_dtyeur,	@ibi_cosmth ,	@ibi_rmk,
					@ibi_tirtyp,	@ibi_moqctn,	@ibi_qty,	
					@ibi_moa,		@ibi_prvsts,	'CreatUser' ,	
					'UpdateUser',	getdate(),		getdate())					
--print 'IMBASINF insert ---------------------------'
			end
				
			else
			
			begin


				update IMBASINF set ibi_lnecde = @ibi_lnecde,
							ibi_curcde = @ibi_curcde, ibi_catlvl0 = @ibi_catlvl0,
							ibi_catlvl1 = @ibi_catlvl1,
							ibi_catlvl2 = @ibi_catlvl2, ibi_catlvl3 = @ibi_catlvl3, ibi_catlvl4 = @ibi_catlvl4,
							ibi_itmsts = @ibi_itmsts, ibi_typ = @ibi_typ, ibi_engdsc = @ibi_engdsc, 
							ibi_chndsc = @ibi_chndsc, ibi_venno = '0005', ibi_imgpth = @ibi_imgpth, 
							ibi_hamusa = @ibi_hamusa, ibi_hameur = @ibi_hameur, ibi_dtyusa = @ibi_dtyusa,
							ibi_dtyeur = @ibi_dtyeur, ibi_cosmth = @ibi_cosmth, 	ibi_rmk = @ibi_rmk, 
							ibi_tirtyp = @ibi_tirtyp, ibi_moqctn = @ibi_moqctn, ibi_qty = @ibi_qty, 
							ibi_moa = @ibi_moa, ibi_prvsts = @ibi_prvsts,
							ibi_updusr = 'UpdateUser', ibi_upddat = getdate()
				From IMVENINF
				where 	ibi_cocde = 'UCP' and 
					ivi_cocde = 'UCP' and
					ivi_venitm = @ibi_itmno and 
					ivi_itmno = ibi_itmno and 
					ibi_venno = ivi_venno
--print 'IMBASINF update -------------------------'

			end			


--IMVENIF START-------------------------------------------------------------------------------------------------------------------------------------------------------------

DECLARE cur_IMVENINF CURSOR
FOR 	SELECT 		
			ivi_itmno,		ivi_venitm, 	ivi_venno,
			ivi_def,		ivi_subcde, 	ivi_creusr,
			ivi_updusr,	ivi_credat,		ivi_upddat	

FROM IMVENINF WHERE ivi_cocde = 'UCPP'  and ivi_itmno = @itmno and ivi_venno = @ibi_venno--'A'
OPEN cur_IMVENINF
FETCH NEXT FROM cur_IMVENINF INTO 
			@ivi_itmno,	@ivi_venitm,	@ivi_venno,
			@ivi_def,		@ivi_subcde,	@ivi_creusr,
			@ivi_updusr,	@ivi_credat,	@ivi_upddat

--	if @ivi_venno = 'A' 
-- 		set @ivi_venno = 'WT'
	Set @ivi_venno = isnull((Select vbi_orgven from VNBASINF where vbi_cocde = 'UCPP' and vbi_venno = @ivi_venno),'WT-Err')

--print @ivi_venno
--select 'IMVENINF', @ivi_itmno,@ivi_venitm,@ivi_venno,@ibi_itmno
	
	--Check IMVENINF - UCPP is it exist record from parameter-item no.
	if (select count(*) from IMVENINF where ivi_cocde = 'UCPP' and ivi_itmno = @itmno) > 0	
	begin

			if(select count(*) from IMVENINF where ivi_cocde = 'UCP' and ivi_itmno = @itmnoCond and ivi_venno = '0005') = 0
			begin

				insert into IMVENINF 
					(	ivi_cocde, 		ivi_itmno, 		ivi_venitm,
						ivi_venno,		ivi_def,		ivi_subcde,
						ivi_creusr,		ivi_updusr,	ivi_credat,
						ivi_upddat				
					)
				values
					(	'UCP',		@itmnoCond,	@ibi_itmno,
						'0005',		'Y',		@ivi_venno,			
						'CreateUser',	'UpdateUser',	getdate(),
						getdate()	
					)
				--print 'IMVENINF insert --------------------------------' + @itmnoCond

			end
			else 
			begin 

				update IMVENINF set ivi_def = 'Y', ivi_subcde = @ivi_venno,
						 ivi_updusr = 'UpdateUser', 
						 ivi_upddat = getdate()
				where ivi_cocde = 'UCP' and ivi_venitm = @ivi_itmno and ivi_itmno = @itmnoCond

				--print 'IMVENINF update --------------------------------' + @ivi_itmno
			end

	end    




close cur_IMVENINF
deallocate cur_IMVENINF


--IMBOMASS START -----------------------------------------------------------------------------------------------------------------------

	--Check IMBOMASS - UCPP is it exist record from parameter-item no.
	IF(select count(*) from IMBOMASS where iba_cocde = 'UCPP' and iba_itmno = @itmno) > 0
	BEGIN

		DECLARE cur_IMBOMASS CURSOR
		FOR 	SELECT 		
			iba_itmno,
			iba_assitm,		iba_typ,		iba_colcde,
			iba_pckunt,	iba_bomqty,	iba_inrqty,
			iba_mtrqty,	iba_creusr,		iba_updusr,
			iba_credat,		iba_upddat

		FROM IMBOMASS WHERE iba_cocde = 'UCPP'  and iba_itmno = @itmno

		OPEN cur_IMBOMASS 
		FETCH NEXT FROM cur_IMBOMASS INTO 			@ibas_itmno,
			@ibas_assitm,	@ibas_typ,	@ibas_colcde,
			@ibas_pckunt,	@ibas_bomqty,	@ibas_inrqty,
			@ibas_mtrqty,	@ibas_creusr,	@ibas_updusr,
			@ibas_credat,	@ibas_upddat	
		while @@fetch_status = 0
		begin

			if (select count(ibi_itmno) from IMBASINF,IMVENINF where 	ibi_cocde = 'UCP' and 
										ivi_cocde = 'UCP' and
										ivi_itmno = ibi_itmno and
										ivi_venno = ibi_venno and 
										ivi_venitm = @ibas_assitm) > 0
			begin
				--search assitm no from IMBASINF 3/F (if exist).
				set @assitm = (select ibi_itmno from IMBASINF,IMVENINF where 
										ibi_cocde = 'UCP' and 
										ivi_cocde = 'UCP' and
										ibi_itmno = ivi_itmno and
										ivi_venno = ibi_venno and
										ivi_venitm = @ibas_assitm)
		

				if (select count(*) from IMBOMASS where iba_cocde = 'UCP' and iba_itmno = @itmno3F and iba_typ = @ibas_typ and iba_colcde = @ibas_colcde and iba_assitm = @assitm)  = 0
				begin
					
					insert into IMBOMASS 
						(
							iba_cocde,		iba_itmno,
							iba_assitm,		iba_typ,		iba_colcde,
							iba_pckunt,	iba_bomqty,	iba_inrqty,
							iba_mtrqty,	iba_creusr,		iba_updusr,
							iba_credat,		iba_upddat
						)
					values
						(
							'UCP',		@itmnoCond,
							@assitm,	 	@ibas_typ,	@ibas_colcde,
							@ibas_pckunt,	@ibas_bomqty,	@ibas_inrqty,
							@ibas_mtrqty,	'CreateUser',	'UpdateUser',
							getdate(),		getdate()
						)

					--print 'IMBOMASS insert -------------------------' + @assitm
				end 	
				else
				begin 
				
					update IMBOMASS set --iba_assitm = @assitm, iba_typ = @ibas_typ, iba_colcde = @ibas_colcde,
							iba_pckunt = @ibas_pckunt, iba_bomqty = @ibas_bomqty, iba_inrqty = @ibas_inrqty,
							iba_mtrqty = @ibas_mtrqty, iba_updusr = 'UpdateUser', 
							iba_upddat = getdate()
					where iba_cocde = 'UCP' and iba_itmno = @itmno3F and iba_typ = @ibas_typ and iba_colcde = @ibas_colcde and iba_assitm = @assitm

					--print 'IMBOMASS update -------------------------' + @assitm

				end

				--print 
				--select 'IMBOMASS',@itmnoCond,@ibas_itmno,@ibas_assitm, @ibas_typ,@ibas_colcde
			end

			else
			begin

				execute sp_ITEMMASTER_SUB 'UCP',@ibas_assitm

				--search assitm no from IMBASINF 3/F (if exist).
				--set @assitm = (select ibi_itmno from IMBASINF where ibi_cocde = 'UCP' and ibi_orgitm = @ibas_assitm)
				set @assitm = (select ibi_itmno from IMBASINF,IMVENINF where 
										ibi_cocde = 'UCP' and 
										ivi_cocde = 'UCP' and
										ibi_itmno = ivi_itmno and
										ivi_venno = ibi_venno and
										ivi_venitm = @ibas_assitm)		

				if (select count(*) from IMBOMASS where iba_cocde = 'UCP' and iba_itmno = @itmno3F and iba_typ = @ibas_typ and iba_colcde = @ibas_colcde and iba_assitm = @assitm)  = 0
				begin
					
					insert into IMBOMASS 
						(
							iba_cocde,		iba_itmno,
							iba_assitm,		iba_typ,		iba_colcde,
							iba_pckunt,	iba_bomqty,	iba_inrqty,
							iba_mtrqty,	iba_creusr,		iba_updusr,
							iba_credat,		iba_upddat
						)
					values
						(
							'UCP',		@itmnoCond,
							@assitm,	 	@ibas_typ,	@ibas_colcde,
							@ibas_pckunt,	@ibas_bomqty,	@ibas_inrqty,
							@ibas_mtrqty,	'CreateUser',	'UpdateUser',
							getdate(),		getdate()
						)

					--print 'IMBOMASS insert -------------------------' + @assitm
				end 	
				else
				begin 
				
					update IMBOMASS set --iba_assitm = @assitm, iba_typ = @ibas_typ, iba_colcde = @ibas_colcde,
							iba_pckunt = @ibas_pckunt, iba_bomqty = @ibas_bomqty, iba_inrqty = @ibas_inrqty,
							iba_mtrqty = @ibas_mtrqty, iba_updusr = 'UpdateUser', 
							iba_upddat = getdate()
					where iba_cocde = 'UCP' and iba_itmno = @itmno3F and iba_typ = @ibas_typ and iba_colcde = @ibas_colcde and iba_assitm = @assitm

					--print 'IMBOMASS update -------------------------' + @assitm

				end

			end


		FETCH NEXT FROM cur_IMBOMASS INTO 			@ibas_itmno,
			@ibas_assitm,	@ibas_typ,	@ibas_colcde,
			@ibas_pckunt,	@ibas_bomqty,	@ibas_inrqty,
			@ibas_mtrqty,	@ibas_creusr,	@ibas_updusr,
			@ibas_credat,	@ibas_upddat	
		end

		CLOSE cur_IMBOMASS
		DEALLOCATE cur_IMBOMASS
	END 

----=========================================================================================
----=========================================================================================

--IMPCKINF START -----------------------------------------------------------------------------------------------------------------------


DECLARE cur_IMPCKINF CURSOR
FOR 	SELECT 		
	ipi_itmno,		ipi_pckseq,
	ipi_pckunt,	ipi_mtrqty,	ipi_inrqty,	
	ipi_inrhin,		ipi_inrwin,		ipi_inrdin,
	ipi_inrhcm,	ipi_inrwcm,	ipi_inrdcm,
	ipi_mtrhin,	ipi_mtrwin,	ipi_mtrdin,
	ipi_mtrhcm,	ipi_mtrwcm,	ipi_mtrdcm,	
	ipi_cft,		ipi_cbm,		ipi_grswgt,
	ipi_netwgt,	ipi_pckitr, 		ipi_creusr,
	ipi_updusr,	ipi_credat,		ipi_upddat	
	

FROM IMPCKINF WHERE ipi_cocde = 'UCPP'  and ipi_itmno = @itmno		

OPEN cur_IMPCKINF
FETCH NEXT FROM cur_IMPCKINF INTO 
	@ipi_itmno,	@ipi_pckseq,
	@ipi_pckunt,	@ipi_mtrqty,	@ipi_inrqty,	
	@ipi_inrhin,	@ipi_inrwin,	@ipi_inrdin,
	@ipi_inrhcm,	@ipi_inrwcm,	@ipi_inrdcm,
	@ipi_mtrhin,	@ipi_mtrwin,	@ipi_mtrdin,
	@ipi_mtrhcm,	@ipi_mtrwcm,	@ipi_mtrdcm,	
	@ipi_cft,		@ipi_cbm,		@ipi_grswgt,
	@ipi_netwgt,	@ipi_pckitr, 	@ipi_creusr,
	@ipi_updusr,	@ipi_credat,	@ipi_upddat	


--BEGIN while loop for ImPCKINF, IMVENPCK, IMMRKUP
WHILE @@fetch_status = 0
begin


--exist 3/F
set @pckseqGlobal=(select ipi_pckseq from IMPCKINF where ipi_cocde = 'UCP' and ipi_itmno = @itmnoCond and ipi_pckunt = @ipi_pckunt and ipi_mtrqty = @ipi_mtrqty and ipi_inrqty = @ipi_inrqty)
--print out
--select 'IMPCKINF', @pckseqGlobal,@ipi_itmno,@ipi_pckunt,@ipi_mtrqty,@ipi_inrqty


--Declare Auto Gen Swq ID--	
set @ipi_seqGen = (select isnull(max(ipi_pckseq),0) +1 from IMPCKINF where ipi_cocde = 'UCP' and ipi_itmno = @itmnoCond)
--select 'seqGen -=-=-=-=-=-',@ipi_seqGen	

	--Check IMPCKINF - UCPP is it exist record from parameter-item no.
	if (select count(*) from IMPCKINF where ipi_cocde = 'UCPP' and ipi_itmno = @itmno) > 0		
	begin
		
		if((select count(*) from IMBASINF where ibi_cocde = 'UCP' and ibi_itmno = @itmnoCond and ibi_typ = 'ASS') > 0 and (select count(*) from IMPCKINF where ipi_cocde = 'UCP' and ipi_itmno = @itmnoCond) > 0)
		begin

				update IMPCKINF set ipi_pckunt = @ipi_pckunt, ipi_mtrqty = @ipi_mtrqty, 
						ipi_inrqty = @ipi_inrqty, ipi_inrhin = @ipi_inrhin,
						ipi_inrwin = @ipi_inrwin, ipi_inrdin = @ipi_inrdin,
						ipi_inrhcm = @ipi_inrhcm, ipi_inrwcm = @ipi_inrwcm,
						ipi_inrdcm = @ipi_inrdcm, ipi_mtrhin = @ipi_mtrhin,
						ipi_mtrwin = @ipi_mtrwin, @ipi_mtrdin = @ipi_mtrdin,
						ipi_mtrhcm = @ipi_mtrhcm, ipi_mtrwcm = @ipi_mtrwcm, 
						ipi_mtrdcm = @ipi_mtrdcm, ipi_cft = @ipi_cft, 
						ipi_cbm = @ipi_cbm, ipi_grswgt = @ipi_grswgt, 
						ipi_netwgt = @ipi_netwgt, ipi_pckitr = @ipi_pckitr, 
						ipi_updusr = 'UpdateUser12',
						ipi_upddat = getdate()				
				where ipi_cocde = 'UCP' and ipi_itmno = @itmnoCond

				--print 'IMPCKINF update (ASS) ------------------------------' + @itmnoCond

		end
		else
		begin

			if (select count(*) from IMPCKINF where ipi_cocde = 'UCP' and ipi_itmno = @itmnoCond and ipi_pckunt = @ipi_pckunt and ipi_mtrqty = @ipi_mtrqty and ipi_inrqty = @ipi_inrqty) = 0	
			begin		

				
				if(select count(*) from IMPCKINF where ipi_cocde = 'UCP' and ipi_itmno = @itmnoCond)= 10 
				begin

					-- Define variable for delete IMMRKUP
					select @delpckseq = ipi_pckseq, @delpckunt = ipi_pckunt, @delinrqty = ipi_inrqty, @delmtrqty = ipi_mtrqty from IMPCKINF where ipi_cocde = 'UCP' and ipi_itmno = @itmnoCond and ipi_upddat = (select min(ipi_upddat) from IMPCKINF where ipi_cocde = 'UCP' and ipi_itmno = @itmnoCond)				

					delete from IMPCKINF where ipi_cocde = 'UCP' and ipi_itmno = @itmnoCond and ipi_upddat = (select min(ipi_upddat) from IMPCKINF where ipi_cocde = 'UCP' and ipi_itmno = @itmnoCond)
					--print 'IMPCKINF delete ---------------------------' 
				end

				insert into IMPCKINF				(	ipi_cocde,		ipi_itmno,		ipi_pckseq,
					ipi_pckunt,	ipi_mtrqty,	ipi_inrqty,	
					ipi_inrhin,		ipi_inrwin,		ipi_inrdin,
					ipi_inrhcm,	ipi_inrwcm,	ipi_inrdcm,
					ipi_mtrhin,	ipi_mtrwin,	ipi_mtrdin,
					ipi_mtrhcm,	ipi_mtrwcm,	ipi_mtrdcm,	
					ipi_cft,		ipi_cbm,		ipi_grswgt,
					ipi_netwgt,	ipi_pckitr, 		ipi_creusr,
					ipi_updusr,	ipi_credat,		ipi_upddat		)
					
				values
				(	'UCP',		@itmnoCond,	@ipi_seqGen,
					@ipi_pckunt,	@ipi_mtrqty,	@ipi_inrqty,	
					@ipi_inrhin,	@ipi_inrwin,	@ipi_inrdin,
					@ipi_inrhcm,	@ipi_inrwcm,	@ipi_inrdcm,
					@ipi_mtrhin,	@ipi_mtrwin,	@ipi_mtrdin,
					@ipi_mtrhcm,	@ipi_mtrwcm,	@ipi_mtrdcm,	
					@ipi_cft,		@ipi_cbm,		@ipi_grswgt,
					@ipi_netwgt,	@ipi_pckitr, 	'CreateUser',
					'UpdateUser',	getdate(),		getdate()		)		

				--print 'IMPCKINF insert ---------------------------------' + @itmnoCond

			end 
			else		
			begin		

				update IMPCKINF set ipi_pckunt = @ipi_pckunt, ipi_mtrqty = @ipi_mtrqty, 
						ipi_inrqty = @ipi_inrqty, ipi_inrhin = @ipi_inrhin,
						ipi_inrwin = @ipi_inrwin, ipi_inrdin = @ipi_inrdin,
						ipi_inrhcm = @ipi_inrhcm, ipi_inrwcm = @ipi_inrwcm,
						ipi_inrdcm = @ipi_inrdcm, ipi_mtrhin = @ipi_mtrhin,
						ipi_mtrwin = @ipi_mtrwin, @ipi_mtrdin = @ipi_mtrdin,
						ipi_mtrhcm = @ipi_mtrhcm, ipi_mtrwcm = @ipi_mtrwcm, 
						ipi_mtrdcm = @ipi_mtrdcm, ipi_cft = @ipi_cft, 
						ipi_cbm = @ipi_cbm, ipi_grswgt = @ipi_grswgt, 
						ipi_netwgt = @ipi_netwgt, ipi_pckitr = @ipi_pckitr, 
						ipi_updusr = 'UpdateUser12',
						ipi_upddat = getdate()				
				where ipi_cocde = 'UCP' and ipi_itmno = @itmnoCond and ipi_pckunt = @ipi_pckunt and ipi_mtrqty = @ipi_mtrqty and ipi_inrqty = @ipi_inrqty

			--print 'IMPCKINF update ------------------------------' + @itmnoCond
			
			end 		



		end
	
	end	


--IMVENPCK START ------------------------------------------------------------------------------------------------------------------------

Select @ivp_creusr = ivp_creusr , @ivp_updusr = ivp_updusr, @ivp_credat = ivp_credat, @ivp_upddat = @ivp_upddat
from IMVENPCK where  ivp_cocde = 'UCPP' and ivp_itmno = @itmno and ivp_venno = @ibi_venno and ivp_pckseq =@ipi_pckseq

--print
--select 'IMVENPCK',  @ivp_creusr, @ivp_updusr,@ivp_credat, @itmno3F, @itmnoGen

	--Check IMVENPCK - UCPP is it exist record from parameter - itmno no.
	if (select count(*) from IMVENPCK where ivp_cocde = 'UCPP' and ivp_itmno = @itmno) > 0
	begin
		
	
		if (select count(*) from IMVENPCK where ivp_cocde = 'UCP' and ivp_itmno = @itmnoCond and ivp_pckseq = @pckseqGlobal) = 0
		begin


				insert into IMVENPCK
				(	ivp_cocde, 	ivp_itmno,		ivp_pckseq,		
					ivp_venno,		ivp_relatn,		ivp_creusr,
					ivp_updusr,	ivp_credat,		ivp_upddat
				) 
				values
				(	'UCP',		@itmnoCond,	@ipi_seqGen,
					'0005',		'Yes',		'CreateUser',
					'UpdateUser',	getdate(),		getdate()
				) 
				--print 'IMVENPCK insert -------------------------------' + @itmnoCond
			
				end 		
				else			
				begin

				update IMVENPCK set ivp_updusr = 'UpdateUser', ivp_upddat = getdate()				
				where ivp_cocde = 'UCP' and ivp_itmno = @itmnoGen and ivp_pckseq = @pckseqGlobal

				--print 'IMVENPCK updade---------------------------------' + @itmnoGen

				end


	end


--IMMRKUP------------------------------------------------------------------------------------------------------------------------------


select 	@imu_pckunt = imu_pckunt, 		@imu_inrqty = imu_inrqty, 		@imu_mtrqty = imu_mtrqty,
	@imu_cft = imu_cft,			@imu_curcde = imu_curcde,		@imu_prctrm = imu_prctrm,
	@imu_relatn = imu_relatn, 		@imu_fmlopt = imu_fmlopt, 		@imu_ftycst = imu_ftycst,		
	@imu_ftyprc = imu_ftyprc,		@imu_calftyprc = imu_calftyprc,		@imu_bcurcde = imu_bcurcde,		
	@imu_basprc = imu_basprc,		@imu_negprc = imu_negprc,		@imu_creusr = imu_creusr	
from IMMRKUP where imu_cocde = 'UCPP' and imu_itmno = @itmno and imu_ventyp = 'D' and imu_venno =@ibi_venno and imu_pckseq = @ipi_pckseq

-- join table
select 	@yvf_fmlopt = yvf_fmlopt,		@yfi_fml = yfi_fml
from  syvenfml left join syfmlinf on yfi_cocde = yvf_cocde and yvf_fmlopt = yfi_fmlopt where yvf_venno = '0005'



--select 'IMMRKUP', @yvf_fmlopt, @yfi_fml
--select 'IMMRKUP',@imu_pckunt, @imu_inrqty, @imu_mtrqty, @imu_ftycst,@imu_bcurcde , @imu_basprc, @ibi_typ

--***Get 3/F Default Currency**********************************
select @3Fcurcde = ysi_cde from SYSETINF 
where 	ysi_cocde = @cocde 	and 	ysi_typ = '06' 	and 	ysi_def = 'Y' 	

--Get the Currency Rate----------------------------------
select @imu_selrat = ysi_selrat from SYSETINF 
where 	ysi_cocde = @cocde  and 	ysi_typ = '06' 	and 	ysi_cde = @imu_bcurcde

--Calculate Basic Price START---for Design Vendor-----------------------------------------
		SET @3Fftycst = @imu_basprc
		SET @yfi_fml = LTRIM(RTRIM(@yfi_fml))
		SET @i  = 1

		set @yfi_fml = replace(@yfi_fml, ' ','')

		if (substring(@yfi_fml,1,1) <> '*') and (substring(@yfi_fml,1,1)<> '/')
		begin
			set @yfi_fml = '*' + @yfi_fml
		end
		
	--set @imu_basprc = @iid_ftyprc
		
		while len(@yfi_fml) <> 0
		begin
			set @yfi_fml = ltrim(@yfi_fml)
			set @OP = substring(@yfi_fml,1,1)
			set @yfi_fml = substring(@yfi_fml, 2, len(@yfi_fml))
			
			if (charindex('*', @yfi_fml) = 0 and charindex('/', @yfi_fml) = 0)
			begin
				set @end = len(@yfi_fml) + 1
			end
			else if (charindex('*', @yfi_fml) = 0) 
			begin
				set @end = charindex('/', @yfi_fml)
			end
			else if (charindex('/', @yfi_fml) = 0) 
			begin
				set @end = charindex('*', @yfi_fml)
			end
			else
			begin
				if (charindex('*', @yfi_fml) < charindex('/', @yfi_fml)) 
				begin
					set @end = charindex('*', @yfi_fml)
				end
				else
				begin					set @end = charindex('/', @yfi_fml)
				end
			end

			set @temp = substring(@yfi_fml, 1, @end -1)

			if @OP = '*'
			begin
				set @3Fftycst = @3Fftycst * @temp /0.97
			end
			else if @OP = '/' 
			begin
				set @3Fftycst = @3Fftycst / @temp /0.97
			end
			
			set @yfi_fml = substring(@yfi_fml, @end, len(@yfi_fml))
		end

		set @3Fbascst = @3Fftycst * @imu_selrat
		--print @3Fbascst
		--Calculate Basic Price END--------------------------------------------

		-- 3F Fty Price = 6/F Base Price markup 3%
		set @3FftycstMarkup = @imu_basprc / 0.97

	if(select count(*) from IMMRKUP where imu_cocde = 'UCPP' and imu_itmno = @itmno) > 0
	begin
		
		if((select count(*) from IMBASINF where ibi_cocde = 'UCP' and ibi_itmno = @itmnoCond and ibi_typ = 'ASS') > 0 and (select count(*) from IMMRKUP where imu_cocde = 'UCP' and imu_itmno = @itmnoCond and imu_ventyp = 'D') > 0)
		begin

			update IMMRKUP set imu_pckunt = @imu_pckunt, imu_inrqty = @imu_inrqty, imu_mtrqty = @imu_mtrqty,
					imu_cft = @imu_cft, imu_curcde = @imu_bcurcde, imu_prctrm = @imu_prctrm,
					imu_relatn = @imu_relatn, imu_fmlopt = @yvf_fmlopt, imu_ftyprc = @3FftycstMarkup, 
					imu_bcurcde = @3Fcurcde, imu_basprc = @3Fbascst, imu_negprc = 0, imu_ftycst =0, 
					imu_updusr = 'UpdateUser', imu_upddat = getdate()
			where imu_cocde = 'UCP' and imu_itmno = @itmnoCond and imu_ventyp = 'D'

			--print 'IMMRKUP update(ASS)---------------------------' + @itmnoCond


		end
		else
		begin

			if (select count(*) from IMMRKUP where imu_cocde = 'UCP' and imu_itmno = @itmnoCond and imu_pckseq = @pckseqGlobal) = 0
			begin

				if(select count(*) from IMMRKUP where imu_cocde = 'UCP' and imu_itmno = @itmnoCond and imu_ventyp = 'D')= 10 
				begin

					delete from IMMRKUP where imu_cocde = 'UCP' and imu_itmno = @itmnoCond and imu_pckseq = @delpckseq and imu_pckunt = @delpckunt and imu_inrqty = @delinrqty and imu_mtrqty = @delmtrqty
					--print 'IMMRKUP delete ---------------------------'
				end	

				insert into IMMRKUP
				(	
					imu_cocde,	imu_itmno,	imu_typ,
					imu_ventyp,	imu_venno,	imu_pckseq,
					imu_pckunt, 	imu_inrqty, 	imu_mtrqty,
					imu_cft,		imu_curcde,	imu_prctrm,
					imu_relatn, 	imu_fmlopt, 	imu_ftycst,	imu_ftyprc,
					imu_bcurcde,	imu_basprc,	imu_negprc,
					imu_creusr,	imu_updusr,	imu_credat,
					imu_upddat					
				)
			values
				(
					'UCP',		@itmnoCond,	@ibi_typ,
					'D',		'0005',		@ipi_seqGen,
					@imu_pckunt, 	@imu_inrqty, 	@imu_mtrqty,
					@imu_cft,		@imu_bcurcde,	@imu_prctrm,
					@imu_relatn, 	@yvf_fmlopt,	0,		@3FftycstMarkup,		
					@3Fcurcde,	@3Fbascst,	0,
					'CreateUser'	,'UpdateUser',	Getdate(),
					Getdate()	
				)
			--print 'IMMRKUP insert----------------------------' + @itmnoCond
			
			end		
			else	
			begin			
			
			update IMMRKUP set imu_pckunt = @imu_pckunt, imu_inrqty = @imu_inrqty, imu_mtrqty = @imu_mtrqty,
					imu_cft = @imu_cft, imu_curcde = @imu_bcurcde, imu_prctrm = @imu_prctrm,
					imu_relatn = @imu_relatn, imu_fmlopt = @yvf_fmlopt, imu_ftyprc = @3FftycstMarkup, 
					imu_bcurcde = @3Fcurcde, imu_basprc = @3Fbascst, imu_negprc = 0, imu_ftycst =0, 
					imu_updusr = 'UpdateUser', imu_upddat = getdate()
			where imu_cocde = 'UCP' and imu_itmno = @itmnoCond and imu_pckseq = @pckseqGlobal

			--print 'IMMRKUP update---------------------------' + @itmnoCond

			end

		end

	end




--END while loop for ImPCKINF, IMVENPCK, IMMRKUP
FETCH NEXT FROM cur_IMPCKINF INTO 
	@ipi_itmno,	@ipi_pckseq,
	@ipi_pckunt,	@ipi_mtrqty,	@ipi_inrqty,	
	@ipi_inrhin,	@ipi_inrwin,	@ipi_inrdin,
	@ipi_inrhcm,	@ipi_inrwcm,	@ipi_inrdcm,
	@ipi_mtrhin,	@ipi_mtrwin,	@ipi_mtrdin,
	@ipi_mtrhcm,	@ipi_mtrwcm,	@ipi_mtrdcm,	
	@ipi_cft,		@ipi_cbm,		@ipi_grswgt,
	@ipi_netwgt,	@ipi_pckitr, 	@ipi_creusr,
	@ipi_updusr,	@ipi_credat,	@ipi_upddat	
END

----=========================================================================================
----=========================================================================================


--IMCOLINF-------------------------------------------------------------------------------------------------------------------------------------------

	DECLARE cur_IMCOLINF CURSOR
	FOR SELECT 
		icf_colcde,		icf_vencol,		icf_coldsc,
		icf_typ,		icf_ucpcde,	icf_eancde,
		icf_creusr,		icf_updusr,	icf_credat,
		icf_upddat

	FROM IMCOLINF WHERE icf_cocde = 'UCPP' and icf_itmno = @itmno 
 
	OPEN cur_IMCOLINF 
	FETCH NEXT FROM cur_IMCOLINF INTO 

		@icf_colcde,	@icf_vencol,	@icf_coldsc,
		@icf_typ,		@icf_ucpcde,	@icf_eancde,
		@icf_creusr,	@icf_updusr,	@icf_credat,
		@icf_upddat

	WHILE @@fetch_status = 0
	begin
--PRINT
--select 'IMCOLINF', @icf_colcde, @icf_vencol
		--Ckeck IMCOLINF is it exist value base from parameter item no.
		if(select count(*) from IMCOLINF where icf_cocde = 'UCPP' and icf_itmno = @itmno) > 0 
		begin

			
			--if (select count(*) from IMBASINF where ibi_cocde = 'UCP' and ibi_orgitm = @itmno) = 0 
			if (select count(*) from IMCOLINF where icf_cocde = 'UCP' and icf_itmno = @itmnoCond and icf_colcde = @icf_colcde) = 0 
			begin
				Set @icf_seqGen = (Select isnull(max(icf_colseq),0) +1 from imcolinf where icf_cocde ='UCP' and icf_itmno = @itmnoCond)
				insert into IMCOLINF
				(
					icf_cocde,		icf_itmno,		icf_colseq,
					icf_colcde,		icf_vencol,		icf_coldsc,
					icf_typ,		icf_ucpcde,	icf_eancde,
					icf_creusr,		icf_updusr,	icf_credat,
					icf_upddat					
				)
				values
				(	
					'UCP',		@itmnoCond,	@icf_seqGen,
					@icf_colcde,	@icf_vencol,	@icf_coldsc,
					@icf_typ,		@icf_ucpcde,	@icf_eancde,
					'CreateUser',	'UpdateUser',	getdate(),
					getdate()		
				)
--print 'IMCOLINF insert ----------------------' + @itmnoCond
			end

			else
		
			begin

				update IMCOLINF set icf_colcde = @icf_colcde, icf_vencol = @icf_vencol, icf_coldsc = @icf_coldsc,
						icf_typ = @icf_typ, icf_ucpcde = @icf_ucpcde, icf_eancde = @icf_eancde,
						icf_updusr = 'UpdateUser', icf_upddat = getdate()
				where icf_cocde = 'UCP' and icf_itmno = @itmnoCond and icf_colcde = @icf_colcde
						
--print 'IMCOLINF update ----------------------' + @itmno3F



			end
			
			
		end


	FETCH NEXT FROM cur_IMCOLINF INTO 

		@icf_colcde,	@icf_vencol,	@icf_coldsc,
		@icf_typ,		@icf_ucpcde,	@icf_eancde,
		@icf_creusr,	@icf_updusr,	@icf_credat,
		@icf_upddat
	end
	
	CLOSE cur_IMCOLINF
	DEALLOCATE cur_IMCOLINF


--------------------------------------------------------------------------------------------------------------------------------------------------------------------------



	close cur_IMPCKINF
	deallocate cur_IMPCKINF



--end while loop of IMBASINF
FETCH NEXT FROM cur_IMBASINF INTO 

			@ibi_cocde,	@ibi_itmno,	@ibi_orgitm,
			@ibi_lnecde,
			@ibi_curcde ,	@ibi_catlvl0, 	@ibi_catlvl1 ,	
			@ibi_catlvl2, 	@ibi_catlvl3, 	@ibi_catlvl4,
			@ibi_itmsts ,	@ibi_typ ,		@ibi_engdsc ,	
			@ibi_chndsc ,	@ibi_venno ,	@ibi_imgpth,		
			@ibi_hamusa,	@ibi_hameur,	@ibi_dtyusa,		
			@ibi_dtyeur,	@ibi_cosmth ,	@ibi_rmk,
			@ibi_tirtyp,	@ibi_moqctn,	@ibi_qty,	
			@ibi_moa,		@ibi_prvsts,	@ibi_creusr ,	
			@ibi_updusr,	@ibi_credat ,	@ibi_upddat
end



close cur_IMBASINF
deallocate cur_IMBASINF


END
set nocount off



GO
GRANT EXECUTE ON [dbo].[sp_Select_ITEMMASTER_bak] TO [ERPUSER] AS [dbo]
GO
