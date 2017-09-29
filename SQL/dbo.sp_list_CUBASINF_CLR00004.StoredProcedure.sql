/****** Object:  StoredProcedure [dbo].[sp_list_CUBASINF_CLR00004]    Script Date: 09/29/2017 15:29:09 ******/
DROP PROCEDURE [dbo].[sp_list_CUBASINF_CLR00004]
GO
/****** Object:  StoredProcedure [dbo].[sp_list_CUBASINF_CLR00004]    Script Date: 09/29/2017 15:29:09 ******/
SET ANSI_NULLS OFF
GO
SET QUOTED_IDENTIFIER OFF
GO



CREATE PROCEDURE [dbo].[sp_list_CUBASINF_CLR00004] 

@cocde nvarchar(8) = ' ',
@usrid nvarchar(30)

AS

select distinct cbi_saldiv

from CUBASINF

--where ysr_cocde = @cocde
where cbi_cocde = ' '

order by cbi_saldiv








GO
GRANT EXECUTE ON [dbo].[sp_list_CUBASINF_CLR00004] TO [ERPUSER] AS [dbo]
GO
