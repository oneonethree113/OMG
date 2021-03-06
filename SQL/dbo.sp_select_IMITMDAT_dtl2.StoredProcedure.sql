/****** Object:  StoredProcedure [dbo].[sp_select_IMITMDAT_dtl2]    Script Date: 09/29/2017 15:29:09 ******/
DROP PROCEDURE [dbo].[sp_select_IMITMDAT_dtl2]
GO
/****** Object:  StoredProcedure [dbo].[sp_select_IMITMDAT_dtl2]    Script Date: 09/29/2017 15:29:10 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

















-- Checked by Allan Yuen at 1 Aug 2003  
  
  
/*  
=========================================================  
Program ID : sp_select_IMITMDAT_dtl2  
Description    :   
Programmer   : PIC  
ALTER  Date    :   
Last Modified   :   
Table Read(s)  :  
Table Write(s)  :  
=========================================================  
 Modification History                                      
=========================================================  
 Date        Initial   Description                            
=========================================================      
2004-07-29  AY Add dispaly wastage%  
2004-10-02 AY Add remark field.  
*/  
  
  
CREATE   PROCEDURE [dbo].[sp_select_IMITMDAT_dtl2]   
@iid_cocde  nvarchar(6),  
@iid_venitm nvarchar(20),  
@iid_untcde nvarchar(6),  
@iid_inrqty int,  
@iid_mtrqty int,   
@iid_itmseq int, 
@iid_recseq int  
  
AS  
  
-- Added by Mark Lau 20090511
----------------------------------------------
declare @negprc_bef  numeric(13,4)
declare @negprc  numeric(13,4)

set @negprc_bef = 0
set @negprc = 0

if (select count(*) from imbasinf where ibi_itmno = @iid_venitm) > 0 
begin
	select	@negprc =  round( isnull(iic_negprc,0),4)  ,
		@negprc_bef = round( isnull(imu_negprc,0),4) 
	from	IMITMDAT (nolock)
		left join IMITMDATCST (nolock) on
			iic_cocde = iid_cocde and 
			iic_venno = iid_venno and  
			iic_prdven = iid_prdven and
			iic_venitm = iid_venitm and 
			iic_untcde = iid_untcde and  
			iic_inrqty = iid_inrqty and 
			iic_mtrqty = iid_mtrqty	and
			iic_itmseq = iid_itmseq and
			iic_recseq = iid_recseq and 
			iic_xlsfil = iid_xlsfil and
			iic_chkdat = iid_chkdat and
			--iic_stage = 'W'	and
			--iic_conftr = iid_assconftr --and
			iic_conftr = iid_conftr
			--iic_cus1no = '' and iic_cus2no = ''
		left join IMPRCINF (nolock) on 
			imu_venno = iid_venno and  
			imu_prdven = iid_prdven and
			imu_pckunt = iid_untcde and  
			imu_inrqty = iid_inrqty and 
			imu_mtrqty = iid_mtrqty	and
			imu_cus1no = iic_cus1no and
			imu_cus2no = iic_cus2no and
			imu_ftyprctrm = iid_ftyprctrm and
			imu_hkprctrm = iid_prctrm and
			imu_trantrm = iid_trantrm and
			--imu_conftr = iid_assconftr and
			imu_conftr = iid_conftr and
			imu_itmno = iid_venitm
	where	iid_venitm = @iid_venitm and
		iid_untcde = @iid_untcde and
		iid_inrqty = @iid_inrqty and
		iid_mtrqty = @iid_mtrqty and
		iid_itmseq = @iid_itmseq and 
		iid_stage <> 'O' and
		iid_recseq = @iid_recseq   
end

else

begin
	select	@negprc = round( isnull(iic_negprc,0),4) ,
		@negprc_bef = round( isnull(imu_negprc,0),4) 
	from	IMITMDAT (nolock)
		left join IMITMDATCST (nolock) on
			iic_cocde = iid_cocde and 
			iic_venno = iid_venno and  
			iic_prdven = iid_prdven and
			iic_venitm = iid_venitm and 
			iic_untcde = iid_untcde and  
			iic_inrqty = iid_inrqty and 
			iic_mtrqty = iid_mtrqty	and
			iic_itmseq = iid_itmseq and
			iic_recseq =iid_recseq and 
			iic_xlsfil = iid_xlsfil and
			iic_chkdat = iid_chkdat and
			--iic_stage = 'W'	and
			iic_conftr = iid_assconftr --and
			--iic_cus1no = '' and iic_cus2no = ''
		left join IMPRCINFH (nolock) on 
			imu_venno = iid_venno and  
			imu_prdven = iid_prdven and
			imu_pckunt = iid_untcde and  
			imu_inrqty = iid_inrqty and 
			imu_mtrqty = iid_mtrqty	and
			imu_cus1no = iic_cus1no and
			imu_cus2no = iic_cus2no and
			imu_ftyprctrm = iid_ftyprctrm and
			imu_hkprctrm = iid_prctrm and
			imu_trantrm = iid_trantrm and
			imu_conftr = iid_assconftr and 
			imu_itmno = iid_venitm
	where	iid_venitm = @iid_venitm and
		iid_untcde = @iid_untcde and
		iid_inrqty = @iid_inrqty and
		iid_mtrqty = @iid_mtrqty and
		iid_itmseq = @iid_itmseq and 
		iid_stage <> 'O' and
		iid_recseq = @iid_recseq   

end

----------------------------------------------

