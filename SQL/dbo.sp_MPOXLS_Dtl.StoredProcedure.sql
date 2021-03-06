/****** Object:  StoredProcedure [dbo].[sp_MPOXLS_Dtl]    Script Date: 09/29/2017 15:29:09 ******/
DROP PROCEDURE [dbo].[sp_MPOXLS_Dtl]
GO
/****** Object:  StoredProcedure [dbo].[sp_MPOXLS_Dtl]    Script Date: 09/29/2017 15:29:10 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO







/*
=========================================================
Program ID	: sp_MPOXLS_Dtl
Description   	: 
Programmer  	: Lester Wu
ALTER  Date   	:
Last Modified  	: 
Table Read(s) 	:
Table Write(s) 	:
=========================================================
 Modification History                                    
=========================================================
Date		Author		Description
=========================================================     
20050928	Allan Yuen	Add update item price's 
*/


CREATE    procedure [dbo].[sp_MPOXLS_Dtl]
--XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX
-- When add a field here, please duplicate in the other 2 places
-- 1. 
-- 2. 
--XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX
@Mxd_PONo	as varchar(20),
@Mxd_POSeq	as int,
@Mxd_ReqNo	as varchar(10),
@Mxd_ShpDat	as datetime,
@Mxd_ItmNo	as varchar(20),
@Mxd_ItmNam	as nvarchar(60),
@Mxd_ItmDsc	as nvarchar(30),
@Mxd_ColCde	as varchar(14),
@Mxd_UM	as varchar(5),	     	     
@Mxd_Qty	as numeric(9,2),
@Mxd_UntPrc	as numeric(18,4),    
@Mxd_PckMth	as nvarchar(8),	     	     
@Mxd_Dept	as nvarchar(10),	     	     
@Mxd_PrdNo	as varchar(100),
@Mxd_Rmk	as nvarchar(400),
@Mxd_UpdFlg	as varchar(3),
@FileName	as nvarchar(50),
@DUMMY	as char(1)

as
BEGIN
	--XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX
	-- CHECK EXIST -- 2
	--XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX
	Declare 
		@tmp_ReqNo	as varchar(10),
		@tmp_ShpDat	as datetime,
		@tmp_ItmNo	as varchar(20),
		@tmp_ItmNam	as nvarchar(60),
		@tmp_ItmDsc	as nvarchar(30),
		@tmp_ColCde	as varchar(14),
		@tmp_UM	as varchar(5),	     	     
		@tmp_Qty	as numeric(9,2),
		@tmp_UntPrc	as numeric(18,4),    
		@tmp_PckMth	as nvarchar(8),	     	     
		@tmp_Dept	as nvarchar(10),	     	     
		@tmp_PrdNo	as varchar(100),
		@tmp_Rmk	as nvarchar(400)
	
	--XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX




	Declare 	
		@errMsg as nvarchar(200) ,
		@Flag as char(1) ,
		@MPO as varchar(20) , 
		@OrdQty as numeric(9,2),
		@ShpQty as numeric(9,2) ,
		@UntPrc as numeric(18,4) , 		
		@VenNo as varchar(30) ,
		@ItmNo as varchar(30),
		@curr as varchar(6),
		@Zil_UM as varchar(5),
		@Zil_Curr as varchar(6),
		@Zil_UnitPrc as numeric(13,4),
		@Zil_Remark varchar(100),
		@MaxSeqNo int

	-------------------------------------------------------
	--Lester Wu 2006-04-26
	-------------------------------------------------------
	Declare 
		@changeLog as varchar(200)

	set @changeLog = ''
	-------------------------------------------------------
		
	set @errMsg = ''
	set @Flag = 'N'	--NEW

	set @MPO = ''
	set @OrdQty = 0
	set @ShpQty = 0
	set @VenNo = ''
	set @ItmNo = ''
	set @UntPrc = 0
	set @curr = ''

	--- Get Currency ---
	select @curr  = isnull(mxh_curr,'')  from MPOXLShdr  where mxh_pono = @Mxd_PONo
	if ltrim(rtrim(@curr))   = ''  select @curr  = mxh_curr  from MPOEXPHDR where mxh_pono = @Mxd_PONo
	-----------------------

