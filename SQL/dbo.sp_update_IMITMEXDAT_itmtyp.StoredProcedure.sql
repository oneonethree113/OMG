/****** Object:  StoredProcedure [dbo].[sp_update_IMITMEXDAT_itmtyp]    Script Date: 09/29/2017 15:29:08 ******/
DROP PROCEDURE [dbo].[sp_update_IMITMEXDAT_itmtyp]
GO
/****** Object:  StoredProcedure [dbo].[sp_update_IMITMEXDAT_itmtyp]    Script Date: 09/29/2017 15:29:10 ******/
SET ANSI_NULLS OFF
GO
SET QUOTED_IDENTIFIER OFF
GO











/*
=========================================================
Program ID	: 	sp_update_IMITMEXDAT_itmtyp
Description   	: 	
Programmer  	: 	PIC
ALTER  Date   	: 	
Last Modified  	: 
Table Read(s) 	:	
Table Write(s) 	:
=========================================================
 Modification History                                    
=========================================================
2012-07-16	David Yue	Replaced IMMRKUP with IMPRCINF Table
=========================================================     
*/

CREATE PROCEDURE [dbo].[sp_update_IMITMEXDAT_itmtyp] 

@cocde		nvarchar(6)

AS

DECLARE	-- IMITMEXDAT
@ied_cocde 	nvarchar(6),	@ied_venno 	nvarchar(6),	@ied_venitm 	nvarchar(20),
@ied_itmseq 	int,		@ied_recseq 	int,		@ied_mode 	nvarchar(3),
@ied_itmsts 	nvarchar(3),	@ied_stage 	nvarchar(3),	@ied_engdsc 	nvarchar(800),
@ied_chndsc 	nvarchar(1600),	@ied_lnecde 	nvarchar(10),	@ied_catlvl4	nvarchar(20),
@ied_untcde 	nvarchar(4),	@ied_inrqty 	int,		@ied_mtrqty 	int,
@ied_inrlcm 	numeric(11,4),	@ied_inrwcm 	numeric(11,4),	@ied_inrhcm 	numeric(11,4),
@ied_mtrlcm 	numeric(11,4),	@ied_mtrwcm 	numeric(11,4),	@ied_mtrhcm 	numeric(11,4),
@ied_cft 	numeric(11,4),	@ied_conftr 	int,		@ied_curcde 	nvarchar(6),
@ied_ftycst 	numeric(13,4),	@ied_ftyprc 	numeric(13,4),	@ied_prctrm 	nvarchar(10),
@ied_grswgt 	numeric(6,3),	@ied_netwgt 	numeric(6,3),	@ied_pckitr 	nvarchar(300),
@ied_ucpno	nvarchar(20),	@ied_sysmsg	nvarchar(300),	@ied_xlsfil 	nvarchar(50),		
@ied_veneml	nvarchar(50),	@ied_malsts	nvarchar(1),	@ied_chkdat	datetime,		
@ied_refresh	nvarchar(1),	@ied_prdven     nvarchar(6),	@ied_cus1no	nvarchar(10),
@ied_cus2no	nvarchar(10)	

DECLARE	--IMBOMASS
@iba_cocde	nvarchar(6),	@iba_itmno	nvarchar(20),	@iba_assitm	nvarchar(20),
@iba_colcde	nvarchar(30),	@iba_pckunt	nvarchar(6),	@iba_inrqty	int,	
@iba_mtrqty	int

DECLARE 	--TEMP
@match		nvarchar(1),
@all_match	nvarchar(1),
@a1		int,
@a2		int
 
DECLARE cur_IMITMEXDAT CURSOR
FOR 	SELECT
 		ied_cocde ,		ied_venno ,		ied_venitm ,
		ied_itmseq ,		ied_recseq ,		ied_mode ,
		ied_itmsts ,		ied_stage ,		ied_engdsc ,
		ied_chndsc ,		ied_lnecde ,		ied_catlvl4 ,
		ied_untcde ,		ied_inrqty ,		ied_mtrqty ,
		ied_inrlin ,		ied_inrwin ,		ied_inrhin ,
		ied_mtrlin ,		ied_mtrwin ,		ied_mtrhin ,
		ied_cft ,		ied_conftr ,		ied_curcde ,
		ied_ftycst ,		ied_ftyprc ,		ied_prctrm ,
		ied_grswgt ,		ied_netwgt ,		ied_pckitr ,
		ied_ucpno,		ied_sysmsg,		ied_xlsfil,		
		ied_chkdat,		ied_cus1no,		ied_cus2no,
		ied_refresh,		ied_prdven
