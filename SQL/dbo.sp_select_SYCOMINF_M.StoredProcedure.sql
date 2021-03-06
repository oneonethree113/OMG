/****** Object:  StoredProcedure [dbo].[sp_select_SYCOMINF_M]    Script Date: 09/29/2017 15:29:08 ******/
DROP PROCEDURE [dbo].[sp_select_SYCOMINF_M]
GO
/****** Object:  StoredProcedure [dbo].[sp_select_SYCOMINF_M]    Script Date: 09/29/2017 15:29:10 ******/
SET ANSI_NULLS OFF
GO
SET QUOTED_IDENTIFIER ON
GO









/*=========================================================
 Modification History                                    
=========================================================
Date		Author		Description
5 Jun 2003	Lewis		Add company Name and company short name
28 Feb 2005	Allan		Add Company Logo Path               
8 Apr 2005	Marco 		Add Company Group
=========================================================     
*/

------------------------------------------------- 
CREATE procedure [dbo].[sp_select_SYCOMINF_M]
                                                                                                                                                                                                                                                                 
---------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------- 
@yco_cocde 	nvarchar(6), 
@mode 		nvarchar(10)
---------------------------------------------- 
 
AS

begin
 Select 
yco_cocde,
yco_addr,
yco_conam, 	-- New add
yco_shtnam,	-- New add by Lewis on 6 Jun 2003
yco_mfystr,
yco_curyer,
yco_systim,
yco_irday,
yco_ir2day,
yco_moq,
yco_curcde,
yco_moa,
yco_bscrat,
yco_datfmt,
yco_ivmth,
yco_commth,
yco_prctle,
yco_expday,
yco_datrme1,
yco_datrme2,
yco_datrme3,
yco_datrme4,
yco_year,
yco_acinv,
yco_acsam,
yco_acinvadj,
yco_acsamtrm,
yco_logoimgpth,	-- New add by Allan Yuen on 28 Feb 2005
yco_addrc,	-- New add by Allan Yuen on 28 Feb 2005
yco_conamc,	-- New add by Allan Yuen on 28 Feb 2005
yco_shtnamc,	-- New add by Allan Yuen on 28 Feb 2005
yco_phoneno,	-- New add by Allan Yuen on 28 Feb 2005
yco_faxno,	-- New add by Allan Yuen on 28 Feb 2005
yco_email,	-- New add by Allan Yuen on 28 Feb 2005
yco_cogrp,
yco_creusr,
yco_updusr,
yco_credat,
yco_upddat,
cast(yco_timstp as int) as yco_timstp
--year(getdate()) as yco_updusr
                                  
--------------------------------- 
 from SYCOMINF
 where
                                                                                                                                                                                                                                                                 
---------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------- 
(@mode = 'All' and yco_cocde <> '999') or (@mode <>'All' and   yco_cocde = @mode )
                           
-------------------------- 

                                                           
---------------------------------------------------------- 
end





GO
GRANT EXECUTE ON [dbo].[sp_select_SYCOMINF_M] TO [ERPUSER] AS [dbo]
GO
