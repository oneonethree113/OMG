/****** Object:  StoredProcedure [dbo].[sp_select_MPO00003_Dtl]    Script Date: 09/29/2017 15:29:09 ******/
DROP PROCEDURE [dbo].[sp_select_MPO00003_Dtl]
GO
/****** Object:  StoredProcedure [dbo].[sp_select_MPO00003_Dtl]    Script Date: 09/29/2017 15:29:10 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO



/*
=========================================================
Program ID	: sp_select_MPO00003_Dtl
Description   	: 
Programmer  	: Lester Wu
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

--sp_select_MPO00003_Dtl 'UCPP','H','','','07/01/2005','08/12/2005'

CREATE   procedure [dbo].[sp_select_MPO00003_Dtl]
@cocde		as varchar(6),
@sts		as varchar(3),
@PONoFm	as varchar(20),
@PONoTo		as varchar(20),
@dtFm		as varchar(10),
@dtTo		as varchar(10)
as
BEGIN


if @sts = 'H'
	Begin
		select 
			*

		from MPORDDTL 
		where mpd_pono in (
				select 
					Mxh_PONo
				from
					MPOEXPHDR
				where
					(@PONoFm = '' or (Mxh_PONo between @PONoFm and @PONoTo )) and 
					--(@FilNamFm = '' or (Mxh_FilNam between @FilNamFm and @FilNamTo)) and
					(@dtFm = '01/01/1900' or (Mxh_CreDat between @dtFm and @dtTo + ' 23:59:59'))
				)

		
	End
Else
	Begin
	
		select 
			*

		from MPORDDTL 
		where mpd_pono in (
					select
						 distinct Mxd_PONo 
					from 
						MPOEXPDTL
					where
						(@PONoFm = '' or (Mxd_PONo between @PONoFm and @PONoTo )) and 
						--(@FilNamFm = '' or (Mxd_FilNam between @FilNamFm and @FilNamTo)) and
						(@dtFm = '01/01/1900' or (Mxd_CreDat between @dtFm and @dtTo + ' 23:59:59'))
				)								

					
	
	End

END







GO
GRANT EXECUTE ON [dbo].[sp_select_MPO00003_Dtl] TO [ERPUSER] AS [dbo]
GO