/*  
select  'Eng. Desc' as 'Field Name', iid_mode as 'Mode', iid_engdsc_bef as 'Before', iid_engdsc as 'After' from imitmdat   
where iid_cocde = @iid_cocde and iid_venitm = @iid_venitm and iid_untcde = @iid_untcde and iid_inrqty = @iid_inrqty and iid_mtrqty = @iid_mtrqty and iid_stage <> 'O' and iid_recseq = @iid_recseq  
union all  
select 'Chin. Desc' as 'Field Name', iid_mode as 'Mode', iid_chndsc_bef as 'Before', iid_chndsc as 'After' from imitmdat   
where iid_cocde = @iid_cocde and iid_venitm = @iid_venitm and iid_untcde = @iid_untcde and iid_inrqty = @iid_inrqty and iid_mtrqty = @iid_mtrqty and iid_stage <> 'O' and iid_recseq = @iid_recseq  
union all  
select 'Prod. Line/Season Code' as 'Field Name', iid_mode as 'Mode', iid_lnecde_bef as 'Before', iid_lnecde as 'After' from imitmdat   
where iid_cocde = @iid_cocde and iid_venitm = @iid_venitm and iid_untcde = @iid_untcde and iid_inrqty = @iid_inrqty and iid_mtrqty = @iid_mtrqty and iid_stage <> 'O' and iid_recseq = @iid_recseq  
union all  
select 'Category 4' as 'Field Name', iid_mode as 'Mode', iid_catlvl4_bef as 'Before', iid_catlvl4 as 'After' from imitmdat   
where iid_cocde = @iid_cocde and iid_venitm = @iid_venitm and iid_untcde = @iid_untcde and iid_inrqty = @iid_inrqty and iid_mtrqty = @iid_mtrqty and iid_stage <> 'O' and iid_recseq = @iid_recseq  
union all  
------  
--select 'Conv. Factor to PCS' as 'Field Name', iid_mode as 'Mode', ltrim(str(iid_conftr_bef)) as 'Before', ltrim(str(iid_conftr)) as 'After' from imitmdat   
--where iid_cocde = @iid_cocde and iid_venitm = @iid_venitm and iid_untcde = @iid_untcde and iid_inrqty = @iid_inrqty and iid_mtrqty = @iid_mtrqty and iid_stage <> 'O' and iid_recseq = @iid_recseq  
--union all  
------  
select 'CCY' as 'Field Name', iid_mode as 'Mode', iid_curcde_bef as 'Before', iid_curcde as 'After' from imitmdat   
where iid_cocde = @iid_cocde and iid_venitm = @iid_venitm and iid_untcde = @iid_untcde and iid_inrqty = @iid_inrqty and iid_mtrqty = @iid_mtrqty and iid_stage <> 'O' and iid_recseq = @iid_recseq  
union all  
select 'CFT' as 'Field Name', iid_mode as 'Mode', ltrim(str(iid_cft_bef,11,4)) as 'Before', ltrim(str(iid_cft,11,4)) as 'After' from imitmdat   
where iid_cocde = @iid_cocde and iid_venitm = @iid_venitm and iid_untcde = @iid_untcde and iid_inrqty = @iid_inrqty and iid_mtrqty = @iid_mtrqty and iid_stage <> 'O' and iid_recseq = @iid_recseq  
union all  
select 'FTY Cost' as 'Field Name', iid_mode as 'Mode', ltrim(str(iid_ftycst_bef,13,4)) as 'Before', ltrim(str(iid_ftycst,13,4)) as 'After' from imitmdat   
where iid_cocde = @iid_cocde and iid_venitm = @iid_venitm and iid_untcde = @iid_untcde and iid_inrqty = @iid_inrqty and iid_mtrqty = @iid_mtrqty and iid_stage <> 'O' and iid_recseq = @iid_recseq  
union all  
select 'FTY Price' as 'Field Name', iid_mode as 'Mode', ltrim(str(iid_ftyprc_bef,13,4)) as 'Before', ltrim(str(iid_ftyprc,13,4)) as 'After' from imitmdat   
where iid_cocde = @iid_cocde and iid_venitm = @iid_venitm and iid_untcde = @iid_untcde and iid_inrqty = @iid_inrqty and iid_mtrqty = @iid_mtrqty and iid_stage <> 'O' and iid_recseq = @iid_recseq  
union all  
select 'Price Term' as 'Field Name', iid_mode as 'Mode', iid_prctrm_bef as 'Before', iid_prctrm as 'After' from imitmdat   
where iid_cocde = @iid_cocde and iid_venitm = @iid_venitm and iid_untcde = @iid_untcde and iid_inrqty = @iid_inrqty and iid_mtrqty = @iid_mtrqty and iid_stage <> 'O' and iid_recseq = @iid_recseq  
union all  
select 'GW' as 'Field Name', iid_mode as 'Mode', ltrim(str(iid_grswgt_bef,6,3)) as 'Before', ltrim(str(iid_grswgt,6,3)) as 'After' from imitmdat   
where iid_cocde = @iid_cocde and iid_venitm = @iid_venitm and iid_untcde = @iid_untcde and iid_inrqty = @iid_inrqty and iid_mtrqty = @iid_mtrqty and iid_stage <> 'O' and iid_recseq = @iid_recseq  
union all  
select 'NW' as 'Field Name', iid_mode as 'Mode', ltrim(str(iid_netwgt_bef,6,3)) as 'Before', ltrim(str(iid_netwgt,6,3)) as 'After' from imitmdat   
where iid_cocde = @iid_cocde and iid_venitm = @iid_venitm and iid_untcde = @iid_untcde and iid_inrqty = @iid_inrqty and iid_mtrqty = @iid_mtrqty and iid_stage <> 'O' and iid_recseq = @iid_recseq  
union all  
select 'Packing Instruction' as 'Field Name', iid_mode as 'Mode', iid_pckitr_bef as 'Before', iid_pckitr as 'After' from imitmdat   
where iid_cocde = @iid_cocde and iid_venitm = @iid_venitm and iid_untcde = @iid_untcde and iid_inrqty = @iid_inrqty and iid_mtrqty = @iid_mtrqty and iid_stage <> 'O' and iid_recseq = @iid_recseq  
union all  
select (case @iid_cocde when 'UCP' then 'Inner (cm) L'   
 else  'Inner (inch) L' end)  as 'Field Name', iid_mode as 'Mode', ltrim(str(iid_inrlcm_bef,11,4)) as 'Before', ltrim(str(iid_inrlcm,11,4)) as 'After' from imitmdat   
where iid_cocde = @iid_cocde and iid_venitm = @iid_venitm and iid_untcde = @iid_untcde and iid_inrqty = @iid_inrqty and iid_mtrqty = @iid_mtrqty and iid_stage <> 'O' and iid_recseq = @iid_recseq  
union all  
select (case @iid_cocde when 'UCP' then 'Inner (cm) W'   
 else  'Inner (inch) W' end) as 'Field Name', iid_mode as 'Mode', ltrim(str(iid_inrwcm_bef,11,4)) as 'Before', ltrim(str(iid_inrwcm,11,4)) as 'After' from imitmdat   
where iid_cocde = @iid_cocde and iid_venitm = @iid_venitm and iid_untcde = @iid_untcde and iid_inrqty = @iid_inrqty and iid_mtrqty = @iid_mtrqty and iid_stage <> 'O' and iid_recseq = @iid_recseq  
union all  
select (case @iid_cocde when 'UCP' then 'Inner (cm) H'   
 else  'Inner (inch) H' end) as 'Field Name', iid_mode as 'Mode', ltrim(str(iid_inrhcm_bef,11,4)) as 'Before', ltrim(str(iid_inrhcm,11,4)) as 'After' from imitmdat   
where iid_cocde = @iid_cocde and iid_venitm = @iid_venitm and iid_untcde = @iid_untcde and iid_inrqty = @iid_inrqty and iid_mtrqty = @iid_mtrqty and iid_stage <> 'O' and iid_recseq = @iid_recseq  
union all  
select (case @iid_cocde when 'UCP' then 'Master (cm) L'   
 else  'Master (inch) L' end) as 'Field Name', iid_mode as 'Mode', ltrim(str(iid_mtrlcm_bef,11,4)) as 'Before', ltrim(str(iid_mtrlcm,11,4)) as 'After' from imitmdat   
where iid_cocde = @iid_cocde and iid_venitm = @iid_venitm and iid_untcde = @iid_untcde and iid_inrqty = @iid_inrqty and iid_mtrqty = @iid_mtrqty and iid_stage <> 'O' and iid_recseq = @iid_recseq  
union all  
select (case @iid_cocde when 'UCP' then 'Master (cm) W'   
 else  'Master (inch) W' end) as 'Field Name', iid_mode as 'Mode', ltrim(str(iid_mtrwcm_bef,11,4)) as 'Before', ltrim(str(iid_mtrwcm,11,4)) as 'After' from imitmdat   
where iid_cocde = @iid_cocde and iid_venitm = @iid_venitm and iid_untcde = @iid_untcde and iid_inrqty = @iid_inrqty and iid_mtrqty = @iid_mtrqty and iid_stage <> 'O' and iid_recseq = @iid_recseq  
union all  
select (case @iid_cocde when 'UCP' then 'Master (cm) H'   
 else  'Master (inch) H' end) as 'Field Name', iid_mode as 'Mode', ltrim(str(iid_mtrhcm_bef,11,4)) as 'Before', ltrim(str(iid_mtrhcm,11,4)) as 'After' from imitmdat   
where iid_cocde = @iid_cocde and iid_venitm = @iid_venitm and iid_untcde = @iid_untcde and iid_inrqty = @iid_inrqty and iid_mtrqty = @iid_mtrqty and iid_stage <> 'O' and iid_recseq = @iid_recseq  
*/  
  
