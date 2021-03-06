/****** Object:  StoredProcedure [dbo].[sp_select_VNBASINF_SC]    Script Date: 09/29/2017 15:29:08 ******/
DROP PROCEDURE [dbo].[sp_select_VNBASINF_SC]
GO
/****** Object:  StoredProcedure [dbo].[sp_select_VNBASINF_SC]    Script Date: 09/29/2017 15:29:10 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO



/*
=================================================================
Program ID	: sp_select_VNBASINF_SC
Description	: Retrieve Vendor List for Sales Confirmation
Programmer	: David Yue
=================================================================
	MODIFICATION HISTORY
=================================================================
   Date		 Editor			Description
=================================================================
2013-06-30 	David Yue		SP Created
=================================================================
*/


CREATE procedure [dbo].[sp_select_VNBASINF_SC]
                                                                                                                                                                                                                                                               
  

@cocde nvarchar(6) ,
@itmno nvarchar(20) 
                                               

AS
BEGIN

DECLARE
@ventyp		char(1),
@tmp_venno	varchar(30)

set @ventyp  = ''
set @tmp_venno = ''

if (select count(*) from IMBASINFH (nolock) where ibi_itmno = @itmno) = 0
begin
	select	@ventyp  = isnull(vbi_ventyp,''),
		@tmp_venno = isnull(ibi_venno,'')
	from 	IMBASINF (nolock)
		left join VNBASINF (nolock) on
			vbi_venno = ibi_cusven
	where	ibi_alsitmno = @itmno
	
	if ltrim(rtrim(@tmp_venno)) = '' 
	begin
		select	@ventyp  = vbi_ventyp ,
			@tmp_venno = ibi_cusven
		from 	IMBASINF (nolock)
			left join VNBASINF (nolock) on
				vbi_venno = ibi_cusven
		where	ibi_itmno = @itmno
	end
end
else
begin
	select	@ventyp  = isnull(vbi_ventyp,''),
		@tmp_venno = isnull(ibi_venno,'')
	from 	IMBASINFH (nolock)
		left join VNBASINF (nolock) on
			vbi_venno = ibi_cusven
	where	ibi_alsitmno = @itmno
	
	if ltrim(rtrim(@tmp_venno)) = '' 
	begin
		select	@ventyp  = vbi_ventyp ,
			@tmp_venno = ibi_cusven
		from 	IMBASINFH (nolock)
			left join VNBASINF (nolock) on
				vbi_venno = ibi_cusven
		where	ibi_itmno = @itmno
	end
end

if @ventyp = 'I' or @ventyp = 'J'
begin
	select	vbi_venno,
		isnull(vbi_vensna,'') as 'vbi_vensna',
		vbi_vensts
	from	VNBASINF (nolock)
	where	(vbi_ventyp in ('I','J') and vbi_venno not in ('0005','0006','0007','0008','0009')) or
		(vbi_ventyp not in ('I','J') and vbi_venno in (select ibi_venno from IMBASINF (nolock) where ibi_itmno = @itmno))
	order by vbi_venno
end
else
begin
	select	vbi_venno,
		isnull(vbi_vensna,'') as 'vbi_vensna',
		vbi_vensts
	from	VNBASINF (nolock)
	where	vbi_ventyp = 'E'
	order by vbi_venno
end


END






GO
GRANT EXECUTE ON [dbo].[sp_select_VNBASINF_SC] TO [ERPUSER] AS [dbo]
GO
