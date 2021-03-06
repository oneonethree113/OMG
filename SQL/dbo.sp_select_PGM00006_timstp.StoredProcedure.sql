/****** Object:  StoredProcedure [dbo].[sp_select_PGM00006_timstp]    Script Date: 09/29/2017 15:29:09 ******/
DROP PROCEDURE [dbo].[sp_select_PGM00006_timstp]
GO
/****** Object:  StoredProcedure [dbo].[sp_select_PGM00006_timstp]    Script Date: 09/29/2017 15:29:10 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO








/*
=================================================================
Program ID	: sp_select_PGM00006_timstp
Description	: Retrieve timestamp for the selected SC Entry
Programmer	: David Yue
=================================================================
	MODIFICATION HISTORY
=================================================================
   Date		 Editor			Description
=================================================================
2013-05-13 	David Yue		SP Created
=================================================================
*/


CREATE procedure [dbo].[sp_select_PGM00006_timstp]
@cocde	varchar(6),
@mode	varchar(10),
@ordno	varchar(20),
@ordseq int,
@creusr	varchar(30)

as

if @mode = 'HDR'
begin
	select	cast(poh_timstp as int) as 'poh_timstp'
	from	PKORDHDR (nolock)
	where	poh_ordno = @ordno
end
else if @mode = 'DTL'
begin
	select	cast(pod_timstp as int) as 'pod_timstp'
	from	PKORDDTL (nolock)
	where	pod_ordno = @ordno and
		pod_seq = @ordseq
end






GO
GRANT EXECUTE ON [dbo].[sp_select_PGM00006_timstp] TO [ERPUSER] AS [dbo]
GO