select	'Alias Item' as 'Field Name',
	iid_mode as 'Mode',
	iid_alsitmno_bef as 'Before',
	iid_alsitmno as 'After',
	-- David Yue	2012-09-17	Add Change Flag
	case when iid_mode = 'UPD' then case when iid_alsitmno_bef = iid_alsitmno then '' else 'Y' end else '' end as 'Change'
from	IMITMDAT (nolock)  
where	iid_venitm = @iid_venitm and
	iid_untcde = @iid_untcde and
	iid_inrqty = @iid_inrqty and
	iid_mtrqty = @iid_mtrqty and
		iid_itmseq = @iid_itmseq and 
	iid_stage <> 'O' and
	iid_recseq = @iid_recseq and
	iid_mode = 'NEW'  

union all  

select	'Eng. Desc' as 'Field Name',
	iid_mode as 'Mode',
	iid_engdsc_bef as 'Before',
	iid_engdsc as 'After',
	-- David Yue	2012-09-17	Add Change Flag
	case when iid_mode = 'UPD' then case when iid_engdsc_bef = iid_engdsc then '' else 'Y' end else '' end as 'Change'
from	IMITMDAT (nolock)
where	iid_venitm = @iid_venitm and
	iid_untcde = @iid_untcde and
	iid_inrqty = @iid_inrqty and
	iid_mtrqty = @iid_mtrqty and
		iid_itmseq = @iid_itmseq and 
	iid_stage <> 'O' and
	iid_recseq = @iid_recseq

union all

select	'Chin. Desc' as 'Field Name',
	iid_mode as 'Mode',
	iid_chndsc_bef as 'Before',
	iid_chndsc as 'After',
	-- David Yue	2012-09-17	Add Change Flag
	case when iid_mode = 'UPD' then case when iid_chndsc_bef = iid_chndsc then '' else 'Y' end else '' end as 'Change'
