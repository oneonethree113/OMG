/****** Object:  StoredProcedure [dbo].[sp_select_QUOTNDTL_moq_moa]    Script Date: 09/29/2017 15:29:09 ******/
DROP PROCEDURE [dbo].[sp_select_QUOTNDTL_moq_moa]
GO
/****** Object:  StoredProcedure [dbo].[sp_select_QUOTNDTL_moq_moa]    Script Date: 09/29/2017 15:29:10 ******/
SET ANSI_NULLS OFF
GO
SET QUOTED_IDENTIFIER OFF
GO





/*	Author : Tommy Ho 	*/
/* 26 Jul 2003 	Lewis To		Change to ignor Company Code in system file *****************/

CREATE PROCEDURE [dbo].[sp_select_QUOTNDTL_moq_moa] 

@cocde 		nvarchar(6),
@itmno		nvarchar(20),
@moq		int,
@creusr		nvarchar(30)

AS
declare 
@alias  varchar(20)

if (select count(*) from imbasinf where ibi_alsitmno = @itmno) > 0
begin 	
	set @alias = (select ibi_itmno from imbasinf where ibi_alsitmno = @itmno)
end
else
begin 
	set @alias = ''
end

select 	ivi_venno, 	yts_tirtyp, 		yts_qtyfr, 
	yts_qtyto, 		yts_moq, 		yts_moa  
from	IMVENINF
left join 	SYTIESTR 	
	on 	--ivi_cocde = yts_cocde 	and 
		ivi_venno = yts_venno 	and 
		yts_tirtyp = 'M'		and
		yts_qtyfr <= @moq 		and 	
		yts_qtyto >= @moq
where 	--ivi_cocde = @cocde 	and 
	ivi_itmno = (case @alias when '' then @itmno else @alias end)	and 
	ivi_def = 'Y'





GO
GRANT EXECUTE ON [dbo].[sp_select_QUOTNDTL_moq_moa] TO [ERPUSER] AS [dbo]
GO
