/****** Object:  StoredProcedure [dbo].[sp_select_POSHPDAT_SC]    Script Date: 09/29/2017 15:29:09 ******/
DROP PROCEDURE [dbo].[sp_select_POSHPDAT_SC]
GO
/****** Object:  StoredProcedure [dbo].[sp_select_POSHPDAT_SC]    Script Date: 09/29/2017 15:29:10 ******/
SET ANSI_NULLS OFF
GO
SET QUOTED_IDENTIFIER OFF
GO




CREATE procedure [dbo].[sp_select_POSHPDAT_SC]

@cocde nvarchar(6),
@cus1no nvarchar(10),
@cus2no nvarchar(10),
@venno nvarchar(6),
@shpstr nvarchar(10),
@shpend nvarchar(10),
@shpcan nvarchar(10)

AS
begin

declare @csf_shpstrbuf int, @csf_shpendbuf int, @csf_cancelbuf int, @ventyp nvarchar(10)
set @csf_shpstrbuf = 0
set @csf_shpendbuf = 0
set @csf_cancelbuf = 0
set @ventyp = ''

select @ventyp = case vbi_ventyp when 'E' then 'EXT' else 'INT' end from VNBASINF where vbi_venno = @venno

if (select count(*) from CUSHPFML where csf_cus1no = @cus1no and csf_cus2no = @cus2no and csf_venno = @venno) = 1
begin
	select @csf_shpstrbuf = csf_shpstrbuf, @csf_shpendbuf = csf_shpendbuf, @csf_cancelbuf = csf_cancelbuf
	from CUSHPFML where csf_cus1no = @cus1no and csf_cus2no = @cus2no and csf_venno = @venno
end
else if (select count(*) from CUSHPFML where csf_cus1no = @cus1no and csf_cus2no = @cus2no and csf_venno = @ventyp) = 1
begin
	select @csf_shpstrbuf = csf_shpstrbuf, @csf_shpendbuf = csf_shpendbuf, @csf_cancelbuf = csf_cancelbuf
	from CUSHPFML where csf_cus1no = @cus1no and csf_cus2no = @cus2no and csf_venno = @ventyp
end
else if (select count(*) from CUSHPFML where csf_cus1no = @cus1no and csf_cus2no = '' and csf_venno = @venno) = 1
begin
	select @csf_shpstrbuf = csf_shpstrbuf, @csf_shpendbuf = csf_shpendbuf, @csf_cancelbuf = csf_cancelbuf
	from CUSHPFML where csf_cus1no = @cus1no and csf_cus2no = '' and csf_venno = @venno
end
else
begin
	select @csf_shpstrbuf = csf_shpstrbuf, @csf_shpendbuf = csf_shpendbuf, @csf_cancelbuf = csf_cancelbuf
	from CUSHPFML where csf_cus1no = @cus1no and csf_cus2no = '' and csf_venno = @ventyp
end




declare
@startdate as datetime,
@enddate as datetime,
@canceldate as datetime

set @startdate = @shpstr
set @enddate = @shpend
set @canceldate = case ltrim(rtrim(@shpcan)) when '/  /' then '01/01/1900' else @shpcan end

--set @startdate = dateadd(day,(select -vbi_bufday from VNBASINF where vbi_venno = @venno), @startdate)
--set @enddate = dateadd(day,(select -vbi_bufday from VNBASINF where vbi_venno = @venno), @enddate)
--set @canceldate = dateadd(day,(select -vbi_bufday from VNBASINF where vbi_venno = @venno), @canceldate)

set @startdate = dateadd(day,-@csf_shpstrbuf, @startdate)
set @enddate = dateadd(day,-@csf_shpendbuf, @enddate)
set @canceldate = dateadd(day,-@csf_cancelbuf, @canceldate)

select	case @shpstr when '' then '' else @startdate end as 'sod_posstr',
	case @shpend when '' then '' else @enddate end as 'sod_posend',
	case @shpcan when '' then '' else @canceldate end as 'sod_poscan'



end





GO
GRANT EXECUTE ON [dbo].[sp_select_POSHPDAT_SC] TO [ERPUSER] AS [dbo]
GO