FROM IMITMEXDAT WHERE ied_stage =  'W' and ied_itmtyp = 'AST'
ORDER BY  ied_ucpno, ied_chkdat
			
OPEN cur_IMITMEXDAT
FETCH NEXT FROM cur_IMITMEXDAT INTO 
		@ied_cocde ,		@ied_venno ,		@ied_venitm ,
		@ied_itmseq ,		@ied_recseq ,		@ied_mode ,
		@ied_itmsts ,		@ied_stage ,		@ied_engdsc ,
		@ied_chndsc ,		@ied_lnecde ,		@ied_catlvl4 ,
		@ied_untcde ,		@ied_inrqty ,		@ied_mtrqty ,
		@ied_inrlcm ,		@ied_inrwcm ,		@ied_inrhcm ,
		@ied_mtrlcm ,		@ied_mtrwcm ,		@ied_mtrhcm ,
		@ied_cft ,		@ied_conftr ,		@ied_curcde ,
		@ied_ftycst ,		@ied_ftyprc ,		@ied_prctrm ,
		@ied_grswgt ,		@ied_netwgt ,		@ied_pckitr ,
		@ied_ucpno,		@ied_sysmsg,		@ied_xlsfil,
		@ied_chkdat,		@ied_cus1no,		@ied_cus2no,
		@ied_refresh,		@ied_prdven

WHILE @@fetch_status = 0
BEGIN
	set @match = 'Y'

	select @a1 = count(*) from IMBOMASS where iba_itmno = @ied_ucpno and iba_typ = 'AST'
	
	if  @a1 <> 0
	begin
		select @a2= count(*) from IMASSEXDAT 
		where 
--			iad_venno = @ied_venno and 
--			iad_prdven = @ied_prdven and
			iad_asstno = @ied_ucpno and 
			iad_xlsfil = @ied_xlsfil and 
			iad_chkdat = @ied_chkdat and
			iad_stage = 'W'

		if 	@a1 <> @a2
		begin
			set @match = 'N'
			set @ied_stage = 'I'
			set @ied_refresh = 'N'
			set @ied_sysmsg = @ied_sysmsg + (case @ied_sysmsg when '' then @ied_ucpno + ' - the Assorted Item(s) in Item Master not match with Excel' 
		  				         else ', ' + @ied_ucpno + ' - the Assorted Item(s) in Item Master not match with Excel' end)
		end

		if @match = 'Y'
		begin
			DECLARE cur_IMBOMASS CURSOR
			FOR 	SELECT 	iba_cocde,	iba_itmno,	iba_assitm,
					iba_colcde,	iba_pckunt,	iba_inrqty,	
					iba_mtrqty
				FROM IMBOMASS
				LEFT JOIN  IMVENINF a ON
						a.ivi_venno = @ied_venno and 
						a.ivi_itmno = iba_itmno
				LEFT JOIN  IMVENINF b ON
						b.ivi_venno = @ied_venno and 
						b.ivi_itmno = iba_assitm
				WHERE 
					iba_itmno = @ied_ucpno and 
					iba_typ = 'AST'
				ORDER BY 
					iba_itmno, iba_assitm
			
			OPEN cur_IMBOMASS
			FETCH NEXT FROM cur_IMBOMASS INTO 
			@iba_cocde,	@iba_itmno,	@iba_assitm,
			@iba_colcde,	@iba_pckunt,	@iba_inrqty,	
			@iba_mtrqty
			
			WHILE @@fetch_status = 0
			BEGIN
				if (select count(*) from IMASSEXDAT 
					where
						iad_asstno = @iba_itmno and
						iad_assdno = @iba_assitm and 
						iad_colcde = @iba_colcde and
						iad_untcde = @iba_pckunt and 
						iad_inrqty = @iba_inrqty and
						iad_mtrqty = @iba_mtrqty and 
						iad_venno = @ied_venno and 
						iad_prdven = @ied_prdven and
						iad_xlsfil = @ied_xlsfil and
						iad_chkdat = @ied_chkdat and
						iad_stage = 'W') = 0
				begin
					set @match = 'N'
					set @ied_stage = 'I'
					set @ied_refresh = 'N'
					set @ied_sysmsg = @ied_sysmsg + (case @ied_sysmsg when '' then @iba_assitm + ' - the Assorted Item info in Item Master not match with Excel' 
				  				         else ', ' + @iba_assitm + ' - the Assorted Item info in Item Master not match with Excel' end)			
				end


			FETCH NEXT FROM cur_IMBOMASS INTO 
			@iba_cocde,	@iba_itmno,	@iba_assitm,
			@iba_colcde,	@iba_pckunt,	@iba_inrqty,	
			@iba_mtrqty
			
			END
			CLOSE cur_IMBOMASS
			DEALLOCATE cur_IMBOMASS
		end -- if @match = 'Y'
		
		if @match = 'N' 
		begin

			update	IMASSEXDAT 
			set 
				iad_stage = 'I' , iad_sysmsg = iad_sysmsg +  (case iad_sysmsg when '' then 'The Assorted Item not match with Item Master' 
			  				 else ', the Assorted Item not match with Item Master' end)
			where
				iad_asstno = @ied_ucpno and iad_xlsfil = @ied_xlsfil and 
				iad_chkdat = @ied_chkdat and iad_venno = @ied_venno and iad_prdven = @ied_prdven and iad_stage = 'W'

			update	IMITMEXDAT 
			set	
				ied_stage = 'I' , ied_sysmsg = @ied_sysmsg
			where	
				ied_ucpno = @ied_ucpno and ied_xlsfil = @ied_xlsfil and 
				ied_chkdat = @ied_chkdat and ied_recseq = @ied_recseq
		end
	end 

