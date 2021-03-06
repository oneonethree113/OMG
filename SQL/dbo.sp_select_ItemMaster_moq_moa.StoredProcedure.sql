/****** Object:  StoredProcedure [dbo].[sp_select_ItemMaster_moq_moa]    Script Date: 09/29/2017 15:29:09 ******/
DROP PROCEDURE [dbo].[sp_select_ItemMaster_moq_moa]
GO
/****** Object:  StoredProcedure [dbo].[sp_select_ItemMaster_moq_moa]    Script Date: 09/29/2017 15:29:10 ******/
SET ANSI_NULLS OFF
GO
SET QUOTED_IDENTIFIER OFF
GO







/*
=========================================================
Description   	: sp_select_ItemMaster_moq_moa
Programmer  	: Allan Yuen
Create Date   	: 
Last Modified  	: 2004-09-22
Table Read(s) 	:
Table Write(s) 	:
=========================================================
 Modification History                                    
=========================================================
 Date      		Initial  		Description                          
=========================================================     
*/	


CREATE PROCEDURE [dbo].[sp_select_ItemMaster_moq_moa] 

@cocde nvarchar(6),
@cus1no NVARCHAR(6),
@cus2no NVARCHAR(6),
@itmno NVARCHAR(20),
@um NVARCHAR(6),
@conftr numeric(9),
@master integer,
@inner integer,
@scflag char(1) = 'N',
@logicflag char(3) = 'NEW',
@qty integer = 0

AS

set nocount on 

declare
@catlvl0 nvarchar(20),
@catlvl1 nvarchar(20),
@catlvl2 nvarchar(20),
@catlvl3 nvarchar(20),
@catlvl4 nvarchar(20),
@ibi_curcde nvarchar(6),
@ibi_moa numeric(20,4),
@ibi_moq integer,
@ibi_typ nvarchar(4),
@cus1no_moa_flag char(1),
@cus1no_moq_flag char(1),
@cus2no_moa_flag char(1),
@catlvl0_flag char(1),
@catlvl1_flag char(1),
@catlvl2_flag char(1),
@catlvl3_flag char(1),
@catlvl4_flag char(1),
@moq integer,
@moa numeric(20,4),
@alias  varchar(20),
@asscount integer,
@ibi_tirtyp char(1),
@ret_moq integer,
@ret_moqchg integer,
@ret_moa numeric(20,4),
@ret_curcde nvarchar(6),
@yco_moq integer,
@yco_moa numeric(20,4),
@yco_curcde nvarchar(6),
@ordqty integer ,
@ctn integer,
@tmpctn integer,
@ventyp  char(1),
@alsitmno nvarchar(20)

set @ordqty = 1
SET @cus2no_moa_flag  = 'X'

set @alsitmno  = ''


/*
Handle the alsitmno of alsitmno or mnay layer of alsitmno
Looping to get the current Item No.
*/
--------------------------------------------------
declare @counter int
set @counter = 0

while @counter <> 1
begin
	if (select count(*) from imbasinf where ibi_alsitmno =  @itmno) > 0 
	begin
		set @alsitmno = (select  top 1 ibi_itmno from imbasinf where ibi_alsitmno = @itmno )
		if @alsitmno <> '' 
		begin
			set @itmno = @alsitmno
		end
		else
		begin
			set @counter = 1
		end
	end
	else
	begin
		set @counter = 1
	end
end

-- Get Vendor Type --
select 	
	@VENTYP = VBI_VENTYP
	from	
		IMVENINF
		LEFT JOIN VNBASINF ON IVI_VENNO = VBI_VENNO
	where
		ivi_def = 'Y' and ivi_itmno = @itmno
--------------------------

-- Get Conversion Factory --
if @um <> 'PC' 
BEGIN
	SELECT 
		@ordqty  = ISNULL(ycf_value,1)
	FROM
		SYCONFTR
	where 
		ycf_cocde = ' ' and
		ycf_code1 = @UM  and
		ycf_code2 = 'PC'
END

SET @ordqty = @ordqty * @conftr
SET @ordqty = @ordqty  * @master

-- Get Company Defined MOQ/MOA --
select
	@yco_moq =  yco_moq ,
	@yco_moa = yco_moa, 
	@yco_curcde = yco_curcde 
from
	SYCOMINF
where
	yco_cocde = @cocde 