-- +++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
-- +++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++

	if @Mxd_ItmNo <> '' and @Mxd_ItmNam <> '' 
	begin
		Select 1 from ZSITMLST where zil_itmno = @Mxd_ItmNo
		if @@rowcount = 0 
		begin
			
			insert into 
				ZSITMLST 
				(
					Zil_ItmNo, 	Zil_ItmNam, 	Zil_ItmDesc, 
					Zil_CatCde1, 	Zil_CatCde2, 	Zil_Moq, 
					Zil_MtyBy, 	Zil_UM ,		Zil_CUR,
					Zil_PRC ,		Zil_CUSTUM,	Zil_CreDat, 
					Zil_CreUsr, 	Zil_UpdDat, 	Zil_UpdUsr
				)
			values 
				(
					@Mxd_ItmNo,	@Mxd_ItmNam,	@Mxd_ItmDsc,
					'',		'',		0,
					1,		@Mxd_UM,	@curr, 
					@Mxd_UntPrc,	'KG',		getdate(),
					'XML UPLOAD',	getdate(),		'XML UPLOAD'
				)
		end
		else
		begin 
			--- Update Item Price ---
			Select 1 from ZSITMLST where zil_itmno = @Mxd_ItmNo and Zil_prc = 0
			IF @@ROWCOUNT = 1 
				begin
					update 
						ZSITMLST 
					set 
						Zil_UM  = @Mxd_UM,
						Zil_CUR = @curr, 
						Zil_PRC = @Mxd_UntPrc,
						--Zil_CUSTUM = 'KG',
						Zil_UpdDat = getdate(), 
						Zil_UpdUsr = 'XML UPLOAD'
					where 
						Zil_ItmNo = @Mxd_ItmNo 
				end
			else
				--- Exception ---
				begin
					select
						@Zil_UM =  Zil_UM,
						@Zil_Curr = Zil_Cur,
						@Zil_UnitPrc = Zil_Prc
					from
						ZSITMLST 
					where
						zil_itmno = @Mxd_ItmNo 
		
					set @Zil_Remark = ''
		
					if @Zil_UM <>  @Mxd_UM
					   begin 
					   	set @Zil_Remark = 'UM Not Match'
					    end
			
					if @Zil_CURR <>  @CURR
					    begin
						if ltrim(rtrim(@Zil_Remark)) = '' 
						    begin 
						    	set @Zil_Remark = 'Currency Not Match'
						    end
						else
						    begin
						    	set @Zil_Remark = @Zil_Remark  + ', Currency Not Match'
						     end
					    end	
		
					if @Zil_UnitPrc <>  @Mxd_UntPrc
					    begin
						if ltrim(rtrim(@Zil_Remark)) = '' 
						    begin 
						    	set @Zil_Remark = 'Unit Price  Not Match'
						    end
						else
						    begin 
						    	set @Zil_Remark = @Zil_Remark  + ', Unit Price Not Match'
						    end
					    end			
					
					IF LTRIM(RTRIM(@Zil_Remark)) <> '' 
					begin
						SELECT @MaxSeqNo  = isnull(MAX(Zid_Seqno),0)  + 1 FROM ZSITMDAT WHERE Zid_Itmno = @Mxd_ItmNo 
	
						INSERT INTO ZSITMDAT
						(Zid_Itmno, Zid_Seqno, Zid_Stage, Zid_UM, Zid_Curr, Zid_UnitPrc, Zid_MPONO, Zid_Remark, Zid_CreDat, Zid_CreUsr, Zid_UpdDat, Zid_UpdUsr)
						VALUES 
						(
							@Mxd_ItmNo,	@MaxSeqNo ,
							'W',		@Mxd_UM,
							@CURR,		@Mxd_UntPrc,
							@Mxd_PONo,	@Zil_Remark,
							convert(varchar(19),GETDATE(),121),	'SYSTEM',
							convert(varchar(19),GETDATE(),121),	'SYSTEM'
						)
					end
							
				end
		end
	end

