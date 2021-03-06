/****** Object:  StoredProcedure [dbo].[sp_list_hkmkup]    Script Date: 09/29/2017 15:29:09 ******/
DROP PROCEDURE [dbo].[sp_list_hkmkup]
GO
/****** Object:  StoredProcedure [dbo].[sp_list_hkmkup]    Script Date: 09/29/2017 15:29:09 ******/
SET ANSI_NULLS OFF
GO
SET QUOTED_IDENTIFIER OFF
GO



CREATE PROCEDURE [dbo].[sp_list_hkmkup]

@cocde	nvarchar(10),
@cus1no 	nvarchar(10),
@cus2no 	nvarchar(10),
@itmno		nvarchar(20),
@csttyp 	nvarchar(10)

 AS

DECLARE
@ibi_catlvl2	nvarchar(20),
@fml		nvarchar(20),
@OP		nvarchar(1),
@end		int,
@temp		nvarchar(20),
@i 		int,
@tmpcst	numeric(13,4),
@ftyfml		nvarchar(10),
@hkfml		nvarchar(10),
@test		int,
@debug		int

BEGIN

select @ibi_catlvl2 = isnull( substring(imd_catlvl4,1, charindex('.', imd_catlvl4)-1), '')
from IMMRKUPDTL where imd_itmno = @itmno

if isnull(@ibi_catlvl2,'') = '' 
begin
	select  @ibi_catlvl2 = ibi_catlvl2  from  IMBASINF where ibi_itmno = @itmno
end


select  yfi_fml, yfi_fmlopt
from syfmlinf  
where yfi_fmlopt =
(
	select	 ycs_hkfmlopt
	from SYCSTSET
	where	ycs_cus1no = @cus1no and
		ycs_cus2no = @cus2no and
		ycs_itmcat = @ibi_catlvl2 and
		ycs_csttyp = @csttyp
)

END


GO
GRANT EXECUTE ON [dbo].[sp_list_hkmkup] TO [ERPUSER] AS [dbo]
GO