-- Get Primary Customer MOA charge flag --
SELECT 
	@cus1no_moa_flag  = cpi_moachgflg,
	@cus1no_moq_flag =  cpi_moqchgflg
from 
	cuprcinf 
where 
	cpi_cusno = @CUS1NO 

-- Get Secondary Customer MOA charge flag --
if ltrim(rtrim(@CUS2NO)) <> '' 
begin
SELECT 
	@cus2no_moa_flag = cpi_moachgflg
from 
	cuprcinf 
where 
	cpi_cusno = @CUS2NO 
end

-- Get Item Master Information ---
if (select count(*) from imbasinf where ibi_alsitmno = @itmno) > 0
begin 	
	set @alias = (select  ibi_itmno from imbasinf where ibi_alsitmno = @itmno )
end
else
begin 
	set @alias = ''
end

--- Get MOQ/MOA from IMBASINF  
select
	@catlvl0 = ibi_catlvl0,
	@catlvl1 = ibi_catlvl1,
	@catlvl2 = ibi_catlvl2,
	@catlvl3 = ibi_catlvl3,
	@catlvl4 = ibi_catlvl4,
	@ibi_curcde = ibi_curcde,
	@ibi_moa = ibi_moa,
	@ibi_moq = ibi_moqctn,
	@ibi_typ = ibi_typ,
	@ibi_tirtyp  = ibi_tirtyp 
from
	imbasinf 
where
	ibi_itmno =  (case @alias when '' then @itmno else @alias end)

--- Get MOQ/MOA from IMMOQMOA
--- If  exist for Customer Group
select  
	@ibi_tirtyp = imm_tirtyp,  
	@ibi_curcde = imm_curcde,  
	@ibi_moa = imm_moa,  
	@ibi_moq = imm_moqctn
from  
	immoqmoa
where  
	imm_itmno = (	case @alias	when '' then	@itmno
				else		@alias
			end)							and
	imm_cus1no = (	select	case @VENTYP	when 'E' then	cbi_cugrptyp_ext
						else		cbi_cugrptyp_int
				end as 'cbi_cugrptyp'
			from	cubasinf
			where	cbi_cusno = @cus1no)					and
	imm_cus2no = '' 

--- If exist for Primary Customer
select  
	@ibi_tirtyp = imm_tirtyp,  
	@ibi_curcde = imm_curcde,  
	@ibi_moa = imm_moa,  
	@ibi_moq = imm_moqctn
from  
	immoqmoa
where  
	imm_itmno = (	case @alias	when '' then	@itmno
				else		@alias
			end)					and
	imm_cus1no = @cus1no					and
	imm_cus2no = '' 

--- If exist for Primary Customer and Secondary Customer
select  
	@ibi_tirtyp = imm_tirtyp,  
	@ibi_curcde = imm_curcde,  
	@ibi_moa = imm_moa,  
	@ibi_moq = imm_moqctn
from  
	immoqmoa
where  
	imm_itmno = (	case @alias	when '' then	@itmno
				else		@alias
			end)					and
	imm_cus1no = @cus1no					and
	imm_cus2no = @cus2no

if ltrim(rtrim(@ibi_typ))  = 'ASS' 
begin
	select 
		@asscount = count(1) 
	from 
		imbomass 
	where
		iba_itmno =  (case @alias when '' then @itmno else @alias end) and
		iba_typ = 'ASS'

	--- Cater some assortment item don't have any assorted item.
	if @asscount = 0 
		set @asscount = 1	
end
else
begin
	set @asscount = 1
end

-- Get Category Information --
select @catlvl0_flag  = ycc_fflag from sycatcde where ycc_catcde = @catlvl0 and ycc_level = 0
select @catlvl1_flag  = ycc_fflag from sycatcde where ycc_catcde = @catlvl1 and ycc_level = 1
select @catlvl2_flag  = ycc_fflag from sycatcde where ycc_catcde = @catlvl2 and ycc_level = 2
select @catlvl3_flag  = ycc_fflag from sycatcde where ycc_catcde = @catlvl3 and ycc_level = 3
select @catlvl4_flag  = ycc_fflag from sycatcde where ycc_catcde = @catlvl4 and ycc_level = 4

set @ret_moa = 0
set @ret_moq = 0
set @ret_moqchg = 0