from	IMITMDAT (nolock) 
where	iid_venitm = @iid_venitm and
	iid_untcde = @iid_untcde and
	iid_inrqty = @iid_inrqty and
	iid_mtrqty = @iid_mtrqty and
		iid_itmseq = @iid_itmseq and 
	iid_stage <> 'O' and
	iid_recseq = @iid_recseq  

union all  

select	'Prod. Line/Season Code' as 'Field Name',
	iid_mode as 'Mode',
	iid_lnecde_bef as 'Before',
	iid_lnecde as 'After',
	-- David Yue	2012-09-17	Add Change Flag
	case when iid_mode = 'UPD' then case when iid_lnecde_bef = iid_lnecde then '' else 'Y' end else '' end as 'Change'
from	IMITMDAT (nolock)
where	iid_venitm = @iid_venitm and
	iid_untcde = @iid_untcde and
	iid_inrqty = @iid_inrqty and
	iid_mtrqty = @iid_mtrqty and
		iid_itmseq = @iid_itmseq and 
	iid_stage <> 'O' and
	iid_recseq = @iid_recseq  

union all  

select	'Category 4' as 'Field Name',
	iid_mode as 'Mode',
	iid_catlvl4_bef as 'Before',
	iid_catlvl4 as 'After',
	-- David Yue	2012-09-17	Add Change Flag
	case when iid_mode = 'UPD' then case when iid_catlvl4_bef = iid_catlvl4 then '' else 'Y' end else '' end as 'Change'
from	IMITMDAT (nolock)
where	iid_venitm = @iid_venitm and
	iid_untcde = @iid_untcde and
	iid_inrqty = @iid_inrqty and
	iid_mtrqty = @iid_mtrqty and
		iid_itmseq = @iid_itmseq and 
	iid_stage <> 'O' and
	iid_recseq = @iid_recseq  

union all  

/*  
--select 'Conv. Factor to PCS' as 'Field Name', iid_mode as 'Mode', ltrim(str(iid_conftr_bef)) as 'Before', ltrim(str(iid_conftr)) as 'After' from imitmdat   
--where iid_cocde = @iid_cocde and iid_venitm = @iid_venitm and iid_untcde = @iid_untcde and iid_inrqty = @iid_inrqty and iid_mtrqty = @iid_mtrqty and iid_stage <> 'O' and iid_recseq = @iid_recseq  
--union all  
*/  

select	'CFT' as 'Field Name',
	iid_mode as 'Mode',
	ltrim(str(iid_cft_bef,11,4)) as 'Before',
	ltrim(str(iid_cft,11,4)) as 'After',
	-- David Yue	2012-09-17	Add Change Flag
	case when iid_mode = 'UPD' then case when ltrim(str(iid_cft_bef,11,4)) = ltrim(str(iid_cft,11,4)) then '' else 'Y' end else '' end as 'Change'
from	IMITMDAT (nolock)
where	iid_venitm = @iid_venitm and
	iid_untcde = @iid_untcde and
	iid_inrqty = @iid_inrqty and
	iid_mtrqty = @iid_mtrqty and
		iid_itmseq = @iid_itmseq and 
	iid_stage <> 'O' and
	iid_recseq = @iid_recseq

union all  

select	'CCY' as 'Field Name',
	iid_mode as 'Mode',
	iid_curcde_bef as 'Before',
	iid_curcde as 'After',
	-- David Yue	2012-09-17	Add Change Flag
	case when iid_mode = 'UPD' then case when iid_curcde_bef = iid_curcde then '' else 'Y' end else '' end as 'Change'
from	IMITMDAT (nolock)
where	iid_venitm = @iid_venitm and
	iid_untcde = @iid_untcde and
	iid_inrqty = @iid_inrqty and
	iid_mtrqty = @iid_mtrqty and
		iid_itmseq = @iid_itmseq and 
	iid_stage <> 'O' and
	iid_recseq = @iid_recseq 

union all

select	'FTY Cost' as 'Field Name',
	iid_mode as 'Mode',
	ltrim(str(iid_ftycst_bef,13,4)) as 'Before',
	ltrim(str(iid_ftycst,13,4)) as 'After',
	-- David Yue	2012-09-17	Add Change Flag
	case when iid_mode = 'UPD' then case when ltrim(str(iid_ftycst_bef,13,4)) = ltrim(str(iid_ftycst,13,4)) then '' else 'Y' end else '' end as 'Change'
from	IMITMDAT (nolock)
where	iid_venitm = @iid_venitm and
	iid_untcde = @iid_untcde and
	iid_inrqty = @iid_inrqty and
	iid_mtrqty = @iid_mtrqty and
		iid_itmseq = @iid_itmseq and 
	iid_stage <> 'O' and
	iid_recseq = @iid_recseq

union all

select	'FTY Price' as 'Field Name',
	iid_mode as 'Mode',
	ltrim(str(iid_ftyprc_bef,13,4)) as 'Before',
	ltrim(str(iid_ftyprc,13,4)) as 'After',
	-- David Yue	2012-09-17	Add Change Flag
	case when iid_mode = 'UPD' then case when ltrim(str(iid_ftyprc_bef,13,4)) = ltrim(str(iid_ftyprc,13,4)) then '' else 'Y' end else '' end as 'Change'
from	IMITMDAT (nolock)
where	iid_venitm = @iid_venitm and
	iid_untcde = @iid_untcde and
	iid_inrqty = @iid_inrqty and
	iid_mtrqty = @iid_mtrqty and
	iid_itmseq = @iid_itmseq and 
	iid_stage <> 'O' and
	iid_recseq = @iid_recseq 

-- Added by Mark Lau 20090511
union all
 
