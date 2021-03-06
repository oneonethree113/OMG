/****** Object:  StoredProcedure [dbo].[sp_update_IMITMDAT_UM]    Script Date: 09/29/2017 15:29:08 ******/
DROP PROCEDURE [dbo].[sp_update_IMITMDAT_UM]
GO
/****** Object:  StoredProcedure [dbo].[sp_update_IMITMDAT_UM]    Script Date: 09/29/2017 15:29:10 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO




-- sp_update_IMITMDAT_UM 'CARD','1','Y'  


/*
=========================================================
Program ID	: 	sp_update_IMITMDAT_UM
Description   	: 	Update IMITMDAT UM
Programmer  	: 	
=========================================================
 Modification History                                   
=========================================================
2013-08-12	David Yue	Use Conversion Factor field
=========================================================     
*/

 
CREATE procedure [dbo].[sp_update_IMITMDAT_UM]  
as  
begin  
 

-- Added by Mark Lau 20090429
-- IMITMCST
update	IMITMDATCST 
set	iic_untcde = des.ycf_code1,  
	iic_conftr = iid_conftr  
from	IMITMDATCST,
	IMITMDAT,
	SYCONFTR src ,
	SYCONFTR des  
where	iid_itmtyp = 'ASS' and
	iid_untcde = src.ycf_code1 and
	src.ycf_dsc1 = des.ycf_dsc1 and
	src.ycf_value > 1 and
	des.ycf_value = 1 and
	des.ycf_systyp = 'N' and
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
	iic_conftr = iid_assconftr

--Lester Wu 2007-07-17  
update	IMITMDAT  
set	iid_untcde = des.ycf_code1,  
	iid_assconftr = iid_conftr,  iid_conftr = 1  
from	IMITMDAT,
	SYCONFTR src,
	SYCONFTR des  
where	iid_itmtyp = 'ASS' and
	iid_untcde = src.ycf_code1 and
	src.ycf_dsc1 = des.ycf_dsc1 and
	src.ycf_value > 1 and
	des.ycf_value = 1 and
	des.ycf_systyp = 'N'

-- David yue 2013-08-21
update	IMITMDAT
set	iid_conftr = iid_assconftr
where	iid_itmtyp <> 'ASS' and
	iid_conftr <> iid_assconftr

-- Added by Mark Lau 20090429
-- IMITMCST
update	IMITMDATCST
set	iic_untcde = 'ST'
from	IMITMDATCST,
	IMITMDAT
where	iic_untcde = 'ST1' and
	iid_itmtyp = 'ASS' and 
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
	iic_conftr = iid_assconftr 

-- Lester Wu 2008-01-18
update	IMITMDAT
set	iid_untcde = 'ST'
where	iid_untcde = 'ST1' and
	iid_itmtyp = 'ASS'





end  






GO
GRANT EXECUTE ON [dbo].[sp_update_IMITMDAT_UM] TO [ERPUSER] AS [dbo]
GO