FETCH NEXT FROM cur_IMITMEXDAT INTO 
		@ied_cocde ,		@ied_venno ,		@ied_venitm ,
		@ied_itmseq ,		@ied_recseq ,		@ied_mode ,
		@ied_itmsts ,		@ied_stage ,		@ied_engdsc ,
		@ied_chndsc ,		@ied_lnecde ,		@ied_catlvl4 ,
		@ied_untcde ,		@ied_inrqty ,		@ied_mtrqty ,
		@ied_inrlcm ,		@ied_inrwcm ,		@ied_inrhcm ,
		@ied_mtrlcm ,		@ied_mtrwcm ,		@ied_mtrhcm ,
		@ied_cft ,		@ied_conftr ,		@ied_curcde ,
		@ied_ftycst ,		@ied_ftyprc ,		@ied_prctrm ,
		@ied_grswgt ,		@ied_netwgt ,		@ied_pckitr ,
		@ied_ucpno,		@ied_sysmsg,		@ied_xlsfil,
		@ied_chkdat,		@ied_veneml,		@ied_malsts,
		@ied_refresh,		@ied_prdven
END
CLOSE cur_IMITMEXDAT
DEALLOCATE cur_IMITMEXDAT

---------------------------------------------------------------------------------------------------
set @all_match = 'Y'
set @match = 'Y'

DECLARE cur_IMITMEXDAT CURSOR
FOR 	SELECT 		
		ied_cocde ,		ied_venno ,		ied_venitm ,
		ied_itmseq ,		ied_recseq ,		ied_mode ,
		ied_itmsts ,		ied_stage ,		ied_engdsc ,
		ied_chndsc ,		ied_lnecde ,		ied_catlvl4 ,
		ied_untcde ,		ied_inrqty ,		ied_mtrqty ,
		ied_inrlin ,		ied_inrwin ,		ied_inrhin ,
		ied_mtrlin ,		ied_mtrwin ,		ied_mtrhin ,
		ied_cft ,		ied_conftr ,		ied_curcde ,
		ied_ftycst ,		ied_ftyprc ,		ied_prctrm ,
		ied_grswgt ,		ied_netwgt ,		ied_pckitr ,
		ied_ucpno,		ied_sysmsg,		ied_xlsfil,		
		ied_chkdat,		ied_cus1no,		ied_cus2no,
		ied_refresh,		ied_prdven
FROM IMITMEXDAT 
WHERE ied_stage =  'W' and ied_mode = 'UPD' and ied_ucpno in
	(select distinct ibd_ucpno from IMBOMEXDAT where ibd_stage = 'W')
ORDER BY  ied_ucpno, ied_chkdat
			
