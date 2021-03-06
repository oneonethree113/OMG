/****** Object:  StoredProcedure [dbo].[sp_select_IMPCKINFH]    Script Date: 09/29/2017 15:29:09 ******/
DROP PROCEDURE [dbo].[sp_select_IMPCKINFH]
GO
/****** Object:  StoredProcedure [dbo].[sp_select_IMPCKINFH]    Script Date: 09/29/2017 15:29:10 ******/
SET ANSI_NULLS OFF
GO
SET QUOTED_IDENTIFIER OFF
GO













/*
=========================================================
Program ID	: 
Description   	: 
Programmer  	: 
ALTER  Date   	: 
Last Modified  	: 17 July 2003
Table Read(s) 	:
Table Write(s) 	:
=========================================================
 Modification History                                    
=========================================================
Date		Author		Description
=========================================================     
17 July 2003	Allan Yuen		For Merge Porject, disable company code
*/





/************************************************************************
Author:		Kenny Chan
Date:		14th September, 2001
Description:	Select data From IMPCKINFH
Parameter:	1. Company
		2. Item No.	
************************************************************************/
------------------------------------------------- 
CREATE procedure [dbo].[sp_select_IMPCKINFH]
                                                                                                                                                                                                                                                                 
---------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------- 
@ipi_cocde nvarchar(6) ,
@ipi_itmno nvarchar(20) 
                                               
---------------------------------------------- 
 
AS
declare @max_seq int

--SET @max_seq = (Select isnull(max(ipi_pckseq),0) from IMPCKINF where ipi_cocde = @ipi_cocde and ipi_itmno = @ipi_itmno)
SET @max_seq = (Select isnull(max(ipi_pckseq),0) from IMPCKINF where ipi_itmno = @ipi_itmno)

begin
 Select 

---------
ipi_creusr as 'ipi_status',
ipi_creusr as 'ipi_relation',
'' as 'ipi_cocde',
ipi_itmno,
ipi_pckseq,
-- Frankie Cheung 20110727 Add Period
case when year(ipi_qutdat) = 1900 then '' else
ltrim(str(year(ipi_qutdat))) + '-' + right('0' +  ltrim(str( month(ipi_qutdat))),2) end as 'ipi_qutdat',
ipi_pckunt,
ipi_inrqty,
ipi_mtrqty,
ipi_cus1no,
ipi_cus2no,
ipi_cft,
ipi_cbm,

cast(ipi_inrdin as nvarchar) + 'x' +
cast(ipi_inrwin as nvarchar)+ 'x' +
cast(ipi_inrhin as nvarchar)  as 'inner_in',

cast(ipi_mtrdin as nvarchar)+ 'x' +
cast(ipi_mtrwin as nvarchar)+  'x' +
cast(ipi_mtrhin as nvarchar) as 'master_in',

cast(ipi_inrdcm as nvarchar)+ 'x' +
cast(ipi_inrwcm as nvarchar)+ 'x' +
cast(ipi_inrhcm as nvarchar) as 'inner_cm',

cast(ipi_mtrdcm as nvarchar)+ 'x' +
cast(ipi_mtrwcm as nvarchar)+ 'x' +
cast(ipi_mtrhcm as nvarchar) as 'master_cm',

ipi_grswgt,
ipi_netwgt,
--ipi_pckitr,
-- Frankie Cheung 20110727 Add Period
ipi_pckitr = isnull(ipi_pckitr, ''),
ltrim(isnull(str(ipi_conftr),'')) as 'ipi_conftr', 
ipi_cusno,
cbi_cussna 'ipi_cussna',
ipi_creusr,
ipi_updusr,
ipi_credat,
ipi_upddat,
cast(ipi_timstp as int) as ipi_timstp,
@max_seq as 'max_seq',
-- Added by Mark Lau 20090211
--ipi_qutdat
-- Frankie Cheung 20100303 Add Period
--case when year(ipi_qutdat) = 1900 then '' else
--ltrim(str(year(ipi_qutdat))) + '-' + right('0' +  ltrim(str( month(ipi_qutdat))),2) end as 'ipi_qutdat'

-- David Yue	2012-09-12	Add Packing Inner Size, Master Size, Material
isnull(ipi_inrsze,'') as 'ipi_inrsze',
isnull(ipi_mtrsze,'') as 'ipi_mtrsze',
isnull(ipi_mat,'') as 'ipi_mat'
--------------------------------- 
 from IMPCKINFH
left join CUBASINF on cbi_cusno = ipi_cusno
 where
                                                                                                                                                                                                                                                                 
---------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------- 
-- ipi_cocde = @ipi_cocde and
 ipi_itmno = @ipi_itmno
order by ipi_pckunt,ipi_conftr,ipi_inrqty,ipi_mtrqty,ipi_cft,ipi_cus1no,ipi_cus2no             
--order by imu_pckunt, imu_conftr, imu_inrqty, imu_mtrqty, imu_cft, imu_ftyprctrm, imu_hkprctrm, imu_trantrm, imu_cus1no, imu_cus2no, imu_venno, imu_prdven
           
-------------------------- 

                                                           
---------------------------------------------------------- 
end



GO
GRANT EXECUTE ON [dbo].[sp_select_IMPCKINFH] TO [ERPUSER] AS [dbo]
GO
