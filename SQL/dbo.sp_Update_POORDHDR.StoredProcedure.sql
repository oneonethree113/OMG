/****** Object:  StoredProcedure [dbo].[sp_Update_POORDHDR]    Script Date: 09/29/2017 15:29:08 ******/
DROP PROCEDURE [dbo].[sp_Update_POORDHDR]
GO
/****** Object:  StoredProcedure [dbo].[sp_Update_POORDHDR]    Script Date: 09/29/2017 15:29:10 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- Checked by Allan Yuen at 28/07/2003


/************************************************************************
Author:		Wong Hong
Date:		4th dec, 2002
Description:	Update data From POORDHDR
Parameter:	1. Company
		2. PO No.	
************************************************************************
2004-09-14	Allan Yuen		Add update billing Address
2004-09-30	Lester Wu		Update State, Country, Zip
*/
------------------------------------------------- 
CREATE  procedure [dbo].[sp_Update_POORDHDR]
                                                                                                                                                                                                                                                                 
---------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------- 
@poh_cocde  nvarchar(6), 	@poh_purord  nvarchar(20),	
@poh_porctp  nvarchar(20),	@poh_puragt  nvarchar(20),	
@poh_salrep  nvarchar(30),	@poh_shpstr  datetime,	
@poh_shpend  datetime,	@poh_lbldue  datetime,	
@poh_pocdat datetime,  	@poh_netamt numeric(13,4),
@poh_prctrm nvarchar(6),	@poh_paytrm nvarchar(6),
@poh_rmk  nvarchar (400),
@poh_discnt numeric(6,3),
@poh_puradr nvarchar(200),	
--Lester Wu 2004/09/30
-- Update State, Country, Zip
@poh_purstt nvarchar(20),
@poh_purcty nvarchar(6),
@poh_purpst nvarchar(20),
-- Mark Lau 20081202
@poh_purchnadr nvarchar(255),	
@poh_signappflg char(1),
@poh_vndackflg char(1),
@poh_dest nvarchar(30),
@poh_updusr nvarchar(30)

---------------------------------------------- 
 
AS
/*
declare @poh_salname as nvarchar(200)
set  @poh_salname  = 
(
select	top 1
	yup_usrnam 
from	SYSALREL, SYUSRPRF
where	
ssr_salrep = yup_usrid and yup_accexp > getdate()
and ssr_salrep =@poh_salrep
)
*/
begin
Update POORDHDR SET
poh_netamt = @poh_netamt,
poh_porctp=@poh_porctp,
poh_puragt=@poh_puragt,
poh_salrep=@poh_salrep,
poh_shpstr=@poh_shpstr,
poh_shpend=@poh_shpend,
poh_lbldue=@poh_lbldue,
poh_pocdat=@poh_pocdat,
poh_prctrm = @poh_prctrm,
poh_paytrm = substring(@poh_paytrm,1,3),
poh_rmk=@poh_rmk,
poh_updusr=@poh_updusr,
poh_discnt=@poh_discnt,
poh_puradr=@poh_puradr,
--Lester Wu 2004/09/30
--Update State, Country, Zip
poh_purstt = @poh_purstt,
poh_purcty = @poh_purcty,
poh_purpst = @poh_purpst,
-- Added by Mark Lau 20081202
poh_purchnadr = @poh_purchnadr,
poh_signappflg = @poh_signappflg,
poh_vndackflg = @poh_vndackflg,
poh_dest = @poh_dest,
-----------------------------------
poh_upddat=GETDATE()
--------------------------------- 


Where                                                                                                                                                                                                                           
---------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------- 
poh_cocde = @poh_cocde and
poh_purord = @poh_purord                                                                                    
---------------------------------------------------------- 


end

GO
GRANT EXECUTE ON [dbo].[sp_Update_POORDHDR] TO [ERPUSER] AS [dbo]
GO
