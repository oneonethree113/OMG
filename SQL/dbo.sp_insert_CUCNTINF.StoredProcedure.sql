/****** Object:  StoredProcedure [dbo].[sp_insert_CUCNTINF]    Script Date: 09/29/2017 15:29:09 ******/
DROP PROCEDURE [dbo].[sp_insert_CUCNTINF]
GO
/****** Object:  StoredProcedure [dbo].[sp_insert_CUCNTINF]    Script Date: 09/29/2017 15:29:09 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO








/************************************************************************
Author:		Kath Ng     
Date:		25th September, 2001
Description:	Insert data into CUCNTINF
************************************************************************/

CREATE PROCEDURE [dbo].[sp_insert_CUCNTINF] 
--------------------------------------------------------------------------------------------------------------------------------------

@cci_cocde	nvarchar(6),
@cci_cusno	nvarchar(6),
@cci_cnttyp	nvarchar(6),
@cci_cntadr	nvarchar(200),
@cci_cntstt	nvarchar(20),
@cci_cntcty	nvarchar(6),
@cci_cntpst	nvarchar(20),
@cci_cntctp	nvarchar(50),
@cci_cnttil	nvarchar(30),
@cci_cntphn	nvarchar(30),
@cci_cntfax	nvarchar(30),
@cci_cnteml	nvarchar(200),
@cci_cntrmk	nvarchar(200),
@cci_cntdef	nvarchar(1),
@cci_updusr	nvarchar(30)
--,@cci_sapreconacc	nvarchar(10)
--------------------------------------------------------------------------------------------------------------------------------------
AS
declare @intCurrentNo int,
	@intsapshcusno int

declare @cci_cntseq as int
set  @cci_cntseq = (select max(cci_cntseq) + 1 from CUCNTINF  where --cci_cocde=@cci_cocde and 
						cci_cusno=@cci_cusno and cci_cnttyp = @cci_cnttyp)

IF @cci_cntseq is null
BEGIN
set @cci_cntseq = 1
END

--Added by Mark Lau 20061228, SAP Implementation

select  @intCurrentNo = isnull(max(cci_sapshcusno),0) from cucntinf where cci_cusno = @cci_cusno and cci_cnttyp in ('M','S','B') and cci_sapshcusno <> ''

if  (@intCurrentNo = 0 )
begin
set @intsapshcusno = cast(@cci_cusno + '000' as int)
end
else
begin
set @intsapshcusno = @intCurrentNo
end
set @intsapshcusno = @intsapshcusno + 1

if @cci_cnttyp = 'S' or @cci_cnttyp = 'M' or @cci_cnttyp = 'B'
begin
INSERT INTO  CUCNTINF
(
cci_cocde,	cci_cusno,	cci_cnttyp,
cci_cntseq,	cci_cntadr,	cci_cntstt,
cci_cntcty,	cci_cntpst,	cci_cntctp,	
cci_cnttil,		cci_cntphn,	cci_cntfax,
cci_cnteml,	cci_cntrmk,	cci_cntdef,
cci_creusr,	cci_updusr,	cci_credat,
cci_upddat,	cci_sapshcusno, cci_sapreconacc
)
--------------------------------------------------------------------------------------------------------------------------------------
values
(
@cci_cocde,	@cci_cusno,	@cci_cnttyp,
@cci_cntseq,	@cci_cntadr,	@cci_cntstt,
@cci_cntcty,	@cci_cntpst,	@cci_cntctp,
@cci_cnttil,	@cci_cntphn,	@cci_cntfax,
@cci_cnteml,	@cci_cntrmk,	@cci_cntdef,
@cci_updusr,	@cci_updusr,	getdate(),
getdate(),	
--Added by Mark Lau 20061228, SAP Implementation
@intsapshcusno,
'1131010000'
)
end

else

begin
INSERT INTO  CUCNTINF
(
cci_cocde,	cci_cusno,	cci_cnttyp,
cci_cntseq,	cci_cntadr,	cci_cntstt,
cci_cntcty,	cci_cntpst,	cci_cntctp,	
cci_cnttil,		cci_cntphn,	cci_cntfax,
cci_cnteml,	cci_cntrmk,	cci_cntdef,
cci_creusr,	cci_updusr,	cci_credat,
cci_upddat
)
--------------------------------------------------------------------------------------------------------------------------------------
values
(
@cci_cocde,	@cci_cusno,	@cci_cnttyp,
@cci_cntseq,	@cci_cntadr,	@cci_cntstt,
@cci_cntcty,	@cci_cntpst,	@cci_cntctp,
@cci_cnttil,	@cci_cntphn,	@cci_cntfax,
@cci_cnteml,	@cci_cntrmk,	@cci_cntdef,
@cci_updusr,	@cci_updusr,	getdate(),
getdate()

)

end

GO
GRANT EXECUTE ON [dbo].[sp_insert_CUCNTINF] TO [ERPUSER] AS [dbo]
GO