if (@scflag = 'N' and @logicflag = 'NEW' ) or (@scflag = 'Y' and @logicflag = 'NEW' ) 
begin
	---- Processing the MOQ / MOA ----
	if @ventyp <> 'E' and @IBI_TIRTYP = '1'  and -- Only apply for standard tier --
	(@catlvl0_flag = 'Y' OR @catlvl1_flag = 'Y' OR @catlvl2_flag = 'Y' OR @catlvl3_flag = 'Y' OR @catlvl4_flag = 'Y' ) or 
	(@cus1no_moa_flag = 'Y' AND @cus2no_moa_flag  = 'X') OR (@cus1no_moa_flag = 'Y' AND @cus2no_moa_flag  = 'Y') OR (@cus1no_moa_flag = 'N' AND @cus2no_moa_flag  = 'Y')
	BEGIN
		if @catlvl0_flag = 'Y' OR @catlvl1_flag = 'Y' OR @catlvl2_flag = 'Y' OR @catlvl3_flag = 'Y' OR @catlvl4_flag = 'Y'  
		begin
			-- New MOQ / MOA Charge --
			IF @catlvl4_flag = 'Y' 
			BEGIN 
				select 
					@ret_curcde = 'USD',
					@ret_moa = ycc_moa,
					@ret_moq = ycc_moq
				from  
					sycatcde 
				where 
					ycc_catcde = @catlvl4 and 
					ycc_level = 4
			END
			ELSE
			IF @catlvl3_flag = 'Y' 
			BEGIN 
				select 
					@ret_curcde = 'USD',
					@ret_moa = ycc_moa,
					@ret_moq = ycc_moq
				from  
					sycatcde 
				where 
					ycc_catcde = @catlvl3 and 
					ycc_level = 3
			END
			ELSE
			IF @catlvl2_flag = 'Y' 
			BEGIN 
				select 
					@ret_curcde = 'USD',
					@ret_moa = ycc_moa,
					@ret_moq = ycc_moq
				from  
					sycatcde 
				where 
					ycc_catcde = @catlvl2 and 
					ycc_level = 2
			END
			ELSE
			IF @catlvl1_flag = 'Y' 
			BEGIN 
				select 
					@ret_curcde = 'USD',
					@ret_moa = ycc_moa,
					@ret_moq = ycc_moq
				from  
					sycatcde 
				where 
					ycc_catcde = @catlvl1 and 
					ycc_level = 1
			END
			ELSE
			IF @catlvl0_flag = 'Y' 
			BEGIN 
				select 
					@ret_curcde = 'USD',
					@ret_moa = ycc_moa,
					@ret_moq = ycc_moq
				from  
					sycatcde 
				where 
					ycc_catcde = @catlvl0 and 
					ycc_level = 0
		       	END
		end
		else
		begin
			if @ret_moa = 0 and @ret_moq = 0 
			begin
				IF @IBI_TIRTYP = '2'
				-- Company Define MOQ/MOA --
				BEGIN
					set @ret_curcde  = @ibi_curcde 
					set @ret_moq = @ibi_moq 
					set @ret_moa = @ibi_moa 
				END
				ELSE
				-- Standard Tier MOQ/MOA --
				BEGIN
					set @ret_moa = 0
					set @ret_curcde = ''
					set @ret_moq = 0
					------------------------------
					select top 1 	
						@ret_moq  = yts_moq
					from	
						IMVENINF
						left join 	SYTIESTR on	
							ivi_venno = yts_venno 	and 
							yts_tirtyp = 'M'		and
							yts_qtyfr <= @ordqty 		and 	
							yts_qtyto >= @ordqty		and
							yts_itmtyp = (case @ibi_typ when  'ASS' then 'A' else 'R' end)
					where
							ivi_itmno = (case @alias when '' then @itmno else @alias end) and 
							ivi_def = 'Y'
					order by
							yts_effdat desc
					------------------------------
					if @ret_moq  = 0
					begin
						set @ret_moq = @yco_moq
						set @ret_moa = @yco_moa 
						set @ret_curcde = @yco_curcde 
					end
				END
			end
		end
	END
	ELSE
	BEGIN
		IF @IBI_TIRTYP = '2'
	     	-- Company Define MOQ/MOA --
	     	BEGIN
			set @ret_curcde  = @ibi_curcde 
			set @ret_moq = @ibi_moq 
			set @ret_moa = @ibi_moa 
		END
		ELSE
		-- Standard Tier MOQ/MOA --
		BEGIN
			set @ret_moa = 0
			set @ret_curcde = ''
			set @ret_moq = 0
			------------------------------
			if @ventyp <> 'E'  -- Checking vendor type --	
			begin
				select 	
					top 1
					@ret_moq  = yts_moq
				from	
					IMVENINF
					left join 	SYTIESTR on	
						ivi_venno = yts_venno 	and 
						yts_tirtyp = 'M'		and
						@ordqty >= yts_qtyfr 	 	and 	
						@ordqty <= yts_qtyto  	and
						yts_itmtyp = (case @ibi_typ when  'ASS' then 'A' else 'R' end)
				where
						ivi_itmno = (case @alias when '' then @itmno else @alias end) and 
						ivi_def = 'Y' 
				order by 
						yts_effdat desc
			end
			else
			begin
				--- For External Vendor, force use vendor A's MOQ information ---
				select 	
					@ret_moq  = yts_moq
				from	
					SYTIESTR 	
				where
					yts_venno = '0005'		and 
					yts_tirtyp = 'M'		and
					@ordqty >= yts_qtyfr 		and 	
					@ordqty <= yts_qtyto  	and
					yts_itmtyp = (case @ibi_typ when  'ASS' then 'A' else 'R' end) 
			end
			------------------------------
			if @ret_moq  = 0
			begin
				set @ret_moq = @yco_moq
				set @ret_moa = @yco_moa 
				set @ret_curcde = @yco_curcde 
			end
		END
	END
