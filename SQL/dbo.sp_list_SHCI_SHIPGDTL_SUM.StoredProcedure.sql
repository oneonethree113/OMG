/****** Object:  StoredProcedure [dbo].[sp_list_SHCI_SHIPGDTL_SUM]    Script Date: 09/29/2017 15:29:09 ******/
DROP PROCEDURE [dbo].[sp_list_SHCI_SHIPGDTL_SUM]
GO
/****** Object:  StoredProcedure [dbo].[sp_list_SHCI_SHIPGDTL_SUM]    Script Date: 09/29/2017 15:29:10 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO




-- Checked by Allan Yuen at 28/07/2003

/*
=========================================================
Program ID	: sp_list_SHCI_SHIPGDTL_SUM
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

-- sp_list_SHCI_SHIPGDTL_SUM 'UCPP'

CREATE procedure [dbo].[sp_list_SHCI_SHIPGDTL_SUM]
                                                                                                                                                                                                                                                               

@hid_cocde nvarchar(6) 
--@hid_shpno nvarchar(20) 
 
AS
begin


declare @tmp_VenSna as nvarchar(40)

set @tmp_VenSna = ' '


select 

hid_cocde,					--	0
hid_shpno,					--	1
hid_shpseq,				--1	2
hid_invno,					--1.1	3
hid_ctrsiz,					--1.2	4
hid_ctrcfs,					--2	5
hid_sealno,					--3	6
hid_cuspo,					--3.1	7
hid_jobno,					--4	8
hid_ordno,					--5	9
--Lester Wu 2004/07/23
--Move the position of PO No
hid_purord,				--27	33		10
---------------------------
hid_itmno,					--6	10		11
hid_cusitm,				--6.1	11		12

'' as 'hid_colpck',				--6.2	12		13
hid_cuscol,					--6.3	13		14
hid_shpqty,				--7	14		15
hid_untcde,					--8	15		16
--hid_conftr , 
--hid_contopc , 
hid_ttlctn,					--9	16		17
hid_ctnstr,					--10	17		18
hid_ctnend,					--11	18		19
'' as 'hid_mtrdim',				--12 X 13 X 14	19	20
--hid_mtrdcm,				--12,13,14			
--hid_mtrwcm,
--hid_mtrhcm,
hid_actvol,					--15	20		21
hid_ttlvol,					--16	21		22
hid_grswgt,				--17	22		23
hid_ttlgrs,					--18	23		24

hid_netwgt,				--19	24		25
hid_ttlnet,					--20	25		26
hid_paytrm,				--	26		27
'' as 'hid_paytrmdsc',				--21	27		28
hid_prctrm,				--22	28		29
hid_selprc,					--23	29		30
hid_untsel,					--24	30		31
hid_untamt,				--25	31		32
hid_ttlamt,					--26	32		33
--Lester Wu 2004/07/23
--Move the position of PO No
--hid_purord,				--27	33		
----------------
hid_mannam,				--28	34		34
-- Lester Wu , Show Vendor Short Name of CV and PV
--hid_venno 
--hid_cusven
hid_venno + ' ' +  @tmp_VenSna as 'hid_venno',					--29	35		35
hid_cusven + ' ' +  @tmp_VenSna as 'hid_cusven',
----------------------------------------------------------------------
hid_pckrmk,				--30	36		36
hid_creusr	,				--31	37		37
--added by Mark Lau 20060929
hid_alsitmno,
hid_alscolcde,
--Added by Mark Lau 20080618
isnull(hid_custum,'') as 'hid_custum'

from SHCI_SHIPGDTL



where                                                                                                                                                                                                                                                          
       
hid_cocde = 'XXXXXX'

order by hid_shpno, hid_shpseq
end



GO
GRANT EXECUTE ON [dbo].[sp_list_SHCI_SHIPGDTL_SUM] TO [ERPUSER] AS [dbo]
GO
