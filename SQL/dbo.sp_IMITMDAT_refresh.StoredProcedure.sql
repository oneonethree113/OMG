/****** Object:  StoredProcedure [dbo].[sp_IMITMDAT_refresh]    Script Date: 09/29/2017 15:29:09 ******/
DROP PROCEDURE [dbo].[sp_IMITMDAT_refresh]
GO
/****** Object:  StoredProcedure [dbo].[sp_IMITMDAT_refresh]    Script Date: 09/29/2017 15:29:09 ******/
SET ANSI_NULLS OFF
GO
SET QUOTED_IDENTIFIER OFF
GO











/*
=========================================================
Program ID	: 	sp_IMITMDAT_refresh
Description   	: 	
Programmer  	: 	PIC
=========================================================
 Modification History                                    
=========================================================
2004-08-25  Allan Yuen	Bug fix the item status
=========================================================     
*/



-- Checked by Allan Yuen at 1 Aug 2003 for merge project.

CREATE  PROCEDURE [dbo].[sp_IMITMDAT_refresh]

AS

UPDATE	IMBASINF
SET	ibi_prvsts = ibi_itmsts,
	ibi_itmsts = 'HLD', 	
	ibi_updusr = 'Excel',
	ibi_upddat = getdate()
FROM	IMITMDAT
WHERE	ibi_itmno = iid_itmno and
	ibi_itmsts <> 'HLD' and
	iid_refresh = 'Y' and 
	(SELECT count(*) FROM SYLNEINF WHERE yli_lnecde = iid_lnecde) > 0 and 
	(SELECT count(*) FROM SYCATREL WHERE ycr_catlvl4 = iid_catlvl4) > 0 --and 
	/*
	-- 2012/06/15 Editted by David Yue --
	(SELECT count(*) FROM IMCALFML WHERE icf_vencde = 'INT' and 
		icf_prdlne = iid_lnecde and icf_catlvl4 = iid_catlvl4) > 0
	*/

/*
UPDATE	IMITMDAT 	
SET	iid_stage = 'W' ,		
	iid_refresh = 'N',	
	iid_sysmsg = left(iid_sysmsg + ' (Invalid Before)',300),
	iid_updusr = 'System',		
	iid_upddat = getdate()
WHERE	iid_refresh = 'Y' and 
	(select count(*) from SYLNEINF where yli_lnecde = iid_lnecde) = 1 and 
	(select count(*) from SYCATREL where ycr_catlvl4 = iid_catlvl4) = 1 and
	
	-- 2012/06/15 Editted by David Yue --
	--(select count(*) from IMCALFML where icf_vencde = 'INT' and
	--	icf_prdlne = iid_lnecde and icf_catlvl4 = iid_catlvl4) = 1 and
	
	(select count(*) from IMASSDAT where iad_venitm = iid_venitm and iad_stage = 'I')  = 0 and
	(select count(*) from IMBOMDAT where ibd_venitm = iid_venitm and ibd_stage = 'I')  = 0
*/

--Frankie Cheung 20110826
exec sp_update_BasicPrice 'UCPP'








GO
GRANT EXECUTE ON [dbo].[sp_IMITMDAT_refresh] TO [ERPUSER] AS [dbo]
GO
