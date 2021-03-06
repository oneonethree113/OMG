/****** Object:  StoredProcedure [dbo].[sp_select_IAR00003]    Script Date: 09/29/2017 15:29:09 ******/
DROP PROCEDURE [dbo].[sp_select_IAR00003]
GO
/****** Object:  StoredProcedure [dbo].[sp_select_IAR00003]    Script Date: 09/29/2017 15:29:10 ******/
SET ANSI_NULLS OFF
GO
SET QUOTED_IDENTIFIER OFF
GO





/*
=======================================================
Modification History
=======================================================
Date		Initial		Description
=======================================================
2004/07/14		Lester Wu		rewrite the query string to return Regualr and Assortment Item No with Item Type
				Add field to indicate return assortment item no or not
2005-04-06	Lester Wu		retrieve company name from database
*/


--sp_select_IAR00003 'ALL','*020005-33960*031372-00101*020005-33960*031372-00101*020005-33960*031372-00101*020005-33960*031372-00101*020005-33960*031372-00101*','1'
--sp_select_IAR00003 'ALL','031372-00101*031372-00101','1'

CREATE PROCEDURE [dbo].[sp_select_IAR00003] 

@cocde	nvarchar(6),
@itmlst	varchar(4000),
--Lester Wu 2004/07/14 add field to indicate return assortment item no or not
@cus1nolist     varchar(1000)  ,
@cus2nolist     varchar(1000)  ,
@vennolist     varchar(1000),
@OPTASS	nvarchar(1)
AS


--select replace(@itmlst,'''','')
--set @itmlst	=  replace(@itmlst,'''','')
--select @itmlst	


SET ANSI_WARNINGS OFF 
/*
Lester Wu 2004/07/14 
Rewrite the query string to return Regualr and Assortment Item No with Item Type
*/
/*

exec('
SELECT 
	''' + @cocde	 + ''' as ''cocde'',
	IBA_ITMNO,
	IBA_ASSITM
FROM
	IMBOMASS (NOLOCK)
WHERE
	IBA_ASSITM IN (' + @itmlst + ')	
	AND IBA_TYP = ''BOM''
ORDER BY
	IBA_ASSITM,
	IBA_ITMNO')
*/
declare @lstEmpty as char(1)
set @lstEmpty = 'N'
if len(rtrim(ltrim(replace(@itmlst,'''','')))) <= 0 
begin
	set @lstEmpty = 'Y'
end 
--create a temp table for item list
create table #TMP_ITM(
	ITMNO nvarchar(20)
)

--create a temp table for resulting data
create table #TMP_IAR00003(
	TMP_ITMNO	nvarchar(20),
	TMP_ASSITM nvarchar(20),
	TMP_TYP nvarchar(10)
)

--declare variable for the item list
declare	@ITM_REMAIN	as nvarchar(4000),
	@ITM_PART		as nvarchar(20)


--Lester Wu 2005-04-06, retrieve company name from database
declare @compName varchar(100)
select @compName = yco_conam from SYCOMINF(NOLOCK) where yco_cocde=@cocde
if @cocde<>'MS' 
begin
	set @compName = 'UNITED CHINESE GROUP'
end
-----------------------------------------------------------------------------

--fill the item list into a temp table
if @itmlst<>'' 
begin
	set @ITM_REMAIN = @itmlst
	while charindex('*',@ITM_REMAIN)<>0
	begin
		set @ITM_PART =  rtrim(ltrim(left(@ITM_REMAIN, charindex('*',@ITM_REMAIN) - 1)))
		Set @ITM_REMAIN = ltrim(rtrim(right(@ITM_REMAIN, len(@ITM_REMAIN) - charindex('*', @ITM_REMAIN))))
		insert into #TMP_ITM values(@ITM_PART)
	end
	insert into #TMP_ITM values(@ITM_REMAIN)


	--obtain distinct item no
	select distinct ITMNO INTO #_ITM from #TMP_ITM where ltrim(rtrim(ITMNO))<>''

	delete from #TMP_ITM

	insert into #TMP_ITM select * from #_ITM

end



--store regular item information into a temp table
insert into #TMP_IAR00003
SELECT 
	rtrim(IBA_ITMNO) as 'IBA_ITMNO',
	rtrim(IBA_ASSITM) as 'IBA_ASSITM',
	'Regular' as 'Item Type'
FROM
	IMBOMASS (NOLOCK),
	#TMP_ITM tmp
	
WHERE
	IBA_ASSITM = tmp.ITMNO
	AND IBA_TYP = 'BOM'



--store assortment item information into a temp table if OPTASS = '1'
if @OPTASS='1' 
begin 

insert into #TMP_IAR00003
SELECT 
	DISTINCT
	rtrim(B.IBA_ITMNO) as 'IBI_ITMNO',
	rtrim(A.IBA_ASSITM) as 'IBI_ASSITM',
	'Assortment'

FROM
	IMBOMASS A (NOLOCK)
	LEFT JOIN IMBOMASS B (NOLOCK)  ON A.IBA_ITMNO=B.IBA_ASSITM 

WHERE
	(A.IBA_ASSITM in (select ITMNO from #TMP_ITM) or @lstEmpty = 'Y')
	AND A.IBA_TYP = 'BOM'
	AND ISNULL(B.IBA_TYP,'')='ASS' 
end



--return of resulting data
select
	@cocde as 'cocde',
	*,
	@compName as 'compName'
FROM
	#TMP_IAR00003

ORDER BY
	TMP_ASSITM,
	TMP_ITMNO




SET ANSI_WARNINGS ON








GO
GRANT EXECUTE ON [dbo].[sp_select_IAR00003] TO [ERPUSER] AS [dbo]
GO
