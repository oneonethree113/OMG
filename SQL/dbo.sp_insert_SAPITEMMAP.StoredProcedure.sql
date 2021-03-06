/****** Object:  StoredProcedure [dbo].[sp_insert_SAPITEMMAP]    Script Date: 09/29/2017 15:29:09 ******/
DROP PROCEDURE [dbo].[sp_insert_SAPITEMMAP]
GO
/****** Object:  StoredProcedure [dbo].[sp_insert_SAPITEMMAP]    Script Date: 09/29/2017 15:29:09 ******/
SET ANSI_NULLS OFF
GO
SET QUOTED_IDENTIFIER ON
GO





/*
=========================================================
Program ID	: sp_select_SAPITEMMAP
Description   	: 
Programmer  	: Mark Lau
Create Date   	:
Last Modified  	: 
Table Read(s) 	:
Table Write(s) 	:
=========================================================
 Modification History                                    
=========================================================
Date		Author		Description
=========================================================     

*/


CREATE   procedure [dbo].[sp_insert_SAPITEMMAP]
--@cocde 		nvarchar(6),
@sim_ordno	nvarchar(20),
@sim_itmno	nvarchar(20),
@sim_pckinstr	nvarchar(20),
@sim_vbeln	nvarchar(10),
@sim_posnr	nvarchar(6),
@sim_jobord	nvarchar(20),
@sim_jobno	nvarchar(20),
@sim_ordtype	nvarchar(20),
@sim_msgtype	nvarchar(20),
@sim_msg	nvarchar(255),
@FileName	as nvarchar(50)
as
BEGIN

if (select count(*) from sapitemmap where upper(sim_ordno) = upper(@sim_ordno) --and upper(sim_jobno) = upper(@sim_jobno) 
and upper(sim_itmno) = upper(@sim_itmno) and upper(sim_jobord) = upper(@sim_jobord) ) > 0
begin

update sapitemmap 
set sim_Latest = 'N', sim_UpdDat = getdate() , sim_UpdUsr = 'SAPUSER'
where upper(sim_ordno) = upper(@sim_ordno) --and upper(sim_jobno) = upper(@sim_jobno) 
and upper(sim_itmno) = upper(@sim_itmno) and upper(sim_jobord) = upper(@sim_jobord)


insert into SAPITEMMAP
(
sim_filename	,
sim_ordno	,
sim_itmno	,
sim_pckinstr	,
sim_vbeln	,
sim_posnr	,
sim_jobord	,
sim_jobno	,
sim_ordtype	,
sim_msgtype	,
sim_msg	,
sim_Latest, 		
sim_CreDat,
sim_CreUsr,
sim_UpdDat,
sim_UpdUsr
)
values
(
@Filename	,
@sim_ordno	,
@sim_itmno	,
@sim_pckinstr	,
@sim_vbeln	,
@sim_posnr	,
@sim_jobord	,
@sim_jobno	,
@sim_ordtype	,
@sim_msgtype	,
@sim_msg	,
'Y', 
getdate(),
'SAPUSER',
getdate(),
'SAPUSER'
)
end

else
begin


insert into SAPITEMMAP
(
sim_filename	,
sim_ordno	,
sim_itmno	,
sim_pckinstr	,
sim_vbeln	,
sim_posnr	,
sim_jobord	,
sim_jobno	,
sim_ordtype	,
sim_msgtype	,
sim_msg	,
sim_Latest, 		
sim_CreDat,
sim_CreUsr,
sim_UpdDat,
sim_UpdUsr
)
values
(
@Filename	,
@sim_ordno	,
@sim_itmno	,
@sim_pckinstr	,
@sim_vbeln	,
@sim_posnr	,
@sim_jobord	,
@sim_jobno	,
@sim_ordtype	,
@sim_msgtype	,
@sim_msg	,
'Y', 
getdate(),
'SAPUSER',
getdate(),
'SAPUSER'
)

end	

update scorddtl
set sod_zorvbeln = @sim_vbeln, sod_zorposnr = @sim_posnr, sod_upddat = getdate(), sod_updusr = 'SAPUSER'
from poorddtl,scorddtl
where upper(sod_ordno) = upper(@sim_ordno) and upper(sod_itmno) = upper(@sim_itmno) 
and pod_scno = sod_ordno and sod_ordseq = pod_scline and sod_itmno = pod_itmno
and pod_jobord = @sim_jobord
--and upper(sod_pjobno) = upper(@sim_jobno)

if @@rowcount  = 1
begin
update sapitemmap 
set sim_message = @sim_ordno + '/' + @sim_itmno + '/' + @sim_jobno + ' - Update Successfully', sim_updflg = 'S'
where upper(sim_ordno) = upper(@sim_ordno) and upper(sim_jobord) = upper(@sim_jobord) and upper(sim_itmno) = upper(@sim_itmno) and upper(sim_Latest) = 'Y'
end
else if @@ROWCOUNT > 1
begin
update sapitemmap 
set sim_message = @sim_ordno + '/' + @sim_itmno + '/' + @sim_jobno + ' - More Than 1 Record Affected', sim_updflg = 'N'
where upper(sim_ordno) = upper(@sim_ordno) and upper(sim_jobord) = upper(@sim_jobord) and upper(sim_itmno) = upper(@sim_itmno) and upper(sim_Latest) = 'Y'
end
else 
begin
update sapitemmap 
set sim_message = @sim_ordno + '/' + @sim_itmno + '/' + @sim_jobno + ' - No Record Found', sim_updflg = 'N'
where upper(sim_ordno) = upper(@sim_ordno) and upper(sim_jobord) = upper(@sim_jobord) and upper(sim_itmno) = upper(@sim_itmno) and upper(sim_Latest) = 'Y'
end 

END


GO
GRANT EXECUTE ON [dbo].[sp_insert_SAPITEMMAP] TO [ERPUSER] AS [dbo]
GO
