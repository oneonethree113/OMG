/****** Object:  StoredProcedure [dbo].[sp_insert_IMBOMHIS]    Script Date: 09/29/2017 15:29:09 ******/
DROP PROCEDURE [dbo].[sp_insert_IMBOMHIS]
GO
/****** Object:  StoredProcedure [dbo].[sp_insert_IMBOMHIS]    Script Date: 09/29/2017 15:29:09 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO



/*
======================================================
Program ID	: sp_insert_IMBOMHIS
Description		: Insert BOM Item Information into IMBOMHIS
		: update design vendor in IMBASINF,IMVENPCK,IMVENINF,IMMRKUP
Programmer	: Lester Wu
Create Date		: 19th July , 2004
Table Read(s)	: 
Table Write(s)	: IMBOMHIS,IMBASINF,IMVENPCK,IMVENINF,IMMRKUP
======================================================
Modification History
======================================================
Date		Initial		Description
======================================================

sp_insert_IMBOMHIS 'UCPP','031603-00001','0001','0003','HKD','1.14','HKD','1.14','mis'

*/

CREATE procedure [dbo].[sp_insert_IMBOMHIS]
@cocde	nvarchar(6),
@itmno	nvarchar(20),
@venno_old	nvarchar(6),
@venno	nvarchar(6),
@imu_curcde	nvarchar(6),
@imu_ttlcst	numeric(13,4),
@imu_bcurcde	nvarchar(6),
@imu_ftycst	numeric(13,4),
@usrid	nvarchar(30)
as
begin

--declare a variable to store the error code
declare @errcde as int
declare @rowcnt as int
declare @str as nvarchar(400)

begin transaction

set @errcde = @@error
set @rowcnt = @@RowCount

set @str = ''

if @errcde=0 
begin

	set @str = 'Cannot Insert Data to IMBOMHIS!'

	insert into IMBOMHIS 
	values (@itmno, @venno_old, @imu_bcurcde, @imu_ftycst, @imu_curcde, @imu_ttlcst, @usrid, getdate())

	select @errcde = @@error, @rowcnt = @@RowCount
end 



if @errcde=0 and @rowcnt = 1
begin


	if exists (select * from IMMRKUP where imu_itmno = @itmno and imu_venno=@venno_old) 
	begin
		
		set @str = 'Cannot Update Design Vendor in IMMRKUP!'

		update IMMRKUP 
		set 	imu_venno = @venno,
			imu_prdven = case isnull(imu_prdven,'') when '' then '' else @venno end ,
			imu_updusr = @usrid,
			imu_upddat = getdate()
	
		where imu_itmno = @itmno and imu_venno=@venno_old

		select @errcde = @@error, @rowcnt = @@RowCount
	end
	else
	begin
		set @str = 'Design Vendor or BOM Item No Not Match  in IMMRKUP!'
		set @rowcnt = 0
	end
end 



if @errcde=0 and @rowcnt = 1
begin


	if exists(select * from IMVENINF where ivi_itmno = @itmno and ivi_venno = @venno_old)
	begin
		set @str = 'Cannot Update Design Vendor in IMVENINF!'

		update IMVENINF 
		set 	ivi_venno = @venno,
			ivi_updusr = @usrid,
			ivi_upddat = getdate()

		where ivi_itmno = @itmno and ivi_venno = @venno_old

		select @errcde = @@error, @rowcnt = @@RowCount
	end
	else
	begin
		set @str = 'Design Vendor or BOM Item No Not Match  in IMVENINF!'
		set @rowcnt = 0
	end


end 



if @errcde=0 and @rowcnt = 1
begin

	if exists(select * from IMVENPCK where ivp_itmno = @itmno and ivp_venno = @venno_old)
	begin
		set @str = 'Cannot Update Design Vendor in IMVENPCK!'

		update IMVENPCK 
		set 	ivp_venno = @venno,
			ivp_updusr = @usrid,
			ivp_upddat = getdate()

		where ivp_itmno = @itmno and ivp_venno = @venno_old

		select @errcde = @@error, @rowcnt = @@RowCount
		end
	else
	begin
		set @str = 'Design Vendor or BOM Item No Not Match  in IMVENPCK!'
		set @rowcnt = 0
	end

	
end 



if @errcde=0 and @rowcnt = 1
begin

	if exists(select * from IMBASINF where ibi_itmno = @itmno and ibi_venno = @venno_old)
	begin
		set @str = 'Cannot Update Design Vendor in IMBASINF!'

		update IMBASINF 
		set 	ibi_venno = @venno,
			ibi_updusr = @usrid,
			ibi_upddat = getdate()

		where ibi_itmno = @itmno and ibi_venno = @venno_old

		select @errcde = @@error, @rowcnt = @@RowCount
	end
	else
	begin
		set @str = 'Design Vendor or BOM Item No Not Match  in IMBASINF!'
		set @rowcnt = 0
	end
end 



if @errcde=0 
begin
	if @rowcnt = 1
	begin
		commit transaction
		return @errcde
		
	end
	else
	begin
		rollback transaction
		print 'Update Design Vendor Failure! ' + @str
		return (99)
		
	end
end
else
begin
	rollback transaction
	return @errcde
end
end







GO
GRANT EXECUTE ON [dbo].[sp_insert_IMBOMHIS] TO [ERPUSER] AS [dbo]
GO