select	'Neg. Prc.' as 'Field Name',
	iid_mode as 'Mode',
	isnull(ltrim(str(@negprc_bef,13,4)),0) as 'Before',
	isnull(ltrim(str(@negprc,13,4)),0) as 'After',
	-- David Yue	2012-09-17	Add Change Flag
	case when iid_mode = 'UPD' then case when isnull(ltrim(str(@negprc_bef,13,4)),0) = isnull(ltrim(str(@negprc,13,4)),0) then '' else 'Y' end else '' end as 'Change'
from	IMITMDAT (nolock)
where	iid_venitm = @iid_venitm and
	iid_untcde = @iid_untcde and
	iid_inrqty = @iid_inrqty and
	iid_mtrqty = @iid_mtrqty and
	iid_itmseq = @iid_itmseq and 
	iid_stage <> 'O' and
	iid_recseq = @iid_recseq

union all  
--

select	'Currency' as 'Field Name',
	iid_mode as 'Mode',
	ltrim(iid_curr_bef) as 'Before',
	ltrim(iid_curr_bef) as 'After',
	-- David Yue	2012-09-17	Add Change Flag
	case when iid_mode = 'UPD' then case when ltrim(iid_curr_bef) = ltrim(iid_curr_bef) then '' else 'Y' end else '' end as 'Change'
from	IMITMDAT (nolock)
where	iid_venitm = @iid_venitm and
	iid_untcde = @iid_untcde and
	iid_inrqty = @iid_inrqty and
	iid_mtrqty = @iid_mtrqty and
	iid_itmseq = @iid_itmseq and 
	iid_stage <> 'O' and
	iid_recseq = @iid_recseq

union all  

select	'BOM Price' as 'Field Name',
	iid_mode as 'Mode',
	isnull(ltrim(str(iid_bomprc_bef,13,4)),0) as 'Before',
	isnull( ltrim(str(iid_bomprc,13,4)),0) as 'After',
	-- David Yue	2012-09-17	Add Change Flag
	case when iid_mode = 'UPD' then case when isnull(ltrim(str(iid_bomprc_bef,13,4)),0) = isnull( ltrim(str(iid_bomprc,13,4)),0) then '' else 'Y' end else '' end as 'Change'
from	IMITMDAT (nolock)
where	iid_venitm = @iid_venitm and
	iid_untcde = @iid_untcde and
	iid_inrqty = @iid_inrqty and
	iid_mtrqty = @iid_mtrqty and
	iid_itmseq = @iid_itmseq and 
	iid_stage <> 'O' and
	iid_recseq = @iid_recseq

union all  

select	'Basic Price' as 'Field Name',
	iid_mode as 'Mode',
	isnull(ltrim(str(iid_basprc_bef,13,4)),0) as 'Before',
	isnull(ltrim(str(iid_basprc,13,4)),0) as 'After',
	-- David Yue	2012-09-17	Add Change Flag
	case when iid_mode = 'UPD' then case when isnull(ltrim(str(iid_basprc_bef,13,4)),0) = isnull(ltrim(str(iid_basprc,13,4)),0) then '' else 'Y' end else '' end as 'Change'
from	IMITMDAT (nolock)
where	iid_venitm = @iid_venitm and
	iid_untcde = @iid_untcde and
	iid_inrqty = @iid_inrqty and
	iid_mtrqty = @iid_mtrqty and
	iid_itmseq = @iid_itmseq and 
	iid_stage <> 'O' and
	iid_recseq = @iid_recseq

union all  
--   

/*
select	'Price Term' as 'Field Name',
	iid_mode as 'Mode',
	iid_prctrm_bef as 'Before',
	iid_prctrm as 'After',
	-- David Yue	2012-09-17	Add Change Flag
	case when iid_mode = 'UPD' then case when iid_prctrm_bef = iid_prctrm then '' else 'Y' end else '' end as 'Change'
from	IMITMDAT   
where	iid_venitm = @iid_venitm and
	iid_untcde = @iid_untcde and
	iid_inrqty = @iid_inrqty and
	iid_mtrqty = @iid_mtrqty and
	iid_stage <> 'O' and
	iid_recseq = @iid_recseq

union all  
*/

select	'BOM CCY' as 'Field Name',
	iid_mode as 'Mode',
	isnull(iid_fcurcde_bef,'') as 'Before',
	isnull(iid_fcurcde,'') as 'After',
	-- David Yue	2012-09-17	Add Change Flag
	case when iid_mode = 'UPD' then case when isnull(iid_fcurcde_bef,'') = isnull(iid_fcurcde,'') then '' else 'Y' end else '' end as 'Change'
from	IMITMDAT (nolock)
where	iid_venitm = @iid_venitm and
	iid_untcde = @iid_untcde and
	iid_inrqty = @iid_inrqty and
	iid_mtrqty = @iid_mtrqty and
	iid_itmseq = @iid_itmseq and 
	iid_stage <> 'O' and
	iid_recseq = @iid_recseq

union all  

select	'BOM Wastage%' as 'Field Name',
	iid_mode as 'Mode',
	ltrim(str(iid_wastage_bef,5,2)) as 'Before',
	ltrim(str(iid_wastage,5,2))  as 'After',
	-- David Yue	2012-09-17	Add Change Flag
	case when iid_mode = 'UPD' then case when ltrim(str(iid_wastage_bef,5,2)) = ltrim(str(iid_wastage,5,2)) then '' else 'Y' end else '' end as 'Change'
from	IMITMDAT (nolock)
where	iid_venitm = @iid_venitm and
	iid_untcde = @iid_untcde and
	iid_inrqty = @iid_inrqty and
	iid_mtrqty = @iid_mtrqty and
	iid_itmseq = @iid_itmseq and 
	iid_stage <> 'O' and
	iid_recseq = @iid_recseq

union all  

