/****** Object:  StoredProcedure [dbo].[sp_update_SHPOSTS]    Script Date: 09/29/2017 15:29:08 ******/
DROP PROCEDURE [dbo].[sp_update_SHPOSTS]
GO
/****** Object:  StoredProcedure [dbo].[sp_update_SHPOSTS]    Script Date: 09/29/2017 15:29:10 ******/
SET ANSI_NULLS OFF
GO
SET QUOTED_IDENTIFIER OFF
GO





-- Checked by Allan Yuen at 27/07/2003


/*
==================================================================================
Program ID	: 	sp_update_SHPOSTS
DePOription   	: 	Check and Update PO Status online
Programmer  	: 	Lewis To
Create Date   	: 	13 May 2003
Last Modified  	: 
Table Read(s) 	:	POORDHDR, POORDDTL, POBOMHDR, POBOMDTL
Table Write(s) 	:	POORDHDR, POBOMHDR
==================================================================================
 Modification History                                    
==================================================================================
Modification Date	Modified by	Description
==================================================================================
2005-03-05	Allan Yuen		Add Skip updte status if status is active.
2005-11-02	Lester Wu 		Cater the problem when PO closed but BOM PO not close
==================================================================================     
*/


CREATE PROCEDURE [dbo].[sp_update_SHPOSTS]


--Declare
@poh_cocde 	varchar(5),
@poh_purord	varchar(20),
@poh_usr		varchar(30)


--set @poh_cocde = 'UCPP'
--set @poh_purord = 'UP0303264'
--set @poh_usr = 'MIS'
AS

Declare
@pod_outqty 	int,
@pod_ttlord	int
select 
	@pod_outqty = sum(case when (pod_ordqty-pod_recqty)>0 Then (pod_ordqty-pod_recqty) ELSE 0 END) ,
          	@pod_ttlord = sum(case when (pod_ordqty)>0 Then (pod_ordqty) ELSE 0 END)
from 
	poorddtl 
where 
	pod_cocde = @poh_cocde and 
	pod_purord = @poh_purord

Update 
	poordhdr 
set 
	poh_pursts = case when @pod_outqty = 0 Then 'CLO' Else 'REL' End,
             poh_updusr = @poh_usr,
	poh_upddat = getdate()
where 
	poh_cocde = @poh_cocde and 
	poh_purord = @poh_purord and 
	@pod_ttlord > 0 and 
	poh_pursts <> case when @pod_outqty = 0 Then 'CLO' Else 'REL' End and
	poh_pursts in ('CLO','REL' )


Update 
	pobomhdr 
set 
	pbh_bomsts = case when @pod_outqty = 0 Then 'CLO' Else 'OPE' End,
	pbh_updusr = @poh_usr,
	pbh_upddat = getdate()
where 
	pbh_cocde = @poh_cocde and 
	pbh_purord = @poh_purord and 
	@pod_ttlord > 0 and 
	pbh_bomsts <> case when @pod_outqty = 0 Then 'CLO' Else 'OPE' End --and
--Lester Wu , 2005/11/02 , Cater the problem when PO closed but BOM PO not close
--	pbh_bomsts  in ('CLO','REL')

--select * from pobomhdr




GO
GRANT EXECUTE ON [dbo].[sp_update_SHPOSTS] TO [ERPUSER] AS [dbo]
GO
