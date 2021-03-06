/****** Object:  StoredProcedure [dbo].[sp_select_IMR00017]    Script Date: 09/29/2017 15:29:09 ******/
DROP PROCEDURE [dbo].[sp_select_IMR00017]
GO
/****** Object:  StoredProcedure [dbo].[sp_select_IMR00017]    Script Date: 09/29/2017 15:29:10 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO














/************************************************************************************************      
Program ID : sp_select_IMR00017      
Programmer : Lester Wu      
Description : A to export item pricing information with input item list      
    Each Item separated by a astirisk sign      
Table Read : IMBASINF, SYFMLINF, IMPCKINF, VNBASINF      
************************************************************************************************      
Modification History      
************************************************************************************************      
Modified On  Modified By  Description      
************************************************************************************************      
2005/03/08   Lester Wu   add fileds , bom item no , bom item description, qty of bom per item , packing instruction      
2005/03/08   Lester Wu   Remove all "nolock" avoid when server busy, query cannot retrieve required data      
07 Apr 2005  Lester Wu   Retrieve Company Name from Database      
03 Oct 2005  Lester Wu   Show Product Line and Category in Excel report      
30 Aug 2006  Lester Wu   Add search by Item Update Date option      
26 Apr 2010  Marco Chan	 Performance Tunning and rewrite the logic
			 4 types of searching @OPT
			 ITM - Item Range
			 LST - Item List
			 DAC - Date Range with current item
			 DAA - Date Range with current + history item
************************************************************************************************/      
      
--sp_select_IMR00017 'ALL', '06B70PTT065C2*06B70PTT065A2','','','06B70PTT000A', '06B70PTT065ZZ', 'B', 'B', 'B', 'B', '01/01/1900', '01/01/1900', '', 'ITM'


      


CREATE     Procedure [dbo].[sp_select_IMR00017]      
@cocde as varchar(6),      
@ItmLst as varchar(650),      
@fromcatlvl4 as varchar(20),      
@tocatlvl4 as varchar(20),      
@fromitmno as varchar(20),      
@toitmno as varchar(20),      
--@itmlist as varchar(4000),  
@dsgVenNoFm as varchar(6),      
@dsgVenNoTo as varchar(6),      
@prdVenNoFm as varchar(6),      
@prdVenNoTo as varchar(6),         
@period as varchar(20),     
@cus1nolist     varchar(1000)  ,
@cus2nolist     varchar(1000)  ,
@dsgvennolist     varchar(1000),
@dateFm as datetime,       
@dateTo as datetime ,       
@STS as varchar(3) ,     
@OPT as varchar(3)      
as      
BEGIN      
create table #tmp_sts(_sts varchar(200))    
    
if @OPT = 'STS'    
begin    
   insert into #tmp_sts( _sts) values ('CMP - Active Item with complete Info.' )    
   insert into #tmp_sts( _sts) values ('INC - Active Item with incomplete Info.' )    
   insert into #tmp_sts( _sts) values ('HLD - Active Item Hold by the system' )    
   insert into #tmp_sts( _sts) values ('DIS - Discontinue Item' )    
   insert into #tmp_sts( _sts) values ('INA - Inactive Item' )    
   insert into #tmp_sts( _sts) values ('CLO - Closed (UCP Item)' )    
   insert into #tmp_sts( _sts) values ('TBC - To be confirmed Item' )    
   insert into #tmp_sts( _sts) values ('OLD - Old Item' )    
    
   select _sts from #tmp_sts    