--- Maggie request to move up at 29/09/2003  
select	'Packing Instruction' as 'Field Name',
	iid_mode as 'Mode',
	iid_pckitr_bef as 'Before',
	iid_pckitr as 'After',
	-- David Yue	2012-09-17	Add Change Flag
	case when iid_mode = 'UPD' then case when iid_pckitr_bef = iid_pckitr then '' else 'Y' end else '' end as 'Change'
from	IMITMDAT (nolock)
where	iid_venitm = @iid_venitm and
	iid_untcde = @iid_untcde and
	iid_inrqty = @iid_inrqty and
	iid_mtrqty = @iid_mtrqty and
	iid_itmseq = @iid_itmseq and 
	iid_stage <> 'O' and
	iid_recseq = @iid_recseq

union all

select	'內盒尺碼(寸)' as 'Field Name',
	iid_mode as 'Mode',
	iid_inrsze_bef as 'Before',
	iid_inrsze as 'After',
	-- David Yue	2012-09-17	Add Change Flag
	case when iid_mode = 'UPD' then case when iid_inrsze_bef = iid_inrsze then '' else 'Y' end else '' end as 'Change'
from	IMITMDAT (nolock)
where	iid_venitm = @iid_venitm and
	iid_untcde = @iid_untcde and
	iid_inrqty = @iid_inrqty and
	iid_mtrqty = @iid_mtrqty and
	iid_itmseq = @iid_itmseq and 
	iid_stage <> 'O' and
	iid_recseq = @iid_recseq

union all

select	'外盒尺碼(寸)' as 'Field Name',
	iid_mode as 'Mode',
	iid_mtrsze_bef as 'Before',
	iid_mtrsze as 'After',
	-- David Yue	2012-09-17	Add Change Flag
	case when iid_mode = 'UPD' then case when iid_mtrsze_bef = iid_mtrsze then '' else 'Y' end else '' end as 'Change'
from	IMITMDAT (nolock)
where	iid_venitm = @iid_venitm and
	iid_untcde = @iid_untcde and
	iid_inrqty = @iid_inrqty and
	iid_mtrqty = @iid_mtrqty and
	iid_itmseq = @iid_itmseq and 
	iid_stage <> 'O' and
	iid_recseq = @iid_recseq

union all

select	'輔屬材料' as 'Field Name',
	iid_mode as 'Mode',
	iid_mat_bef as 'Before',
	iid_mat as 'After',
	-- David Yue	2012-09-17	Add Change Flag
	case when iid_mode = 'UPD' then case when iid_mat_bef = iid_mat then '' else 'Y' end else '' end as 'Change'
from	IMITMDAT (nolock)
where	iid_venitm = @iid_venitm and
	iid_untcde = @iid_untcde and
	iid_inrqty = @iid_inrqty and
	iid_mtrqty = @iid_mtrqty and
	iid_itmseq = @iid_itmseq and 
	iid_stage <> 'O' and
	iid_recseq = @iid_recseq

union all  

select	(case @iid_cocde when 'UCP' then 'MOQ' else  'MOQ'  end) as 'Field Name',
	iid_mode as 'Mode',
	ltrim(str(iid_moq_bef,11,0)) as 'Before',
	ltrim(str(iid_moq,11,0)) as 'After',
	-- David Yue	2012-09-17	Add Change Flag
	case when iid_mode = 'UPD' then case when ltrim(str(iid_moq_bef,11,0)) = ltrim(str(iid_moq,11,0)) then '' else 'Y' end else '' end as 'Change'
from	IMITMDAT (nolock)
where	iid_venitm = @iid_venitm and
	iid_untcde = @iid_untcde and
	iid_inrqty = @iid_inrqty and
	iid_mtrqty = @iid_mtrqty and
	iid_itmseq = @iid_itmseq and 
	iid_stage <> 'O' and
	iid_recseq = @iid_recseq

union all  

select	(case @iid_cocde when 'UCP' then 'Original Design Vendor' else 'Original Design Vendor' end) as 'Field Name',
	iid_mode as 'Mode',
	iid_orgdsgvenno_bef as 'Before',
	iid_orgdsgvenno as 'After',
	-- David Yue	2012-09-17	Add Change Flag
	case when iid_mode = 'UPD' then case when iid_orgdsgvenno_bef = iid_orgdsgvenno then '' else 'Y' end else '' end as 'Change'
from	IMITMDAT (nolock)
where	iid_venitm = @iid_venitm and
	iid_untcde = @iid_untcde and
	iid_inrqty = @iid_inrqty and
	iid_mtrqty = @iid_mtrqty and
	iid_itmseq = @iid_itmseq and 
	iid_stage <> 'O' and
	iid_recseq = @iid_recseq

union all  

select	'GW' as 'Field Name',
	iid_mode as 'Mode',
	isnull(ltrim(str(iid_grswgt_bef,6,3)),0.000) as 'Before',
	isnull(ltrim(str(iid_grswgt,6,3)),0.000) as 'After',
	-- David Yue	2012-09-17	Add Change Flag
	case when iid_mode = 'UPD' then case when isnull(ltrim(str(iid_grswgt_bef,6,3)),0.000) = isnull(ltrim(str(iid_grswgt,6,3)),0.000) then '' else 'Y' end else '' end as 'Change'
from	IMITMDAT (nolock)
where	iid_venitm = @iid_venitm and
	iid_untcde = @iid_untcde and
	iid_inrqty = @iid_inrqty and
	iid_mtrqty = @iid_mtrqty and
	iid_itmseq = @iid_itmseq and 
	iid_stage <> 'O' and
	iid_recseq = @iid_recseq

union all  

