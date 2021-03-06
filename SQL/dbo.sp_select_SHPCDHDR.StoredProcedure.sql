/****** Object:  StoredProcedure [dbo].[sp_select_SHPCDHDR]    Script Date: 09/29/2017 15:29:09 ******/
DROP PROCEDURE [dbo].[sp_select_SHPCDHDR]
GO
/****** Object:  StoredProcedure [dbo].[sp_select_SHPCDHDR]    Script Date: 09/29/2017 15:29:10 ******/
SET ANSI_NULLS OFF
GO
SET QUOTED_IDENTIFIER OFF
GO





CREATE procedure [dbo].[sp_select_SHPCDHDR]
                                                                                                                                                                                                                                                               
@hiv_cocde nvarchar(6) ,
@hiv_invno nvarchar(20) 
AS 
SELECT
s.hih_shpsts,
s.hih_cus1no,
s.hih_cus2no,
s.hih_smpshp,
s.hih_biladr,
s.hih_bilstt,
s.hih_bilcty,
s.hih_bilzip,
i.hiv_prctrm,
i.hiv_paytrm,
i.hiv_ttlamt,
i.hiv_untamt
from SHIPGHDR s, SHINVHDR i
where                                                                                                                                                                                                                                                                 
s.hih_cocde = i.hiv_cocde and
s.hih_shpno = i.hiv_shpno and
i.hiv_cocde = @hiv_cocde and
i.hiv_invno = @hiv_invno


GO
GRANT EXECUTE ON [dbo].[sp_select_SHPCDHDR] TO [ERPUSER] AS [dbo]
GO