end
else
begin
	-- Calculate the number of carton --	
	if @qty <> 0 
	begin
		set @ctn = @qty / @master	
	end

	IF @IBI_TIRTYP = '2'
	     -- Company Define MOQ/MOA --
	BEGIN
		set @ret_curcde  = @ibi_curcde 
		set @ret_moq = @ibi_moq 
		set @ret_moa = @ibi_moa 
	END
	ELSE
	-- Standard Tier MOQ/MOA --
	BEGIN
		set @ret_moa = 0
		set @ret_curcde = ''
		set @ret_moq = 0
		------------------------------
		if @ibi_typ  = 'ASS' 
			set @tmpctn = @ctn / @asscount
		else
			set @tmpctn = @ctn 
		
		if @tmpctn < 1 
			set @tmpctn = 1
				
		if @ventyp <> 'E'  -- Checking vendor type --
		begin
			select 	
				@ret_moq  = yts_moq,
				@ret_moqchg = yts_moqchg
			from	
				IMVENINF
				left join 	SYTIESTR on	
					ivi_venno = yts_venno 	and 
					yts_tirtyp = 'M'		and
					@ordqty >= yts_qtyfr 		and 	
					@ordqty <= yts_qtyto  	and
					yts_itmtyp = (case @ibi_typ when  'ASS' then 'A' else 'R' end) and
					@tmpctn >= yts_moqchgfr   	and 	
					@tmpctn <= yts_moqchgto 
			where
					ivi_itmno = (case @alias when '' then @itmno else @alias end) and 
					ivi_def = 'Y'
		end
		else
		begin
			--- For External Vendor, force use vendor A's MOQ information ---
			select 	
				@ret_moq  = yts_moq
			from	
				SYTIESTR 	
			where
				yts_venno = '0005'	and 
				yts_tirtyp = 'M'		and
				@ordqty >= yts_qtyfr 		and 	
				@ordqty <= yts_qtyto  	and
				yts_itmtyp = (case @ibi_typ when  'ASS' then 'A' else 'R' end) 
		end
		------------------------------
		if @ret_moq  = 0
		begin
			set @ret_moq = @yco_moq
			set @ret_moa = @yco_moa 
			set @ret_curcde = @yco_curcde 
		end
	END
end

if @VENTYP <> 'E'
begin
	set @ret_moa = @ret_moa  * @asscount 
	set @ret_moq = @ret_moq  * @asscount 
end

SELECT 
	@ret_moq as 'MOQ',
	@ret_moa as 'MOA',
	@ret_curcde as 'CURCDE',
	@ret_moqchg as 'MOQCHG'


set nocount off




GO
GRANT EXECUTE ON [dbo].[sp_select_ItemMaster_moq_moa] TO [ERPUSER] AS [dbo]
GO