-- +++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
-- +++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++

	if Upper(@Mxd_UpdFlg) <> 'DEL'  and  ltrim(rtrim(isnull(@Mxd_ItmNo,'')))= ''
	begin
		set @errMsg = @errMsg +  case len(@errMsg) when 0 then '' else ' | ' end + 'Item # Empty'
		set @Flag = 'R'
	end

	if Upper(@Mxd_UpdFlg) <> 'DEL' and isnull(@Mxd_UntPrc,0) <= 0 
	begin
		set @errMsg = @errMsg +   case len(@errMsg) when 0 then '' else ' | ' end + 'Unit Price Invalid'
		set @Flag = 'R'
	end

	if Upper(@Mxd_UpdFlg) <> 'DEL' and (isnull(@Mxd_ShpDat,'') = '' or @Mxd_ShpDat = '1900/01/01')
	begin
		set @errMsg = @errMsg +   case len(@errMsg) when 0 then '' else ' | ' end + 'Ship Date Invalid'
		set @Flag = 'R'
	end
	/*
	else if Upper(@Mxd_UpdFlg) <> 'DEL' 
	begin
		-- Add Logic to Check Modify Ship Date Less Than Previous Ship Date
	end
	*/
	
	if Upper(@Mxd_UpdFlg) <> 'DEL' and isnull(@Mxd_Qty,0) = 0
	begin
		set @errMsg = @errMsg +   case len(@errMsg) when 0 then '' else ' | ' end + 'Zero Ord Qty'
		set @Flag = 'R'
	end
	
	if Upper(@Mxd_UpdFlg) <> 'DEL' and isnull(@Mxd_UM,'') = ''
	begin
		set @errMsg = @errMsg +   case len(@errMsg) when 0 then '' else ' | ' end + 'UM Empty'
		set @Flag = 'R'
	end

	
	select @MPO = max(isnull(Mxd_MPONo,'')) from MPOXLSDTL where Mxd_PONo = @Mxd_PONo and Mxd_POSeq = @Mxd_POSeq
-- Added by Mark Lau 20090803
and mxd_credat >= '2009-01-01'
--	select @MPO, @Flag

