/****** Object:  StoredProcedure [dbo].[sp_select_CUITMPRC]    Script Date: 09/29/2017 15:29:09 ******/
DROP PROCEDURE [dbo].[sp_select_CUITMPRC]
GO
/****** Object:  StoredProcedure [dbo].[sp_select_CUITMPRC]    Script Date: 09/29/2017 15:29:10 ******/
SET ANSI_NULLS OFF
GO
SET QUOTED_IDENTIFIER OFF
GO













/*
=========================================================
Author:		Kenny Chan
Date:		6th FEB, 2002
Description:	Select data From SAORDDTL
Parameter:		1. Company
		2. Item No.
		3. Color Code
		4. Update_date	
=========================================================
 Modification History                                    
=========================================================
 Date      		Initial  		Description          
 18-03-2003	Lewis To		Change when fields empty, range 
				from ='' instead of '0'
06-08-2003	Lewis To		Change to ignor company code of CUST ans system file               
=========================================================     
*/
CREATE  procedure [dbo].[sp_select_CUITMPRC]
                                                                                                                                                                                                                                                                 



@cip_cusno 	nvarchar(6) ,
@cip_seccus	nvarchar(6),
@itmnolist nvarchar(1000),
@cip_cusitm	nvarchar(20),
@cip_cusstyno	nvarchar(30)

---------------------------------------------- 

 
AS

declare @i as nvarchar(4000)
declare @s as nvarchar(4000)
declare @s1 as nvarchar(4000)
declare @f as nvarchar(4000)
declare @w as nvarchar(4000)
declare @g as nvarchar(4000)
declare @o as nvarchar(4000)

begin

create table #TEMP_INIT (tmp_init nvarchar(1000)) on [PRIMARY]
create table #TEMP_ITMNO (tmp_itmno nvarchar(20)) on [PRIMARY]

declare	@fm nvarchar(100), @to nvarchar(100)

declare @strPart nvarchar(1000), @strRemain nvarchar(1000)

set @i = ''
set @s = ''
set @f = ''
set @w = ''
set @g = ''
set @o = ''

set @fm = ''
set @to = ''
set @strPart = ''
set @strRemain = ''

--#TEMP_ITMNO
if ltrim(rtrim(@itmnolist)) <> ''
begin
	delete from #TEMP_INIT

	set @strRemain = @itmnolist
	while charindex(',', @strRemain) <> 0
	begin
		set @strPart = ltrim(left(@strRemain, charindex(',', @strRemain)-1))
		set @strRemain = right(@strRemain, len(@strRemain) - charindex(',', @strRemain))
		if charindex('~', @strPart) <> 0 
		begin
			set @fm = ltrim(left(@strPart, charindex('~', @strPart)-1))
			set @to = right(@strPart, len(@strPart) - charindex('~', @strPart))
			insert into #TEMP_INIT
			select ibi_itmno from IMBASINF (nolock) where ibi_itmno between @fm and @to
			union all
			select ibi_itmno from IMBASINFH (nolock) where ibi_itmno between @fm and @to
			union all
			select ibi_alsitmno from imbasinf (nolock) where ibi_alsitmno between @fm and @to
		end
		else if charindex('%', @strPart) <> 0
		begin
			insert into #TEMP_INIT
			select ibi_itmno from IMBASINF (nolock) where ibi_itmno like @strPart
			union all
			select ibi_itmno from IMBASINFH (nolock) where ibi_itmno like @strPart
			union all
			select ibi_alsitmno from imbasinf (nolock) where ibi_alsitmno like @strPart
		end
		else
		begin
			insert into #TEMP_INIT values (@strPart)
		end
	end
	if charindex(',',@strRemain) = 0
	begin
		set @strRemain = ltrim(@strRemain)
		if charindex('~', @strRemain) <> 0 
		begin
			set @fm = ltrim(left(@strRemain, charindex('~', @strRemain)-1))
			set @to = right(@strRemain, len(@strRemain) - charindex('~', @strRemain))
			insert into #TEMP_INIT
			select ibi_itmno from IMBASINF (nolock) where ibi_itmno between @fm and @to
			union all
			select ibi_itmno from IMBASINFH (nolock) where ibi_itmno between @fm and @to
			union all
			select ibi_alsitmno from imbasinf (nolock) where ibi_alsitmno between @fm and @to
		end
		else if charindex('%', @strRemain) <> 0
		begin
			insert into #TEMP_INIT
			select ibi_itmno from IMBASINF (nolock)  where ibi_itmno like @strRemain
			union all
			select ibi_itmno from IMBASINFH (nolock) where ibi_itmno like @strRemain
			union all
			select ibi_alsitmno from imbasinf (nolock) where ibi_alsitmno like @strRemain
		end
		else
		begin
			insert into #TEMP_INIT values (@strRemain)
		end
	end
	insert into #TEMP_ITMNO
	select distinct tmp_init from #TEMP_INIT