select	'NW' as 'Field Name',
	iid_mode as 'Mode',
	isnull(ltrim(str(iid_netwgt_bef,6,3)),0.000) as 'Before',
	isnull(ltrim(str(iid_netwgt,6,3)),0.000) as 'After',
	-- David Yue	2012-09-17	Add Change Flag
	case when iid_mode = 'UPD' then case when isnull(ltrim(str(iid_netwgt_bef,6,3)),0.000) = isnull(ltrim(str(iid_netwgt,6,3)),0.000) then '' else 'Y' end else '' end as 'Change'
from	IMITMDAT (nolock)
where	iid_venitm = @iid_venitm and
	iid_untcde = @iid_untcde and
	iid_inrqty = @iid_inrqty and
	iid_mtrqty = @iid_mtrqty and
	iid_itmseq = @iid_itmseq and 
	iid_stage <> 'O' and
	iid_recseq = @iid_recseq

union all  

select	(case @iid_cocde when 'UCP' then 'Inner (cm) L' else 'Inner (inch) L' end) as 'Field Name',
	iid_mode as 'Mode',
	isnull(ltrim(str(iid_inrlcm_bef,11,4)),0.0000) as 'Before',
	isnull(ltrim(str(iid_inrlcm,11,4)),0.0000) as 'After',
	-- David Yue	2012-09-17	Add Change Flag
	case when iid_mode = 'UPD' then case when isnull(ltrim(str(iid_inrlcm_bef,11,4)),0.0000) = isnull(ltrim(str(iid_inrlcm,11,4)),0.0000) then '' else 'Y' end else '' end as 'Change'
from	IMITMDAT (nolock)
where	iid_venitm = @iid_venitm and
	iid_untcde = @iid_untcde and
	iid_inrqty = @iid_inrqty and
	iid_mtrqty = @iid_mtrqty and
	iid_itmseq = @iid_itmseq and 
	iid_stage <> 'O' and
	iid_recseq = @iid_recseq

union all  

select	(case @iid_cocde when 'UCP' then 'Inner (cm) W' else 'Inner (inch) W' end) as 'Field Name',
	iid_mode as 'Mode',
	isnull(ltrim(str(iid_inrwcm_bef,11,4)),0.0000) as 'Before',
	isnull(ltrim(str(iid_inrwcm,11,4)),0.0000) as 'After',
	-- David Yue	2012-09-17	Add Change Flag
	case when iid_mode = 'UPD' then case when isnull(ltrim(str(iid_inrwcm_bef,11,4)),0.0000) = isnull(ltrim(str(iid_inrwcm,11,4)),0.0000) then '' else 'Y' end else '' end as 'Change'
from	IMITMDAT (nolock)
where	iid_venitm = @iid_venitm and
	iid_untcde = @iid_untcde and
	iid_inrqty = @iid_inrqty and
	iid_mtrqty = @iid_mtrqty and
	iid_itmseq = @iid_itmseq and 
	iid_stage <> 'O' and
	iid_recseq = @iid_recseq

union all  

select	(case @iid_cocde when 'UCP' then 'Inner (cm) H' else 'Inner (inch) H' end) as 'Field Name',
	iid_mode as 'Mode',
	isnull(ltrim(str(iid_inrhcm_bef,11,4)),0.0000) as 'Before',
	isnull(ltrim(str(iid_inrhcm,11,4)),0.0000) as 'After',
	-- David Yue	2012-09-17	Add Change Flag
	case when iid_mode = 'UPD' then case when isnull(ltrim(str(iid_inrhcm_bef,11,4)),0.0000) = isnull(ltrim(str(iid_inrhcm,11,4)),0.0000) then '' else 'Y' end else '' end as 'Change'
from	IMITMDAT (nolock)
where	iid_venitm = @iid_venitm and
	iid_untcde = @iid_untcde and
	iid_inrqty = @iid_inrqty and
	iid_mtrqty = @iid_mtrqty and
	iid_itmseq = @iid_itmseq and 
	iid_stage <> 'O' and
	iid_recseq = @iid_recseq

union all  

select	(case @iid_cocde when 'UCP' then 'Master (cm) L' else  'Master (inch) L' end) as 'Field Name',
	iid_mode as 'Mode',
	isnull(ltrim(str(iid_mtrlcm_bef,11,4)),0.0000) as 'Before',
	isnull(ltrim(str(iid_mtrlcm,11,4)),0.0000) as 'After',
	-- David Yue	2012-09-17	Add Change Flag
	case when iid_mode = 'UPD' then case when isnull(ltrim(str(iid_mtrlcm_bef,11,4)),0.0000) = isnull(ltrim(str(iid_mtrlcm,11,4)),0.0000) then '' else 'Y' end else '' end as 'Change'
from	IMITMDAT (nolock)
where	iid_venitm = @iid_venitm and
	iid_untcde = @iid_untcde and
	iid_inrqty = @iid_inrqty and
	iid_mtrqty = @iid_mtrqty and
	iid_itmseq = @iid_itmseq and 
	iid_stage <> 'O' and
	iid_recseq = @iid_recseq

union all  

select	(case @iid_cocde when 'UCP' then 'Master (cm) W' else 'Master (inch) W' end) as 'Field Name',
	iid_mode as 'Mode',
	isnull(ltrim(str(iid_mtrwcm_bef,11,4)),0.0000) as 'Before',
	isnull(ltrim(str(iid_mtrwcm,11,4)),0.0000) as 'After',
	-- David Yue	2012-09-17	Add Change Flag
	case when iid_mode = 'UPD' then case when isnull(ltrim(str(iid_mtrwcm_bef,11,4)),0.0000) = isnull(ltrim(str(iid_mtrwcm,11,4)),0.0000) then '' else 'Y' end else '' end as 'Change'
