/****** Object:  StoredProcedure [dbo].[sp_select_MSR00009]    Script Date: 09/29/2017 15:29:09 ******/
DROP PROCEDURE [dbo].[sp_select_MSR00009]
GO
/****** Object:  StoredProcedure [dbo].[sp_select_MSR00009]    Script Date: 09/29/2017 15:29:10 ******/
SET ANSI_NULLS OFF
GO
SET QUOTED_IDENTIFIER OFF
GO




--sp_select_MSR00009 'EW','','','','','03/21/2005','03/21/2005','I','''OPE'',''HOL'',''REL'',''CLO''','mis'


/***************************************************************
Modification Information
	Date		By		Description
	23 Feb 2003	Lewis To	Add select one more field hiv_invamt for printinvoice summary
	16 Feb 2004	Lester Wu	Add "ALL" company selection
	17 Mar 2005	Lester Wu	Replace "ALL" with "UC-G"
				Remark: UC-G is excluding Magic Silk
****************************************************************/
CREATE  PROCEDURE [dbo].[sp_select_MSR00009] 

@Cocde		as nvarchar(8),
@From_Inv	as nvarchar(20),
@To_Inv		as nvarchar(20),
@From_PriCus	as nvarchar(6),
@To_PriCus	as nvarchar(6),
@From_Issdat	as nvarchar(10),
@To_Issdat	as nvarchar(10),
@SortBy		as nvarchar(1),
@INVSTS	as nvarchar(50),
@Usrid		as nvarchar(30)


AS


------------------------------------------------------------------------------------------------------------------------------------------------------
--Lester Wu 2005/03/03 -- Retrieve Company Name, Short Name, Address, Phone No, Fax No, Email Address, Logo Path
------------------------------------------------------------------------------------------------------------------------------------------------------
DECLARE
@yco_conam	varchar(100)
set @yco_conam = 'UNITED CHINESE GROUP'

if @cocde <> 'UC-G' 
BEGIN
	select @yco_conam=yco_conam from SYCOMINF(NOLOCK) where yco_cocde = @cocde
END
------------------------------------------------------------------------------------------------------------------------------------------------------
------------------------------------------------------------------------------------------------------------------------------------------------------



declare @sql as nvarchar(4000)
-- Add field hiv_invamt by Lewis
set @sql = '

SELECT

DISTINCT
''' + @cocde + ''',
hih_cocde,
hih_cus1no, 
pri_cbi_cussna = isnull(Pri.cbi_cussna, ''''),
hih_cus2no, 
sec_cbi_cussna = isnull(Sec.cbi_cussna, ''''),
hid_invno, 
hiv_invdat = convert(nvarchar(10), hiv_invdat, 101), 
hid_shpno, 
hih_ves,
hih_voy,
hih_slnonb = convert(nvarchar(10), hih_slnonb, 101),
hih_dst,
hiv_prctrm = isnull(A.ysi_dsc,''''),
hiv_paytrm = isnull(B.ysi_dsc,''''),
hiv_untamt = isnull(hiv_untamt, ''''),
hiv_invamt = isnull(hiv_invamt,0), 
hiv_ttlamt = isnull(hiv_ttlamt,0), 
replace(replace(replace(replace(hih_shpsts,"REL","REL."),"OPE","OPEN"),"HOL","HOLD"),''CLO'',''CLO''), ' +

'''' + @From_Inv + ''',''' +
'' + @To_Inv + ''',''' + 
'' + @From_PriCus + ''',''' +
'' + @To_PriCus + ''',''' +
'' + @From_Issdat + ''',''' +
'' + @To_Issdat + ''',''' +
'' + @SortBy + ''','''+
'' + case @invsts when "'OPE','HOL','REL','CLO'" then 'ALL' else replace(replace(replace(replace(replace(@invsts,'''',' '), 'OPE', 'OPEN'), 'HOL', 'HOLD'),'REL','RELEASED'),'CLO','CLOSED') end  + ''',''' + 
'' + @yco_conam + ''' as ''CompName''' + 
'
FROM

SHIPGHDR
left join SHIPGDTL on hih_cocde = hid_cocde and hih_shpno = hid_shpno
left join SHINVHDR on hih_cocde = hiv_cocde and hid_shpno = hiv_shpno and hid_invno = hiv_invno
left join CUBASINF Pri on --hih_cocde = Pri.cbi_cocde and 
hih_cus1no = Pri.cbi_cusno
left join CUBASINF Sec on --hih_cocde = Sec.cbi_cocde and 
hih_cus2no = Sec.cbi_cusno
left join SYSETINF A on --hih_cocde = A.ysi_cocde and 
hiv_prctrm = A.ysi_cde and A.ysi_typ = ''03''
left join SYSETINF B on --hih_cocde = B.ysi_cocde and 
hiv_paytrm = B.ysi_cde and B.ysi_typ = ''04''
WHERE
--Lester Wu 2005-03-17 replace ALL with UC-G and cater MS company
--(''' + @cocde + '''=''ALL'' or hih_cocde=''' + @cocde + ''') and
' +
case @cocde when 'UC-G' then 'hih_cocde not in (''MS'')'
	   else 'hih_cocde = ''' + @cocde + ''''  end 
+ '
---------------------------------------------------------------------------------------------
--hid_cocde = ' + '''' + @cocde + '''' + 'and

and hid_invno Between  ''' + 

case @From_Inv when '' then '0' else @From_Inv end

+ ''' and ''' +

case @To_Inv when '' then 'Z' else @To_Inv end

+ ''' and hih_cus1no between ''' +

case @From_PriCus when '' then '0' else @From_PriCus end

+ ''' and ''' +

case @To_PriCus  when '' then 'Z' else @To_PriCus end

+ ''' and hiv_invdat between ''' + 

case @From_Issdat when '' then '01/01/1900' else @From_Issdat + ' 00:00:00' end

+ ''' and ''' +

case @to_Issdat when '' then '01/01/3000' else @to_Issdat + ' 23:59:59.998' end

+ ''' and hih_shpsts in (' +

@invsts 

+ ')  ' + 

'ORDER BY '

if @sortby = 'C' 
begin
	set @sql = @sql + -- 'Pri.cbi_cussna, Sec.cbi_cussna '

'hih_cocde,
isnull(Pri.cbi_cussna, ''''),
isnull(Sec.cbi_cussna, ''''),
hih_cus1no,
hih_cus2no,
hid_invno, 
 convert(nvarchar(10), hiv_invdat, 101), 
hid_shpno, 
hih_ves,
hih_voy,
 convert(nvarchar(10), hih_slnonb, 101),
hih_dst,
isnull(A.ysi_dsc,''''),
isnull(B.ysi_dsc,''''),
isnull(hiv_untamt, ''''),
isnull(hiv_ttlamt,0)' 

end
else
begin
	set @sql = @sql + -- 'Pri.cbi_cussna, Sec.cbi_cussna '

'hih_cocde,
hid_invno, 
isnull(Pri.cbi_cussna, ''''),
isnull(Sec.cbi_cussna, ''''),
hih_cus1no,
hih_cus2no,
 convert(nvarchar(10), hiv_invdat, 101), 
hid_shpno, 
hih_ves,
hih_voy,
 convert(nvarchar(10), hih_slnonb, 101),
hih_dst,
isnull(A.ysi_dsc,''''),
isnull(B.ysi_dsc,''''),
isnull(hiv_untamt, ''''),
isnull(hiv_ttlamt,0)' 

end


exec(@sql)







GO
GRANT EXECUTE ON [dbo].[sp_select_MSR00009] TO [ERPUSER] AS [dbo]
GO