--	if (@Flag <> 'E' or @Flag <> 'R') and isnull(@MPO,'') = '' 
	if @Flag <> 'R' and isnull(@MPO,'') = '' 
	begin
		--set @errMsg = @errMsg +   case len(@errMsg) when 0 then '' else ' | ' end + 'Existing Record Marked "Old"'
		if upper(@Mxd_UpdFlg) = 'DEL'
		begin
			set @Flag = 'D'
		end
		--update MPOXLSDTL set Mxd_MPOFlg = 'O' where Mxd_PONo = @Mxd_PONo and Mxd_POSeq = @Mxd_POSeq and Mxd_MPOFlg <> 'G'
	end
	else if @Flag <> 'R'
	begin
		select 
			@ShpQty = Mpd_ShpQty , 
			@OrdQty = Mpd_Qty , 
			@UntPrc = Mpd_MinPrc 
		from 
			MPORDDTL 
		where 
			Mpd_MPONo = @MPO and  
			Mpd_PONo = @Mxd_PONo and 
			Mpd_POSeq = @Mxd_POSeq
		
		set @errMsg = @errMsg +  case len(@errMsg) when 0 then '' else ' | ' end +  'PO Generated (' + @MPO + ')'

		--xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx
		-- CHECK EXIST -- 2
		--Check record identical or not	Lester Wu 2006-04-26
		-- If incoming MPO record is identical to the latest record, insert that record to MPOXLSDTL with UpdFlg marked 'O' and Latest Flag marked 'Y'
		--xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx
		set @changeLog = ''

		set @tmp_ReqNo =  ''
		set @tmp_ShpDat =   ''
		set @tmp_ItmNo =    ''
		set @tmp_ItmNam =   ''
		set @tmp_ItmDsc =   ''
		set @tmp_ColCde =   ''
		set @tmp_UM =   ''
		set @tmp_Qty =   0
		set @tmp_UntPrc =  0
		set @tmp_PckMth =   ''
		set @tmp_Dept =   ''
		set @tmp_PrdNo =   ''
		set @tmp_Rmk =   ''

		select 
			Top 1
			@changeLog = 'Y' , 
			@tmp_ReqNo =  isnull(Mxd_ReqNo , '') , 
			@tmp_ShpDat = isnull(Mxd_ShpDat , '1900/01/01') , 
			@tmp_ItmNo =  isnull(Mxd_ItmNo , '') , 
			@tmp_ItmNam = isnull(Mxd_ItmNam ,  '') , 
			@tmp_ItmDsc = isnull(Mxd_ItmDsc ,   '') , 
			@tmp_ColCde = isnull(Mxd_ColCde ,   '') , 
			@tmp_UM = isnull(Mxd_UM ,   '') , 
			@tmp_Qty = isnull(Mxd_Qty ,   0) , 
			@tmp_UntPrc = isnull(Mxd_UntPrc ,   0) , 
			@tmp_PckMth = isnull(Mxd_PckMth ,   '') , 
			@tmp_Dept = isnull(Mxd_Dept ,   '') , 
			@tmp_PrdNo = isnull(Mxd_PrdNo ,   '') , 
			@tmp_Rmk = isnull(Mxd_Rmk ,   '') 
		from 
			MPOXLSDTL 
		where
			Mxd_PONo  = @Mxd_PONo and
			Mxd_POSeq = @Mxd_POSeq and
			Mxd_MPOFlg = 'G'
		order by 
			Mxd_Credat desc
		
		if @changeLog = 'Y'
		begin
			set @changeLog = ''
			if isnull(@tmp_ReqNo , '')   <>  isnull(@Mxd_ReqNo , '') 
			begin
				set @changeLog = @changeLog + case len(@changeLog) when 0 then '' else ' / ' end + 'Req#'
			end
			if isnull(@tmp_ShpDat , '1900/01/01')   <> isnull(@Mxd_ShpDat , '1900/01/01')
			begin
				set @changeLog = @changeLog + case len(@changeLog) when 0 then '' else ' / ' end + 'Shp Dat'
			end
			if isnull(@tmp_ItmNo , '')   <>  isnull(@Mxd_ItmNo , '') 
			begin
				set @changeLog = @changeLog + case len(@changeLog) when 0 then '' else ' / ' end + 'Item#'
			end
			if isnull(@tmp_ItmNam , '')   <> isnull(@Mxd_ItmNam ,  '') 
			begin
				set @changeLog = @changeLog + case len(@changeLog) when 0 then '' else ' / ' end + 'Item Name'
			end
			if isnull(@tmp_ItmDsc , '')   <> isnull(@Mxd_ItmDsc ,   '') 
			begin
				set @changeLog = @changeLog + case len(@changeLog) when 0 then '' else ' / ' end + 'Item Desc'
			end
			if isnull(@tmp_ColCde , '')   <> isnull(@Mxd_ColCde ,   '') 
			begin
				set @changeLog = @changeLog + case len(@changeLog) when 0 then '' else ' / ' end + 'Color'
			end
			if isnull(@tmp_UM , '')   <> isnull(@Mxd_UM ,   '') 
			begin
				set @changeLog = @changeLog + case len(@changeLog) when 0 then '' else ' / ' end + 'UM'
			end
			if isnull(@tmp_Qty , 0)   <> isnull(@Mxd_Qty ,   0) 
			begin
				set @changeLog = @changeLog + case len(@changeLog) when 0 then '' else ' / ' end + 'Qty'
			end
			if isnull(@tmp_UntPrc , 0)  <> isnull(@Mxd_UntPrc ,   0) 
			begin
				set @changeLog = @changeLog + case len(@changeLog) when 0 then '' else ' / ' end + 'Price'
			end
			if isnull(@tmp_PckMth , '')  <> isnull(@Mxd_PckMth ,   '') 
			begin
				set @changeLog = @changeLog + case len(@changeLog) when 0 then '' else ' / ' end + 'Packing'
			end
			if isnull(@tmp_Dept , '')  <> isnull(@Mxd_Dept ,   '') 
			begin
				set @changeLog = @changeLog + case len(@changeLog) when 0 then '' else ' / ' end + 'Dept'
			end
			if isnull(@tmp_PrdNo , '')  <> isnull(@Mxd_PrdNo ,   '') 
			begin
				set @changeLog = @changeLog + case len(@changeLog) when 0 then '' else ' / ' end + 'Prod#'
			end
			if isnull(@tmp_Rmk , '')  <> isnull(@Mxd_Rmk,  '') 
			begin
				set @changeLog = @changeLog + case len(@changeLog) when 0 then '' else ' / ' end + 'Rmk'
			end

			if len(@changeLog) > 0 
			begin
			-- Not Identical
				set @changeLog = '[ Change of :-' + @changeLog + ' ]'
				set @Flag = 'E'
			end
			else
			begin
				set @Flag = 'O'
			end

		end


		--xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx
		
		/*
		if Upper(@Mxd_UpdFlg) = 'DEL' 
		begin
			if ((select count(1) from MPORDDTL where Mpd_MpoNo = @MPO) <= 1 )
			begin
				set @errMsg =  @errMsg + case len(@errMsg) when 0 then '' else ' | ' end +  'Only One Dtl Record Remain'
				set @Flag = 'R'
			end
		end
		*/

		if @Flag <> 'R'
		begin
			if Upper(@Mxd_UpdFlg) <> 'DEL'  and @Mxd_UntPrc <= 0 
			begin
				set @errMsg = @errMsg +  case len(@errMsg) when 0 then '' else ' | ' end + 'Unit Price Not Valid!'
				set @Flag = 'R'
			end
			else if Upper(@Mxd_UpdFlg) <> 'DEL'  and @Mxd_UntPrc < @UntPrc
			begin
				set @errMsg = @errMsg +  case len(@errMsg) when 0 then '' else ' | ' end + 'Modified Unit Price < Previous Unit Price'
