/****** Object:  StoredProcedure [dbo].[sp_select_IAR00002]    Script Date: 09/29/2017 15:29:09 ******/
DROP PROCEDURE [dbo].[sp_select_IAR00002]
GO
/****** Object:  StoredProcedure [dbo].[sp_select_IAR00002]    Script Date: 09/29/2017 15:29:10 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

















/*  
=========================================================  
Program ID : sp_select_IAR00002  
Description    :   
Programmer   :   
ALTER  Date    :   
Last Modified   :   
Table Read(s)  :  
Table Write(s)  :  
=========================================================  
 Modification History                                      
=========================================================  
 Date        Initial    Description                            
=========================================================      
05/06/2003  Allan Yuen  Relocate Audit Log Table Location    
07/10/2004  Allan Yuen  Bug Fix date range grouping error.  
08/24/2004  Lester Wu  Add alias name to retrieved fields  
10/05/2004  Lester Wu  Add  "NOLOCK" to tables selected  
30/12/2004  Allan Yuen  Add cater imbasinf_aud in difference year.
13/08/2012  David Yue	Replaced IMMRKUP with IMPRCINF
*/  
  
--sp_select_IAR00002 'UCPP','''01A0403661101'''  
  
CREATE   procedure [dbo].[sp_select_IAR00002]  
                                                                                                                                                                                                                                                               
    
---------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
  
@cocde nvarchar(6),  
@itmlst varchar(300)     ,
@cus1nolist     varchar(1000)  ,
@cus2nolist     varchar(1000)  ,
@vennolist     varchar(1000)                                           
---------------------------------------------   
   
AS  
  
  
DECLARE   
 @itmlst2 varchar(500),  
 @dummy varchar(20),  
 @TIME int,  
 @LASTYEAR VARCHAR(4)  
  
  declare
@i 		int,		@start 		varchar(20),	@end 		nvarchar(20),
@value		varchar(20),	@condition 	varchar(3000),	@itmnoqry	varchar(2000),
@cus1qry 	varchar(2000),	@cus2qry 	varchar(2000),	@dvqry		varchar(2000)

