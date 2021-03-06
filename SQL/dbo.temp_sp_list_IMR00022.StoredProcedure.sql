/****** Object:  StoredProcedure [dbo].[temp_sp_list_IMR00022]    Script Date: 09/29/2017 15:29:08 ******/
DROP PROCEDURE [dbo].[temp_sp_list_IMR00022]
GO
/****** Object:  StoredProcedure [dbo].[temp_sp_list_IMR00022]    Script Date: 09/29/2017 15:29:10 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO





create procedure [dbo].[temp_sp_list_IMR00022]
@cocde	varchar(6) , 
@ItemList varchar(800) , 
@CustAls varchar(800) , 
@custfm varchar(20) , 
@custto varchar(20) , 
@Sort varchar(3) = 'ITM'
as
begin

declare
	@optCust char(1),
	@optItem char(1),
	@optAlias char(1)

declare 	@tmp_Remain as varchar(800),
	@tmp_Part as varchar(20)
	
	

create table #_Item(
itm varchar(30)
)

create table #_Alias(
als varchar(30)
)

set @optCust = 'N'
if len(@custfm) > 0
begin
	set @optCust = 'Y'
end

set @optItem = 'N'
if len(@ItemList) > 0
begin
	set @optItem = 'Y'
end

set @optAlias = 'N'
if len(@CustAls) > 0
begin
	set @optAlias = 'Y'
end


--Trim space
set @tmp_Remain = ltrim(rtrim(@ItemList))
if @tmp_Remain<>'' 
begin

--XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX
--Insert the item no in the @ItmLst string into the temp table	
set @tmp_Part = ''
while charindex(',',@tmp_Remain)<> 0 
begin
	set @tmp_Part = ltrim(rtrim(left(@tmp_Remain,charindex(',',@tmp_Remain)-1)))
	set @tmp_Remain = ltrim(rtrim(right(@tmp_Remain,len(@tmp_Remain) - charindex(',',@tmp_Remain))))
	insert into #_Item values(@tmp_Part)
end 
insert  into #_Item values(@tmp_Remain)
end
--XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX
		


--Trim space
set @tmp_Remain = ltrim(rtrim(@CustAls))
if @tmp_Remain<>'' 
begin

--XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX
--Insert the item no in the @ItmLst string into the temp table	
set @tmp_Part = ''
while charindex(',',@tmp_Remain)<> 0 
begin
	set @tmp_Part = ltrim(rtrim(left(@tmp_Remain,charindex(',',@tmp_Remain)-1)))
	set @tmp_Remain = ltrim(rtrim(right(@tmp_Remain,len(@tmp_Remain) - charindex(',',@tmp_Remain))))
	insert into #_Alias values(@tmp_Part)
end 
insert  into #_Alias values(@tmp_Remain)
end
--XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX
		









-- Changed by Mark Lau 20090115
/*
	select 
		ica_itmno as 'Item #', 
		isnull(ibi_engdsc, '') as 'Item Description' , 
		ica_cusno as 'Cust #' , 
		isnull(cbi_cussna,'') as 'Customer Name' , 
		ica_cusalsitm as 'Cust. Alias Item #'
	from IMCUSALS
	left join IMBASINF on ica_itmno  = ibi_itmno
	left join CUBASINF on ica_cusno = cbi_cusno and cbi_custyp = 'P'
	left join #_Item on ica_itmno = itm
	left join #_Alias on ica_cusalsitm = als
	where ica_apvsts = 'Y'
	and (@optCust = 'N' or (@optCust = 'Y' and isnull(cbi_cusno,'') between @custfm and @custto))
	and (@optItem = 'N' or (@optItem = 'Y' and itm is not null ))
	and (@optAlias = 'N' or (@optAlias = 'Y' and als is not null ))
	-- ITM: Item, Customer , Alias Item
	-- CUS: Customer, Alias Item, Item
	-- ALS: Alias Item, Customer, Item
	order by 
		case @Sort when 'ITM' then  ica_itmno
			  when 'CUS' then ica_cusno
			 else ica_cusalsitm end, 
		case @Sort when 'ITM' then ica_cusno
			 when 'CUS' then ica_cusalsitm
			else ica_cusno end , 
		case @Sort when 'ITM' then ica_cusalsitm
			  when 'CUS' then ica_itmno
			else ica_itmno end 
*/

	select 
		ics_itmno as 'Item #', 
		isnull(ibi_engdsc, '') as 'Item Description' , 
		ics_cusno as 'Cust #' , 
		isnull(cbi_cussna,'') as 'Customer Name' , 
		ics_cusstyno as 'Cust. Alias Item #'
	from IMCUSSTY
	left join IMBASINF on ics_itmno  = ibi_itmno
	left join CUBASINF on ics_cusno = cbi_cusno and cbi_custyp = 'P'
	left join #_Item on ics_itmno = itm
	left join #_Alias on ics_cusstyno = als
	where (@optCust = 'N' or (@optCust = 'Y' and isnull(cbi_cusno,'') between @custfm and @custto))
	and (@optItem = 'N' or (@optItem = 'Y' and itm is not null ))
	and (@optAlias = 'N' or (@optAlias = 'Y' and als is not null ))
	-- ITM: Item, Customer , Alias Item
	-- CUS: Customer, Alias Item, Item
	-- ALS: Alias Item, Customer, Item
	order by 
		case @Sort when 'ITM' then  ics_itmno
			  when 'CUS' then ics_cusno
			 else ics_cusstyno end, 
		case @Sort when 'ITM' then ics_cusno
			 when 'CUS' then ics_cusstyno
			else ics_cusno end , 
		case @Sort when 'ITM' then ics_cusstyno
			  when 'CUS' then ics_itmno
			else ics_itmno end 
end







GO
GRANT EXECUTE ON [dbo].[temp_sp_list_IMR00022] TO [ERPUSER] AS [dbo]
GO