--				set @Flag = 'R'
				set @Flag = 'E'
			end
			else if @Mxd_Qty < @ShpQty
			begin
				set @errMsg = @errMsg +  case len(@errMsg) when 0 then '' else ' | ' end + 'Modified Order Qty  < Shipped Qty'
				set @Flag = 'R'
			end 
		end
		
		
		
	end
	

	
/* XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX
		----------+-----------+-----------+-----------+-----------+-----------+-----------+
			N	O	E	R	D	*G	<--- @Flag
		----------+-----------+-----------+-----------+-----------+-----------+-----------+
		O	\	\	\	\	\	\
		E	O	\	O	\	O	\
		R	\	\	\	\	\	\
		D	\	\	\	\	O	\
		*G	\	\	\	\	\	\
		N	O	\	O	\	O	\
 XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX*/
		
		 if @Flag = 'N'
		begin
			update MPOXLSDTL set Mxd_MPOFlg = 'O' where Mxd_PONo = @Mxd_PONo and Mxd_POSeq = @Mxd_POSeq and Mxd_MPOFlg in ('E', 'N')
		end
		else if @Flag = 'E'
		begin
			update MPOXLSDTL set Mxd_MPOFlg = 'O' where Mxd_PONo = @Mxd_PONo and Mxd_POSeq = @Mxd_POSeq and Mxd_MPOFlg in ('E', 'N')
		end
		else if @Flag = 'D'
		begin
			update MPOXLSDTL set Mxd_MPOFlg = 'O' where Mxd_PONo = @Mxd_PONo and Mxd_POSeq = @Mxd_POSeq and Mxd_MPOFlg in ('E', 'N','D')
		end
	