from	IMITMDAT (nolock)
where	iid_venitm = @iid_venitm and
	iid_untcde = @iid_untcde and
	iid_inrqty = @iid_inrqty and
	iid_mtrqty = @iid_mtrqty and
	iid_itmseq = @iid_itmseq and 
	iid_stage <> 'O' and
	iid_recseq = @iid_recseq

union all  

select	(case @iid_cocde when 'UCP' then 'Master (cm) H' else 'Master (inch) H' end) as 'Field Name',
	iid_mode as 'Mode',
	isnull(ltrim(str(iid_mtrhcm_bef,11,4)),0.0000) as 'Before',
	isnull(ltrim(str(iid_mtrhcm,11,4)),0.0000) as 'After',
	-- David Yue	2012-09-17	Add Change Flag
	case when iid_mode = 'UPD' then case when isnull(ltrim(str(iid_mtrhcm_bef,11,4)),0.0000) = isnull(ltrim(str(iid_mtrhcm,11,4)),0.0000) then '' else 'Y' end else '' end as 'Change'
from	IMITMDAT (nolock)
where	iid_venitm = @iid_venitm and
	iid_untcde = @iid_untcde and
	iid_inrqty = @iid_inrqty and
	iid_mtrqty = @iid_mtrqty and
	iid_itmseq = @iid_itmseq and 
	iid_stage <> 'O' and
	iid_recseq = @iid_recseq

union all  

select	'Remark' as 'Field Name',
	iid_mode as 'Mode',
	iid_remark_bef as 'Before',
	iid_remark as 'After',
	-- David Yue	2012-09-17	Add Change Flag
	case when iid_mode = 'UPD' then case when iid_remark_bef = iid_remark then '' else 'Y' end else '' end as 'Change'
from	IMITMDAT (nolock)
where	iid_venitm = @iid_venitm and
	iid_untcde = @iid_untcde and
	iid_inrqty = @iid_inrqty and
	iid_mtrqty = @iid_mtrqty and
	iid_itmseq = @iid_itmseq and 
	iid_stage <> 'O' and
	iid_recseq = @iid_recseq

union all  

select	'No. of Assorted Item' as 'Field Name',
	iid_mode as 'Mode',
	ltrim(str(iid_assconftr_bef)) as 'Before',
	ltrim(str(iid_assconftr)) as 'After',
	-- David Yue	2012-09-17	Add Change Flag
	case when iid_mode = 'UPD' then case when ltrim(str(iid_assconftr_bef)) = ltrim(str(iid_assconftr)) then '' else 'Y' end else '' end as 'Change'
from	IMITMDAT (nolock)
where	iid_venitm = @iid_venitm and
	iid_untcde = @iid_untcde and
	iid_inrqty = @iid_inrqty and
	iid_mtrqty = @iid_mtrqty and
	iid_itmseq = @iid_itmseq and 
	iid_stage <> 'O' and
	iid_recseq = @iid_recseq and
	iid_itmtyp = 'ASS'

-- Frankie Cheung 20100315 Add Period
union all  

select	'Period' as 'Field Name',
	iid_mode as 'Mode',
	case ltrim(str(year(iid_period_bef))) when '1900' then '' else ltrim(str(year(iid_period_bef))) + '-' +
		right('0' + ltrim(str(month(iid_period_bef))),2) end as 'Before',
	case ltrim(str(year(iid_period))) when '1900' then '' else ltrim(str(year(iid_period))) + '-' +
		right('0' + ltrim(str(month(iid_period))),2) end as 'After',
	-- David Yue	2012-09-17	Add Change Flag
	case when iid_mode = 'UPD' then case when (case ltrim(str(year(iid_period_bef))) when '1900' then '' else ltrim(str(year(iid_period_bef))) + '-' +
		right('0' + ltrim(str(month(iid_period_bef))),2) end) = (case ltrim(str(year(iid_period))) when '1900' then
		'' else ltrim(str(year(iid_period))) + '-' + right('0' + ltrim(str(month(iid_period))),2) end) then '' else 'Y'
		end else '' end as 'Change'
from	IMITMDAT (nolock)
where	iid_venitm = @iid_venitm and
	iid_untcde = @iid_untcde and
	iid_inrqty = @iid_inrqty and
	iid_mtrqty = @iid_mtrqty and
	iid_itmseq = @iid_itmseq and 
	iid_stage <> 'O' and
	iid_recseq = @iid_recseq

-- Frankie Cheung 20110317 Add Cost expiry Date
union all

select	'Cost Expiry Date' as 'Field Name',
	iid_mode as 'Mode',
	case ltrim(str(year(iid_cstexpdat_bef))) when '1900' then '' else convert(char(10), iid_cstexpdat_bef, 101) end as 'Before',
	case ltrim(str(year(iid_cstexpdat))) when '1900' then '' else convert(char(10), iid_cstexpdat, 101) end as 'After',
	-- David Yue	2012-09-17	Add Change Flag
	case when iid_mode = 'UPD' then case when (case ltrim(str(year(iid_cstexpdat_bef))) when '1900' then '' else
		convert(char(10), iid_cstexpdat_bef, 101) end) = (case ltrim(str(year(iid_cstexpdat))) when '1900' then '' else
		convert(char(10), iid_cstexpdat, 101) end) then '' else 'Y' end else '' end as 'Change'
from	IMITMDAT (nolock)
where	iid_venitm = @iid_venitm and
	iid_untcde = @iid_untcde and
	iid_inrqty = @iid_inrqty and
	iid_mtrqty = @iid_mtrqty and
	iid_itmseq = @iid_itmseq and 
	iid_stage <> 'O' and
	iid_recseq = @iid_recseq












GO
GRANT EXECUTE ON [dbo].[sp_select_IMITMDAT_dtl2] TO [ERPUSER] AS [dbo]
GO