OPEN cur_IMITMEXDAT
FETCH NEXT FROM cur_IMITMEXDAT INTO 
		@ied_cocde ,		@ied_venno ,		@ied_venitm ,
		@ied_itmseq ,		@ied_recseq ,		@ied_mode ,
		@ied_itmsts ,		@ied_stage ,		@ied_engdsc ,
		@ied_chndsc ,		@ied_lnecde ,		@ied_catlvl4 ,
		@ied_untcde ,		@ied_inrqty ,		@ied_mtrqty ,
		@ied_inrlcm ,		@ied_inrwcm ,		@ied_inrhcm ,
		@ied_mtrlcm ,		@ied_mtrwcm ,		@ied_mtrhcm ,
		@ied_cft ,		@ied_conftr ,		@ied_curcde ,
		@ied_ftycst ,		@ied_ftyprc ,		@ied_prctrm ,
		@ied_grswgt ,		@ied_netwgt ,		@ied_pckitr ,
		@ied_ucpno,		@ied_sysmsg,		@ied_xlsfil,
		@ied_chkdat,		@ied_cus1no,		@ied_cus2no,
		@ied_refresh,		@ied_prdven
WHILE @@fetch_status = 0
BEGIN

		declare @c1 int, @c2 int

		select @c1 =  count(*) from IMBOMASS where 
					iba_itmno = @ied_ucpno and 
					iba_typ = 'BOM'


		select  @c2 = count(*) from IMBOMEXDAT where 
					ibd_ucpno = @ied_ucpno and 
					ibd_xlsfil = @ied_xlsfil and 
					ibd_chkdat = @ied_chkdat and 
					ibd_stage = 'W'

		if @c1 <> @c2
		begin
			if @c1 = 0 
			begin
				set @match = 'N'
				set @ied_stage = 'I'
				set @ied_refresh = 'N'
				set @ied_sysmsg = @ied_sysmsg + (case @ied_sysmsg when '' then @ied_ucpno + ' - Cannot attach BOM item to REG without BOM previously' 
			  				         else ', ' + @ied_ucpno + ' - Cannot attach BOM item to REG without BOM previously' end)
			end
			else
			begin
				set @match = 'N'
				set @ied_stage = 'I'
				set @ied_refresh = 'N'
				set @ied_sysmsg = @ied_sysmsg + (case @ied_sysmsg when '' then @ied_ucpno + ' - the BOM Item in Item Master not match with Excel' 
			  				         else ', ' + @ied_ucpno + ' - the BOM Item in Item Master not match with Excel' end)
			end
		end	

		if @match = 'Y'
		begin
			DECLARE cur_IMBOMASS CURSOR
			FOR 	SELECT 
					iba_cocde,	iba_itmno,	iba_assitm,
					iba_colcde,	iba_pckunt,	iba_inrqty,	
					iba_mtrqty
				FROM IMBOMASS
				LEFT JOIN  IMVENINF a ON
						a.ivi_venno = @ied_venno and 
						a.ivi_itmno = iba_itmno
				LEFT JOIN  IMVENINF b ON
						b.ivi_venno = @ied_venno and 
						b.ivi_itmno = iba_assitm
				WHERE 
					iba_itmno = @ied_ucpno and 
					iba_typ = 'BOM'
--					iba_typ = 'AST'
				ORDER BY 
					iba_itmno, iba_assitm
			
			OPEN cur_IMBOMASS
			FETCH NEXT FROM cur_IMBOMASS INTO 
				@iba_cocde,	@iba_itmno,	@iba_assitm,
				@iba_colcde,	@iba_pckunt,	@iba_inrqty,	
				@iba_mtrqty
			
			WHILE @@fetch_status = 0
			BEGIN
				if (select count(*) from IMBOMEXDAT where  
					ibd_ucpno = @iba_itmno and
					ibd_bomno = @iba_assitm and 
					ibd_colcde = @iba_colcde and
					ibd_untcde = @iba_pckunt and 
					--ibd_inrqty = @iba_inrqty and
					--ibd_mtrqty = @iba_mtrqty and 
					--ibd_venno = @ied_venno and 
					--ibd_prdven = @ied_prdven and 
					ibd_xlsfil = @ied_xlsfil and
					ibd_chkdat = @ied_chkdat) = 0
				begin
					set @match = 'N'
					set @ied_stage = 'I'
					set @ied_refresh = 'N'
					set @ied_sysmsg = @ied_sysmsg + (case @ied_sysmsg when '' then @iba_assitm + ' - the BOM Item in Item Master not match with Excel' 
				  				         else ', ' + @iba_assitm + ' - the BOM Item in Item Master not match with Excel' end)
				end
	
			FETCH NEXT FROM cur_IMBOMASS INTO 
			@iba_cocde,	@iba_itmno,	@iba_assitm,
			@iba_colcde,	@iba_pckunt,	@iba_inrqty,	
			@iba_mtrqty
			
			END
			CLOSE cur_IMBOMASS
			DEALLOCATE cur_IMBOMASS
		end

		if @match = 'N' 
		begin			
			update	IMITMEXDAT 
			set	
				ied_stage = 'I' , 
				ied_sysmsg = @ied_sysmsg
			where	
				ied_ucpno = @ied_ucpno and 
				ied_xlsfil = @ied_xlsfil and 
				ied_chkdat = @ied_chkdat and