-- +++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
-- +++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++

	if @Flag = 'E'  or @Flag = 'R'
	begin
		update MPOEXPDTL set Mxd_MPOFLG = 'O' , Mxd_UpdDat = getdate(), Mxd_UpdUsr = 'XML_UPLOAD'
		where Mxd_pono = @Mxd_pono and Mxd_poseq = @mxd_poseq and Mxd_MPOFlG = 'E'
		
		insert into MPOEXPDTL (
			Mxd_FilNam,
			Mxd_seq,
			Mxd_PONo,
			Mxd_POSeq,
			Mxd_ReqNo,
			Mxd_ShpDat,
			Mxd_ItmNo,
			Mxd_ItmNam,
			Mxd_ItmDsc,
			Mxd_ColCde,
			Mxd_UM,
			Mxd_Qty,
			Mxd_UntPrc,
			Mxd_PckMth,
			Mxd_Dept,
			Mxd_PrdNo,
			Mxd_Rmk,
			Mxd_UpdFlg,
			Mxd_Expt,
			Mxd_MPOFLG,
			Mxd_MPONO,
			Mxd_CreDat,
			Mxd_CreUsr,
			Mxd_UpdDat,
			Mxd_UpdUsr
		)
		select
			isnull(@FileName,''),
			isnull(max(Mxd_seq),0) + 1,
			isnull(@Mxd_PONo,''),
			isnull(@Mxd_POSeq,''),
			isnull(@Mxd_ReqNo,''),
			isnull(@Mxd_ShpDat,''),
			isnull(@Mxd_ItmNo,''),
			isnull(@Mxd_ItmNam,''),
			isnull(@Mxd_ItmDsc,''),
			isnull(@Mxd_ColCde,''),
			upper(@Mxd_UM),
			isnull(@Mxd_Qty,''),
			isnull(@Mxd_UntPrc,''),
			isnull(@Mxd_PckMth,''),
			isnull(@Mxd_Dept,''),
			isnull(@Mxd_PrdNo,''),
			isnull(@Mxd_Rmk,''),
			isnull(@Mxd_UpdFlg,''),
			isnull(@errMsg + case when len(@errMsg) > 0 then ' ' else '' end + @changeLog ,''),
			ltrim(rtrim(@Flag)),
			'',
			getdate(),
			'XML UPLOAD',
			getdate(),
			'XML UPLOAD'
		from
			MPOEXPDTL
		where
			Mxd_FilNam = @FileName

	end
	--else
	--begin
		
		update MPOXLSDTL set Mxd_Latest = 'N' where Mxd_PONo = @Mxd_PONo and Mxd_POSeq = @Mxd_POSeq and Mxd_Latest = 'Y'

		insert into MPOXLSDTL (
			Mxd_FilNam,
			Mxd_seq,
			Mxd_PONo,
			Mxd_POSeq,
			Mxd_ReqNo,
			Mxd_ShpDat,
			Mxd_ItmNo,
			Mxd_ItmNam,
			Mxd_ItmDsc,
			Mxd_ColCde,
			Mxd_UM,
			Mxd_Qty,
			Mxd_UntPrc,
			Mxd_PckMth,
			Mxd_Dept,
			Mxd_PrdNo,
			Mxd_Rmk,
			Mxd_UpdFlg,
			Mxd_Expt,
			Mxd_MPOFLG,
			Mxd_MPONO,
			Mxd_Latest, 		--Lester Wu 2006-04-26
			Mxd_CreDat,
			Mxd_CreUsr,
			Mxd_UpdDat,
			Mxd_UpdUsr
		)
		select
			isnull(@FileName,''),
			isnull(max(Mxd_seq),0) + 1,
			isnull(@Mxd_PONo,''),
			isnull(@Mxd_POSeq,''),
			isnull(@Mxd_ReqNo,''),
			isnull(@Mxd_ShpDat,''),
			isnull(@Mxd_ItmNo,''),
			isnull(@Mxd_ItmNam,''),
			isnull(@Mxd_ItmDsc,''),
			isnull(@Mxd_ColCde,''),
			upper(@Mxd_UM),
			isnull(@Mxd_Qty,''),
			isnull(@Mxd_UntPrc,''),
			isnull(@Mxd_PckMth,''),
			isnull(@Mxd_Dept,''),
			isnull(@Mxd_PrdNo,''),
			isnull(@Mxd_Rmk,''),
			isnull(@Mxd_UpdFlg,''),
--			@errMsg,
			isnull(@errMsg + case when len(@errMsg) > 0 then ' ' else '' end + @changeLog ,''),
			ltrim(rtrim(@Flag)),
			'',
			'Y', 		--Lester Wu 2006-04-26
			getdate(),
			'XML UPLOAD',
			getdate(),
			'XML UPLOAD'
		from
			MPOXLSDTL
		where
			Mxd_FilNam = @FileName		
	-- end

END






GO
GRANT EXECUTE ON [dbo].[sp_MPOXLS_Dtl] TO [ERPUSER] AS [dbo]
GO
