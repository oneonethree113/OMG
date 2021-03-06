/****** Object:  StoredProcedure [dbo].[sp_list_SHIPGDTL_SUM]    Script Date: 09/29/2017 15:29:09 ******/
DROP PROCEDURE [dbo].[sp_list_SHIPGDTL_SUM]
GO
/****** Object:  StoredProcedure [dbo].[sp_list_SHIPGDTL_SUM]    Script Date: 09/29/2017 15:29:10 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO







-- Checked by Allan Yuen at 28/07/2003

/*
=========================================================
Program ID	: sp_list_SHIPGDTL_SUM
Description   	: creat Shipping Detail Summary Recordset template 
Programmer  	: Lewis To
ALTER  Date   	: 13 Jul 2003
Last Modified  	: 
Table Read(s) 	:SHIPGDTL
Table Write(s) 	:
=========================================================
 Modification History                                    
=========================================================
Date		Author		Description
22nd Jul, 2004	Lester Wu		Move the field hid_purord to the position in between hid_ordno and hid_itmno               
12th Sep, 2005	Lester Wu		Show Vendor Short Name of PV and CV
=========================================================     
*/

-- sp_list_SHIPGDTL_SUM 'UCPP'

CREATE  procedure [dbo].[sp_list_SHIPGDTL_SUM]
                                                                                                                                                                                                                                                               

@hid_cocde nvarchar(6) 
--@hid_shpno nvarchar(20) 
 
AS
begin


declare @tmp_VenSna as nvarchar(40)

set @tmp_VenSna = ' '


select 
'' as 'DEL',
'' as 'COV',
hid_cocde, 
hid_shpno, 
hid_shpseq, 
hid_invno, 
hid_ctrsiz, 
hid_ctrcfs, 
hid_sealno, 
hid_cuspo, 
hid_jobno, 
hid_ordno, 
hid_purord, 
hid_itmno,
hid_cusitm,
'' as 'dcp',
hid_cuscol,
hid_shpqty,
hid_untcde,
hid_ttlctn,	
hid_ctnstr,
hid_ctnend,
'' as 'hid_mtrdcm',
hid_actvol,
hid_ttlvol,
hid_grswgt,
hid_ttlgrs,	
hid_netwgt,
hid_ttlnet,	
hid_paytrm,	
'' as 'hid_paytrmdsc',
hid_prctrm,
hid_selprc,
hid_untsel,
hid_untamt,
hid_ttlamt,
hid_mannam,
hid_venno,
hid_cusven,
hid_pckrmk,	
hid_creusr,
hid_alsitmno,
hid_alscolcde,
hid_custum

from SHIPGDTL



where                                                                                                                                                                                                                                                          
       
hid_cocde = 'XXXXXX'

order by hid_shpno, hid_shpseq
end






GO
GRANT EXECUTE ON [dbo].[sp_list_SHIPGDTL_SUM] TO [ERPUSER] AS [dbo]
GO