--					ied_venno = @ied_venno and 
--					ied_prdven = @ied_prdven and 
--					ied_cus1no = @ied_cus1no and 
--					ied_cus2no = @ied_cus2no and	
				ied_recseq = @ied_recseq	


			update	IMITMEXDAT 
			set	
				ied_stage = 'I' , 
				ied_sysmsg = @ied_sysmsg
			where	
				ied_ucpno = @ied_ucpno and 
				ied_xlsfil = @ied_xlsfil and 
				ied_chkdat = @ied_chkdat and
				ied_mode = 'NEW'			
		end


FETCH NEXT FROM cur_IMITMEXDAT INTO 
		@ied_cocde ,		@ied_venno ,		@ied_venitm ,
		@ied_itmseq ,		@ied_recseq ,		@ied_mode ,
		@ied_itmsts ,		@ied_stage ,		@ied_engdsc ,
		@ied_chndsc ,		@ied_lnecde ,		@ied_catlvl4 ,
		@ied_untcde ,		@ied_inrqty ,		@ied_mtrqty ,
		@ied_inrlcm ,		@ied_inrwcm ,		@ied_inrhcm ,
		@ied_mtrlcm ,		@ied_mtrwcm ,		@ied_mtrhcm ,
		@ied_cft ,		@ied_conftr ,		@ied_curcde ,
		@ied_ftycst ,		@ied_ftyprc ,		@ied_prctrm ,
		@ied_grswgt ,		@ied_netwgt ,		@ied_pckitr ,
		@ied_ucpno,		@ied_sysmsg,		@ied_xlsfil,
		@ied_chkdat,		@ied_cus1no,		@ied_cus2no,
		@ied_refresh,		@ied_prdven
END
CLOSE cur_IMITMEXDAT
DEALLOCATE cur_IMITMEXDAT

if @match = 'N' 
begin
	update 
		IMBOMEXDAT 
	set 
		ibd_stage = 'I' , 
		ibd_sysmsg = ibd_sysmsg +  (case ibd_sysmsg when '' then 'The BOM Item not match with Item Master'  else ', the BOM Item not match with Item Master' end)
	where 
		ibd_ucpno = @ied_ucpno and 
		ibd_xlsfil = @ied_xlsfil and 
		ibd_chkdat = @ied_chkdat
--	           	ibd_venno = @ied_venno and 
--		ibd_prdven = @ied_prdven

end

-- Check Multiple DV for same item wait for approve
CREATE TABLE #ItmDv(
tmp_ucpno char(20),
tmp_venno char(6) )

INSERT INTO #ItmDv (tmp_ucpno, tmp_venno)
select distinct ied_ucpno, ied_venno from imitmexdat where ied_stage = 'W'

update	IMITMEXDAT 
set	
	ied_stage = 'I' , 
	ied_sysmsg = ied_sysmsg +  (case ied_sysmsg when '' then 'Multiple DV for same item wait for approve'  else ', Multiple DV for same item wait for approve' end)
where 
	ied_ucpno in
	(
		select tmp_ucpno from #ItmDv group by tmp_ucpno having count(*) > 1
	)


-- Check DV <> PV
Update	IMITMEXDAT
Set	ied_stage = 'I' , 
	ied_sysmsg = ied_sysmsg +  (case ied_sysmsg when '' then 'Missing DV = PV'  else ', Missing DV = PV' end)
From	IMPRCINF
Where	not exists
	(
		select imu_itmno from IMPRCINF where imu_itmno = ied_ucpno and imu_venno = ied_venno and imu_prdven = ied_venno
	)
	and ied_venno <> ied_prdven
	and ied_stage = 'W'	


	
--select imu_itmno, imu_itmprc from immrkup group by imu_itmno, imu_itmprc having count(*) > 1









GO
GRANT EXECUTE ON [dbo].[sp_update_IMITMEXDAT_itmtyp] TO [ERPUSER] AS [dbo]
GO