end    
else    
begin    

   declare @compName varchar(100)      
   select @compName = yco_conam from SYCOMINF(nolock) where yco_cocde = @cocde      
   if @cocde<>'MS'       
   begin      
      set @compName = 'UNITED CHINESE GROUP'      
   end      

   declare @tmp_ItmLst as varchar(650),      
   @tmp_Remain as varchar(650),      
   @tmp_Part as varchar(20)      

   --Create a temp table for input items      
   create table #tmp_inItmLst(tmp_itmno  nvarchar(20))      

   --Create a temp table for items      
   create table #tmp_ItmLst(tmp_itmno  nvarchar(20))
         
   --Trim space      
   set @tmp_Remain = ltrim(rtrim(@ItmLst))      
   
   declare @Cus1Empty as char(1)
	set @Cus1Empty = 'N'
	if len(rtrim(ltrim(replace(@cus1nolist,'''','')))) <= 0 
	begin
		set @Cus1Empty = 'Y'
	end 


	declare @Cus2Empty as char(1)
	set @Cus2Empty = 'N'
	if len(rtrim(ltrim(replace(@cus2nolist,'''','')))) <= 0 
	begin
		set @Cus2Empty = 'Y'
	end 


	declare @VenEmpty as char(1)
	set @VenEmpty = 'N'
	if len(rtrim(ltrim(replace(@dsgvennolist,'''','')))) <= 0 
	begin
		set @VenEmpty = 'Y'
	end 

	declare	
		@i 			int,
		@value		varchar(20),	@start 		varchar(20),	@end 		nvarchar(20),
		@dvqry		varchar(2000),	@cus1qry 	varchar(2000),	@cus2qry 	varchar(2000)
-- Process cus1no Query --
create table #tempCus1no(
tempCus1no  nvarchar(6)
)
if charindex('A',@cus1nolist) <> 0 
begin
insert into #tempCus1no values('A')
end

if charindex('B',@cus1nolist) <> 0 
begin
insert into #tempCus1no values('B')
end
if charindex('I',@cus1nolist) <> 0 
begin
insert into #tempCus1no values('I')
end
 if ltrim(rtrim(@cus1nolist)) <> ''
begin
	set @cus1qry = ''
	set @i = 0
	
	while charindex(',',@cus1nolist) <> 0
	begin
		set @i = charindex(',',@cus1nolist)
		if @i = 0 and charindex(@cus1nolist,@cus1qry) = 0
			set @i = len(@cus1nolist)
		set @value = substring(@cus1nolist, 0, @i)
		set @cus1nolist = substring(@cus1nolist,@i+1,len(@cus1nolist)-@i)
		if ltrim(rtrim(@value)) <> ''
		begin
			if charindex('~',@value) > 0
			begin
				set @i = charindex('~',@value)
				set @start = substring(@value, 0, @i)
				set @end = substring(@value, @i+1,len(@value))
				set @cus1qry = @cus1qry + case len(@cus1qry) when 0 then '' else ' or cbi_cusno ' end + 'between ''' + @start + ''' and ''' + @end + ''''
			end
			else
			begin
				set @cus1qry = @cus1qry + case len(@cus1qry) when 0 then '' else ' or cbi_cusno ' end + '= ''' + @value + ''''

			end
		end
	end
	
	if charindex(@cus1nolist, @cus1qry) = 0
	begin
		if charindex('~',@cus1nolist) > 0
		begin
			set @i = charindex('~',@cus1nolist)
			set @start = substring(@cus1nolist, 0, @i)
			set @end = substring(@cus1nolist, @i+1,len(@cus1nolist))
			set @cus1qry = @cus1qry + case len(@cus1qry) when 0 then '' else ' or cbi_cusno ' end + 'between ''' + @start + ''' and ''' + @end + ''''
		end
		else
		begin
			set @cus1qry = @cus1qry + case len(@cus1qry) when 0 then '' else ' or cbi_cusno ' end + '= ''' + @cus1nolist + ''''
		end
	end
	
	set @cus1qry = ' where cbi_cusno ' + @cus1qry

	exec ('insert into #tempCus1no select distinct  cbi_cusno from CUBASINF '+@cus1qry)
end -- if ltrim(rtrim(@cus1nolist)) <> ''

--select * from #tempCus1no
--------------------cus1no part end


--++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++--

-- Process cus2no Query --

create table #tempCus2no(
tempCus2no  nvarchar(6)
)
if charindex('A',@cus2nolist) <> 0 
begin
insert into #tempCus2no values('A')
end

if charindex('B',@cus2nolist) <> 0 
begin
insert into #tempCus2no values('B')
end
if charindex('I',@cus2nolist) <> 0 
begin
insert into #tempCus2no values('I')
end
if @Cus2Empty='N'
begin

	if ltrim(rtrim(@cus2nolist)) <> ''
	begin
		set @cus2qry = ''
		set @i = 0
	
		while charindex(',',@cus2nolist) <> 0
		begin
			set @i = charindex(',',@cus2nolist)
			if @i = 0 and charindex(@cus2nolist,@cus2qry) = 0
				set @i = len(@cus2nolist)
			set @value = substring(@cus2nolist, 0, @i)
			set @cus2nolist = substring(@cus2nolist,@i+1,len(@cus2nolist)-@i)
			if ltrim(rtrim(@value)) <> ''
			begin
				if charindex('~',@value) > 0
				begin
					set @i = charindex('~',@value)
					set @start = substring(@value, 0, @i)
					set @end = substring(@value, @i+1,len(@value))
					set @cus2qry = @cus2qry + case len(@cus2qry) when 0 then '' else ' or cbi_cusno ' end + 'between ''' + @start + ''' and ''' + @end + ''''
				end
				else
				begin
					set @cus2qry = @cus2qry + case len(@cus2qry) when 0 then '' else ' or cbi_cusno ' end + '= ''' + @value + ''''
				end
			end
		end
	
		if charindex(@cus2nolist, @cus2qry) = 0
		begin
			if charindex('~',@cus2nolist) > 0
			begin
				set @i = charindex('~',@cus2nolist)
				set @start = substring(@cus2nolist, 0, @i)
				set @end = substring(@cus2nolist, @i+1,len(@cus2nolist))
				set @cus2qry = @cus2qry + case len(@cus2qry) when 0 then '' else ' or cbi_cusno ' end + 'between ''' + @start + ''' and ''' + @end + ''''
			end
			else
			begin
				set @cus2qry = @cus2qry + case len(@cus2qry) when 0 then '' else ' or cbi_cusno ' end + '= ''' + @cus2nolist + ''''
			end
		end
	
		set @cus2qry = ' where cbi_cusno ' + @cus2qry
	end -- if ltrim(rtrim(@cus2nolist)) <> ''
	--select @cus2qry

	--select ('insert into #tempCus2no select distinct  cbi_cusno from CUBASINF'+@cus2qry)
	exec ('insert into #tempCus2no select distinct  cbi_cusno from CUBASINF'+@cus2qry)
	--select * from #tempCus2no
end
---------------------------
----------------------cus2no part end


--++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++--
-- Process venno Query --
create table #tempVENno(
tempVen  nvarchar(6)
)
if @VenEmpty='N'
begin

	if ltrim(rtrim(@dsgvennolist)) <> ''
	begin
		set @dvqry = ''
		set @i = 0
	
		while charindex(',',@dsgvennolist) <> 0
		begin
			set @i = charindex(',',@dsgvennolist)
			if @i = 0 and charindex(@dsgvennolist,@dvqry) = 0
				set @i = len(@dsgvennolist)
			set @value = substring(@dsgvennolist, 0, @i)
			set @dsgvennolist = substring(@dsgvennolist,@i+1,len(@dsgvennolist)-@i)
			if ltrim(rtrim(@value)) <> ''
			begin
				if charindex('~',@value) > 0
				begin
					set @i = charindex('~',@value)
					set @start = substring(@value, 0, @i)
					set @end = substring(@value, @i+1,len(@value))
					set @dvqry = @dvqry + case len(@dvqry) when 0 then '' else ' or vbi_venno ' end + 'between ''' + @start + ''' and ''' + @end + ''''
				end
				else
				begin
					set @dvqry = @dvqry + case len(@dvqry) when 0 then '' else ' or vbi_venno ' end + '= ''' + @value + ''''
				end
			end
		end
	
		if charindex(@dsgvennolist, @dvqry) = 0
		begin
			if charindex('~',@dsgvennolist) > 0
			begin
				set @i = charindex('~',@dsgvennolist)
				set @start = substring(@dsgvennolist, 0, @i)
				set @end = substring(@dsgvennolist, @i+1,len(@dsgvennolist))
				set @dvqry = @dvqry + case len(@dvqry) when 0 then '' else ' or vbi_venno ' end + 'between ''' + @start + ''' and ''' + @end + ''''
			end
			else
			begin
				set @dvqry = @dvqry + case len(@dvqry) when 0 then '' else ' or vbi_venno ' end + '= ''' + @dsgvennolist + ''''
			end
		end
	
		set @dvqry = ' where vbi_venno ' + @dvqry
	end -- if ltrim(rtrim(@dsgvennolist)) <> ''
	--select @dvqry

	--select ('insert into #tempVENno select distinct  vbi_venno from VNBASINF'+@dvqry)
	exec ('insert into #tempVENno select distinct  vbi_venno from VNBASINF'+@dvqry)
	--select * from #tempVENno
end
---------------------------
----------------------venno part end

   if @tmp_Remain <> '' and @OPT = 'LST'       
   begin      
	--XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX      
	--Insert the item no in the @ItmLst string into the temp table       
	set @tmp_Part = ''      
	
	while charindex(',',@tmp_Remain)<> 0       
	begin      
	set @tmp_Part = ltrim(rtrim(left(@tmp_Remain,charindex(',',@tmp_Remain)-1)))      
	set @tmp_Remain = ltrim(rtrim(right(@tmp_Remain,len(@tmp_Remain) - charindex(',',@tmp_Remain))))      
	insert into #tmp_inItmLst values(@tmp_Part)      
	end       
	
	insert  into #tmp_inItmLst values(@tmp_Remain)      
	--XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX      
   end      
   else if @fromitmno <> '' and @toitmno <> '' and @OPT = 'ITM'       
   begin
	insert into #tmp_inItmLst
	select ibi_itmno from IMBASINF (nolock) where ibi_itmno >= @fromitmno and ibi_itmno <= @toitmno
	union
	select ibi_itmno from IMBASINFH (nolock) where ibi_itmno >= @fromitmno and ibi_itmno <= @toitmno
	order by ibi_itmno

   end     
   else if @OPT = 'DAC' or @OPT = 'DAA' 
   begin
	set @dateFm = convert(char(10), @dateFm, 121) + ' 00:00:00'
	set @dateTo = convert(char(10), @dateTo, 121) + ' 23:59:59'
   end

   if @OPT = 'LST' or @OPT = 'ITM'
   begin
	--Retrieve related item no      
	insert into #tmp_inItmLst
	select ibi_alsitmno from IMBASINF,#tmp_inItmLst
	where tmp_itmno = ibi_itmno and ibi_alsitmno <> ''
	
	insert into #tmp_inItmLst
	select ibi_itmno from IMBASINF,#tmp_inItmLst
	where tmp_itmno = ibi_alsitmno and ibi_alsitmno <> ''
	
	insert into #tmp_inItmLst
	select ibi_alsitmno from IMBASINFH,#tmp_inItmLst
	where tmp_itmno = ibi_itmno and ibi_alsitmno <> ''
	
	insert into #tmp_inItmLst
	select ibi_itmno from IMBASINFH,#tmp_inItmLst
	where tmp_itmno = ibi_alsitmno and ibi_alsitmno <> ''
   end
	
   insert into #tmp_ItmLst   
   select distinct tmp_itmno from #tmp_inItmLst	


declare @flg_catlvl4	char(1)
declare @flg_dv		char(1)
declare @flg_pv		char(1)
declare @flg_sts	char(1)

-- Category
declare @catFm as nvarchar(20)      
declare @catTo as nvarchar(20)      
    
set @catFm = @fromcatlvl4      
set @catTo = @tocatlvl4      

if @catFm <> '' and @catTo <> ''
begin
	if charindex('-',@fromcatlvl4) > 0       
	begin      
	   set @catFm = rtrim(left(@fromcatlvl4,charindex('-',@fromcatlvl4) -1))      
	end      
	         
	if charindex('-',@tocatlvl4) > 0       
	begin      
	   set @catTo = rtrim(left(@tocatlvl4,charindex('-',@tocatlvl4) -1))      
	end      

	set @flg_catlvl4 = 'Y'
end
else
begin
	set @flg_catlvl4 = 'N'
end

-- DV
if @dsgVenNoFm <> '' and @dsgVenNoTo <> ''
begin
	set @flg_dv = 'N'
end
else
begin
	set @flg_dv = 'N'
end

-- PV
if @prdVenNoFm <> '' and @prdVenNoTo <> ''
begin
	set @flg_pv = 'Y'
end
else
begin
	set @flg_pv = 'N'
end

-- Status
if @STS <> ''
begin
	set @flg_sts = 'Y'
end
else
begin
	set @flg_sts = 'N'
end





declare @counter int

select @counter = count(*) from #tmp_ItmLst 
if @counter = 0 and @OPT <> 'DAA' and @OPT <> 'DAC' begin
select * from #tmp_ItmLst
end
else if @counter > 0 and @OPT <> 'DAA' and @OPT <> 'DAC'
begin


-- RESULT
select       
ibi.ibi_itmno as 'Item No',  --1  
ibi.ibi_itmsts as 'Item Status',     
ibi.ibi_engdsc as 'English Description', --17      
ibi.ibi_lnecde as 'Product Line',      
ibi.ibi_catlvl4 + case isnull(ycc_catdsc,'') when '' then '' else ' - ' + ycc_catdsc end  as 'Category' ,      
icf_colcde as 'Color Code',
ipi_pckunt as 'UM',  --2       
ipi_inrqty as 'Inner',  --3       
ipi_mtrqty as 'Master',  --4
ipi_cft as 'CFT',  --5  
imu_ftyprctrm as 'FTY Prc Trm',
imu_hkprctrm as 'HK Prc Trm',
imu_trantrm as 'Tran Trm',     
case left(convert(varchar(20), ipi_qutdat,111),7) when '1900/01' then '' else left(convert(varchar(20), ipi_qutdat,111),7) end as 'Period',   
ipi_pckitr as 'Packing Instruction', --6      
isnull(imu_cus1no,'') as 'Pri. Cus. No.',
isnull(pri.cbi_cussna,'') as 'Pri. Cus. Name',
isnull(imu_cus2no,'') as 'Sec. Cus. No.',
isnull(sec.cbi_cussna,'') as 'Sec. Cus. Name',
--dsg.imu_ftycst as 'Fty Cost', --7      
--dsg.imu_ftyprc as 'Item Cost', --8      
imu_ftycst as 'Fty Cost', --7
imu_ftyprc as 'Item Cost', --8
/*
case isnull(dsg.imu_fmlopt,'') when '' then '' else       
case isnull(yfi_fml,'') when '' then  dsg.imu_fmlopt else dsg.imu_fmlopt + ' - ' + yfi_fml end       
end as 'Formula',  --9
*/
case isnull(imu_fmlopt,'') when '' then '' else case isnull(yfi_fml,'') when '' then imu_fmlopt else imu_fmlopt + ' - ' + yfi_fml end end as 'Formula',  --9
isnull(iba_assitm,'')  as 'BOM Item No.', --10      
isnull(bom.ibi_engdsc,'') as 'Item Description', --11      
iba_untcst as 'BOM Cost',      
case isnull(iba_bomqty,0) when 0 then ''  else ltrim(str(iba_bomqty)) end as 'Qty of Bom Per Item',      
iba_bombasprc as 'BOM Price',      
--prd.imu_basprc as 'Basic Price', --14      
--prd.imu_calftyprc as 'Calculated', -- 15      
--prd.imu_negprc as 'Negotiated', --16
imu_basprc as 'Basic Price', --14       
imu_negprc as 'Negotiated', --16
/*      
case isnull(prd.imu_prdven,'') when '' then       
dsg.imu_prdven + case isnull(dsgPven.vbi_vensna,'') when '' then '' else ' -' + dsgPven.vbi_vensna end      
else      
prd.imu_prdven + case isnull(prdPven.vbi_vensna,'') when '' then '' else ' -' + prdPven.vbi_vensna end      
end  as 'Production Vendor1'  --18
*/
imu_prdven + case isnull(vbi_vensna,'') when '' then '' else ' -' + vbi_vensna end as 'Production Vendor1'  --18  	
,ibi.ibi_alsitmno as 'Alias No'
,ibi.ibi_rmk as 'Item Remark'
,isnull(convert(varchar(20),imu_expdat,111),'') as 'Cost Expiry Date'  
,isnull(ici_cstrmk,'') as 'Cost Remark'    
,@compName as 'compName' 
FROM #tmp_ItmLst (nolock)
left join IMBASINF ibi (nolock) on ibi.ibi_itmno = tmp_itmno
LEFT JOIN IMPCKINF (nolock)  ON ibi.ibi_itmno = ipi_itmno      
--LEFT JOIN IMMRKUP dsg (nolock)  ON dsg.imu_ventyp='D' and ipi_itmno= dsg.imu_itmno and ipi_pckunt = dsg.imu_pckunt and ipi_inrqty = dsg.imu_inrqty and ipi_mtrqty = dsg.imu_mtrqty      
--LEFT JOIN IMMRKUP prd (nolock)   ON prd.imu_ventyp='P' and ipi_itmno= prd.imu_itmno and ipi_pckunt = prd.imu_pckunt and ipi_inrqty = prd.imu_inrqty and ipi_mtrqty = prd.imu_mtrqty      
LEFT JOIN IMPRCINF (nolock)  ON ipi_itmno= imu_itmno and ipi_pckunt = imu_pckunt and ipi_inrqty = imu_inrqty and ipi_mtrqty = imu_mtrqty
--LEFT JOIN SYFMLINF (nolock)  ON dsg.imu_fmlopt = yfi_fmlopt    
LEFT JOIN SYFMLINF (nolock)  ON imu_fmlopt = yfi_fmlopt
--LEFT JOIN VNBASINF prdPven  (nolock)  ON prd.imu_prdven = prdPven.vbi_venno      
--LEFT JOIN VNBASINF dsgPven  (nolock)  ON dsg.imu_prdven = dsgPven.vbi_venno      
LEFT JOIN VNBASINF (nolock)  ON imu_prdven = vbi_venno
LEFT JOIN IMBOMASS  (nolock)   ON ibi.ibi_itmno = iba_itmno and iba_typ = 'BOM'       
LEFT JOIN IMBASINF bom  (nolock)  on iba_assitm = bom.ibi_itmno      
LEFT JOIN SYCATCDE  (nolock) ON ibi.ibi_catlvl4 = ycc_catcde and ycc_level = 4      
LEFT JOIN IMCOLINF (nolock) ON ibi.ibi_itmno = icf_itmno 	
LEFT JOIN CUBASINF pri ON imu_cus1no = pri.CBI_CUSNO
LEFT JOIN CUBASINF sec ON imu_cus2no = sec.CBI_CUSNO
LEFT JOIN IMCSTINF on ICI_ITMNO = ibi.IBI_ITMNO
where ibi.ibi_itmno is not null
and ((@flg_catlvl4 = 'N') or (@flg_catlvl4 = 'Y' and ibi.ibi_catlvl4 >= @catFm and ibi.ibi_catlvl4 <= @catTo))
--and ((@flg_dv = 'N') or (@flg_dv = 'Y' and ibi.ibi_venno >= @dsgVenNoFm and ibi.ibi_venno <= @dsgVenNoTo)) 
 and 	(@VenEmpty='Y' or ibi.ibi_venno  in (select tempVen from #tempVENno) )
--and ((@flg_pv = 'N') or (@flg_pv = 'Y' and prd.imu_prdven >= @prdVenNoFm and prd.imu_prdven <= @prdVenNoTo))
and ((@flg_pv = 'N') or (@flg_pv = 'Y' and imu_prdven >= @prdVenNoFm and imu_prdven <= @prdVenNoTo))
and ((@flg_sts = 'N') or (@flg_sts = 'Y' and ibi.ibi_itmsts = @STS))
and (@Cus1Empty = 'Y'or imu_cus1no in (select tempCus1no from #tempCus1no))
and (@Cus2Empty = 'Y'or imu_cus2no in (select tempCus2no from #tempCus2no))
and(@period=left(convert(varchar(20), ipi_qutdat,111),7) or @period='1900/01')
union
select       
ibi.ibi_itmno as 'Item No',  --1     
ibi.ibi_itmsts as 'Item Status',     
ibi.ibi_engdsc as 'English Description', --17      
ibi.ibi_lnecde as 'Product Line',      
ibi.ibi_catlvl4 + case isnull(ycc_catdsc,'') when '' then '' else ' - ' + ycc_catdsc end  as 'Category' ,      
icf_colcde as 'Color Code',
ipi_pckunt as 'UM',  --2       
ipi_inrqty as 'Inner',  --3       
ipi_mtrqty as 'Master',  --4
ipi_cft as 'CFT',  --5   
imu_ftyprctrm as 'FTY Prc Trm',
imu_hkprctrm as 'HK Prc Trm',
imu_trantrm as 'Tran Trm',    
case left(convert(varchar(20), ipi_qutdat,111),7) when '1900/01' then '' else left(convert(varchar(20), ipi_qutdat,111),7) end as 'Period',   
ipi_pckitr as 'Packing Instruction', --6      
isnull(imu_cus1no,'') as 'Pri. Cus. No.',
isnull(pri.cbi_cussna,'') as 'Pri. Cus. Name',
isnull(imu_cus2no,'') as 'Sec. Cus. No.',
isnull(sec.cbi_cussna,'') as 'Sec. Cus. Name',
--dsg.imu_ftycst as 'Fty Cost', --7      
--dsg.imu_ftyprc as 'Item Cost', --8      
imu_ftycst as 'Fty Cost', --7
imu_ftyprc as 'Item Cost', --8
/*
case isnull(dsg.imu_fmlopt,'') when '' then '' else       
case isnull(yfi_fml,'') when '' then  dsg.imu_fmlopt else dsg.imu_fmlopt + ' - ' + yfi_fml end       
end as 'Formula',  --9      
*/
case isnull(imu_fmlopt,'') when '' then '' else case isnull(yfi_fml,'') when '' then imu_fmlopt else imu_fmlopt + ' - ' + yfi_fml end end as 'Formula',  --9
isnull(iba_assitm,'')  as 'BOM Item No.', --10      
isnull(bom.ibi_engdsc,'') as 'Item Description', --11      
iba_untcst as 'BOM Cost',      
case isnull(iba_bomqty,0) when 0 then ''  else ltrim(str(iba_bomqty)) end as 'Qty of Bom Per Item',      
iba_bombasprc as 'BOM Price',      
--prd.imu_basprc as 'Basic Price', --14      
--prd.imu_calftyprc as 'Calculated', -- 15      
--prd.imu_negprc as 'Negotiated', --16
imu_basprc as 'Basic Price', --14
imu_negprc as 'Negotiated', --16
/*
case isnull(prd.imu_prdven,'') when '' then       
dsg.imu_prdven + case isnull(dsgPven.vbi_vensna,'') when '' then '' else ' -' + dsgPven.vbi_vensna end      
else      
prd.imu_prdven + case isnull(prdPven.vbi_vensna,'') when '' then '' else ' -' + prdPven.vbi_vensna end      
end  as 'Production Vendor1'  --18      	
*/
imu_prdven + case isnull(vbi_vensna,'') when '' then '' else ' -' + vbi_vensna end as 'Production Vendor1'  --18
,ibi.ibi_alsitmno as 'Alias No'
,ibi.ibi_rmk as 'Item Remark'
,isnull(convert(varchar(20),imu_expdat,111),'') as 'Cost Expiry Date'      
,isnull(ici_cstrmk,'') as 'Cost Remark'    
,@compName as 'compName'
FROM #tmp_ItmLst (nolock)       
left join IMBASINFH ibi (nolock) on ibi.ibi_itmno = tmp_itmno
LEFT JOIN IMPCKINFH (nolock)  ON ibi.ibi_itmno = ipi_itmno      
--LEFT JOIN IMMRKUPH dsg   (nolock)  ON dsg.imu_ventyp='D' and ipi_itmno= dsg.imu_itmno and ipi_pckunt = dsg.imu_pckunt and ipi_inrqty = dsg.imu_inrqty and ipi_mtrqty = dsg.imu_mtrqty      
--LEFT JOIN IMMRKUPH prd  (nolock)   ON prd.imu_ventyp='P' and ipi_itmno= prd.imu_itmno and ipi_pckunt = prd.imu_pckunt and ipi_inrqty = prd.imu_inrqty and ipi_mtrqty = prd.imu_mtrqty      
LEFT JOIN IMPRCINFH (nolock)  ON ipi_itmno= imu_itmno and ipi_pckunt = imu_pckunt and ipi_inrqty = imu_inrqty and ipi_mtrqty = imu_mtrqty
--LEFT JOIN SYFMLINF  (nolock)  ON dsg.imu_fmlopt = yfi_fmlopt    
LEFT JOIN SYFMLINF  (nolock)  ON imu_fmlopt = yfi_fmlopt
--LEFT JOIN VNBASINF prdPven  (nolock)  ON prd.imu_prdven = prdPven.vbi_venno      
--LEFT JOIN VNBASINF dsgPven  (nolock)  ON dsg.imu_prdven = dsgPven.vbi_venno      
LEFT JOIN VNBASINF (nolock)  ON imu_prdven = vbi_venno
LEFT JOIN IMBOMASSH  (nolock)   ON ibi.ibi_itmno = iba_itmno and iba_typ = 'BOM'       
LEFT JOIN IMBASINFH bom  (nolock)  on iba_assitm = bom.ibi_itmno      
LEFT JOIN SYCATCDE  (nolock) ON ibi.ibi_catlvl4 = ycc_catcde and ycc_level = 4      
LEFT JOIN IMCOLINFH (nolock) ON ibi.ibi_itmno = icf_itmno 	
LEFT JOIN CUBASINF pri ON imu_cus1no = pri.CBI_CUSNO
LEFT JOIN CUBASINF sec ON imu_cus2no = sec.CBI_CUSNO
LEFT JOIN IMCSTINFH on ICI_ITMNO = ibi.IBI_ITMNO
where ibi.ibi_itmno is not null
and ((@flg_catlvl4 = 'N') or (@flg_catlvl4 = 'Y' and ibi.ibi_catlvl4 >= @catFm and ibi.ibi_catlvl4 <= @catTo))
--and ((@flg_dv = 'N') or (@flg_dv = 'Y' and ibi.ibi_venno >= @dsgVenNoFm and ibi.ibi_venno <= @dsgVenNoTo))  
 and 	(@VenEmpty='Y' or ibi.ibi_venno  in (select tempVen from #tempVENno) )
and (@Cus1Empty = 'Y'or imu_cus1no in (select tempCus1no from #tempCus1no))
and (@Cus2Empty = 'Y'or imu_cus2no in (select tempCus2no from #tempCus2no))
--and ((@flg_pv = 'N') or (@flg_pv = 'Y' and prd.imu_prdven >= @prdVenNoFm and prd.imu_prdven <= @prdVenNoTo))
and ((@flg_pv = 'N') or (@flg_pv = 'Y' and imu_prdven >= @prdVenNoFm and imu_prdven <= @prdVenNoTo))
and ((@flg_sts = 'N') or (@flg_sts = 'Y' and ibi.ibi_itmsts = @STS))
and (@period=left(convert(varchar(20), ipi_qutdat,111),7) or @period='1900/01')
order by 1,20,5,6,7 

end
else if @OPT = 'DAC'
begin

select       
ibi.ibi_itmno as 'Item No',  --1     
ibi.ibi_itmsts as 'Item Status',     
ibi.ibi_engdsc as 'English Description', --17      
ibi.ibi_lnecde as 'Product Line',      
ibi.ibi_catlvl4 + case isnull(ycc_catdsc,'') when '' then '' else ' - ' + ycc_catdsc end  as 'Category' ,      
icf_colcde as 'Color Code',
ipi_pckunt as 'UM',  --2       
ipi_inrqty as 'Inner',  --3       
ipi_mtrqty as 'Master',  --4   
ipi_cft as 'CFT',  --5  
imu_ftyprctrm as 'FTY Prc Trm',
imu_hkprctrm as 'HK Prc Trm',
imu_trantrm as 'Tran Trm',     
case left(convert(varchar(20), ipi_qutdat,111),7) when '1900/01' then '' else left(convert(varchar(20), ipi_qutdat,111),7) end as 'Period',   
ipi_pckitr as 'Packing Instruction', --6      
isnull(imu_cus1no,'') as 'Pri. Cus. No.',
isnull(pri.cbi_cussna,'') as 'Pri. Cus. Name',
isnull(imu_cus2no,'') as 'Sec. Cus. No.',
isnull(sec.cbi_cussna,'') as 'Sec. Cus. Name',
--dsg.imu_ftycst as 'Fty Cost', --7      
--dsg.imu_ftyprc as 'Item Cost', --8
imu_ftycst as 'Fty Cost', --7      
imu_ftyprc as 'Item Cost', --8
/*
case isnull(dsg.imu_fmlopt,'') when '' then '' else       
case isnull(yfi_fml,'') when '' then  dsg.imu_fmlopt else dsg.imu_fmlopt + ' - ' + yfi_fml end       
end as 'Formula',  --9
*/
case isnull(imu_fmlopt,'') when '' then '' else case isnull(yfi_fml,'') when '' then imu_fmlopt else imu_fmlopt + ' - ' + yfi_fml end end as 'Formula',  --9
isnull(iba_assitm,'')  as 'BOM Item No.', --10      
isnull(bom.ibi_engdsc,'') as 'Item Description', --11      
iba_untcst as 'BOM Cost',      
case isnull(iba_bomqty,0) when 0 then ''  else ltrim(str(iba_bomqty)) end as 'Qty of Bom Per Item',      
iba_bombasprc as 'BOM Price',      
--prd.imu_basprc as 'Basic Price', --14      
--prd.imu_calftyprc as 'Calculated', -- 15      
--prd.imu_negprc as 'Negotiated', --16      
imu_basprc as 'Basic Price', --14
imu_negprc as 'Negotiated', --16
/*
case isnull(prd.imu_prdven,'') when '' then       
dsg.imu_prdven + case isnull(dsgPven.vbi_vensna,'') when '' then '' else ' -' + dsgPven.vbi_vensna end      
else      
prd.imu_prdven + case isnull(prdPven.vbi_vensna,'') when '' then '' else ' -' + prdPven.vbi_vensna end      
end  as 'Production Vendor1'  --18      	
*/
imu_prdven + case isnull(vbi_vensna,'') when '' then '' else ' -' + vbi_vensna end as 'Production Vendor1'  --18
,ibi.ibi_alsitmno as 'Alias No'
,ibi.ibi_rmk as 'Item Remark'
,isnull(convert(varchar(20),imu_expdat,111),'') as 'Cost Expiry Date'      
,isnull(ici_cstrmk,'') as 'Cost Remark'    
,@compName as 'compName'       
FROM IMBASINF ibi (nolock)
LEFT JOIN IMPCKINF (nolock)  ON ibi.ibi_itmno = ipi_itmno      
--LEFT JOIN IMMRKUP dsg (nolock)  ON dsg.imu_ventyp='D' and ipi_itmno= dsg.imu_itmno and ipi_pckunt = dsg.imu_pckunt and ipi_inrqty = dsg.imu_inrqty and ipi_mtrqty = dsg.imu_mtrqty      
--LEFT JOIN IMMRKUP prd (nolock)   ON prd.imu_ventyp='P' and ipi_itmno= prd.imu_itmno and ipi_pckunt = prd.imu_pckunt and ipi_inrqty = prd.imu_inrqty and ipi_mtrqty = prd.imu_mtrqty      
LEFT JOIN IMPRCINF (nolock)  ON ipi_itmno= imu_itmno and ipi_pckunt = imu_pckunt and ipi_inrqty = imu_inrqty and ipi_mtrqty = imu_mtrqty
--LEFT JOIN SYFMLINF (nolock)  ON dsg.imu_fmlopt = yfi_fmlopt    
LEFT JOIN SYFMLINF (nolock)  ON imu_fmlopt = yfi_fmlopt  
--LEFT JOIN VNBASINF prdPven  (nolock)  ON prd.imu_prdven = prdPven.vbi_venno      
--LEFT JOIN VNBASINF dsgPven  (nolock)  ON dsg.imu_prdven = dsgPven.vbi_venno      
LEFT JOIN VNBASINF (nolock)  ON imu_prdven = vbi_venno
LEFT JOIN IMBOMASS  (nolock)   ON ibi.ibi_itmno = iba_itmno and iba_typ = 'BOM'       
LEFT JOIN IMBASINF bom  (nolock)  on iba_assitm = bom.ibi_itmno      
LEFT JOIN SYCATCDE  (nolock) ON ibi.ibi_catlvl4 = ycc_catcde and ycc_level = 4      
LEFT JOIN IMCOLINF (nolock) ON ibi.ibi_itmno = icf_itmno 	
LEFT JOIN CUBASINF pri ON imu_cus1no = pri.CBI_CUSNO
LEFT JOIN CUBASINF sec ON imu_cus2no = sec.CBI_CUSNO
LEFT JOIN IMCSTINF on ICI_ITMNO = ibi.IBI_ITMNO
where 
--((ibi.ibi_upddat >= @dateFm and ibi.ibi_upddat <= @dateTo)or(prd.imu_upddat >= @dateFm and prd.imu_upddat <= @dateTo)or(dsg.imu_upddat >= @dateFm and dsg.imu_upddat <= @dateTo))
((ibi.ibi_upddat >= @dateFm and ibi.ibi_upddat <= @dateTo)or(imu_upddat >= @dateFm and imu_upddat <= @dateTo))
and ((@flg_catlvl4 = 'N') or (@flg_catlvl4 = 'Y' and ibi.ibi_catlvl4 >= @catFm and ibi.ibi_catlvl4 <= @catTo))
--and ((@flg_dv = 'N') or (@flg_dv = 'Y' and ibi.ibi_venno >= @dsgVenNoFm and ibi.ibi_venno <= @dsgVenNoTo))  
 and 	(@VenEmpty='Y' or ibi.ibi_venno  in (select tempVen from #tempVENno) )
and (@Cus1Empty = 'Y'or imu_cus1no in (select tempCus1no from #tempCus1no))
and (@Cus2Empty = 'Y'or imu_cus2no in (select tempCus2no from #tempCus2no))
--and ((@flg_pv = 'N') or (@flg_pv = 'Y' and prd.imu_prdven >= @prdVenNoFm and prd.imu_prdven <= @prdVenNoTo))
and ((@flg_pv = 'N') or (@flg_pv = 'Y' and imu_prdven >= @prdVenNoFm and imu_prdven <= @prdVenNoTo))
and ((@flg_sts = 'N') or (@flg_sts = 'Y' and ibi.ibi_itmsts = @STS))
and (@period=left(convert(varchar(20), ipi_qutdat,111),7) or @period='1900/01')
order by 1,20,5,6,7 


end
else if @OPT = 'DAA'
begin

select       
ibi.ibi_itmno as 'Item No',  --1     
ibi.ibi_itmsts as 'Item Status',     
ibi.ibi_engdsc as 'English Description', --17      
ibi.ibi_lnecde as 'Product Line',      
ibi.ibi_catlvl4 + case isnull(ycc_catdsc,'') when '' then '' else ' - ' + ycc_catdsc end  as 'Category' ,      
icf_colcde as 'Color Code',
ipi_pckunt as 'UM',  --2       
ipi_inrqty as 'Inner',  --3       
ipi_mtrqty as 'Master',  --4 
ipi_cft as 'CFT',  --5     
imu_ftyprctrm as 'FTY Prc Trm',
imu_hkprctrm as 'HK Prc Trm',
imu_trantrm as 'Tran Trm',        
case left(convert(varchar(20), ipi_qutdat,111),7) when '1900/01' then '' else left(convert(varchar(20), ipi_qutdat,111),7) end as 'Period',   
ipi_pckitr as 'Packing Instruction', --6      
isnull(imu_cus1no,'') as 'Pri. Cus. No.',
isnull(pri.cbi_cussna,'') as 'Pri. Cus. Name',
isnull(imu_cus2no,'') as 'Sec. Cus. No.',
isnull(sec.cbi_cussna,'') as 'Sec. Cus. Name',
--dsg.imu_ftycst as 'Fty Cost', --7      
--dsg.imu_ftyprc as 'Item Cost', --8
imu_ftycst as 'Fty Cost', --7      
imu_ftyprc as 'Item Cost', --8
/*
case isnull(dsg.imu_fmlopt,'') when '' then '' else       
case isnull(yfi_fml,'') when '' then  dsg.imu_fmlopt else dsg.imu_fmlopt + ' - ' + yfi_fml end       
end as 'Formula',  --9      
*/
case isnull(imu_fmlopt,'') when '' then '' else case isnull(yfi_fml,'') when '' then imu_fmlopt else imu_fmlopt + ' - ' + yfi_fml end end as 'Formula',  --9
isnull(iba_assitm,'')  as 'BOM Item No.', --10      
isnull(bom.ibi_engdsc,'') as 'Item Description', --11      
iba_untcst as 'BOM Cost',      
case isnull(iba_bomqty,0) when 0 then ''  else ltrim(str(iba_bomqty)) end as 'Qty of Bom Per Item',      
iba_bombasprc as 'BOM Price',      
--prd.imu_basprc as 'Basic Price', --14      
--prd.imu_calftyprc as 'Calculated', -- 15      
--prd.imu_negprc as 'Negotiated', --16      
imu_basprc as 'Basic Price', --14      
imu_negprc as 'Negotiated', --16
/*
case isnull(prd.imu_prdven,'') when '' then       
dsg.imu_prdven + case isnull(dsgPven.vbi_vensna,'') when '' then '' else ' -' + dsgPven.vbi_vensna end      
else      
prd.imu_prdven + case isnull(prdPven.vbi_vensna,'') when '' then '' else ' -' + prdPven.vbi_vensna end      
end  as 'Production Vendor1'  --18
*/
imu_prdven + case isnull(vbi_vensna,'') when '' then '' else ' -' + vbi_vensna end as 'Production Vendor1'  --18
,ibi.ibi_alsitmno as 'Alias No'
,ibi.ibi_rmk as 'Item Remark'
,isnull(convert(varchar(20),imu_expdat,111),'') as 'Cost Expiry Date'      
,isnull(ici_cstrmk,'') as 'Cost Remark'    
,@compName as 'compName'       
FROM IMBASINF ibi (nolock)
LEFT JOIN IMPCKINF (nolock)  ON ibi.ibi_itmno = ipi_itmno      
--LEFT JOIN IMMRKUP dsg (nolock)  ON dsg.imu_ventyp='D' and ipi_itmno= dsg.imu_itmno and ipi_pckunt = dsg.imu_pckunt and ipi_inrqty = dsg.imu_inrqty and ipi_mtrqty = dsg.imu_mtrqty      
--LEFT JOIN IMMRKUP prd (nolock)   ON prd.imu_ventyp='P' and ipi_itmno= prd.imu_itmno and ipi_pckunt = prd.imu_pckunt and ipi_inrqty = prd.imu_inrqty and ipi_mtrqty = prd.imu_mtrqty      
LEFT JOIN IMPRCINF(nolock)  ON ipi_itmno= imu_itmno and ipi_pckunt = imu_pckunt and ipi_inrqty = imu_inrqty and ipi_mtrqty = imu_mtrqty
--LEFT JOIN SYFMLINF (nolock)  ON dsg.imu_fmlopt = yfi_fmlopt    
LEFT JOIN SYFMLINF (nolock)  ON imu_fmlopt = yfi_fmlopt 
--LEFT JOIN VNBASINF prdPven  (nolock)  ON prd.imu_prdven = prdPven.vbi_venno      
--LEFT JOIN VNBASINF dsgPven  (nolock)  ON dsg.imu_prdven = dsgPven.vbi_venno
LEFT JOIN VNBASINF (nolock)  ON imu_prdven = vbi_venno
LEFT JOIN IMBOMASS  (nolock)   ON ibi.ibi_itmno = iba_itmno and iba_typ = 'BOM'       
LEFT JOIN IMBASINF bom  (nolock)  on iba_assitm = bom.ibi_itmno      
LEFT JOIN SYCATCDE  (nolock) ON ibi.ibi_catlvl4 = ycc_catcde and ycc_level = 4      
LEFT JOIN IMCOLINF (nolock) ON ibi.ibi_itmno = icf_itmno 	
LEFT JOIN CUBASINF pri ON imu_cus1no = pri.CBI_CUSNO
LEFT JOIN CUBASINF sec ON imu_cus2no = sec.CBI_CUSNO
LEFT JOIN IMCSTINF on ICI_ITMNO = ibi.IBI_ITMNO
where 
--((ibi.ibi_upddat >= @dateFm and ibi.ibi_upddat <= @dateTo)or(prd.imu_upddat >= @dateFm and prd.imu_upddat <= @dateTo)or(dsg.imu_upddat >= @dateFm and dsg.imu_upddat <= @dateTo))
((ibi.ibi_upddat >= @dateFm and ibi.ibi_upddat <= @dateTo)or(imu_upddat >= @dateFm and imu_upddat <= @dateTo))
and ((@flg_catlvl4 = 'N') or (@flg_catlvl4 = 'Y' and ibi.ibi_catlvl4 >= @catFm and ibi.ibi_catlvl4 <= @catTo))
--and ((@flg_dv = 'N') or (@flg_dv = 'Y' and ibi.ibi_venno >= @dsgVenNoFm and ibi.ibi_venno <= @dsgVenNoTo))  
 and 	(@VenEmpty='Y' or ibi.ibi_venno  in (select tempVen from #tempVENno) )
and (@Cus1Empty = 'Y'or imu_cus1no in (select tempCus1no from #tempCus1no))
and (@Cus2Empty = 'Y'or imu_cus2no in (select tempCus2no from #tempCus2no))
--and ((@flg_pv = 'N') or (@flg_pv = 'Y' and prd.imu_prdven >= @prdVenNoFm and prd.imu_prdven <= @prdVenNoTo))
and ((@flg_pv = 'N') or (@flg_pv = 'Y' and imu_prdven >= @prdVenNoFm and imu_prdven <= @prdVenNoTo))
and ((@flg_sts = 'N') or (@flg_sts = 'Y' and ibi.ibi_itmsts = @STS))
and (@period=left(convert(varchar(20), ipi_qutdat,111),7) or @period='1900/01')
union
select       
ibi.ibi_itmno as 'Item No',  --1     
ibi.ibi_itmsts as 'Item Status',     
ibi.ibi_engdsc as 'English Description', --17      
ibi.ibi_lnecde as 'Product Line',      
ibi.ibi_catlvl4 + case isnull(ycc_catdsc,'') when '' then '' else ' - ' + ycc_catdsc end  as 'Category' ,      
icf_colcde as 'Color Code',
ipi_pckunt as 'UM',  --2       
ipi_inrqty as 'Inner',  --3       
ipi_mtrqty as 'Master',  --4   
ipi_cft as 'CFT',  --5   
imu_ftyprctrm as 'FTY Prc Trm',
imu_hkprctrm as 'HK Prc Trm',
imu_trantrm as 'Tran Trm',        
case left(convert(varchar(20), ipi_qutdat,111),7) when '1900/01' then '' else left(convert(varchar(20), ipi_qutdat,111),7) end as 'Period',   
ipi_pckitr as 'Packing Instruction', --6      
isnull(imu_cus1no,'') as 'Pri. Cus. No.',
isnull(pri.cbi_cussna,'') as 'Pri. Cus. Name',
isnull(imu_cus2no,'') as 'Sec. Cus. No.',
isnull(sec.cbi_cussna,'') as 'Sec. Cus. Name',
--dsg.imu_ftycst as 'Fty Cost', --7      
--dsg.imu_ftyprc as 'Item Cost', --8
imu_ftycst as 'Fty Cost', --7      
imu_ftyprc as 'Item Cost', --8
/*
case isnull(dsg.imu_fmlopt,'') when '' then '' else       
case isnull(yfi_fml,'') when '' then  dsg.imu_fmlopt else dsg.imu_fmlopt + ' - ' + yfi_fml end       
end as 'Formula',  --9
*/
case isnull(imu_fmlopt,'') when '' then '' else case isnull(yfi_fml,'') when '' then imu_fmlopt else imu_fmlopt + ' - ' + yfi_fml end end as 'Formula',  --9
isnull(iba_assitm,'')  as 'BOM Item No.', --10      
isnull(bom.ibi_engdsc,'') as 'Item Description', --11      
iba_untcst as 'BOM Cost',      
case isnull(iba_bomqty,0) when 0 then ''  else ltrim(str(iba_bomqty)) end as 'Qty of Bom Per Item',      
iba_bombasprc as 'BOM Price',      
--prd.imu_basprc as 'Basic Price', --14      
--prd.imu_calftyprc as 'Calculated', -- 15      
--prd.imu_negprc as 'Negotiated', --16
imu_basprc as 'Basic Price', --14        
imu_negprc as 'Negotiated', --16
/*
case isnull(prd.imu_prdven,'') when '' then       
dsg.imu_prdven + case isnull(dsgPven.vbi_vensna,'') when '' then '' else ' -' + dsgPven.vbi_vensna end      
else      
prd.imu_prdven + case isnull(prdPven.vbi_vensna,'') when '' then '' else ' -' + prdPven.vbi_vensna end      
end  as 'Production Vendor1'  --18
*/
imu_prdven + case isnull(vbi_vensna,'') when '' then '' else ' -' + vbi_vensna end as 'Production Vendor1'  --18
,ibi.ibi_alsitmno as 'Alias No'
,ibi.ibi_rmk as 'Item Remark'
,isnull(convert(varchar(20),imu_expdat,111),'') as 'Cost Expiry Date'    
,isnull(ici_cstrmk,'') as 'Cost Remark'    
,@compName as 'compName'       
FROM IMBASINFH ibi (nolock)      
LEFT JOIN IMPCKINFH (nolock)  ON ibi.ibi_itmno = ipi_itmno      
--LEFT JOIN IMMRKUPH dsg   (nolock)  ON dsg.imu_ventyp='D' and ipi_itmno= dsg.imu_itmno and ipi_pckunt = dsg.imu_pckunt and ipi_inrqty = dsg.imu_inrqty and ipi_mtrqty = dsg.imu_mtrqty      
--LEFT JOIN IMMRKUPH prd  (nolock)   ON prd.imu_ventyp='P' and ipi_itmno= prd.imu_itmno and ipi_pckunt = prd.imu_pckunt and ipi_inrqty = prd.imu_inrqty and ipi_mtrqty = prd.imu_mtrqty      
LEFT JOIN IMPRCINFH (nolock)  ON ipi_itmno= imu_itmno and ipi_pckunt = imu_pckunt and ipi_inrqty = imu_inrqty and ipi_mtrqty = imu_mtrqty
--LEFT JOIN SYFMLINF  (nolock)  ON dsg.imu_fmlopt = yfi_fmlopt
LEFT JOIN SYFMLINF  (nolock)  ON imu_fmlopt = yfi_fmlopt
--LEFT JOIN VNBASINF prdPven  (nolock)  ON prd.imu_prdven = prdPven.vbi_venno      
--LEFT JOIN VNBASINF dsgPven  (nolock)  ON dsg.imu_prdven = dsgPven.vbi_venno      
LEFT JOIN VNBASINF (nolock)  ON imu_prdven = vbi_venno
LEFT JOIN IMBOMASSH  (nolock)   ON ibi.ibi_itmno = iba_itmno and iba_typ = 'BOM'       
LEFT JOIN IMBASINFH bom  (nolock)  on iba_assitm = bom.ibi_itmno      
LEFT JOIN SYCATCDE  (nolock) ON ibi.ibi_catlvl4 = ycc_catcde and ycc_level = 4      
LEFT JOIN IMCOLINFH (nolock) ON ibi.ibi_itmno = icf_itmno 	
LEFT JOIN CUBASINF pri ON imu_cus1no = pri.CBI_CUSNO
LEFT JOIN CUBASINF sec ON imu_cus2no = sec.CBI_CUSNO
LEFT JOIN IMCSTINFH on ICI_ITMNO = ibi.IBI_ITMNO
where 
--((ibi.ibi_upddat >= @dateFm and ibi.ibi_upddat <= @dateTo)or(prd.imu_upddat >= @dateFm and prd.imu_upddat <= @dateTo)or(dsg.imu_upddat >= @dateFm and dsg.imu_upddat <= @dateTo))
((ibi.ibi_upddat >= @dateFm and ibi.ibi_upddat <= @dateTo)or(imu_upddat >= @dateFm and imu_upddat <= @dateTo))
and ((@flg_catlvl4 = 'N') or (@flg_catlvl4 = 'Y' and ibi.ibi_catlvl4 >= @catFm and ibi.ibi_catlvl4 <= @catTo))
--and ((@flg_dv = 'N') or (@flg_dv = 'Y' and ibi.ibi_venno >= @dsgVenNoFm and ibi.ibi_venno <= @dsgVenNoTo))  
 and 	(@VenEmpty='Y' or ibi.ibi_venno  in (select tempVen from #tempVENno) )
and (@Cus1Empty = 'Y'or imu_cus1no in (select tempCus1no from #tempCus1no))
and (@Cus2Empty = 'Y'or imu_cus2no in (select tempCus2no from #tempCus2no))
--and ((@flg_pv = 'N') or (@flg_pv = 'Y' and prd.imu_prdven >= @prdVenNoFm and prd.imu_prdven <= @prdVenNoTo))
and ((@flg_pv = 'N') or (@flg_pv = 'Y' and imu_prdven >= @prdVenNoFm and imu_prdven <= @prdVenNoTo))
and ((@flg_sts = 'N') or (@flg_sts = 'Y' and ibi.ibi_itmsts = @STS))
and (@period=left(convert(varchar(20), ipi_qutdat,111),7) or @period='1900/01')
order by 1,20,5,6,7 

end




drop table #tmp_ItmLst        	


end      

   
END








GO
GRANT EXECUTE ON [dbo].[sp_select_IMR00017] TO [ERPUSER] AS [dbo]
GO