end




set @s = @s + 
 ' select ' +
'cip_cocde as "CoCde",'+
'cip_cusno as "Pri Cust",'+
'cip_seccus as "Sec Cust",'+
'cis_secsna as "S Cust Name",'+
'cip_itmno as "Item No",'+
'cip_venno as "DV",'+
'cip_prdven as "PV",'+
'cip_colcde as "Color",'+
'cip_untcde as "UM",'+
'cip_conftr as "Con Ftr",'+
'cip_inrqty as "Inner",'+
'cip_mtrqty as "Master",'+
'cis_cft as ''Cft'','+
'cis_cbm as ''Cbm'','+
'cip_hkprctrm as "HKPrcTerm",'+
'cip_ftyprctrm as "FtyPrcTerm",'+
'cip_trantrm as "TranTerm",'+
'cip_cus1no as "PriceKey1",'+
'cip_cus2no as "PriceKey2",'+
'cip_effdat as "Eff Date",'+
'CONVERT(VARCHAR(10), cip_expdat, 101) as "Exp Date",'+
'cip_refdoc as "Ref Doc",'+
'cip_refseq as "Ref Seq",'+
'cip_docdat as "Doc Date",'+
'cip_fcurcde as "Fty Curr",'+
'cip_ftycst as "FtyCst",'+
'cip_bomcst as "BOMCst",'+
'cip_ftyprc as "FtyPrcTerm",'+
'cip_curcde as "Curr",'+
'cip_basprc as "BasPrc",'+
'cip_markup as "MU",'+
'cip_mrkprc as "MU Prc",'+
'cip_mumin as "Min MU%",'+
'cip_muminprc as "Min MU Prc",' +
'cip_pckcst as "Pck Cst",'+
'cip_commsn as "Comm",'+
'cip_itmcom as "Item Comm",'+
'cip_stdprc as "StdPrc",'+
'cip_discnt as "Disc",'+
'cip_adjprc as "AdjPrc",'+
'cip_pcprc as "PC Price",' +
'ltrim(str(year(cip_qutdat))) + ''-'' + right(''0'' +  ltrim(str( month(cip_qutdat))),2)  as "Period",'+
'cip_imqutdat as "IM Period"'+
' from CUITMHIS (nolock)'+
' left join CUITMPRC on cis_cocde = cip_cocde and cis_cusno = cip_cusno and cis_seccus = cip_seccus'+
' and cis_itmno = cip_itmno and cis_untcde = cip_untcde and cis_inrqty = cip_inrqty and cis_mtrqty = cip_mtrqty'+
' and cis_hkprctrm = cip_hkprctrm and cis_ftyprctrm = cip_ftyprctrm and cis_trantrm = cip_trantrm and cis_colcde = cip_colcde' 



set @w = @w + ' where ' +  
'cip_cocde is not null and ' + 
 'cis_cusno = ''' + @cip_cusno  + '''' 

if @cip_seccus <> '' 
		begin 
			set @w = @w + ' and cis_seccus = ''' +@cip_seccus  + '''' 
		end 
	
if @cip_cusitm <>''
		begin
			set @w = @w  + ' and cis_cusitm = ''' +@cip_cusitm  + '''' 
		end
	
if @cip_cusstyno <>''
		begin
			set @w = @w  + ' and cis_cusstyno = ''' +@cip_cusstyno  + '''' 
		end
	 

if @itmnolist <>''
		begin
			set @w = @w  +  ' and cis_itmno in ( Select tmp_itmno from #TEMP_ITMNO (nolock))'
		end

	
	
exec(@s+@w)


drop table #TEMP_INIT 
drop table #TEMP_ITMNO  

end









GO
GRANT EXECUTE ON [dbo].[sp_select_CUITMPRC] TO [ERPUSER] AS [dbo]
GO
