/****** Object:  StoredProcedure [dbo].[sp_select_SAORDDTL_2]    Script Date: 09/29/2017 15:29:09 ******/
DROP PROCEDURE [dbo].[sp_select_SAORDDTL_2]
GO
/****** Object:  StoredProcedure [dbo].[sp_select_SAORDDTL_2]    Script Date: 09/29/2017 15:29:10 ******/
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
CREATE procedure [dbo].[sp_select_SAORDDTL_2]
                                                                                                                                                                                                                                                                 


@sad_cocde 	nvarchar(6) ,
@sad_cus1no 	nvarchar(6),
@itmnolist nvarchar(1000),
@sad_colcde	nvarchar(30),
@sad_upddat	nvarchar(10),
@creusr		nvarchar(30),
@gsflgcst		char(1),
@gsflgcstext	char(1)

---------------------------------------------- 

 
AS
begin

create table #TEMP_INIT (tmp_init nvarchar(1000)) on [PRIMARY]
create table #TEMP_ITMNO (tmp_itmno nvarchar(20)) on [PRIMARY]

declare	@fm nvarchar(100), @to nvarchar(100)

declare @strPart nvarchar(1000), @strRemain nvarchar(1000)


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





Select 	
	distinct 
	sad_cocde,		sad_qutno,		sad_qutseq,
	sad_seqno,		sad_cus1no,	sad_cus1na,
	sad_cus2no,	sad_cus2na,	sad_delflg,
	sad_orgitm,	sad_itmno,		sad_colcde,	
	cast(sad_untcde as nvarchar(6)) + ' / ' +
	cast(sad_inrqty  as nvarchar(10)) + ' / ' +
	cast(sad_mtrqty as nvarchar(10)) + ' / ' +
	cast(sad_cft as nvarchar(20)) as 'sad_pck',
	sad_itmdsc,	sad_smpuntcde,	sad_stkqty,
	sad_cusqty,	sad_smpqty,	sad_curcde,
	sad_smpselprc,	

	case sad_itmventyp
		when 'I' then
			case @gsflgcst when  '1' then sad_fcurcde else '---'  end
		when 'J' then
			case @gsflgcst when  '1' then sad_fcurcde else '---'  end
		when 'E' then
			case @gsflgcstext when  '1' then sad_fcurcde else '---' end
	end as 'sad_fcurcde',
	

	case sad_itmventyp
		when 'I' then
			case @gsflgcst when  '1' then sad_smpftyprc else 0 end
		when 'J' then
			case @gsflgcst when '1' then sad_smpftyprc else 0 end
		when 'E' then 
			case @gsflgcstext  when '1' then sad_smpftyprc else 0  end
	end as 'sad_smpftyprc',	
	
	--sad_fcurcde, 	
	--sad_smpftyprc,	

	sad_shpqty,	sad_freqty,	
	sad_cusitm,	sad_cuscol,
	sad_coldsc,	sad_venno,
	sad_subcde,
	sad_cusven,	sad_cussub,
	sad_qutno as 'qutno',
	sad_reqno,		sad_reqseq,
	sad_creusr,		sad_updusr,	sad_credat,
	sad_upddat,	cast(sad_timstp as int) as 'sad_timstp',
	--************************************
	sad_cus1no + ' - ' + sad_cus1na + (case pri.cbi_cussts when 'A' then ' (Active)' when 'I' then ' (Inactive)' when 'D' then ' (Discontinue)' end) as 'sad_Pri',
--	'sad_Pri' = Case pri.cbi_cussts when 'A' then sad_cus1no + ' - ' + sad_cus1na when 'I' then sad_cus1no + ' - ' + rtrim(sad_cus1na) + '(Inactive)' when 'D' then sad_cus1no + ' - ' + rtrim(sad_cus1na) + '(Discontinue)' else sad_cus1no + ' - ' + sad_cus1na end,
	--************************************
	isnull(sad_cus2no + ' - ' + sad_cus2na + (case sec.cbi_cussts when 'A' then ' (Active)' when 'I' then ' (Inactive)' when 'D' then ' (Discontinue)' end),'' ) as 'sad_Sec',
--	'sad_Sec' = Case sad_cus2no when ' ' then sad_cus2no else 
--			Case sec.cbi_cussts when 'A' then sad_cus1no + ' - ' + sad_cus1na when 'I' then sad_cus1no + ' - ' + rtrim(sad_cus1na) + '(Inactive)' when 'D' then sad_cus1no + ' - ' + rtrim(sad_cus1na) + '(Discontinue)' else sad_cus1no + ' - ' + sad_cus1na end end, 
	isnull(ysr_saltem,'') as 'ysr_saltem',
	--************************************
	vbi_ventyp,
	sad_itmnotmp,
	sad_itmnoven,
	sad_itmnovenno,
sad_imu_ftyprctrm + ' / ' + sad_imu_hkprctrm + ' / ' + sad_imu_trantrm as 'sad_terms'
	

from SAORDDTL (nolock)
left join IMBASINF (nolock) on ibi_itmno = sad_itmno 
left join  CUBASINF pri (nolock) on --sad_cocde = pri.cbi_cocde and 
		(pri.cbi_cusno  = sad_cus1no or pri.cbi_cusali  = sad_cus1no)
left join  CUBASINF sec (nolock) on --sad_cocde = sec.cbi_cocde and 
		sad_cus2no = sec.cbi_cusno
left join VNBASINF (nolock) on vbi_venno = sad_itmno
left join  SYSALREP (nolock) on --ysr_cocde = @sad_cocde and 
		ysr_code1 = isnull((Select cbi_salrep from CUBASINF (nolock) where --cbi_cocde = sad_cocde and 
							          cbi_cusno = sad_cus1no),'')
where 
	sad_cocde = @sad_cocde and

	sad_cus1no in 
		(select cbi_cusno from cubasinf (nolock) where cbi_cusno = @sad_cus1no or cbi_cusali = @sad_cus1no
		 union
		 select cbi_cusali from cubasinf (nolock) where cbi_cusno = @sad_cus1no)
and

	(sad_itmno in 
	(Select tmp_itmno from #TEMP_ITMNO (nolock)) or
	sad_itmnotmp in
	(Select tmp_itmno from #TEMP_ITMNO (nolock)))
	--(Select ibi_itmno  from imbasinf (nolock) where ibi_itmno = @sad_itmno or ibi_alsitmno = @sad_itmno
		--union
		--select ibi_alsitmno from imbasinf (nolock) where ibi_itmno = @sad_itmno   )  
and

	sad_colcde between 	(case @sad_colcde when '' then '' 
--                                                                                                        ^ changed from '0' to null
		    		             else @sad_colcde end)
			and
			(case @sad_colcde when '' then 'ZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZ' 
		 		             else @sad_colcde end)	
and
	sad_upddat	 between 	(case @sad_upddat when '' then '1900/01/01 0:0:0' 
				 else @sad_upddat + ' 0:0:00' end) 
			and
			(case @sad_upddat when '' then '2099/12/31 23:59:59' 
			 else @sad_upddat + ' 23:59:59' end) 	
and (ltrim(rtrim(sad_itmno)) <> '' or ltrim(rtrim(sad_itmnotmp))<> '')

order by 
sad_upddat desc,
sad_itmno,
sad_itmnotmp,
sad_colcde,
sad_seqno


drop table #TEMP_INIT 
drop table #TEMP_ITMNO  

end







GO
GRANT EXECUTE ON [dbo].[sp_select_SAORDDTL_2] TO [ERPUSER] AS [dbo]
GO