SELECT @LASTYEAR  = CONVERT(VARCHAR(4),YEAR(GETDATE())-1)  
  
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
if len(rtrim(ltrim(replace(@vennolist,'''','')))) <= 0 
begin
	set @VenEmpty = 'Y'
end 
  
SET @itmlst2 = ''  
  
--Lester Wu 2005-04-06, retrieve company name from database  
declare @compName varchar(100)  
select @compName = yco_conam from SYCOMINF(NOLOCK) where yco_cocde=@cocde  
if @cocde<>'MS'   
begin  
 set @compName = 'UNITED CHINESE GROUP'  
end  
-----------------------------------------------------------------------------  
  
  
DECLARE ALSITMNO_cursor CURSOR FOR   
 SELECT   
  IBI_ALSITMNO   
 FROM   
  IMBASINF (NOLOCK)   
 WHERE   
  IBI_ITMNO IN (@itmlst) AND IBI_ALSITMNO  <> ''  
  
OPEN ALSITMNO_cursor   
  
FETCH NEXT FROM ALSITMNO_cursor INTO @dummy   
SET @TIME = 1  
  
  
WHILE @@FETCH_STATUS = 0  
BEGIN  
 if @TIME = 1   
  SET @itmlst2 = @itmlst2  + '''' + @dummy + ''''  
 ELSE  
  SET @itmlst2 = @itmlst2  + ',' + '''' + @dummy + ''''  
 SET @TIME = @TIME + 1   
 FETCH NEXT FROM ALSITMNO_cursor INTO @dummy   
END  
  
  
  
  
close ALSITMNO_cursor   
deallocate ALSITMNO_cursor   
  
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

	if ltrim(rtrim(@vennolist)) <> ''
	begin
		set @dvqry = ''
		set @i = 0
	
		while charindex(',',@vennolist) <> 0
		begin
			set @i = charindex(',',@vennolist)
			if @i = 0 and charindex(@vennolist,@dvqry) = 0
				set @i = len(@vennolist)
			set @value = substring(@vennolist, 0, @i)
			set @vennolist = substring(@vennolist,@i+1,len(@vennolist)-@i)
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
	
		if charindex(@vennolist, @dvqry) = 0
		begin
			if charindex('~',@vennolist) > 0
			begin
				set @i = charindex('~',@vennolist)
				set @start = substring(@vennolist, 0, @i)
				set @end = substring(@vennolist, @i+1,len(@vennolist))
				set @dvqry = @dvqry + case len(@dvqry) when 0 then '' else ' or vbi_venno ' end + 'between ''' + @start + ''' and ''' + @end + ''''
			end
			else
			begin
				set @dvqry = @dvqry + case len(@dvqry) when 0 then '' else ' or vbi_venno ' end + '= ''' + @vennolist + ''''
			end
		end
	
		set @dvqry = ' where vbi_venno ' + @dvqry
	end -- if ltrim(rtrim(@vennolist)) <> ''
	--select @dvqry

	--select ('insert into #tempVENno select distinct  vbi_venno from VNBASINF'+@dvqry)
	exec ('insert into #tempVENno select distinct  vbi_venno from VNBASINF'+@dvqry)
	--select * from #tempVENno
end
---------------------------
----------------------venno part end

if @itmlst2 = ''   
 set @itmlst2 = replace(@itmlst,'''','')  

CREATE TABLE #PREPROCESS
(
	ibi_itmno nvarchar(20),
	ipi_pckseq int,
	ipi_pckunt nvarchar(255),
	imu_ftyprc nvarchar(255),
	imu_basprc nvarchar(255),
	ipi_credat nvarchar(20),
	beforepacking nvarchar(50),
	afterpacking nvarchar(50),
	beforeftyprc nvarchar(255), 
	afterftyprc nvarchar(255),
	yfi_prcfml nvarchar(100),
	ibi_engdsc nvarchar(255),
	existflag char(1),  
	ibi_cocde nvarchar(4),
	ivi_venitm nvarchar(20),
	compName nvarchar(30)
)

CREATE TABLE #PACKGRP
(
	ibi_itmno nvarchar(20),
	ipi_pckseq int,
	ipi_pckunt nvarchar(255),
	imu_ftyprc nvarchar(255),
	imu_basprc nvarchar(255),
	ipi_credat nvarchar(20),
	beforepacking nvarchar(50),
	afterpacking nvarchar(50),
	beforeftyprc nvarchar(255), 
	afterftyprc nvarchar(255),
	yfi_prcfml nvarchar(100),
	ibi_engdsc nvarchar(255),
	existflag char(1),  
	ibi_cocde nvarchar(4),
	ivi_venitm nvarchar(20),
	compName nvarchar(30)
)

CREATE TABLE #PRICEGRP
(
	ibi_itmno nvarchar(20),
	ipi_pckseq int,
	ipi_pckunt nvarchar(255),
	imu_ftyprc nvarchar(255),
	imu_basprc nvarchar(255),
	ipi_credat nvarchar(20),
	beforepacking nvarchar(50),
	afterpacking nvarchar(50),
	beforeftyprc nvarchar(255), 
	afterftyprc nvarchar(255),
	yfi_prcfml nvarchar(100),
	ibi_engdsc nvarchar(255),
	existflag char(1),  
	ibi_cocde nvarchar(4),
	ivi_venitm nvarchar(20),
	compName nvarchar(30)
)

CREATE TABLE #PRERESULT
(
	ibi_itmno nvarchar(20),
	ipi_pckseq int,
	ipi_pckunt nvarchar(255),
	imu_ftyprc nvarchar(255),
	imu_basprc nvarchar(255),
	ipi_credat nvarchar(20),
	beforepacking nvarchar(50),
	afterpacking nvarchar(50),
	beforeftyprc nvarchar(255), 
	afterftyprc nvarchar(255),
	yfi_prcfml nvarchar(100),
	ibi_engdsc nvarchar(255),
	existflag char(1),  
	ibi_cocde nvarchar(4),
	ivi_venitm nvarchar(20),
	compName nvarchar(30)
)

CREATE TABLE #PRERESULT2
(
	tmp_seq smallint IDENTITY(1,1) PRIMARY KEY CLUSTERED,
	ibi_itmno nvarchar(20),
	ipi_pckseq int,
	ipi_pckunt nvarchar(255),
	imu_ftyprc nvarchar(255),
	imu_basprc nvarchar(255),
	ipi_credat nvarchar(20),
	beforepacking nvarchar(50),
	afterpacking nvarchar(50),
	beforeftyprc nvarchar(255), 
	afterftyprc nvarchar(255),
	yfi_prcfml nvarchar(100),
	ibi_engdsc nvarchar(255),
	existflag char(1),  
	ibi_cocde nvarchar(4),
	ivi_venitm nvarchar(20),
	compName nvarchar(30)
)


CREATE TABLE #PACKING
(
	tmp_seq smallint IDENTITY(1,1) PRIMARY KEY CLUSTERED,
	ibi_itmno nvarchar(20),
	ipi_pckseq int,
	ipi_pckunt nvarchar(255),
	imu_ftyprc nvarchar(255),
	imu_basprc nvarchar(255),
	ipi_credat nvarchar(20),
	beforepacking nvarchar(50),
	afterpacking nvarchar(50),
	beforeftyprc nvarchar(255), 
	afterftyprc nvarchar(255),
	yfi_prcfml nvarchar(100),
	ibi_engdsc nvarchar(255),
	existflag char(1),  
	ibi_cocde nvarchar(4),
	ivi_venitm nvarchar(20),
	compName nvarchar(30)
)


CREATE TABLE #PRICE
(
	tmp_seq smallint IDENTITY(1,1) PRIMARY KEY CLUSTERED,
	ibi_itmno nvarchar(20),
	ipi_pckseq int,
	ipi_pckunt nvarchar(255),
	imu_ftyprc nvarchar(255),
	imu_basprc nvarchar(255),
	ipi_credat nvarchar(20),
	beforepacking nvarchar(50),
	afterpacking nvarchar(50),
	beforeftyprc nvarchar(255), 
	afterftyprc nvarchar(255),
	yfi_prcfml nvarchar(100),
	ibi_engdsc nvarchar(255),
	existflag char(1),  
	ibi_cocde nvarchar(4),
	ivi_venitm nvarchar(20),
	compName nvarchar(30)
)
  
  
SET ANSI_WARNINGS OFF   
  
begin  
--the following string is not written by me, but I doubt the nessesary that prvious coder wrote it as string to execute but not write sql command directly
exec('  
insert into #PREPROCESS
select DISTINCT  
 bas.ibi_itmno as ''ibi_itmno'',   
 cpk.ipi_pckseq as ''ipi_pckseq'',   
 cpk.ipi_pckunt+''/''+ltrim(str(cpk.ipi_inrqty))+''/''+ltrim(str(cpk.ipi_mtrqty))+''/''+ltrim(str(cpk.ipi_cft,10,2)) as ''ipi_pckunt'',  
 cmk.imu_curcde + ltrim(str(cmk.imu_ftyprc,10,4)) as ''imu_ftyprc'',  
 isnull(cmk.imu_bcurcde,'''') + ltrim(str(cmk.imu_basprc,10,4)) as ''imu_basprc'',  
 CONVERT(CHAR(20),hpk.ipi_credat,120) as ''ipi_credat'',  
 MAX(CASE hpk.ipi_actflg_aud   
  WHEN 2 then hpk.ipi_pckunt+''/''+ltrim(str(hpk.ipi_inrqty))+''/''+ltrim(str(hpk.ipi_mtrqty))+''/''+ltrim(str(hpk.ipi_cft,10,2))+'';''+rtrim(ltrim(str(year(hpk.ipi_qutdat))))+''-''+right(''0''+ltrim(rtrim(str(month(hpk.ipi_qutdat)))),2)  
  ELSE NULL END) as ''beforepacking'',  
 MAX(CASE hpk.ipi_actflg_aud   
  WHEN 3 then hpk.ipi_pckunt+''/''+ltrim(str(hpk.ipi_inrqty))+''/''+ltrim(str(hpk.ipi_mtrqty))+''/''+ltrim(str(hpk.ipi_cft,10,2))+'';''+rtrim(ltrim(str(year(hpk.ipi_qutdat))))+''-''+right(''0''+ltrim(rtrim(str(month(hpk.ipi_qutdat)))),2)   
  ELSE NULL END) as ''afterpacking'',  
 '''' as ''beforeftyprc'', '''' as ''afterftyprc'',  
 ltrim(fml.yfi_fmlopt) + '' - '' + ltrim(fml.yfi_fml) as ''yfi_prcfml'',  
 bas.ibi_engdsc as ''ibi_engdsc'',  
 existflag = Max(Case isnull(vw.qud_itmno, '''') when '''' then ''N'' else ''Y'' end),  
 bas.ibi_cocde as ''ibi_cocde'',  ivi_venitm as ''ivi_venitm''  
 ,''' + @compName + ''' as ''compName''  
FROM IMBASINF bas (NOLOCK)
left join IMPCKINF cpk (NOLOCK) on  bas.ibi_itmno = cpk.ipi_itmno
left join UCPERPDB_AUD.DBO.IMPCKINF_AUD hpk (NOLOCK) on 
	 cpk.ipi_itmno = hpk.ipi_itmno and   
	 cpk.ipi_pckseq = hpk.ipi_pckseq 
left join IMPRCINF cmk (NOLOCK) on 
	 cpk.ipi_itmno = cmk.imu_itmno and   
	 cpk.ipi_pckunt = cmk.imu_pckunt and
	 cpk.ipi_inrqty = cmk.imu_inrqty and
	 cpk.ipi_mtrqty = cmk.imu_inrqty
left join SYFMLINF fml (NOLOCK) on  cmk.imu_fmlopt = fml.yfi_fmlopt
left join vw_select_iar00002 vw  (nolock) on cpk.ipi_itmno = vw.qud_itmno and cpk.ipi_pckseq = vw.qud_pckseq
left join IMVENINF (NOLOCK) on  bas.ibi_itmno = ivi_itmno and ivi_venno = bas.ibi_venno
WHERE  
 bas.ibi_itmno IN  (' + @itmlst + ',''' + @itmlst2  + ''')  and
 (hpk.ipi_actflg_aud = 2 or hpk.ipi_actflg_aud = 3) and   
 cmk.imu_ventyp = ''D'' 	and
	('''+@Cus1Empty+''' = ''Y'' or cpk.ipi_cus1no in (select tempCus1no from #tempCus1no))and
	('''+@Cus2Empty+''' = ''Y'' or cpk.ipi_cus2no in (select tempCus2no from #tempCus2no) )and 
	('''+@VenEmpty+'''=''Y'' or ibi_venno in (select tempVen from #tempVENno) )
GROUP BY   
 bas.ibi_itmno,   
 bas.ibi_engdsc,  
 cpk.ipi_pckseq,   
 cpk.ipi_pckunt+''/''+ltrim(str(cpk.ipi_inrqty))+''/''+ltrim(str(cpk.ipi_mtrqty))+''/''+ltrim(str(cpk.ipi_cft,10,2)),  
 cmk.imu_curcde + ltrim(str(cmk.imu_ftyprc,10,4)),  
 isnull(cmk.imu_bcurcde,'''') + ltrim(str(cmk.imu_basprc,10,4)),  
 ltrim(fml.yfi_fmlopt) + '' - '' + ltrim(fml.yfi_fml),  
 CONVERT(CHAR(20),hpk.ipi_credat,120) ,  
 bas.ibi_cocde,  
 ivi_venitm  
HAVING MAX(CASE hpk.ipi_actflg_aud   
  WHEN 2 then hpk.ipi_pckunt+''/''+ltrim(str(hpk.ipi_inrqty))+''/''+ltrim(str(hpk.ipi_mtrqty))+''/''+ltrim(str(hpk.ipi_cft,10,2))+'';''+rtrim(ltrim(str(year(hpk.ipi_qutdat)))) +''-''+  right(''0'' + ltrim(rtrim(str(month(hpk.ipi_qutdat)))),2)  
  ELSE NULL END) <>  
 MAX(CASE hpk.ipi_actflg_aud   
  WHEN 3 then hpk.ipi_pckunt+''/''+ltrim(str(hpk.ipi_inrqty))+''/''+ltrim(str(hpk.ipi_mtrqty))+''/''+ltrim(str(hpk.ipi_cft,10,2))+'';''+rtrim(ltrim(str(year(hpk.ipi_qutdat)))) +''-''+  right(''0'' + ltrim(rtrim(str(month(hpk.ipi_qutdat)))),2)   
  ELSE NULL END)  

UNION  
  
select DISTINCT  
 bas.ibi_itmno,
 cpk.ipi_pckseq,   
 cmk.imu_pckunt+''/''+ltrim(str(cmk.imu_inrqty))+''/''+ltrim(str(cmk.imu_mtrqty))+''/''+ltrim(str(cmk.imu_cft,10,2)),  
 cmk.imu_curcde + ltrim(str(cmk.imu_ftyprc,10,4)),  
 isnull(cmk.imu_bcurcde,'''') + ltrim(str(cmk.imu_basprc,10,4)),  
 CONVERT(CHAR(20),hmk.imu_credat,120) ,  
 '''', '''',  
 MAX(CASE hmk.imu_actflg_aud   
  WHEN 2 then hmk.imu_curcde + ltrim(str(hmk.imu_ftyprc,10,4)) + '';'' + isnull(hmk.imu_bcurcde,'''') + ltrim(str(hmk.imu_basprc,10,4))  
  ELSE NULL END),  
 MAX(CASE hmk.imu_actflg_aud   
  WHEN 3 then hmk.imu_curcde + ltrim(str(hmk.imu_ftyprc,10,4)) + '';'' + isnull(hmk.imu_bcurcde,'''') + ltrim(str(hmk.imu_basprc,10,4))  
  ELSE NULL END),  
 ltrim(fml.yfi_fmlopt) + '' - '' + ltrim(fml.yfi_fml),  
 bas.ibi_engdsc,  
 existflag = Max(Case isnull(vw.qud_itmno, '''') when '''' then ''N'' else ''Y'' end),  
 bas.ibi_cocde, ivi_venitm  
 ,''' + @compName + ''' as ''compName''  
FROM IMBASINF bas (NOLOCK)
left join IMPRCINF cmk (NOLOCK) on bas.ibi_itmno = cmk.imu_itmno
left join UCPERPDB_AUD.DBO.IMPRCINF_AUD hmk (NOLOCK) on 
	 cmk.imu_itmno = hmk.imu_itmno and   
	 cmk.imu_pckunt = hmk.imu_pckunt and
	 cmk.imu_inrqty = hmk.imu_inrqty and
	 cmk.imu_mtrqty = hmk.imu_mtrqty and
	 cmk.imu_cus1no = hmk.imu_cus1no and
	 cmk.imu_cus2no = hmk.imu_cus2no and
	 cmk.imu_ftyprctrm = hmk.imu_ftyprctrm and
	 cmk.imu_hkprctrm = hmk.imu_hkprctrm and
	 cmk.imu_trantrm = hmk.imu_trantrm and
	 cmk.imu_ventyp = hmk.imu_ventyp
left join SYFMLINF fml (NOLOCK) on  cmk.imu_fmlopt = fml.yfi_fmlopt
left join vw_select_iar00002 vw (nolock) on 
	cmk.imu_itmno = vw.qud_itmno and   
	cmk.imu_pckunt = vw.qud_untcde and
	cmk.imu_inrqty = vw.qud_inrqty and
	cmk.imu_mtrqty = vw.qud_mtrqty
left join IMVENINF (NOLOCK) on  bas.ibi_itmno = ivi_itmno and ivi_venno = bas.ibi_venno
left join IMPCKINF cpk (nolock) on 
	 cpk.ipi_itmno = cmk.imu_itmno and
	 cpk.ipi_pckunt = cmk.imu_pckunt and
	 cpk.ipi_inrqty = cmk.imu_inrqty and
	 cpk.ipi_mtrqty = cmk.imu_mtrqty
WHERE   
 bas.ibi_itmno IN (' + @itmlst + ',''' + @itmlst2 + ''') and
 (hmk.imu_actflg_aud = 2 or hmk.imu_actflg_aud = 3) and   
 cmk.imu_ventyp = ''D''and
	('''+@Cus1Empty+''' = ''Y'' or ipi_cus1no in (select tempCus1no from #tempCus1no))and
	('''+@Cus2Empty+''' = ''Y'' or ipi_cus2no in (select tempCus2no from #tempCus2no) )and 
	('''+@VenEmpty+'''=''Y'' or ibi_venno in (select tempVen from #tempVENno) )
GROUP BY   
 bas.ibi_itmno,  
 bas.ibi_engdsc ,  
 cpk.ipi_pckseq,
 cmk.imu_pckunt+''/''+ltrim(str(cmk.imu_inrqty))+''/''+ltrim(str(cmk.imu_mtrqty))+''/''+ltrim(str(cmk.imu_cft,10,2)),  
 cmk.imu_curcde + ltrim(str(cmk.imu_ftyprc,10,4)),  
 isnull(cmk.imu_bcurcde,'''') + ltrim(str(cmk.imu_basprc,10,4)),  
 ltrim(fml.yfi_fmlopt) + '' - '' + ltrim(fml.yfi_fml),  
 CONVERT(CHAR(20),hmk.imu_credat,120) ,  
 bas.ibi_cocde,  
 ivi_venitm  
HAVING  MAX(CASE hmk.imu_actflg_aud   
  WHEN 2 then hmk.imu_curcde + ltrim(str(hmk.imu_ftyprc,10,4)) + '';'' + isnull(hmk.imu_bcurcde,'''') + ltrim(str(hmk.imu_basprc,10,4))  
  ELSE NULL END) <>  
  MAX(CASE hmk.imu_actflg_aud   
  WHEN 3 then hmk.imu_curcde + ltrim(str(hmk.imu_ftyprc,10,4)) + '';'' + isnull(hmk.imu_bcurcde,'''') + ltrim(str(hmk.imu_basprc,10,4))  
  ELSE NULL END)' + 
'ORDER BY 1,4,5,3,6')  
  
---*** Merge all save day change into 1 line ***---
insert into #PACKING
select * from #PREPROCESS where isnull(beforeftyprc,'') = '' 

insert into #PRICE
select * from #PREPROCESS where isnull(beforepacking,'') = '' 

SELECT ibi_itmno, ipi_pckseq, CONVERT(CHAR(10), ipi_credat , 112) as 'grpdate', min(tmp_seq) as 'firstseq', max(tmp_seq) as 'lateseq' 
into #PACKFL
FROM #PACKING 
GROUP BY ibi_itmno, ipi_pckseq, CONVERT(CHAR(10), ipi_credat , 112);


insert into #PACKGRP
select 
	#PACKING.ibi_itmno,
	#PACKING.ipi_pckseq,
	ipi_pckunt,imu_ftyprc,
	imu_basprc,ipi_credat,
	beforepacking,'' as afterpacking,
	beforeftyprc, 
	afterftyprc,
	yfi_prcfml,
	ibi_engdsc,
	existflag,
	ibi_cocde,
	ivi_venitm,
	compName  
from #PACKING, #PACKFL 
where 
	CONVERT(CHAR(10), ipi_credat , 112) =  grpdate 
and 	tmp_seq = firstseq 
and 	#PACKING.ipi_pckseq = #PACKFL.ipi_pckseq
and	#PACKING.ibi_itmno = #PACKFL.ibi_itmno


insert into #PACKGRP
select 
	#PACKING.ibi_itmno,
	#PACKING.ipi_pckseq,
	ipi_pckunt,
	imu_ftyprc,
	imu_basprc,
	ipi_credat,'' as beforepacking,
	afterpacking,beforeftyprc, 
	afterftyprc,
	yfi_prcfml,
	ibi_engdsc,
	existflag,
	ibi_cocde,
	ivi_venitm,
	compName  
from #PACKING, #PACKFL 
where 
	CONVERT(CHAR(10), ipi_credat , 112) =  grpdate 
and 	tmp_seq = lateseq 
and 	#PACKING.ipi_pckseq = #PACKFL.ipi_pckseq
and	#PACKING.ibi_itmno = #PACKFL.ibi_itmno


insert into #PRERESULT
select  	
	ibi_itmno,	
	ipi_pckseq,
	ipi_pckunt,
	imu_ftyprc,
	imu_basprc,
	CONVERT(CHAR(10), 
	ipi_credat , 112),
	max(beforepacking),
	max(afterpacking),
	beforeftyprc, 
	afterftyprc,
	yfi_prcfml,
	ibi_engdsc,
	existflag,
	ibi_cocde,
	ivi_venitm,
	compName
from #PACKGRP
group by 
	ibi_itmno,
	ipi_pckseq,
	ipi_pckunt,
	imu_ftyprc,	
	imu_basprc,
	CONVERT(CHAR(10), 
	ipi_credat , 112),
	beforeftyprc, 
	afterftyprc,
	yfi_prcfml,	
	ibi_engdsc,
	existflag,
	ibi_cocde,
	ivi_venitm,
	compName

SELECT ibi_itmno, ipi_pckseq, CONVERT(CHAR(10), ipi_credat , 112) as 'grpdate', min(tmp_seq) as 'firstseq', max(tmp_seq) as 'lateseq' 
into #PRICEFL
FROM #PRICE 
GROUP BY ibi_itmno, ipi_pckseq, CONVERT(CHAR(10), ipi_credat , 112);

insert into #PRICEGRP
select 
	#PRICE.ibi_itmno,
	#PRICE.ipi_pckseq,
	ipi_pckunt,
	imu_ftyprc,
	imu_basprc,
	ipi_credat,
	beforepacking,
	afterpacking,
	beforeftyprc, 
	'' as afterftyprc,
	yfi_prcfml,
	ibi_engdsc,
	existflag,
	ibi_cocde,
	ivi_venitm,
	compName  
from #PRICE, #PRICEFL 
where 
	CONVERT(CHAR(10), ipi_credat , 112) =  grpdate 
and	tmp_seq = firstseq 
and 	#PRICE.ipi_pckseq = #PRICEFL.ipi_pckseq
and	#PRICE.ibi_itmno = #PRICEFL.ibi_itmno


insert into #PRICEGRP
select 
	#PRICE.ibi_itmno,
	#PRICE.ipi_pckseq,
	ipi_pckunt,
	imu_ftyprc,
	imu_basprc,
	ipi_credat,
	beforepacking,
	afterpacking,
	'' as beforeftyprc, 
	afterftyprc,
	yfi_prcfml,
	ibi_engdsc,
	existflag,
	ibi_cocde,
	ivi_venitm,
	compName  
from #PRICE, #PRICEFL 
where 
	CONVERT(CHAR(10), ipi_credat , 112) =  grpdate 
and 	tmp_seq = lateseq 
and 	#PRICE.ipi_pckseq = #PRICEFL.ipi_pckseq
and	#PRICE.ibi_itmno = #PRICEFL.ibi_itmno


--select * from #PRICEGRP
insert into #PRERESULT
select  ibi_itmno,ipi_pckseq,ipi_pckunt,imu_ftyprc,imu_basprc,CONVERT(CHAR(10), ipi_credat , 112),
	beforepacking,afterpacking,max(beforeftyprc), max(afterftyprc),yfi_prcfml,ibi_engdsc,existflag,ibi_cocde,ivi_venitm,compName
from #PRICEGRP
group by ibi_itmno,ipi_pckseq,ipi_pckunt,imu_ftyprc,imu_basprc,CONVERT(CHAR(10), ipi_credat , 112),
		beforepacking,afterpacking,yfi_prcfml,ibi_engdsc,existflag,ibi_cocde,ivi_venitm,compName



insert into #PRERESULT2
select  ibi_itmno,ipi_pckseq,ipi_pckunt,imu_ftyprc,imu_basprc,CONVERT(CHAR(10), ipi_credat , 112) as ipi_credat,
	max(beforepacking) as beforepacking,max(afterpacking) as afterpacking,max(beforeftyprc) as beforeftyprc, 
	max(afterftyprc) as afterftyprc,yfi_prcfml,ibi_engdsc,existflag,ibi_cocde,ivi_venitm,compName
from #PRERESULT
group by ibi_itmno,ipi_pckseq,ipi_pckunt,imu_ftyprc,imu_basprc,CONVERT(CHAR(10), ipi_credat , 112),
	yfi_prcfml,ibi_engdsc,existflag,ibi_cocde,ivi_venitm,compName
order by ibi_itmno, ipi_pckseq, ipi_credat





declare
@tmp_seq int, 
@pckseq int,
@itmno nvarchar(20),
@beforepacking nvarchar(255), 
@afterpacking nvarchar(255),
@beforeftyprc nvarchar(255),
@afterftyprc nvarchar(255)

DECLARE MissingFieldAsc_cursor CURSOR FOR   
	SELECT tmp_seq, ibi_itmno, ipi_pckseq, isnull(beforepacking,''), isnull(afterpacking,''), isnull(beforeftyprc,'') ,isnull(afterftyprc,'') 
	FROM #PRERESULT2 (nolock) 
	Order by ipi_pckseq ASC, tmp_seq ASC
OPEN MissingFieldAsc_cursor     
FETCH NEXT FROM MissingFieldAsc_cursor INTO @tmp_seq, @itmno ,@pckseq, @beforepacking, @afterpacking, @beforeftyprc ,@afterftyprc

WHILE @@FETCH_STATUS = 0  
BEGIN  
	if @tmp_seq > 1 
	begin
		if @afterpacking = '' 
		begin
			update #PRERESULT2 
			set beforepacking = 
				(select top 1 isnull(afterpacking,'') from #PRERESULT2 
				where tmp_seq = @tmp_seq - 1 and ipi_pckseq = @pckseq and ibi_itmno = @itmno)
			where tmp_seq = @tmp_seq	

			update #PRERESULT2 
			set afterpacking = 
				(select top 1 isnull(afterpacking,'') from #PRERESULT2 
				where tmp_seq = @tmp_seq - 1 and ipi_pckseq = @pckseq and ibi_itmno = @itmno)
			where tmp_seq = @tmp_seq	 
		end 		

		if @afterftyprc = '' 
		begin

			update #PRERESULT2 
			set beforeftyprc = 
				(select top 1 isnull(afterftyprc,'') from #PRERESULT2 
				where tmp_seq = @tmp_seq - 1 and ipi_pckseq = @pckseq and ibi_itmno = @itmno)
			where tmp_seq = @tmp_seq		

			update #PRERESULT2 set afterftyprc = 
				(select top 1 isnull(afterftyprc,'') from #PRERESULT2 
				where tmp_seq = @tmp_seq - 1 and ipi_pckseq = @pckseq and ibi_itmno = @itmno)
			where tmp_seq = @tmp_seq			 
		end 	
	end


 FETCH NEXT FROM MissingFieldAsc_cursor INTO @tmp_seq, @itmno, @pckseq, @beforepacking, @afterpacking, @beforeftyprc ,@afterftyprc
  
END  
close MissingFieldAsc_cursor   
deallocate MissingFieldAsc_cursor   



DECLARE MissingFieldDsc_cursor CURSOR FOR   
	SELECT tmp_seq, ibi_itmno, ipi_pckseq, isnull(beforepacking,''), isnull(afterpacking,''), isnull(beforeftyprc,'') ,isnull(afterftyprc,'') FROM #PRERESULT2 (nolock) 
	Order by ipi_pckseq DESC, tmp_seq DESC
OPEN MissingFieldDsc_cursor     
FETCH NEXT FROM MissingFieldDsc_cursor INTO @tmp_seq, @itmno ,@pckseq, @beforepacking, @afterpacking, @beforeftyprc ,@afterftyprc

WHILE @@FETCH_STATUS = 0  
BEGIN  
	if @beforepacking = '' 
	begin
		update #PRERESULT2 set beforepacking = 
			(select top 1 isnull(beforepacking,'') from #PRERESULT2 
			where tmp_seq = @tmp_seq + 1 and ipi_pckseq = @pckseq and ibi_itmno = @itmno)
		where tmp_seq = @tmp_seq
	
		update #PRERESULT2 set afterpacking = 
			(select top 1 isnull(beforepacking,'') from #PRERESULT2 
			where tmp_seq = @tmp_seq + 1 and ipi_pckseq = @pckseq and ibi_itmno = @itmno)
		where tmp_seq = @tmp_seq
	end 		
	
	if @beforeftyprc = '' 
	begin
	
		update #PRERESULT2 set beforeftyprc = 
			(select top 1 isnull(beforeftyprc,'') from #PRERESULT2 
--			where tmp_seq = @tmp_seq + 1)
			where tmp_seq = @tmp_seq + 1 and ipi_pckseq = @pckseq and ibi_itmno = @itmno)
		where tmp_seq = @tmp_seq	
	
		update #PRERESULT2 set afterftyprc = 
			(select top 1 isnull(beforeftyprc,'') from #PRERESULT2 
--			where tmp_seq = @tmp_seq + 1)
			where tmp_seq = @tmp_seq + 1 and ipi_pckseq = @pckseq and ibi_itmno = @itmno)
		where tmp_seq = @tmp_seq		 
	end 	

 FETCH NEXT FROM MissingFieldDsc_cursor INTO @tmp_seq, @itmno, @pckseq, @beforepacking, @afterpacking, @beforeftyprc ,@afterftyprc
  
END  
close MissingFieldDsc_cursor   
deallocate MissingFieldDsc_cursor   



select 
	ibi_itmno,
	ipi_pckseq,
	ipi_pckunt,
	imu_ftyprc,
	imu_basprc,
	ipi_credat,
	case when charindex(';',beforepacking) = 0 then beforepacking + ';' else
		case when right(ltrim(rtrim(beforepacking)),8) = ';1900-01' then left(ltrim(rtrim(beforepacking)),len(ltrim(rtrim(beforepacking))) - 7) else beforepacking end end as 'beforepacking',
	case when charindex(';',afterpacking) = 0 then afterpacking + ';' else
		case when right(ltrim(rtrim(afterpacking)),8) = ';1900-01' then left(ltrim(rtrim(afterpacking)),len(ltrim(rtrim(afterpacking))) - 7) else afterpacking end end as 'afterpacking',
--	beforepacking,
--	afterpacking,
	beforeftyprc,
	afterftyprc,	
	yfi_prcfml,
	ibi_engdsc,
	existflag,
	ibi_cocde,
	ivi_venitm,	
	compName
from 
	#PRERESULT2 
order by 
	ipi_pckseq, ipi_credat



drop table #PREPROCESS

drop table #PACKING
drop table #PACKFL
drop table #PACKGRP

drop table #PRICE
drop table #PRICEFL
drop table #PRICEGRP

drop table #PRERESULT
drop table #PRERESULT2

 

  
SET ANSI_WARNINGS ON  
end  













GO
GRANT EXECUTE ON [dbo].[sp_select_IAR00002] TO [ERPUSER] AS [dbo]
GO
