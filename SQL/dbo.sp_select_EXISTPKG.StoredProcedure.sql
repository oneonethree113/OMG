/****** Object:  StoredProcedure [dbo].[sp_select_EXISTPKG]    Script Date: 09/29/2017 15:29:09 ******/
DROP PROCEDURE [dbo].[sp_select_EXISTPKG]
GO
/****** Object:  StoredProcedure [dbo].[sp_select_EXISTPKG]    Script Date: 09/29/2017 15:29:10 ******/
SET ANSI_NULLS OFF
GO
SET QUOTED_IDENTIFIER OFF
GO
















CREATE  procedure [dbo].[sp_select_EXISTPKG]
                                                                                                                                                                                                                                                                 
@code nvarchar(10),
@Ordno nvarchar(20),
@type nvarchar(10)


---------------------------------------------- 

 
AS
 

begin

 if @type = 'SC'
begin

declare @output as int

select @output = count (sod_ordno)
from scorddtl where sod_ordno = @Ordno
and sod_cocde = @code

	if @output <> 0
	begin
	select '1' as 'CountedData',c.sod_ordno,a.toh_toordno,b.prh_Scno,e.prh_ToNo  from scorddtl c (nolock)
	left join toordhdr a on toh_toordno = sod_tordno
	left join PKREQHDR b on prh_ScNo = sod_ordno and b.prh_Flag ='02'
	left join PKREQHDR e on a.toh_toordno = e.prh_ToNo and e.prh_Flag ='02'
	where sod_ordno = @Ordno and (b.prh_Scno is not null or e.prh_ToNo is not null)
	end
	else
	begin
	select '0' as 'CountedData' --NOT SC HAD FOUND
	end


end 

else if @type = 'TO'

begin 

declare @output2 as int

select @output2 = count (toh_toordno)
from toordhdr where toh_toordno = @Ordno
and toh_cocde = @code

	if @output2 <> 0
	begin
	select '1' as 'CountedData',c.toh_toordno,a.sod_ordno,b.prh_Scno,e.prh_ToNo  from toordhdr c (nolock)
	left join scorddtl a on sod_tordno  = toh_toordno
	left join PKREQHDR b on prh_ToNo = toh_toordno and prh_Flag ='02'
	left join PKREQHDR e on a.sod_ordno = e.prh_ScNo and e.prh_Flag ='02'
	where toh_toordno = @Ordno and (b.prh_ToNo is not null or e.prh_ScNo is not null)
	end
	else
	begin
	select '0' as 'CountedData' --NOT SC HAD FOUND
	end
 
end 


end












GO
GRANT EXECUTE ON [dbo].[sp_select_EXISTPKG] TO [ERPUSER] AS [dbo]
GO
